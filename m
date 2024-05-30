Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1355AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmN-00060j-PS; Thu, 30 May 2024 07:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmM-0005zX-Kr
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:06 -0400
Received: from mail-bn8nam11on20624.outbound.protection.outlook.com
 ([2a01:111:f403:2414::624]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmJ-0001SK-ML
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL69pESnpYLjxXNxBHCbsRWq3DFf8ywaKzOnX/U7uFzH3Z4/Ir/vGOJcMsluIz+DaiqeL7aliJOUzcfwka24EVHUyzh0I1NUlgKvm+zDqukf9v/IwZq892Olr0twNrbA1SlWBPsN+9KQzN7VEDo2oLwBE3Gn+kZsoTOL2HE6OPu9AyEYxMCzAvwMhF04B3/xZrbto6Iq+zVhIcGp8WWlRxg5pNRd2oLdNhUTkUaqE/GinHMRugf+a8cLAd8dktP+t+uTasdxqoTPHgnm6427BupWyOqt2x+j5njPpUhO9APLJSmQ2m5uqtRkix/JPE+Zk/bVa6eHmpoSwDJtqNLhhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68tnYI6ipZ8mBahj5St8AOyJU76kc67TAbkPM3BQUuQ=;
 b=UatOY1ZcFnvywQ0JeQ2kH7+bW6seFkLCtrB/tm2o9VHCtmXtkkpbaWjfJ0YNXFINdk/3UIVjwb/pFxWa+VQD6fc1GdJyI+zP7E2fEe5GXYJU0UpdNDeb8nMnWRxU8Yh5SdpaY9I+ZNYY55931Acm9Mh3+Nrca9J7DbEEBiuIDl2v3Cjgm9A1CMhiBG7/aQv0+a2fmf2StpXIjKf23g8DM8TJuVmWXgC2fMbYF+tzN9ZF7PliPrMf6burNRsvwnG5vLi386+X+GfWjBU7XGg9pgYF2hnVHf3VH9PH7K/FlsItzq/WFpzUrtJG2ausr9Rj0sgUPTGYrfpKFTLibl/oEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68tnYI6ipZ8mBahj5St8AOyJU76kc67TAbkPM3BQUuQ=;
 b=zcbeVi3kwznfCoNR9EwsrhijPkyKMl31yhixfRgEgeEe7qCzNY7XGHFejg5qTE1aALcnMmDDYZvxzf2JCJ9z6Yvrq2L2Lw2TW0HfOJGeVmLXSz17YBJrSUSfLTEvVl8llUAGunaq59C0H5s8bEd521PrgOvxzPRaMoqbG+eB9TA=
Received: from BN9PR03CA0670.namprd03.prod.outlook.com (2603:10b6:408:10e::15)
 by SN7PR12MB7856.namprd12.prod.outlook.com (2603:10b6:806:340::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 30 May
 2024 11:16:58 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::18) by BN9PR03CA0670.outlook.office365.com
 (2603:10b6:408:10e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 11:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:57 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:57 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 21/31] i386/sev: Extract build_kernel_loader_hashes
Date: Thu, 30 May 2024 06:16:33 -0500
Message-ID: <20240530111643.1091816-22-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SN7PR12MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db6d0fa-2c05-461b-5036-08dc809a0556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o1/wygQbTLs6vnev5n5jBA9Lnn9Rl4F7Bj9fjG/67aTfXbgFN6pUXzIWlh6s?=
 =?us-ascii?Q?nrRfM8KSDpdMCGz13nmIjF3fdwp4yCuaReI4cMled9D995UERI0etwgP3XXJ?=
 =?us-ascii?Q?W7NcmLMQ9280j9zslqFsHXnc2opNPnF6YzVgUIIpwK0OC8biku+Iw2WnDgsG?=
 =?us-ascii?Q?kLDrJe+qV0GpVfTh3028vIGnRQDDwMtTvu6+DwKfK8YCB1HBIk2e/p76bhnH?=
 =?us-ascii?Q?YTmNaKbw5HVd3J/SMP2AsUeZkmYpfASiC1THNrsNdddh/ggueiQ+C3HEIsRF?=
 =?us-ascii?Q?DhKZDjpW7XtHqAbHuN6g506Vt4d+KI9SZf6sBB5s+x09dqEj9gYU2U23vvmc?=
 =?us-ascii?Q?6uzvaI4B5ywm1uFYbnYL7Z1vPb3Rngd+FN8Nj+cCWwDoFTUhZNFpAl/sRhhS?=
 =?us-ascii?Q?ugF0pkY7YqrzY75bpsVjOsGgyp9rUTH+hGct2HzenmcJWxPFb7L7yfD665vQ?=
 =?us-ascii?Q?qaCYzArxd9T9qk8XrHuy36cw0oM+qL9OjIdYpCNh5Jth2HMAyxCmf8G+RYv9?=
 =?us-ascii?Q?8H9OWAq7kgwQHXWH6vIYi901JFdSxIfFppK2qna1Ht8XWTAnMZ53GcLxe90C?=
 =?us-ascii?Q?cGEykcaG9c+Bih3rb5cllrg7qz79qDoYbpJanoq9XjXk0iJ5w0lEWYPOdYkL?=
 =?us-ascii?Q?HFkIIZ2uTSYpBaZSeDQy91FdgBm30otc4i1ZQRJEeBzZnzcSWTSPqb46hIWc?=
 =?us-ascii?Q?/b1yxw3M/7edLe+iiyS9BqAYbgI3bUi4RLg2HL2jIcEuwwdnZisQyhRn84Ic?=
 =?us-ascii?Q?dlLAPdwyBKn83G4vJZlLkmMceH/Ib1+LE5cahJ6BIyxhmoBzoNJp9LwXIDQe?=
 =?us-ascii?Q?K9ww3rbUth8pUADsnTOY45IDhV62I4gePkgrDMldUfGCOZ28gL5tnxDY+fgI?=
 =?us-ascii?Q?Stcl+3WgeWLEMLDPSdBJD3fjQYJ51Ow7kvU82hMSB9Wa7KKzGTQa0r6exYJZ?=
 =?us-ascii?Q?UfwpGBaB32iBXDOuhmp3s5E6WfPNLcfhzOOSLEdw+ReZB0jiG4+Xpj8UJW+D?=
 =?us-ascii?Q?dTM4nMycMp5v/AbqDEJea1n6KdaF56KwuFliM86eLWaYg3AHkvpgc1mNAFcm?=
 =?us-ascii?Q?GQbJlomVS0kG/f37HpoGG7grR0a9sRnDJCI/1bnHifVejlYtYsEvTWvmmdGK?=
 =?us-ascii?Q?zakEDT0vAbv7hfBCGooubf/dukIzLBYNzjMF2vzYFhu7aNTJ+JXLW3imOIMO?=
 =?us-ascii?Q?2jDgkciz/kDxYlqmRvih81VhwZjkKY91crMfKKHjwUthd12mSudimk+T7cBM?=
 =?us-ascii?Q?5+AH2uG3MC3LTTyGjuEBKebbRGXbK1LK7Jzm0V/2PKuqQFBz7Agoo5VIKVCK?=
 =?us-ascii?Q?2pWVEiOrhyYKLts7vQK6OWrzWxtMibJtzMlzVnBe8fSP5z5p9rjHmUTNZUP/?=
 =?us-ascii?Q?YG4eQkZIMH3URuX+7B33nFb4e2ri?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:58.2160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db6d0fa-2c05-461b-5036-08dc809a0556
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7856
Received-SPF: permerror client-ip=2a01:111:f403:2414::624;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

From: Dov Murik <dovmurik@linux.ibm.com>

Extract the building of the kernel hashes table out from
sev_add_kernel_loader_hashes() to allow building it in
other memory areas (for SNP support).

No functional change intended.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 target/i386/sev.c | 101 ++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 43 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 4388ffe867..831745c02a 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1751,45 +1751,16 @@ static const QemuUUID sev_cmdline_entry_guid = {
                     0x4d, 0x36, 0xab, 0x2a)
 };
 
-/*
- * Add the hashes of the linux kernel/initrd/cmdline to an encrypted guest page
- * which is included in SEV's initial memory measurement.
- */
-bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
+static bool build_kernel_loader_hashes(PaddedSevHashTable *padded_ht,
+                                       SevKernelLoaderContext *ctx,
+                                       Error **errp)
 {
-    uint8_t *data;
-    SevHashTableDescriptor *area;
     SevHashTable *ht;
-    PaddedSevHashTable *padded_ht;
     uint8_t cmdline_hash[HASH_SIZE];
     uint8_t initrd_hash[HASH_SIZE];
     uint8_t kernel_hash[HASH_SIZE];
     uint8_t *hashp;
     size_t hash_len = HASH_SIZE;
-    hwaddr mapped_len = sizeof(*padded_ht);
-    MemTxAttrs attrs = { 0 };
-    bool ret = true;
-    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
-
-    /*
-     * Only add the kernel hashes if the sev-guest configuration explicitly
-     * stated kernel-hashes=on.
-     */
-    if (!sev_common->kernel_hashes) {
-        return false;
-    }
-
-    if (!pc_system_ovmf_table_find(SEV_HASH_TABLE_RV_GUID, &data, NULL)) {
-        error_setg(errp, "SEV: kernel specified but guest firmware "
-                         "has no hashes table GUID");
-        return false;
-    }
-    area = (SevHashTableDescriptor *)data;
-    if (!area->base || area->size < sizeof(PaddedSevHashTable)) {
-        error_setg(errp, "SEV: guest firmware hashes table area is invalid "
-                         "(base=0x%x size=0x%x)", area->base, area->size);
-        return false;
-    }
 
     /*
      * Calculate hash of kernel command-line with the terminating null byte. If
@@ -1826,16 +1797,6 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
     }
     assert(hash_len == HASH_SIZE);
 
-    /*
-     * Populate the hashes table in the guest's memory at the OVMF-designated
-     * area for the SEV hashes table
-     */
-    padded_ht = address_space_map(&address_space_memory, area->base,
-                                  &mapped_len, true, attrs);
-    if (!padded_ht || mapped_len != sizeof(*padded_ht)) {
-        error_setg(errp, "SEV: cannot map hashes table guest memory area");
-        return false;
-    }
     ht = &padded_ht->ht;
 
     ht->guid = sev_hash_table_header_guid;
@@ -1856,7 +1817,61 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
     /* zero the excess data so the measurement can be reliably calculated */
     memset(padded_ht->padding, 0, sizeof(padded_ht->padding));
 
-    if (sev_encrypt_flash((uint8_t *)padded_ht, sizeof(*padded_ht), errp) < 0) {
+    return true;
+}
+
+/*
+ * Add the hashes of the linux kernel/initrd/cmdline to an encrypted guest page
+ * which is included in SEV's initial memory measurement.
+ */
+bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
+{
+    uint8_t *data;
+    SevHashTableDescriptor *area;
+    PaddedSevHashTable *padded_ht;
+    hwaddr mapped_len = sizeof(*padded_ht);
+    MemTxAttrs attrs = { 0 };
+    bool ret = true;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    /*
+     * Only add the kernel hashes if the sev-guest configuration explicitly
+     * stated kernel-hashes=on.
+     */
+    if (!sev_common->kernel_hashes) {
+        return false;
+    }
+
+    if (!pc_system_ovmf_table_find(SEV_HASH_TABLE_RV_GUID, &data, NULL)) {
+        error_setg(errp, "SEV: kernel specified but guest firmware "
+                         "has no hashes table GUID");
+        return false;
+    }
+
+    area = (SevHashTableDescriptor *)data;
+    if (!area->base || area->size < sizeof(PaddedSevHashTable)) {
+        error_setg(errp, "SEV: guest firmware hashes table area is invalid "
+                         "(base=0x%x size=0x%x)", area->base, area->size);
+        return false;
+    }
+
+    /*
+     * Populate the hashes table in the guest's memory at the OVMF-designated
+     * area for the SEV hashes table
+     */
+    padded_ht = address_space_map(&address_space_memory, area->base,
+                                  &mapped_len, true, attrs);
+    if (!padded_ht || mapped_len != sizeof(*padded_ht)) {
+        error_setg(errp, "SEV: cannot map hashes table guest memory area");
+        return false;
+    }
+
+    if (build_kernel_loader_hashes(padded_ht, ctx, errp)) {
+        if (sev_encrypt_flash((uint8_t *)padded_ht, sizeof(*padded_ht),
+                              errp) < 0) {
+            ret = false;
+        }
+    } else {
         ret = false;
     }
 
-- 
2.34.1


