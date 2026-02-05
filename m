Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C769ECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5VO-0006kM-Bl; Thu, 05 Feb 2026 14:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VM-0006jd-E6
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:08 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VK-00037A-Gi
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:08 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so915109f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321545; x=1770926345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okCHnQwuhdSjTOfJI68bWJdfyGo5v7fjnvg4A5+IdxA=;
 b=F8ixgkHd76PM/ZsJQ1C0SXLp5+SGbKtrR4BaY49Qp3ir3H7psfnE6e70rGt49LCF/i
 3X2OMMo/uh0hz26tgfNDkIfKasmVH3AqozkIpNiF5jJ0a9joC9+6Eu2MOWkqu+EZh/97
 NbJX3rTkQ+xMzbumSqCp8wYkzhf89SfhXOXLGiRDxrfPEoh5Wk+eYKqe2dN1u0hyY7LA
 Y7/e+5q/R799D3NR7iS6VJ1JzefjJcbeCQc/G6Kmw1dOD/nG70Bvwcl1AXeHzJSIhJyj
 LpWBZiLsheNOPrQIxQL0ansUWJ3vsEyJIyNroRSKoE2H7gi3oT8lCafKgW5niNz6+LSM
 Hgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321545; x=1770926345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=okCHnQwuhdSjTOfJI68bWJdfyGo5v7fjnvg4A5+IdxA=;
 b=k/k8+tz2Pj/mACz37/aH+UqIDejffj7nEWitvoF8a/snAefIVFohvB/zc3Jf3in2Y0
 Meo33IVbSaLdOQBDBitpJxJ5VUeQyFuDKIh/aZ5i4zabaDDB6kapavg8hlMoZNWikS6z
 EdF0bSiuP3MW3U9jZWkVK4FedbE4ITyHYnfX/QljP2ZAVarrZD/pQESVjG3W74RVssVb
 r7HgCxOD0I4/P7O/AUFY0CUDEzUTedUVZslxyU4hbZkO/iXvhpOLbealOMs9I2uryXYB
 t9d18QkpXh31Tzo/VXVxdGZ0GT6PahMCbbky0Jh52gKmrv0U5jppB+dljVOBeVivgAyQ
 VR2Q==
X-Gm-Message-State: AOJu0YxudPQxcVV3SkaS/XfY9N8nxgAPmdV2ckNHO5sz2nNeow/54rdT
 amOowezj3Puvm1iZ9PZ/saaxqZS0BJOFCIhPpEgSZ8rHIT9cPXCUw2rGhsrOzzDG+Cw=
X-Gm-Gg: AZuq6aKlBNiyZEaTmDvMCS/cYVbPnGv2uzSBsm6cE6iPhUqNaLhpciMT30UaR+RFaFJ
 oal1QwzeSO/dzhgkNZpmCMH4/IEJH/jDNcYkCQVfkAiDAaFJATR7UXEngoYheZr78RJ6ncsADkQ
 9By1Wl8gpBxrUr5cvVsHlOISe/5w1p0NSEKKuRIICm2yFZgWAym6G2rFPcDpCv1I0TKYYLOYPRY
 sOg4uGALuVZyZhWT9vCI/m9lWZempzLhBT9s4oEtNr+8+19cnlk6XjbUHnicbxrWeJSZkW5AkuH
 i5vdy7723OUDGNj9LI4GMdSEjKQLnNwhJ0GshKk43NNrnntoisS+XThgSQbBTy5CpY+OO0RDJNe
 s3iVKSJK+Rg+HgEH8XAGYhAozPaOPW3wIquI1cj4h6x9JIgeCL4hmEtzKPgBvgG6d9nueniqXmT
 0u6CWBpRaEaWKEBqyp0eE=
X-Received: by 2002:a05:6000:2c13:b0:435:a0f5:c271 with SMTP id
 ffacd0b85a97d-4362967ded6mr532453f8f.31.1770321544577; 
 Thu, 05 Feb 2026 11:59:04 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:03 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 14/29] hw/core: Add Remote Port Memory Master object skeleton
Date: Thu,  5 Feb 2026 20:58:09 +0100
Message-ID: <20260205195824.2610192-15-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce 'remote-port-memory-master' device skeleton.

This device exposes a MemoryRegion within QEMU that represents
resources located in the external simulator. When implemented
fully, read/write accesses to the region will be encapsulated
into Remote Port packets and transmitted to the peer.

This enables QEMU to map remote peripherals or memory into
its own address space.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-memory-master.c         | 151 ++++++++++++++++++++
 hw/core/remote-port.c                       |   5 +
 include/hw/core/remote-port-memory-master.h |  59 ++++++++
 include/hw/core/remote-port.h               |   2 +
 4 files changed, 217 insertions(+)
 create mode 100644 hw/core/remote-port-memory-master.c
 create mode 100644 include/hw/core/remote-port-memory-master.h

diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
new file mode 100644
index 0000000000..d714f66ddf
--- /dev/null
+++ b/hw/core/remote-port-memory-master.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU remote port memory master.
+ *
+ * Copyright (c) 2014 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+#include "qemu/log.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/error.h"
+#include "hw/core/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "trace.h"
+
+#include "hw/core/remote-port-proto.h"
+#include "hw/core/remote-port.h"
+#include "hw/core/remote-port-memory-master.h"
+
+#ifndef REMOTE_PORT_ERR_DEBUG
+#define REMOTE_PORT_DEBUG_LEVEL 0
+#else
+#define REMOTE_PORT_DEBUG_LEVEL 1
+#endif
+
+#define DB_PRINT_L(level, ...) do { \
+    if (REMOTE_PORT_DEBUG_LEVEL > level) { \
+        fprintf(stderr,  ": %s: ", __func__); \
+        fprintf(stderr, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define REMOTE_PORT_MEMORY_MASTER_PARENT_CLASS \
+    object_class_get_parent( \
+            object_class_by_name(TYPE_REMOTE_PORT_MEMORY_MASTER))
+
+#define RP_MAX_ACCESS_SIZE 4096
+
+static MemTxResult rp_access(MemoryTransaction *tr)
+{
+    /* TBD */
+    return MEMTX_OK;
+}
+
+static const MemoryRegionOps rp_ops_template = {
+    .access = rp_access,
+    .valid.max_access_size = RP_MAX_ACCESS_SIZE,
+    .valid.unaligned = true,
+    .impl.max_access_size = RP_MAX_ACCESS_SIZE,
+    .impl.unaligned = false,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void rp_memory_master_realize(DeviceState *dev, Error **errp)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(dev);
+    int i;
+
+    /* Sanity check max access size.  */
+    if (s->max_access_size > RP_MAX_ACCESS_SIZE) {
+        error_setg(errp, "%s: max-access-size %d too large! MAX is %d",
+                   TYPE_REMOTE_PORT_MEMORY_MASTER, s->max_access_size,
+                   RP_MAX_ACCESS_SIZE);
+        return;
+    }
+
+    if (s->max_access_size < 4) {
+        error_setg(errp, "%s: max-access-size %d too small! MIN is 4",
+                   TYPE_REMOTE_PORT_MEMORY_MASTER, s->max_access_size);
+        return;
+    }
+
+    assert(s->rp);
+    s->peer = rp_get_peer(s->rp);
+
+    /* Create a single static region if configuration says so.  */
+    if (s->map_num) {
+        /* Initialize rp_ops from template.  */
+        s->rp_ops = g_malloc(sizeof *s->rp_ops);
+        memcpy(s->rp_ops, &rp_ops_template, sizeof *s->rp_ops);
+        s->rp_ops->valid.max_access_size = s->max_access_size;
+        s->rp_ops->impl.max_access_size = s->max_access_size;
+
+        s->mmaps = g_new0(typeof(*s->mmaps), s->map_num);
+        for (i = 0; i < s->map_num; ++i) {
+            char *name = g_strdup_printf("rp-%d", i);
+
+            s->mmaps[i].offset = s->map_offset;
+            memory_region_init_io(&s->mmaps[i].iomem, OBJECT(dev), s->rp_ops,
+                                  &s->mmaps[i], name, s->map_size);
+            sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmaps[i].iomem);
+            s->mmaps[i].parent = s;
+            g_free(name);
+        }
+    }
+}
+
+static void rp_prop_allow_set_link(const Object *obj, const char *name,
+                                   Object *val, Error **errp)
+{
+}
+
+static void rp_memory_master_init(Object *obj)
+{
+    RemotePortMemoryMaster *rpms = REMOTE_PORT_MEMORY_MASTER(obj);
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&rpms->rp,
+                             rp_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("map-num", RemotePortMemoryMaster, map_num, 0),
+    DEFINE_PROP_UINT64("map-offset", RemotePortMemoryMaster, map_offset, 0),
+    DEFINE_PROP_UINT64("map-size", RemotePortMemoryMaster, map_size, 0),
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortMemoryMaster, rp_dev, 0),
+    DEFINE_PROP_BOOL("relative", RemotePortMemoryMaster, relative, false),
+    DEFINE_PROP_UINT32("max-access-size", RemotePortMemoryMaster,
+                       max_access_size, RP_MAX_ACCESS_SIZE),
+};
+
+static void rp_memory_master_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+    dc->realize = rp_memory_master_realize;
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT_MEMORY_MASTER,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(RemotePortMemoryMaster),
+    .instance_init = rp_memory_master_init,
+    .class_init    = rp_memory_master_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_REMOTE_PORT_DEVICE },
+        { },
+    },
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+}
+
+type_init(rp_register_types)
diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
index 6a1933a5a6..c783a12153 100644
--- a/hw/core/remote-port.c
+++ b/hw/core/remote-port.c
@@ -938,6 +938,11 @@ static void rp_init(Object *obj)
     }
 }
 
+struct rp_peer_state *rp_get_peer(RemotePort *s)
+{
+    return &s->peer;
+}
+
 static void rp_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/include/hw/core/remote-port-memory-master.h b/include/hw/core/remote-port-memory-master.h
new file mode 100644
index 0000000000..70f7c38c35
--- /dev/null
+++ b/include/hw/core/remote-port-memory-master.h
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU remote port memory master. Read and write transactions
+ * recieved from QEMU are transmitted over remote-port.
+ *
+ * Copyright (c) 2020 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_MEMORY_MASTER_H
+#define REMOTE_PORT_MEMORY_MASTER_H
+
+#include "hw/core/remote-port.h"
+
+#define TYPE_REMOTE_PORT_MEMORY_MASTER "remote-port-memory-master"
+#define REMOTE_PORT_MEMORY_MASTER(obj) \
+        OBJECT_CHECK(RemotePortMemoryMaster, (obj), \
+                     TYPE_REMOTE_PORT_MEMORY_MASTER)
+
+typedef struct RemotePortMemoryMaster RemotePortMemoryMaster;
+
+typedef struct RemotePortMap {
+    void *parent;
+    MemoryRegion iomem;
+    uint32_t rp_dev;
+    uint64_t offset;
+} RemotePortMap;
+
+struct RemotePortMemoryMaster {
+    /* private */
+    SysBusDevice parent;
+
+    MemoryRegionOps *rp_ops;
+    RemotePortMap *mmaps;
+
+    /* public */
+    uint32_t map_num;
+    uint64_t map_offset;
+    uint64_t map_size;
+    uint32_t rp_dev;
+    bool relative;
+    uint32_t max_access_size;
+    struct RemotePort *rp;
+    struct rp_peer_state *peer;
+    int rp_timeout;
+};
+
+MemTxResult rp_mm_access(RemotePort *rp, uint32_t rp_dev,
+                         struct rp_peer_state *peer,
+                         MemoryTransaction *tr,
+                         bool relative, uint64_t offset);
+
+MemTxResult rp_mm_access_with_def_attr(RemotePort *rp, uint32_t rp_dev,
+                                       struct rp_peer_state *peer,
+                                       MemoryTransaction *tr,
+                                       bool relative, uint64_t offset,
+                                       uint32_t def_attr);
+#endif
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index 1d8b64925a..e5dfaf7c3b 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -151,4 +151,6 @@ void rp_process(RemotePort *s);
 
 ssize_t rp_write(RemotePort *s, const void *buf, size_t count);
 
+struct rp_peer_state *rp_get_peer(RemotePort *s);
+
 #endif
-- 
2.43.0


