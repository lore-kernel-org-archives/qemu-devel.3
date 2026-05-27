Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FC9CD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 11:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSC5f-0004Uq-Lo; Wed, 27 May 2026 07:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wSC5c-0004Ua-Tn; Wed, 27 May 2026 07:06:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wSC5Z-0001Tv-T5; Wed, 27 May 2026 07:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779879961; bh=8xdqxDSHwsQ8MpYFsmEAbDVMmDAx1vWXh9Y1nZyDtMY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=YQ9pu/cvFmnO20cisrArCySB5ljS2q2oH8K4eAQQOSU3B6XFhPAaUpF8u1psZ635l
 NfY2saCM2pPmBQgitVYgGXqM4D66Ghf5Fwwa/0EPsdlcUGvwxZ8+ltoKEw4tDQiZCW
 17iJEzhMNKviyNjIW/SAH+HB+n4Q/Bk7oX2NllMG2vqdB18bwApoEwIx49/kX66mYL
 +RRb9K89bUOQEN8vDDryWVyYP3v7RxUF2UPhcsrur4dEiIRGmf0safBaJAZ9YtnSh8
 JT+3guXT9MSodLY7tTFlsX/bPcQkEkqqOic4q0nz3IOjUEy3O6AzzrrFsCb8kIWnAu
 jWRV6XmhAEIjw==
Received: from [192.168.177.146] (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by isrv.corpit.ru (Postfix) with ESMTP id D5DB41B1AD2;
 Wed, 27 May 2026 14:06:01 +0300 (MSK)
Message-ID: <d5cad829-a61c-45fe-85b7-0a310cb882cd@tls.msk.ru>
Date: Wed, 27 May 2026 14:06:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user/mips64: fix elf_core_copy_regs register
 layout in core files
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-stable@nongnu.org
References: <20260521184119.1631958-1-mattst88@gmail.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260521184119.1631958-1-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 21.05.2026 21:41, Matt Turner wrote:
> mips64/elfload.c uses #include "../mips/elfload.c" to share code. When
> the compiler processes mips/elfload.c the quoted #include "target_elf.h"
> resolves relative to the including file's directory, so it picks up
> mips/target_elf.h instead of mips64/target_elf.h.  mips/target_elf.h
> pulls in mips/target_ptrace.h, whose target_pt_regs has a pad0[6] field
> before regs[].  As a result elf_core_copy_regs writes:
> 
>    r->pt.regs[i]   -> reserved[6+i]   (shifted by 6 from the correct index)
>    r->pt.cp0_epc   -> reserved[40]    (correct mips64 N64 index is 34)
> 
> The Linux kernel and glibc both use the mips64 N64 layout (no pad0): EPC
> at reserved[34].  Debuggers and libunwind reading the core with N64
> constants therefore see a completely wrong register set — EPC points to
> GP, RA holds the branch target instead of the link address, etc.
> 
> Fix by:
>   - Guarding the mips32 elf_core_copy_regs in mips/elfload.c with #ifndef
>     TARGET_MIPS64 so it is not compiled for mips64/mipsn32 targets.
>   - Providing a mips64-specific elf_core_copy_regs in mips64/elfload.c
>     that writes directly to r->reserved[i] with the correct N64 indices,
>     bypassing the struct field names that are tainted by the wrong header
>     include.
> 
> The mipsn32 (TARGET_ABI_MIPSN32) and mips64el targets are covered by the
> same mips64/elfload.c and benefit from the same fix.

This code was different before the linux/elfload.c split into targets -
before the split, all this was in single linux/elfload.c file.  While
this patch should not be needed before the split (eg. for stable-10.0
branch), the following patch is apparently needed still.

Can you verify please, and maybe provide a similar fix for 10.0.x too -
provided it's actually needed there?

Thanks,

/mjt

> Signed-off-by: Matt Turner <mattst88@gmail.com>
> Cc: qemu-stable@nongnu.org
> ---
> v2: Use tswap32/tswap64 instead of tswapl
> 
>   linux-user/mips/elfload.c   |  2 ++
>   linux-user/mips64/elfload.c | 29 +++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> diff --git ./linux-user/mips/elfload.c ./linux-user/mips/elfload.c
> index cc5bbf05ab..1a46e180cf 100644
> --- ./linux-user/mips/elfload.c
> +++ ./linux-user/mips/elfload.c
> @@ -131,6 +131,7 @@ const char *get_elf_base_platform(CPUState *cs)
>   #undef MATCH_PLATFORM_INSN
>   
>   /* See linux kernel: arch/mips/kernel/process.c:elf_dump_regs.  */
> +#ifndef TARGET_MIPS64
>   void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
>   {
>       for (int i = 1; i < ARRAY_SIZE(env->active_tc.gpr); i++) {
> @@ -146,3 +147,4 @@ void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
>       r->pt.cp0_status = tswapl(env->CP0_Status);
>       r->pt.cp0_cause = tswapl(env->CP0_Cause);
>   }
> +#endif
> diff --git ./linux-user/mips64/elfload.c ./linux-user/mips64/elfload.c
> index b719555e65..9081ae8111 100644
> --- ./linux-user/mips64/elfload.c
> +++ ./linux-user/mips64/elfload.c
> @@ -1 +1,30 @@
>   #include "../mips/elfload.c"
> +
> +/*
> + * mips/elfload.c defines elf_core_copy_regs guarded by #ifndef TARGET_MIPS64.
> + *
> + * We must provide the mips64 version here.  We cannot use r->pt.regs[] because
> + * when mips/elfload.c is #include'd above its "#include "target_elf.h"" resolves
> + * to mips/target_elf.h (compiler searches the including file's directory first),
> + * which pulls in mips/target_ptrace.h.  That struct has pad0[6] before regs[],
> + * so r->pt.regs[i] writes to reserved[6+i] — offset by 6 from what the kernel
> + * and glibc expect for the N64 ABI (EPC at reserved[34], not reserved[40]).
> + *
> + * Write directly to reserved[] using the mips64 N64 index layout:
> + *   R0-R31 at reserved[0..31], LO at [32], HI at [33], EPC at [34].
> + */
> +void elf_core_copy_regs(target_elf_gregset_t *r, const CPUMIPSState *env)
> +{
> +    /* R0 is always 0; r->reserved is zero-initialised by the caller */
> +    for (int i = 1; i < 32; i++) {
> +        r->reserved[i] = tswap64(env->active_tc.gpr[i]);
> +    }
> +    r->reserved[26] = 0;   /* k0 */
> +    r->reserved[27] = 0;   /* k1 */
> +    r->reserved[32] = tswap64(env->active_tc.LO[0]);
> +    r->reserved[33] = tswap64(env->active_tc.HI[0]);
> +    r->reserved[34] = tswap64(env->active_tc.PC);
> +    r->reserved[35] = tswap64(env->CP0_BadVAddr);
> +    r->reserved[36] = tswap64(env->CP0_Status);
> +    r->reserved[37] = tswap64(env->CP0_Cause);
> +}


