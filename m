Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9C7C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubENK-000572-R4; Mon, 14 Jul 2025 04:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEER-0006ro-Dq
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEEM-0003Gc-Ai
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752480489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hOnk6tUF8BEtgoK/DOmMaR/Km0pJrk/2ZiEFOx7CRQU=;
 b=iLN2dbiLoLaSH1FTGvjPcQSEKIGbwR5AiYArtWymAf1SIeE5cHn6P7GEFhfQos2U5VURFe
 +ZyCP1QCBwEyYy5zOS33ql3G2preaHfBRT0wT0XZI+vY8RoOhpmEufAtvSrTn+DCwNwwUa
 L+kSx3b0ATdCsSp6Y2oonlwpmF1x9ek=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-Sq1E1nGkOoK7Up2V1d64Cw-1; Mon,
 14 Jul 2025 04:08:05 -0400
X-MC-Unique: Sq1E1nGkOoK7Up2V1d64Cw-1
X-Mimecast-MFC-AGG-ID: Sq1E1nGkOoK7Up2V1d64Cw_1752480484
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2AE519560AD; Mon, 14 Jul 2025 08:08:03 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 535AF1977000; Mon, 14 Jul 2025 08:07:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v7 15/36] hw/i386/acpi-build: Use AcpiPciHpState::root in
 acpi_set_pci_info
Date: Mon, 14 Jul 2025 10:04:59 +0200
Message-ID: <20250714080639.2525563-16-eric.auger@redhat.com>
In-Reply-To: <20250714080639.2525563-1-eric.auger@redhat.com>
References: <20250714080639.2525563-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

pcihp acpi_set_pci_info() generic code currently uses
acpi_get_i386_pci_host() to retrieve the pci host bridge.

To make it work also on ARM we get rid of that call and
directly use AcpiPciHpState::root.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

v2 -> v3:
- Use AcpiPciHpState::root

v1 -> v2
- described the fact we changed the implementation of
  acpi_get_pci_host() in the commit msg.
---
 hw/acpi/pcihp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 2c76edeb15..2db2f16940 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -99,10 +99,10 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     return info;
 }
 
-static void acpi_set_pci_info(bool has_bridge_hotplug)
+static void acpi_set_pci_info(AcpiPciHpState *s)
 {
     static bool bsel_is_set;
-    Object *host = acpi_get_i386_pci_host();
+    bool has_bridge_hotplug = s->use_acpi_hotplug_bridge;
     PCIBus *bus;
     BSELInfo info = { .bsel_alloc = ACPI_PCIHP_BSEL_DEFAULT,
                       .has_bridge_hotplug = has_bridge_hotplug };
@@ -112,11 +112,8 @@ static void acpi_set_pci_info(bool has_bridge_hotplug)
     }
     bsel_is_set = true;
 
-    if (!host) {
-        return;
-    }
 
-    bus = PCI_HOST_BRIDGE(host)->bus;
+    bus = s->root;
     if (bus) {
         /* Scan all PCI buses. Set property to enable acpi based hotplug. */
         pci_for_each_bus_depth_first(bus, acpi_set_bsel, NULL, &info);
@@ -266,7 +263,7 @@ static void acpi_pcihp_update(AcpiPciHpState *s)
 
 void acpi_pcihp_reset(AcpiPciHpState *s)
 {
-    acpi_set_pci_info(s->use_acpi_hotplug_bridge);
+    acpi_set_pci_info(s);
     acpi_pcihp_update(s);
 }
 
-- 
2.49.0


