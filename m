Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF29C021B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 00:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpd0S-00022M-J7; Tue, 04 Mar 2025 19:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0Q-00022A-Ux
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:02 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpd0O-0007Uh-Us
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 19:53:02 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-390eebcc371so2710193f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 16:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741135979; x=1741740779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI7bGdusWwalQtQ/oihM/Pr8zgv/ivF1OVwRKsBRxKw=;
 b=g3whpSgMsjfDpFlmtAsVyRlysniRThxnmibzudnqjCWKjl1E5iFCW/ty37mXHiiXol
 hu6vog9URuJA8U6KdqasYWEET7zCsSRf6pUKFT3LnCBXI0OvoEJuMEvlhi3F6tt6Gsu9
 KuJiC0fV5q3Q0u2vhvFV0fJpJ2ZtE9nSaQfEXlpWvgohOXTnJqzbMs0PXkWUNXLj/VbC
 /6vGf1q8r/trHZ94M1N50UgiIuPd7u95alxDWeBXJ6tWazTGnFMYJcTdZwG22Y3AZ14L
 IJ5n+QkTk+Cz360OAOUCKa50IyC+CBzWSMZ+IXaet/FayLsbs5N1SvX6Lhmf2k2+ti1Q
 K5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741135979; x=1741740779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aI7bGdusWwalQtQ/oihM/Pr8zgv/ivF1OVwRKsBRxKw=;
 b=EJsxJpqeMiQT2q3oBkXOm41d3ZI0iu6PFY6Nao/Vrx8x7Wa6LNGSSB/VF6uCch4Ryq
 epfpDMFyK1KU7JWP8a4FW/PEF0CoPTWxG4HfDQBP8Eq1Q3YlUX0vJBUe1iw2H3u0l9jK
 ExXbvNKdQ8Auchmj3/zdAWw1fS6QaY/LrqLjEZ97GzVhhF8xUQOHeySQTXrCm9KmyRFR
 YDdKEajX2jV3IDadaJpG5JpdBxiHecBJ/7hhpuZmS08TAMkpHV9blJ3+/L0eAUkiUpZt
 CSLn4rtxmVkgfnxgEoh3Ok4SyWI3P6eE4r0YVkrwVf2DH0tZzLEePc5kULkTd9nN8jtC
 eT6w==
X-Gm-Message-State: AOJu0Ywg8w1n2Cimo61fYQ6qZ3cukyH6Lcfg0SXXuzSIsCdcfiQ70Wid
 UDDyThebxodO5T62a4zTr40kxCn6uJoqVSHNrbL5zH7hueS/weIznbCY3u6xwGkq1CCojqvY9bc
 dp1k=
X-Gm-Gg: ASbGnctMbkMx++0DE3RLniqMCE8UsbSPnubqso9jN3By6qb2aylaJpzHhJi5aBigCyq
 VTsFpZvo4uZZwFGv5synPaI/QwSkMxJlHH92/pIls6gs0sdMerlsNS6uAQe5QvN9zbUqEjJzhn7
 OqaKzx6VCAeS6AduaRA7vsQeYAHSOney2eOYdoqV6gTbACG/bzPirq7Av9yW80bdSWNARQW5aHW
 DlcMLVjc/e5kxLjX8EtF994EREKh3CJl4Xhk4c2zl/gdPtbCYfq1G14Vv4YSpv0gMwe5Cq2fu3w
 6TUVnINT0VfwAKAQ7O1SryaC/RaSWt5/4arJzTAAsufe1ftij690lUi4w4oQ0vB9eviuyIMlsn8
 IHatGGKkx0lfTrYPKNhg=
X-Google-Smtp-Source: AGHT+IHyudN3+aoLMMTl2NXHC5V5XiMCm46ELQZrXWSOxnMrXDJ0eiX43eqvnq0Af6uh3iIJFwywVw==
X-Received: by 2002:a05:6000:18a7:b0:38f:483f:8319 with SMTP id
 ffacd0b85a97d-3911f7c17f2mr662075f8f.51.1741135978743; 
 Tue, 04 Mar 2025 16:52:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42b7478sm1496035e9.17.2025.03.04.16.52.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 16:52:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 06/11] include: Declare target_name() in common
 "qemu/arch_info.h"
Date: Wed,  5 Mar 2025 01:52:20 +0100
Message-ID: <20250305005225.95051-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305005225.95051-1-philmd@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

No need to include the huge "hw/core/cpu.h" header to
get a simple prototype declaration such target_name().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h      | 2 --
 include/qemu/arch_info.h   | 2 ++
 arch_info-target.c         | 5 +++++
 cpu-target.c               | 5 -----
 hw/core/machine-qmp-cmds.c | 1 +
 system/vl.c                | 1 -
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556a..4f538a8f96d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1162,8 +1162,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-const char *target_name(void);
-
 #ifdef COMPILING_PER_TARGET
 
 #ifndef CONFIG_USER_ONLY
diff --git a/include/qemu/arch_info.h b/include/qemu/arch_info.h
index 3cb95926e27..613dc2037db 100644
--- a/include/qemu/arch_info.h
+++ b/include/qemu/arch_info.h
@@ -46,6 +46,8 @@ typedef enum QemuArchBit {
 #define QEMU_ARCH_LOONGARCH     BIT(QEMU_ARCH_BIT_LOONGARCH)
 #define QEMU_ARCH_ALL           -1
 
+const char *target_name(void);
+
 bool qemu_arch_available(unsigned qemu_arch_mask);
 
 #endif
diff --git a/arch_info-target.c b/arch_info-target.c
index 6c11c73feb9..61007415b30 100644
--- a/arch_info-target.c
+++ b/arch_info-target.c
@@ -24,6 +24,11 @@
 #include "qemu/osdep.h"
 #include "qemu/arch_info.h"
 
+const char *target_name(void)
+{
+    return TARGET_NAME;
+}
+
 bool qemu_arch_available(unsigned qemu_arch_mask)
 {
     return qemu_arch_mask & BIT(QEMU_ARCH_BIT);
diff --git a/cpu-target.c b/cpu-target.c
index f7e17a650c0..1177e93c444 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -158,8 +158,3 @@ bool target_words_bigendian(void)
 {
     return TARGET_BIG_ENDIAN;
 }
-
-const char *target_name(void)
-{
-    return TARGET_NAME;
-}
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3130c5cd456..3bf280cef16 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,6 +19,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
+#include "qemu/arch_info.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
diff --git a/system/vl.c b/system/vl.c
index e96c72e5400..a41ba4a2d5f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -80,7 +80,6 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
-#include "hw/core/cpu.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
-- 
2.47.1


