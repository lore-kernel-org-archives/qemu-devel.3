Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB748C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd0C-000206-Ri; Tue, 04 Mar 2025 19:52:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0B-0001zg-8T
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:47 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd09-0007SU-4X
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:52:46 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390dd3403fdso5286861f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135963; x=1741740763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gvg7bjz4W+7lzF+vO3juWf59GOeb1i4zphl0KgEd4ko=;
 b=msBVr5SB/ThYOS4z8boJRdNwBJaqE1SAnyDfcPoW9L2VYNLup0uVjupRsPKtUqfZCS
 pQ7EichT67ISxtQis61YNg0/MmUcvDzqHQAmw8xTrCVMVxjqKEJZDXhsD7gcF0DzJKOL
 Xx9E/Zoi2bC64PD/n//1G+xdJ1ABnMeCnyeNl4NCXDsSEFjrJVU28emWGWkODNoWVPZR
 3ZXUW7BzNAa83tAtrMhdSJzyCpE8R5l0XFjonOsp6kDDz6EEQi25Cj6TlcqJ9CCtHBF1
 kZYBOWw6SCjWF5V1/MJVxJxvYm4Q1h6vP//jrW4sNPCVYLRqq+c2CjA+pjUIG3HmC8d1
 Osvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135963; x=1741740763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gvg7bjz4W+7lzF+vO3juWf59GOeb1i4zphl0KgEd4ko=;
 b=YGD85/yiymqJphlNRYYUJ9Yd3tnbfFTqbiqH11cVWefaZom4B6xTtGgJjhQ/CW7U7L
 d4fMHBAFtzNL93iV8YzoEv0p8FMadcmx7ee3KGIg1v+MCBjxeEEteUDKyGNXlIVoLDvH
 E1qjVberorwA8ms+kFtSNY2ifvn8yRnfLa1i9YM10ZAHwqZ5ujdQ6EhHn37KNcLfRapQ
 mJ5zZK7Sv4Q16HjpLEQMLC504AOVWtx7NmloOKzJpS49A4K3e7djCtW+X9t9ic5lCESe
 H/HRl6iuU7n/ixtqrg0cH6papJsN0ReuRIXqCv6g++VJjUmaHQlROD1SaJUCBmEFAdw5
 od0A==
X-Gm-Message-State: AOJu0YxLQx7fkKP7I3ZOEZeveQ+/Ps/5Tns7rp88XUagy1jMHKy9WjEL
 qLmWAa98q3zSg7+EYom33vWsxX5U6bnT/OqnSqTKNfSmhoNmLFj3pprP74YJZZuqjJKu31uekmM
 gBPM=
X-Gm-Gg: ASbGncvSlq6jIzAd3QySub0uBrIH/t8mDMPnd/k32vXQxtgwgBddc15mGMn/nqiW5Ca
 aHLoQeS5KsbXHILTXgua9pdsgz3y8z2UvaI3cm70Kr2SucDiY4n3DvWRYIKPR4QIN8sjr/DRShG
 eeRIyas7b6m4bmlrp3g4eIJVorbIZnRaaT59pSDvOgsonss85zoxOvvUQnxQV/d6pyMSiVs/uyG
 f9DC61Jz2szdrtFqWKzL2zDbYTaRAZB+j993jBaUQ8GinNXanhkhd4IT3UMspUCWdh6e0quuAUc
 T8w6Uj3z2mZNqBS68P21bjqi8ZHtzNw1h/lUoj9S+cpp7ZwMiDYsCBDCPF8awBDufRlIr36rdHq
 qODfLt0wIZFqDMUJCLQY=
X-Google-Smtp-Source: AGHT+IHjU9RSQgn8/qnNnh/JVX6W+KNECJ40bx++dPyvd0u8d+AIzAL5WAYkiUmXC1KuhwQi+vQuyQ==
X-Received: by 2002:a5d:5886:0:b0:38f:2ddd:a1bb with SMTP id
 ffacd0b85a97d-3911f727557mr607055f8f.8.1741135963191; 
 Tue, 04 Mar 2025 16:52:43 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39122da6cb4sm37957f8f.72.2025.03.04.16.52.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:52:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 03/11] system: Introduce QemuArchBit enum
Date: Wed,  5 Mar 2025 01:52:17 +0100
Message-ID: <20250305005225.95051-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Declare QEMU_ARCH_BIT_$target as QemuArchBit enum.
Use them to declare QEMU_ARCH_$target bitmasks.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build                |  4 +--
 include/system/arch_init.h | 65 +++++++++++++++++++++++++-------------
 system/arch_init.c         |  2 +-
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/meson.build b/meson.build
index 0a2c61d2bfa..1ab02a5d48d 100644
--- a/meson.build
+++ b/meson.build
@@ -3357,8 +3357,8 @@ foreach target : target_dirs
       config_target_data.set(k, v)
     endif
   endforeach
-  config_target_data.set('QEMU_ARCH',
-                         'QEMU_ARCH_' + config_target['TARGET_BASE_ARCH'].to_upper())
+  config_target_data.set('QEMU_ARCH_BIT',
+                         'QEMU_ARCH_BIT_' + config_target['TARGET_BASE_ARCH'].to_upper())
   config_target_h += {target: configure_file(output: target + '-config-target.h',
                                                configuration: config_target_data)}
 
diff --git a/include/system/arch_init.h b/include/system/arch_init.h
index d8b77440487..06e5527ec88 100644
--- a/include/system/arch_init.h
+++ b/include/system/arch_init.h
@@ -1,29 +1,50 @@
 #ifndef QEMU_ARCH_INIT_H
 #define QEMU_ARCH_INIT_H
 
+#include "qemu/bitops.h"
 
-enum {
-    QEMU_ARCH_ALL = -1,
-    QEMU_ARCH_ALPHA = (1 << 0),
-    QEMU_ARCH_ARM = (1 << 1),
-    QEMU_ARCH_I386 = (1 << 3),
-    QEMU_ARCH_M68K = (1 << 4),
-    QEMU_ARCH_MICROBLAZE = (1 << 6),
-    QEMU_ARCH_MIPS = (1 << 7),
-    QEMU_ARCH_PPC = (1 << 8),
-    QEMU_ARCH_S390X = (1 << 9),
-    QEMU_ARCH_SH4 = (1 << 10),
-    QEMU_ARCH_SPARC = (1 << 11),
-    QEMU_ARCH_XTENSA = (1 << 12),
-    QEMU_ARCH_OPENRISC = (1 << 13),
-    QEMU_ARCH_TRICORE = (1 << 16),
-    QEMU_ARCH_HPPA = (1 << 18),
-    QEMU_ARCH_RISCV = (1 << 19),
-    QEMU_ARCH_RX = (1 << 20),
-    QEMU_ARCH_AVR = (1 << 21),
-    QEMU_ARCH_HEXAGON = (1 << 22),
-    QEMU_ARCH_LOONGARCH = (1 << 23),
-};
+typedef enum QemuArchBit {
+    QEMU_ARCH_BIT_ALPHA         = 0,
+    QEMU_ARCH_BIT_ARM           = 1,
+    QEMU_ARCH_BIT_I386          = 3,
+    QEMU_ARCH_BIT_M68K          = 4,
+    QEMU_ARCH_BIT_MICROBLAZE    = 6,
+    QEMU_ARCH_BIT_MIPS          = 7,
+    QEMU_ARCH_BIT_PPC           = 8,
+    QEMU_ARCH_BIT_S390X         = 9,
+    QEMU_ARCH_BIT_SH4           = 10,
+    QEMU_ARCH_BIT_SPARC         = 11,
+    QEMU_ARCH_BIT_XTENSA        = 12,
+    QEMU_ARCH_BIT_OPENRISC      = 13,
+    QEMU_ARCH_BIT_TRICORE       = 16,
+    QEMU_ARCH_BIT_HPPA          = 18,
+    QEMU_ARCH_BIT_RISCV         = 19,
+    QEMU_ARCH_BIT_RX            = 20,
+    QEMU_ARCH_BIT_AVR           = 21,
+    QEMU_ARCH_BIT_HEXAGON       = 22,
+    QEMU_ARCH_BIT_LOONGARCH     = 23,
+} QemuArchBit;
+
+#define QEMU_ARCH_ALPHA         BIT(QEMU_ARCH_BIT_ALPHA)
+#define QEMU_ARCH_ARM           BIT(QEMU_ARCH_BIT_ARM)
+#define QEMU_ARCH_I386          BIT(QEMU_ARCH_BIT_I386)
+#define QEMU_ARCH_M68K          BIT(QEMU_ARCH_BIT_M68K)
+#define QEMU_ARCH_MICROBLAZE    BIT(QEMU_ARCH_BIT_MICROBLAZE)
+#define QEMU_ARCH_MIPS          BIT(QEMU_ARCH_BIT_MIPS)
+#define QEMU_ARCH_PPC           BIT(QEMU_ARCH_BIT_PPC)
+#define QEMU_ARCH_S390X         BIT(QEMU_ARCH_BIT_S390X)
+#define QEMU_ARCH_SH4           BIT(QEMU_ARCH_BIT_SH4)
+#define QEMU_ARCH_SPARC         BIT(QEMU_ARCH_BIT_SPARC)
+#define QEMU_ARCH_XTENSA        BIT(QEMU_ARCH_BIT_XTENSA)
+#define QEMU_ARCH_OPENRISC      BIT(QEMU_ARCH_BIT_OPENRISC)
+#define QEMU_ARCH_TRICORE       BIT(QEMU_ARCH_BIT_TRICORE)
+#define QEMU_ARCH_HPPA          BIT(QEMU_ARCH_BIT_HPPA)
+#define QEMU_ARCH_RISCV         BIT(QEMU_ARCH_BIT_RISCV)
+#define QEMU_ARCH_RX            BIT(QEMU_ARCH_BIT_RX)
+#define QEMU_ARCH_AVR           BIT(QEMU_ARCH_BIT_AVR)
+#define QEMU_ARCH_HEXAGON       BIT(QEMU_ARCH_BIT_HEXAGON)
+#define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
+#define QEMU_ARCH_ALL           -1
 
 extern const uint32_t arch_type;
 
diff --git a/system/arch_init.c b/system/arch_init.c
index b9147af93cb..fedbb18e2cc 100644
--- a/system/arch_init.c
+++ b/system/arch_init.c
@@ -24,4 +24,4 @@
 #include "qemu/osdep.h"
 #include "system/arch_init.h"
 
-const uint32_t arch_type = QEMU_ARCH;
+const uint32_t arch_type = BIT(QEMU_ARCH_BIT);
-- 
2.47.1


