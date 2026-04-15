Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5318F42105
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD4CR-000096-QQ; Wed, 15 Apr 2026 13:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wD4CN-00008p-PY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:38:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wD4CL-0002ic-LP
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:38:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a14c31eeso57112605e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776274724; x=1776879524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fm1uSt8v3N52EDQqCSTygQcIRULkfTeQnbM96/UzDVE=;
 b=pvcTJWYig9Y7xnLHJRjDa26f7/zCGCFBvCfoXrE0Bp/oCi4Lm02pKuicKkEyykv8Xo
 ggvlhtwsW6TsH3PJ/1PBBlrvapjI1SLF40mx/50XjDNpEsPkztrgitQYQLbrUcmrxLc8
 bmlPizUwZQZnNSJ0zDqa4l3MQnIc4oivZK8Gqoe7EL+eW12QV9FgWzNjJwVzgdbQZECT
 fWbotsaSetlDStYjD3quLgTngMUZqLFmkIHa4HGw1YFmscLGTpxtJ96z+uFzwwNxvCyO
 z4+5ViyOJ7ZxV8fOSe6KU9whxV3b0NoiWlXRGA/6Z1gg7U4uCgS68jfWCyuvZxGMhhek
 CQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776274724; x=1776879524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fm1uSt8v3N52EDQqCSTygQcIRULkfTeQnbM96/UzDVE=;
 b=icAFcHgTcRfnCNbnotKaOCkibtg3gNPtuTWuc9fwtwQMr2vk80a5n8T4HXNFxC9Mb/
 3y0kUu68775ws8e8Fo+FjGeq4J3JsouB9NqCgwr5irwsZvPIBrAsGuTuvSGxXNG9+iMN
 AkHIL7BFtwwGnhxNlLFE9H+54nqLvGTRESA17UeJ0UtiGPAjIA3/8cBQIpaCxxTUwwGp
 qoujCeXwNX2912DzkexfFR9PjybP1om2ZfNO+eXfy3h3IySxuCUw3z3j/ZgfpUsun88K
 G+UwD1cJxGveLjVFJau3Qk/3zKynBd5Y2C/33XaXm6goupJRI4XLXstTuLaJpS+494kE
 DUYg==
X-Gm-Message-State: AOJu0YzBs/MaPLpscPhTdtV3FGLOic4Xv4MIH6zmDgU+rvn5tyeoUUGt
 QOLh0ej8khM5sGJymjp2oOp4yL4IIJCopPf4MOGY82wRmQe8yG6MewyDqP5VdYLhefstlaGfxxC
 3Lhp6T+4xxmy1vArWUokNIOtJdV/A3Iinejjvkd1SWEjybDWJUUKgxgcMvwAtrsXjp8GxnhBgxd
 QY1VasDhc6uQwHkbeYV/BW47vF1tpxmMu7yzXZNIY=
X-Gm-Gg: AeBDievTkhRKH/LkzR0T2Mu9547OU9kxPBtqpB/nkSAR82sAk7EA1bqb25/cw97wRFw
 MLOVpBcI9H7Y5eFeZ8/KfBtZFfYg+TySWRq7JiuFARvtNoiwiZyTN+gjB6ypCS5RIcjgpafVV1b
 63pGKyRkV04zGl0cW3Ot/UsydkupaqQcFUoeJIkXW7RKNx2QAfAGl+T91R3lG8qI3c+jyrQvNJ4
 ZG1MZ11W/F36pKofAj67/0uSc8ZN3e4n+TQk6SXKfyvwsnk/Ur6BU6Ds+tLP37Mg0saSTJmLIBb
 qPoCSeGmWFZVjxMexlT1rSP/5F0N+4MCrz6sQfohyzzhzmre+1qOLXgEAOSc+CAvcI1E/XkKIzJ
 ckaN00Mj3IiyRgxzwmQORp5ihMKf4gwzgvkUh8WqCxkWn46Bl4RCBxu/YDqNDlrWqoAxPbl3qv/
 nxiVBCmTtghqhZYxMNCInEJ0K4ezvXBsmRzOwV7Jx/Ie66rlJNSsEWv3oJFoLbYR+9O3o0RGNgB
 5MYoQhRJ5JxtpO5mvMX6dDKRHfkBWOmSx85xhi9vsebrpWc1C1BhcK67N2tN6oakwfoFsw=
X-Received: by 2002:a05:600c:c10d:b0:488:ae4e:51a5 with SMTP id
 5b1f17b1804b1-488d683d633mr217192825e9.15.1776274723436; 
 Wed, 15 Apr 2026 10:38:43 -0700 (PDT)
Received: from localhost (2a01cb001411480010f92e9cd3b40a22.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:10f9:2e9c:d3b4:a22])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488f0ea65b9sm39069835e9.5.2026.04.15.10.38.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 10:38:43 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 mr-083 <matthieu@min.io>
Subject: [PATCH v4] hw/nvme: add namespace hotplug support
Date: Wed, 15 Apr 2026 19:38:52 +0200
Message-ID: <20260415173852.71135-1-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409060155.94704-1-matthieu@min.io>
References: <20260409060155.94704-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add hotplug support for nvme-ns devices on the NvmeBus. This enables
NVMe namespace-level hot-add and hot-remove via device_add and
device_del with proper Asynchronous Event Notification (AEN), so the
guest kernel can react to namespace topology changes.

Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
hotplug handler with proper plug and unplug callbacks:

- plug: attach namespace to all started controllers and send an
  Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
  the guest kernel rescans namespaces and adds the block device
- unplug: drain in-flight I/O, detach from all controllers, send
  AEN, then unrealize the device. The guest kernel rescans and
  removes the block device.

The plug handler skips controllers that haven't started yet
(qs_created == false) to avoid interfering with boot-time namespace
attachment in nvme_start_ctrl().

The unplug handler drains in-flight I/O via nvme_ns_drain() before
detaching the namespace from controllers, so pending requests can
complete normally without touching freed state.

For symmetry with nvme_ns_realize() which sets subsys->namespaces[nsid],
nvme_ns_unrealize() now clears that slot too making the namespace
lifecycle complete.

Both the controller bus and subsystem bus are configured as hotplug
handlers via qbus_set_bus_hotplug_handler() since nvme-ns devices
may reparent to the subsystem bus during realize.

Example hot-swap sequence using the NVMe subsystem model:

  # Boot with: -device nvme-subsys,id=subsys0
  #            -device nvme,id=ctrl0,subsys=subsys0
  #            -device nvme-ns,id=ns0,drive=drv0,bus=ctrl0,nsid=1

  device_del ns0             # guest receives AEN, removes /dev/nvme0n1
  drive_del drv0
  drive_add 0 file=disk.qcow2,format=qcow2,id=drv0,if=none
  device_add nvme-ns,id=ns0,drive=drv0,bus=ctrl0,nsid=1
                              # guest receives AEN, adds /dev/nvme0n1

Tested with Linux 6.1 guest (NVMe driver processes AEN and rescans
namespace list automatically).

Signed-off-by: Matthieu <matthieu@min.io>
---
 hw/nvme/ctrl.c   | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c     |  8 +++++
 hw/nvme/subsys.c |  2 ++
 3 files changed, 98 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index be6c7028cb..2024b0ff75 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -206,6 +206,7 @@
 #include "system/hostmem.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
+#include "hw/core/qdev.h"
 #include "system/spdm-socket.h"
 #include "migration/vmstate.h"
 
@@ -9293,6 +9294,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     qbus_init(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id);
+    qbus_set_bus_hotplug_handler(BUS(&n->bus));
 
     if (nvme_init_subsys(n, errp)) {
         return;
@@ -9553,10 +9555,96 @@ static const TypeInfo nvme_info = {
     },
 };
 
+static void nvme_ns_hot_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
+{
+    NvmeNamespace *ns = NVME_NS(dev);
+    NvmeSubsystem *subsys = ns->subsys;
+    uint32_t nsid = ns->params.nsid;
+    int i;
+
+    /*
+     * Attach to all started controllers and notify via AEN.
+     * Skip controllers that haven't started yet (boot-time realize) —
+     * nvme_start_ctrl() will attach namespaces during controller init.
+     */
+    for (i = 0; i < NVME_MAX_CONTROLLERS; i++) {
+        NvmeCtrl *ctrl = nvme_subsys_ctrl(subsys, i);
+        if (!ctrl || !ctrl->qs_created) {
+            continue;
+        }
+
+        if (nvme_csi_supported(ctrl, ns->csi) && !ns->params.detached) {
+            nvme_attach_ns(ctrl, ns);
+            nvme_update_dsm_limits(ctrl, ns);
+
+            if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
+                nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
+                                   NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
+                                   NVME_LOG_CHANGED_NSLIST);
+            }
+        }
+    }
+}
+
+static void nvme_ns_hot_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
+{
+    NvmeNamespace *ns = NVME_NS(dev);
+    NvmeSubsystem *subsys = ns->subsys;
+    uint32_t nsid = ns->params.nsid;
+    int i;
+
+    /*
+     * Drain in-flight I/O before tearing down the namespace.
+     * This must happen while the namespace is still attached to the
+     * controllers so any pending requests can complete normally.
+     */
+    nvme_ns_drain(ns);
+
+    /*
+     * Detach from all controllers and notify the guest via AEN.
+     * The guest kernel will rescan namespaces and remove the block device.
+     */
+    for (i = 0; i < NVME_MAX_CONTROLLERS; i++) {
+        NvmeCtrl *ctrl = nvme_subsys_ctrl(subsys, i);
+        if (!ctrl || !nvme_ns(ctrl, nsid)) {
+            continue;
+        }
+
+        nvme_detach_ns(ctrl, ns);
+        nvme_update_dsm_limits(ctrl, NULL);
+
+        if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
+            nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
+                               NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
+                               NVME_LOG_CHANGED_NSLIST);
+        }
+    }
+
+    /*
+     * Unrealize: removes from subsystem (in nvme_ns_unrealize), flushes,
+     * cleans up structures, and removes from QOM.
+     */
+    qdev_unrealize(dev);
+}
+
+static void nvme_bus_class_init(ObjectClass *klass, const void *data)
+{
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+    hc->plug = nvme_ns_hot_plug;
+    hc->unplug = nvme_ns_hot_unplug;
+}
+
 static const TypeInfo nvme_bus_info = {
     .name = TYPE_NVME_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(NvmeBus),
+    .class_init = nvme_bus_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    },
 };
 
 static void nvme_register_types(void)
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index b0106eaa5c..f4f755c6fc 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -719,10 +719,17 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
 static void nvme_ns_unrealize(DeviceState *dev)
 {
     NvmeNamespace *ns = NVME_NS(dev);
+    NvmeSubsystem *subsys = ns->subsys;
+    uint32_t nsid = ns->params.nsid;
 
     nvme_ns_drain(ns);
     nvme_ns_shutdown(ns);
     nvme_ns_cleanup(ns);
+
+    /* Symmetric with nvme_ns_realize() which sets subsys->namespaces[nsid]. */
+    if (subsys && nsid && subsys->namespaces[nsid] == ns) {
+        subsys->namespaces[nsid] = NULL;
+    }
 }
 
 void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
@@ -937,6 +944,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
     dc->bus_type = TYPE_NVME_BUS;
     dc->realize = nvme_ns_realize;
     dc->unrealize = nvme_ns_unrealize;
+    dc->hotpluggable = true;
     device_class_set_props(dc, nvme_ns_props);
     dc->desc = "Virtual NVMe namespace";
 }
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 777e1c620f..fa35055d3c 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "hw/core/qdev.h"
 
 #include "nvme.h"
 
@@ -205,6 +206,7 @@ static void nvme_subsys_realize(DeviceState *dev, Error **errp)
     NvmeSubsystem *subsys = NVME_SUBSYS(dev);
 
     qbus_init(&subsys->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id);
+    qbus_set_bus_hotplug_handler(BUS(&subsys->bus));
 
     nvme_subsys_setup(subsys, errp);
 }
-- 
2.53.0


