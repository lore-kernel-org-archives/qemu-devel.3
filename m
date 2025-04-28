Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F00BDC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 10:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9LiF-0008KG-AH; Mon, 28 Apr 2025 06:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9Lhr-0007oR-WA
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1u9Lho-0003L3-Qm
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 06:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745836039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MK1FBnL9l6rNaxiGEG/Bnn7tSwy/sliDftuBgCzt8KE=;
 b=QTlJ250H61chIlxj8grga2p1/k04Tt96EGqZElhYQ0J6PBrmZrI78J1JY2916jPs+FqIFG
 x58VBh4iLHbH44Xa/wI9HIaM84knPeimXTVhENL+bgrvbe91r5YlXMsKmhSmVEPx9CynRQ
 olV5JB8TD+/mrtObfVpuWABx5OhEjtE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-eiLNcdcpPNKUh8Xz3e1PSw-1; Mon,
 28 Apr 2025 06:27:15 -0400
X-MC-Unique: eiLNcdcpPNKUh8Xz3e1PSw-1
X-Mimecast-MFC-AGG-ID: eiLNcdcpPNKUh8Xz3e1PSw_1745836034
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A365180036E; Mon, 28 Apr 2025 10:27:14 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.14])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43D711800359; Mon, 28 Apr 2025 10:27:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	Jonathan.Cameron@huawei.com
Subject: [RFC 08/24] hw/pci-host/gpex-acpi: Split host bridge OSC and DSM
 generation
Date: Mon, 28 Apr 2025 12:25:34 +0200
Message-ID: <20250428102628.378046-9-eric.auger@redhat.com>
In-Reply-To: <20250428102628.378046-1-eric.auger@redhat.com>
References: <20250428102628.378046-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
it appends the _OSC method but in fact it also appends the _DSM method
for the host bridge. Let's split the function into two separate ones
and let them return the method Aml pointer instead. This matches the
way it is done on x86 (build_q35_osc_method). In a subsequent patch
we will replace the gpex method by the q35 implementation that will
become shared between ARM and x86.

acpi_dsdt_add_host_bridge_methods is a new top helper that generates
both the _OSC and _DSM methods.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/pci-host/gpex-acpi.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 4016089893..9d9f5ed7c6 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -50,13 +50,10 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
+static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
 {
-    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
+    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
 
-    /* Declare an _OSC (OS Control Handoff) method */
-    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
-    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
     method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
     aml_append(method,
         aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
@@ -103,9 +100,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
                                aml_name("CDW1")));
     aml_append(elsectx, aml_return(aml_arg(3)));
     aml_append(method, elsectx);
-    aml_append(dev, method);
+    return method;
+}
 
-    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
+static Aml *build_host_bridge_dsm(void)
+{
+    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
+    Aml *UUID, *ifctx, *ifctx1, *buf;
 
     /* PCI Firmware Specification 3.0
      * 4.6.1. _DSM for PCI Express Slot Information
@@ -124,7 +125,17 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
     byte_list[0] = 0;
     buf = aml_buffer(1, byte_list);
     aml_append(method, aml_return(buf));
-    aml_append(dev, method);
+    return method;
+}
+
+static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
+                                              bool enable_native_pcie_hotplug)
+{
+    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
+    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
+    /* Declare an _OSC (OS Control Handoff) method */
+    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
+    aml_append(dev, build_host_bridge_dsm());
 }
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
@@ -193,7 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             if (is_cxl) {
                 build_cxl_osc_method(dev);
             } else {
-                acpi_dsdt_add_pci_osc(dev, true);
+                acpi_dsdt_add_host_bridge_methods(dev, true);
             }
 
             aml_append(scope, dev);
@@ -268,7 +279,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_pci_osc(dev, true);
+    acpi_dsdt_add_host_bridge_methods(dev, true);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
-- 
2.49.0


