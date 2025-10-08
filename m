Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015C0CCD183
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 12:16:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6T46-0006ul-RV; Wed, 08 Oct 2025 08:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6T44-0006uJ-KX
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:14:40 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6T3v-0004NY-2E
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 08:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=y6TMoN+MhiWkPaw4gZPZwdY5Psopq5rSFdII9OluXZg=; b=W5K7GTQ1e+LMcnp
 uBL1KCkubBimKEEp8iaQy1kPLeLxRND9a0mjr9lWBK4MJ9toXe/5bVoAp8ThIvBF2KbRBRET19PK+
 yyxSZwT2imQXBo0Fmz0GlXaCFpsOV56X3gpvNd3P40HC4CFU5R9pmvzKbcClIC4fnSaEhYz7B7XFn
 GQ=;
Date: Wed, 8 Oct 2025 14:16:48 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Stafford Horne <shorne@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [RFC PATCH 7/7] target/openrisc: Replace target_ulong -> uint32_t
Message-ID: <fowsbt2ovqpl5mzizniyqx6xhlnvu7lc2po3jbi2cslwrpu5ew@dkcvbphrov6u>
References: <20251008075612.94193-1-philmd@linaro.org>
 <20251008075612.94193-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008075612.94193-8-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08/10/25, Philippe Mathieu-Daudé wrote:
> The OpenRISC targets are only built as 32-bit, therefore
> target_ulong always expands to uint32_t. Replace and adapt
> the API uses mechanically:
> 
>   target_ulong -> uint32_t
>   target_long -> int32_t
>   tl -> i32
>   TCGv -> TCGv_i32
>   tcg_global_mem_new -> tcg_global_mem_new_i32
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> RFC: not sure how to split to ease review :|
> ---
>  target/openrisc/cpu.h        |  22 +--
>  target/openrisc/helper.h     |   8 +-
>  target/openrisc/fpu_helper.c |   8 +-
>  target/openrisc/machine.c    |  16 +-
>  target/openrisc/sys_helper.c |   5 +-
>  target/openrisc/translate.c  | 374 +++++++++++++++++------------------
>  6 files changed, 216 insertions(+), 217 deletions(-)

[...]

> -static void gen_add(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
> +static void gen_add(DisasContext *dc, TCGv_i32 dest, TCGv_i32 srca, TCGv_i32 srcb)
>  {
> -    TCGv t0 = tcg_temp_new();
> -    TCGv res = tcg_temp_new();
> +    TCGv_i32 t0 = tcg_temp_new();
> +    TCGv_i32 res = tcg_temp_new();

I think you missed transforming tcg_temp_new -> tcg_temp_new_i32.

>  static bool trans_l_lwa(DisasContext *dc, arg_load *a)
>  {
> -    TCGv ea;
> +    TCGv_i32 ea;
>  
>      check_r0_write(dc, a->d);
>      ea = tcg_temp_new();
> -    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
> -    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
> -    tcg_gen_mov_tl(cpu_lock_addr, ea);
> -    tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
> +    tcg_gen_addi_i32(ea, cpu_R(dc, a->a), a->i);
> +    tcg_gen_qemu_ld_i32(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
> +    tcg_gen_mov_i32(cpu_lock_addr, ea);
> +    tcg_gen_mov_i32(cpu_lock_value, cpu_R(dc, a->d));
>      return true;
>  }

What about MO_TE -> MO_BE to handle MO_TE[SU][WL]?

I think this is fine to review as is.  if you're looking to split it
more, maybe moving helper signature changes to a separate patch makes
sense (helper.h, fpu_helper.c, sys_helper.c, do_fp*() from translate.c).

Also, might be worth reiterating that the migration stream is unaffected
in the commit message.

With the tcg_temp_new transformation:

Reviewed-by: Anton Johansson <anjo@rev.ng>

