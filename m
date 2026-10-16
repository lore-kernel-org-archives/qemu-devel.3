Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAF9CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHjXj-0004N6-5v; Fri, 16 Oct 2026 11:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHjXe-0004MQ-RF
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:08:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHjXc-0003Cj-3u
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:08:18 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE6Cok3006260
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:07:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yg8vS9aKor87I6J1IvQucbe0IlhLN62+mgSn3zZGqTE=; b=bY0vrI1Q7bogqKPO
 s8jS5bcCS54BL1amAUgYYMQ876Eat7mcT5CF+j4Sx4jjnSCgqdqzM0RXtldwfEHW
 OXzq7lEnp4FDjHSm7Wl4bpRMwy2KFFzvvjyAdagHJPQLjaKBxQEPJlJrXyDK2Mh7
 OuuT2/1YT6yb/m44sfIOgUi43YP4ZYJ4HoALyyAMn7Yu4dJCYq5QW3P9bHJ4ZYZE
 MxdB6FG/qiokbI0gjI26l+p6Ut+UD3aOwpkTbF8GJYz0Pha0/841drrZIBuCzOoM
 5pXhN75Fd2ksCYxNAmqAvsNrlI8hOdrG8eY5j3QS6eoYqpZ4QMpH68cOBbRDe7Lk
 3YGQQg==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa49ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:07:43 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4f9b643ae53so81343b6e.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792163263; cv=none;
 d=google.com; s=arc-20260327;
 b=X+VvAp7MBxZtxvIq95wJ8kKSLb4nkKTWRwkaNdZNmVam3bcBYRtSG5yafzKP4UT8OZ
 hr3u4fYvSifKMv3vp5rn0oXD+8h4hBbhgCTU5yzhfKHgDAQTJHeNw1qcw99qFCdw86Mq
 DUTR9vyTyPKbAzSasW2qRsXuFY/h0na0kvGcLr6R2YAARXAUR8gl0seTvjY2JTfJUdbH
 iOTLm55miJPETkLaxEIPK5SCikBdCswIQLsvSj56wgOPQu6PfU3g8m7CyVXuMJ9I5tVq
 HU0snTXbepc0y2X1chF8OyJwcYWc9hNevkerovZlztw0zi6Aj/fKdq+hXUmaBW1HVVfd
 FGaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yg8vS9aKor87I6J1IvQucbe0IlhLN62+mgSn3zZGqTE=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=jJroxLULNn0rJzT1klcCPaF12NrXt7xWlx0zCHpAyp8AaUSHcJyOAqUrEPsSXxVElt
 cpRFPhO/28DdS+5hTrg20xBz1PDe585KP44qTloN9Cehigw6ym0gttjeM6eDpeAplfm3
 3wHjTus0xGokvI55THOQfpHKB9gAjQrlF6dsHHXaUw/ojhzzGVws9GNmPBQOgZ5dhzpL
 D/muT4hvZzr2EfiKPUAhrtSUD8HJ40l38VjFgVafhhY1XpKNZjzj+8WAX1G4Oe0rC8Wt
 14NN48nKazC9JohQa+C3Bvrj2tVcgsaFEZgxs4ILZcLnngxpO/QcTieZuoF0vHTYIpis
 VUDQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792163263; x=1792768063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yg8vS9aKor87I6J1IvQucbe0IlhLN62+mgSn3zZGqTE=;
 b=MacP4ildp72B+n0Bvsr224wOnUhGYPKzAWGX0jzqsQOrIs8aceLNXcdh2OQeRhOQrF
 w8j1wht+Q/TNnQq883qYDVfZvUStx5DcowoZiUbZr2oIH+HI/QMDoDLSctwQpMbepri2
 rLJF96EU+NcjFvKilv8vWA+jius4yEp3rsaZJ2t+YpFc8Of6NtLeZ/CZJgVzfv3UOlN3
 2x9MzDHN4+LyyDjhHvWtSornDJMT3/p/LUIkDD+530KnizZsZfLZPl5F1N39rrync1g5
 hT07pXEM8dgyVku75Ff8zc314Ftyg6gl5+7R4P5DtPz/+hwUjExHvFux8YJ1XApzLdOA
 QIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163263; x=1792768063;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yg8vS9aKor87I6J1IvQucbe0IlhLN62+mgSn3zZGqTE=;
 b=EtF66ue/6iVLue44IuBfUad4ziBgGwusGCmAOvIAYnwR/YzSby0hgE8ly/qqosmAZR
 k1sRtj+39opy5vowutO/Cb1pbRE/dzENpTyzYrzD48q8V2mLMShbuKR93qf6m7qKErxf
 pR+g+eODIMMn9oW4EYGPdijmQv1K2UNH9H6tNj+yOjRAiJAwkP1psP99Y1r8YDutxrlz
 Uh8ZP4WgyQlg0cT6w0N+mm/F2lCnlzhVMcrZ0AUlnj2X8IsJrEkZTJevCFa2v/VeHbo7
 rNQT8ILOfV31geAPLbm/I1U9GM5TIUtwwYaWfRb5K8FHsVC3BQrJnui2vtG/jfVx53fS
 2hDQ==
X-Gm-Message-State: AFq9FYK3xef5EUUxTNvfoDAQfMyQBQJbUPRAHAavxjF8BuhgKHPwUJ0+
 G2fDGnvjIanyzXgC4wiMrOZwnxsJlp4Pi0hSZu/jjiAkhgU/6lb3+RFfAQSHizizv2fvbcQGklr
 G+KG8srZO3Sx250Yj6zs5l5KAc3PPN5C+6VSaceKDCDNHEVNT25sn6/P1Zm9D9sBd/UuHI3Pb3Q
 WJjFfQ5Em18G1u8710DM5nXHMm7MRJsit0
X-Gm-Gg: AYBFou2m4JhnapLvSDw+Suo3ghrVyZ8zyjgpD1KTZL5os5ncRJgBgImI3NanHF/TZcC
 WoAS4v9P2hZE1yaK9jRZcODeeu5rtHmfvp10C6eIylT+WweYfzjn1M46clsQU3BRycmQHIKQD3a
 mTH1bdjGSzfnwFfqZdfCElpwG7yqO3Q3IBPxsx14w38P4OIqk3QVvv0Xemnzy3WOCf9w3/UDsas
 jld9JJFKvyv2IedHe4=
X-Received: by 2002:a05:6808:10d0:b0:4e0:1d24:cec0 with SMTP id
 5614622812f47-50c435bc6ebmr22620778b6e.8.1792163262698; 
 Fri, 16 Oct 2026 08:07:42 -0700 (PDT)
X-Received: by 2002:a05:6808:10d0:b0:4e0:1d24:cec0 with SMTP id
 5614622812f47-50c435bc6ebmr22620717b6e.8.1792163261737; Fri, 16 Oct 2026
 08:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-2-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:07:30 -0500
X-Gm-Features: AclHuK-MAL04JrNVI-N-FvKJ0DnVqO-qLYx32sLiSsgPj3Z_I_XfDe04n7xm9DM
Message-ID: <CAJ+KCYPe=FgSOU3EQYn5vZtogOzSxGxRsnYfW+Zi7BsfEZb8Bw@mail.gmail.com>
Subject: Re: [PATCH 01/12] target/hexagon: sort tag_rev_info entries by version
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfXwMG6QSLW84gU
 6iyaZB1ek1pEHarZ5uGzoU2KT9a1q7eNgZ5ueesTykSYJ6kZj4WPcCgo49R6KamWNRGwm2P49jN
 LHOuynVxCA/O2DvUFe0FqK8lnIGvvxg=
X-Proofpoint-ORIG-GUID: gJPs1RXtf_FWn8CNGIuJ5mbLlsf8gIWH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfX56CJTGWw5lxG
 fYMwdJO8mlV9Sb2GjbHAygQFQEsLxR6ZFVxCkansa7DMPi1lAx6XpObM/dHrk2aDNfl/Tp37bn/
 glwI3CWhNehxueAKQ6eq0+e0T+YMaELl5iUOrHDrWcTCy3Vi+V3KJ2/EriUicbljBCIYmJj2zc1
 0QP8juDqGDDMySI9SjgVeUAP1AUCaxzsId3l2NM6rC6iUSivG2K3G+IVUUY+4TDLwBkMPI9Hgg/
 EH2XfHwjO8in2x/swBwjUxUXh3GBDq0YY2NEu+eOp5YpUtwyu77b+EQPR63odUr4JtPe1r0+Pw7
 okj5qUwB9o06ohGUmW981dQ/OfwXX2RRAzjJtUw5cPW3hwUI7o+awBo6tldZ8y6CO14xoo1MW0R
 T0F8E23tZ4qYfa7XUcsbLLoAJjyutSKMhWQMNe8amgYPL+RxA0S+SM6xh/sd/355SdbLXKapMvc
 i/R8JemvzDLlZpdTHyA==
X-Proofpoint-GUID: gJPs1RXtf_FWn8CNGIuJ5mbLlsf8gIWH
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad23dbf cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=oiUj86p4EGMqR00RCskA:9
 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160060
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 14, 2026 at 2:52=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm=
.com> wrote:
>
> The V79 QFloat entries were placed after the V81 entries.  Move them
> before the V81 block, and group V6_vconv_bf_qf32 with the other V81
> entries.  No functional change.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/tag_rev_info.c.inc | 32 +++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

