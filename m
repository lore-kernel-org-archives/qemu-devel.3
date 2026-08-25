Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BBFC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr0-0005pI-Fa; Tue, 25 Aug 2026 17:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqz-0005oL-Ez
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:45 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqx-00052V-7z
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id E17CE80BD7;
 Wed, 26 Aug 2026 00:38:41 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-Of8Wnvu5; Wed, 26 Aug 2026 00:38:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693921;
 bh=7xut4V9uJ3hS49dZ2pwxsuX/aPSjisN0ILr5Fb+X2Lc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=rkC/fVGVdKtenWN47/0O2FEO2zxmrtQKKMtVB9tTCBkO6sJMdg6NkGp/P5uBb9YiR
 HsrnDomMUZ7QF/uI4YWDD2csw2AAgaG5LNr0FtcsPvued+byLNAGhx/KrfyyMZJhO0
 KH37TG81DQKa+xDmp5KQ3o5keGr5IqJwgCdThRyM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 11/30] hw/pci/pci: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:51 +0300
Message-ID: <20260825213811.3725682-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/pci.c | 58 ++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76d006fa1d7..0f70f0f7af8 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -807,8 +807,9 @@ int pci_bus_numa_node(PCIBus *bus)
     return PCI_BUS_GET_CLASS(bus)->numa_node(bus);
 }
 
-static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
-                                 const VMStateField *field)
+static bool load_pci_config_device(QEMUFile *f, void *pv, size_t size,
+                                   const VMStateField *field,
+                                   Error **errp)
 {
     PCIDevice *s = container_of(pv, PCIDevice, config);
     uint8_t *config;
@@ -821,12 +822,12 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
     for (i = 0; i < size; ++i) {
         if ((config[i] ^ s->config[i]) &
             s->cmask[i] & ~s->wmask[i] & ~s->w1cmask[i]) {
-            error_report("%s: Bad config data: i=0x%x read: %x device: %x "
-                         "cmask: %x wmask: %x w1cmask:%x", __func__,
-                         i, config[i], s->config[i],
-                         s->cmask[i], s->wmask[i], s->w1cmask[i]);
+            error_setg(errp, "%s: Bad config data: i=0x%x read: %x device: %x "
+                       "cmask: %x wmask: %x w1cmask:%x", __func__,
+                       i, config[i], s->config[i],
+                       s->cmask[i], s->wmask[i], s->w1cmask[i]);
             g_free(config);
-            return -EINVAL;
+            return false;
         }
     }
     memcpy(s->config, config, size);
@@ -840,28 +841,30 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
                       & PCI_COMMAND_MASTER);
 
     g_free(config);
-    return 0;
+    return true;
 }
 
 /* just put buffer */
-static int put_pci_config_device(QEMUFile *f, void *pv, size_t size,
-                                 const VMStateField *field, JSONWriter *vmdesc)
+static bool save_pci_config_device(QEMUFile *f, void *pv, size_t size,
+                                   const VMStateField *field,
+                                   JSONWriter *vmdesc, Error **errp)
 {
     const uint8_t **v = pv;
     assert(size == pci_config_size(container_of(pv, PCIDevice, config)));
     qemu_put_buffer(f, *v, size);
 
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_pci_config = {
     .name = "pci config",
-    .get  = get_pci_config_device,
-    .put  = put_pci_config_device,
+    .load  = load_pci_config_device,
+    .save  = save_pci_config_device,
 };
 
-static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
-                             const VMStateField *field)
+static bool load_pci_irq_state(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field,
+                               Error **errp)
 {
     PCIDevice *s = container_of(pv, PCIDevice, irq_state);
     uint32_t irq_state[PCI_NUM_PINS];
@@ -869,9 +872,9 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
     for (i = 0; i < PCI_NUM_PINS; ++i) {
         irq_state[i] = qemu_get_be32(f);
         if (irq_state[i] != 0x1 && irq_state[i] != 0) {
-            fprintf(stderr, "irq state %d: must be 0 or 1.\n",
-                    irq_state[i]);
-            return -EINVAL;
+            error_setg(errp, "irq state %d: must be 0 or 1.",
+                       irq_state[i]);
+            return false;
         }
     }
 
@@ -879,11 +882,12 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
         pci_set_irq_state(s, i, irq_state[i]);
     }
 
-    return 0;
+    return true;
 }
 
-static int put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
-                             const VMStateField *field, JSONWriter *vmdesc)
+static bool save_pci_irq_state(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, JSONWriter *vmdesc,
+                               Error **errp)
 {
     int i;
     PCIDevice *s = container_of(pv, PCIDevice, irq_state);
@@ -892,13 +896,13 @@ static int put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
         qemu_put_be32(f, pci_irq_state(s, i));
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_pci_irq_state = {
     .name = "pci irq state",
-    .get  = get_pci_irq_state,
-    .put  = put_pci_irq_state,
+    .load = load_pci_irq_state,
+    .save = save_pci_irq_state,
 };
 
 static bool migrate_is_pcie(void *opaque, int version_id)
@@ -911,17 +915,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
     return !pci_is_express((PCIDevice *)opaque);
 }
 
-static int pci_post_load(void *opaque, int version_id)
+static bool pci_post_load(void *opaque, int version_id, Error **errp)
 {
     pcie_sriov_pf_post_load(opaque);
-    return 0;
+    return true;
 }
 
 const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
-    .post_load = pci_post_load,
+    .post_load_errp = pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
-- 
2.43.0


