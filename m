Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5488CFF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH3l-00024k-44; Mon, 27 Apr 2026 04:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3k-00020J-2b
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:11:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH3i-0002zK-0F
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:11:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso140727325e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277472; x=1777882272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GHuhl7sujEeEFbAkpoWph1gRfoj+IqsXXghTjX/XrLM=;
 b=JBgiN6YSc2lA2swjk1/9oj8zGMHykEcAe6Y70XToWBThwTzG8Tem/4piornqViu/lV
 4aPpNZk/6LJePWK1ninZdYP8qkx1Y+IudMjVf+X5Ktw9zEEz4F5xR59rsUZN2HLfFQd/
 oT6LujYqBvqifx1QWjZTdX+A/f8p34t3Ng92OmI+dNkJffVDSFgmLzGrMjkGlqMmiknc
 Q50z+tBN4czhoP69fBq5skVUmBlSe6cVaVbsB3mPMl0fjoj9jPERzy3FHEFDgZ1ndqS3
 jBUGacu/ebXw4/crWKixmCNh8j5pb/R63E1/9IzcW6qJJ3ICHnGGHcpHr51JU6zYK1++
 2K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277472; x=1777882272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GHuhl7sujEeEFbAkpoWph1gRfoj+IqsXXghTjX/XrLM=;
 b=XfX9gk2QXkXYy7kQubIsgwV0T0YyZrVbQ3lmS78jOS95xwDwM/ZYz/MD2jsnCmRuIl
 /Yt07vMZj4VeDGaz3u/md1rW/JkGh/1WSLaiIaME/V4hHXhIRtd8ibhL9RJECixz/scz
 g7Lku7Ii5X6JWd1Gz2DTPjCs54jpmQ4axpoSct78VUHCTlZ1c9DZh4uU7+Og9nALeJ3n
 Ohp34zF31lIvGkOezdQa10NC6Z3ifTZfkfzwpJL2ZOJ5I0PrYxuCG3L2ckNEnUW+MgRA
 UPf4wpzpiM8uArQRhGI5BYCx8uLKIo5g9v1Ne0R8Pbazq/1AsL77JULsKvskcpbM/+n/
 EUxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ktk3MUORrku48djNVUTQGu53ioWiIZeEWAGVHynYp4AlP2LRTfXyNkxvv5+8LRYeF6gdJhB3rYwip@nongnu.org
X-Gm-Message-State: AOJu0YxtCxmwhssihVgTWwV2nTH/GsXLEt49vgWGXE3LCGxD3hqarD+J
 C0mGQSA/fNdvsgwhFiMAGE1dYdhyPfZp9jFIOfvIsATSIhrXjLoWTra9OrLRcDFmltALrAhjO8w
 g0VqPqvI=
X-Gm-Gg: AeBDieuTiFUhXS3SYiel4pAWyhGT17gaHhR0HQbeDQrzH6si05hIi3iRJTT6Ay3aGuL
 1aFpMUXujwgWTnC5jENG5u2TkCZLu8y4mbvbYu291FJw679g+49nbZhmmM6zUkzFv5kx+y2e+sw
 4C7XDW+6ueidk6Gw5cK8pKUoT0YXryKBqz+YC5JzcSI+kByIedUdGsEBwKMF640FPKSUUaMKqlQ
 tyrDsAD0GqHQ01fxL9ZdeukXKFma1bHSDSoWqcyxc4+xrOYhMAa3bsWJOnf+InTlw3Dv861NyES
 eB3d0Be4eP3ljIq8fx1Q50ABx0rqbWT4tqGeI/GS5o3vG4Uxzm6OZFXlim3pVbd22H09esd0eJN
 iEBgq4EL1d0nhC/oVoxV4drMaTAyMbjiyWVPW4yE0t2SeIsZp27mqBCwQFlBERMHmXvb+BNIhZs
 PrMrAJQmdCXnN9qWc1hDuLfoGDGb6ujcLH1WszzV646sFeTOgTh820k58UjQzqA6TSrIwAG+kWK
 wVVA/DA1mY=
X-Received: by 2002:a05:600c:3483:b0:486:fba7:b150 with SMTP id
 5b1f17b1804b1-488fb7787d7mr583789875e9.15.1777277472211; 
 Mon, 27 Apr 2026 01:11:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0b4c85sm743195075e9.0.2026.04.27.01.11.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:11:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 31/32] monitor: Merge hmp-target.c code within hmp-cmds.c
Date: Mon, 27 Apr 2026 10:07:37 +0200
Message-ID: <20260427080738.77138-32-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

hmp-target.c doesn't contain any target-specific code anymore.
Merge it within hmp-cmds.c (which is already built once).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS          |  1 -
 monitor/hmp-cmds.c   | 40 ++++++++++++++++++++++++
 monitor/hmp-target.c | 74 --------------------------------------------
 monitor/meson.build  |  3 --
 4 files changed, 40 insertions(+), 78 deletions(-)
 delete mode 100644 monitor/hmp-target.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e797b540d2..ea47dfd2cf8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3388,7 +3388,6 @@ Human Monitor (HMP)
 M: Dr. David Alan Gilbert <dave@treblig.org>
 S: Maintained
 F: monitor/monitor-internal.h
-F: monitor/hmp-target.c
 F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index e81632f5551..409a1a9c701 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/base-arch-defs.h"
 #include "system/address-spaces.h"
 #include "system/ioport.h"
 #include "exec/gdbstub.h"
@@ -22,19 +23,58 @@
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
 #include "monitor/hmp.h"
+#include "monitor/hmp-completion.h"
 #include "monitor/monitor-internal.h"
+#include "monitor/qdev.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
+#include "block/block-hmp-cmds.h"
 #include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "net/slirp.h"
+#include "system/device_tree.h"
 #include "system/hw_accel.h"
 #include "system/memory.h"
 #include "system/system.h"
 #include "disas/disas.h"
 
+/* Please update hmp-commands.hx when adding or changing commands */
+static HMPCommand hmp_info_cmds[] = {
+#include "hmp-commands-info.h"
+    { NULL, NULL, },
+};
+
+/* hmp_cmds and hmp_info_cmds would be sorted at runtime */
+static HMPCommand hmp_cmds[] = {
+#include "hmp-commands.h"
+    { NULL, NULL, },
+};
+
+HMPCommand *hmp_cmds_for_target(bool info_command)
+{
+    return info_command ? hmp_info_cmds : hmp_cmds;
+}
+
+static int
+compare_mon_cmd(const void *a, const void *b)
+{
+    return strcmp(((const HMPCommand *)a)->name,
+            ((const HMPCommand *)b)->name);
+}
+
+static void __attribute__((__constructor__)) sortcmdlist(void)
+{
+    qsort(hmp_cmds, ARRAY_SIZE(hmp_cmds) - 1,
+          sizeof(*hmp_cmds),
+          compare_mon_cmd);
+    qsort(hmp_info_cmds, ARRAY_SIZE(hmp_info_cmds) - 1,
+          sizeof(*hmp_info_cmds),
+          compare_mon_cmd);
+}
+
 bool hmp_handle_error(Monitor *mon, Error *err)
 {
     if (err) {
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
deleted file mode 100644
index 2739383607d..00000000000
--- a/monitor/hmp-target.c
+++ /dev/null
@@ -1,74 +0,0 @@
-/*
- * QEMU monitor, target-dependent part
- *
- * Copyright (c) 2003-2004 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/base-arch-defs.h"
-#include "monitor-internal.h"
-#include "monitor/qdev.h"
-#include "net/slirp.h"
-#include "system/device_tree.h"
-#include "monitor/hmp.h"
-#include "monitor/hmp-completion.h"
-#include "block/block-hmp-cmds.h"
-#include "qapi/qapi-commands-control.h"
-#include "qapi/qapi-commands-misc.h"
-#include "qapi/qapi-commands-machine.h"
-#include "hw/core/sysemu-cpu-ops.h"
-
-/* Make devices configuration available for use in hmp-commands*.hx templates */
-#include CONFIG_DEVICES
-
-/* Please update hmp-commands.hx when adding or changing commands */
-static HMPCommand hmp_info_cmds[] = {
-#include "hmp-commands-info.h"
-    { NULL, NULL, },
-};
-
-/* hmp_cmds and hmp_info_cmds would be sorted at runtime */
-static HMPCommand hmp_cmds[] = {
-#include "hmp-commands.h"
-    { NULL, NULL, },
-};
-
-HMPCommand *hmp_cmds_for_target(bool info_command)
-{
-    return info_command ? hmp_info_cmds : hmp_cmds;
-}
-
-static int
-compare_mon_cmd(const void *a, const void *b)
-{
-    return strcmp(((const HMPCommand *)a)->name,
-            ((const HMPCommand *)b)->name);
-}
-
-static void __attribute__((__constructor__)) sortcmdlist(void)
-{
-    qsort(hmp_cmds, ARRAY_SIZE(hmp_cmds) - 1,
-          sizeof(*hmp_cmds),
-          compare_mon_cmd);
-    qsort(hmp_info_cmds, ARRAY_SIZE(hmp_info_cmds) - 1,
-          sizeof(*hmp_info_cmds),
-          compare_mon_cmd);
-}
diff --git a/monitor/meson.build b/monitor/meson.build
index 585251804e4..4c58dd148c0 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -7,6 +7,3 @@ system_ss.add(files(
   'qemu-config-qmp.c',
   'qmp-cmds.c',
 ))
-
-specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: [files('hmp-target.c')])
-- 
2.53.0


