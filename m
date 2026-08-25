Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8F0C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqt-0005k3-JG; Tue, 25 Aug 2026 17:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqs-0005jK-Py
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:38 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqp-0004zM-II
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 6940180BD7;
 Wed, 26 Aug 2026 00:38:32 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-jQ7aX7kL; Wed, 26 Aug 2026 00:38:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693911;
 bh=Jtp5jaohUch9p7DJWj0nHlAm99nPRCLA8RD+DhZUNT8=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=tU86OouqxmIQK/IFGRN/g3JwvC3N38nfvckqaL0Ok2hkLl1cAnv1Zb7Ob9OL0eQ4+
 zFxI0xSJ9rvxyn0UL0+XPmJZaQCgDxYX9pGyGaBBXZFZOR9pue35TnEsvVTzNpGfI6
 GUdPuSab3lByevRhQJ5dTMcMZjFmlhMuYsA4Mi0E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 03/30] hw/virtio: extra state: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:43 +0300
Message-ID: <20260825213811.3725682-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Stop ignoring the error on save path.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/virtio/virtio-mmio.c        | 21 ++++++---------------
 hw/virtio/virtio-pci.c         | 21 ++++++---------------
 hw/virtio/virtio.c             | 24 +++++++++++++-----------
 include/hw/virtio/virtio-bus.h |  4 ++--
 4 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 55ceaeef5fc..559363e4438 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -606,29 +606,20 @@ static const VMStateDescription vmstate_virtio_mmio = {
     }
 };
 
-static void virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f)
+static bool virtio_mmio_save_extra_state(DeviceState *opaque, QEMUFile *f,
+                                         Error **errp)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
-    Error *local_err = NULL;
-    int ret;
 
-    ret = vmstate_save_state(f, &vmstate_virtio_mmio, proxy, NULL, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    return vmstate_save_vmsd(f, &vmstate_virtio_mmio, proxy, NULL, errp);
 }
 
-static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
+static bool virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f,
+                                         Error **errp)
 {
     VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
-    Error *local_err = NULL;
-    int ret;
 
-    ret = vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
-    return ret;
+    return vmstate_load_vmsd(f, &vmstate_virtio_mmio, proxy, 1, errp);
 }
 
 static bool virtio_mmio_has_extra_state(DeviceState *opaque)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 6f5db5fc42b..7a5d4f35e33 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -184,29 +184,20 @@ static bool virtio_pci_has_extra_state(DeviceState *d)
     return true;
 }
 
-static void virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f)
+static bool virtio_pci_save_extra_state(DeviceState *d, QEMUFile *f,
+                                        Error **errp)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    Error *local_err = NULL;
-    int ret;
 
-    ret = vmstate_save_state(f, &vmstate_virtio_pci, proxy, NULL, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
+    return vmstate_save_vmsd(f, &vmstate_virtio_pci, proxy, NULL, errp);
 }
 
-static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
+static bool virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f,
+                                        Error **errp)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    Error *local_err = NULL;
-    int ret;
 
-    ret = vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &local_err);
-    if (ret < 0) {
-        error_report_err(local_err);
-    }
-    return ret;
+    return vmstate_load_vmsd(f, &vmstate_virtio_pci, proxy, 1, errp);
 }
 
 static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index daa5607338c..8230a383aff 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2914,35 +2914,37 @@ static const VMStateDescription vmstate_virtio_ringsize = {
     }
 };
 
-static int get_extra_state(QEMUFile *f, void *pv, size_t size,
-                           const VMStateField *field)
+static bool load_extra_state(QEMUFile *f, void *pv, size_t size,
+                             const VMStateField *field,
+                             Error **errp)
 {
     VirtIODevice *vdev = pv;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
     if (!k->load_extra_state) {
-        return -1;
-    } else {
-        return k->load_extra_state(qbus->parent, f);
+        error_setg(errp, "extra state is unsupported");
+        return false;
     }
+
+    return k->load_extra_state(qbus->parent, f, errp);
 }
 
-static int put_extra_state(QEMUFile *f, void *pv, size_t size,
-                           const VMStateField *field, JSONWriter *vmdesc)
+static bool save_extra_state(QEMUFile *f, void *pv, size_t size,
+                             const VMStateField *field, JSONWriter *vmdesc,
+                             Error **errp)
 {
     VirtIODevice *vdev = pv;
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
-    k->save_extra_state(qbus->parent, f);
-    return 0;
+    return k->save_extra_state(qbus->parent, f, errp);
 }
 
 static const VMStateInfo vmstate_info_extra_state = {
     .name = "virtqueue_extra_state",
-    .get = get_extra_state,
-    .put = put_extra_state,
+    .load = load_extra_state,
+    .save = save_extra_state,
 };
 
 static const VMStateDescription vmstate_virtio_extra_state = {
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index f80fd714244..255ecb2fcb2 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -43,11 +43,11 @@ struct VirtioBusClass {
     void (*notify)(DeviceState *d, uint16_t vector);
     void (*save_config)(DeviceState *d, QEMUFile *f);
     void (*save_queue)(DeviceState *d, int n, QEMUFile *f);
-    void (*save_extra_state)(DeviceState *d, QEMUFile *f);
+    bool (*save_extra_state)(DeviceState *d, QEMUFile *f, Error **errp);
     int (*load_config)(DeviceState *d, QEMUFile *f);
     int (*load_queue)(DeviceState *d, int n, QEMUFile *f);
     int (*load_done)(DeviceState *d, QEMUFile *f);
-    int (*load_extra_state)(DeviceState *d, QEMUFile *f);
+    bool (*load_extra_state)(DeviceState *d, QEMUFile *f, Error **errp);
     bool (*has_extra_state)(DeviceState *d);
     bool (*query_guest_notifiers)(DeviceState *d);
     int (*set_guest_notifiers)(DeviceState *d, int nvqs, bool assign);
-- 
2.43.0


