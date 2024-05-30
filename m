Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94355C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCdmW-00068P-DG; Thu, 30 May 2024 07:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmV-00067X-7A
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:15 -0400
Received: from mail-mw2nam04on20609.outbound.protection.outlook.com
 ([2a01:111:f403:240a::609]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sCdmT-0001VR-AZ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVBy77h31i9uKs3hRYSQP9w2xcSCroDL9SRh90fTzmibgv4A0peMeW5/Uc2jXFEU4x9Bk8hk2Fmz+CnD1zFQ6u/gM8Nu0eLVzaeUjD9MJIiiYGUJylF6604yrP/T1riPhtdTlC836g9rpHOjIFqlik9YWRqtDVQ0MopdFftyon+Vf4QX39p3Z1O/Tdjkr2q8T1jG2bEeQ4WhuxZjOn1nXdy/anCG3bUfA5geG/U8of2x+8JQy/duHPkGxyhJ1h9s5PnnFWHCQqq6nhV2qu+aKo0qCWpJctF3KzOxGcW9CSrfuwVGiaiUuQU3gXGqxi9wFBB5Fz5jfFm+FKrtGK6XJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQmGneEGIQyCeB+hP5aEHRwAi8ISVe3UdrZExegunhA=;
 b=ZNyMw2d22qlTrKS/YhiNgTaZydESplIAWHuchGeaC3xuZlJi3O4czt48+jcFXsBMf2g+yPyg3JMbNHSdwXTNJV0DptwyH7N0gFZ4TmybRfr2c0fOQt1s7cYe14WHq7ZMd4L7yZtOoPa65X7CC3cRpPcCLHwbHJC5DYgSDY+q+tJswBymIe4PKU8ihZM86Uu/kITIbuUFXLo7s7I3w/UhIHiVFxeeqfFoR4H/c5t0WvkW+W8+IfUVRo6LNKqTUfL1dtLTPZI7lHiv/hCXf8wcm4F6j731NB9N+H8uO8JgGcMa16rKr8WzkeXTTqlyNm4xHqLoF81JSJsHIz9NwnVhrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQmGneEGIQyCeB+hP5aEHRwAi8ISVe3UdrZExegunhA=;
 b=LcnQOpN7s8FCb7FeAQfJJEcX7tor0/nZcxMHZVbupN1Zp2DzGp+ogV6qRHRBMIIsWEiqzqCZIu1kcD2Vi7NW5kgp9wY1i743/Iw5bJKqX5hykVzKac31URhJv5szmIyMwSXM5IQ0SOjsRSpkp6sDXbYJes4oUWimNB9dx0XnDKA=
Received: from BN9PR03CA0557.namprd03.prod.outlook.com (2603:10b6:408:138::22)
 by DM4PR12MB7502.namprd12.prod.outlook.com (2603:10b6:8:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 11:17:09 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::9b) by BN9PR03CA0557.outlook.office365.com
 (2603:10b6:408:138::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.18 via Frontend
 Transport; Thu, 30 May 2024 11:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 11:17:08 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 06:17:01 -0500
Received: from pankaj-M75q.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 30 May 2024 06:17:01 -0500
From: Pankaj Gupta <pankaj.gupta@amd.com>
To: <qemu-devel@nongnu.org>
CC: <brijesh.singh@amd.com>, <dovmurik@linux.ibm.com>, <armbru@redhat.com>,
 <michael.roth@amd.com>, <xiaoyao.li@intel.com>, <pbonzini@redhat.com>,
 <thomas.lendacky@amd.com>, <isaku.yamahata@intel.com>, <berrange@redhat.com>, 
 <kvm@vger.kernel.org>, <anisinha@redhat.com>, <pankaj.gupta@amd.com>
Subject: [PATCH v4 28/31] hw/i386: Add support for loading BIOS using
 guest_memfd
Date: Thu, 30 May 2024 06:16:40 -0500
Message-ID: <20240530111643.1091816-29-pankaj.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|DM4PR12MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d19acf-2aca-4483-622d-08dc809a0b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sM5jLii9Ebf4bsilYj2nRpVpogIdPW1vOgnsu32635DA1Zlie1z7SN7i6U4I?=
 =?us-ascii?Q?wOZit1cQHdm34feyaxQe+tEftE9IuzaNTC9+TzOxX1ddocFbBitsoFgRd3a8?=
 =?us-ascii?Q?Dq1Z3rZ72faEre6LQz669UrpA9GpD4Mn2pVUEsOURnei9T+SQOngFLT2BO6q?=
 =?us-ascii?Q?KSmxHTdr7YSmKBkknOrSoTxWVSmi8GYMP6vFzFBkD3yAosdRRx0hTEV8QvJU?=
 =?us-ascii?Q?xDMO4XT9UY31QzyiUAyqv7hxrzns39IzRNc+FapQ2622I0weGMCKqPCxHxJV?=
 =?us-ascii?Q?YRhJ4NlvNZUW/ehmmfLh825qNcfd5Ya+yvYDjnwahSzxEULGfmQIhbY5Ax5p?=
 =?us-ascii?Q?17FPyrONyzzpTgwZrqAuRPINm92EcvkBSdId7KhlcHbLigZfypRwTCBSAA1L?=
 =?us-ascii?Q?L6m7wFmPTKdRgcQgorHcBYIHA5s8A4gcQh3dQs7Kz1mIrvCCbQC9t2T53WdX?=
 =?us-ascii?Q?LWznV0LLNP5Ouhn6RgMhDuLVxw+FcoyXNS297zka0k5HXTmqFjQm9fdbgpEV?=
 =?us-ascii?Q?UzSjP1jsB2H0020Qn4vAlhfEw5G8bXFkpznKskI+uHSmIzvcEXWW8raDySzO?=
 =?us-ascii?Q?U4PgPEyXjM0Rr+H4T31/8m0cKP1uuS3rqGDEppLKaz1+tl95L+WptEanEQij?=
 =?us-ascii?Q?jFuWGYI97N7IEYrXPo2VAP2lyvuMGYzP25BsGf4yIekP8rgHx1m2B7CcAB+m?=
 =?us-ascii?Q?mXvaSRm/f6HiiyD8Q1NmlmgFmFwGDJbzlKAx555Rfd65D4D9+W7+DLFQiOED?=
 =?us-ascii?Q?iGmqzxpR6t3l2w4NvOxjQCv8amLqye8LG85TQL+gt9Y5gCdHI2eUMdhxcS2h?=
 =?us-ascii?Q?thMjvIvBwNKT8SB+hxj3PELUMVJteeAYvMKXdawkDPEZT21ZwiAMM7saJa3A?=
 =?us-ascii?Q?If4yT1dHDSbWGiT5r/QSDCI3iOIFgRXOawx1tiHtr1SNrAeMiqEQQJhBnT7T?=
 =?us-ascii?Q?G/cjeVtYA7zY4OKgQZ3uJ9kJ6zVwjTIkEv1f8wlxguQYCMJut4OCxvU6eW1d?=
 =?us-ascii?Q?LQGFH1X7EfqPO27YiII7nJWioh758uFLjGeUFqtCXGx/VBqcqTbHBEOrWyDc?=
 =?us-ascii?Q?N+64jZ4/8yniZ/a1l2/DF5zxz5MGujDZVRLv6WrPWSq4/HBDK8CtbbS17ISI?=
 =?us-ascii?Q?52b2JnEjPQg7zU4i9/lXGx0KRGf/KmFtJF/PAonnyY+hBJtqQqllPWhh5nBc?=
 =?us-ascii?Q?UySslhbmg9OnAhQYyDX+jqgCXLBhoeFbJD/iP7ZkCTF7sYuXpcRBg7M9BmUS?=
 =?us-ascii?Q?wHLiksUMKzQcMSpuPhGuhLSGAfaJzBRhBdvdBNk37wlQRJ8mBn3uioJZREuu?=
 =?us-ascii?Q?9Tj7VhCdjRZJ0oTdxKMtVDEYXW/99D/xFJ5l4CVYM6ccmvQSpQnsroqIBYpA?=
 =?us-ascii?Q?SYpeVzQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 11:17:08.4729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d19acf-2aca-4483-622d-08dc809a0b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7502
Received-SPF: permerror client-ip=2a01:111:f403:240a::609;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

From: Michael Roth <michael.roth@amd.com>

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
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
---
 hw/i386/x86-common.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index f41cb0a6a8..059de65f36 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -999,10 +999,18 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     }
     if (bios_size <= 0 ||
         (bios_size % 65536) != 0) {
-        goto bios_error;
+        if (!machine_require_guest_memfd(MACHINE(x86ms))) {
+                g_warning("%s: Unaligned BIOS size %d", __func__, bios_size);
+                goto bios_error;
+        }
+    }
+    if (machine_require_guest_memfd(MACHINE(x86ms))) {
+        memory_region_init_ram_guest_memfd(&x86ms->bios, NULL, "pc.bios",
+                                           bios_size, &error_fatal);
+    } else {
+        memory_region_init_ram(&x86ms->bios, NULL, "pc.bios",
+                               bios_size, &error_fatal);
     }
-    memory_region_init_ram(&x86ms->bios, NULL, "pc.bios", bios_size,
-                           &error_fatal);
     if (sev_enabled()) {
         /*
          * The concept of a "reset" simply doesn't exist for
@@ -1023,9 +1031,11 @@ void x86_bios_rom_init(X86MachineState *x86ms, const char *default_firmware,
     }
     g_free(filename);
 
-    /* map the last 128KB of the BIOS in ISA space */
-    x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
-                      !isapc_ram_fw);
+    if (!machine_require_guest_memfd(MACHINE(x86ms))) {
+        /* map the last 128KB of the BIOS in ISA space */
+        x86_isa_bios_init(&x86ms->isa_bios, rom_memory, &x86ms->bios,
+                          !isapc_ram_fw);
+    }
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.34.1


