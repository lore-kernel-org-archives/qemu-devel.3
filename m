Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC0BC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrZ6-0000C2-So; Wed, 20 Mar 2024 04:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrZ5-00009E-C1
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:44:51 -0400
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:240a::601]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrYy-00083q-Gm
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:44:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vk9xaW5e+eprpioY6hFO1ODy46mNy7+Mg9PB7LXB6g3UcseSJf8mxWwwkEcEmvYygPSUFmYH6u/iiAtqNlTGAvdisQiyLZ7yJBgJHokbZo++bnCtBCLY/X22IuBnviIVQqgyUhuYu0Hq+5nH3kJBFu79cnlrVnMLCu59vSGCVilT8VF+Z4APas6WL8MSrVt32vnESddpL9idM+q3TEoSnH0eQ9RCA0H/J4UGokO0L09yWe/NcI+hfQyxktegLCEQbruUMZpiqFhQc97giIuaD/xNe5dnads3LhUqi5XHMdUT/5oCG/IJqT9X/1I88nVUuVj2WyTO3326YsJzGw/GCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZXSYLqzazsjQqsL8guAe/PDsMZiZI6uZP4O0rA8/oQ=;
 b=OaqkRBLA9pfEH9b5hSl/+WFNGxLvLveV+sFnglv090wCR8uW7N6bmUx/lR+vP7eCihh9/DNKs//KUIRvNpPrW4q/ZUs36khIS5Go9akfEOYJdowQca0Wlk5vu6AlLV2OVUl7fySaa0lI81wEEiX5RuoY5DfEEqNZjdB7XwDuwO3EVkpRol/1bXgCX3csW4WJVmSyfWY48WTQx/9aIdmBJd38hKUqHXWwrZlFXm7z0C3RJ7U/P/hUAslXjz3jFO1Ydyoz82As1U6/skB0H1DrzT1wBqsG2FHtECj+75K6ZFFNtqugoIxdsfFN8mcvtfXL1MkcUzGFWJc62GbGh3lQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZXSYLqzazsjQqsL8guAe/PDsMZiZI6uZP4O0rA8/oQ=;
 b=Eim9g7n3wxzF9hILrND5BHzQmPME1rrSwHvQ0AJniBiiXpIrhKuICAaJyCXtnByvj5fPzg09UZFs2bU3OicWLd7BOsemKVH83rF/9chIvDbKc9c8OYSC+/6uwFTgixjeQhL1KMFkxB6DeH7xytNvfTiRmSAmVcsGw9FM36yTmD0=
Received: from BYAPR11CA0086.namprd11.prod.outlook.com (2603:10b6:a03:f4::27)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Wed, 20 Mar
 2024 08:44:38 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:f4:cafe::74) by BYAPR11CA0086.outlook.office365.com
 (2603:10b6:a03:f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 08:44:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:44:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:44:37 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, Sean Christopherson
 <sean.j.christopherson@intel.com>
Subject: [PATCH v3 18/49] q35: Introduce smm_ranges property for q35-pci-host
Date: Wed, 20 Mar 2024 03:39:14 -0500
Message-ID: <20240320083945.991426-19-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 937a9cd3-f0d6-4054-c2d3-08dc48b9fa54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJCHAwcp46/2I8twpNQvSwBRMx6RSNGPv6Ho0R9Yj39j/8zj7ErnxOgBqgdksdNidKyF6jqTUpehCPUPtarrQskguowwP30aMwXjBJ3KfiR5iaWbdbYYWc/3GwBBORgkc0swW4cuGXi5sIPOYQDP/HSMlaQ2tNDSY7CjyUrdUuXRJUo6De2EmZxZpj6pb9QebvZQHFx20t7x8p/VAtU+KrXJvg0SBqFoxn1daZm2BvFzzMKmSeAyt0ZnvMZIovMZ8jN7OjXQo7gl2PpAZSuXHwx4t/L+etgA/aKpyBbrfG2b+U8teRh1Bo+zHs129na/sAK4ns3Hpuw+CxiDcYadIeTZqTRcYKzi+R7+RNvoJ6zkAYxxWGXm3bp4LrlCK+pvW8stu0qBqA5AfVQSJEC0T1lOmndz5uzBok+0LwVg4UibslLLyszBr+HEAq7Jv3iy4A1z9vl7BS3I5ru3mFsmC66FhTjBqfkeP+ZFp11h+KMdlg/wPhX5Eq7ENVXjXWo4Oc6F+88iqq9xaV0CPtanV2n/jb9vY4l9htRp4ADn9sVyaN1M66QicKrso3T3KBYLXARUiOAoF2Yi5Xn6SVE8cIO4PSGNtFBiFK4rQssMQkcpUbXxOa63o+kjw7gCmlWDLz8ks96LvKjzQPWmOXNwISkdBUm72h59WmXcPS0RJUoB9sHRy9gueRG0n0y9n96sSu7cpde9yL/KebU4Szd76dqlGAeHTxgwhnSnI2uMUzZoug3KK5wlwwqJrkBwA4IX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:44:38.4213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 937a9cd3-f0d6-4054-c2d3-08dc48b9fa54
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822
Received-SPF: permerror client-ip=2a01:111:f403:240a::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Isaku Yamahata <isaku.yamahata@linux.intel.com>

Add a q35 property to check whether or not SMM ranges, e.g. SMRAM, TSEG,
etc... exist for the target platform.  TDX doesn't support SMM and doesn't
play nice with QEMU modifying related guest memory ranges.

Signed-off-by: Isaku Yamahata <isaku.yamahata@linux.intel.com>
Co-developed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 hw/i386/pc_q35.c          |  2 ++
 hw/pci-host/q35.c         | 42 +++++++++++++++++++++++++++------------
 include/hw/i386/pc.h      |  1 +
 include/hw/pci-host/q35.h |  1 +
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8a427c4647..42324448d7 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -219,6 +219,8 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->above_4g_mem_size, NULL);
     object_property_set_bool(phb, PCI_HOST_BYPASS_IOMMU,
                              pcms->default_bus_bypass_iommu, NULL);
+    object_property_set_bool(phb, PCI_HOST_PROP_SMM_RANGES,
+                             x86_machine_is_smm_enabled(x86ms), NULL);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 98d4a7c253..0b6cbaed7e 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -179,6 +179,8 @@ static Property q35_host_props[] = {
                      mch.below_4g_mem_size, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MEM_SIZE, Q35PCIHost,
                      mch.above_4g_mem_size, 0),
+    DEFINE_PROP_BOOL(PCI_HOST_PROP_SMM_RANGES, Q35PCIHost,
+                     mch.has_smm_ranges, true),
     DEFINE_PROP_BOOL("x-pci-hole64-fix", Q35PCIHost, pci_hole64_fix, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -214,6 +216,7 @@ static void q35_host_initfn(Object *obj)
     /* mch's object_initialize resets the default value, set it again */
     qdev_prop_set_uint64(DEVICE(s), PCI_HOST_PROP_PCI_HOLE64_SIZE,
                          Q35_PCI_HOST_HOLE64_SIZE_DEFAULT);
+
     object_property_add(obj, PCI_HOST_PROP_PCI_HOLE_START, "uint32",
                         q35_host_get_pci_hole_start,
                         NULL, NULL, NULL);
@@ -476,6 +479,10 @@ static void mch_write_config(PCIDevice *d,
         mch_update_pciexbar(mch);
     }
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     if (ranges_overlap(address, len, MCH_HOST_BRIDGE_SMRAM,
                        MCH_HOST_BRIDGE_SMRAM_SIZE)) {
         mch_update_smram(mch);
@@ -494,10 +501,13 @@ static void mch_write_config(PCIDevice *d,
 static void mch_update(MCHPCIState *mch)
 {
     mch_update_pciexbar(mch);
+
     mch_update_pam(mch);
-    mch_update_smram(mch);
-    mch_update_ext_tseg_mbytes(mch);
-    mch_update_smbase_smram(mch);
+    if (mch->has_smm_ranges) {
+        mch_update_smram(mch);
+        mch_update_ext_tseg_mbytes(mch);
+        mch_update_smbase_smram(mch);
+    }
 
     /*
      * pci hole goes from end-of-low-ram to io-apic.
@@ -538,18 +548,20 @@ static void mch_reset(DeviceState *qdev)
     pci_set_quad(d->config + MCH_HOST_BRIDGE_PCIEXBAR,
                  MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT);
 
-    d->config[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_DEFAULT;
-    d->config[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_DEFAULT;
-    d->wmask[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_WMASK;
-    d->wmask[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_WMASK;
+    if (mch->has_smm_ranges) {
+        d->config[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_DEFAULT;
+        d->config[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_DEFAULT;
+        d->wmask[MCH_HOST_BRIDGE_SMRAM] = MCH_HOST_BRIDGE_SMRAM_WMASK;
+        d->wmask[MCH_HOST_BRIDGE_ESMRAMC] = MCH_HOST_BRIDGE_ESMRAMC_WMASK;
 
-    if (mch->ext_tseg_mbytes > 0) {
-        pci_set_word(d->config + MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
-                     MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
-    }
+        if (mch->ext_tseg_mbytes > 0) {
+            pci_set_word(d->config + MCH_HOST_BRIDGE_EXT_TSEG_MBYTES,
+                        MCH_HOST_BRIDGE_EXT_TSEG_MBYTES_QUERY);
+        }
 
-    d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
-    d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
+        d->config[MCH_HOST_BRIDGE_F_SMBASE] = 0;
+        d->wmask[MCH_HOST_BRIDGE_F_SMBASE] = 0xff;
+    }
 
     mch_update(mch);
 }
@@ -578,6 +590,10 @@ static void mch_realize(PCIDevice *d, Error **errp)
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
 
+    if (!mch->has_smm_ranges) {
+        return;
+    }
+
     /* if *disabled* show SMRAM to all CPUs */
     memory_region_init_alias(&mch->smram_region, OBJECT(mch), "smram-region",
                              mch->pci_address_space, MCH_HOST_BRIDGE_SMRAM_C_BASE,
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 27a68071d7..fb1d4106e5 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -161,6 +161,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 #define PCI_HOST_PROP_PCI_HOLE64_SIZE  "pci-hole64-size"
 #define PCI_HOST_BELOW_4G_MEM_SIZE     "below-4g-mem-size"
 #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
+#define PCI_HOST_PROP_SMM_RANGES       "smm-ranges"
 
 
 void pc_pci_as_mapping_init(MemoryRegion *system_memory,
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index bafcbe6752..22fadfa3ed 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -50,6 +50,7 @@ struct MCHPCIState {
     MemoryRegion tseg_blackhole, tseg_window;
     MemoryRegion smbase_blackhole, smbase_window;
     bool has_smram_at_smbase;
+    bool has_smm_ranges;
     Range pci_hole;
     uint64_t below_4g_mem_size;
     uint64_t above_4g_mem_size;
-- 
2.25.1


