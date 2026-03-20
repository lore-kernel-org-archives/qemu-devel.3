Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB009108B8ED
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3XDe-0000sM-GU; Fri, 20 Mar 2026 06:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1w3XDT-0000rp-Iw; Fri, 20 Mar 2026 06:36:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1w3XDR-0004T2-JI; Fri, 20 Mar 2026 06:36:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K01Zbb802935; Fri, 20 Mar 2026 10:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dakKny
 V/K0+54l3X8ne6P2paUxGObvMmGxwnCdS06lk=; b=ZdgJGUZaE2sNw9dGMPJUal
 tmbhrAENGEai+oxQH9ZvLLjba3veR7Cv9aJqUHL2rmRy/mmfyJQzAE/qYUrthEAZ
 AsCeQf56jIFliBa+qc4k/QzILE2MzMKTcsiKtbQHDjSX1NXy4MtMEyy5Pyk7HKIx
 mvfkU+2X4zpK+SaUyKHqeMw4wNmQn40KyDfSosyaKJi9VIJ9mcfjGSQ1SqePHdnw
 hkpj2wFraxvz9rEkK1CBgT7z0J7cumaG1I8V0GYFH3RLNdlTNdt0fdUIrbRoBHLf
 oaWlgouLpE95f/vxusw15a9X8MSDq/S10YIv/jJtEZLlKqFgrg7PEQ3+ZDkEf4vw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaut8ud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 10:36:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62K8K6GR028459;
 Fri, 20 Mar 2026 10:36:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1pk5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 10:36:21 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62KAaKXU61931914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Mar 2026 10:36:20 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E6F758065;
 Fri, 20 Mar 2026 10:36:20 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C3665804B;
 Fri, 20 Mar 2026 10:36:16 +0000 (GMT)
Received: from [9.39.24.163] (unknown [9.39.24.163])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 20 Mar 2026 10:36:15 +0000 (GMT)
Message-ID: <5fe614f5-6ff4-4418-84ae-6d6b8952bb0a@linux.ibm.com>
Date: Fri, 20 Mar 2026 16:05:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/ppc: Explicitly declare BHRB related register
 as 64-bit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Glenn Miles <milesg@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260315170832.40331-1-philmd@linaro.org>
 <20260315170832.40331-4-philmd@linaro.org>
Content-Language: en-US
From: Chinmay Rath <rathc@linux.ibm.com>
In-Reply-To: <20260315170832.40331-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDA3OSBTYWx0ZWRfX0mtCPxsFVDMI
 9pBRrU7gfr7zB7zDlkX6hDdwDTEh8p5mZ31Qgurx8TO79xpRqMuo4t5fF/0qbT3TUBboR1efYOI
 DwZYcVahim70tzGpWQo6wdXK+TckFCg2yzxPgnR7GEOfLSaiMf+CyeKfJJUXNDtJy7ETh+/Iuxz
 FUyS+EvNNM0maAg4K/CyFI+ZHv9hz03T79mkzF+B2VEA+kojhfpFwKs3HTXXYnt9OxzzyfUVbgg
 bFaJZynKl5n5eBQjrAPBugfJWwOq/Ibqp9SlNYqJSXIoY6LGg71OHsuIPcGWGfTjm+JvrT7b+7V
 1wfUrEwtNJk7fnArFXZS2389OVwdXRvTYu/sZhmiMpn8NjgSkC7V1cpmAepx3vHyCBdSX8DXRoN
 Av4ZEY1wBJKa7yOFs0jnPzG6pzhFuzVBwe4uVwILwSbtAPGTo/0NXB+TzbzImiq90diAN6N93bR
 f9d+5Yz3wLVVWaYUlMA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bd2326 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=8fZdWQDGgGsc3t5ButEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Fr5VIBfRaxSDG0CCc--IEViBsJDJFaCF
X-Proofpoint-GUID: hJlLbahAyYdf2uR-mZmG7kVNdpzh5j0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200079
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/15/26 22:38, Philippe Mathieu-Daudé wrote:
> When TARGET_PPC64 is set, the 'target_ulong' type expand to
> the 'uint64_t' one. Use the latter which is more explicity,
> similarly with the TCG and migration APIs. No logical change
> intended.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu.h       | 10 +++++-----
>   target/ppc/machine.c   |  2 +-
>   target/ppc/translate.c | 33 +++++++++++++++++----------------
>   3 files changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f4438982928..2332c509524 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1373,11 +1373,11 @@ struct CPUArchState {
>   
>   #ifdef TARGET_PPC64
>       /* Branch History Rolling Buffer (BHRB) resources */
> -    target_ulong bhrb_num_entries;
> -    intptr_t     bhrb_base;
> -    target_ulong bhrb_filter;
> -    target_ulong bhrb_offset;
> -    target_ulong bhrb_offset_mask;
> +    uint64_t bhrb_num_entries;
> +    intptr_t bhrb_base;
> +    uint64_t bhrb_filter;
> +    uint64_t bhrb_offset;
> +    uint64_t bhrb_offset_mask;
>       uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
>   #endif
>   
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index b44c3ccf0ae..65594f5e1a6 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -723,7 +723,7 @@ static const VMStateDescription vmstate_bhrb = {
>       .minimum_version_id = 1,
>       .needed = bhrb_needed,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
> +        VMSTATE_UINT64(env.bhrb_offset, PowerPCCPU),
>           VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
>           VMSTATE_END_OF_LIST()
>       }
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index ecf75c1376e..996e6551436 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3502,7 +3502,8 @@ static void gen_rvwinkle(DisasContext *ctx)
>   #endif /* defined(CONFIG_USER_ONLY) */
>   }
>   
> -static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv value)
> +static TCGv gen_write_bhrb(TCGv_ptr base, TCGv_i64 offset,
> +                           TCGv_i64 mask, TCGv_i64 value
Hey was it intentional to leave out 'inline' here ?

Regards,
Chinmay
>   {
>       TCGv_ptr tmp = tcg_temp_new_ptr();
>   
> @@ -3513,10 +3514,10 @@ static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv va
>       tcg_gen_st_i64(value, tmp, 0);
>   
>       /* add 8 to current bhrb_offset */
> -    tcg_gen_addi_tl(offset, offset, 8);
> +    tcg_gen_addi_i64(offset, offset, 8);
>   
>       /* apply offset mask */
> -    tcg_gen_and_tl(offset, offset, mask);
> +    tcg_gen_and_i64(offset, offset, mask);
>   
>       return offset;
>   }
> @@ -3529,13 +3530,13 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>   {
>   #if defined(TARGET_PPC64)
>       TCGv_ptr base;
> -    TCGv tmp;
> -    TCGv offset;
> -    TCGv mask;
> +    TCGv_i64 tmp;
> +    TCGv_i64 offset;
> +    TCGv_i64 mask;
>       TCGLabel *no_update;
>   
>       if (ctx->has_cfar) {
> -        tcg_gen_movi_tl(cpu_cfar, nip);
> +        tcg_gen_movi_i64(cpu_cfar, nip);
>       }
>   
>       if (!ctx->has_bhrb ||
> @@ -3548,22 +3549,22 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>       no_update = gen_new_label();
>   
>       /* check for bhrb filtering */
> -    tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
> -    tcg_gen_andi_tl(tmp, tmp, inst_type);
> -    tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, 0, no_update);
> +    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
> +    tcg_gen_andi_i64(tmp, tmp, inst_type);
> +    tcg_gen_brcondi_i64(TCG_COND_EQ, tmp, 0, no_update);
>   
>       base = tcg_temp_new_ptr();
> -    offset = tcg_temp_new();
> -    mask = tcg_temp_new();
> +    offset = tcg_temp_new_i64();
> +    mask = tcg_temp_new_i64();
>   
>       /* load bhrb base address */
>       tcg_gen_ld_ptr(base, tcg_env, offsetof(CPUPPCState, bhrb_base));
>   
>       /* load current bhrb_offset */
> -    tcg_gen_ld_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
> +    tcg_gen_ld_i64(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
>   
>       /* load a BHRB offset mask */
> -    tcg_gen_ld_tl(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
> +    tcg_gen_ld_i64(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
>   
>       offset = gen_write_bhrb(base, offset, mask, tcg_constant_i64(nip));
>   
> @@ -3571,13 +3572,13 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>       if (inst_type & BHRB_TYPE_XL_FORM) {
>   
>           /* Set the 'T' bit for target entries */
> -        tcg_gen_ori_tl(tmp, target, 0x2);
> +        tcg_gen_ori_i64(tmp, target, 0x2);
>   
>           offset = gen_write_bhrb(base, offset, mask, tmp);
>       }
>   
>       /* save updated bhrb_offset for next time */
> -    tcg_gen_st_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
> +    tcg_gen_st_i64(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
>   
>       gen_set_label(no_update);
>   #endif

