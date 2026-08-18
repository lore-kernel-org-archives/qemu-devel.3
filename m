Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBECC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 10:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHQz-0005uK-4S; Tue, 18 Aug 2026 06:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wwHQx-0005u4-EM
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:52:43 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wwHQv-0001iV-F4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 06:52:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 94CE8583493;
 Tue, 18 Aug 2026 12:52:35 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Pd9gLoG4VF3M; Tue, 18 Aug 2026 12:52:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2DBFB583492; Tue, 18 Aug 2026 12:52:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C1BC583224;
 Tue, 18 Aug 2026 12:52:33 +0200 (CEST)
Date: Tue, 18 Aug 2026 12:52:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: 54weasels <54weasels@gmail.com>
cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH v4 2/6] target/m68k: Fix fsave/frestore for 68881 FPU
In-Reply-To: <20260818022225.31801-3-54weasels@gmail.com>
Message-ID: <a9c04b36-c217-c0f7-0328-70c89d5ca667@eik.bme.hu>
References: <20260818022225.31801-1-54weasels@gmail.com>
 <20260818022225.31801-3-54weasels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Mon, 17 Aug 2026, 54weasels wrote:
> High level description:
> The 68881/68882 FPUs require fsave/frestore instructions to read/write state frames. QEMU only fully implemented this for the 68040. The Sun-3 uses a 68881 FPU, and the boot ROM executes `fsave` to probe FPU presence. This patch adds basic 68881 FPU state frame handling (NULL frame) to accurately simulate an idle FPU state.
>
> Impact on existing functionality:
> Fixes FPU detection for 68881/68882 across all M68k boards without affecting 68040 specific state logic.

Comments such as the next Context: should go below the --- as everything 
before that is part of the commit message. In QEMU a Context: tag is not 
commonly used so I think you want this as a comment not part of the 
commit message.

> Context: This patch was originally submitted as part of the monolithic Sun-3 Machine Emulation series (https://patchew.org/QEMU/20260503015756.99176-1-54weasels@gmail.com/) and has been split into atomic components.
> ---
> target/m68k/translate.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 138c89d3e5..bdf619883c 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -5364,11 +5364,19 @@ DISAS_INSN(frestore)
>         gen_exception(s, s->base.pc_next, EXCP_PRIVILEGE);
>         return;
>     }
> -    if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> +    if (m68k_feature(s->env, M68K_FEATURE_M68040) ||
> +        m68k_feature(s->env, M68K_FEATURE_FPU)) {

M68020+ (including M68040) has FPU set so no need to keep that test and 
can be replaced with M68K_FEATURE_FPU.

>         SRC_EA(env, addr, OS_LONG, 0, NULL);
> -        /* FIXME: check the state frame */
> +        if (m68k_feature(s->env, M68K_FEATURE_M68040)) {
> +            /* FIXME: check the state frame */
> +        } else {

What about M68060 or other CPUs with built-in FPU? As none of these do 
anything maybe the if/else is not needed and can just keep the FIXME 
comment?

> +            /*
> +             * 68881/68882 FRESTORE: read the state frame
> +             * (NULL frame is 4 bytes)
> +             */
> +        }
>     } else {
> -        disas_undef(env, s, insn);
> +        disas_undef_fpu(env, s, insn);
>     }
> }
>
> @@ -5383,8 +5391,12 @@ DISAS_INSN(fsave)
>         /* always write IDLE */
>         TCGv idle = tcg_constant_i32(0x41000000);
>         DEST_EA(env, insn, OS_LONG, idle, NULL);
> +    } else if (m68k_feature(s->env, M68K_FEATURE_FPU)) {
> +        /* 68881/68882 FSAVE: always write NULL frame */
> +        TCGv null_frame = tcg_constant_i32(0x00000000);
> +        DEST_EA(env, insn, OS_LONG, null_frame, NULL);

Same comment as above about CPUs with FPU. Maybe there should be only one 
block for M68K_FEATURE_FPU replacing M68K_FEATURE_M68040 and a switch for 
setting the frame value?

Regards,
BALATON Zoltan

>     } else {
> -        disas_undef(env, s, insn);
> +        disas_undef_fpu(env, s, insn);
>     }
> }
> #endif
>

