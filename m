Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C10C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 13:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGw4-0000K8-H9; Mon, 01 Jul 2024 09:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sOGvw-0000G1-Vv
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:19:05 -0400
Received: from mail.xenproject.org ([104.130.215.37])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony@xenproject.org>)
 id 1sOGvd-0007ub-DO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 09:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=xenproject.org; s=20200302mail; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=xwhPXZgnf2ShtahzS2ZragTwFKjTepc0etNckiWQG/8=; b=0FAej2CnIaurGLWoXc42EvwX4e
 KYgTnmGFwh7kQoO3zNpIKl2+Dv2atVZLculYNNscVXbJELPE74L/TYBk4lxxVfmT8TS8FqH7D9Pm5
 8jEmLWSR0RjvU8sGY6YfbG95wBjnGJgxmSZNrPnFDrGiZaaRiROPh0W6dyi1/bsXDREg=;
Received: from xenbits.xenproject.org ([104.239.192.120])
 by mail.xenproject.org with esmtp (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sOGva-0006nk-QH; Mon, 01 Jul 2024 13:18:42 +0000
Received: from lfbn-lyo-1-451-148.w2-7.abo.wanadoo.fr ([2.7.43.148]
 helo=l14.home) by xenbits.xenproject.org with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <anthony@xenproject.org>)
 id 1sOGva-0000WF-HL; Mon, 01 Jul 2024 13:18:42 +0000
From: anthony@xenproject.org
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Subject: [PULL 2/3] xen: fix stubdom PCI addr
Date: Mon,  1 Jul 2024 15:18:32 +0200
Message-Id: <20240701131833.29486-3-anthony@xenproject.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701131833.29486-1-anthony@xenproject.org>
References: <20240701131833.29486-1-anthony@xenproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.130.215.37;
 envelope-from=anthony@xenproject.org; helo=mail.xenproject.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

From: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

When running in a stubdomain, the config space access via sysfs needs to
use BDF as seen inside stubdomain (connected via xen-pcifront), which is
different from the real BDF. For other purposes (hypercall parameters
etc), the real BDF needs to be used.
Get the in-stubdomain BDF by looking up relevant PV PCI xenstore
entries.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <35049e99da634a74578a1ff2cb3ae4cc436ede33.1711506237.git-series.marmarek@invisiblethingslab.com>
Signed-off-by: Anthony PERARD <anthony@xenproject.org>
---
 hw/xen/xen-host-pci-device.c | 76 +++++++++++++++++++++++++++++++++++-
 hw/xen/xen-host-pci-device.h |  6 +++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-host-pci-device.c b/hw/xen/xen-host-pci-device.c
index 8c6e9a1716..eaf32f2710 100644
--- a/hw/xen/xen-host-pci-device.c
+++ b/hw/xen/xen-host-pci-device.c
@@ -9,6 +9,8 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
+#include "hw/xen/xen-legacy-backend.h"
+#include "hw/xen/xen-bus-helper.h"
 #include "xen-host-pci-device.h"
 
 #define XEN_HOST_PCI_MAX_EXT_CAP \
@@ -33,13 +35,73 @@
 #define IORESOURCE_PREFETCH     0x00001000      /* No side effects */
 #define IORESOURCE_MEM_64       0x00100000
 
+/*
+ * Non-passthrough (dom0) accesses are local PCI devices and use the given BDF
+ * Passthough (stubdom) accesses are through PV frontend PCI device.  Those
+ * either have a BDF identical to the backend's BDF (xen-backend.passthrough=1)
+ * or a local virtual BDF (xen-backend.passthrough=0)
+ *
+ * We are always given the backend's BDF and need to lookup the appropriate
+ * local BDF for sysfs access.
+ */
+static void xen_host_pci_fill_local_addr(XenHostPCIDevice *d, Error **errp)
+{
+    unsigned int num_devs, len, i;
+    unsigned int domain, bus, dev, func;
+    char *be_path = NULL;
+    char path[16];
+
+    be_path = qemu_xen_xs_read(xenstore, 0, "device/pci/0/backend", &len);
+    if (!be_path) {
+        error_setg(errp, "Failed to read device/pci/0/backend");
+        goto out;
+    }
+
+    if (xs_node_scanf(xenstore, 0, be_path, "num_devs", NULL,
+                      "%d", &num_devs) != 1) {
+        error_setg(errp, "Failed to read or parse %s/num_devs", be_path);
+        goto out;
+    }
+
+    for (i = 0; i < num_devs; i++) {
+        snprintf(path, sizeof(path), "dev-%d", i);
+        if (xs_node_scanf(xenstore, 0, be_path, path, NULL,
+                          "%x:%x:%x.%x", &domain, &bus, &dev, &func) != 4) {
+            error_setg(errp, "Failed to read or parse %s/%s", be_path, path);
+            goto out;
+        }
+        if (domain != d->domain ||
+                bus != d->bus ||
+                dev != d->dev ||
+                func != d->func)
+            continue;
+        snprintf(path, sizeof(path), "vdev-%d", i);
+        if (xs_node_scanf(xenstore, 0, be_path, path, NULL,
+                          "%x:%x:%x.%x", &domain, &bus, &dev, &func) != 4) {
+            error_setg(errp, "Failed to read or parse %s/%s", be_path, path);
+            goto out;
+        }
+        d->local_domain = domain;
+        d->local_bus = bus;
+        d->local_dev = dev;
+        d->local_func = func;
+        goto out;
+    }
+    error_setg(errp, "Failed to find PCI device %x:%x:%x.%x in xenstore",
+               d->domain, d->bus, d->dev, d->func);
+
+out:
+    free(be_path);
+}
+
 static void xen_host_pci_sysfs_path(const XenHostPCIDevice *d,
                                     const char *name, char *buf, ssize_t size)
 {
     int rc;
 
     rc = snprintf(buf, size, "/sys/bus/pci/devices/%04x:%02x:%02x.%d/%s",
-                  d->domain, d->bus, d->dev, d->func, name);
+                  d->local_domain, d->local_bus, d->local_dev, d->local_func,
+                  name);
     assert(rc >= 0 && rc < size);
 }
 
@@ -342,6 +404,18 @@ void xen_host_pci_device_get(XenHostPCIDevice *d, uint16_t domain,
     d->dev = dev;
     d->func = func;
 
+    if (xen_is_stubdomain) {
+        xen_host_pci_fill_local_addr(d, errp);
+        if (*errp) {
+            goto error;
+        }
+    } else {
+        d->local_domain = d->domain;
+        d->local_bus = d->bus;
+        d->local_dev = d->dev;
+        d->local_func = d->func;
+    }
+
     xen_host_pci_config_open(d, errp);
     if (*errp) {
         goto error;
diff --git a/hw/xen/xen-host-pci-device.h b/hw/xen/xen-host-pci-device.h
index 4d8d34ecb0..270dcb27f7 100644
--- a/hw/xen/xen-host-pci-device.h
+++ b/hw/xen/xen-host-pci-device.h
@@ -23,6 +23,12 @@ typedef struct XenHostPCIDevice {
     uint8_t dev;
     uint8_t func;
 
+    /* different from the above in case of stubdomain */
+    uint16_t local_domain;
+    uint8_t local_bus;
+    uint8_t local_dev;
+    uint8_t local_func;
+
     uint16_t vendor_id;
     uint16_t device_id;
     uint32_t class_code;
-- 
Anthony PERARD


