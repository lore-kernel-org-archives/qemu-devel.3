Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF332C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvguy-0008BH-Dp; Fri, 21 Mar 2025 14:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvguu-0008B0-VQ
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:24 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvgut-0000xY-54
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:16:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso16155875e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580981; x=1743185781; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvlc/05Bc6G7gWkNJ4vtmciJR0DqTH/VV0mlV1pn8BA=;
 b=GnqiYfL0Ge1GCLzytnD77lErCcAzKuQl3zC/OZ06B65LS1kcTlMBJnm2hxEThEU5Og
 b1R/x0l6YXVIrD1q3Nw4TlKVyCgqgY3LPFsuTHgYiC7X4vpy5gvuZqv1evMY3KB4bAkg
 r0fTzSXpd92BFH4RdBV/1JcvnQrblSnfCCrTHm2BL4WgqBD+UQ+twRRMFgWuwdljgAil
 2sTzjmzxyjUKo6rRvrrDW0ukmU5aVzt7adSGku3L3UUPq12786Wo13b6AtniAIgpaUo7
 asX2fgA5fpULj1RYpBucwgzIhbDUlV6i9LqZWjFNF3MFHa140WL540d/CYHu13hbVCbJ
 JsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580981; x=1743185781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvlc/05Bc6G7gWkNJ4vtmciJR0DqTH/VV0mlV1pn8BA=;
 b=jm2N+22+s2in/f6FrMFRTmL8GnoeLij8n+kfHlDvVDABUgSVqL1g6k4jClmXKu1A+Q
 LZnLzyJBzZQQzwdtNWjbNeJpA+J74eV72l9ebRor5MIBzGsZtFYRGIe9jKVIYtbBm74d
 5bOTbmKDCdph+cfXZaWPGtYUihW+CMwczrlCr17Uuu7a8lE3iWlIqUrEGNb5iW7yJiT4
 wWfFroiUuEW4oNjQYU2iZtcuI5tZm1zmLBR2GuAsg9C0B/GwRqqt4H9Y5eofvoUIRNMU
 aQgBQQ64t5kbei18s6Ejguxvu02eZ78pj7GWjBB3xzKqXsg7L/5qbpkvolLMZOlgJvwE
 O6Ow==
X-Gm-Message-State: AOJu0YxcWV4ASmOPCJNK3z+tQ7vo/DQbS+qbOYV4itRXE3N05CJ4Vy+v
 DQjTld4oNJnK/1S2zO+yX6ZVlPDrzUGhsGa3C0QTlF/HCVDyPysI60C4OFqyQHTezSaEb3hzP/w
 B
X-Gm-Gg: ASbGncv3CxtNgD9RonTb0Nvg8e0SRC/GxBxTC5J+MR+HJvjtH8Y8kuOmCUn615/MJ2A
 q91rw/B9/rg0f5A8tkT2/WGoqpJ5JzRyaPK3aUZ/icHkB38Jde2ggiSWH7i/Bsjs/pLnaG76vBI
 FSsMotl/eKRO+kXh93UL72Z6kpE5uJHZGQRnLLxLUM3a/IT3faWjNQf6g6yXLrokkqGh6I2MDYs
 jG2XohG7fWw5brbJ3x2xHnFufPBf5Mvf3d6FciZCioQeJ6Fkh1m3u9p7DSBNa+uXLRW93I8hv2P
 cF+/YNo735J8VsUYVyXV/rcJgSrKfruHNBn0bH0Sez4ayw4+2YJevGD3DINI+fS3CQi7kYokcZE
 tYa/kSAdT/H20o70cl7YHUk0Qp9vGTw==
X-Google-Smtp-Source: AGHT+IE0IuANSIGEO0KqwlFBkvczgYUzqAYPTi0Fu5DsANWa7xlJv/HV1EkRdq3cC6OYk7Z7mCPK9A==
X-Received: by 2002:a05:600c:83c4:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-43d509ec52fmr39394605e9.8.1742580981304; 
 Fri, 21 Mar 2025 11:16:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fcea6ecsm33815125e9.5.2025.03.21.11.16.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Mar 2025 11:16:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-10.1 v2 6/7] tcg: Have tcg_req_mo() use
 TCGCPUOps::guest_default_memory_order
Date: Fri, 21 Mar 2025 19:15:48 +0100
Message-ID: <20250321181549.3331-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250321181549.3331-1-philmd@linaro.org>
References: <20250321181549.3331-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

In order to use TCG with multiple targets, replace the
compile time use of TCG_GUEST_DEFAULT_MO by a runtime access
to TCGCPUOps::guest_default_memory_order via CPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal-target.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 992362be7e6..d5b8c4b730b 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -44,16 +44,15 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 
 /**
  * tcg_req_mo:
+ * @guest_mo: Guest default memory order
  * @type: TCGBar
  *
  * Filter @type to the barrier that is required for the guest
  * memory ordering vs the host memory ordering.  A non-zero
  * result indicates that some barrier is required.
- *
- * This is a macro so that it's constant even without optimization.
  */
-#define tcg_req_mo(type) \
-    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
+#define tcg_req_mo(guest_mo, type) \
+    ((type) & guest_mo & ~TCG_TARGET_DEFAULT_MO)
 
 /**
  * cpu_req_mo:
@@ -65,7 +64,7 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
  */
 #define cpu_req_mo(cpu, type)     \
     do {                          \
-        if (tcg_req_mo(type)) {   \
+        if (tcg_req_mo(cpu->cc->tcg_ops->guest_default_memory_order, type)) { \
             smp_mb();             \
         }                         \
     } while (0)
-- 
2.47.1


