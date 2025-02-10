Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABCEC02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc7P-00026D-5s; Mon, 10 Feb 2025 17:19:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc79-0001hg-Gc
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:18:52 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc77-0002pO-EE
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:18:51 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dcb7122c1so2992944f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225927; x=1739830727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=verx53GTrTT7sD7mWRhDwPgxK/V6+ka4Dj5r4zGv8rc=;
 b=FD45hCCChnTWHaHseVR9p5vcGmvatxekjMWbl4vgRSa5qlxZtZ4JmIoBn0wHTkIGkV
 V63WFEMk7m3AphYWr7qIOqHDff2SSRv7be2WWYBdsHzseaviSaKT7BUf8or+MvbVN8ow
 DnP8sNOJ21zKhr+oAT0QaaG2hCHCu7sVYKSlzIQABv0CR1l4znljkhgemUMIYGX3nL7L
 Xb/gF9GL2FRgQOwCsuUhHbNYsM4W1a1L134mQbAZH3SSqRWKmHrh1+T+PYBnHyPvNFgV
 jzfcEMY2bysRrGUA+zZsPCqy7KwFzdUgxV2g1HaUHLy5Qw4QMMVoXJq0ZKO7bBNO5GBp
 hHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225927; x=1739830727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=verx53GTrTT7sD7mWRhDwPgxK/V6+ka4Dj5r4zGv8rc=;
 b=p58BBtsXzGp9VV6qKx88+CGjrapeHKUhIVErG+5DOxqX0pbJjp97HO2Cr2zrKEM3Cu
 WW34Wb5Tdg8HqjXuARQ6mqQIlLvOTETNFZ2QR2nyNfcc/ISuSA6iBp08xr6d/XgcAo9B
 4jsh631PP3yV039pyty0q6gJIYTIknD0kVNBvD3g6SbSPBI2G0E5IsQ1S3y0Dab9gogo
 0z3UG+h2TeM/I4pu8BEbUh/91L4tl4rsfchswdipJdpqmPjGhfTqHFsyHKsa4nAtVUaa
 F3am5H7lbt7bGzxcRGYdICpQ3o700e69ILOs4N8kANIPnYBJcjsi/wESrPSiWIANFqRa
 jhFQ==
X-Gm-Message-State: AOJu0YyRCQIDyDkTKUWA6kGjuTP9GGDG4iOhFt4MFCxGyZRo5+oCNlUI
 f7+NCpYscZeKdkJNOsvOHEImfjGTV14BMzLL7atKvWFIxayoP7umJjHs+VaxphLTPmBbZtyPkmw
 2YqM=
X-Gm-Gg: ASbGncvY1bqSmPuD0mdcgS0BW/GMl/dVPNVT1BP3CuwPiGltsclct2IBZna6conO5zJ
 nXv/MrCZtfuvBrIgHhTZCB9+nJCv63xsuvjn3y5TV2YTPjrwoT9GqAvQqsbtNGhIDrb2he9E3MT
 IG8VMnqfW2Gu33qasGwZCTpp0QAR2HHg44RDif+wFlm6DsLEOIU8L38pIxLY5cYRZhWQBDSu06/
 VMBg+tCVqOSXDK6T47PdQ+uUBYXhEW/TBv7ilrn+J9s+qQoNMG4YhWFh75dYjmEAiL+TmiMaylu
 cFQhIJ9h/SMTMEVgf6uN+w2DL1s/RZe7lyS/lag/xuIeABFgro3CCnb1S+TC2/k/Jw==
X-Google-Smtp-Source: AGHT+IEzZ1+q8KD5AAig4JPSHiADGHQUs1Zn0JZEx0tNonuH9I2EJA251/mOntXjvnaOXuvQCyNnHw==
X-Received: by 2002:a5d:648f:0:b0:38d:cf33:31a1 with SMTP id
 ffacd0b85a97d-38dcf333704mr10350016f8f.23.1739225927584; 
 Mon, 10 Feb 2025 14:18:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc17e278bsm12408209f8f.48.2025.02.10.14.18.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 14:18:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/10] target/arm: Set disassemble_info::endian value in
 disas_set_info()
Date: Mon, 10 Feb 2025 23:18:23 +0100
Message-ID: <20250210221830.69129-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210221830.69129-1-philmd@linaro.org>
References: <20250210221830.69129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 94f1c55622b..68b3a9d3ab0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1188,7 +1188,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     ARMCPU *ac = ARM_CPU(cpu);
     CPUARMState *env = &ac->env;
-    bool sctlr_b;
+    bool sctlr_b = arm_sctlr_b(env);
 
     if (is_a64(env)) {
         info->cap_arch = CS_ARCH_ARM64;
@@ -1215,13 +1215,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
         info->cap_mode = cap_mode;
     }
 
-    sctlr_b = arm_sctlr_b(env);
+    info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-#if TARGET_BIG_ENDIAN
-        info->endian = BFD_ENDIAN_LITTLE;
-#else
-        info->endian = BFD_ENDIAN_BIG;
-#endif
+        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.1


