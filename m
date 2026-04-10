Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC16F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHyd-0002Dk-5V; Fri, 10 Apr 2026 15:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHya-00029g-HT
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:57:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBHy4-0004vK-8v
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:57:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-483487335c2so26372345e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775850998; x=1776455798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnjRe5b33HAs4SIsako+kOOSPGazNPDfUbCOKtysLcw=;
 b=Q2maWj+/L7brHeiwqlqdYeP+o/fCrvIPwee7m+0MISUo6xN6RPlAp48OnKwbqrfMj2
 5EJltMnnMZaRQe818qvxoSwORUH5vNkvwbRH8WuLJ/+J24N7uClGgj5M11nH+VFnxq4m
 Op0ISVKbobLa00R5xHdhZ4KCAlFGWl5N/VmvF3eqKhAxSStzpyO93zqYD2fVviRGTqEV
 ppqOpRFNqu19chbZpr5+vXmezYRf6aohqqOYsHHctsaWs+e3BNUiz51O0zHYa4KVLraI
 BXMk5LI2CW+RrAos0q4bDSGnlfBseyL3at8ANJXqa1B7GqbcvcWPJPIvQX+VsXhK/e/Y
 ku4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775850998; x=1776455798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TnjRe5b33HAs4SIsako+kOOSPGazNPDfUbCOKtysLcw=;
 b=UYUcnRODYVFDUFhAVUwmuUDObfjOpSY72ByG0SPFx0zc2RJbtzuIfRk6M7e9kTxlHq
 a9KEQKcxa7IKGTaLS64vPf2CKuZLZrcj7aT0EYqnqfzeurozobOlFXXrZN/qqfg6V2w2
 5JC5KJlgYC8THAutgaTc9xPIiCnAYwfmvWK8z2lfVo1s9+y7v0H0DSYAPm7GC4SkU54V
 ZKpEBj8eDOjm3Yo/t6oTRC7GyMXd9gil9F0bfQZPsdBa3NXccUtx2qOpxe4gbTXyO7kG
 Kq6Xr++zaZ84TnXDMgpNi2c6dir92PCv4q4skO0PgVDXioULHy2exWIezdmNJE7PHcxa
 zR9g==
X-Gm-Message-State: AOJu0YwpMYAurXZ2WMzNHNPaHiyjdXRptVoLizrldJyQaXLqizJEKXO4
 dKKmHhQeW4rJkIgSFB4KSC4lvsh4M3zHtp6DEbFe4Yem+583YxE9x7iWfA4L89TKm1G02KAphQ+
 E0NdkVgM=
X-Gm-Gg: AeBDieuBumsU50DOwV7P715IKoh26fZV24S5da9705CzRc7pt4kZI7drg8fXD1tN0al
 eUVX9hlruElpXyQGO3hH4GwrXdTXuRZhoCessx/vDgdhA3I0fiJ0/GxohZuGJ1gZZCQq6i/FxWk
 EtcAojYSf5SK6IQx3CvgvZ7J8bbr4lY4ZG2D9w7Dmhfib33K3UJ74SIvludLEGTpq4jc6uplfZZ
 2gHMutZvG0N3UO5re/P12BOwufNs2KWJxKl4U8clMQ/BWeL0Ep8QZ1V77a/g2wV6VDSWUWbGMjb
 QMt3PhLNCzPFZNSguSCWuTsFbSTNFm62MgGNolVS5zTcQprHYZqMyhf95ekMtM9baHVsPByzEh9
 VSZUrqui7lOiaibj7yiPBGWD/9W+xDKMG+Na8FNNqrQfrxDj2XmI9rfBSG1fiOt1z/PAXdkCpTP
 Cs/uB+zLigOdFh0EKk4v7gEEIbI82+0V/QZkYpdPhX9zKnAKZqFiBut8EVkWy1NGaBXcBuKlsA
X-Received: by 2002:a05:600c:c0da:b0:488:936a:6220 with SMTP id
 5b1f17b1804b1-488d685b577mr50873375e9.21.1775850998436; 
 Fri, 10 Apr 2026 12:56:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f1f9sm124274295e9.1.2026.04.10.12.56.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 12:56:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 27/27] monitor: Merge hmp-target.c code within hmp-cmds.c
Date: Fri, 10 Apr 2026 21:53:21 +0200
Message-ID: <20260410195323.17937-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410195323.17937-1-philmd@linaro.org>
References: <20260410195323.17937-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
---
 MAINTAINERS          |  1 -
 monitor/hmp-cmds.c   | 40 ++++++++++++++++++++++++
 monitor/hmp-target.c | 73 --------------------------------------------
 monitor/meson.build  |  3 --
 4 files changed, 40 insertions(+), 77 deletions(-)
 delete mode 100644 monitor/hmp-target.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5dcd24a8a89..d184e25ddd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3414,7 +3414,6 @@ Human Monitor (HMP)
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
index 4968d511101..00000000000
--- a/monitor/hmp-target.c
+++ /dev/null
@@ -1,73 +0,0 @@
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


