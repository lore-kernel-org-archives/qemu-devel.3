Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3954C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepl3-0007E6-FT; Thu, 24 Jul 2025 02:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uepl1-0007BW-8s
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:48:47 -0400
Received: from mail-dm6nam10on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2413::619]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uepky-0002yX-W2
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:48:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnpkBkpbJDdIeZ8/qhSORdza58JHd8J1iGOWtyaVIeV1rZrTriH2yRU/rQ+Juk42p/+OCzdBV1r8FT+oLPMEXNzcC+10hxjRcSiWETH/aqLwDm6OxewecUTwFNx221q6unkGw2lqeForirPnxBStsVXVJWoMKz7pcBLK5Ue6TleiCdPDWkt6OEcqrEtruJSYsBGPGjXJAaYviQkySfhUa837fhVxacih6wu/UTCr2Iap/c+MwDxr8wnUbzvtQ0UCwNBA54NXDxglT6PwFSV3n8CjmpJRX6cydylyC9SATK9mlMN+JoIN6jQLj2N0CV0QMhVN4AxLcnsaym7ygxeaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wiGQtBPrJPxrFmR78Sey4wafy2fm5zo4JG9LXRWPJQ=;
 b=qtNXCLZFy8SQ4HJPb037IJNUp9/5jPra2+vnbTQ3qY4Er6DJOhbrui27dJCTiTPbhnaK0itpSIWt6TF7LnPsQXsEtl37iyUt8PLHzDoGPCmAlWtX9LJZnLrzHrajLtHhQcDldqoo3Bd+OFfQolj+YYi+N9sdJMwe7gNwDIvUwo/pN50C2k6QjWMOm8afh5RutZJP670BsX4xKgYnWXFBNh+WrtA2VOW2HFAbspJN0eUZYb8xeQv3PzTbeiE/THfM41PYmEO2ZANO5pWDXVeNJ0KkJarKHjSGnYoMZZwQqH7CnNEXuWrAfBz4VY5PJh/Z6TxPdPJqKvMXmRxqpwHpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wiGQtBPrJPxrFmR78Sey4wafy2fm5zo4JG9LXRWPJQ=;
 b=X/Sszd8qhFYIe47Lnr30nmiWlUJ1EGUQ+obS46aVjjEunQ+iP45TtMzBkfgXva/cKYIXrvixivlY4SlkdZg4RZqwUQ1DhexC2jjqBS1o21iIDtWPC65mGBsyHk4NytR3NsENsK0PCBBhB7V919BwcYpFZBYAYdRzL3487Hy4yl4=
Received: from MW4PR03CA0127.namprd03.prod.outlook.com (2603:10b6:303:8c::12)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 06:48:39 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::a2) by MW4PR03CA0127.outlook.office365.com
 (2603:10b6:303:8c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 06:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 06:48:39 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 01:48:34 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 2/6] hw/i386/amd_iommu: Remove unused and wrongly set
 ats_enabled field
Date: Thu, 24 Jul 2025 12:17:41 +0530
Message-ID: <20250724064745.4091-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724064745.4091-1-sarunkod@amd.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d60b223-bd15-42aa-bd87-08ddca7e1f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TOI8nPvjhurhDFIz+ZZTyoxZHsGbCsHXXvvNrOVYbVCzDOvXDVao4/S7YI3H?=
 =?us-ascii?Q?aImvIUKJ5na8BGnFGkkUBBuNbyNLwEnPVeKV+D5/LYxVSF9Rl2iiMEvsjMBc?=
 =?us-ascii?Q?99Iahj3tAyW8/eyDSuoDJnSMoK4fvy4OyLv3lp9R37w2tXRY2yeMffVJbhUA?=
 =?us-ascii?Q?ZI6DcLYopda0EBaLdWWAiEoHPJSBJUk9WEa1yduBTygcbEiyOhM6/CTn55Pq?=
 =?us-ascii?Q?tIhrHdXbY3rekG0zttxHKbThJoi6bVXrADgOdyv83nOnHWxhi0R+mSibjdxe?=
 =?us-ascii?Q?ITzPpjKB98QYMsXSiplAjQkN2au6UCLG5Mq4Sp62HjzJTOm+Az4c0cig8G7d?=
 =?us-ascii?Q?AbdCoJ54Ejjic3O36sWxEVL/Br0XB6UPb8l+bJxgAKn3KlwTGshuLg6CNDKR?=
 =?us-ascii?Q?KLQHVhHlwaygnwjYv5WkS67VI1BL70tV/r7YW6I2gy0Sj0bRkuYiDVi5itax?=
 =?us-ascii?Q?k05WSIr1Az2hwsWebRS++q5uoFG1vZYJJNY4hFI2k0Ev6BZL34MZLW3vTfav?=
 =?us-ascii?Q?CejRAXhNYEIBwDxf3+TRAI90X1ReJm6W6LgC4KHf165RHAxcUXsOMNEJBENy?=
 =?us-ascii?Q?BeMbss2rjLXwQrO5Hr6yP3UjIbCsi2W3LLjzp/n2CcCCRIBb26enCwx50Iof?=
 =?us-ascii?Q?du4CDV+wvSAdWYka7Sc0Wv+c6hyFebg8PFPyo9p8vFygJiwouCeHc8SiqiaJ?=
 =?us-ascii?Q?1b5MeZo+U4/Y5Q20YzJ1SsuYlp+NcKHBuBENuPVoNirOqPQitXqXx+djP0ML?=
 =?us-ascii?Q?ZcyWeSJZt9LgBf+DUWzim4dFEql4Z9ivNWOozGAHB7TyjE2oAQgHoffLVqbX?=
 =?us-ascii?Q?N14t37x2qJKvMfRhRggY9aiotskQIF3jZ9cWzLvo66Dp3JTgVRqjcoe3/i3x?=
 =?us-ascii?Q?0DHTqH+PGbsLTJ7eP0ykBPlNarKFHyqoK1yuAtGS+mKDSL6GfVO5GRXIrCr5?=
 =?us-ascii?Q?f6Klzumco+vhlvopOWiVlPC+y67hgiiBdvVNDQoKfumhAqwduMt8H9VW8OKA?=
 =?us-ascii?Q?0qGxv34RMDaAaH4cM7s7esO5U+s/kJtWb2C30vGy8VKyfrLqNNN65zTA696K?=
 =?us-ascii?Q?Wh2HyaRbTDT/0772Nv6nsQifQw/0VWZu+Q3RKUSzpqXuxTPSKwooxzMRNxjY?=
 =?us-ascii?Q?EvM9lNeDbX1sqe8c1ZwyhvOw8QRmEhGe6HKbzUULRdtRm792BzHwjjrN96UO?=
 =?us-ascii?Q?bxOXbj+CPs9B6caMsmFXBu4iO4thRoQxSr5d2L0PqBI2zLdqycCoIl5r0Hgr?=
 =?us-ascii?Q?wCaGurnbm4nDQjEqtj5ZT7sknQnmTTStSHlAQ7acglTQ+EuGa0sfEUTSYqVM?=
 =?us-ascii?Q?y6TgZLXAApsSsLh7FQOiJNGfElJlDuACoWUfcep4OXsIo0peDAfcldSIp70B?=
 =?us-ascii?Q?sijBMJG56y6Qd+F1Em0OEypXP79UyTfkhkzMzTLwq0gfiOMpHbyWyY6VyBIo?=
 =?us-ascii?Q?SNpRxTpItraCB6SE7h4uXVPpLAt8zNb0JMF3R/NggA75P1a38kBlwHQfVeia?=
 =?us-ascii?Q?rS1BADOyUJHciwxvOBah2BmFuIoGMxs2R0F6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:48:39.3230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d60b223-bd15-42aa-bd87-08ddca7e1f32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
Received-SPF: permerror client-ip=2a01:111:f403:2413::619;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The ats_enabled field is set using HTTUNEN, which is wrong.
Fix this by removing the field as it is never used.

Fixes: d29a09ca68428 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 3 ---
 hw/i386/amd_iommu.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 7fb0bb68f008..39bb04fd9b18 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -646,7 +646,6 @@ static void amdvi_handle_control_write(AMDVIState *s)
     unsigned long control = amdvi_readq(s, AMDVI_MMIO_CONTROL);
     s->enabled = !!(control & AMDVI_MMIO_CONTROL_AMDVIEN);
 
-    s->ats_enabled = !!(control & AMDVI_MMIO_CONTROL_HTTUNEN);
     s->evtlog_enabled = s->enabled && !!(control &
                         AMDVI_MMIO_CONTROL_EVENTLOGEN);
 
@@ -1555,7 +1554,6 @@ static void amdvi_init(AMDVIState *s)
     s->excl_allow = false;
     s->mmio_enabled = false;
     s->enabled = false;
-    s->ats_enabled = false;
     s->cmdbuf_enabled = false;
 
     /* reset MMIO */
@@ -1626,7 +1624,6 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
       /* Updated in  amdvi_handle_control_write() */
       VMSTATE_BOOL(enabled, AMDVIState),
       VMSTATE_BOOL(ga_enabled, AMDVIState),
-      VMSTATE_BOOL(ats_enabled, AMDVIState),
       VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
       VMSTATE_BOOL(completion_wait_intr, AMDVIState),
       VMSTATE_BOOL(evtlog_enabled, AMDVIState),
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 8b42913ed8da..67078c6f1e22 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -322,7 +322,6 @@ struct AMDVIState {
     uint64_t mmio_addr;
 
     bool enabled;                /* IOMMU enabled                */
-    bool ats_enabled;            /* address translation enabled  */
     bool cmdbuf_enabled;         /* command buffer enabled       */
     bool evtlog_enabled;         /* event log enabled            */
     bool excl_enabled;
-- 
2.34.1


