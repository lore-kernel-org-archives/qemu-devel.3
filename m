Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70972C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:56:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrkU-0007dh-D3; Wed, 20 Mar 2024 04:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrkS-0007WG-UC
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:56:36 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrkR-0002Uu-8M
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:56:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERUPASCW6PMt6/5/HkAc9uaW682IecIoXTOsZeL55Aq2u+CIK8ECYZz+IQOc0QNTkhw49JCDCNGup3IiekeSlFBfdtsX3pq8h/f59rYI0eUVAfNb1b8aMwekCQXMTWfHk8I+Mb689jd1f3TCAd670HWOjmolWBTJ4VZODd8vIuQK+VX01EqibPlAzyQPEx6aByI4Jp7+w37CCguiCbWBE91Gg/THWl+JMdvhG8VFI17lDQodm1GsHgSaGcaP0WXbQ/z0am0J2YaV1xtbmK+5eshhAP0oAjkRTxKlmSUjziNVj7BQcG3wA7IUf2QIuSG1SdIXDGwsonVtuOEUr7RloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0Ga6hkIq4PMlehO1h4QdPsKNE+e6tDuLWJwPmSvLCE=;
 b=eNfkIB5LwsBqxY9IJcy8uLLs+Gn5+SfwgbpgW1x/YLS9Euc0uexYj5xKvvWdoMmkBJWTNJwWJEtfxaDY78BclfdsSNiramNIj+8S0iPtsr5T/9E4iVWO3JjQyw2OBljjH+hWuy+HRpWW0RFPUO8vaN/kdK+5htmnGlVZ9k7d0yzSlq853PS9ByqxBqRMEGODbDVLx6o73lS90sPviGj9oxTITZAFqr9i63n6E4gq720VFDQzZDDL2u17oK10MaSaPirXukh0f+MdtOLKSBPYpPF350NaqanAn0iB1xrIXtwGZG0RPvHwyPTqEPTCI5Dyjwd4msxglxXshINcYbB4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0Ga6hkIq4PMlehO1h4QdPsKNE+e6tDuLWJwPmSvLCE=;
 b=w2jnqHXwNlYrzQTqQNt73DSQwf7WRqUf/h7wsZOUurep7ddWZvmQSFpBHYClE8HuaxwXFuxXpBODy6UiEhQlCt8H4rKUDEbxNo5dx3mSYhTJFM1iiNGFGC3J3YIS+zYCU4gl+ZTrk3PirR3n7QR2+jnegbbrbZiwB5lKqj39o0k=
Received: from BYAPR07CA0045.namprd07.prod.outlook.com (2603:10b6:a03:60::22)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.28; Wed, 20 Mar 2024 08:56:31 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::3c) by BYAPR07CA0045.outlook.office365.com
 (2603:10b6:a03:60::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Wed, 20 Mar 2024 08:56:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:56:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:56:30 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 49/49] hw/i386: Add support for loading BIOS using
 guest_memfd
Date: Wed, 20 Mar 2024 03:39:45 -0500
Message-ID: <20240320083945.991426-50-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a210e5-dd6a-4b73-0ab1-08dc48bba35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lud8KTiiKCE/PkaJr7NuWRmzXft5G6zDAx+WQKgbC9yxAO6mP5FjVoJSdry30VmDcsq0U4hgDr6KTNeNsBmkKOCNblwPij3dO229DmUFAHyJ1vZeGzc+k5jnITHlDreFVqvtSpDRi3c08wlTv4E2Ql70Z/eqWJ9328mkwPG3erGGBfKQQ9pCxPk8MO7ZHQjb7AC2BVbl/wl65MABhPi2+6MYfMIZ60+z+ZLgZZ2y3wxaxbHwv8Nzs2euTHmUU5EkP3PY8LpHCqYpO/rSgK22nVpB2keVbBbSdDJPH1QUUn38tnEcohph8LS7kyTCD23p/uhvFd+CkSywzFIFcqJoIlRGzDpkxrsX3Ikv8WsvQ/51o+wUraSkc7GjciW0hXmzAnU8+nWuYnyIbRAp001+qIXH6d9M3BeWiGr+iwLm246Xs6Z/oGZbg+ml1EDV8QeWAdKb0giK5gAztFGwKgH+WQNELBR7Y+Q2rH3Tiyt2v0cJoV0Guyk6RMP1LnHubk1Q2t2rimJetPPIjgIyJ+E15BiYcs3jglRIFgim373BZsmsyTRQkUfdXUVIfoiHhWFU8PofW3CNatj/L1vUxZ7Q5/KVXTIFC7YQ74E+BhQT1BtqgwW4yo8YhdBmwUEVbDIea9dmnh7fsVQEj+ZHaNlLjnkZDiqGS2z0nYcpcVMPwH0OPghUY9sNjZwgTWg/zx7K2zH8GESL46JUNkOcXevUBtQMoQeQ7gDRnXIXYv0UK+az4pUdE383eF9v6unPABO3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:56:31.4851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a210e5-dd6a-4b73-0ab1-08dc48bba35c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
Received-SPF: permerror client-ip=2a01:111:f403:2412::601;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

TODO: - Add proper handling for non-64K-aligned BIOS images.
      - Add proper handling for BIOS pflash area which should be
        initially mapped as shared, resulting in unecessary
        KVM_EXIT_MEMORY_FAULTs

When guest_memfd is enabled, the BIOS is generally part of the initial
encrypted guest image and will be accessed as private guest memory. Add
the necessary changes to set up the associated RAM region with a
guest_memfd backend to allow for this.

Current support centers around using -bios to load the BIOS data.
Support for loading the BIOS via pflash requires additional enablement
since those interfaces rely on the use of ROM memory regions which make
use of the KVM_MEM_READONLY memslot flag, which is not supported for
guest_memfd-backed memslots.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 hw/i386/x86.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index e3ddc39133..ea2d03cc02 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1147,10 +1147,18 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
     }
     if (bios_size <= 0 ||
         (bios_size % 65536) != 0) {
-        goto bios_error;
+        g_warning("%s: Unaligned BIOS size %d", __func__, bios_size);
+        if (!machine_require_guest_memfd(ms)) {
+            goto bios_error;
+        }
     }
     bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    if (machine_require_guest_memfd(ms)) {
+        memory_region_init_ram_guest_memfd(bios, NULL, "pc.bios", bios_size,
+                                           &error_fatal);
+    } else {
+        memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    }
     if (sev_enabled()) {
         /*
          * The concept of a "reset" simply doesn't exist for
@@ -1173,17 +1181,19 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
     }
     g_free(filename);
 
-    /* map the last 128KB of the BIOS in ISA space */
-    isa_bios_size = MIN(bios_size, 128 * KiB);
-    isa_bios = g_malloc(sizeof(*isa_bios));
-    memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
-                             bios_size - isa_bios_size, isa_bios_size);
-    memory_region_add_subregion_overlap(rom_memory,
-                                        0x100000 - isa_bios_size,
-                                        isa_bios,
-                                        1);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(isa_bios, true);
+    if (!machine_require_guest_memfd(ms)) {
+        /* map the last 128KB of the BIOS in ISA space */
+        isa_bios_size = MIN(bios_size, 128 * KiB);
+        isa_bios = g_malloc(sizeof(*isa_bios));
+        memory_region_init_alias(isa_bios, NULL, "isa-bios", bios,
+                                 bios_size - isa_bios_size, isa_bios_size);
+        memory_region_add_subregion_overlap(rom_memory,
+                                            0x100000 - isa_bios_size,
+                                            isa_bios,
+                                            1);
+        if (!isapc_ram_fw) {
+            memory_region_set_readonly(isa_bios, true);
+        }
     }
 
     /* map all the bios at the top of memory */
-- 
2.25.1


