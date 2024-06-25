Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED67C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 03:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLxEe-0005Ga-QQ; Mon, 24 Jun 2024 23:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sLxEd-0005GO-B6
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 23:52:47 -0400
Received: from mx24.baidu.com ([111.206.215.185] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1sLxEa-0004D3-8Y
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 23:52:46 -0400
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <imammedo@redhat.com>, Shiyuan Gao <gaoshiyuan@baidu.com>
Subject: [v2 1/1] hw/i386/acpi-build: add OSHP method support for SHPC driver
 load
Date: Tue, 25 Jun 2024 11:52:24 +0800
Message-ID: <20240625035224.13019-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.127.73.8]
X-ClientProxiedBy: BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 172.31.51.48
X-FE-Policy-ID: 52:10:53:SYSTEM
Received-SPF: pass client-ip=111.206.215.185;
 envelope-from=gaoshiyuan@baidu.com; helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Shiyuan Gao <gaoshiyuan@baidu.com>
From:  Shiyuan Gao via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SHPC driver will be loaded fail in i440fx machine, the dmesg shows
that OS cannot get control of SHPC hotplug and hotplug device to
the PCI bridge will fail when we use SHPC Native type:

  [3.336059] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S28_)
  [3.337408] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
  [3.338710] shpchp 0000:00:03.0: Cannot get control of SHPC hotplug

Add OSHP method support for transfer control to the operating system,
after this SHPC driver will be loaded success and the hotplug device to
the PCI bridge will success when we use SHPC Native type.

  [1.703975] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0.S18_)
  [1.704934] shpchp 0000:00:03.0: Requesting control of SHPC hotplug via OSHP (\_SB_.PCI0)
  [1.705855] shpchp 0000:00:03.0: Gained control of SHPC hotplug (\_SB_.PCI0)
  [1.707054] shpchp 0000:00:03.0: HPC vendor_id 1b36 device_id 1 ss_vid 0 ss_did 0

Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
---
v1 -> v2:
* add quote PCI firmware spec 3.0
* explain why an empty method is enough
---

 hw/i386/acpi-build.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f4e366f64f..00f8abedf6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1412,6 +1412,23 @@ static void build_acpi0017(Aml *table)
     aml_append(table, scope);
 }
 
+/*
+ * PCI Firmware Specification 3.0
+ * 4.8. The OSHP Control Method
+ */
+static Aml *build_oshp_method(void)
+{
+    Aml *method;
+
+    /*
+     * We don't use ACPI to control the SHPC, so just return
+     * success is enough.
+     */
+    method = aml_method("OSHP", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(0x0)));
+    return method;
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1452,6 +1469,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
         aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
         aml_append(dev, aml_pci_edsm());
+        aml_append(dev, build_oshp_method());
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
 
@@ -1586,6 +1604,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(dev, build_q35_osc_method(true));
             } else {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
+                aml_append(dev, build_oshp_method());
             }
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
-- 
2.36.1


