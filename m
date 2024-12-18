Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5162E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwJs-0005PJ-7g; Wed, 18 Dec 2024 10:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tNwJn-0005O8-D0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:50:35 -0500
Received: from mail-co1nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2416::625]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1tNwJe-0003n7-V3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:50:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO0Z2MbonTrzaPgbenJXao+qvZwsLsU9t0rh0vHp37F7F/OY1shePvI6EsUjcPZD9hKjOoTjUZLwZjuRFmUZ1Sm2fMhCP8GbLrN0iOBWVlGEFGd/mBqvG4WcCVj18BFeVzqNkRMQ9w6OzVoyy0IRhMdAlTkETB/LJRQL8yyulPT2YzrHiL7IXANFsmmiAlUdwjO9DoubvLjNA+NQ9SjpKvTwFU2EU2XN997bL6tUukB5fPWF6l9vKuvQuzFYUii7I8/uQ3dViKHvuzU1BD5bJn9qyxs6mOLNgZzR/JVGI0H5AKGE12+r0Zk5b4dsOXqXgMg5WTjLseHIH6v+ILhvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGmmpmcTLV3AmYrzVnmgwyiRjPBVj+Lzuv/m/TuqAuo=;
 b=lPg1niKsNyXjaW6iLoWqrt4LwIXqjrNJLvzckiRxKbn/2LMGUqZ7d7Rn/6pt13gLXjP3aaLM5kQcsIybZgBR/610MCJNCM2QbGvPakKMMMyzbmmR2elpCV6aSWWmjw4fx//hGOjSKW3hHVYh85uGRgj+h1fAXdVf2X1eyHTtcoINYgfDTHoq4Q7O8hOfu4BkY2nCFRW0bxnjxg5TgXT/b3jvdlEY5ghSDWKZ7hm6TivN9lPXedOibM1voiHC9FEE4IFiCjYYtsnzu3IzB51L+f/SF32zn5BARXDkolSHo83ucuTKZ6Pq4nlkPiJBDCipfN+KofwS7RLNEOMpz3IWcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGmmpmcTLV3AmYrzVnmgwyiRjPBVj+Lzuv/m/TuqAuo=;
 b=qDSoxZPzNkRhk18qTNYLhrnSYixX7G4Zow4fCRYIMSogg+7h3/eoDjx+31riw5RqVZkXQ8b5FXDnJ0dyzgwEL3wZzyZ0BAgHeCjelRmR+yqxpAKyb0BZX4AhVj/+T8QtL4hIraMDupTs0VQ/GTCvl4MgmurdVvnI7Yi8i7CjZgE=
Received: from MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23)
 by SN7PR12MB7347.namprd12.prod.outlook.com (2603:10b6:806:29a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 15:50:21 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:235:cafe::da) by MN2PR20CA0054.outlook.office365.com
 (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Wed,
 18 Dec 2024 15:50:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:50:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 09:50:20 -0600
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <eduardo@habkost.net>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <huibo.wang@amd.com>,
 <jroedel@suse.com>
Subject: [PATCH v1 1/3] linux-headers: Update for 6.12 and SNP certificate
 support
Date: Wed, 18 Dec 2024 09:49:37 -0600
Message-ID: <20241218154939.1114831-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241218154939.1114831-1-michael.roth@amd.com>
References: <20241218154939.1114831-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SN7PR12MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffc041e-0ad8-415d-953a-08dd1f7bad83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+B4gflJ2n0XZm8BvTHmoOB3y72yBN/UYqxvhWjcmgv3WH0R/XusWUFGyU/GF?=
 =?us-ascii?Q?CtT+JeZr+cq/iufyqrNnYIi7dH4iChyIGKVS7C1GsON6ex1UkdwbnTKqmnk8?=
 =?us-ascii?Q?VXrKCcvUQaCDm5L2TqsLQcPZMuAwBupY+SeLoyF1fQhr9d+TWE7DgaAE/L7f?=
 =?us-ascii?Q?5sA0cHRT4LwVmyHUVanLRMTizLab3q8CkRU+kwHA0ERz1oVSeznqnUhVjdpl?=
 =?us-ascii?Q?68P81WIvyQTFep4bM8Sl9PnhCULlbMOeY1fTfYxP2lbCPUpCC9cTCUWZX9k1?=
 =?us-ascii?Q?HBDktLVrX47KRyTaNNs4nwE1ajSJpJ04CcdKi53GAVASB3HDmasjl87ygr50?=
 =?us-ascii?Q?6O7FKuxXNyhZMVCVMvswsqpXaM/HebaBJ0/CCsfmWKof3+1zwKPLfaaoXcoS?=
 =?us-ascii?Q?vrEnC6MbMjl7c4ozNJAZ02PwUeTMUP2oQ/ZSsVN2jjMFBF3N/TyHwQK6WPhp?=
 =?us-ascii?Q?+PF+ovh6+nkuVUKuy+AxZt6gypwG1immVpYCZlkHFSix3/KWALwl1c2EPi4L?=
 =?us-ascii?Q?6EkNfpx/FYKSItDovfkSqZ0El+p4LEkb4HvAmISxhSxbgPTTtRbB5Q8PCbkr?=
 =?us-ascii?Q?w0vMB+U+zaNU4wY9vida5fFDSVo4Gsrjk6PX0G6ltV3qVvozJcFADEcqQDf1?=
 =?us-ascii?Q?kI2R4f1IjsULng7X5doz8ghMlqd75l7WljHTz7W3qKxPWhGnmnzZcbq+KKdv?=
 =?us-ascii?Q?QyZQJFwEX0+7oHmFxRp8g8bBYb2X4k52ahW/sVvKUxtz2svjvGdQerGnhnNo?=
 =?us-ascii?Q?YN14KnvGve5ODayNI2lmI6rnIxqk7NPMI87Xdoi35SY7aWwXvyUiMcjhW4Iv?=
 =?us-ascii?Q?o+Ke0rkxdgk4pVoEZFkKsepDzYiWjmScnGpabStQarI4B9hwapOgZmqcJhIA?=
 =?us-ascii?Q?FET3Dn3+F2/dKPkDplTHKH/M63AEyXm22J5q/YRAFfIWL555a+3xdgCTIhJw?=
 =?us-ascii?Q?2F2OHfJnFOTMIJv3QWoz75nBRJ505KGoHPH2GyZu25wZfabjAdpsNznsOy2b?=
 =?us-ascii?Q?pyTOBPE8CeIjYEXt7tpaTNVRH7wm4OjuHbgBcwRbaN0IPRVzx9GA5h/cPksh?=
 =?us-ascii?Q?36XLGftHz+uHIcweOboTUuC1A91YuTtRLV2C8tJiP3H1U2oJPPKJPLpS7eBb?=
 =?us-ascii?Q?C6awU/09948CdtyOFc53qlaYXBCkRxo+suE2L+Mc+ob+0ijLDUupngQSTDII?=
 =?us-ascii?Q?UwMQ7br8eD14JousFRXUVpGacNgRkaR5R4H37x1rCOWByIQGIBaBavNAsXPq?=
 =?us-ascii?Q?m7sQlZIOPEL3OOD3eZhZkAgYVK0TgqtH0qeQFa4lzO39dUc2MkJn3/7lr3RZ?=
 =?us-ascii?Q?w/tHm588iavdQy9B4j7XtzC8dsHx1y1zWOh570cnJioKeWUtQRMAYNYFTXsv?=
 =?us-ascii?Q?r0DJPEyfRts+hclg7ixJauIwMSvhQUiAt0CCd0CIbgKViPtxPGniLCrs7HUq?=
 =?us-ascii?Q?1jS8MgwDwyBWUK+RelKml4seJ4OvcVGYHCyhTzOpxEhyTvnN/XeUhmUYycpg?=
 =?us-ascii?Q?7JTScu7wvPX+QoI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:50:20.8217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffc041e-0ad8-415d-953a-08dd1f7bad83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7347
Received-SPF: permerror client-ip=2a01:111:f403:2416::625;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Michael Roth <michael.roth@amd.com>
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
2.25.1


