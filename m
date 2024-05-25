Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAF2C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 21:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAz5e-0004zV-7M; Sat, 25 May 2024 17:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sAz5c-0004zK-Td
 for qemu-devel@nongnu.org; Sat, 25 May 2024 17:38:08 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1sAz5a-00081B-VH
 for qemu-devel@nongnu.org; Sat, 25 May 2024 17:38:08 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2e72b8931caso80587281fa.0
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716673084; x=1717277884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=Vo4mOElxSUPWi2Nc1pNYDJmddqDfN+/8nfsq5hNgnQY=;
 b=m2MpSrCK34RDeBI2rrbl63+Y5xqjlJ2wmxxbiFsDSPG/BwZ91B6+vpQDW2eB89YWI8
 PrvMUVA80xUShQqoJZ2eAgGwYRvfBp2F2vkngIA2nyLXtkEnjPqxBbOe10QocRg56jvO
 6ydiH32qcexCQlqtK3AoyPXtNz6FLX9o3eGf2RD6+TVDvotk4ja2PyO3R9e4Y3B7v+rY
 oS5MbvMg+OZkXgEk0dr5zwP7FkS9honoIbzbyyEjegVEU1GiGzBiOxS9lwxoCy6kr8hf
 Zp5KOfVZLO5+qClqMjWYXPHJYtkvQ4qkWjzksEEwTyfLkYFkTKgvvSMnFv0ENdRpCno5
 sY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716673084; x=1717277884;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vo4mOElxSUPWi2Nc1pNYDJmddqDfN+/8nfsq5hNgnQY=;
 b=kLV6XSQzENjvs/nyEMHg9Mbuu+d34mGQZdWRxl2gkwEIVlACN9ZWwSo53RytLiL2pO
 RwSiTIRIcIvoAOyD9zxAjrHtIKiKQuTWTTUUn4BalUwc7C6SPT8votqFWZxVIIJecjCX
 OlmzLst5JWzR9u4t31gc+Vl00P8PEOAT3fvd2Gv04xrUSvvmG4O7aCCUVGt7LRxC3715
 tDElTVAez56Xo2ZsVn1xzseY4TIcoZqX7mmfptnsQWrcJPgInZ7YHa6cBEGt77Pbd3C+
 4Ro0Y5P/EDn4U1JEVddj/ON9Jd31/PntkymUcbqUzxsG2t55Y6QXm2kvABuuJmIGgFpR
 13Jg==
X-Gm-Message-State: AOJu0YxSqtoLw4cmlHt4VpeLtZ3yu+B/CEWCADuwnFVhSCm8vUm2Jfx6
 flFAmCFisIWuHwQ517YvqJiYvxVYlul9wAUC4CgBRGbRN6NhfhRQKWFDPw==
X-Google-Smtp-Source: AGHT+IG4S3R8uW9fWQJ066O+aJfaIlCg1rXb845Lkn1ssUNNk9XFgWKjD+/OHC05ruI+n9Y9zWek/Q==
X-Received: by 2002:a2e:2e10:0:b0:2e5:87c1:e845 with SMTP id
 38308e7fff4ca-2e95b278a70mr32523041fa.48.1716673083803; 
 Sat, 25 May 2024 14:38:03 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-191-050-204.77.191.pool.telefonica.de.
 [77.191.50.204]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-579c81b5eb4sm209874a12.11.2024.05.25.14.38.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 May 2024 14:38:03 -0700 (PDT)
Date: Sat, 25 May 2024 20:50:32 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPULL_17/20=5D_target/arm=3A_Do_memory_typ?=
 =?US-ASCII?Q?e_alignment_check_when_translation_disabled?=
In-Reply-To: <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
References: <20240305135237.3111642-1-peter.maydell@linaro.org>
 <20240305135237.3111642-18-peter.maydell@linaro.org>
 <C875173E-4B5B-4F71-8CF4-4325F7AB7629@gmail.com>
Message-ID: <72ED7A80-9EA7-4FF6-BE29-9583587985C7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=shentey@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 25=2E Mai 2024 13:41:54 UTC schrieb Bernhard Beschow <shentey@gmail=2Ec=
om>:
>
>
>Am 5=2E M=C3=A4rz 2024 13:52:34 UTC schrieb Peter Maydell <peter=2Emaydel=
l@linaro=2Eorg>:
>>From: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>>
>>If translation is disabled, the default memory type is Device, which
>>requires alignment checking=2E  This is more optimally done early via
>>the MemOp given to the TCG memory operation=2E
>>
>>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>>Reported-by: Idan Horowitz <idan=2Ehorowitz@gmail=2Ecom>
>>Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>>Message-id: 20240301204110=2E656742-6-richard=2Ehenderson@linaro=2Eorg
>>Resolves: https://gitlab=2Ecom/qemu-project/qemu/-/issues/1204
>>Signed-off-by: Richard Henderson <richard=2Ehenderson@linaro=2Eorg>
>>Signed-off-by: Peter Maydell <peter=2Emaydell@linaro=2Eorg>
>
>Hi,
>
>This change causes an old 4=2E14=2E40 Linux kernel to panic on boot using=
 the sabrelite machine:
>
>[snip]
>Alignment trap: init (1) PC=3D0x76f1e3d4 Instr=3D0x14913004 Address=3D0x7=
6f34f3e FSR 0x001
>Alignment trap: init (1) PC=3D0x76f1e3d8 Instr=3D0x148c3004 Address=3D0x7=
e8492bd FSR 0x801
>Alignment trap: init (1) PC=3D0x76f0dab0 Instr=3D0x6823 Address=3D0x7e849=
fbb FSR 0x001
>Alignment trap: init (1) PC=3D0x76f0dab2 Instr=3D0x6864 Address=3D0x7e849=
fbf FSR 0x001
>scsi 0:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2=2E5+ PQ: 0 AN=
SI: 5
>fsl-asoc-card sound: ASoC: CODEC DAI sgtl5000 not registered
>imx-sgtl5000 sound: ASoC: CODEC DAI sgtl5000 not registered
>imx-sgtl5000 sound: snd_soc_register_card failed (-517)
>Alignment trap: init (1) PC=3D0x76eac95a Instr=3D0xf8dd5015 Address=3D0x7=
e849b05 FSR 0x001
>Alignment trap: not handling instruction f8dd5015 at [<76eac95a>]
>Unhandled fault: alignment exception (0x001) at 0x7e849b05
>pgd =3D 9c59c000
>[7e849b05] *pgd=3D2c552831, *pte=3D109eb34f, *ppte=3D109eb83f
>Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x00000007
>
>---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=3D0=
x00000007
>
>As you can see, some alignment exceptions are handled by the kernel, the =
last one isn't=2E I added some additional printk()'s and traced it down to =
this location in the kernel: <https://github=2Ecom/torvalds/linux/blob/v4=
=2E14/arch/arm/mm/alignment=2Ec#L762> which claims that ARMv6++ CPUs can ha=
ndle up to word-sized unaligned accesses, thus no fixup is needed=2E
>
>I hope that this will be sufficient for a fix=2E Let me know if you need =
any additional information=2E

I'm performing a direct kernel boot=2E On real hardware, a bootloader is i=
nvolved which probably enables unaligned access=2E This may explain why it =
works there but not in QEMU any longer=2E

To fix direct kernel boot, it seems as if the "built-in bootloader" would =
need to be adapted/extended [1]=2E Any ideas?

Best regards,
Bernhard

 [1] https://stackoverflow=2Ecom/questions/68949890/how-does-qemu-emulate-=
a-kernel-without-a-bootloader

>
>Best regards,
>Bernhard
>
>>---
>> target/arm/tcg/hflags=2Ec | 34 ++++++++++++++++++++++++++++++++--
>> 1 file changed, 32 insertions(+), 2 deletions(-)
>>
>>diff --git a/target/arm/tcg/hflags=2Ec b/target/arm/tcg/hflags=2Ec
>>index 8e5d35d9227=2E=2E5da1b0fc1d4 100644
>>--- a/target/arm/tcg/hflags=2Ec
>>+++ b/target/arm/tcg/hflags=2Ec
>>@@ -26,6 +26,35 @@ static inline bool fgt_svc(CPUARMState *env, int el)
>>         FIELD_EX64(env->cp15=2Efgt_exec[FGTREG_HFGITR], HFGITR_EL2, SVC=
_EL1);
>> }
>>=20
>>+/* Return true if memory alignment should be enforced=2E */
>>+static bool aprofile_require_alignment(CPUARMState *env, int el, uint64=
_t sctlr)
>>+{
>>+#ifdef CONFIG_USER_ONLY
>>+    return false;
>>+#else
>>+    /* Check the alignment enable bit=2E */
>>+    if (sctlr & SCTLR_A) {
>>+        return true;
>>+    }
>>+
>>+    /*
>>+     * If translation is disabled, then the default memory type is
>>+     * Device(-nGnRnE) instead of Normal, which requires that alignment
>>+     * be enforced=2E  Since this affects all ram, it is most efficient
>>+     * to handle this during translation=2E
>>+     */
>>+    if (sctlr & SCTLR_M) {
>>+        /* Translation enabled: memory type in PTE via MAIR_ELx=2E */
>>+        return false;
>>+    }
>>+    if (el < 2 && (arm_hcr_el2_eff(env) & (HCR_DC | HCR_VM))) {
>>+        /* Stage 2 translation enabled: memory type in PTE=2E */
>>+        return false;
>>+    }
>>+    return true;
>>+#endif
>>+}
>>+
>> static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
>>                                            ARMMMUIdx mmu_idx,
>>                                            CPUARMTBFlags flags)
>>@@ -121,8 +150,9 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState =
*env, int fp_el,
>> {
>>     CPUARMTBFlags flags =3D {};
>>     int el =3D arm_current_el(env);
>>+    uint64_t sctlr =3D arm_sctlr(env, el);
>>=20
>>-    if (arm_sctlr(env, el) & SCTLR_A) {
>>+    if (aprofile_require_alignment(env, el, sctlr)) {
>>         DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
>>     }
>>=20
>>@@ -223,7 +253,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState =
*env, int el, int fp_el,
>>=20
>>     sctlr =3D regime_sctlr(env, stage1);
>>=20
>>-    if (sctlr & SCTLR_A) {
>>+    if (aprofile_require_alignment(env, el, sctlr)) {
>>         DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
>>     }
>>=20

