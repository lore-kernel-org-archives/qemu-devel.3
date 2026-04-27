Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6996DFF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRrA-0000vF-6F; Mon, 27 Apr 2026 15:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRqy-0000rk-PX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wHRqv-0007jM-Lz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777318965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAuYAhy1cX7XBXjOLthJfEq8jJm8Z2hVUkA1DREfIfI=;
 b=evjlNtY9ITisemuonp510myOUJA1IqPlB1+WDoVmHEjQWnUM+5qZjffwftUdeCzG0gSnMr
 i44727thjwc82nmjCBIMbZEf6jArxXi92Gy15xfaEIZ2dlmPiu4VKyyhR75GdL448UeTYP
 KkxX9jJpPptZM6p6+FPq4F9iPIQWUCc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-1jwxN4HQNgCg54yE6XrU0g-1; Mon,
 27 Apr 2026 15:42:43 -0400
X-MC-Unique: 1jwxN4HQNgCg54yE6XrU0g-1
X-Mimecast-MFC-AGG-ID: 1jwxN4HQNgCg54yE6XrU0g_1777318962
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9580B195609D
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:42:42 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2BE4195608E; Mon, 27 Apr 2026 19:42:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Apr 2026 23:42:02 +0400
Subject: [PATCH 03/41] hw/pci-bridge: handle missing parent in prop_pxb_uid_get
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260427-qom-tests-v1-3-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
In-Reply-To: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7IzFtyW5t8Gf12v8GCg2dNaN6ZsDHP4zF5gwn8PfMpc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp77wUxXrEGyOfqXJtmyjiR7kGhiC9PY3OuVy9q
 xBEprUUWW2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCae+8FAAKCRDa6OEJdZac
 5Tq9EACUumLvmV3Yhiw+Fjqg5+mbboRkvntsilf5BiEJAydH/nFWLvm+WWq06JBcVEGbesvP5r3
 xxxyjMAPelAS+ywlVUSnslPuMfjEn2Mkc2iyuGJEe5KGbw1z1JTlzAvbUPV5e0wXkCxiVY4F05r
 kKPp7/qNw4vjxfw2ona30Fnn3PaN0KvYit75DSGoqXM5FqHboQUICtwJ53d+R8UwOL/6LyIfK+M
 3Ls8WX7BRRU/6AcUINYABz8LxQ5vxwbX8ErDbQMlPTRZlIySD9F1MWvFfm4C56bD7uVQ+TVZw+i
 aCK+F79m2/v7Cuj4o44QZOVFK4YJUgOMmJ6esmCJD/WglFFVvMH24+KdGbkMXF5RwevG2wJcEse
 9VFclGaCyGuReOfB2McBj2GUpBVY4yja2jl35cK/ofH5Y6BEU840iLZ+fWrzr2LrkHcvlpueTCf
 LNfGiXC6Fy2N9vCubHrUU/bNDMerlyQ1P1U0Pz7P8XxVM1H86sSkhDAa0qvx8EkHZZw+wyt3wVf
 imBPp9WE4lLloeAH9A5oHQzHgerEnNjINGk0tWs+yk7PGXJoQt6MMqzMJWMc/Pitptdqpqk3g/t
 yJqflIUP9lnnd434ynI5+OungsjcDmZbnaUaAIu0XSBjVkJzYo9yWYH0Ea4U0iQYC5jPOuGzfpM
 V1tipA2S7Sk2PMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
2.53.0


