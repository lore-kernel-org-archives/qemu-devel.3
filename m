Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EAEC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 18:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcqBO-0001AN-ES; Tue, 28 Jan 2025 13:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqBH-00019c-Ke
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:19:23 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcqBC-0003hP-1r
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 13:19:21 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-219f8263ae0so110597905ad.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 10:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738088350; x=1738693150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sh/uzz08TlghSRbHt8cVEugv8efVWhCzPVxYeuQQ8ss=;
 b=FNo/XZCGSc8obg+Ebg7uKUTiXp0YEe1hvw+IFrXxwKmpGl60lu1s3AAPhizi1I7LBs
 nJWWgsYBESzHPHoZpQTJPNSrD329CcpmMtUgfemhfUWPB4sXIiKgicj6UQRCzSsDRf/m
 edILxBwBUbNwqHm3zCbhEVF7rGSdVNpGUmbACIwYasSh3GzMjAXGZlwSGxna9X+R5fu2
 8f/WhHdHM/LKBlfox8c/DlNEfljRpEBZehoWmelyrwzj+5003sv5tVQj0xfS66wKP9wr
 HKB53KPX8RueM7JyBxwHkkOjljssoEMU63XlAOw+q8gMGFBmo2tG7ia1k+OMjHOnLbaR
 k80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738088350; x=1738693150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sh/uzz08TlghSRbHt8cVEugv8efVWhCzPVxYeuQQ8ss=;
 b=mHIbzQYIBLbSBlaL953GftoQpgm6CVd2Wi7P1vXTP3L7HwAxEg3y5arvT3ULrk0iIn
 DrcOWVyIack9Cxsj7fI64pQgc1C/uGmhcl5tSYkA3oCW3OdHmdagvjY9zDNpXQoBGtJ6
 eBy4n8mS6Xt01M9XSCVnYcraI2KmaX12t8Dqz/hbjFvIMj2adsZ0t4SrP5sZumIpyQnI
 1ZqSwPRnfEVBxBh20xBDlVEY3kSpoOzASs/hbKCgyKMKzlLsnkihhCl1dEauAg4A3D5o
 bkyDz3PF75sxpXPbOVSt5HHmD/1miUoH2le/f0vdKW9EZenzwk7UnpHEHuCwCZO0inaI
 /DmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURn5nVJMB1N5YbHggZq0rAKTWQ+AoOIu78dNiY0CSlphaou0lHVDPP3scJrIOBb8Iccnzwcc30J+7R@nongnu.org
X-Gm-Message-State: AOJu0YzVn9mMc2J6pkM4fsBTxPY9Y8g2joEHLp9KKrQmFPXtDTGAtLuT
 +YxooMuhK0U0XivRYOIW06g4aG22SD/gahO74XdxZEhMlLRf99/O8x8eXBvYHas=
X-Gm-Gg: ASbGncsLPlzdcoNioDhS0KmpwNQG0043+Kbk0wXHrTRAkcxFQ+EGZLOj0/5ayf1hOaS
 mErCxh/peBZ3ySNiF4D59HNR5I5jRZO2nY7/VoDcsNse651A+wB2Q6FnrxlzlaCXWkvDUcAlMLY
 NlI6EWWzEjS+9ByATFDMwZ8N9ccN1965ZbPhVAeBFc4aMEeTLbIGB6nssUwWo1Eer78T+0z1Ryb
 Xoi/pA4pe63yHiajj+9IKGcKD8E6XoKcwo6qq7FIYAH6t7nCHgXfOBdTLZCFxhQSfEh70JROIaj
 df/6ePDH5AXK5YxW8Qkj7NBWSVh2e3D64wB+/HvPMysEavGx/GzZG34QjQ==
X-Google-Smtp-Source: AGHT+IHj1YHKFlrYUIG0jK2gYuuvqekgh5XQI3ng9Lx5hwli/ZIH03vJfHL7EwR+jLN1KzsfHB66kw==
X-Received: by 2002:a05:6a20:9f05:b0:1db:ddba:8795 with SMTP id
 adf61e73a8af0-1ed7a6f7a25mr356274637.36.1738088350079; 
 Tue, 28 Jan 2025 10:19:10 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6a002csm9590092b3a.21.2025.01.28.10.19.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 10:19:09 -0800 (PST)
Message-ID: <ad9dbe8b-2fca-4e06-ae6c-849db63868f8@linaro.org>
Date: Tue, 28 Jan 2025 10:19:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/hppa: Implement CPU diagnose registers for
 64-bit HP-UX
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250128161450.12975-1-deller@kernel.org>
 <20250128161450.12975-4-deller@kernel.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250128161450.12975-4-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/28/25 08:14, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> PA-RISC CPUs have diagnose registers (%dr). Those are mostly
> undocumented and control cache behaviour, memory behaviour, reset button
> management and many other related internal CPU things.
> 
> The Linux kernel turns space-register hashing off unconditionally at
> bootup.  That code was provided by HP at the beginning of the PA-RISC
> Linux porting effort, and I don't know why it was decided then why Linux
> should not use space register hashing.
> 32-bit HP-UX versions seem to not use space register hashing either.
> But for 64-bit HP-UX versions, Sven Schnelle noticed that space register
> hashing needs to be enabled and is required, otherwise the HP-UX kernel
> will crash badly.
> 
> On 64-bit CPUs space register hashing is controlled by a bit in diagnose
> register %dr2.  Since we want to support Linux and 32- and 64-bit HP-UX,
> we need to fully emulate the diagnose registers and handle specifically
> the content of %dr2.
> 
> Furthermore it turned out that commit 3bdf20819e68 seems wrong and
> conflicts with the general space register diagnose register, so it is
> partly reverted here.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Suggested-by: Sven Schnelle <svens@stackframe.org>
> Fixes: 3bdf20819e68 ("target/hppa: Add diag instructions to set/restore shadow registers")
> ---
>   hw/hppa/machine.c        |  5 +++++
>   target/hppa/cpu.c        |  3 ++-
>   target/hppa/cpu.h        | 24 ++++++++++++++++--------
>   target/hppa/helper.c     |  4 ++--
>   target/hppa/insns.decode |  6 ++++--
>   target/hppa/int_helper.c |  6 +++---
>   target/hppa/machine.c    |  5 +++--
>   target/hppa/sys_helper.c |  2 +-
>   target/hppa/translate.c  | 24 +++++++++++++++++-------
>   9 files changed, 53 insertions(+), 26 deletions(-)

This does too much at once.

Adding the dr registers should be separate from any of the space hashing.  Translator 
changes can be separate from everything else.  Etc.

> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index 0dd1908214..d5de793b62 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -662,6 +662,11 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
>           cpu_set_pc(cs, firmware_entry);
>           cpu[i]->env.psw = PSW_Q;
>           cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
> +
> +        /* 64-bit machines start with space-register hashing enabled in %dr2 */
> +        if (hppa_is_pa20(&cpu[0]->env)) {
> +            cpu[i]->env.dr[2] = HPPA64_DIAG_SPHASH_ENABLE; /* (bit 54) */
> +        }
>       }

Why in hw/?  I would expect this in hppa_cpu_reset_hold.

> diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
> index beea42d105..64e60a3980 100644
> --- a/target/hppa/cpu.h
> +++ b/target/hppa/cpu.h
> @@ -25,6 +25,7 @@
>   #include "qemu/cpu-float.h"
>   #include "qemu/interval-tree.h"
>   #include "hw/registerfields.h"
> +#include "hw/hppa/hppa_hardware.h"

Ideally this would never be in cpu.h.

> @@ -319,27 +321,33 @@ void hppa_translate_code(CPUState *cs, TranslationBlock *tb,
>   
>   #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
>   
> -static inline uint64_t gva_offset_mask(target_ulong psw)
> +static inline uint64_t gva_offset_mask(CPUHPPAState *env, target_ulong psw)
>   {
> -    return (psw & PSW_W
> -            ? MAKE_64BIT_MASK(0, 62)
> -            : MAKE_64BIT_MASK(0, 32));
> +    if (psw & PSW_W) {
> +        return (env->dr[2] & HPPA64_DIAG_SPHASH_ENABLE)
> +            ? MAKE_64BIT_MASK(0, 62) &
> +                ~((uint64_t)HPPA64_PDC_CACHE_RET_SPID_VAL << 48)
> +            : MAKE_64BIT_MASK(0, 62);
> +    } else {
> +        return MAKE_64BIT_MASK(0, 32);
> +    }
>   }

This is getting pretty complicated now.  I think perhaps we should cache the mask based on 
current cpu state (updated with writes to psw or dr2).

This would also move the HPPA64_DIAG_SPHASH_ENABLE reference out of cpu.h.

>   
> -static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
> -                                             target_ulong off)
> +static inline target_ulong hppa_form_gva_psw(CPUHPPAState *env,
> +                                             target_ulong psw,
> +                                             uint64_t spc, target_ulong off)

Which means this would take the cached mask as argument, not env + psw.
Might rename as hppa_form_gva_mask() at the same time to emphasize the
change in arguments.

> diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
> index 71074a64c1..4eaac750ea 100644
> --- a/target/hppa/insns.decode
> +++ b/target/hppa/insns.decode
> @@ -644,10 +644,12 @@ xmpyu           001110 ..... ..... 010 .0111 .00 t:5    r1=%ra64 r2=%rb64
>       # For 32-bit PA-7300LC (PCX-L2)
>       diag_getshadowregs_pa1  000101 00 0000 0000 0001 1010 0000 0000
>       diag_putshadowregs_pa1  000101 00 0000 0000 0001 1010 0100 0000
> +    diag_mfdiag             000101 dr:5  rt:5   0000 0110 0000 0000
> +    diag_mtdiag             000101 dr:5  r1:5   0001 0110 0000 0000
>   
>       # For 64-bit PA8700 (PCX-W2)
> -    diag_getshadowregs_pa2  000101 00 0111 1000 0001 1000 0100 0000
> -    diag_putshadowregs_pa2  000101 00 0111 0000 0001 1000 0100 0000
> +    diag_mfdiag             000101 dr:5  0 0000 0000 1000 101  rt:5
> +    diag_mtdiag             000101 dr:5  r1:5   0001 1000 0100 0000

Do we not want to distinguish the two different diag instructions?
Did you really want to remove get/put_shadowregs_pa2?

> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index 58695def82..5aefb3ade4 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -112,9 +112,9 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>        */
>       if (old_psw & PSW_C) {
>           env->cr[CR_IIASQ] =
> -            hppa_form_gva_psw(old_psw, env->iasq_f, env->iaoq_f) >> 32;
> +            hppa_form_gva_psw(env, old_psw, env->iasq_f, env->iaoq_f) >> 32;
>           env->cr_back[0] =
> -            hppa_form_gva_psw(old_psw, env->iasq_b, env->iaoq_b) >> 32;
> +            hppa_form_gva_psw(env, old_psw, env->iasq_b, env->iaoq_b) >> 32;
>       } else {
>           env->cr[CR_IIASQ] = 0;
>           env->cr_back[0] = 0;
> @@ -165,7 +165,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>                   if (old_psw & PSW_C) {
>                       int prot, t;
>   
> -                    vaddr = hppa_form_gva_psw(old_psw, env->iasq_f, vaddr);
> +                    vaddr = hppa_form_gva_psw(env, old_psw, env->iasq_f, vaddr);
>                       t = hppa_get_physical_address(env, vaddr, MMU_KERNEL_IDX,
>                                                     0, 0, &paddr, &prot);
>                       if (t >= 0) {

Here we'd need to cache the old mask, since PSW_W is changed in step 2, which would 
compute a new mask.


r~

