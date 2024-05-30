Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EDEC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmQ-00063J-QQ; Thu, 30 May 2024 07:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmL-0005yp-TE
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:05 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmI-0001S4-CW
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsWZoc6cBCyjLdah1pWxpm/Us3/CdjmzuoDR/clgHCTpmb5X2mR/0fA6n+hJFtzRcniML6puSTXAYz2JUipwqwsmqniDmIiOheDSLAqkvLKEub8g7s+o79Vob7KFIoyix8gL6NeAIMdOvvixuggiBaTYj1E6u1J1dbauch5rdCO4XfyWp8BNpnNPGbG7i9vuYxNjtxyFsSEu/9cshxJO5Iu4yymn/xailYr6lXtYWi08HUM2MJp/IUvNeSvjUmv8xTAGRtXkn3gNmoM0HEjBk7C61yG8z8HNq/h+suP+gXpWezDHbj2jjMjUB6nlSBz3WS/5jKZLEKNrTMpvbh7k2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU1YEWuFgyxOJu7nKj1mL3riIRBFC2b9Xzhlg3trUy4=;
 b=ervtslJAI5f3FG6bsJcVr1OA7E8uJVSfOymzxmVJegHLHDAw7+Y4/jnDmLJFeJSaI4SASDvu0xSwfS8gUuVvshOxlVApkgzqH0H9+DAK4D1J3p4SaCNrkliZsLdv906/rVMOEBxWn1SGF+4KgmsrxTWLuqgzMntZsFy7KW6v3Euw6zU9ljb3gTCqqAt55VXX+y/6xE4Z49dJYvKn8cl8pH1vR+EKhm97B2GCj3hOMtDfUGUIm1hKF+vf2QZoGbtXzzA12P8gxIZMZ+2fGxVAmdF946RHykKs00XuwUULL9i2XwpIY1QFwaYm+n2DFXUIxa5QTWCZ7nUW47ZAelQIUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU1YEWuFgyxOJu7nKj1mL3riIRBFC2b9Xzhlg3trUy4=;
 b=qQoL/7dUaaNNhhbTzme+fQgTstTnFYso735F7qivXuNz+5B8f7gJPc4IK9J4SKW8/BbwzFiYE1K6PUtzTCpNk1hvLC8BVIzmYzK7DddDlm5jUEyqDF1XqJbVboHOZ0ulmt/81Ek2KtQ7XfhLxvZD4eZZlb4/vEhOIyEK/tNRWbA=
Received: from BN9PR03CA0663.namprd03.prod.outlook.com (2603:10b6:408:10e::8)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 11:16:59 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::6c) by BN9PR03CA0663.outlook.office365.com
 (2603:10b6:408:10e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 11:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:16:59 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:16:58 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:16:58 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 23/31] i386/sev: Allow measured direct kernel boot on SNP
Date: Thu, 30 May 2024 06:16:35 -0500
Message-ID: <20240530111643.1091816-24-pankaj.gupta@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530111643.1091816-1-pankaj.gupta@amd.com>
References: <20240530111643.1091816-1-pankaj.gupta@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: pankaj.gupta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: b48da0e8-a88d-4324-48e6-08dc809a05f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VzKankzau55G4l6TlZnyUWcyvVSYyG4yIH84GuDzx1w5WaZGsHKyJF08J0rm?=
 =?us-ascii?Q?cplRF+vln9yUnzLGRYgfOn5k+KAcNKyLvh5mDo3cH9ZAsGZ0K9DztYwbpzfl?=
 =?us-ascii?Q?+KeVuUfEzcR8NsjKc2/MVuV44SfuUXAKrX9PToQCoiKiycYFzTGgOWZ7zvhB?=
 =?us-ascii?Q?pZdmKn8Vg3RGbTAHumAYg1U9+CEm0hD+QaWgl/f73+OvpIj8W3my3Jj7Kf9V?=
 =?us-ascii?Q?KYvmO3EIDFXncrF2Lvfx4rZL/Jlagcz0WR24q2d5sEk59uVtGZZRHUvvJkMv?=
 =?us-ascii?Q?7pxs4dCU1gaFZHSu1Xdj7wUsqKI1hEVw7pElZ87JdEC3Byl38debQWDccPoM?=
 =?us-ascii?Q?qBwxuv/RNN8udFZRzmPX5A3FI1qG3vDpJLwxvJdu8k4YDsYEpHrpal1gnp7u?=
 =?us-ascii?Q?8WaBtKXQ/IjSPTy2jkrqpmB6v0hzxENgJgVN+g816xVdQIjpCZKZ2UU0hkH+?=
 =?us-ascii?Q?40pTWvqa3iEwKQJSR0GS0ucCxNrHavmTcuVB/P9pOb+KZ+91t8oRDOpO83fT?=
 =?us-ascii?Q?PVPVx5JjZnxY/Rq4Xx6Ataqwxqn6PHpwVT/ycpgPx6/FbvK4EUdvAKYikZia?=
 =?us-ascii?Q?4e5/5TtxrugX7DMc+iMNrECKe0Y5WNlBJ9qC2NhOXvWDHUxe82GfpINF8Dtm?=
 =?us-ascii?Q?77IhqYf+Z6ZrlFOVKYcycjMbbbv/PAIF49MU7Sv2vO78mT4d1ugM37nBA3yY?=
 =?us-ascii?Q?v6eruyt+AXB/Q3ZBWd34K675mwoADCDYvDWcY1Rjf/8+1rJoN/QNpRPCgIbv?=
 =?us-ascii?Q?uVWglrlXN+N8uaW8KpB8nQec82+onMV/IQxA5hVr3d/1VKPceJTUEERX4kNR?=
 =?us-ascii?Q?mh6e0lsOxy6Nm/vG47SjwTcdp/ZD9xfaleZhmDNWsf4vKUHp/rFNnilAMbaP?=
 =?us-ascii?Q?O0CqKf5uQ1Roe+/ItpFICvCk5ObQkZ7RxaEJdw+VBB+xcqHzFnoDAGPXxW9u?=
 =?us-ascii?Q?ZqZS23rnZVTrOl4Aup0kyvhBE4ZRf7S4zrs7+2/N0SyM4nRiacV/dCQTHdlZ?=
 =?us-ascii?Q?KuGTcVrT9qsKg5hA0lE+M70n1YwKnz9Fx/i1NcFCsH19NvLN8klqpNNOPCYT?=
 =?us-ascii?Q?qOj7ayo/AYVmubu4JE30qhvewvuDd6AV3aZGdJZBAMfM4savBQoBnD0PTo6Q?=
 =?us-ascii?Q?2kPhK0Syk17lGP5N4Tby5sfvLoNYEtWFh/rARl79STCbRefBOd2ScNy1/w3U?=
 =?us-ascii?Q?LVfwIW5LN1dIpdMThGLl/BWUaIgcpKxm9BY5ttclSajiWsSxAaGDmpFHDWXT?=
 =?us-ascii?Q?Ze++fIXG0heizNq/Z39lMI/hLZkdtIh+ONh83yrUpl1iefSw0AoT7uF32nZG?=
 =?us-ascii?Q?5bMd78+KnDtdjIZHJZAa/KIlw8vkQ5LF2W3khXvtvYMOQp3jYB4D/fmGRfjb?=
 =?us-ascii?Q?M+fiDidXjv1Q47ukIDqnz2Xk7Q0q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:16:59.2316 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b48da0e8-a88d-4324-48e6-08dc809a05f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
Received-SPF: permerror client-ip=2a01:111:f403:2415::600;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

In SNP, the hashes page designated with a specific metadata entry
published in AmdSev OVMF.

Therefore, if the user enabled kernel hashes (for measured direct boot),
QEMU should prepare the content of hashes table, and during the
processing of the metadata entry it copy the content into the designated
page and encrypt it.

Note that in SNP (unlike SEV and SEV-ES) the measurements is done in
whole 4KB pages.  Therefore QEMU zeros the whole page that includes the
hashes table, and fills in the kernel hashes area in that page, and then
encrypts the whole page.  The rest of the page is reserved for SEV
launch secrets which are not usable anyway on SNP.

If the user disabled kernel hashes, QEMU pre-validates the kernel hashes
page as a zero page.

Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 include/hw/i386/pc.h |  2 ++
 target/i386/sev.c    | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index c653b8eeb2..ca7904ac2c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -172,6 +172,8 @@ typedef enum {
     SEV_DESC_TYPE_SNP_SECRETS,
     /* The section contains address that can be used as a CPUID page */
     SEV_DESC_TYPE_CPUID,
+    /* The section contains the region for kernel hashes for measured direct boot */
+    SEV_DESC_TYPE_SNP_KERNEL_HASHES = 0x10,
 
 } ovmf_sev_metadata_desc_type;
 
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 1b29fdbc9a..1a78e98751 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -145,6 +145,9 @@ struct SevSnpGuestState {
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
     struct kvm_sev_snp_launch_finish kvm_finish_conf;
+
+    uint32_t kernel_hashes_offset;
+    PaddedSevHashTable *kernel_hashes_data;
 };
 
 struct SevSnpGuestStateClass {
@@ -1187,6 +1190,23 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
                                   KVM_SEV_SNP_PAGE_TYPE_CPUID);
 }
 
+static int
+snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
+                                void *hva, uint32_t len)
+{
+    int type = KVM_SEV_SNP_PAGE_TYPE_ZERO;
+    if (sev_snp->parent_obj.kernel_hashes) {
+        assert(sev_snp->kernel_hashes_data);
+        assert((sev_snp->kernel_hashes_offset +
+                sizeof(*sev_snp->kernel_hashes_data)) <= len);
+        memset(hva, 0, len);
+        memcpy(hva + sev_snp->kernel_hashes_offset, sev_snp->kernel_hashes_data,
+               sizeof(*sev_snp->kernel_hashes_data));
+        type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
+    }
+    return snp_launch_update_data(addr, hva, len, type);
+}
+
 static int
 snp_metadata_desc_to_page_type(int desc_type)
 {
@@ -1223,6 +1243,9 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
 
         if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
             ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
+        } else if (desc->type == SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
+            ret = snp_launch_update_kernel_hashes(sev_snp, desc->base, hva,
+                                                  desc->len);
         } else {
             ret = snp_launch_update_data(desc->base, hva, desc->len, type);
         }
@@ -1855,6 +1878,18 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
         return false;
     }
 
+    if (sev_snp_enabled()) {
+        /*
+         * SNP: Populate the hashes table in an area that later in
+         * snp_launch_update_kernel_hashes() will be copied to the guest memory
+         * and encrypted.
+         */
+        SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+        sev_snp_guest->kernel_hashes_offset = area->base & ~TARGET_PAGE_MASK;
+        sev_snp_guest->kernel_hashes_data = g_new0(PaddedSevHashTable, 1);
+        return build_kernel_loader_hashes(sev_snp_guest->kernel_hashes_data, ctx, errp);
+    }
+
     /*
      * Populate the hashes table in the guest's memory at the OVMF-designated
      * area for the SEV hashes table
-- 
2.34.1


