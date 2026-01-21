Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C365CC44506
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 21:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigC9-0003rL-0M; Wed, 21 Jan 2026 16:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vigBy-0003mq-9P
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:56:51 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vigBu-0002km-TS
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 16:56:44 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47f3b7ef761so2407085e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 13:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769032600; x=1769637400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LX21BujlgqLNegaCHJq4WH7F5LCMmLxyoxIgzdMruqg=;
 b=LKQ8DsP70qBnkUUSELtl41pxTFdpdIMzIT2SIU94st7615Ig8VBLtFoLmlT+4iCqwP
 udrTfJWYpv3+sWcSPNhJnNm2RH0cO1OatH1zq2z8zXWk5S+Nub4c6Ke7g+QsSO+CtxKj
 pGkaQ+PDUFWa36DFYWgMRRHxHpVpfVvFDyGJ3y2+fZJmnRfisuvNjwFwUswERTGKoYxU
 cswPMFxzJoeH8YpkkmsfAEfuGiXQbgq130gE9vcN0ZC1eRkW7DfOOGPolCVy8qYbFBEo
 NL9T3CNaEOOJ+kISD3v0EASPq8ZVgPdLTgXU39480oQmbXQwEeDqdFLMWHrktmRGXi8R
 Zn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769032600; x=1769637400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LX21BujlgqLNegaCHJq4WH7F5LCMmLxyoxIgzdMruqg=;
 b=d4612XA55CAEiFFjsnHj73KS6oMtbMeQpiKo1oQy3+oaB5B3WaVYyPTLtdGbYeBQiE
 FmLEQxwdpRoWPNIjxHfIJF6Rjxm17TjDeKv+VUjLNA8qxL9tlcx+JLv3xHja8AmXFUNS
 E6ozZ5DKj9BMdZ393TlfMulcFtEi4tMaKaVEu/s8/zpiHMBvUz+a1wjqN3rdIHv6E6T2
 8YM7CKzw1qz93S/F209dP/W9R9CENIo6MurPrbkfppGXrfZMrnT4ujn5VxTbAT3Aqu32
 D5CjNe6wB5ZlYjwm3QNc2LAFuupk12j4c9UfBJf+lxZZWySuUGgeWbaqhWzHW4FdzYGB
 xCIA==
X-Gm-Message-State: AOJu0Yx/CGJSHf9cF6TDkgWlhavKCFSefHal7VbyjkGc617F7n/tU9r8
 S/ZuzYxDktdlg7sE23eZQZigp2uCQ0jGOlBaZznjowMOe5I4ARhu6rxG3lZ+6cFMtP/1TlRKiGY
 LV+t0gYU=
X-Gm-Gg: AZuq6aI0Io7YakmzSklSVXV432LEnQa5SMfcHk836YppKGlCmnDmhE5RbPSFBXeV2sm
 bCeGdxgLyjy/ln0JK4CFc8dnDCZ/QTnFX/e83t7vGgKl08bTHnLMg/zWnYr9LNuWa8YtTLxwVAa
 lgZS5O+vMHPwCaj9vF3+ojHFdL4d/JATAdND+9ud6gXzZScy0YCdFO4d2IgVBuvy7y2wJTcOV1x
 rFBO9Io1lrAYhSDbWNwHgWhowQ/U3OX4AxLTJahGueGdCiROVRU8Ykv4lWHg6M46GQa4idH3PG1
 pJ+0c76Sq8+cOIi+y15J0Yw17EKTyzw6wq+CpYPlwjrr+CoCpGC/WZB6pCCEGejmOmGEsxI/lGB
 SoIhbr0hGA13MhYmIxHhQgK1VZy7L/T2U5tSzc0a18g8/DTeSLXA9Kurx4otb6EWcfGVO25nGoF
 56iD7Qn1S/aK3O745GemhtxJtk42L+YYFjbOV3VK0dnryeasGUAtIlt6gDvshGeZ7D+J3LMac=
X-Received: by 2002:a05:600c:34c8:b0:47d:8479:78d5 with SMTP id
 5b1f17b1804b1-4803e79b7a0mr105454265e9.7.1769032599998; 
 Wed, 21 Jan 2026 13:56:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cf1acsm16356705e9.14.2026.01.21.13.56.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Jan 2026 13:56:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/2] dump: Build stubs once for non-x86 targets
Date: Wed, 21 Jan 2026 22:56:22 +0100
Message-ID: <20260121215622.92966-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121215622.92966-1-philmd@linaro.org>
References: <20260121215622.92966-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Rather than compiling the same content for all targets (unused
most of the time, i.e. qemu-system-avr ...), extract the non
x86 specific parts to a stub file and build it once for all
non-x86 targets.

Add a Kconfig symbol to only select the target-specific file
with the x86 target (rename this file with '-x86' suffix).

Since Kconfig symbols aren't evaluated for user emulation,
the file unit is only built for system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260108161220.15146-5-philmd@linaro.org>
---
 dump/win_dump-stubs.c               | 21 +++++++++++++++++++++
 dump/{win_dump.c => win_dump-x86.c} | 20 +-------------------
 Kconfig                             |  1 +
 dump/Kconfig                        |  4 ++++
 dump/meson.build                    |  3 ++-
 5 files changed, 29 insertions(+), 20 deletions(-)
 create mode 100644 dump/win_dump-stubs.c
 rename dump/{win_dump.c => win_dump-x86.c} (97%)
 create mode 100644 dump/Kconfig

diff --git a/dump/win_dump-stubs.c b/dump/win_dump-stubs.c
new file mode 100644
index 00000000000..96c1095c4e1
--- /dev/null
+++ b/dump/win_dump-stubs.c
@@ -0,0 +1,21 @@
+/*
+ * Windows crashdump stubs
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "win_dump.h"
+
+bool win_dump_available(Error **errp)
+{
+    error_setg(errp, "x86-64 Windows guest dump not built-in");
+
+    return false;
+}
+
+void create_win_dump(DumpState *s, Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/dump/win_dump.c b/dump/win_dump-x86.c
similarity index 97%
rename from dump/win_dump.c
rename to dump/win_dump-x86.c
index 6e07913dfb4..d893dea7f19 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump-x86.c
@@ -1,5 +1,5 @@
 /*
- * Windows crashdump (target specific implementations)
+ * Windows crashdump (x86 specific implementations)
  *
  * Copyright (c) 2018 Virtuozzo International GmbH
  *
@@ -18,8 +18,6 @@
 #include "win_dump.h"
 #include "cpu.h"
 
-#if defined(TARGET_X86_64)
-
 bool win_dump_available(Error **errp)
 {
     return true;
@@ -477,19 +475,3 @@ out_free:
 out_cr3:
     first_x86_cpu->env.cr[3] = saved_cr3;
 }
-
-#else /* !TARGET_X86_64 */
-
-bool win_dump_available(Error **errp)
-{
-    error_setg(errp, "Windows dump is only available for x86-64");
-
-    return false;
-}
-
-void create_win_dump(DumpState *s, Error **errp)
-{
-    g_assert_not_reached();
-}
-
-#endif
diff --git a/Kconfig b/Kconfig
index 63ca7f46df7..26388c12838 100644
--- a/Kconfig
+++ b/Kconfig
@@ -1,6 +1,7 @@
 source Kconfig.host
 source backends/Kconfig
 source accel/Kconfig
+source dump/Kconfig
 source target/Kconfig
 source hw/Kconfig
 source semihosting/Kconfig
diff --git a/dump/Kconfig b/dump/Kconfig
new file mode 100644
index 00000000000..cd6e8f2e137
--- /dev/null
+++ b/dump/Kconfig
@@ -0,0 +1,4 @@
+config WINDUMP
+    bool
+    default y if X86_64
+    depends on X86_64
diff --git a/dump/meson.build b/dump/meson.build
index 4277ce9328a..26e1561ed48 100644
--- a/dump/meson.build
+++ b/dump/meson.build
@@ -1,2 +1,3 @@
 system_ss.add([files('dump.c', 'dump-hmp-cmds.c'), snappy, lzo])
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: files('win_dump.c'))
+specific_ss.add(when: 'CONFIG_WINDUMP', if_true: files('win_dump-x86.c'))
+system_ss.add(when: 'CONFIG_WINDUMP', if_false: files('win_dump-stubs.c'))
-- 
2.52.0


