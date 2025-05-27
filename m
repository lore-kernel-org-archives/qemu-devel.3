Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A1BC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJoyu-0002Q6-S4; Tue, 27 May 2025 03:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoxk-00012H-87
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoxb-000082-TL
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748331773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26R9IIYGQ9335iDhOwqOOe4wYjnRcjspHMBu6o9oC2s=;
 b=Hj6cVOGIiNYUQDtVK888MedGoV9f0j29AQyGkAiSRJjG7pbA3VPtGwW2mK582vVerOI3Y2
 7FHG3UxF53cj0O9VRlRi8qBb8sd6mUG50naM/qxNiOA/kIY/N2CTng9eMIXCLMinQzoqoL
 bzmYbW4cRM0q5PmXtyVmV4+Jj1GXX7k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-ilVSxtWEMAy756Df8jod7g-1; Tue,
 27 May 2025 03:42:50 -0400
X-MC-Unique: ilVSxtWEMAy756Df8jod7g-1
X-Mimecast-MFC-AGG-ID: ilVSxtWEMAy756Df8jod7g_1748331768
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9ADFA1955E79; Tue, 27 May 2025 07:42:48 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.201])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECB9A19560AA; Tue, 27 May 2025 07:42:43 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v2 03/25] hw/acpi: Rename and move build_x86_acpi_pci_hotplug
 to pcihp
Date: Tue, 27 May 2025 09:40:05 +0200
Message-ID: <20250527074224.1197793-4-eric.auger@redhat.com>
In-Reply-To: <20250527074224.1197793-1-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We plan to reuse build_x86_acpi_pci_hotplug() implementation
for ARM so let's move the code to generic pcihp.

Associated static aml_pci_pdsm() helper is also moved along.
build_x86_acpi_pci_hotplug is renamed into build_acpi_pci_hotplug().

No code change intended.

Also fix the reference to acpi_pci_hotplug.rst documentation

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

---

v1 -> v2:
- s/spec/specs in reference to rst (Gustavo)
- fixed double space in commit msg (Gustavo)

rfc -> v1:
- make build_append_pci_dsm_func0_common non static and move it to
  pcihp
---
 hw/i386/acpi-build.h    |   4 -
 include/hw/acpi/pcihp.h |   9 +-
 hw/acpi/pcihp.c         | 174 ++++++++++++++++++++++++++++++++++++++-
 hw/i386/acpi-build.c    | 176 +---------------------------------------
 4 files changed, 183 insertions(+), 180 deletions(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 275ec058a1..8ba3c33e48 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -5,10 +5,6 @@
 
 extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
-/* PCI Hot-plug registers' base. See docs/specs/acpi_pci_hotplug.rst */
-#define ACPI_PCIHP_SEJ_BASE 0x8
-#define ACPI_PCIHP_BNMR_BASE 0x10
-
 void acpi_setup(void);
 Object *acpi_get_i386_pci_host(void);
 
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index a97904bada..971451e8ea 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -3,7 +3,7 @@
  *
  * QEMU supports PCI hotplug via ACPI. This module
  * implements the interface between QEMU and the ACPI BIOS.
- * Interface specification - see docs/specs/acpi_pci_hotplug.txt
+ * Interface specification - see docs/specs/acpi_pci_hotplug.rst
  *
  * Copyright (c) 2013, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
  * Copyright (c) 2006 Fabrice Bellard
@@ -33,6 +33,10 @@
 #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
 #define ACPI_PCIHP_IO_LEN_PROP "acpi-pcihp-io-len"
 
+/* PCI Hot-plug registers bases. See docs/specs/acpi_pci_hotplug.rst */
+#define ACPI_PCIHP_SEJ_BASE 0x8
+#define ACPI_PCIHP_BNMR_BASE 0x10
+
 typedef struct AcpiPciHpPciStatus {
     uint32_t up;
     uint32_t down;
@@ -69,6 +73,9 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                          AcpiPciHpState *s, DeviceState *dev,
                                          Error **errp);
 
+void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr);
+void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar);
+
 /* Called on reset */
 void acpi_pcihp_reset(AcpiPciHpState *s);
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index aac90013d4..e0260f67e6 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -26,7 +26,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/acpi/pcihp.h"
-
+#include "hw/acpi/aml-build.h"
 #include "hw/pci-host/i440fx.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
@@ -513,6 +513,178 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
                                    OBJ_PROP_FLAG_READ);
 }
 
+void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
+{
+    Aml *UUID, *ifctx1;
+    uint8_t byte_list[1] = { 0 }; /* nothing supported yet */
+
+    aml_append(ctx, aml_store(aml_buffer(1, byte_list), retvar));
+    /*
+     * PCI Firmware Specification 3.1
+     * 4.6.  _DSM Definitions for PCI
+     */
+    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
+    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(0), UUID)));
+    {
+        /* call is for unsupported UUID, bail out */
+        aml_append(ifctx1, aml_return(retvar));
+    }
+    aml_append(ctx, ifctx1);
+
+    ifctx1 = aml_if(aml_lless(aml_arg(1), aml_int(2)));
+    {
+        /* call is for unsupported REV, bail out */
+        aml_append(ifctx1, aml_return(retvar));
+    }
+    aml_append(ctx, ifctx1);
+}
+
+static Aml *aml_pci_pdsm(void)
+{
+    Aml *method, *ifctx, *ifctx1;
+    Aml *ret = aml_local(0);
+    Aml *caps = aml_local(1);
+    Aml *acpi_index = aml_local(2);
+    Aml *zero = aml_int(0);
+    Aml *one = aml_int(1);
+    Aml *not_supp = aml_int(0xFFFFFFFF);
+    Aml *func = aml_arg(2);
+    Aml *params = aml_arg(4);
+    Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
+    Aml *sunum = aml_derefof(aml_index(params, aml_int(1)));
+
+    method = aml_method("PDSM", 5, AML_SERIALIZED);
+
+    /* get supported functions */
+    ifctx = aml_if(aml_equal(func, zero));
+    {
+        build_append_pci_dsm_func0_common(ifctx, ret);
+
+        aml_append(ifctx, aml_store(zero, caps));
+        aml_append(ifctx,
+            aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
+        /*
+         * advertise function 7 if device has acpi-index
+         * acpi_index values:
+         *            0: not present (default value)
+         *     FFFFFFFF: not supported (old QEMU without PIDX reg)
+         *        other: device's acpi-index
+         */
+        ifctx1 = aml_if(aml_lnot(
+                     aml_or(aml_equal(acpi_index, zero),
+                            aml_equal(acpi_index, not_supp), NULL)
+                 ));
+        {
+            /* have supported functions */
+            aml_append(ifctx1, aml_or(caps, one, caps));
+            /* support for function 7 */
+            aml_append(ifctx1,
+                aml_or(caps, aml_shiftleft(one, aml_int(7)), caps));
+        }
+        aml_append(ifctx, ifctx1);
+
+        aml_append(ifctx, aml_store(caps, aml_index(ret, zero)));
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
+
+       aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
+       aml_append(ifctx, aml_store(pkg, ret));
+       /*
+        * Windows calls func=7 without checking if it's available,
+        * as workaround Microsoft has suggested to return invalid for func7
+        * Package, so return 2 elements package but only initialize elements
+        * when acpi_index is supported and leave them uninitialized, which
+        * leads elements to being Uninitialized ObjectType and should trip
+        * Windows into discarding result as an unexpected and prevent setting
+        * bogus 'PCI Label' on the device.
+        */
+       ifctx1 = aml_if(aml_lnot(aml_lor(
+                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
+                )));
+       {
+           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
+           /*
+            * optional, if not impl. should return null string
+            */
+           aml_append(ifctx1, aml_store(aml_string("%s", ""),
+                                        aml_index(ret, one)));
+       }
+       aml_append(ifctx, ifctx1);
+
+       aml_append(ifctx, aml_return(ret));
+    }
+
+    aml_append(method, ifctx);
+    return method;
+}
+
+void build_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
+{
+    Aml *scope;
+    Aml *field;
+    Aml *method;
+
+    scope =  aml_scope("_SB.PCI0");
+
+    aml_append(scope,
+        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
+    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("PCIU", 32));
+    aml_append(field, aml_named_field("PCID", 32));
+    aml_append(scope, field);
+
+    aml_append(scope,
+        aml_operation_region("SEJ", AML_SYSTEM_IO,
+                             aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
+    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("B0EJ", 32));
+    aml_append(scope, field);
+
+    aml_append(scope,
+        aml_operation_region("BNMR", AML_SYSTEM_IO,
+                             aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
+    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
+    aml_append(field, aml_named_field("BNUM", 32));
+    aml_append(field, aml_named_field("PIDX", 32));
+    aml_append(scope, field);
+
+    aml_append(scope, aml_mutex("BLCK", 0));
+
+        method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
+    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
+    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
+    aml_append(method,
+        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ")));
+    aml_append(method, aml_release(aml_name("BLCK")));
+    aml_append(method, aml_return(aml_int(0)));
+    aml_append(scope, method);
+
+    method = aml_method("AIDX", 2, AML_NOTSERIALIZED);
+    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
+    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
+    aml_append(method,
+        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("PIDX")));
+    aml_append(method, aml_store(aml_name("PIDX"), aml_local(0)));
+    aml_append(method, aml_release(aml_name("BLCK")));
+    aml_append(method, aml_return(aml_local(0)));
+    aml_append(scope, method);
+
+    aml_append(scope, aml_pci_pdsm());
+
+    aml_append(table, scope);
+}
+
 const VMStateDescription vmstate_acpi_pcihp_pci_status = {
     .name = "acpi_pcihp_pci_status",
     .version_id = 1,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f59026524f..4f8572eebe 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -361,32 +361,6 @@ static Aml *aml_pci_device_dsm(void)
     return method;
 }
 
-static void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
-{
-    Aml *UUID, *ifctx1;
-    uint8_t byte_list[1] = { 0 }; /* nothing supported yet */
-
-    aml_append(ctx, aml_store(aml_buffer(1, byte_list), retvar));
-    /*
-     * PCI Firmware Specification 3.1
-     * 4.6.  _DSM Definitions for PCI
-     */
-    UUID = aml_touuid("E5C937D0-3553-4D7A-9117-EA4D19C3434D");
-    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(0), UUID)));
-    {
-        /* call is for unsupported UUID, bail out */
-        aml_append(ifctx1, aml_return(retvar));
-    }
-    aml_append(ctx, ifctx1);
-
-    ifctx1 = aml_if(aml_lless(aml_arg(1), aml_int(2)));
-    {
-        /* call is for unsupported REV, bail out */
-        aml_append(ifctx1, aml_return(retvar));
-    }
-    aml_append(ctx, ifctx1);
-}
-
 static Aml *aml_pci_edsm(void)
 {
     Aml *method, *ifctx;
@@ -647,96 +621,6 @@ static bool build_append_notification_callback(Aml *parent_scope,
     return !!nr_notifiers;
 }
 
-static Aml *aml_pci_pdsm(void)
-{
-    Aml *method, *ifctx, *ifctx1;
-    Aml *ret = aml_local(0);
-    Aml *caps = aml_local(1);
-    Aml *acpi_index = aml_local(2);
-    Aml *zero = aml_int(0);
-    Aml *one = aml_int(1);
-    Aml *not_supp = aml_int(0xFFFFFFFF);
-    Aml *func = aml_arg(2);
-    Aml *params = aml_arg(4);
-    Aml *bnum = aml_derefof(aml_index(params, aml_int(0)));
-    Aml *sunum = aml_derefof(aml_index(params, aml_int(1)));
-
-    method = aml_method("PDSM", 5, AML_SERIALIZED);
-
-    /* get supported functions */
-    ifctx = aml_if(aml_equal(func, zero));
-    {
-        build_append_pci_dsm_func0_common(ifctx, ret);
-
-        aml_append(ifctx, aml_store(zero, caps));
-        aml_append(ifctx,
-            aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
-        /*
-         * advertise function 7 if device has acpi-index
-         * acpi_index values:
-         *            0: not present (default value)
-         *     FFFFFFFF: not supported (old QEMU without PIDX reg)
-         *        other: device's acpi-index
-         */
-        ifctx1 = aml_if(aml_lnot(
-                     aml_or(aml_equal(acpi_index, zero),
-                            aml_equal(acpi_index, not_supp), NULL)
-                 ));
-        {
-            /* have supported functions */
-            aml_append(ifctx1, aml_or(caps, one, caps));
-            /* support for function 7 */
-            aml_append(ifctx1,
-                aml_or(caps, aml_shiftleft(one, aml_int(7)), caps));
-        }
-        aml_append(ifctx, ifctx1);
-
-        aml_append(ifctx, aml_store(caps, aml_index(ret, zero)));
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
-
-       aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
-       aml_append(ifctx, aml_store(pkg, ret));
-       /*
-        * Windows calls func=7 without checking if it's available,
-        * as workaround Microsoft has suggested to return invalid for func7
-        * Package, so return 2 elements package but only initialize elements
-        * when acpi_index is supported and leave them uninitialized, which
-        * leads elements to being Uninitialized ObjectType and should trip
-        * Windows into discarding result as an unexpected and prevent setting
-        * bogus 'PCI Label' on the device.
-        */
-       ifctx1 = aml_if(aml_lnot(aml_lor(
-                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
-                )));
-       {
-           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
-           /*
-            * optional, if not impl. should return null string
-            */
-           aml_append(ifctx1, aml_store(aml_string("%s", ""),
-                                        aml_index(ret, one)));
-       }
-       aml_append(ifctx, ifctx1);
-
-       aml_append(ifctx, aml_return(ret));
-    }
-
-    aml_append(method, ifctx);
-    return method;
-}
-
 /*
  * build_prt - Define interrupt routing rules
  *
@@ -1227,62 +1111,6 @@ static Aml *build_q35_dram_controller(const AcpiMcfgInfo *mcfg)
     return dev;
 }
 
-static void build_x86_acpi_pci_hotplug(Aml *table, uint64_t pcihp_addr)
-{
-    Aml *scope;
-    Aml *field;
-    Aml *method;
-
-    scope =  aml_scope("_SB.PCI0");
-
-    aml_append(scope,
-        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
-    field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
-    aml_append(field, aml_named_field("PCIU", 32));
-    aml_append(field, aml_named_field("PCID", 32));
-    aml_append(scope, field);
-
-    aml_append(scope,
-        aml_operation_region("SEJ", AML_SYSTEM_IO,
-                             aml_int(pcihp_addr + ACPI_PCIHP_SEJ_BASE), 0x04));
-    field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
-    aml_append(field, aml_named_field("B0EJ", 32));
-    aml_append(scope, field);
-
-    aml_append(scope,
-        aml_operation_region("BNMR", AML_SYSTEM_IO,
-                             aml_int(pcihp_addr + ACPI_PCIHP_BNMR_BASE), 0x08));
-    field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
-    aml_append(field, aml_named_field("BNUM", 32));
-    aml_append(field, aml_named_field("PIDX", 32));
-    aml_append(scope, field);
-
-    aml_append(scope, aml_mutex("BLCK", 0));
-
-    method = aml_method("PCEJ", 2, AML_NOTSERIALIZED);
-    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
-    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
-    aml_append(method,
-        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("B0EJ")));
-    aml_append(method, aml_release(aml_name("BLCK")));
-    aml_append(method, aml_return(aml_int(0)));
-    aml_append(scope, method);
-
-    method = aml_method("AIDX", 2, AML_NOTSERIALIZED);
-    aml_append(method, aml_acquire(aml_name("BLCK"), 0xFFFF));
-    aml_append(method, aml_store(aml_arg(0), aml_name("BNUM")));
-    aml_append(method,
-        aml_store(aml_shiftleft(aml_int(1), aml_arg(1)), aml_name("PIDX")));
-    aml_append(method, aml_store(aml_name("PIDX"), aml_local(0)));
-    aml_append(method, aml_release(aml_name("BLCK")));
-    aml_append(method, aml_return(aml_local(0)));
-    aml_append(scope, method);
-
-    aml_append(scope, aml_pci_pdsm());
-
-    aml_append(table, scope);
-}
-
 static Aml *build_q35_osc_method(bool enable_native_pcie_hotplug)
 {
     Aml *if_ctx;
@@ -1394,7 +1222,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, sb_scope);
 
         if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
-            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
+            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
         }
         build_piix4_pci0_int(dsdt);
     } else if (q35) {
@@ -1438,7 +1266,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dsdt, sb_scope);
 
         if (pm->pcihp_bridge_en) {
-            build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
+            build_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
         }
         build_q35_pci0_int(dsdt);
     }
-- 
2.49.0


