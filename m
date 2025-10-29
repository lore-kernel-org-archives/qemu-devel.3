Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2EFCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 22:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEEKr-0000Jk-CZ; Wed, 29 Oct 2025 18:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEKo-0000J5-3y
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:08:02 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEKa-00012a-Bt
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 18:08:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-474975af41dso2270445e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761775653; x=1762380453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnFZ8HbLjzhB7Z42tZa4PrSIDLq0WeA8PmYU1umg+/U=;
 b=DzlTKO5EyIewydKLE30BNstvhLLhSkov7EKvPsSLN9b5pBtoVXNIYeYhO+RLyJe7yQ
 fVVONgMdFq6FBFAXYUlNxw3b3vc5fui/xUH1nILdjOTuhUjQEi7857QZEPn/N1Hr4nRl
 11H7n/fvX/0JOeCOUNbDYI7oDXV3maa6AHs+gufgX1P+qI7uqb2HjjBQrIz5E37/Qick
 bb4/PYsR/iJdoDz6DXAR3QEGUFQ3zihLqC34cj4IqzwMUh1iJbvOKIex+lkT1e8lopjY
 pjIPzCLGoM+8DkQEiSe5uUXZKip3oufo6jLZXpcVCG3WGAFqf5gUbNw5UPcsIVA8kkQ9
 I+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761775653; x=1762380453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnFZ8HbLjzhB7Z42tZa4PrSIDLq0WeA8PmYU1umg+/U=;
 b=EN4kR2eEePMpcPJRt5R0PxF4dxKibFYVKzQzi5xGskxoDUnKKD24hOjUBfxoxGQYIt
 ulZBoYTsNL9XwS5uCDq/+DbXWOArm+U3r+tqWzIC2KBuuujUc4x4HCx4yqAUL0rJtEcK
 +uVeDtzi0ub72u4u1v/ZE7tDf/nmXlPVxMWmugMOfJgjwOfKIX/ZtDhfCBZWFiBAiMnC
 jzyJYrNW7248nwx1+B967U2KHYuaLg+wOLuBAHtDF3IlAPlb/nO8rGsAGZK1kKjowL8+
 XKdro0iKv9jdFXW/vPkWnIJ/TapDpEBanYa3MG98E7uFBBc/re2KleT+ehRb26b1dE1R
 +stg==
X-Gm-Message-State: AOJu0YxKKT3/u/jG3RnOD+LGP85SbfAvXErQg9hOD2faq0spfsS7Ae0f
 DnW21UoLFGgQzJeZ2kvwbmx04rEgSLoiQw8UYgcGNyZrOiPP53VOQ73EVuxOHhjyfaaH66ghITk
 MQwZdOOc=
X-Gm-Gg: ASbGncvAjcLCuu0mWBYFFBFPT7tlM/zSYZOfqJnpWuTg4Zwvd8k6AUbQSIyEteLGqDm
 AkMhMweNk02wwOHY1wPJeXjKB9bWdd0Tha1eIqzhsaCXfykObbGwnQTT/5MOaXPzJCosfHX7CF4
 B1Lu4Zc2lQH2YV/rp7yL7Zzj/LOQ/oTIbD175OpCSgGLQGX2GSEdykr6sQEIyHGOeL3l2K/sJYJ
 yneM9HB9GGZfM5CJCKDfCZOh49xyJx0LFqkCmeZ06uSEwB/48KZ3IzH9RQs1vH7y20QVLTTGdtD
 H255VOAwgcZPMPje3yTcabmvGhmp4q9hWsTCl1BnmIzVR9hS/x9xqMH5upIJrUAd2gDWIQvs3NF
 hSCWW3UU52WZ/8+PRZcvjtFMUFLpOPLDKumDQJaEagaV3qNuiI5smjdQqLu3bAe0/Szh9qwvrML
 KgfXKPpLLe06q1NLbxJZRUtrvG1GmBliMRf1q9mS2UjWURDJWl9g==
X-Google-Smtp-Source: AGHT+IGTUCvJg4EhDeIPRvsWLBe3ei0nncRNddGB/z3peEHm9UduFf3ev/3OBQpoDFo6/UIh/mDJOw==
X-Received: by 2002:a05:600c:c171:b0:45b:9a46:69e9 with SMTP id
 5b1f17b1804b1-477268487dbmr7732815e9.31.1761775653356; 
 Wed, 29 Oct 2025 15:07:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718fe63e0sm53515075e9.3.2025.10.29.15.07.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 15:07:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 23/23] hw/riscv: Replace target_ulong uses
Date: Wed, 29 Oct 2025 22:40:00 +0100
Message-ID: <20251029214001.99824-24-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-ID: <20251027-feature-single-binary-hw-v1-v2-2-44478d589ae9@rev.ng>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/riscv-iommu.c | 6 ++++--
 hw/riscv/riscv_hart.c  | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index b33c7fe3259..f8656ec04b1 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -26,6 +26,8 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "qemu/target-info.h"
+#include "qemu/bitops.h"
 
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
@@ -391,9 +393,9 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             const uint64_t va_mask = (1ULL << va_len) - 1;
 
             if (pass == S_STAGE && va_len > 32) {
-                target_ulong mask, masked_msbs;
+                uint64_t mask, masked_msbs;
 
-                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
+                mask = MAKE_64BIT_MASK(0, target_long_bits() - va_len + 1);
                 masked_msbs = (addr >> (va_len - 1)) & mask;
 
                 if (masked_msbs != 0 && masked_msbs != mask) {
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 4d51a93dd52..33cbc9873e6 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -94,7 +94,7 @@ static bool csr_qtest_callback(CharFrontend *chr, gchar **words)
         g_assert(rc == 0);
         csr_call(words[1], cpu, csr, &val);
 
-        qtest_sendf(chr, "OK 0 "TARGET_FMT_lx"\n", (target_ulong)val);
+        qtest_sendf(chr, "OK 0 %"PRIx64"\n", val);
 
         return true;
     }
-- 
2.51.0


