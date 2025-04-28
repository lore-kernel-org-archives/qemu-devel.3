Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D60FC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9LhR-00066m-5E; Mon, 28 Apr 2025 06:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9LhJ-0005rP-Tl
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9LhH-0003Fl-Ip
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745836006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6XahBnXpFqwycsDBbg1wLu1EfXJ0E3CuvWhdSJiCoos=;
 b=BmbFEPG2efQN3ARm5+jW4l9h7v41PGBdt7UjtbEjIQTFFl1ToPjauIkYxX/r0xAR0fhBP4
 7MYdlM8K1bIzVzuQ4g2uSKAQN8WN+Sxg/i8gaOLvu5wgRypn9lfG3eCNZyPS9RpYSMcDkI
 evIHbCWsIY56sXBTMC/sBJ6eMjp1PhA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-6ey_4z0KMjCz6EJX54VPFQ-1; Mon,
 28 Apr 2025 06:26:43 -0400
X-MC-Unique: 6ey_4z0KMjCz6EJX54VPFQ-1
X-Mimecast-MFC-AGG-ID: 6ey_4z0KMjCz6EJX54VPFQ_1745836002
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00E7319560AA; Mon, 28 Apr 2025 10:26:42 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0464180045C; Mon, 28 Apr 2025 10:26:36 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	Jonathan.Cameron@huawei.com
Subject: [RFC 01/24] hw/pci/pcie_port: Fix pcie_slot_is_hotpluggbale_bus typo
Date: Mon, 28 Apr 2025 12:25:27 +0200
Message-ID: <20250428102628.378046-2-eric.auger@redhat.com>
In-Reply-To: <20250428102628.378046-1-eric.auger@redhat.com>
References: <20250428102628.378046-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/pci/pcie_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index c73db30e98..072500ed34 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -188,7 +188,7 @@ int pcie_count_ds_ports(PCIBus *bus)
     return dsp_count;
 }
 
-static bool pcie_slot_is_hotpluggbale_bus(HotplugHandler *plug_handler,
+static bool pcie_slot_is_hotpluggable_bus(HotplugHandler *plug_handler,
                                           BusState *bus)
 {
     PCIESlot *s = PCIE_SLOT(bus->parent);
@@ -221,7 +221,7 @@ static void pcie_slot_class_init(ObjectClass *oc, void *data)
     hc->plug = pcie_cap_slot_plug_cb;
     hc->unplug = pcie_cap_slot_unplug_cb;
     hc->unplug_request = pcie_cap_slot_unplug_request_cb;
-    hc->is_hotpluggable_bus = pcie_slot_is_hotpluggbale_bus;
+    hc->is_hotpluggable_bus = pcie_slot_is_hotpluggable_bus;
 }
 
 static const TypeInfo pcie_slot_type_info = {
-- 
2.49.0


