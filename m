Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6EBF531CE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRie-0001WV-4N; Mon, 13 Apr 2026 20:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRiX-0001TF-5d
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:33:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRiV-0003fv-9N
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:33:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-483487335c2so54767705e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126801; x=1776731601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODwnfJVouK+JUVlbOBy8KRV4Th4vkJEO+Xt0lwwIQP8=;
 b=dLB1Mi3LosnyTRuIlMQmSZshoWtfrlNSa5MDtEuOgZnAGZxpsk7pePs/HQtFarPPwG
 CsxaMsPS2z9m4VAQRks2pBg3A0yJEfvyymEj4NARpz6r7SORXqLA4sqk+XisdppBZL9D
 3CuqYujfAlTvaY3MGmBQD+GQymWeafVz/1/HrLTIllLMRWdkrZpXMjPjx5EGTJXVl9G6
 J6GL2U4yM2X0/LlFJqDu0xymNBAEPRPLbLlQEAIg8PH5egR28dxRlR1MeMvdwQb1fohu
 78WW2Z7m8fdnDuWl4wu68WvpiFiQ+J2sTTz11X0G8VfCngHxgezR0FD9fEoCAzDT3r9t
 U+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126801; x=1776731601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ODwnfJVouK+JUVlbOBy8KRV4Th4vkJEO+Xt0lwwIQP8=;
 b=ZUoIw3jtaofoNntzptkrcZ2OLvex5QaErTRfexEmSxZrQCPh8RxlJDvliuLMUx0gx+
 J/dhIGbeJRXIIhy/iH0NccgvUqasRymKyH6r97bSsssAF9285D4/wsnoBVYz7ffLRGGU
 qmSeRhLme0uYRpHWehQfh7x73QeKtM+8PnU2U40iRf6bCyK1ByKW/wgmMibGRuk+TYgl
 RJEewUUEGztCwY3yVijX+qzd8I5JcJ6RT6lAH2i15x67gJegL4DFCgitWPTyobYlHthb
 Nha34Xsd/c5+g4Ex+BwjhNI3fc+F2xCz094sG2JYvhWt/Mc2lwnHMvyqW6YcIIfEuP5N
 qZ0g==
X-Gm-Message-State: AOJu0YzMCtokQrWLpI3fWUEUEND2DLYlCd6/tF8pomdCjalCYtK5kJo+
 ALosixP0ZC+suDh0TzdCRcFtXWDpjXV6c3kvmDJVUrR1G7h2wgALhyVP7578aozQRTiZt8g7aIZ
 tCStAF7U=
X-Gm-Gg: AeBDiesZnz4dHWQ8mgxliP1zWhrkb3/sWYCB8+Bi/2geX8WWXBYP1p42aENTJ6cxjo7
 EkC+RxZMS8aUPQBqwfq7GG9uYcnDoFPKcfLob0LNWy5aPOvih3LNpCxqcqPEouGlsAYCujVO79+
 nqtq/KXyokmBKqmPG3sLqua+nb+/v1s7AZrO80KQSw7UMIvuikEZ7XojhkPHKx51t2UVgz73VdA
 IyDmH3EsDHjtkxoew/RSn8Tw++13uB8FNueR6gTY7Huaepj5LuTI467uIlNn1ZvPJ3w4bjSVUlZ
 G7nDTjUIP/cEnv4+YluKLs5zaFZVyCGeyqJ1EeOW/M22qEpd16nVPEtn77JWaDdeagTFUO5zIq1
 4fZGkg/ms0VJORJW1hwAXMSJ3NvhqTKaQT1bfb3ONJwWBVuBBBwtIkmiUcZtDEy3nmKlXaT3lgB
 I2p+yS4LL7i6IsW+YWJLdNptAjVTBq7BkrS+xj4Wccb7kPCAAZDzpG1xNnF7ImtIDt47n2Q1SZ
X-Received: by 2002:a05:600d:d:b0:485:2a85:e5ec with SMTP id
 5b1f17b1804b1-488d67b8db8mr160288015e9.2.1776126801487; 
 Mon, 13 Apr 2026 17:33:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee038752sm5826945e9.9.2026.04.13.17.33.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:33:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 27/27] monitor: Merge hmp-target.c code within hmp-cmds.c
Date: Tue, 14 Apr 2026 02:29:59 +0200
Message-ID: <20260414003001.97571-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
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


