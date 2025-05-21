Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC293C54ED1
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4T-000686-99; Wed, 21 May 2025 18:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4Q-00067g-U9
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4N-0005YD-D9
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:37:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2321c38a948so49244645ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867066; x=1748471866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0N4C9DptqevA9wK4usU3+DxvuKBaI+3ZGbXSlc09sfk=;
 b=WRvrlvHiYR7GGyvZJ2178TgaUvL4jPeHuF6VKRidhDOacr1FSGL67GE8w/sQFqZsaD
 xAJgaT0+7drAm5s6zyqwLFIrmkaFk0STFu2jcfSAYIFjolG4PiBbCknEna60xSj54XTe
 HN+isXia/9JPg1qHtqDPV/MtqxexuEaj3nPMymY7fEeI2iMaLbVW5RGt8WMREhmp00l2
 4YqLD/0S2Y+0gchjy3gTjWe9d2j6lOniHwx6OBt+YupRRwQOI3R+nbrdcl/PIjpECk6o
 skwZ82lyrvG3XfBMDU8Y9dphS9VuSar+PmF8+jYDET5QQXPxDgLZxURN5WzGT3zWKixC
 zUGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867066; x=1748471866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0N4C9DptqevA9wK4usU3+DxvuKBaI+3ZGbXSlc09sfk=;
 b=G7xaoL1qvj5zCjAx58zqNyw2Pz8zYMdjcy6/2IyysEQzjTaST6L0PMEbCrrR6mPLOu
 kWOd+29P9in29y1A56Lm3w8jV7x6+W6LCe9lF73kKpXQ6yX1zO87ZLDaTTgSQnzm5jti
 /qpm4b1RAj2JgZe/HrGPX0oEU7b+tpbBcFplp6VXE/ttvZu8mPbvJsPPSDf53/1NIu+f
 s1DnYLWKWzNqa5xaE45OrdnwSNSY46yLss49ER+kMZPFvj6awAVsPLOVw+T/l61wREUj
 bs+FpSEOz3oZbU/PSe+lBNV+YBHu3g69LZLutO5yPKNQiad12emJG0ocHDKI3bPDFeBN
 y45A==
X-Gm-Message-State: AOJu0YxFfY3T16N3gxF2rRyibQ4gEG2gScwwkBjt1Bar5LqyJbAkgA59
 WA/ZBu2nDSo4XqRsqwOxGwMWR71/vPVkOsqG4e/e4wMgOBmaE+LyzSU9oSeTe7hlR4CI0+AAIRh
 Gc4RJ
X-Gm-Gg: ASbGncvgQZzaHZ0QrqTBHa1u7Qc2i4kaF4BVKSH+MKlkToUz87zjzDyxVaQPOD3scth
 5tCgvkRMvuM+dpUhahOvZ0Foo7IMjX5eDv5eSi7hlPNRiPlDezpWqtifoa+huL2TPn2n8S4REnb
 8/zmbUo92aGjf+6kX37ja/BztFXmRpMWv34hi07btshUVkKczgPxyq9untItfqHJkpSYLBhBa8i
 nbJ/8XCcp9uClA7s5/Lj3U6qpFvA1ijOvogq7kwRbQRY5AnlHbwT5kWx2feRt+E35/pw/H/rAp+
 eq7pu93mn9IewyqCRCFbh1tsuE6f8YkEI8URbmtlx2q0OmGjBrg=
X-Google-Smtp-Source: AGHT+IG6TLxm7U5Fef4R0jF2GtqE94xid0h71JYx4EltdZ43DutkU8xT2Y0c+A94xV56oGaNnV4tgA==
X-Received: by 2002:a17:902:e846:b0:22e:4586:e33f with SMTP id
 d9443c01a7336-231de3bb190mr305305035ad.45.1747867065993; 
 Wed, 21 May 2025 15:37:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com
Subject: [PATCH v3 01/14] qapi: expose rtc-reset-reinjection command
 unconditionally
Date: Wed, 21 May 2025 15:37:27 -0700
Message-ID: <20250521223740.249720-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes the TARGET_I386 condition from the rtc-reset-reinjection
command. This requires providing a QMP command stub for non-i386 target.
This in turn requires moving the command out of misc-target.json, since
that will trigger symbol poisoning errors when built from target
independent code.

Rather than putting the command into misc.json, it is proposed to create
misc-$TARGET.json files to hold commands whose impl is conceptually
only applicable to a single target. This gives an obvious docs hint to
consumers that the command is only useful in relation a specific target,
while misc.json is for commands applicable to 2 or more targets.

The current impl of qmp_rtc_reset_reinject() is a no-op if the i386
RTC is disabled in Kconfig, or if the running machine type lack any
RTC device.

The stub impl for non-i386 targets retains this no-op behaviour.
However, it is now reporting an Error mentioning this command is not
available for current target.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json      | 24 ++++++++++++++++++++++++
 qapi/misc-target.json    | 17 -----------------
 qapi/qapi-schema.json    |  1 +
 hw/i386/monitor.c        |  2 +-
 stubs/monitor-i386-rtc.c | 12 ++++++++++++
 qapi/meson.build         |  1 +
 stubs/meson.build        |  1 +
 7 files changed, 40 insertions(+), 18 deletions(-)
 create mode 100644 qapi/misc-i386.json
 create mode 100644 stubs/monitor-i386-rtc.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
new file mode 100644
index 00000000000..d5bfd91405e
--- /dev/null
+++ b/qapi/misc-i386.json
@@ -0,0 +1,24 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+##
+# @rtc-reset-reinjection:
+#
+# This command will reset the RTC interrupt reinjection backlog.  Can
+# be used if another mechanism to synchronize guest time is in effect,
+# for example QEMU guest agent's guest-set-time command.
+#
+# Use of this command is only applicable for x86 machines with an RTC,
+# and on other machines will silently return without performing any
+# action.
+#
+# Since: 2.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "rtc-reset-reinjection" }
+#     <- { "return": {} }
+##
+{ 'command': 'rtc-reset-reinjection' }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index f7ec695caad..c5f9f6be7e1 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,23 +2,6 @@
 # vim: filetype=python
 #
 
-##
-# @rtc-reset-reinjection:
-#
-# This command will reset the RTC interrupt reinjection backlog.  Can
-# be used if another mechanism to synchronize guest time is in effect,
-# for example QEMU guest agent's guest-set-time command.
-#
-# Since: 2.1
-#
-# .. qmp-example::
-#
-#     -> { "execute": "rtc-reset-reinjection" }
-#     <- { "return": {} }
-##
-{ 'command': 'rtc-reset-reinjection',
-  'if': 'TARGET_I386' }
-
 ##
 # @SevState:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 7bc600bb768..96f6aa44133 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -61,6 +61,7 @@
 { 'include': 'replay.json' }
 { 'include': 'yank.json' }
 { 'include': 'misc.json' }
+{ 'include': 'misc-i386.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
 { 'include': 'acpi.json' }
diff --git a/hw/i386/monitor.c b/hw/i386/monitor.c
index 1921e4d52e9..79df96562f6 100644
--- a/hw/i386/monitor.c
+++ b/hw/i386/monitor.c
@@ -26,7 +26,7 @@
 #include "monitor/monitor.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "hw/i386/x86.h"
 #include "hw/rtc/mc146818rtc.h"
 
diff --git a/stubs/monitor-i386-rtc.c b/stubs/monitor-i386-rtc.c
new file mode 100644
index 00000000000..8420d7c93c2
--- /dev/null
+++ b/stubs/monitor-i386-rtc.c
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    error_setg(errp,
+               "RTC interrupt reinjection backlog reset is not available for"
+               "this machine");
+}
diff --git a/qapi/meson.build b/qapi/meson.build
index eadde4db307..3a9bd061047 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -64,6 +64,7 @@ if have_system
     'qdev',
     'pci',
     'rocker',
+    'misc-i386',
     'tpm',
     'uefi',
   ]
diff --git a/stubs/meson.build b/stubs/meson.build
index 63392f5e785..9907b54c1e6 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -77,6 +77,7 @@ if have_system
   stub_ss.add(files('target-monitor-defs.c'))
   stub_ss.add(files('win32-kbd-hook.c'))
   stub_ss.add(files('xen-hw-stub.c'))
+  stub_ss.add(files('monitor-i386-rtc.c'))
 endif
 
 if have_system or have_user
-- 
2.47.2


