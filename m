Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3943C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDVs-00051n-NF; Thu, 06 Mar 2025 10:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUX-00043p-CH
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:35 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUV-0006ho-0I
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bbb440520so9749635e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276229; x=1741881029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1WCMtYnB/Q/FPr4quB+y9Nf8Ulz7xJ98JX+NEB2sY0o=;
 b=XmbW7AgOzkAEZz5a1fjCsUf6f+nF4FESBHMI09NRgiFLeOB2S0c93EIMcTtXbsexPg
 f50qJDADyIPlMNDvLBO6xA+c59axKIR5MPreS+sRZ+Gr6qjbPa4U1k1P0Wo4oG3mM+Rx
 xC3uAfoVlcvVxIxJ5pv/fMMhUsPFTkeH5Kbh/45EjhAXZa+t5KPKOnHM2jWJLgJNpJz6
 lL4KhBnZaPEerO8sg3IFmiYrAmEs1d/7BPyBOAuZSNHMccTRiyXG5TIwY/zxJuPaFddP
 3vCA/B/8eH4rpl7by7PRBy52NxFtZH7f+cyC1PRdU9Z5NKKHRTuXHeKd/1hIA8/kaLXp
 Ss7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276229; x=1741881029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WCMtYnB/Q/FPr4quB+y9Nf8Ulz7xJ98JX+NEB2sY0o=;
 b=UO6+jsP7dvZ5Zm282rFoM2NwCHzClCSf7fROiFxj0+oZ4qUoPmKEcOGtK/sPQyi1Ds
 O+S6QsDs4W7SpnuDNXIqZw6/Wvj9fb4BRnuFShBp13FlRe41pKe10yZvq5k7JO45zzjR
 kv4Q53yvP+f3yE48X4R6mMfKJfl8hI9+7aLABOApfaldidg7NnKx83St8QhTw8Btp64n
 DaLFrHDBFJ9A/caMInedKrXLF1xNgMITdWJqNcemw6mCyaTzdpOJTWWQ43Y/kTEmAxCh
 k5sB42riU3D9mT8to8xM20cGS0zF8RNyep8Vm28dF4gD+8JL7iT03ykQQitPZdkmCTJv
 tPxw==
X-Gm-Message-State: AOJu0Yx8YgJib0yp0ZhzX5Q15pOXErR3zIDhcoMrM8XEBtgSyk8ZpBQC
 +gxpOan8DcsshTMpEbyubfmF2wtzqi3dBL5A/Ij6W6JguuK+KjecLy8dhD/Fs5Rijvx6M32rfpS
 zlbI=
X-Gm-Gg: ASbGncsbrT/oNjXxpjrV4hVsYEjlHBSLUl5BF2Gwl3jrAJf6vEfXcEnwx5QfIlGgpOW
 vMlLeqww0tDJ2XzBZ+CsLzNo7u8NoMG+5Ngpms+E4Qz3lOxKTBacZxahPLv2cdx/s8qvVZWh2eu
 il/lCSASWPqRY94gQsG/8Np/EqGm3RyrDrlPnG/5HXdOpA4M803Gs8GSlBNYL3SuZHu3ejvkxq9
 A3cb46lAp/ew5CLhfeicn5vNCasBTCGHac56XUJQDcGWE15Jo4TJY6uufGO0Na7OLQ5GkP+6GPQ
 1UQJHyB2/QfNfVcqI/ZlRojdE5WZplrkoB7Xw2yvMQvl0wj6pqHS5IrxLrScnYHl8aS32PmWci8
 Rf22KxPDzarzSFwmJ/P0=
X-Google-Smtp-Source: AGHT+IGkDbcVHf3B9eL8q6jL42T2q+4DkUCpBOGSOBuP2C8/ANLvBmK75fbj3N4OUQ/rHXD6mT1qOw==
X-Received: by 2002:a05:6000:18a6:b0:390:f0f3:138a with SMTP id
 ffacd0b85a97d-3911f757382mr8911760f8f.27.1741276229176; 
 Thu, 06 Mar 2025 07:50:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4292b06sm53471455e9.14.2025.03.06.07.50.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/54] target/arm: Set disassemble_info::endian value in
 disas_set_info()
Date: Thu,  6 Mar 2025 16:47:20 +0100
Message-ID: <20250306154737.70886-39-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-4-philmd@linaro.org>
---
 target/arm/cpu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ac1ceec2110..948defa3f5d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1171,7 +1171,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     ARMCPU *ac = ARM_CPU(cpu);
     CPUARMState *env = &ac->env;
-    bool sctlr_b;
+    bool sctlr_b = arm_sctlr_b(env);
 
     if (is_a64(env)) {
         info->cap_arch = CS_ARCH_ARM64;
@@ -1198,13 +1198,9 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
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


