Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E54C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsH-0006Ak-V9; Mon, 27 Jul 2026 07:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsF-00061T-KL
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsD-0003ha-Kw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u2ZZmmA7la3LPIJb4HIyU9FC0Vdh1HZQjE97gHf8bEo=;
 b=WnAl57lC0MSWvZNtbGj7NIdnDLtZgKV0uPujM//Si6uIT0p5zPpzMaOjPBUIBvO2yraSsP
 LGsht4L10jvK68sel0UfmL7t+cvxkLjJOMjt/FhyVEx0bguFk4MfKMww/PRNIfiks83138
 W/bP5PYIK9JvD+Rm7XaXsFEc6sbRcgI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-fo0m1F-OPDOsi-ScUYlNBQ-1; Mon,
 27 Jul 2026 07:51:55 -0400
X-MC-Unique: fo0m1F-OPDOsi-ScUYlNBQ-1
X-Mimecast-MFC-AGG-ID: fo0m1F-OPDOsi-ScUYlNBQ_1785153115
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA754195E919
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 11:51:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD97B30010CC; Mon, 27 Jul 2026 11:51:53 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:13 +0400
Subject: [GIT PULL 04/23] hw/display/qxl: unregister vm_change_state
 handler and BHs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix-v1-4-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3556;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=H9fIokRleIlkTHgJZ2eUvb/iq6NOB2CFAfALJqXMA6Q=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y+HW8m6PdkG5/CMb/0371yVzAc/23S+nLIH
 VDLE+t1vIiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5V/xEACvalF74K4x19tCzcY/C7scyYjAEuBI5EJXnNAYw7xbU7SJxHmVDyEmPaGr1kYSsO0oX3f
 8bO/ID+FQQdCbQsDOrSBuZhTRjlwGRzQhmMahgJNsVWt08AG/gY+bgXmLfJtvhU+wUm7JQmCDyX
 JrvI4TZOVVy6l/HEFoJqJbrpXzTUQ/Zw52pCN0K/Xrsnw1OySqJjKfJvKKuq05WVJYPykHKQxzr
 nR+77NaNCo5w9c2obq5DzBkVTH7yXg5DyQGtZK3700pse1SoP81jtm+/zK89jBkxpik6aSOFzlL
 Om1oJ5/ZPSAL0XFw3YhCkBTP6qYGXhGoHOK7K61L2NnXtH9rzoDIJWss5j3xw3JjY30xV75m4EP
 2bnCCgMW+JHsIpGNf7fKD0ozwPzjR8OrTykM+mIeWp8sCQHj7geDzJGJWTkQy5LGEgtW/J8SJDz
 21MKzEcuv25JBINQ4SmoIZeLg3BKshKl5kIjzGnk6OnS1pV3alBM/6m3AfMfFuJYHRHQaJyrgnB
 S+4nLW/CLRfKd53gGF0CJNbjiOAf5zTL/e7C3ihzitORJ68Dee034gCfwhYEmk0Oorhf2bt2Ghs
 9odkcK+4VJ1LxknEITBtQdDqmjz3IxmcEzYV56R3B2br7pSxugNOhBtj2Bser18grepR+gehNYp
 /wsLcmWwcL8N/wQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
---
 hw/display/qxl.h |  1 +
 hw/display/qxl.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl.h b/hw/display/qxl.h
index ad8a9128785e..48d664f77736 100644
--- a/hw/display/qxl.h
+++ b/hw/display/qxl.h
@@ -83,6 +83,7 @@ struct PCIQXLDevice {
 
     /* thread signaling */
     QEMUBH             *update_irq;
+    VMChangeStateEntry *vmstate_handler;
 
     /* ram pci bar */
     QXLRam             *ram;
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 3df796175c29..b7d871b9ee33 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2203,7 +2203,8 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
         error_report_err(err);
     }
 
-    qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
+    qxl->vmstate_handler =
+        qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
 
     qxl->update_irq = qemu_bh_new_guarded(qxl_update_irq_bh, qxl,
                                           &DEVICE(qxl)->mem_reentrancy_guard);
@@ -2475,6 +2476,18 @@ static const Property qxl_properties[] = {
         DEFINE_PROP_UINT32("yres", PCIQXLDevice, yres, 0),
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
 static void qxl_pci_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -2482,6 +2495,7 @@ static void qxl_pci_class_init(ObjectClass *klass, const void *data)
 
     k->vendor_id = REDHAT_PCI_VENDOR_ID;
     k->device_id = QXL_DEVICE_ID_STABLE;
+    k->exit = qxl_exit;
     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
     device_class_set_legacy_reset(dc, qxl_reset_handler);
     dc->vmsd = &qxl_vmstate;

-- 
2.55.0


