Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996EBCD8CA8
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWfD5-00017e-VM; Mon, 08 Jun 2026 15:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfD1-00014R-DR
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:27 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wWfCz-0006tK-CU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 15:00:26 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e6128bd9b3so2592388a34.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 12:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780945224; x=1781550024; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W8sf8OT+nsg957PRY3OZR99qZCzK1VlYe1z4gwGaMBA=;
 b=acscsU2SmdiScb0Ozt93cvpm2jHDC7CMB2nyWMPgIp6UY3BJyedb3Vq+RUryDWGL/C
 t3drzZLgMGRg7O7AR5WTF8lPDHkBilPOnPC0hUlG3iSfd8EbJw43iXgYU+WC2HFariyP
 j3xE5YNaq8/WNNQFI+4I750umtVoodnnhxb0IQyOEbMtunVDix0Qym1helqBxTERLEWS
 nUeKibTMhTPl/hNn4mkK950J2M5l9vkPfmeFjJJgpkX0sQ9psYJ4JvAVvBgBrLJU89U9
 dnG8mOB+k3p8FFO5/mWsGxDgsOT3I6iTByWqxHUmfMfgzdOKcblH8nyds+B06MPcuGZJ
 +N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780945224; x=1781550024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W8sf8OT+nsg957PRY3OZR99qZCzK1VlYe1z4gwGaMBA=;
 b=CR3ezjR29f+31es6tfk1axVcgpVwkjXY+dnS6FgSRv0K0Z4anTNjb1vaT8plxHpwBa
 iciXwnoa+oPJEXwRz/yUiaL8zDMc3xBmU8bEStCDHFqSOmFE+wkYMpSG8BZMxDUB+x55
 sSaV35JZNzCvCc79LWdE4EcFyP29flc6xngx1NLtLQKZ1XDK5g5lRkXJoUQSBDjRm7xQ
 levrVD84k494ft+sWOispVAHfyNHfXWw/ZBCZ3BuaUk6yAZpD5Uast39gwDs+rHRARXx
 snlkEM5SKsZweMdhcZrXH1eURj+U0Wzi0/F/5g3Hc1an4AtZ8k9QGTQPHNK4Q7XiZTI+
 4/Yg==
X-Gm-Message-State: AOJu0Yy4WW8Lk3aEPStaGztWtUZ2UKy/ucfAShv8WzmaHFlcl81u8J/d
 svo/4bUCDI2AEi9mUqFP/EUpXAsCmJBpTGSS1mBK+inwqA5x/XXPulthCev0dkjiIek=
X-Gm-Gg: Acq92OHU+Nuwe+Ub3sBhSmUQT0LiwCH0FZ0Wzy4SdlQPYQQZUvdh3AsbMsLtejG3bru
 dsOruKQnh/Kurt/4ltFdXSKvXia5gvD7lvIC8sdRv9QmROcgAguanWTv0aGA6TUUnO5wUKCOdec
 bhVGZRRyhha7i+Z78TXVLbLLWQgqFD8k+mbNZ4evgr154QBO0hbmy6PDiHYXUeunSekOQSSHt5R
 FFv/GDKNeem7JWaOMBblFmxz6tiO+hbkwu4Che4CqGEihesPyTKZj709w62hOyHW6EZek2JWkZe
 dON7OPMQjteBldkAJ+5KxIZTHAOj/SgtxulRSAOXTxsNP05ZvPInQGFr0ZRKx3zK2/afhogIPhX
 vdXnm/lIpqidJQs3GITF7amUMS2SkJohst+E6AkuJu4HvkPJRy9Sw77yLc+uCLCOMDL/9ustYrU
 eMSjSNcxxIANEuFJJEWVqWO3s8XkrUr3E6Ip+Qj8RFnAimIhsFLMnwlGEZtKP6+SbxE4d6cJ6G8
 EbXp/mBz8FtzHaJ0YPwbyfcUwiBsyksv9T70c8vcKUIE9A7T0mh5mttkQMJkHUDV9Z3REY8gTd3
 ZMLRzcv5WeFu4yEijadL3cxM1IUPlZzT
X-Received: by 2002:a05:6830:2b11:b0:7dc:c7aa:22d4 with SMTP id
 46e09a7af769-7e70c63de1bmr9623065a34.1.1780945224062; 
 Mon, 08 Jun 2026 12:00:24 -0700 (PDT)
Received: from mac.localdomain (97-118-5-210.hlrn.qwest.net. [97.118.5.210])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75db138sm12397777a34.11.2026.06.08.12.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:00:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 08 Jun 2026 12:59:46 -0600
Subject: [PATCH v16 21/21] tests/tcg/mips: cover Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-mips-octeon-missing-insns-v2-v16-21-daef7a0d8b04@gmail.com>
References: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
In-Reply-To: <20260608-mips-octeon-missing-insns-v2-v16-0-daef7a0d8b04@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add smoke coverage for Octeon QMAC and QMACS fixed-point accumulator
instruction paths.

The coverage exercises normal accumulation, saturating accumulation, and
the sticky saturation flag.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
Changes v12 -> v13:
  - Add QMAC/QMACS smoke coverage.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 6480c8532a..6fffc82010 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -129,6 +129,43 @@ static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
     return rd;
 }
 
+static uint64_t octeon_qmac_lo(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x710904d2\n\t" /* qmac.03 $8, $9 */
+        "mflo %[rd]\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return rd;
+}
+
+static uint64_t octeon_qmacs_state(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t hi, rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x71090012\n\t" /* qmacs.00 $8, $9 */
+        "mfhi %[hi]\n\t"
+        "mflo %[rd]\n\t"
+        : [hi] "=r" (hi), [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return ((hi & 1) << 32) | (rd & 0xffffffff);
+}
+
 static uint64_t octeon_vmm0_zeroes_mpl1(void)
 {
     uint64_t rd;
@@ -355,6 +392,9 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
     assert(octeon_vmulu(5, 7, 11) == 46);
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);

-- 
2.54.0


