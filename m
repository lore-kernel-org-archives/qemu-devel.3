Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCB2CD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWj8-0004UI-4D; Fri, 05 Jun 2026 11:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWj3-0004Sj-63
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWj1-0005sM-PH
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KSCoPhM3lk7JFhTxcjXT83QO7v9CIqkxILozb1DjS4=;
 b=USsBRqX4iRUYsFXHtJEyFs1Ec75RBKTRCbJP4HBKSIM8cZbj4GAdF7B8lWbsekBD3AUjb3
 vrBGJCkYyJ9ytzeFAgIthoFxIUd/gSv0lwTge9qrzY35exTo/S4dcy5l43eeT1mSUjk46L
 KgAge3qIIScokKWMy7AixnCDqIYrhxw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-nFCpILmSMg2IelpYtvCr2g-1; Fri,
 05 Jun 2026 11:44:45 -0400
X-MC-Unique: nFCpILmSMg2IelpYtvCr2g-1
X-Mimecast-MFC-AGG-ID: nFCpILmSMg2IelpYtvCr2g_1780674283
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A6C31956046
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:44:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A1EB1800480; Fri,  5 Jun 2026 15:44:41 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:23 +0400
Subject: [GIT PULL 03/23] hw/pci-bridge: handle missing parent in
 prop_pxb_uid_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-3-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1251;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=n1HD5N4FZEYQbnTz/49cmNT99YN0r5FAVFil0pDrL3g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7UGZb9oKUroYCLr2jb1iMyj7IW9mAURFV3f
 ENXa5AxfMyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1AAKCRDa6OEJdZac
 5VcOD/wPqZQ/Mck+zohML+UIP166oAFDbQbv4t6vhsG5YRV6yKRBAHMt0AH4T760n1DHvbDNjdl
 TS2t/WchENZvCyncEjQFzWweEMSwkCpbuQ32WKy2CpLV39/kj1fjYzgP0O5lMqwSj706xDIrydS
 JgoNMc+x4rsgs35dGxMmpZ7cZF5U34ShCMLwk1IjBMH7bYPq0YgTdWzv3ERfgzp9P7eIrHVWj3r
 0THxefSJucnKqy1DIO2XMswb0VJnuuWbB6YdPt3/ByCJ3ssdxw2EXq02qScbS7moFgpwKHtL4Xj
 F1ovlrwA/56hwSb4yOvGrCymXvhAvpKiM6aKGkhFZ8daVWrjd4P+RxMck18B2c7hJo5x+juky3Y
 mpJTloCqVcB2XsGlvfQJz88cC6+G6Ila6DlpK7tDSsMcpMzRy1mvykjF/UiUhV7Z8Yxc78fPoRX
 TAQ/HkQKLGKNuGQFWSJcsMy+FsrZ77B/9GiOUiroa19wOqTImvkqeFc//brqIJmecN+/UlJ3KeM
 LFKqa9TQZYddkv91Q+tqTojkLpQ7FuYKukegVRw42YG/psSkyLNB7CQCWxcQb/nvFymKmtLzXLp
 twAq9Y6549AEKIgUpl0CKD3udNvVO66vKv31FwJfEgcMv0Ux6ZBSSvdMGvp4tpPnPdtcJ4S3hjI
 SRr/c8uYJiQHGzw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When called on an unrealized pxb bus (e.g. from
qmp_qom_list_properties), bus->parent_dev is NULL. The pxb_bus_num()
callback dereferences it unconditionally. Check for this to avoid a
NULL dereference.

Fixes: 97b9cb066e5f ("hw/pci-bridge: Add acpi_uid property to TYPE_PXB_BUS")
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci-bridge/pci_expander_bridge.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 11623a5666f..40ffbc4e082 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -85,8 +85,14 @@ static uint16_t pxb_bus_numa_node(PCIBus *bus)
 static void prop_pxb_uid_get(Object *obj, Visitor *v, const char *name,
                              void *opaque, Error **errp)
 {
-    uint32_t uid = pci_bus_num(PCI_BUS(obj));
+    PCIBus *bus = PCI_BUS(obj);
+    uint32_t uid;
 
+    if (!bus->parent_dev) {
+        error_setg(errp, "bus not attached to a device");
+        return;
+    }
+    uid = pci_bus_num(bus);
     visit_type_uint32(v, name, &uid, errp);
 }
 

-- 
2.54.0


