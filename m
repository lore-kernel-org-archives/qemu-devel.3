Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C27CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHjZo-0005Va-TB; Fri, 16 Oct 2026 11:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHjZi-0005Uz-Cq
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:10:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1xHjZg-0003Xk-Rm
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:10:26 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE5nRf1450308
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lfX4QNk7K/53oVSszPh2KHWvECzX/05t8EsE5dhvPp0=; b=RQfFIGUxFzHiBgXr
 dgLLcgVdBVFu4Iy1TH4/yGfxaZd1mGWd5hmBIEpF3qdhFQKjzv5gYL6IBwNpVtvk
 qFigFtb0aJ6VPeZUlcXl/cb5yFbhUOzt9mXcEVGbFpie2+kVNa5yM098OYzDfO7K
 HB3yzumcT8/RBtEyagtZR2/MTFx4TOQLom5s2huT5gPU1R3vEr4cjo/z0h8TEuJ/
 ZL9SjdSVyVmqgoieNnmB4siBYhdnOHALLNRdEtURQ4/hJER6hnOLNhDL3wF1qAj6
 KqOn5XF5UcoMzdxdqdWRyJ+Ens1U+8dsZuBslrWDGPeEIVKo1EdQ/3rrRI+rs22Q
 sYrYqA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbhur13a0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 15:10:23 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-4ab260600easo1664892b6e.1
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:10:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792163423; cv=none;
 d=google.com; s=arc-20260327;
 b=GjRqU7/URpK2YDBNxF+YCMZexvZJNe9GZwXHyh/r4+Z90gYAS42o2cDGA9Es0Cn8iC
 k8UxvVhUJjc6Yy7/sK2uO7VjPqZ0d6MhHuOi2HC/ZPtuL6BuWBT5sftYjxZLl6dPldsv
 5oLaZOHWyRsTQvREiP7avOLJwmuzp0++0Ms6uXc8BmTUwdmF6L5pvD0ElvboO8BANV2h
 2jQJ0H78MczVWJXE2SsZTes7vKdKBC784digf/NHkk2iW0doq/QEEdlvtoCbFGzv4Ckr
 Bn91jgOqM1GA/dRbPA0tPDxiP7/pHkX/QogTZ18HpvM6isBVLWMKJkF5+Nxg/bXQAD6H
 MQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lfX4QNk7K/53oVSszPh2KHWvECzX/05t8EsE5dhvPp0=;
 fh=BDwCUQnyOohCW2T3saAEoDn+gM7VDetp6cmJKplLvtM=;
 b=GDmkuIfSEooafdFFPK8IjCZTT3NTw18596fNMoUaRnSwD8UDs50O9ej5Qu508niSRL
 w9hzRcVD9WTbhFV5uyk86RWaGsbwVHfX70rwLDcO9TveWwN2DgY1eCv2jC4dSBpUL9au
 l6uUXgT3wlc16TeJouxSLoGVro+hmwtpg0pB/8yS7XEg4I3pj5Eyh/NElJ7lvDsHf/EQ
 3swNb4YB7eTABONrXKKXapqQZmbp2sT3GkKN97C+Z7Ob1+8qfIbsWLoIJlaa/QBVkPwX
 SILFEpbDVRVt9oM3IC8IdLGKdRCq9qZJBsL8QZpEoLQpVDVkYIeyC95SXaNno/3mo6Km
 Wlvw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792163423; x=1792768223; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lfX4QNk7K/53oVSszPh2KHWvECzX/05t8EsE5dhvPp0=;
 b=AL0ujMUVV5ausN8Hc31aUvUV1HJeqNJgRvMkUPgD95S7yc8dHkJndPNOC3NeoEb5HL
 C8z8ANvliMcMN5go6bgKIbFFPWxbHkPV58e+jgeRNbEknvFDKDFkpKbuGa5YGUIfkZim
 tvkK5F5nJxmzO7N3O3e5vtoRE3eeFk5zV2m0hGtygKYmmoTbc+Vxs3Y2mpYCJ4vmLcqt
 DwvP7lTELMNvncklcko5oRbj62Eh3QsyvdzFjuyWsBqXndJF9bjSaY0qXhG4QMp7qGAd
 djKnUEvWUzGI7YOdxgxxegCNWBDUZS10Bs1ABW7A+HdTu1zwoDOAVBGNdRcT+E+tLdWQ
 0nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792163423; x=1792768223;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lfX4QNk7K/53oVSszPh2KHWvECzX/05t8EsE5dhvPp0=;
 b=i+TOUnqiAC184e2wbv19cDhaeFVJtEHgWyuxRUNYSNtUqCXiD6LkbCumBOAmIVBovu
 Bio+cJpZKB1WSBxjYpX+AQ7qRQV6K4H6nS4QHAeiDVaA9PUlDYLdTZUh+vquxcHbmROE
 8ISfrXi3sp/Xr0kuQsPTimJ9KNvXC6RUUM2tMLvaSAhcIdw22L+z2y7sO8Oh8uFQ0hSD
 PFzD5yCqpWoVS1o3s1FN35lZh0ngBbxTAA9Yyx9wnxWQEYalWiw4M7165ECWQmIEI+cE
 aWU1JlOWJH6IhEcZPGovnKgCIJROw+X135aJvFQvEIBzPGuwsQe1xZwMV1iegd5QXdLo
 YlhQ==
X-Gm-Message-State: AFq9FYIlqRmeooS675wEAgigb0z/GJK3SI9DMq3K4HXkdEZEd3bVTENS
 ZmvL+OuyNlgLKnbFFCSDjdSYLAVlxIfbSV3aGUFTfzgT1qEiZn+xe9mcOpSVT9nAb59/Cvcl94n
 cxav9LpSYWjFnplnGdAsDaTvz23lf1n2ybjOHETh4wL0lCPA+0PuvVgtif75jfTfMCtWMiF47Np
 ownHA2wwPtJmHrO6DHYkwW83s9FgB/8BIk
X-Gm-Gg: AYBFou2U63h+N+iZK5NvDv7Ccxhf6rw3FSstjbkmcSKs0HU30nPlUxlZ5GYhgoy0GHK
 QalWodTy4mtU6LGd+YRXRquCXRn98hwcSZbWd3fH30YQP+ohvWu+R+omROnqdxs9qbxRUt8hadA
 ZFIb/Cyo3DUucGOhzDO8psaVoED1VF5o5UpzG0/f3mNbTK+MciadDvm1s+ydbPJVcDbmt7uPuMj
 83Z+5ZqU9C6dKRFlWw=
X-Received: by 2002:a05:6808:1a2a:b0:4f0:2d60:f0f4 with SMTP id
 5614622812f47-536fafd4a90mr2223635b6e.17.1792163422744; 
 Fri, 16 Oct 2026 08:10:22 -0700 (PDT)
X-Received: by 2002:a05:6808:1a2a:b0:4f0:2d60:f0f4 with SMTP id
 5614622812f47-536fafd4a90mr2223502b6e.17.1792163419165; Fri, 16 Oct 2026
 08:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261014195223.3233623-1-brian.cain@oss.qualcomm.com>
 <20261014195223.3233623-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261014195223.3233623-4-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 10:10:08 -0500
X-Gm-Features: AclHuK_OYQpdisx_RyIF-6i_zlVXIeXo6OcrFVeUOqJJH3qBlWutJ01O_VJz1o4
Message-ID: <CAJ+KCYOGTgvKOCCTyPUMhh4WGhQ98B+ZNOe+-Y9YYSvZRSOH9Q@mail.gmail.com>
Subject: Re: [PATCH 03/12] hw/hexagon: add v85 machines
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfX8IsWkBfxp7+l
 jRG2cSGHC4kPB12TA6Z+Er6uwr1dE+kH1CIG89iPzQGZTqWDxRiN5urDA3rSOOusOjTd/2kRWT9
 MEqZ6kKw8AXak8TJJ/iMvb/ZyDwWzlaMRrieZh8pO2MSCgCiKlP59EcHeaVLTdo11EAUkxz/00Y
 uHnpvluUT7l/solGOdq0ytyDkyxtUSFvPCAxedrr9x5x/BMa9Y2Ke7YmUqmG+1riy0RX8FTx7yy
 nlXtqwUJb3GS1PmlgmpcnxBJ/SYjtm5qfYTaiSxFaT1MePTPQPLytm2XCEq9KpvmoJJZo2MMFUr
 aSVy793MkcoBA9Wr0t4MqedaerNyGA1R+M3AG1Vv+jE4b2lRdXJjMsC9inK/Qd2XcOs0OhL0fGH
 22SfGEO6TrKw44fyHOHYyJXMpojeTHcBWdFLa2fwT0vfgtiwk6V43Q7XMj0gUnDKOC5AIL6wJ4j
 8CbdAxHqDgAFqdHIEyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2MCBTYWx0ZWRfXxMOIW9cqoIo4
 KN8IL+7YFx0AT897HS9YmkOhyHqXVeIGVIlS+g70XCJYUrodFnGvpkqIjnIuRnML+hSLwcx4k+5
 2ALKjKYF9lgscpv7c79qoKp3B0ytnAw=
X-Authority-Analysis: v=2.4 cv=PqsG/AM3 c=1 sm=1 tr=0 ts=6ad23e5f cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=XI7MBPpaTVa-333muigA:9
 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: BpSjlGuixkx7ub5-b-EYwcwUPFNTanVn
X-Proofpoint-GUID: BpSjlGuixkx7ub5-b-EYwcwUPFNTanVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0
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
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h         |  6 ++--
>  hw/hexagon/machine_cfg_v85na_1.h.inc | 50 +++++++++++++++++++++++++++
>  hw/hexagon/machine_cfg_v85qa_1.h.inc | 51 ++++++++++++++++++++++++++++
>  hw/hexagon/hexagon_dsp.c             | 48 +++++++++++++++++++++++++-
>  4 files changed, 152 insertions(+), 3 deletions(-)
>  create mode 100644 hw/hexagon/machine_cfg_v85na_1.h.inc
>  create mode 100644 hw/hexagon/machine_cfg_v85qa_1.h.inc
>

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

