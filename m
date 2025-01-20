Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91D8C02182
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2025 22:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZznt-0006t1-H1; Mon, 20 Jan 2025 16:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Huibo.Wang@amd.com>)
 id 1tZzNP-0005LL-PO
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:32:09 -0500
Received: from mail-dm6nam12on20620.outbound.protection.outlook.com
 ([2a01:111:f403:2417::620]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Huibo.Wang@amd.com>)
 id 1tZzNM-0000Ae-7p
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 16:32:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p44sw0Fr8/3oF9AZONjOYM/SZfMNijA2zvdM3UE5Lkl2tPj9kAJrHZeWwIHRhPGrH10nO+jeS1jtdl1CxPviZGCvjKZZegjICPxyP6EajEe+dz1kwTF4oX0iaKsQvmqxafzBLgu5Mxa/hgEYah/22KzWsKeLs2ZaM4Eut3dKD7jyjFaL4iw3oapYoPP8OsAdod/j2mYtI6qjFaW97mJDI5vf4AQg5v6MplmqRVzhNIDDl/zbr1xEej2ZHgAJRBPC6A0JYs8uHXiLHGWkWP5qf9jSN5yqLnFriTH0wdZRvlYdAIlsio4jejawVK2XjQG9d0xSefDBd9jsSdSp4lJYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2l8yRSZ0y9gIqCPFqo4uHuFSQMFdEflfSEpPyuuGtA=;
 b=Tc0yLzu0WZN9PbXaYNhnXSibAfNXpGCpOpXGmrWkHO8+UDz3qfy404d/+zTavLU5UczBRa3wyNdbrcjHgwTuVo+9XwqqaI74yAAoruK+B9lpATVz3qZWofkVzrS2DWAUz8UT4AqJHvf/mXhd5sx2Aa/1LIVCK019O5/VaZUzYhAzPtrVSGskgoDRGBk4qd+NjfbGjm6e9bhiUYZLnYomRno/T30HwbXcgPlD5wEJ0gQmsQUrTEG4PGIpx94U3yAMlgGmh+x1OW4ZYd9XKOd94RYbDsYepte+ZXPktNSU71vnkPAtYck2cjL28CU9JVNRmFzUWOt/aFd9MmuDmh2jyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2l8yRSZ0y9gIqCPFqo4uHuFSQMFdEflfSEpPyuuGtA=;
 b=sydIUPLuOVy9eLX6WTpgPpc3TYTCBaTWbDGAESmBTkhxmnrRJFUNPheEL2y194OYrjZ+quc7AIzrBYlmUZzh9v6yrKqBxpgP8HbNGKiof+Zutq+18g45VgwS3r21u/0u5KZYGya9VpVoDQegFTomhonZJIpNsAucpP8iaX9ifCk=
Received: from LV3P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::9)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 21:31:58 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::7a) by LV3P220CA0006.outlook.office365.com
 (2603:10b6:408:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.22 via Frontend Transport; Mon,
 20 Jan 2025 21:31:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Mon, 20 Jan 2025 21:31:57 +0000
Received: from ruby-9130host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Jan
 2025 15:31:56 -0600
From: Melody Wang <huibo.wang@amd.com>
To: <qemu-devel@nongnu.org>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini
 <pbonzini@redhat.com>, <eduardo@habkost.net>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <jroedel@suse.com>,
 <michael.roth@amd.com>, Melody Wang <huibo.wang@amd.com>
Subject: [RFC PATCH v2 1/3] linux-headers: Update for 6.12 and SNP certificate
 support
Date: Mon, 20 Jan 2025 21:31:14 +0000
Message-ID: <20250120213116.521519-2-huibo.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120213116.521519-1-huibo.wang@amd.com>
References: <20250120213116.521519-1-huibo.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|SJ0PR12MB8114:EE_
X-MS-Office365-Filtering-Correlation-Id: db9a1247-6779-4968-dd5e-08dd3999de32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J8Zk6+1bysTUJZiajneDEStF3SNubGfXY9a9909u4gZvtza/Qkwty2ZaR9vD?=
 =?us-ascii?Q?4LV1MRNEIih15zm5nGea36ecgCe5Zuoo0z4UCSazYjO7J6fhaoP7c2bILEPV?=
 =?us-ascii?Q?UWZBEcyyc8ITTej8T/0q2Y6GpRiB4jeCpWCX3kYkdBpFVE6fdDQ9HWGqmvSY?=
 =?us-ascii?Q?lD3W0l1yXCwnPlNkU6BtcXJmd+AviTV4dYwKW+2g4TzCL2QDsQXU3wnH3OzZ?=
 =?us-ascii?Q?UPnvzbeksmDtcykZYhddb0aMX5DCwU0TZnxBwhZM2UXg9LYiUl8QKOvW7YmL?=
 =?us-ascii?Q?5FLFA0U12HYZUZS6jjVzb1ziJjfTwAC5/wtrfjsbWvkGZjVwe01M85Yy3Tn9?=
 =?us-ascii?Q?rzII5m8sil/lV/XOX9xn5hjYGkAgGepPKQXEL44/xJVEkPGJAgX1UG0ehiNR?=
 =?us-ascii?Q?9r3BnPHmz8uFQYUlNpLmkDvW7BTKg5ckB20iBcn8m60vI4OvC5FQgl7ITBdP?=
 =?us-ascii?Q?gka8ivgTytvASOMSyxP9I+z6CKroZSoBgKHChnhHu8F7jfTzJOjVVfcxWv9h?=
 =?us-ascii?Q?ibCn+CX6f/Czf5gNhQOZcgDOUt70hpFNxqk0Mq8V3L6cfwIThgFi+fwLQNDh?=
 =?us-ascii?Q?kzK2rR9KqYNkhJqc9Orb5V6yw2qktQiisgUEdiIpD4ZDHd0dXyrwjnrD4ueZ?=
 =?us-ascii?Q?u30AoR0e0XbnlJJGwVFxRI2ICIeQxuvDxogrTrfXs5x12Ux+0P3kvEvrSuhu?=
 =?us-ascii?Q?jD7UDKSxAXllpe0kRKDfncx3+sk4UTsoE7ejR4VYNq13FRsKk/ZM4uDnToUs?=
 =?us-ascii?Q?VxAdW+4o0g6vxcvn4rhRNSj5J5Xfdpq0vkUPJaYwLQZ6ab6iu+FBXCUKqUY8?=
 =?us-ascii?Q?yHB4lPFIG3vJlY77idApbPjPw7dxKweN0pI3ZXksdjbho/sW9VH9vpNAxS4O?=
 =?us-ascii?Q?lTfFi5ej+HwU1ZlaQkFOxjNEtoOHJj6QQt1OrqSxRl36YTP626qpiyrxNR7k?=
 =?us-ascii?Q?hZQDLggLXl+Qd7kpTR+JclbCMlQZnZ2vd/rrO3SWYh8CYWoQrGXGa//5Vr0q?=
 =?us-ascii?Q?xZ8khluybrBOEY8yAFoYvbvLboH77fLIYx5Fs8M7Thha9H9HzWR7DPIsFVuo?=
 =?us-ascii?Q?OAkGe7hYuehmWVWq6k/egGJRRhutswj6EmdYqjDWwt5Z82m1LWWQkjAwa71h?=
 =?us-ascii?Q?vUM/pCSI9GweFbzOSuVZ5CV4MnXFasn0z8pdNbWDcNyVSXd91KjTOZlKDCKM?=
 =?us-ascii?Q?w5piBRh/5iKLsWTAUiQFt/VNmocGcpLe5ydXHgUzzvutzY24g3mqL8DDBhSp?=
 =?us-ascii?Q?kVlBYSsCBwyDKfRoAbdTpoRKQlT56Cb9CN/aRQtSvDPMSn2EhxWx/zqE+B55?=
 =?us-ascii?Q?tIIItleMy2Ix3FllvzYZsORvA86EVXMG9znyUjA5v26hQKnelSPIuEGpAp3g?=
 =?us-ascii?Q?BEPF1nDF3qmaz0YzSwC40SbeEFd4/X7HxI4/btIqT9gUYzOYhCUuAYnaaCPO?=
 =?us-ascii?Q?/cyXS4XC+UG9xa9fZtuOroipOjSWw0IbtQyv+72XNZxujUNKW2Xs9xADxoQb?=
 =?us-ascii?Q?Df0WvqEo67q6Jog=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 21:31:57.6508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db9a1247-6779-4968-dd5e-08dd3999de32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
Received-SPF: permerror client-ip=2a01:111:f403:2417::620;
 envelope-from=Huibo.Wang@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 20 Jan 2025 16:59:27 -0500
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

Add defines for SNP certificate support.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Melody Wang <huibo.wang@amd.com>
---
 linux-headers/linux/kvm.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 3bcd4eabe3..10f6c908d9 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -135,6 +135,12 @@ struct kvm_xen_exit {
 	} u;
 };
 
+struct kvm_exit_snp_req_certs {
+	__u64 gfn;
+	__u32 npages;
+	__u32 ret;
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -178,6 +184,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_SNP_REQ_CERTS    40
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -438,6 +445,8 @@ struct kvm_run {
 			__u64 gpa;
 			__u64 size;
 		} memory_fault;
+		/* KVM_EXIT_SNP_REQ_CERTS */
+		struct kvm_exit_snp_req_certs snp_req_certs;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -925,6 +934,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PRE_FAULT_MEMORY 236
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
+#define KVM_CAP_EXIT_SNP_REQ_CERTS 239
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.34.1


