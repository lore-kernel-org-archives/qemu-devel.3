Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94C606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=WVjLHlWy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=qfXLlrkq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=u9MbZTo0bJ5gYJv6q4hvBPRcyGw2yuHuNMvohS9MJ3s=; b=WVjLHlWyfgVwCCBLnVjm
	ez1IlVfvAZWgGKROg2g62TgtjaQI1miyUIU48HbK+BGs53bU0u5eDLwCLvfFtdQzfh22kIek8L6wV
	Hq4kRS3X8gvK4hj2hED+a7FzFkK4xm/8SCDQfi74S0TskBstF5mg825zZ+nmPfg1JWckrLcBOMNLA
	HP3uEC9NL8ZsCCWEai4EsTk0BKrRV+UUny67T60C0wDA3p6AJVTMZpHfcU4qK7dZb2qJa1ml4Anke
	dtkya8O4Bybor2f94XeOU1YJLAygfM4HQUvB5c2UjoVku7Ixa6JxVEJdpbb4bMK6ojuOP4JVf2ggD
	fM4hOqQpnDxh+w==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWu16-0001QX-V9; Fri, 27 Nov 2026 06:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu0e-0001Jc-1F; Fri, 27 Nov 2026 06:20:56 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu0c-00014Z-HZ; Fri, 27 Nov 2026 06:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=u9MbZTo0bJ5gYJv6q4hvBPRcyGw2yuHuNMvohS9MJ3s=; b=qfXLlrkqHxX7GNc
 0nNjfYsx2bwBiA/LzZJ0MuWhEHvP9QUcxWwY2TWtPxZ2PvSPm7S7F26ns57ist8QeBzAoj42l4AAE
 xrh/NVf7AFyCnAG3WVxK5ivVdTR94uPhDsj38XBZ2/RdL+gC4HRo82ssuiYexKHya5mH+HQkewPdW
 GE=;
Date: Fri, 27 Nov 2026 12:27:19 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: Re: [PATCH 18/24] target/rx: Use 64-bit TB flags
Message-ID: <awlpEAXr5uv81vI7@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-19-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-19-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> TranslationBlock::flags and TCGTBCPUState::flags are now
> 64-bit, use matching types for the values derived from them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/rx/cpu.c       |  6 +++---
>  target/rx/translate.c | 16 ++++++++--------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/target/rx/cpu.c b/target/rx/cpu.c
> index c35a98f7cefa..dba253bda9b1 100644
> --- a/target/rx/cpu.c
> +++ b/target/rx/cpu.c
> @@ -47,10 +47,10 @@ static vaddr rx_cpu_get_pc(CPUState *cs)
>  static TCGTBCPUState rx_get_tb_cpu_state(CPUState *cs)
>  {
>      CPURXState *env = cpu_env(cs);
> -    uint32_t flags = 0;
> +    uint64_t flags = 0;
>  
> -    flags = FIELD_DP32(flags, PSW, PM, env->psw_pm);
> -    flags = FIELD_DP32(flags, PSW, U, env->psw_u);
> +    flags = FIELD_DP64(flags, PSW, PM, env->psw_pm);
> +    flags = FIELD_DP64(flags, PSW, U, env->psw_u);
>  
>      return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
>  }
> diff --git a/target/rx/translate.c b/target/rx/translate.c
> index 1bacc7adf929..69547c83cc05 100644
> --- a/target/rx/translate.c
> +++ b/target/rx/translate.c
> @@ -36,7 +36,7 @@ typedef struct DisasContext {
>      DisasContextBase base;
>      CPURXState *env;
>      uint32_t pc;
> -    uint32_t tb_flags;
> +    uint64_t tb_flags;
>  } DisasContext;
>  
>  typedef struct DisasCompare {
> @@ -243,7 +243,7 @@ static TCGv_i32 rx_load_source(DisasContext *ctx, TCGv_i32 mem,
>  /* Processor mode check */
>  static int is_privileged(DisasContext *ctx, int is_exception)
>  {
> -    if (FIELD_EX32(ctx->tb_flags, PSW, PM)) {
> +    if (FIELD_EX64(ctx->tb_flags, PSW, PM)) {
>          if (is_exception) {
>              gen_helper_raise_privilege_violation(tcg_env);
>          }
> @@ -332,7 +332,7 @@ static void move_from_cr(DisasContext *ctx, TCGv_i32 ret, int cr, uint32_t pc)
>          tcg_gen_movi_i32(ret, pc);
>          break;
>      case 2:     /* USP */
> -        if (FIELD_EX32(ctx->tb_flags, PSW, U)) {
> +        if (FIELD_EX64(ctx->tb_flags, PSW, U)) {
>              tcg_gen_mov_i32(ret, cpu_sp);
>          } else {
>              tcg_gen_mov_i32(ret, cpu_usp);
> @@ -348,7 +348,7 @@ static void move_from_cr(DisasContext *ctx, TCGv_i32 ret, int cr, uint32_t pc)
>          tcg_gen_mov_i32(ret, cpu_bpc);
>          break;
>      case 10:    /* ISP */
> -        if (FIELD_EX32(ctx->tb_flags, PSW, U)) {
> +        if (FIELD_EX64(ctx->tb_flags, PSW, U)) {
>              tcg_gen_mov_i32(ret, cpu_isp);
>          } else {
>              tcg_gen_mov_i32(ret, cpu_sp);
> @@ -386,7 +386,7 @@ static void move_to_cr(DisasContext *ctx, TCGv_i32 val, int cr)
>          break;
>      /* case 1: to PC not supported */
>      case 2:     /* USP */
> -        if (FIELD_EX32(ctx->tb_flags, PSW, U)) {
> +        if (FIELD_EX64(ctx->tb_flags, PSW, U)) {
>              tcg_gen_mov_i32(cpu_sp, val);
>          } else {
>              tcg_gen_mov_i32(cpu_usp, val);
> @@ -402,7 +402,7 @@ static void move_to_cr(DisasContext *ctx, TCGv_i32 val, int cr)
>          tcg_gen_mov_i32(cpu_bpc, val);
>          break;
>      case 10:    /* ISP */
> -        if (FIELD_EX32(ctx->tb_flags, PSW, U)) {
> +        if (FIELD_EX64(ctx->tb_flags, PSW, U)) {
>              tcg_gen_mov_i32(cpu_isp, val);
>          } else {
>              tcg_gen_mov_i32(cpu_sp, val);
> @@ -2080,8 +2080,8 @@ static void clrsetpsw(DisasContext *ctx, int cb, int val)
>              ctx->base.is_jmp = DISAS_UPDATE;
>              break;
>          case PSW_U:
> -            if (FIELD_EX32(ctx->tb_flags, PSW, U) != val) {
> -                ctx->tb_flags = FIELD_DP32(ctx->tb_flags, PSW, U, val);
> +            if (FIELD_EX64(ctx->tb_flags, PSW, U) != val) {
> +                ctx->tb_flags = FIELD_DP64(ctx->tb_flags, PSW, U, val);
>                  tcg_gen_movi_i32(cpu_psw_u, val);
>                  tcg_gen_mov_i32(val ? cpu_isp : cpu_usp, cpu_sp);
>                  tcg_gen_mov_i32(cpu_sp, val ? cpu_usp : cpu_isp);
> -- 
> 2.55.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

