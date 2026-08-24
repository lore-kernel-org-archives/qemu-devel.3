Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B61C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyWSD-0001dh-Hd; Mon, 24 Aug 2026 11:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWSC-0001dP-FT; Mon, 24 Aug 2026 11:19:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wyWSA-0004tO-OQ; Mon, 24 Aug 2026 11:19:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OD1Wxo1957962; Mon, 24 Aug 2026 15:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=BfrQApLYNG3Jz8YPxqsUh+0zk8nfcF9mLCCJ0hstID8=; b=IS+m0GZxlku7
 XbFIAVxTcFkNk1uds4WueX7UIn5HVNYPBaNUhHDAshZM8E0NN7PDsWRFfSxCc8U3
 IOfPdJK/CPeLbGRZMZmyan+wHc67bgk38HcCdykbmd/o5RiHqRsU30v1giq4418n
 Qsl+wOyWH3C8DbZMFRvKm8mFxKVdyDm3xSyNDBTiZgX6bjyI72V5TiSvh/23KK8E
 ajzgH8tBwp9rs0BXuftff50WlAFs3kf46PmPdgOwxQkVxB8ezwjwbkgNSIxQuTuk
 q6OR1L8+vXm1HlMWIIVoL0xT3NkCssGkf+ESw+sA5SUZxa/BmKoyqRAbRgwHUgDd
 /jOGWRMa8A==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4j874-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:19:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OFBOiW005056;
 Mon, 24 Aug 2026 15:19:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxxgv5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Aug 2026 15:19:10 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67OFJ92G34799964
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Aug 2026 15:19:09 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DB2F58056;
 Mon, 24 Aug 2026 15:19:09 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E049558055;
 Mon, 24 Aug 2026 15:19:07 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Aug 2026 15:19:07 +0000 (GMT)
Message-ID: <0af9ff380d65d9d7703e5d0d6f311e5d6304a9fa.camel@linux.ibm.com>
Subject: Re: [PATCH 22/29] target/ppc: make do_ea_calc_ra available for 32
 bit builds
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com,
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com,
 aboorvad@linux.ibm.com, amachhiw@linux.ibm.com, sv@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Date: Mon, 24 Aug 2026 10:19:07 -0500
In-Reply-To: <20260820140114.327023-23-rathc@linux.ibm.com>
References: <20260820140114.327023-1-rathc@linux.ibm.com>
 <20260820140114.327023-23-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ve7JxvukM1FZghikdO6vVigsat_O9tiL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX9h5NsNeoScqT
 4M20+2yIW6dD1MO4xq+7uYtDhvVEYhhIF/rK2iZWiW0T+rxqq6/5nw3BgrhZbXOUP8ejAk0MvZk
 fDdwb0tfuinx9FoHl8nnQYmx83w4UkA=
X-Proofpoint-GUID: xG9d07Uo6J6cdj_211fICLSrsnbrlPwl
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8c60f0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=EwRygrq437bwd6lpZL0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX25YlemFnDRgG
 u29SebSac+rVprVyXX0DXN4YKQ5g5mVweHq3EQn2byh2HWc9L1xFodqPu/K6jQclTuBQU7Gdzc8
 Cftgpt+zZmzK6WwA3XRYJ0xLcHIWuAGRvIEXYw4HDfSJw+fNuP4whjrvR2gI9DHUVBROaFeHVpj
 r8GyfT3PBe4fEBHgL9ed7Zirg0sTFi935lgJs4XzSxhvzC41EShjUKtMzNhquvtTGMXFvUtaq6o
 t+OUoSXK7j0iEdU5lFjHyaSA/T/D94nCH+v1FOs3V11AVthpIXQhW1/6n3cuPn2mypeaOQog26W
 LTZEIxrTZ9s8dLcs/XbyOWdV4Pphi37jnstWY7mtc1mQBHQNYFY/DtJOAg2vZb4zWMK2HxgBG4/
 D08tT+fQVyEc8LU+da6RSTnnVMjjMKDDzwNIO/70Us3a4i/2vih87jOG4liykt/EG0j+1dDlhhS
 nAZ7JeN4YAshgmX4xZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-08-20 at 19:30 +0530, Chinmay Rath wrote:
> There is no reason to keep do_ea_calc_ra exclusive to TARGET_PPC64.
> Make it available for PPC32 builds.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/translate.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 5b08d9b282..e40841b68e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -2397,7 +2397,6 @@ static TCGv do_ea_calc(DisasContext *ctx, int ra, TCGv displ)
>      return ea;
>  }
>  
> -#if defined(TARGET_PPC64)
>  /* EA <- (ra == 0) ? 0 : GPR[ra] */
>  static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
>  {
> @@ -2411,7 +2410,6 @@ static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
>      }
>      return EA;
>  }
> -#endif
>  
>  /***                             Integer load                              ***/
>  #define DEF_MEMOP(op) ((op) | ctx->default_tcg_memop_mask)


