Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C164606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YjUOmJto
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQf5x-0003BX-MR; Tue, 10 Nov 2026 01:12:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xQf5t-0003Ak-Dv; Tue, 10 Nov 2026 01:12:33 -0500
Received: from [115.124.30.132] (helo=out30-132.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xQf5n-0007HW-RI; Tue, 10 Nov 2026 01:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794291126; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=g5bstPdRHkWbNiSlV3mlZUo5ZDpDV1E0HV7Po0QUbmQ=;
 b=YjUOmJtokgKLXmVgTszizMV6QUQD1fspzEBxnq44vxfrViBnw65nlPy3im9+v8fyKuhr5o5Ht0/Ds16iYJDHwD3va1JFGfc+C1w3VoYcbiiM3LV+DgnhStV7L8mwLoC7RWCsrf/kJNnPpFhIw0ojApOjYZhUb2tTbipqYr3gKNo=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033045098064;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0XEUDESx_1794291125; 
Received: from 30.166.65.98(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XEUDESx_1794291125 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 10 Nov 2026 14:12:06 +0800
Message-ID: <e5793ffb-635e-4e0b-ab85-18fafb942255@linux.alibaba.com>
Date: Tue, 10 Nov 2026 14:12:04 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix exception PC for WFI
To: fangyu.yu@linux.alibaba.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, chao.liu@processmission.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, guoren@kernel.org
References: <20261109135633.64867-1-fangyu.yu@linux.alibaba.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20261109135633.64867-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.132 (deferred)
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/9/26 9:56 PM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> trans_wfi() advances env->pc before calling helper_wfi(), which may
> raise illegal or virtual-instruction exceptions through GETPC().
> With CF_PCREL, restoring the instruction PC uses env->pc's page base.
> If the next instruction is in a different page, the exception PC is
> restored one page too high. This affects both a WFI ending exactly at
> a page boundary and one crossing it.
>
> Keep env->pc pointing at WFI while helper_wfi() can raise an exception,
> and pass the instruction length to the helper. Advance env->pc only on
> the normal single-step or halt paths.
>
> Fixes: 356c13f94dbf ("target/riscv: Enable PC-relative translation")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei
> ---
>   target/riscv/helper.h                              | 2 +-
>   target/riscv/tcg/insn_trans/trans_privileged.c.inc | 4 ++--
>   target/riscv/tcg/op_helper.c                       | 6 +++++-
>   3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 1cffcad580..b36e3532aa 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -135,7 +135,7 @@ DEF_HELPER_1(mret, tl, env)
>   DEF_HELPER_1(dret, tl, env)
>   DEF_HELPER_1(mnret, tl, env)
>   DEF_HELPER_1(ctr_clear, void, env)
> -DEF_HELPER_1(wfi, void, env)
> +DEF_HELPER_2(wfi, void, env, i32)
>   DEF_HELPER_1(wrs_nto, void, env)
>   DEF_HELPER_1(tlb_flush, void, env)
>   DEF_HELPER_1(tlb_flush_all, void, env)
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> index e22df6fbe7..3ca55b9842 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -167,8 +167,8 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>   {
>   #ifndef CONFIG_USER_ONLY
>       decode_save_opc(ctx, 0);
> -    gen_update_pc(ctx, ctx->cur_insn_len);
> -    gen_helper_wfi(tcg_env);
> +    gen_update_pc(ctx, 0);
> +    gen_helper_wfi(tcg_env, tcg_constant_i32(ctx->cur_insn_len));
>       ctx->base.is_jmp = DISAS_NORETURN;
>       return true;
>   #else
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index f9c79fe6b9..3f71258858 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -625,7 +625,7 @@ void HELPER(ctr_clear)(CPURISCVState *env)
>       riscv_ctr_clear(env);
>   }
>   
> -void HELPER(wfi)(CPURISCVState *env)
> +void HELPER(wfi)(CPURISCVState *env, uint32_t insn_len)
>   {
>       CPUState *cs = env_cpu(env);
>       bool rvs = riscv_has_ext(env, RVS);
> @@ -639,6 +639,10 @@ void HELPER(wfi)(CPURISCVState *env)
>                  (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW)))) {
>           riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
>       } else {
> +        env->pc += insn_len;
> +        if (env->xl == MXL_RV32) {
> +            env->pc = (int32_t)env->pc;
> +        }
>           if (riscv_cpu_cfg(env)->ext_sdext && !env->debug_mode &&
>               (env->dcsr & DCSR_STEP)) {
>               return;

