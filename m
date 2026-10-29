Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61871606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 00:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=f+L/cJrG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMDcP-0000x0-G2; Wed, 28 Oct 2026 20:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xMDcN-0000wj-57
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:03:43 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1xMDcJ-00084r-Sf
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 20:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject
 :Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=77s5GGS4sJQ2EK2DPUG2BIKnKP8YIF+dbmBv3wrRJ0s=; b=f+L/cJrGYkqVrOM
 78K1c4WTOLHledCYuBgLG8hNI7UK/0wqTz5iH9IvOA4T8ig/6Ynjj/T0WlalZIGdh4ZBviuzmB5aS
 zQVWQeNt/QL77e3gbf76+J42BL+C6gepUYzp5gAHBzHdYKVarWFYN4q4+iJXuEDGRiFHtAsFl2jZO
 +w=;
Date: Thu, 29 Oct 2026 01:08:55 +0100
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 1/1] target/hexagon: implement floating-point exception
 for sysemu
Message-ID: <auKOkD7mDrXnmU3E@hive.localdomain>
References: <20261028232720.3331505-1-brian.cain@oss.qualcomm.com>
 <20261028232720.3331505-2-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261028232720.3331505-2-brian.cain@oss.qualcomm.com>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/26, Brian Cain wrote:
> Define RAISE_FP_EXCEPTION with a HEX_EVENT_FPTRAP exception.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/arch.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/target/hexagon/arch.c b/target/hexagon/arch.c
> index 3c417358e06..5ee87b320b6 100644
> --- a/target/hexagon/arch.c
> +++ b/target/hexagon/arch.c
> @@ -20,6 +20,7 @@
>  #include "cpu.h"
>  #include "fma_emu.h"
>  #include "arch.h"
> +#include "internal.h"
>  #include "macros.h"
>  
>  #define SF_BIAS        127
> @@ -213,10 +214,14 @@ void arch_fpop_start(CPUHexagonState *env)
>   */
>  #define RAISE_FP_EXCEPTION   do {} while (0)
>  #else
> - /*
> -  * To be implemented.
> -  */
> -#define RAISE_FP_EXCEPTION   do { g_assert_not_reached(); } while (0)
> +#define RAISE_FP_EXCEPTION \
> +    do { \
> +        CPUState *cs = env_cpu(env); \
> +        cs->exception_index = HEX_EVENT_FPTRAP; \
> +        env->cause_code = HEX_CAUSE_FPTRAP_CAUSE_BADFLOAT; \
> +        do_raise_exception(env, cs->exception_index, \
> +                           env->gpr[HEX_REG_PC], 0); \
> +    } while (0)
>  #endif
>  
>  #define SOFTFLOAT_TEST_FLAG(FLAG, MYF, MYE) \
> -- 
> 2.34.1
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

