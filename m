Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5366C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wja8g-0000Jp-LN; Tue, 14 Jul 2026 06:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wja8a-0000JT-KN
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:13:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wja8Y-0006l9-TV
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:13:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SirG3862185
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=wexrdtAVoYZ
 x8WkNhJYCUgPfupYdhnrhCseKGNm5RGQ=; b=H1QZD2HemO9DHux8vyG7drrQKLE
 aljMq+pqOZrrYFLmygiStdJU8uBdH4AOVqpnrao6J6/q2rO/P3fo4sYgsQ7DZx8l
 Bg5J+VxpSW/RmZIKXkcW98HwVBctMVIYQy+A6g0Xknv+F8LHLFg3KTHCu7Ny8l6k
 TdMo7tTfz81nQ/0CyNYecfGUDzuGkz9zIluR9p5kMcPb4gTgu0i6qNHWhVqHIV6w
 ndhsZzK1psDIUJwrZXouiCaC94RkQ2f6SRVPMM1xJWpWjFa2GTntzq8dlgHlCVnv
 +3uFR4pQVABTxhuO92WY6pDBJbpLUPHpccAHrOLS6xi8x+CxhpYy56gskig==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44j38t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:13:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso72685755ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784023992; x=1784628792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wexrdtAVoYZx8WkNhJYCUgPfupYdhnrhCseKGNm5RGQ=;
 b=aa+nKRz2G05Ncfdm5eRbnIZu38MMqWHRje284ljHWCqq4MiB3ug0aGptf3jrYWbhFf
 L9nQD+k2crtEJ2LNjBc/KHa4UCmJkcZ79M7dl+EtyAO1pr1RmrHKi5rCgkiYAflCcIhn
 vKL70vCMVSJakv9AAkjX4LdIBiAOhkDJSKmjPrD6U9Nkq6tdMNahLdF6vy4KY1aHMTxB
 f13X3KQxJLazOpVWYwsB8bz9XDuTBV7RJRsCLql+YRjXk1z1N3zL6VMKojOcbLbJG440
 hIi/H4EuYqYzEGNGQPQfjvafhL4IwoVSDdKXvB+LmErLfmyDeDzQBfrS5IvtGEuze53/
 4xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023992; x=1784628792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wexrdtAVoYZx8WkNhJYCUgPfupYdhnrhCseKGNm5RGQ=;
 b=lBK0OTKP5Hj+hcS0CQrynno1/Ps86Dn8VsPQA1qdxeTXtSiecyoj1xmLWUQnxJJh5u
 R+tehs1BCeUI1bVDf3C5QNCv74nxKA7SPK6c+1SEQ40DpDU0kBV7zpOFCtXTmmxRizvc
 w54PNdmGoD8LizYxpt8FG8lr7FojVH2vub8lTMlGz782+b5KO9NMuLq/8gKaEDemS7qO
 qmyccdvYqiKoZULYS+gOyeQIk8Y2JoUgx451fqZjZRlmElS0Xm3/kDkSnhVZSXjyMKYl
 B+pYb34C+JuF5TJbOQqL/LD1o9sHykmCccmJlrUVdg2R7n5jtMAMOUTsctUv75n0CwV2
 OJog==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwPRBN3uuhvNZqzeYioJhCdlMbQaQR2uH6V7jBtGo6IdobM8f/5xsIiMkikPQhoLDdDbne7VaWIqcR@nongnu.org
X-Gm-Message-State: AOJu0YyM5RXvzeAql91qJobNo4W2T3+RPfpgX80eM8jMYZ1lHacqEFUY
 7To55sIMZBFylNzvTNSrCb1+OX/d+96g+nAPqiOjEhx4nwmvdenKVGRYRG6rjZLJDa5Kr7K1JJq
 LPsOmLiWjEJ1mtKrIMvoEstci22yRKj0rJorWuWMMWpMhnmNXVVcRSFUujA==
X-Gm-Gg: AfdE7clwt5R/2qT+HKey2TMnTzwIcE9JwYhINx6WznUg1VgJdKkXig4mjWLmOUF2/9G
 8vcBwVn4LH1bRbeSAmBdZ/C0qfYuhSkLP7Od8hZAjehmhJErer/XtuqjpHuhgILer18odjGXKGD
 dZUTCTarqUzxuV+psBoLMvhBFlifaDNaHul/tG9RGXa4Uqnv4xxGRZ+g8QPw6TAhku/6fHmt3p1
 MTlxsbfp5pRYz8QQJ41sL58LsQKWb0mm/i6LCJBk/Q7Vf0l1TtpsepsyIlRHu2IN19kHRqu7GTX
 WU9Lvo6y7HcEdHw0Op5BUf8JKZrx67afs6wxOrAFTAT9+PMQt/mJRCP5e8x6ulE2aWkoAIZ6Wc3
 eGMfTqYpB2xQzxE3oJcDj3+2B7+q7oiTblHYiulbSVjr2jGFqDby9x4w283254923LKXKDujLgQ
 ==
X-Received: by 2002:a17:90b:55c5:b0:381:77cd:38d1 with SMTP id
 98e67ed59e1d1-38e1ae2679fmr1823437a91.10.1784023991989; 
 Tue, 14 Jul 2026 03:13:11 -0700 (PDT)
X-Received: by 2002:a17:90b:55c5:b0:381:77cd:38d1 with SMTP id
 98e67ed59e1d1-38e1ae2679fmr1823400a91.10.1784023991475; 
 Tue, 14 Jul 2026 03:13:11 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b0240570sm46791699eec.28.2026.07.14.03.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:13:11 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: pierrick.bouvier@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 quic_mathbern@quicinc.com, pbonzini@redhat.com
Subject: Re: [PATCH 07/14] target/hexagon: add semihosting support
Date: Tue, 14 Jul 2026 03:13:09 -0700
Message-Id: <20260714101309.612797-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <4d2aef3f-31c4-4b3b-8810-fe6a491da70a@oss.qualcomm.com>
References: <4d2aef3f-31c4-4b3b-8810-fe6a491da70a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfX68xNBin0GJB1
 DqON//mr0Q1/zZ+ba3AaC1s8kPvpn3xLpUpASt16IkCuq92Z2IIOxUiU2w0Glxuu0EhPZJekgx5
 OYceLnHNO6mZrQMzkUrxRGeRn7YpLs4=
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a560bb9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=tzD0Yh30GMFDOikydqQA:9 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 0PfwRh-ic-zx6jocvQX9wP2RUKYLfixr
X-Proofpoint-ORIG-GUID: 0PfwRh-ic-zx6jocvQX9wP2RUKYLfixr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfXzEfyQWlDZrl7
 6pUUlWWNu0Ohlhkg2GA8hI2O7EdeYnDwOOZrKP2HaHN4Cjha+dgSGw5cOallxWSHgiKSJI9M6ER
 eGkLYba8rTz7awuehC6Z+bsnZgEEKPpRg792lkdF+IOO2zERUhoIK0Gi2vpf3b2SsRwUt281bYr
 +ZHG4tbj7GVvTTCfu3jiyOmPGbMznh0fFk6St5f+DF/uEslrVOX0LKW84JGvnfeGF6VYlQxv+gM
 hqLuJje2KqrYtx05bClcrzfNtE3OGX9epypjGW033I/WdSXbHBDGDzYwsbAq3arVeH9l4tSbKYY
 m1Dx97Fv979+Q1w/MfnugmlAtuWvJ3H8xlApDeJQ7Rav2H1mQcLSKLr/MmAlCQ10MkGQ2CFXaCt
 2b6xqGB5+IrpFhI1ocAuGEHLkxiJqCcKbCqqBu9iz1s5qnUwcEYLDUDk8yiN7YQwN401VvecI9a
 OldlPo1zj+CCeLSEKVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140106
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On Mon, 13 Jul 2026 15:11:18 -0700 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> > From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > 
> > Baremetal Hexagon programs use trap0 #0 to invoke
> > semihosting calls for I/O and process control.  Wire up the
> > arm-compatible semihosting framework for softmmu by enabling
> > CONFIG_ARM_COMPATIBLE_SEMIHOSTING and routing trap0 to the
> > semihosting handler.
> > 
> > Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >  configs/targets/hexagon-softmmu.mak |   2 +
> >  hw/hexagon/hexagon_dsp.c            |   2 +
> >  target/hexagon/common-semi-target.c |  51 +++++++++
> >  target/hexagon/hexswi.c             | 164 +++++++++++++++++++++++++++-
> >  hw/hexagon/Kconfig                  |   1 +
> >  qemu-options.hx                     |   8 +-
> >  target/hexagon/meson.build          |   3 +
> >  7 files changed, 224 insertions(+), 7 deletions(-)
> >  create mode 100644 target/hexagon/common-semi-target.c
> > 
> 
> ...
> 
> > +static void sim_handle_trap0(CPUHexagonState *env)
> > +{
> > +    target_ulong what_swi, swi_info;
> > +    G_GNUC_UNUSED uintptr_t retaddr = 0;
> 
> leftover?

Actually, this is used in the next commit. Let me add move it.

