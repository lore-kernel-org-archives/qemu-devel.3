Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EB4C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzH0B-0001o8-8O; Wed, 26 Aug 2026 13:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzH09-0001nv-RK; Wed, 26 Aug 2026 13:01:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzH08-0003fB-1C; Wed, 26 Aug 2026 13:01:25 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QE1fXK3084964; Wed, 26 Aug 2026 17:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=wM6YVU23RJDGbuE/xFgKA9N3HIra1Q
 EJUsO/R/YU+k4=; b=adSzuCg/kQi3wf+9qQHaO3BKdqEozKi0VGS+sXFjgEBOcD
 MDLkt+t1fS/PEVlrWWYx8QFEfpHNVp+M6woJ2xryVY4+Phv7PvdVck6wpg2MrXMg
 LdavpsasZpWj6WUsqaKHV9WprRmMLpT4vHrqhnzu1VlHhvLjHaosNei3GIEkcjCv
 PrJ13vYJrZgpoRm6k5Hx5ZpZVRcMnYUj/3QtIWTVrTAbOLhLdrbYhJSCHZupzK+U
 P2zUPqgL+PbNtcWgfH79DVwOR0Et91RVpgv14SV8htdOnqXlFl/IbDM7TMRGkMY4
 mKCkageqr096zxN5ZmQvbfkTTbKVym+N43mXBvYQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726eqxkg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:01:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QGv8dJ010891;
 Wed, 26 Aug 2026 17:01:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qb9v7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 17:01:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QH1DEk29754072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 17:01:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1BB320043;
 Wed, 26 Aug 2026 17:01:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6E142004B;
 Wed, 26 Aug 2026 17:01:09 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 17:01:09 +0000 (GMT)
Date: Wed, 26 Aug 2026 22:31:13 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 vishalc@linux.ibm.com, tshah@linux.ibm.com, shivangu@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 shivani@linux.ibm.com, mkchauras@gmail.com, uverma@linux.ibm.com,
 nikhilks@linux.ibm.com
Subject: Re: [PATCH v2 32/37] target/ppc: Use PPC2_ISA207 instead of
 PPC2_LSQ_ISA207
Message-ID: <20260826223022.b804a252-f4-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, vishalc@linux.ibm.com, 
 tshah@linux.ibm.com, shivangu@linux.ibm.com, ojaswin@linux.ibm.com, 
 aboorvad@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-33-rathc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826050923.74756-33-rathc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8f1be0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=-gZqQ3hT50n4G0il6jYA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX7V7aANNw22Yy
 cEfiYXqj8motipdtTiPGWPl7tB3Tna0Xi1g7o7eMnUd8dsRbf5OGOZvk5394zl7diIXnDxSEn74
 wUZiYKYQth20DoEpuPqq8dzU3reHm4o=
X-Proofpoint-GUID: xRgjXxhCSWZbimpUNXJoeEnhQNP7arXC
X-Proofpoint-ORIG-GUID: 3o_imYXpev8xx0Sdp3c1zc3mr4Rjfquu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX8teSoQVbKPRK
 NJSJxYdUGF/lzMX8ToBSDRYiTugEjrbFPFoDYCU3BbQy65ll7+Hik9ZDdGZR980dO87sK29Fo1M
 Mm/MqMpdhTB6AIW5bhVVByL+cCrfTYEsDCFf9jThl7e73893qNluT3w0kJvIMpQFjzl1EXLqxtw
 Sq8wcm5gPLdNWS2/thJZRcQgQnhoFAd3ke1lMkt1yTU59kV8AGrPare4XW3MK8cVNfqygfZO0Th
 C0lX3c9Qi1hBQGKDbSWAQXxfepSvzqUTZiBCBP69wlhomt6NGvQEbeY34MKQhy3BnOOsIwumc0S
 UlNpoNRCTvwS2VsUfSKaEirULOtcuUCV6fWszZwQhYHIM3uNbpjWl0n3x1+nR7dNX6uiXnbD/BI
 YwtkdTB1LbMLqC+zd592gQg51f+0ZtwEetjRbiX2tnQVTww2mY/tOEYXGCJ5B0ang9f1MDqzULp
 tOTwyLKmTE/kNPmNyVg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260138
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
> PPC2_LSQ_ISA207 is only ever set in the CPUPPCState's insns_flags2
> alongside PPC2_ISA207. Checks made by PPC2_LSQ_ISA207 could be
> replaced with PPC2_ISA207, hence rendering it useless and apt for
> removal. This patch does the same.
> 
> Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  linux-user/ppc/elfload.c                   | 2 +-
>  target/ppc/cpu.h                           | 3 ---
>  target/ppc/cpu_init.c                      | 3 +--
>  target/ppc/cpu_init.h                      | 2 +-
>  target/ppc/translate/fixedpoint-impl.c.inc | 4 ++--
>  5 files changed, 5 insertions(+), 9 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
> index 5c6065e08a..76ab9f43de 100644
> --- a/linux-user/ppc/elfload.c
> +++ b/linux-user/ppc/elfload.c
> @@ -116,7 +116,7 @@ abi_ulong get_elf_hwcap2(CPUState *cs)
>      do { if (cpu->env.insns_flags2 & flag) { features |= feature; } } while (0)
>  
>      GET_FEATURE(PPC_ISEL, QEMU_PPC_FEATURE2_HAS_ISEL);
> -    GET_FEATURE2((PPC2_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> +    GET_FEATURE2((PPC2_ISA207 | PPC2_ALTIVEC_207 |
>                    PPC2_ISA207S), (QEMU_PPC_FEATURE2_ARCH_2_07 |
>                    QEMU_PPC_FEATURE2_VEC_CRYPTO | QEMU_PPC_FEATURE2_HAS_TAR));
>      GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00 |
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index df1e943d8d..b3cd8d85df 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2577,8 +2577,6 @@ enum {
>      PPC2_FP_CVT_ISA206 = 0x0000000000000400ULL,
>      /* ISA 2.06B floating point test instructions                            */
>      PPC2_FP_TST_ISA206 = 0x0000000000000800ULL,
> -    /* ISA 2.07 load/store quadword                                          */
> -    PPC2_LSQ_ISA207    = 0x0000000000002000ULL,
>      /* ISA 2.07 Altivec                                                      */
>      PPC2_ALTIVEC_207   = 0x0000000000004000ULL,
>      /* PowerISA 2.07 Book3s specification                                    */
> @@ -2608,7 +2606,6 @@ enum {
>                          PPC2_ISA205 | PPC2_ISA207 | PPC2_PERM_ISA206 | \
>                          PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 | \
>                          PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 | \
> -                        PPC2_LSQ_ISA207 | \
>                          PPC2_ALTIVEC_207 | PPC2_ISA207S | PPC2_DFP | \
>                          PPC2_FP_CVT_S64 | PPC2_TM | PPC2_PM_ISA206 | \
>                          PPC2_ISA300 | PPC2_ISA310 | PPC2_MEM_LWSYNC | \
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index c250f805a7..4cc8b93dca 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6349,8 +6349,7 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, const void *data)
>      pcc->insns_flags2 = PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |
>                          PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 |
>                          PPC2_ATOMIC_ISA206 | PPC2_FP_CVT_ISA206 |
> -                        PPC2_FP_TST_ISA206 |
> -                        PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
> +                        PPC2_FP_TST_ISA206 | PPC2_ALTIVEC_207 |
>                          PPC2_ISA205 | PPC2_ISA207S | PPC2_FP_CVT_S64 |
>                          PPC2_TM | PPC2_PM_ISA206 | PPC2_MEM_LWSYNC |
>                          PPC2_BCDA_ISA206;
> diff --git a/target/ppc/cpu_init.h b/target/ppc/cpu_init.h
> index 7dd587908e..6961007926 100644
> --- a/target/ppc/cpu_init.h
> +++ b/target/ppc/cpu_init.h
> @@ -18,7 +18,7 @@
>      (PPC2_VSX | PPC2_ISA207 | PPC2_DFP | PPC2_DBRX |                 \
>       PPC2_PERM_ISA206 | PPC2_DIVE_ISA206 | PPC2_ATOMIC_ISA206 |      \
>       PPC2_FP_CVT_ISA206 | PPC2_FP_TST_ISA206 |                       \
> -     PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 | PPC2_ISA205 |              \
> +     PPC2_ALTIVEC_207 | PPC2_ISA205 |                                \
>       PPC2_ISA207S | PPC2_FP_CVT_S64 | PPC2_ISA300 | PPC2_PRCNTL |    \
>       PPC2_MEM_LWSYNC | PPC2_BCDA_ISA206)
>  
> diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
> index cef67d6431..b9c20b66dc 100644
> --- a/target/ppc/translate/fixedpoint-impl.c.inc
> +++ b/target/ppc/translate/fixedpoint-impl.c.inc
> @@ -116,7 +116,7 @@ static bool do_ldst_quad(DisasContext *ctx, arg_D *a, bool store, bool prefixed)
>  
>      REQUIRE_INSNS_FLAGS(ctx, 64BX);
>  
> -    if (!prefixed && !(ctx->insns_flags2 & PPC2_LSQ_ISA207)) {
> +    if (!prefixed && !(ctx->insns_flags2 & PPC2_ISA207)) {
>          /* lq and stq were privileged prior to V. 2.07 */
>          REQUIRE_SV(ctx);
>  
> @@ -280,7 +280,7 @@ TRANS64(STDCX, do_store_cond, MO_UQ);
>  static bool trans_STQCX(DisasContext *ctx, arg_STQCX *a)
>  {
>      REQUIRE_64BIT(ctx);
> -    REQUIRE_INSNS_FLAGS2(ctx, LSQ_ISA207);
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA207);
>  #if defined(TARGET_PPC64)
>      TCGLabel *lfail = gen_new_label();
>      TCGv ea = do_ea_calc(ctx, a->ra, cpu_gpr[a->rb]);
> -- 
> 2.55.0
> 

