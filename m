Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E37CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 15:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6W2h-000277-Oe; Wed, 08 Oct 2025 11:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6W2f-00026z-Ub
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:25:25 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1v6W2X-0005vh-L2
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 11:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=0Ni+PhFQ3dKEOeIyg5QLHtPh5He/YOdqZaeeboir4AM=; b=mf878khqLtjYKdY
 03ltqNelV37MuFRBKklDNy5XlPalwFOgee9ff5nax9UYSz3nKOVSZILOd+tbq+JTQcZda47FTpyUZ
 M0FrZ1rUBSnFLvW4+10MXRZ8EChZERQpuXDGZTzRsHHBiYJ59Wkn+4AFeCt4heR4V3unR6mcVIhPP
 RA=;
Date: Wed, 8 Oct 2025 17:27:49 +0200
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, marco.liebel@oss.qualcomm.com,
 ltaylorsimpson@gmail.com, alex.bennee@linaro.org, quic_mburton@quicinc.com, 
 sid.manning@oss.qualcomm.com,
 Alex =?utf-8?B?UsO4bm5l?= Petersen <alex@alexrp.com>, 
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 1/2] linux-user/hexagon: Fix sigcontext
Message-ID: <37cyiiwd6ktmjvfue7t6ifw727p4pdl52wfpbuyll7aqsocxk7@6wro7hlwb6mc>
References: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
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

On 08/10/25, Brian Cain wrote:
> In order to correspond with the kernel, we've now (1) moved the
> preds[] to the right offset and combined the representation as a single
> ulong "p3_0", (2), added the cs{0,1} registers, (3) added a pad for 48
> words, (4) added the user regs structure to an 8-byte aligned
> target_sigcontext structure.
> 
> Co-authored-by: Alex Rønne Petersen <alex@alexrp.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  linux-user/hexagon/signal.c | 199 ++++++++++++++++++++----------------
>  1 file changed, 111 insertions(+), 88 deletions(-)
> 
> diff --git a/linux-user/hexagon/signal.c b/linux-user/hexagon/signal.c
> index 492b51f155..6c3dbf91fa 100644
> --- a/linux-user/hexagon/signal.c
> +++ b/linux-user/hexagon/signal.c
> @@ -23,7 +23,7 @@
>  #include "signal-common.h"
>  #include "linux-user/trace.h"
>  
> -struct target_sigcontext {
> +struct target_user_regs_struct {
>      target_ulong r0,  r1,  r2,  r3;
>      target_ulong r4,  r5,  r6,  r7;
>      target_ulong r8,  r9, r10, r11;
> @@ -39,14 +39,21 @@ struct target_sigcontext {
>      target_ulong m0;
>      target_ulong m1;
>      target_ulong usr;
> +    target_ulong p3_0;
>      target_ulong gp;
>      target_ulong ugp;
>      target_ulong pc;
>      target_ulong cause;
>      target_ulong badva;
> -    target_ulong pred[NUM_PREGS];
> +    target_ulong cs0;
> +    target_ulong cs1;
> +    target_ulong pad1;
>  };

struct layout looks good assuming it must correspond to
`arch/hexagon/include/uapi/asm/user.h`.  Add a `/* pad to 48 words */`
comment to pad1, and static assert following the struct definition

  QEMU_BUILD_BUG_ON(sizeof(struct target_user_regs_struct) != 48*4);

>  
> +struct target_sigcontext {
> +    struct target_user_regs_struct sc_regs;
> +} __attribute__((aligned(8)));

Use QEMU_ALIGNED(8)

> +
>  struct target_ucontext {
>      unsigned long uc_flags;
>      target_ulong uc_link; /* target pointer */
> @@ -76,53 +83,63 @@ static abi_ulong get_sigframe(struct target_sigaction *ka,
>  
>  static void setup_sigcontext(struct target_sigcontext *sc, CPUHexagonState *env)
>  {
> -    __put_user(env->gpr[HEX_REG_R00], &sc->r0);

[...]

> +    __put_user(env->gpr[HEX_REG_PC], &sc->sc_regs.pc);
>  
> +    /* Consolidate predicates into p3_0 */
> +    target_ulong preds = 0;

Declare `preds` at the top of the function.

>      int i;
>      for (i = 0; i < NUM_PREGS; i++) {

int i = 0 inside the for loop is fine

> -        __put_user(env->pred[i], &(sc->pred[i]));
> +        preds |= (env->pred[i] & 0xff) << (i * 8);
>      }
> +    __put_user(preds, &sc->sc_regs.p3_0);
> +
> +    /* Set cause and badva to 0 - these are set by kernel on exceptions */
> +    __put_user(0, &sc->sc_regs.cause);
> +    __put_user(0, &sc->sc_regs.badva);
> +
> +    __put_user(env->gpr[HEX_REG_CS0], &sc->sc_regs.cs0);
> +    __put_user(env->gpr[HEX_REG_CS1], &sc->sc_regs.cs1);
>  }
>  
>  static void setup_ucontext(struct target_ucontext *uc,
> @@ -192,53 +209,59 @@ badframe:
>  static void restore_sigcontext(CPUHexagonState *env,
>                                 struct target_sigcontext *sc)
>  {

[...]

>  
> +    /* Restore predicates from p3_0 */
> +    target_ulong preds;
> +    __get_user(preds, &sc->sc_regs.p3_0);
>      int i;
>      for (i = 0; i < NUM_PREGS; i++) {
> -        __get_user(env->pred[i], &(sc->pred[i]));
> +        env->pred[i] = (preds >> (i * 8)) & 0xff;
>      }

Same here with preds at the top of the function and i declared in the
for statement.

> +
> +    __get_user(env->gpr[HEX_REG_CS0], &sc->sc_regs.cs0);
> +    __get_user(env->gpr[HEX_REG_CS1], &sc->sc_regs.cs1);
>  }
>  
>  static void restore_ucontext(CPUHexagonState *env, struct target_ucontext *uc)
> -- 
> 2.34.1
> 

Other than that

Reviewed-by: Anton Johansson <anjo@rev.ng>

