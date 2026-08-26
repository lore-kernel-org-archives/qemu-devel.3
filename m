Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A73EC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:49:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzEvT-0000r2-T3; Wed, 26 Aug 2026 10:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzEvS-0000qY-2e; Wed, 26 Aug 2026 10:48:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzEvP-00077s-Jt; Wed, 26 Aug 2026 10:48:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1XgM2333802; Wed, 26 Aug 2026 14:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=4sPr/xu+BA+BxOLwrAUhx43VVptGLb
 H3/S4h1+HPkQU=; b=hXzl3N5RgjtavpzvbDplGu2jHa1B5lr+yIEoKfkwSbeHaK
 zWtDI3PzObVqGegFuCnmJ42MzAF8VnSDMJ34qTcHFE+hjuTn61G6LWr0T9394CsD
 zVL8VrfynRja3Qaie59SFR/AtSiNxNE2OXScpEyJxKGCCdCa/zIpTlnzyRtxTBw/
 Jx5vzeCQ0U1rrCme03pzHNFK/vqvXOvHjAi+sOHyLZd8MAxLntdAiztOquz9SPqB
 +1an8ub0q2VG4P6FP+IGF8S/8V0Pc4fCxSwFqAADAbelNvJV/gonRzo9bY1YE8kJ
 TJaxct7Q39JkPUgdCTu2jkIOy3rqeghcmASlw4Bw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqy94w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:48:19 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QEfNHT030450;
 Wed, 26 Aug 2026 14:48:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qaq4f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 14:48:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QEmFLG49938748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 14:48:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDBF120043;
 Wed, 26 Aug 2026 14:48:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3C1A20040;
 Wed, 26 Aug 2026 14:48:11 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 14:48:11 +0000 (GMT)
Date: Wed, 26 Aug 2026 20:18:14 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 22/37] target/ppc: make do_ea_calc_ra available for 32
 bit builds
Message-ID: <20260826201706.44486ab3-d0-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-23-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-23-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: pofINVCajattAMe3P1NRB65gFtP7Iu85
X-Proofpoint-ORIG-GUID: _sfoVJ7cMPoAwEP4mu9OvFI2Fd6vfHSe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX271AiE9uWDl5
 naBD8GpPiET+8t6hWgTEqSMdtPLGmpV4l4shllx7UEpnLUCLdeAx0XoA4v/Qd+qLSF158hptqSK
 GCe6iVlS5PQg9uJB1uLqKfS/wt47MmcbK+MWlZ80aHXtlzDjz/RB9bstJbsoIR6JjQdWIzGcbVH
 SmNS+rCco4/rdbsOlALuv/5y75LTwCRoKW9J7jFkB0BS/OzyCFUIn2R7SqmLbmODyaNVI/9ecYu
 QGBCYlCGv6IBdV5Vn1I7zyylT8WwUW6vZfVlJMFTPnYGPwzdTjSwXHzTrVD+6X8KBB83tL4EU3U
 7uX/b1YvccKrTjim33iVdH3bEKU9ke57j45gj9jQH7BHpC5Wex3IdqH9Za6diyV978Y1TrO4xqD
 oNrAxntH9bus7MzhAUW+zeZZp8jHaTg8LSViiRs5f+CX++dyYvXKkWfa4DA/IO6TJ8eA6AFr7Bl
 w02tDI2HHGTMA360gww==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8efcb4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Ir-s_cnAjVjAHO5yQj4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEyMSBTYWx0ZWRfX5GycJTbayp4D
 cHpGAHZgPel8VghGkcyYQbAMobSoZkDksCuSj0kbFfowJqXanhggkdbwgbQFQPBpr4ENFSIlQ0v
 xulSRe4ZAdfGL8iyZwNmMIH23i0wGqw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260121
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/08/26 10:38 AM, Chinmay Rath wrote:
> There is no reason to keep do_ea_calc_ra exclusive to TARGET_PPC64.
> Make it available for PPC32 builds.
> 
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/translate.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

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
> -- 
> 2.55.0
> 

