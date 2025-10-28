Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1494CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstU-0002wj-E7; Tue, 28 Oct 2025 19:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstS-0002wV-Ny
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:22 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstA-00015S-4f
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:22 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 2453281706;
 Wed, 29 Oct 2025 02:13:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-KqnPbGSV; Wed, 29 Oct 2025 02:13:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693237;
 bh=Ll76idKmX5Ptpr+6lLa70BZKdy1c2Q/mIS+RNqLYjdY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=hcsXQXMjxTzkA4W7Jl3CF+Y/J5SBGZcPgyZWhHi4p8pwW3+zvMuLk1T5r8FvNZlw9
 C6Z2W5GxmhbExxIR4Q9YC7UVcJdyDXpKhrp4QLJxcR8Y/uyaGdLAj9fzyCjilBv0gO
 w1Rn8sI7NVF/YHjP6IDMxBlj+JCFoG6XyFzYAwck=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 09/22] hw/pci/pci: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:33 +0300
Message-ID: <20251028231347.194844-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/pci.c | 66 +++++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index acc03fd470..c66bfd96fa 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -786,8 +786,9 @@ int pci_bus_numa_node(PCIBus *bus)
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
@@ -800,12 +801,12 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
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
@@ -819,28 +820,30 @@ static int get_pci_config_device(QEMUFile *f, void *pv, size_t size,
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
@@ -848,9 +851,9 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
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
 
@@ -858,11 +861,12 @@ static int get_pci_irq_state(QEMUFile *f, void *pv, size_t size,
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
@@ -871,13 +875,13 @@ static int put_pci_irq_state(QEMUFile *f, void *pv, size_t size,
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
@@ -890,17 +894,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
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
@@ -926,19 +930,17 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
      * This makes us compatible with old devices
      * which never set or clear this bit. */
     s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
-    vmstate_save_state(f, &vmstate_pci_device, s, NULL, &error_fatal);
+    vmstate_save_vmsd(f, &vmstate_pci_device, s, NULL, &error_fatal);
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
 }
 
 int pci_device_load(PCIDevice *s, QEMUFile *f)
 {
-    int ret;
-    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
-                             &error_fatal);
+    vmstate_load_vmsd(f, &vmstate_pci_device, s, s->version_id, &error_fatal);
     /* Restore the interrupt status bit. */
     pci_update_irq_status(s);
-    return ret;
+    return 0;
 }
 
 static void pci_set_default_subsystem_id(PCIDevice *pci_dev)
-- 
2.48.1


