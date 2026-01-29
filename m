Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADB4D61011
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 13:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlSAG-0002bT-IX; Thu, 29 Jan 2026 08:34:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS9g-0000Xm-Me
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:53 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlS9c-0002kS-PC
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 08:33:52 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48069a48629so10486855e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769693626; x=1770298426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hq4FdROzQMT1FITLEs5mQOhgWXAvATG5cfWFccAK6cg=;
 b=O4ae0lXKJ1j5U5751NPYDHBRfOKLKcF42Kc6ex4wJEz5x/KwsoRJ0voMrSzoiJnQ6J
 L0aLN2DPyzLx0PA0a8Hv8/St/hW3lkDffxkrGO+ljeJ96AMO3gxRiwR1vxTYTxk7rr9s
 oPZ1sladZoGFX/zwpkuxahllRrhq89VTp4FAE/WMCVkvnNqxgTocvlztZsh1eYMDagsM
 USNegCWuiS9/0Lc7f3KP2334mtet8dFbLi+MqLIZmPs+AZEQK48rbpKXAwaFFUzNKMuP
 dh56tQfXIhUBP2wJMubDN1/wrbP/bTOf49oayDA4bL0HkX0Ys2JgWdJqDzY5z3w3Qj+w
 umRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769693626; x=1770298426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hq4FdROzQMT1FITLEs5mQOhgWXAvATG5cfWFccAK6cg=;
 b=JiLxpy7te+VF0iDZG0TgPdgBQMMERSwVDBHPjUQhvAm94H7AEaqpWozLux/jwgMgP3
 nqSoPPDyoTa2vQTBfTPhaguNNearOD5KpL7YKOxlph5A67B/p1DWIh1S+GLN5Vi0ZuS+
 nCz+hugAHNyE+mHzF7D5lcfJwoVpr+XfG/SBfXkqsmcKyK+kvFvGkTpWuM4mpj5il7jQ
 5ppdVfJsHTKfZzmdyexoRaLz7DPe+FaMzyTUEqe1hUufqovRLF0x00VU6PoiPpFiLZR0
 EHJtJVspBXKzJuWV4qWQZdNmkiO0Q+kA30oz7eKUS6/rkWsQ0VagJLMlRhV8nLHNgYwC
 1Hlw==
X-Gm-Message-State: AOJu0Yw0cPKKhDWvv7SBuSVdg/ngfUQ2qv0a2nZcffKJJuI3IW5Z31/b
 2mNHzUVxFu2So3+l0vZKiYm6gVA7NtId/1kZNm+Dgyd4mZ+4/VeQzN0I0PGWkzSA+XFrxm8eRH3
 7UuUsz0E=
X-Gm-Gg: AZuq6aLYkyGlQyKzXOOhfk8LaUdGFHKGbwRwVIDKE4MsYT/u2WBFm8rLYpB3HLm8BiM
 5PuJzuHbsdRe3gGByaeNB3/BrNXu9N1Oqdq/XiEdWgH3J5iDsSHwXQwQl4n2/MpYUslEGdtolYe
 uQA3kJzET1LWlbWNrDJDSLyGF2qM9vi07KDrJQ8EJTNAtqYMQOPRMgdBfR5shNI7DDATCVGVMcT
 AydCc7SsgWK8fGAVLJNNgXssmK+vEyB5eHukw3wEMZLQ++hxR+HlwJ2ByRVgATLIhS0QEBeL+eE
 UNVb2jVvgEt74uT/GMVoti/U7jtFs5w/ebHYbxebhEwwNN2IXKgDxg5U/X7HRWOHZxjE2OpKJBs
 rffUQt5G+cU/bF6HPuqeCVSZnHutd2StuzVXWvncaFpMSpl6ciM0AqT1amwi1uI2jYvzJ0J2YVb
 8xb5y3gLEHl154+3fnHIpIvqSUorkJ5EujiZKDTqqOzPoXazo9sNNLiY2KN6E5
X-Received: by 2002:a05:600c:4f06:b0:475:da1a:5418 with SMTP id
 5b1f17b1804b1-48069c0fdfemr119806935e9.1.1769693625867; 
 Thu, 29 Jan 2026 05:33:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdd78d3sm133908465e9.1.2026.01.29.05.33.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Jan 2026 05:33:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v4 9/9] monitor: Remove 'monitor/hmp-target.h' header
Date: Thu, 29 Jan 2026 14:32:41 +0100
Message-ID: <20260129133241.35990-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129133241.35990-1-philmd@linaro.org>
References: <20260129133241.35990-1-philmd@linaro.org>
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

The "monitor/hmp-target.h" header doesn't contain any
target-specific declarations anymore. Merge it with
"monitor/hmp.h", its target-agnostic counterpart.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 MAINTAINERS                   |  2 +-
 include/monitor/hmp-target.h  | 46 -----------------------------------
 include/monitor/hmp.h         | 17 +++++++++++++
 hw/i386/sgx-stub.c            |  1 -
 hw/i386/sgx.c                 |  1 -
 monitor/hmp-cmds.c            |  1 -
 monitor/hmp-target.c          |  1 -
 monitor/hmp.c                 |  1 -
 stubs/target-monitor-defs.c   |  2 +-
 target/i386/cpu-apic.c        |  1 -
 target/i386/monitor.c         |  1 -
 target/i386/sev-system-stub.c |  1 -
 target/i386/sev.c             |  1 -
 target/m68k/monitor.c         |  1 -
 target/ppc/ppc-qmp-cmds.c     |  1 -
 target/riscv/monitor.c        |  1 -
 target/riscv/riscv-qmp-cmds.c |  1 -
 target/sh4/monitor.c          |  1 -
 target/sparc/monitor.c        |  1 -
 target/xtensa/monitor.c       |  1 -
 20 files changed, 19 insertions(+), 64 deletions(-)
 delete mode 100644 include/monitor/hmp-target.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dccdf478886..f19b1362cda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3385,7 +3385,7 @@ F: monitor/monitor.c
 F: monitor/hmp*
 F: hmp.h
 F: hmp-commands*.hx
-F: include/monitor/hmp-target.h
+F: include/monitor/hmp.h
 F: tests/qtest/test-hmp.c
 F: include/qemu/qemu-print.h
 F: util/qemu-print.c
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
deleted file mode 100644
index 788bc9e330a..00000000000
--- a/include/monitor/hmp-target.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * QEMU monitor
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
-#ifndef MONITOR_HMP_TARGET_H
-#define MONITOR_HMP_TARGET_H
-
-typedef struct MonitorDef MonitorDef;
-
-struct MonitorDef {
-    const char *name;
-    int offset;
-    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
-    int type;
-};
-
-#define MD_TULONG 0
-#define MD_U32    1
-
-const MonitorDef *target_monitor_defs(void);
-int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
-
-CPUArchState *mon_get_cpu_env(Monitor *mon);
-CPUState *mon_get_cpu(Monitor *mon);
-
-#endif /* MONITOR_HMP_TARGET_H */
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e222bea60cd..83889ab8ed2 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -17,6 +17,23 @@
 #include "qemu/readline.h"
 #include "qapi/qapi-types-common.h"
 
+typedef struct MonitorDef {
+    const char *name;
+    int offset;
+    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
+    int type;
+} MonitorDef;
+
+#define MD_TULONG 0
+#define MD_U32    1
+
+const MonitorDef *target_monitor_defs(void);
+
+int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
+
+CPUArchState *mon_get_cpu_env(Monitor *mon);
+CPUState *mon_get_cpu(Monitor *mon);
+
 bool hmp_handle_error(Monitor *mon, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
 strList *hmp_split_at_comma(const char *str);
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 1dd8d9afbfa..6e82773a86d 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 5e792e8e6e9..7e4c509f5a4 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -17,7 +17,6 @@
 #include "monitor/qdev.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qapi/qapi-commands-misc-i386.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index bad034937a9..a85c5243a40 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -22,7 +22,6 @@
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/monitor/hmp-target.c b/monitor/hmp-target.c
index a3306b69c93..2574c5d8b4b 100644
--- a/monitor/hmp-target.c
+++ b/monitor/hmp-target.c
@@ -27,7 +27,6 @@
 #include "monitor/qdev.h"
 #include "net/slirp.h"
 #include "system/device_tree.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "block/block-hmp-cmds.h"
 #include "qapi/qapi-commands-control.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 36e58c54670..2d9f870df26 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,7 +27,6 @@
 #include "hw/core/qdev.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qobject/qdict.h"
 #include "qobject/qnum.h"
 #include "qemu/bswap.h"
diff --git a/stubs/target-monitor-defs.c b/stubs/target-monitor-defs.c
index 35a0a342772..0dd4cdb34f6 100644
--- a/stubs/target-monitor-defs.c
+++ b/stubs/target-monitor-defs.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "monitor/hmp-target.h"
+#include "monitor/hmp.h"
 
 const MonitorDef *target_monitor_defs(void)
 {
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index f7ad7b51394..3b73a04597f 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -11,7 +11,6 @@
 #include "qapi/error.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/xen.h"
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 427f1990399..1d04978c43b 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qobject/qdict.h"
 #include "qapi/error.h"
diff --git a/target/i386/sev-system-stub.c b/target/i386/sev-system-stub.c
index fb84aee94d2..f799a338d60 100644
--- a/target/i386/sev-system-stub.c
+++ b/target/i386/sev-system-stub.c
@@ -14,7 +14,6 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "sev.h"
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fef9f441c61..946aecd0408 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -37,7 +37,6 @@
 #include "qom/object.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "qapi/qapi-commands-misc-i386.h"
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 1bb5012da91..c148926d827 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -8,7 +8,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "monitor/monitor.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
diff --git a/target/ppc/ppc-qmp-cmds.c b/target/ppc/ppc-qmp-cmds.c
index 07938abb15f..08314e3c1cd 100644
--- a/target/ppc/ppc-qmp-cmds.c
+++ b/target/ppc/ppc-qmp-cmds.c
@@ -26,7 +26,6 @@
 #include "cpu.h"
 #include "monitor/monitor.h"
 #include "qemu/ctype.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 478fd392ac6..bc176dd8771 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -23,7 +23,6 @@
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/memory.h"
 
 #ifdef TARGET_RISCV64
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d5e9bec0f86..79232d34005 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -34,7 +34,6 @@
 #include "qemu/ctype.h"
 #include "qemu/qemu-print.h"
 #include "monitor/hmp.h"
-#include "monitor/hmp-target.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
 #include "cpu-qom.h"
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 2da6a5426eb..50324d3600c 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 378967f8164..83257a18717 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index fbf60d55530..2af84934f83 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "monitor/monitor.h"
-#include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
 
 void hmp_info_tlb(Monitor *mon, const QDict *qdict)
-- 
2.52.0


