Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEB3E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 09:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVSKi-00046y-RG; Wed, 08 Jan 2025 04:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK7-0003vO-Dr; Wed, 08 Jan 2025 04:25:59 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tVSK5-0004mT-Mj; Wed, 08 Jan 2025 04:25:59 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d84179ef26so4889425a12.3; 
 Wed, 08 Jan 2025 01:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736328355; x=1736933155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPu1XN0WSJ78Dz4uVHZFF9UQOoIdIxv9/jGfNRVw5Jw=;
 b=j7xb5pb2jPBVVRVNDtYjb7IclOXD/OEIYWugNEKIDc141FnTrrSNR66yLARw3cKRBD
 4VTPpJYs5dl4W2Uhdu38HY9DtCdTLAnSd2xVOpzOhZI0rQVc7YD2VjBcV588fi1W/qB3
 biRZpJsTRgNo7xl3nv0GpFuCZNSj9EsUqQCedzxYvt9+ve3lF4CkETBqSq+pBamdsys8
 yb6o4IRyqM5DjkAygo+0nFSO/nXaVjspA5v5GV3xivHXeV4TnNltOYXzvaLqHv58XzYa
 b5my6G1CqveArerkQiWXGIvldpMtt7VhYnC7j5I0tbsVcE9mzD/ECSpX26FelWz+HYmP
 EILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736328355; x=1736933155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPu1XN0WSJ78Dz4uVHZFF9UQOoIdIxv9/jGfNRVw5Jw=;
 b=aIr9TtyYNChEHCJ4FQ9Sn8uxNPaOnASqzEQfdYW5T9tEyXwEgAvdWRfx/bpo25PCqg
 2EDf8vobyOg6ywq8hipIzkBQiASHyAyj6HunHU4lqvJfxkapXESP3eP8PBsIg1BPqmxX
 ldafjUKAewN6OSFsgaEmfOSHYnvYoFId7SFaBrFO9EsvV4tnHtnMSiRO74LQoX27vj7Z
 kewUuOJaKCLM2g1+Oknl03SvSoXrgcfHnm1W5beZLWe/l3KOWnsmryCzHxj7reDqYRuP
 b/NBCSKH/WWbknaOUDBJq+SgkYgDCXPUdEe55VzFsBoOPHWy5vUgXotIZwiFpVgZMkP4
 M1dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSqrKRTgotxzcyQkLmPgKBahxYyy7EwatHnx+Bv4ZWyNmIrFpNzYy+6DfSKWk3tIkMhdImrtmglg==@nongnu.org,
 AJvYcCXYSb/X1hWNrdfvMQJTfTdUR3RDtsZoq0juy3QZqwcjyfQsn55v2yJdAImdoZK6/6TkZq0zMpoX0VhUVw==@nongnu.org
X-Gm-Message-State: AOJu0YzVskKmQIKscCIzye/WxRrXNPrZY6Ju1OzMo8UdgVH+Oq620YDl
 sxB3olhVDL3fgwnXM+WvGwRCtEFtbig/iHQ6ICaRX3861Rw54zDDiiJ6yybH
X-Gm-Gg: ASbGncuMacfI3iMYlq+czSp6BnhPB8RVSJne40j0dvjVabknfqw53mE6xLQzFvchS5O
 kKVr33uX0T9FWk/Tj3q6Y9F5tlDZynfaPVmt8l+ZZowcrR+cjGu53dengjSP7a1wp9Nco4WVmec
 79as4PF6ji3Q40eFAadG8Ew3yBPfE3LkIMjXNiKK+yGA5NPcIbAfmB6j+3VVHegxaSXfCTGo5kB
 kGL6oG0MRjkfAWxd/F2crqvWaNs4d8tcxhySmmlxX0h6aEyVT7yqR8MvP7qvewhhS21IIETEMv6
 FsKoPbR04c/r196XAwFlzQpyqxPnPPTlV4YggI/EqiGKqJA=
X-Google-Smtp-Source: AGHT+IGIdvkIyqHc0FKN2Jp91DlocfLqEpUXXhnmKMVI6La0cBQr+vzBb8GswUzk1fQHEXmYFqBfuw==
X-Received: by 2002:a05:6402:354c:b0:5d3:fb9d:3f69 with SMTP id
 4fb4d7f45d1cf-5d972e4cdd8mr1521105a12.21.1736328355021; 
 Wed, 08 Jan 2025 01:25:55 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-106-228.77.188.pool.telefonica.de. [77.188.106.228])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806feddfasm26116096a12.58.2025.01.08.01.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 01:25:54 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 04/14] hw/core: Introduce TYPE_SHARED_IRQ
Date: Wed,  8 Jan 2025 10:25:28 +0100
Message-ID: <20250108092538.11474-5-shentey@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108092538.11474-1-shentey@gmail.com>
References: <20250108092538.11474-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/core/shared-irq.h | 39 ++++++++++++++++
 hw/core/shared-irq.c         | 88 ++++++++++++++++++++++++++++++++++++
 hw/core/Kconfig              |  3 ++
 hw/core/meson.build          |  1 +
 4 files changed, 131 insertions(+)
 create mode 100644 include/hw/core/shared-irq.h
 create mode 100644 hw/core/shared-irq.c

diff --git a/include/hw/core/shared-irq.h b/include/hw/core/shared-irq.h
new file mode 100644
index 0000000000..803c303dd0
--- /dev/null
+++ b/include/hw/core/shared-irq.h
@@ -0,0 +1,39 @@
+/*
+ * IRQ sharing device.
+ *
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+/*
+ * This is a simple device which has one GPIO output line and multiple GPIO
+ * input lines. The output line is active if at least one of the input lines is.
+ *
+ * QEMU interface:
+ *  + N unnamed GPIO inputs: the input lines
+ *  + one unnamed GPIO output: the output line
+ *  + QOM property "num-lines": sets the number of input lines
+ */
+#ifndef HW_SHARED_IRQ_H
+#define HW_SHARED_IRQ_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_SHARED_IRQ "shared-irq"
+
+#define MAX_SHARED_LINES 16
+
+
+OBJECT_DECLARE_SIMPLE_TYPE(SharedIRQ, SHARED_IRQ)
+
+struct SharedIRQ {
+    DeviceState parent_obj;
+
+    qemu_irq out_irq;
+    uint16_t irq_states;
+    uint8_t num_lines;
+};
+
+#endif
diff --git a/hw/core/shared-irq.c b/hw/core/shared-irq.c
new file mode 100644
index 0000000000..b2a4ea4a66
--- /dev/null
+++ b/hw/core/shared-irq.c
@@ -0,0 +1,88 @@
+/*
+ * IRQ sharing device.
+ *
+ * Copyright (c) 2025 Bernhard Beschow <shentey@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/shared-irq.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+
+static void shared_irq_handler(void *opaque, int n, int level)
+{
+    SharedIRQ *s = opaque;
+    uint16_t mask = BIT(n);
+
+    if (level) {
+        s->irq_states |= mask;
+    } else {
+        s->irq_states &= ~mask;
+    }
+
+    qemu_set_irq(s->out_irq, !!s->irq_states);
+}
+
+static void shared_irq_init(Object *obj)
+{
+    SharedIRQ *s = SHARED_IRQ(obj);
+
+    qdev_init_gpio_out(DEVICE(s), &s->out_irq, 1);
+}
+
+static void shared_irq_realize(DeviceState *dev, Error **errp)
+{
+    SharedIRQ *s = SHARED_IRQ(dev);
+
+    if (s->num_lines < 1 || s->num_lines >= MAX_SHARED_LINES) {
+        error_setg(errp,
+                   "IRQ shared number of lines %d must be between 1 and %d",
+                   s->num_lines, MAX_SHARED_LINES);
+        return;
+    }
+
+    qdev_init_gpio_in(dev, shared_irq_handler, s->num_lines);
+}
+
+static const Property shared_irq_properties[] = {
+    DEFINE_PROP_UINT8("num-lines", SharedIRQ, num_lines, 1),
+};
+
+static const VMStateDescription shared_irq_vmstate = {
+    .name = TYPE_SHARED_IRQ,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT16(irq_states, SharedIRQ),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void shared_irq_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    /* No state to reset */
+    device_class_set_props(dc, shared_irq_properties);
+    dc->vmsd = &shared_irq_vmstate;
+    dc->realize = shared_irq_realize;
+
+    /* Reason: Needs to be wired up to work */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo shared_irq_types[] = {
+    {
+       .name = TYPE_SHARED_IRQ,
+       .parent = TYPE_DEVICE,
+       .instance_size = sizeof(SharedIRQ),
+       .instance_init = shared_irq_init,
+       .class_init = shared_irq_class_init,
+    },
+};
+
+DEFINE_TYPES(shared_irq_types)
diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index d1bdf765ee..ddff977963 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -32,6 +32,9 @@ config PLATFORM_BUS
 config REGISTER
     bool
 
+config SHARED_IRQ
+    bool
+
 config SPLIT_IRQ
     bool
 
diff --git a/hw/core/meson.build b/hw/core/meson.build
index ce9dfa3f4b..6b5bdc8ec7 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -21,6 +21,7 @@ system_ss.add(when: 'CONFIG_OR_IRQ', if_true: files('or-irq.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('platform-bus.c'))
 system_ss.add(when: 'CONFIG_PTIMER', if_true: files('ptimer.c'))
 system_ss.add(when: 'CONFIG_REGISTER', if_true: files('register.c'))
+system_ss.add(when: 'CONFIG_SHARED_IRQ', if_true: files('shared-irq.c'))
 system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
-- 
2.47.1


