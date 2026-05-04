Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B753FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJraC-0007Uq-FP; Mon, 04 May 2026 07:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJraA-0007UL-IJ
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJra8-0000m5-S8
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LnmPj2a/SZ2VXKAkFID+9JaaVLfJOAgO0sBcWpZJog=;
 b=cuPyDpwqJBMWit5zpLWWebI6c2gcTL6jHuMknwwRgT3qkuXW7t4VnKGIKsHgRwJ3X4+eMo
 HV3Ft7aO5jZ0QMPic0vJfvqn5qb0E9nzN4vgLd317GHoDF3E4MTXLUy/ORWVQCgMuxcTXw
 mL9FV9pa6NrQBAQwUAL90ld4NjoxqWI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-xRcAc9CBOECCGvfAeZKgsg-1; Mon,
 04 May 2026 07:35:22 -0400
X-MC-Unique: xRcAc9CBOECCGvfAeZKgsg-1
X-Mimecast-MFC-AGG-ID: xRcAc9CBOECCGvfAeZKgsg_1777894521
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77640195608B
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:35:21 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77CF71800347; Mon,  4 May 2026 11:35:20 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:34:49 +0400
Subject: [PATCH v2 01/46] hw/pci: handle missing bus in prop_pci_busnr_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-1-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TNcMmHQOk/Cv/pMBfbzxmrySqL4hQAd92bEHD4UL6Q0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRr//8ubAy8v2Oj1r0e7dXjo+CRyChMgnZ/0
 A1+EgTV1nSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEawAKCRDa6OEJdZac
 5VcCD/9gGFYwE91xP9RdLb6fSOV65ujihzeQ0i1npwXmXc86tDhxFSXcMa/JNFrvBB43HbpHmZW
 ulj5WQFBerU7dJ9bx4kMNrz658dLKsIVOz96CF4vzBY35J5q0PukFG5FpeJEnPcclsNn3+ty47t
 YjIGnhx1liyTj8+p6rldYalAFC1FOM6Z52QKcopN1XNQe+Rdc7juxh/Nz7RLCzUwMg/9taof+/9
 8Idmx0lPzuoh1l4D3IqB0LN1fm8ar450dDKJZz9PQcolWMHq+YZOk8/qG+COOvcD8bz2WgyjUsU
 YNwkfJ9rJYhfZwPi5eQR8KeCpX5nMSlASvciFtdc0HuaWZQw8yuL1sMDt/D1r/YBeJ+SqX4CVya
 Qlm2Bj/ccmmgT1eJMFUkVC1viBYz9R57r3+OkTjZAbROEoibo91BgS04j+69YPjXeGffH2UPkW6
 0zvqR8JtABLSQOU9jU5A03ceQfx09ab3Rm3mlzUiIPbK7rxm1R2G19GYfjxRUZjtssq3NdEozVn
 syYGoahObkk7Cw/CDEgS6xNUHyGr68HKwR5jK4BkEBePAc//ZX2apFhfcLXjAjZ2nnE1XCiT52c
 BGdck9m9qGr4TzHUxQCn61OShf6UUJN/DQAscQXCsgbPC7bUN4wyvUvZV4IPP96xXO/3rIBlj+E
 pegFo4nZSU8x6TQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

When called on an unrealized device (e.g. from
qmp_qom_list_properties), pci_get_bus() returns NULL since the device
has no parent bus. Check for this to avoid a NULL dereference in
pci_bus_num().

Fixes: df9ac7254fd9 ("hw/pci: Add a busnr property to pci_props and use for acpi/gi")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/pci/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index a0dbb81fd90..bf13cabd174 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -64,10 +64,17 @@ static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
 static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
-                             void *opaque, Error **errp)
+                               void *opaque, Error **errp)
 {
-    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
+    PCIDevice *dev = PCI_DEVICE(obj);
+    PCIBus *bus = pci_get_bus(dev);
+    uint8_t busnr;
 
+    if (!bus) {
+        error_setg(errp, "device not attached to a PCI bus");
+        return;
+    }
+    busnr = pci_bus_num(bus);
     visit_type_uint8(v, name, &busnr, errp);
 }
 

-- 
2.54.0


