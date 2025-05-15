Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8D4C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcN0-00080C-BJ; Thu, 15 May 2025 13:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcMx-0007rR-VL
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:44 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcMv-00023W-QJ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:43 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7426159273fso1401123b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330060; x=1747934860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n2kksRWF5uMfLBl5C93UC3KpDnUA54+ae7RH/Q2zvUg=;
 b=emgyDLkvLDOwPVMrWYu4P8R8/FyzN6eDNrMgg28nGXVkRUC9WlqafERkCmEI1EHC1E
 QyFH4mbEY5Qqn1gcaV6flf8TwVfYOYQ0u6yrKRbS5f+OsLJwaTJGrsSeit3LtUvz/7BM
 wn6AqECdw3sbID4bCNdInqCD0NnooY87D1eSUEKyGnHoZyXpeYR1DLObuj7B78fDN+uH
 T2iY4FcjumbRruyBVcHcjreh6QAmFhvK5P6mjcMpTDuI06XJgfx06nhi5fnV9vrHTIw1
 xc5XNbphY0Kp6wz0doWG1JZMuOL6MYOIpX3rgvg7q1crIj3JHay799v9giyXX335hCWA
 7Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330060; x=1747934860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n2kksRWF5uMfLBl5C93UC3KpDnUA54+ae7RH/Q2zvUg=;
 b=xSIkNo+tEIHJYkjIJUN6t3b0sLY/33G96MdY1bq/eQWiAB4P1ujGsYvNQ6mcd/Z7Hf
 +gP1Xn6bz4bXwlbQEMCXPq/qTf5LwcKqzXl8Gu9ImBMp3eB6dSYJdOifFOJpxuPGBDku
 pn1ME15ga20tlzO6cXXYJYNpy4x+BbVdNMCinP3l8xz61IWyjEU+GNcTemgdc/3ob3Je
 ZYvz9eIdASjgzppX9kw3FhpaPT98zLw0t84Cv9VSRqTpMi4B8C1ZeBHyKlRer6jZHmCI
 BvDjmczBeU6ixEaqJw8k6/klM1Jk+qTfF3nBAH2kKKbTk5Y8yVsQbz2nINds8VX+UkA/
 /UrA==
X-Gm-Message-State: AOJu0YxCd3DsMe4+K6v7WR+pNWtxR7YK39tMQoGOapeX6fVESbqGPWHi
 DvuRS18zYlMprOjz8Rw4pZ1/pNq7SwRfJxYlEFoUATa0fBdgZbnMQcRN2IEEm+x0sWxzt9F99Sf
 QWr+2
X-Gm-Gg: ASbGncv6ms5H+bF70HWv/2hMufYPuAl+Q458PIKUIfMigbuqE7nH856LmhmqrAUsenI
 9wa+SNj1l7Yxpd5tgOrSXRV02h6KXb+Wn8ohftct2oSe8T8gpQhfAzFpEOg+hpNmOlWVmO8avp/
 dwjZ/phpjpAQlwA+q/UYYCOEIDrhgiYSwCQ/iaiuP9CgIVIinFag1ukw5w6pxMuVDzbAoMB21BY
 fKc18TvjUFPHfQn7E5+psx1XWrK2ZRdvjjDnU4BizsD3n5b76zOyWDnmg/cYUw03vbZAp3oVZYl
 f0ib0nRGSYbI+3KM42XOZdX65hQ+Db7HsPDlOVKmprsaS5YEs3+hWq4/GrZt8g==
X-Google-Smtp-Source: AGHT+IF0LBYBfzQB+zOA33MPQ0a0eP3k6cQ7jJbZscSJ69xaeCUXg/lvAZ5b20pQ8nI1t81bCq07FQ==
X-Received: by 2002:a05:6a00:1495:b0:736:ff65:3fcc with SMTP id
 d2e1a72fcca58-742a98ab432mr269829b3a.16.1747330060278; 
 Thu, 15 May 2025 10:27:40 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 01/12] qapi: expose rtc-reset-reinjection command
 unconditionally
Date: Thu, 15 May 2025 10:27:21 -0700
Message-ID: <20250515172732.3992504-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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
 stubs/monitor-i386-rtc.c | 11 +++++++++++
 qapi/meson.build         |  1 +
 stubs/meson.build        |  1 +
 7 files changed, 39 insertions(+), 18 deletions(-)
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
index 42e4a7417dc..5d0ffb0164f 100644
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
index 00000000000..d810f33efec
--- /dev/null
+++ b/stubs/monitor-i386-rtc.c
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+void qmp_rtc_reset_reinjection(Error **errp)
+{
+    error_setg(errp,
+               "rtc-reset-injection is only available for x86 machines with RTC");
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


