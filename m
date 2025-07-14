Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11114C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 08:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubESv-0004fN-SU; Mon, 14 Jul 2025 04:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEET-0006wV-Hm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ubEER-0003Hv-Gi
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 04:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752480494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K1qBDlo5RmWIcZiTe3O+JHoMl+6Vli62AciAkI4Q6kE=;
 b=WXAYH9GIjgoFzQ/YzG2zCJYVIu6LextJv2eKjeDLQ9Dy8j1Gu0SDCVKx152U8HVkBg504i
 tq9jYm41cHMWVi8ByU3rz5tIwhQIlkHiEPWreaUaKOkkGr5tvLFqWqXbTCFWNdj5yo1JU6
 R5aRuKavcSw9hMCrQCdkwtf+XdaXpmQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-4P3H6wDZMvOUBJ9TMSre4g-1; Mon,
 14 Jul 2025 04:08:10 -0400
X-MC-Unique: 4P3H6wDZMvOUBJ9TMSre4g-1
X-Mimecast-MFC-AGG-ID: 4P3H6wDZMvOUBJ9TMSre4g_1752480488
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3013195608A; Mon, 14 Jul 2025 08:08:08 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.221])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8274D1977029; Mon, 14 Jul 2025 08:08:04 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v7 16/36] hw/i386/acpi-build: Move aml_pci_edsm to a generic
 place
Date: Mon, 14 Jul 2025 10:05:00 +0200
Message-ID: <20250714080639.2525563-17-eric.auger@redhat.com>
In-Reply-To: <20250714080639.2525563-1-eric.auger@redhat.com>
References: <20250714080639.2525563-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Move aml_pci_edsm to pci-bridge.c since we want to reuse that for
ARM and acpi-index support. Also rename it into build_pci_bridge_edsm.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

---

v3->v4:
- renamed into build_pci_bridge_edsm() (Jonathan, Igor)

v2 -> v3:
- move to pci-bridge.c instead of pcihp.c (Igor)
---
 include/hw/acpi/pci.h |  1 +
 hw/acpi/pci-bridge.c  | 54 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c  | 57 ++-----------------------------------------
 3 files changed, 57 insertions(+), 55 deletions(-)

diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 69bae95eac..20b672575f 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -42,5 +42,6 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
 void build_srat_generic_affinity_structures(GArray *table_data);
 
 Aml *build_pci_host_bridge_osc_method(bool enable_native_pcie_hotplug);
+Aml *build_pci_bridge_edsm(void);
 
 #endif
diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
index 7baa7034a1..394a919479 100644
--- a/hw/acpi/pci-bridge.c
+++ b/hw/acpi/pci-bridge.c
@@ -35,3 +35,57 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope)
         }
     }
 }
+
+Aml *build_pci_bridge_edsm(void)
+{
+    Aml *method, *ifctx;
+    Aml *zero = aml_int(0);
+    Aml *func = aml_arg(2);
+    Aml *ret = aml_local(0);
+    Aml *aidx = aml_local(1);
+    Aml *params = aml_arg(4);
+
+    method = aml_method("EDSM", 5, AML_SERIALIZED);
+
+    /* get supported functions */
+    ifctx = aml_if(aml_equal(func, zero));
+    {
+        /* 1: have supported functions */
+        /* 7: support for function 7 */
+        const uint8_t caps = 1 | BIT(7);
+        build_append_pci_dsm_func0_common(ifctx, ret);
+        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
+        aml_append(ifctx, aml_return(ret));
+    }
+    aml_append(method, ifctx);
+
+    /* handle specific functions requests */
+    /*
+     * PCI Firmware Specification 3.1
+     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
+     *        Operating Systems
+     */
+    ifctx = aml_if(aml_equal(func, aml_int(7)));
+    {
+       Aml *pkg = aml_package(2);
+       aml_append(pkg, zero);
+       /* optional, if not impl. should return null string */
+       aml_append(pkg, aml_string("%s", ""));
+       aml_append(ifctx, aml_store(pkg, ret));
+
+       /*
+        * IASL is fine when initializing Package with computational data,
+        * however it makes guest unhappy /it fails to process such AML/.
+        * So use runtime assignment to set acpi-index after initializer
+        * to make OSPM happy.
+        */
+       aml_append(ifctx,
+           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
+       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
+       aml_append(ifctx, aml_return(ret));
+    }
+    aml_append(method, ifctx);
+
+    return method;
+}
+
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index fe8bc62c03..423c4959fe 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -338,59 +338,6 @@ build_facs(GArray *table_data)
     g_array_append_vals(table_data, reserved, 40); /* Reserved */
 }
 
-static Aml *aml_pci_edsm(void)
-{
-    Aml *method, *ifctx;
-    Aml *zero = aml_int(0);
-    Aml *func = aml_arg(2);
-    Aml *ret = aml_local(0);
-    Aml *aidx = aml_local(1);
-    Aml *params = aml_arg(4);
-
-    method = aml_method("EDSM", 5, AML_SERIALIZED);
-
-    /* get supported functions */
-    ifctx = aml_if(aml_equal(func, zero));
-    {
-        /* 1: have supported functions */
-        /* 7: support for function 7 */
-        const uint8_t caps = 1 | BIT(7);
-        build_append_pci_dsm_func0_common(ifctx, ret);
-        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret, zero)));
-        aml_append(ifctx, aml_return(ret));
-    }
-    aml_append(method, ifctx);
-
-    /* handle specific functions requests */
-    /*
-     * PCI Firmware Specification 3.1
-     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
-     *        Operating Systems
-     */
-    ifctx = aml_if(aml_equal(func, aml_int(7)));
-    {
-       Aml *pkg = aml_package(2);
-       aml_append(pkg, zero);
-       /* optional, if not impl. should return null string */
-       aml_append(pkg, aml_string("%s", ""));
-       aml_append(ifctx, aml_store(pkg, ret));
-
-       /*
-        * IASL is fine when initializing Package with computational data,
-        * however it makes guest unhappy /it fails to process such AML/.
-        * So use runtime assignment to set acpi-index after initializer
-        * to make OSPM happy.
-        */
-       aml_append(ifctx,
-           aml_store(aml_derefof(aml_index(params, aml_int(0))), aidx));
-       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
-       aml_append(ifctx, aml_return(ret));
-    }
-    aml_append(method, ifctx);
-
-    return method;
-}
-
 /*
  * build_prt - Define interrupt routing rules
  *
@@ -937,7 +884,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
-        aml_append(dev, aml_pci_edsm());
+        aml_append(dev, build_pci_bridge_edsm());
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
 
@@ -952,7 +899,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
         aml_append(dev, build_pci_host_bridge_osc_method(!pm->pcihp_bridge_en));
-        aml_append(dev, aml_pci_edsm());
+        aml_append(dev, build_pci_bridge_edsm());
         aml_append(sb_scope, dev);
         if (mcfg_valid) {
             aml_append(sb_scope, build_q35_dram_controller(&mcfg));
-- 
2.49.0


