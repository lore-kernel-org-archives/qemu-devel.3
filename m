Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13110FD8775
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Uhm-0006GL-Tc; Tue, 17 Mar 2026 09:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1w2Uhk-0006G7-DX; Tue, 17 Mar 2026 09:43:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1w2Uhh-0005hh-Rc; Tue, 17 Mar 2026 09:43:27 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HAolaW1190027; Tue, 17 Mar 2026 13:43:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=nftXitDB7a0uwhVqeW6pmTW0ACraI24pvK+zdfb1znk=; b=MRns3WI36TPm
 y0Tc83hNDak6c5Y7CodwIbQJVzN9tv6QlQhZUxX+To1YZPTtllXRWJuU7Ks55R/V
 Dd0a79KwRhdRSq0wY9/qQn86M5fnu/xE20e2NZ+I0nPjHPndeRJ+MGC6xH129f/v
 A0/BYbe2bAw4gSfwiyUQ+RWs3sb8MkHOclXnGcntoCh2us649zlJ3EkHiZIXdDxj
 H0NeULlGX1u1mI9kmqLA7MdDWswFL8z4fuXl2h5+Y3QpaIC5JdgSgbX5GV+TcJyb
 SOz1VqVjubZk5W2Av68icSj5O8q32TO11wLwouITkHrvzKtn2CZVaUX59qSIEupO
 A7IeL+BTmg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vff8e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:43:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HCD6tv032333;
 Tue, 17 Mar 2026 13:43:17 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7js741-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:43:17 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HDhGWR22872750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 13:43:16 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DA3E58052;
 Tue, 17 Mar 2026 13:43:16 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C8BBD58045;
 Tue, 17 Mar 2026 13:43:15 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 13:43:15 +0000 (GMT)
Message-ID: <f43de7c4f9f0165c01afe02215c679dfd94d21ed.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] target/ppc: Explicitly declare BHRB related
 register as 64-bit
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Anton Johansson <anjo@rev.ng>, Nicholas
 Piggin <npiggin@gmail.com>
Date: Tue, 17 Mar 2026 08:43:15 -0500
In-Reply-To: <20260315170832.40331-4-philmd@linaro.org>
References: <20260315170832.40331-1-philmd@linaro.org>
 <20260315170832.40331-4-philmd@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: MSPgXfSopMA_xYnQp6YBguIotGGmr9bk
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b95a76 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=U8dKSvN9zE5VMYdgUXAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyMSBTYWx0ZWRfX7yt+rlEhISH4
 ugB9B4LLioU3T1wAtYaB4Eh54DceNyJ0cGGMX+NrAzoPo6rysZJ9twsUshhspgNAGzrt19W3yPr
 y43qK+Cdi60obdYbn0HguML66yT8+QIHhxTCxXrdVlNH1EcJNeJLsRErWJ5eVvFK6SG67OKSGaf
 hhfBP6x3assSzc+Sd5qfLL0z2IaQRNxFsWKtGT76VV+B7eoWXeuc4dZ+7XRZEn+ifMDmTRPcDjm
 SXG2bBPqFJRRdqypatKQteo7HuaXxRR3xK94t7xqqruaTqL5XjoyiXgWKws3OcThBZSHLtooeus
 GmvMtTUNw8eBQLDkDLDaO2zqEwzIrrKe8QoQjbCF0kC1Sugmgj/TJCi+8up7+/6aqf4R5ZqvjTV
 bKSImaVdUbP7nirr0r3/knSQZZAKj69uqmIBp8T49k3okJ/RQOYuLep01qXSCe2bQloiumR1u7x
 SpHok8El2sniqRxIGMA==
X-Proofpoint-GUID: oD2XsxYezvQkSjYQOHEZXTkY4kJicbJk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170121
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Sun, 2026-03-15 at 18:08 +0100, Philippe Mathieu-Daudé wrote:
> When TARGET_PPC64 is set, the 'target_ulong' type expand to
> the 'uint64_t' one. Use the latter which is more explicity,
> similarly with the TCG and migration APIs. No logical change
> intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/ppc/cpu.h       | 10 +++++-----
>  target/ppc/machine.c   |  2 +-
>  target/ppc/translate.c | 33 +++++++++++++++++----------------
>  3 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f4438982928..2332c509524 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1373,11 +1373,11 @@ struct CPUArchState {
>  
>  #ifdef TARGET_PPC64
>      /* Branch History Rolling Buffer (BHRB) resources */
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
>      uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
>  #endif
>  
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index b44c3ccf0ae..65594f5e1a6 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -723,7 +723,7 @@ static const VMStateDescription vmstate_bhrb = {
>      .minimum_version_id = 1,
>      .needed = bhrb_needed,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
> +        VMSTATE_UINT64(env.bhrb_offset, PowerPCCPU),
>          VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index ecf75c1376e..996e6551436 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3502,7 +3502,8 @@ static void gen_rvwinkle(DisasContext *ctx)
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
>  
> -static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv value)
> +static TCGv gen_write_bhrb(TCGv_ptr base, TCGv_i64 offset,
> +                           TCGv_i64 mask, TCGv_i64 value)
>  {
>      TCGv_ptr tmp = tcg_temp_new_ptr();
>  
> @@ -3513,10 +3514,10 @@ static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv va
>      tcg_gen_st_i64(value, tmp, 0);
>  
>      /* add 8 to current bhrb_offset */
> -    tcg_gen_addi_tl(offset, offset, 8);
> +    tcg_gen_addi_i64(offset, offset, 8);
>  
>      /* apply offset mask */
> -    tcg_gen_and_tl(offset, offset, mask);
> +    tcg_gen_and_i64(offset, offset, mask);
>  
>      return offset;
>  }
> @@ -3529,13 +3530,13 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>  {
>  #if defined(TARGET_PPC64)
>      TCGv_ptr base;
> -    TCGv tmp;
> -    TCGv offset;
> -    TCGv mask;
> +    TCGv_i64 tmp;
> +    TCGv_i64 offset;
> +    TCGv_i64 mask;
>      TCGLabel *no_update;
>  
>      if (ctx->has_cfar) {
> -        tcg_gen_movi_tl(cpu_cfar, nip);
> +        tcg_gen_movi_i64(cpu_cfar, nip);
>      }
>  
>      if (!ctx->has_bhrb ||
> @@ -3548,22 +3549,22 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>      no_update = gen_new_label();
>  
>      /* check for bhrb filtering */
> -    tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
> -    tcg_gen_andi_tl(tmp, tmp, inst_type);
> -    tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, 0, no_update);
> +    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
> +    tcg_gen_andi_i64(tmp, tmp, inst_type);
> +    tcg_gen_brcondi_i64(TCG_COND_EQ, tmp, 0, no_update);
>  
>      base = tcg_temp_new_ptr();
> -    offset = tcg_temp_new();
> -    mask = tcg_temp_new();
> +    offset = tcg_temp_new_i64();
> +    mask = tcg_temp_new_i64();
>  
>      /* load bhrb base address */
>      tcg_gen_ld_ptr(base, tcg_env, offsetof(CPUPPCState, bhrb_base));
>  
>      /* load current bhrb_offset */
> -    tcg_gen_ld_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
> +    tcg_gen_ld_i64(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
>  
>      /* load a BHRB offset mask */
> -    tcg_gen_ld_tl(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
> +    tcg_gen_ld_i64(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
>  
>      offset = gen_write_bhrb(base, offset, mask, tcg_constant_i64(nip));
>  
> @@ -3571,13 +3572,13 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>      if (inst_type & BHRB_TYPE_XL_FORM) {
>  
>          /* Set the 'T' bit for target entries */
> -        tcg_gen_ori_tl(tmp, target, 0x2);
> +        tcg_gen_ori_i64(tmp, target, 0x2);
>  
>          offset = gen_write_bhrb(base, offset, mask, tmp);
>      }
>  
>      /* save updated bhrb_offset for next time */
> -    tcg_gen_st_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
> +    tcg_gen_st_i64(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
>  
>      gen_set_label(no_update);
>  #endif


