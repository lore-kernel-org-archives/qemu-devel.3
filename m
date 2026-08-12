Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A491C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8eZ-0000RI-KZ; Wed, 12 Aug 2026 09:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8eA-0008MM-Eh; Wed, 12 Aug 2026 09:05:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8e8-0004u1-PI; Wed, 12 Aug 2026 09:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539783; bh=l+gqMS0oNGQKnhuV2H7zb9b46FmVN46P3CJ2NQuPNCM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kS5Cpd6nVcK5j3QpxjoQx/rO37EX/36LGVCLy+6uPcgp616VBJqN5JFTQxY17WdwI
 K+UTMGOJy3NiM16365owbDlbZ2xwUDZSzTzGcNX/bdPP8RDowbyx5qNu3KpQz1tkOI
 vgdN8EKmJ+xyGZGqHGFs9XbPi4oDyj/uRkAkgR2a4mqR92GT7mil2wnnfpo9IKKxQM
 cee9FeYrAKMai4ScYem87hSmDiMfvsFBeaHG/zPxoFfoxzq3yjf0vUiWeED3oXTwPw
 o5MXxW0V+9Tg8t7r3D00Kk2w+mWjf2SVrVR45RIPMn7+ekC3LD0AT60jtr8cNrFrdh
 /YLNw8kcpRYig==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91C231CA49B;
 Wed, 12 Aug 2026 16:03:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C6E8B409B7E;
 Wed, 12 Aug 2026 16:03:14 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 155422F8CC; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Haotian Jiang <sundayjiang@tencent.com>,
 Haotian Jiang <jianghaotian.sunday@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 028/102] hw/display/qxl: unregister vm_change_state
 handler and BHs
Date: Wed, 12 Aug 2026 16:01:03 +0300
Message-ID: <20260812130233.621965-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Haotian Jiang <sundayjiang@tencent.com>

qxl_realize_common() registers a vm_change_state handler via
qemu_add_vm_change_state_handler() and creates three bottom halves
(update_irq, update_area_bh, cursor_bh), but none are ever cleaned up.
The return value of qemu_add_vm_change_state_handler() is discarded, so
the handler is never removed from the global list, and there is no
PCIDeviceClass.exit callback to delete the BHs.

When a secondary QXL device (hotpluggable by default) is hot-unplugged
via device_del, the PCIQXLDevice memory is freed but the vm_state
handler and BH entries remain with dangling opaque pointers. On the
next VM state change (stop/cont/migrate) or BH dispatch, the callback
dereferences freed memory, causing a use-after-free.

Fix this by storing the VMChangeStateEntry returned by
qemu_add_vm_change_state_handler() and adding a qxl_exit() callback
that deletes the vm_state handler, all three BHs, and the
guest_surfaces.cmds allocation before the device memory is freed.

Fixes: a19cbfb34642 ("spice: add qxl device")
Fixes: CVE-2026-63322
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3607
Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
Cc: qemu-stable@nongnu.org
[ Marc-André - tweak commit message, add TODO ]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260720024855.3757499-1-jianghaotian.sunday@gmail.com>
(cherry picked from commit 4727cc883b7e81d2c30b9801af54482d65b84292)
(Mjt: context fixup across v10.0.0-263-g12d1a768bdfe
 "qom: Have class_init() take a const data argument")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 04314eabe78..2a599761b5a 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2223,7 +2223,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     }
 #endif
 
-    qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
+    qxl->vmstate_handler =
+        qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
 
     qxl->update_irq = qemu_bh_new_guarded(qxl_update_irq_bh, qxl,
                                           &DEVICE(qxl)->mem_reentrancy_guard);
@@ -2498,6 +2499,18 @@ static const Property qxl_properties[] = {
         DEFINE_PROP_BOOL("global-vmstate", PCIQXLDevice, vga.global_vmstate, false),
 };
 
+static void qxl_exit(PCIDevice *dev)
+{
+    PCIQXLDevice *qxl = PCI_QXL(dev);
+
+    /* TODO: complete cleanup, error paths etc */
+    g_clear_pointer(&qxl->vmstate_handler, qemu_del_vm_change_state_handler);
+    g_clear_pointer(&qxl->update_irq, qemu_bh_delete);
+    g_clear_pointer(&qxl->update_area_bh, qemu_bh_delete);
+    g_clear_pointer(&qxl->ssd.cursor_bh, qemu_bh_delete);
+    g_clear_pointer(&qxl->guest_surfaces.cmds, g_free);
+}
+
 static void qxl_pci_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2505,6 +2518,7 @@ static void qxl_pci_class_init(ObjectClass *klass, void *data)
 
     k->vendor_id = REDHAT_PCI_VENDOR_ID;
     k->device_id = QXL_DEVICE_ID_STABLE;
+    k->exit = qxl_exit;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     device_class_set_legacy_reset(dc, qxl_reset_handler);
     dc->vmsd = &qxl_vmstate;
diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index e0a85a5ca49..ddbab3d693a 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -83,6 +83,7 @@ struct PCIQXLDevice {
 
     /* thread signaling */
     QEMUBH             *update_irq;
+    VMChangeStateEntry *vmstate_handler;
 
     /* ram pci bar */
     QXLRam             *ram;
-- 
2.47.3


