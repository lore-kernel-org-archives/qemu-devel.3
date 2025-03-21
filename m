Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7BFC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvfk5-00070u-V0; Fri, 21 Mar 2025 13:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvfk2-00070g-Sv
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:01:07 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvfjz-0005qe-57
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=48rg6yMHF9CZP5gM11OhM3rx5Ds3b60xqUIBbxCoXO4=; b=QXnTOPHCplcbP64
 7JNxYYbSy8Fp7KSCHshP3m5VplSkNzXNhN++kg0xgbSy5KpVSjXKd/CtkM9tyF5PRn7o/RFiZCOZO
 AKPxktP17dqmyo35vrsVoeU3ArPM6U7AsCnVvcCKtWRfExzVMnefV4kOro3WlGvn/g359HSUckZRI
 wE=;
Date: Fri, 21 Mar 2025 18:01:29 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH-for-10.1 3/4] tcg: Convert TCGState::mttcg_enabled to
 TriState
Message-ID: <3woeoqgwnmksex36kytsasvlidqoviyogmbjjko4e5mlrnureo@3bdqaducdkjs>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321155925.96626-4-philmd@linaro.org>
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

On 21/03/25, Philippe Mathieu-Daudé wrote:
> Use the OnOffAuto type as 3-state.
> 
> Since the TCGState instance is zero-initialized, the
> mttcg_enabled is initialzed as AUTO (ON_OFF_AUTO_AUTO).
> 
> In tcg_init_machine(), if mttcg_enabled is still AUTO,
> set a default value (effectively inlining the
> default_mttcg_enabled() method content).
> 
> Instead of emiting a warning when the 'thread' property
> is set in tcg_set_thread(), emit it in tcg_init_machine()
> where it is consumed.
> 
> In the tcg_get_thread() getter, consider AUTO / OFF states
> as "single", otherwise ON is "multi".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  accel/tcg/tcg-all.c | 68 ++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index d75ecf531b6..2b7f89eaa20 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -32,6 +32,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/accel.h"
>  #include "qemu/atomic.h"
> +#include "qapi/qapi-types-common.h"
>  #include "qapi/qapi-builtin-visit.h"
>  #include "qemu/units.h"
>  #if defined(CONFIG_USER_ONLY)
> @@ -47,7 +48,7 @@
>  struct TCGState {
>      AccelState parent_obj;
>  
> -    bool mttcg_enabled;
> +    OnOffAuto mttcg_enabled;
>      bool one_insn_per_tb;
>      int splitwx_enabled;
>      unsigned long tb_size;
> @@ -68,37 +69,10 @@ bool qemu_tcg_mttcg_enabled(void)
>  }
>  #endif
>  
> -/*
> - * We default to false if we know other options have been enabled
> - * which are currently incompatible with MTTCG. Otherwise when each
> - * guest (target) has been updated to support:
> - *   - atomic instructions
> - *   - memory ordering primitives (barriers)
> - * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
> - *
> - * Once a guest architecture has been converted to the new primitives
> - * there is one remaining limitation to check:
> - *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
> - */
> -
> -static bool default_mttcg_enabled(void)
> -{
> -    if (icount_enabled()) {
> -        return false;
> -    }
> -#ifdef TARGET_SUPPORTS_MTTCG
> -    return true;
> -#else
> -    return false;
> -#endif
> -}
> -
>  static void tcg_accel_instance_init(Object *obj)
>  {
>      TCGState *s = TCG_STATE(obj);
>  
> -    s->mttcg_enabled = default_mttcg_enabled();
> -
>      /* If debugging enabled, default "auto on", otherwise off. */
>  #if defined(CONFIG_DEBUG_TCG) && !defined(CONFIG_USER_ONLY)
>      s->splitwx_enabled = -1;
> @@ -117,9 +91,37 @@ static int tcg_init_machine(MachineState *ms)
>  #else
>      unsigned max_cpus = ms->smp.max_cpus;
>  #endif
> +#ifdef TARGET_SUPPORTS_MTTCG
> +    bool mttcg_supported = true;
> +#else
> +    bool mttcg_supported = false;
> +#endif
>  
>      tcg_allowed = true;
>      mttcg_enabled = s->mttcg_enabled;
> +    if (mttcg_enabled == ON_OFF_AUTO_AUTO) {
> +        /*
> +         * We default to false if we know other options have been enabled
> +         * which are currently incompatible with MTTCG. Otherwise when each
> +         * guest (target) has been updated to support:
> +         *   - atomic instructions
> +         *   - memory ordering primitives (barriers)
> +         * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
> +         *
> +         * Once a guest architecture has been converted to the new primitives
> +         * there is one remaining limitation to check:
> +         *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
> +         */
> +        if (icount_enabled()) {
> +            mttcg_enabled = ON_OFF_AUTO_OFF;
> +        } else {
> +            mttcg_enabled = mttcg_supported;
> +        }
> +    }
> +    if (mttcg_enabled == ON_OFF_AUTO_ON && !mttcg_supported) {
> +        warn_report("Guest not yet converted to MTTCG - "
> +                    "you may get unexpected results");
> +    }

[...]

>  
>  static void tcg_set_thread(Object *obj, const char *value, Error **errp)
> @@ -155,14 +157,10 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
>          if (icount_enabled()) {
>              error_setg(errp, "No MTTCG when icount is enabled");
>          } else {
> -#ifndef TARGET_SUPPORTS_MTTCG
> -            warn_report("Guest not yet converted to MTTCG - "
> -                        "you may get unexpected results");
> -#endif

Patch itself looks good!  My only concern is moving the warning, would
it be worthwhile to have a mttcg_supported field in TCGState as well?
I.e in a heterogeneous setup it would correspond to wether or not all
targets support mttcg.

Otherwise:

Reviewed-by: Anton Johansson <anjo@rev.ng>

