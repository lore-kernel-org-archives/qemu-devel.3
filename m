Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADB8C56206
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7s-0005re-O3; Fri, 20 Feb 2026 10:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2Z-0008PE-95; Fri, 20 Feb 2026 10:03:35 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2X-0002MU-LR; Fri, 20 Feb 2026 10:03:34 -0500
DKIM-Signature: a=rsa-sha256; bh=AHBKd/E7gyHUH8J6ORF6Q6SY/jbV6XihNGC5nYAYW8Y=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599792; v=1;
 b=E7ZA/Ga9knyjjFTJb/IJKleVXgIabmEzGst8yeGmrBGD67nCLlcTT5ahiJIvpTsZScpVb7+L
 NBfyJ2uwxQ6ZKhd4bsqncE0U/45X2FcqNLBsZy3fnm6brPCjB44DhpLy4GICRkEKnLAyVCFWVtB
 4yGxq8Os6LsjX+qpxX5A8aZ1QshKBs+jD//eid7jmrE88kFgd+jm24xvMITNH3xVdRpnuLxmk4a
 rB3xJ/G4pn+XiMQN0CH8HSYFdPBmFtZBkDJm3s7ZzOfxwZNth9SaktaNUJoiKziigLoA/X5yo/k
 GxqKQqU+qeXVpOHFVaq5EZfg/fhVwFlbpCGtNsz1/3LVQ==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 3249E25025;
 Fri, 20 Feb 2026 15:03:12 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Tue, 31 Jan 2023 14:52:45 +0100
Subject: [PATCH qemu 10/11] [ot] hw/riscv: add an IRQ wrapper
Message-ID: <177159976712.8279.7732381632410882915-10@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

Signed-off-by: Emmanuel Blot <eblot@rivosinc.com>

Includes existing MIT licenced code (already published elsewhere)
---
 include/hw/riscv/ibex_irq.h | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 include/hw/riscv/ibex_irq.h

diff --git a/include/hw/riscv/ibex_irq.h b/include/hw/riscv/ibex_irq.h
new file mode 100644
index 0000000000..22ccff6d5e
--- /dev/null
+++ b/include/hw/riscv/ibex_irq.h
@@ -0,0 +1,69 @@
+/*
+ * QEMU lowRISC Ibex IRQ wrapper
+ *
+ * Copyright (c) 2022-2023 Rivos, Inc.
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ */
+
+#ifndef HW_RISCV_IBEX_IRQ_H
+#define HW_RISCV_IBEX_IRQ_H
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/irq.h"
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+
+
+/** Simple IRQ wrapper to limit propagation of no-change calls */
+typedef struct {
+    qemu_irq irq;
+    int level;
+} IbexIRQ;
+
+static inline bool ibex_irq_set(IbexIRQ *ibex_irq, int level)
+{
+    if (level != ibex_irq->level) {
+        ibex_irq->level = level;
+        qemu_set_irq(ibex_irq->irq, level);
+        return true;
+    }
+
+    return false;
+}
+
+static inline bool ibex_irq_raise(IbexIRQ *irq)
+{
+    return ibex_irq_set(irq, 1);
+}
+
+static inline bool ibex_irq_lower(IbexIRQ *irq)
+{
+    return ibex_irq_set(irq, 0);
+}
+
+static inline void ibex_qdev_init_irq(Object *obj, IbexIRQ *irq,
+                                      const char *name)
+{
+    irq->level = 0;
+    qdev_init_gpio_out_named(DEVICE(obj), &irq->irq, name, 1);
+}
+
+static inline void ibex_qdev_init_irqs(Object *obj, IbexIRQ *irqs,
+                                       const char *name, unsigned count)
+{
+    for (unsigned ix = 0; ix < count; ix++) {
+        irqs[ix].level = 0;
+        qdev_init_gpio_out_named(DEVICE(obj), &irqs[ix].irq, name, 1);
+    }
+}
+
+static inline void ibex_sysbus_init_irq(Object *obj, IbexIRQ *irq)
+{
+    irq->level = 0;
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &irq->irq);
+}
+
+#endif /* HW_RISCV_IBEX_IRQ_H */
-- 
2.49.1


