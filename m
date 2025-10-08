Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CD8CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RGs-0003Nj-Qp; Wed, 08 Oct 2025 06:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6RGq-0003NH-5Z
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:19:44 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6RGn-0004Fm-Ox
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=2H77+Doc+3zP1TJjcgqc5M/smB7yZceOdndJyy4/ArE=; b=uqOINIWUN1wZ4QE
 0LiinR6yWIDfEuq2xhGef89A/70pJbvIhpxEI3bhhbapqkf1xKrru8SRivYAMmReANzg1969pCSG9
 rBKxZxGv4B7olErsh2oa8DrxHRmS31zjav+bad22GgKIoacQ3oOXMHyFs8QJdTkefHWsfSbiOszxc
 C4=;
Date: Wed, 8 Oct 2025 12:22:20 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 4/5] target/microblaze: Remove target_ulong use in
 helper_stackprot()
Message-ID: <dmneby7i44m7vvkhfhxh7cdhfu4l43wilukrtnfcvqzwgrgp66@hzkohhyqg4cu>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008060129.87579-5-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
> Since commit 36a9529e60e ("target/microblaze: Simplify
> compute_ldst_addr_type{a,b}"), helper_stackprot() takes
> a TCGv_i32 argument.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/helper.h    | 2 +-
>  target/microblaze/op_helper.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
> index ef4fad9b91e..01eba592b26 100644
> --- a/target/microblaze/helper.h
> +++ b/target/microblaze/helper.h
> @@ -20,7 +20,7 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
>  DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
>  
>  DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
> -DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
> +DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, i32)
>  DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
>  DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
>  
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index b8365b3b1d2..df93c4229d6 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -365,13 +365,13 @@ uint32_t helper_pcmpbf(uint32_t a, uint32_t b)
>      return 0;
>  }
>  
> -void helper_stackprot(CPUMBState *env, target_ulong addr)
> +void helper_stackprot(CPUMBState *env, uint32_t addr)
>  {
>      if (addr < env->slr || addr > env->shr) {
>          CPUState *cs = env_cpu(env);
>  
>          qemu_log_mask(CPU_LOG_INT, "Stack protector violation at "
> -                      TARGET_FMT_lx " %x %x\n",
> +                                   "0x%x 0x%x 0x%x\n",
>                        addr, env->slr, env->shr);
>  
>          env->ear = addr;
> -- 
> 2.51.0
> 

Might as well update call sites to gen_helper_stackprot() as well.
compute_ldst_addr_type[ab]() calls into gen_helper_stackprot() but
returns TCGv.  That return value is passed to do_load() and
do_store() as TCGv, but the bodies of these function clearly expect
TCG_i32.

Otherwise

Reviewed-by: Anton Johansson <anjo@rev.ng>

