Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B94CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xES7l-0008UW-CV; Wed, 07 Oct 2026 09:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xES1s-0006XT-M4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:50:08 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xES1q-00044q-3s
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:49:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gN7IuPh1j3Yfa6nUBs68CwgESbR7CTb2Az4arfNnWkVaw9K3VK4Ry9OG9jlCJdc/z0oGl/taOPRJKR490S8yrahxmkc/FABCEy6zzxDVP3znzS2H+qe8Wk2kYXsbdITpMYKZapLOlRvmueMHYlD2A6cdV546azK3P/dARCI7s8/B4D/PNppafYZQTccdln0Xz9EvHluDwq26KPfztP5TxMXpU7EqHZuidgDSHSmbzw2FjJGHyP3HPctB3LW3mq+SHvAswOQkvWrLPiQ+vo/2vfa0QAvxEJg3NWY7I2GeTU6D0s+SR3orBeCPixdFa8hItb5aLJ36Faf7RHpBN7kz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BwQLt9z9ccVGFNYc6uJj3gco7m9SnTGmnE91hDx3eU=;
 b=JGLRzpDLCMf0V3nAyobWnQ7eh+FnVPTRJp+jllra4t3r0WudUJlLLP5LhvfCrhHEY/mfMdBwCHU6KK5gskvffeYRdbWO3Z3BKqkuYtFKTCWwsUFWDoWMBRyHygHAIGJ0bcmFTrr55zdSMfQO/7Vr9yCb0ne0zPY8pYm6u+xxdT4PXPhaiaAs3336rozhGIJsQujUj0syba8LZI3a/ywZ/vn/Qj7wnokaSEgb+gk02yjotlpPKqDzuwyWACDquTl29Irdt5lOT7PE+h9oWkLkgNCCNQqN/vbmATGTBLJbNONdqetAn/TuhYwxLuzQ0QpbQRRbvX8QucVrSAU8+wcrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BwQLt9z9ccVGFNYc6uJj3gco7m9SnTGmnE91hDx3eU=;
 b=XzhIWOVg8QEuGpf1tjR0kec0m524uif9U2DfF6iXt4eky0Vv0Cz3yWSXEcnAj/MEa14WfdZO8onho7ukGJMZsB5D+AgGYiEj54K91aa7z1tNbRsGf3cIGryE1fLPPqgSyZ7C8HZjIRH96GpjP7/5KIFl8sKyfaaytabBnRp/gWs=
Received: from MW4PR04CA0056.namprd04.prod.outlook.com (2603:10b6:303:6a::31)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 7 Oct
 2026 13:49:45 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:303:6a:cafe::73) by MW4PR04CA0056.outlook.office365.com
 (2603:10b6:303:6a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 13:49:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:49:44 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:49:42 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 06/19] [NOT-FOR-MERGE] linux-headers: Update headers for
 v13 of in-place conversion kernel support
Date: Wed, 7 Oct 2026 08:41:30 -0500
Message-ID: <20261007134323.1606088-7-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007134323.1606088-1-michael.roth@amd.com>
References: <20261007134323.1606088-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea2edfb-61c4-4825-fe34-08df2479d832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|7416014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rlk9Cf/4tgINQR3IZBxsVNZituRzJXzj2pueRyIGwp7JJlzR5XGWqF57RsDXmvcvYDOlVM2tWQU9KZydvp95U4SqlUgK6hF1pR3FJCbMRN6nbpOikeSDTHURM+w/UDliWNi4IG8uKeE3zQWpd2oFPbAcUjOrry25q6yM/aUZVsFfUygBNzCTGe9Zscf3+5MCzL3bxbrP1bMqf6l0YJ7aE2/bHW/0IxodHf4rerutkpVTJ/lF1HxIZa2OHeGLZACB6bDqjYRIARAZ6DzyEpI/zUfVI2yQZfAuC+g9+/Z58sghnR8eTGqmffYwNaQ6ariubVryZUyw7pwvzLF4wJa1IAQfif+NvgNVroP8hmzu2u9a/6/AGBaSWVD1DEeibM+OUcYDlj4l1W4M3wx7nV7eosBiGOqMOxZMKClDHyJX5izxy36XibpMhA101P899wIONSUtzN5wE6sVnzMoeiV+JmxH/nyjDRaEU6D3z/qa4nsRJJsWn8NKsnhLSZHSgHd1LKZw6EGMm8/VVT1hO4N1JpqKKdtegmPd+6WsNC35DanqI3Rd4OoObuoK6A+EDkt91a507qAmBEK8hjXkswI22s915uxXzhYubnQ8Kc8zPu6yJeeuDj93ddOj3m6bAmzkdM3spcs2dTfT8I3l96i4LF9KTasfKZ1jgLKdLZhmOX1P/sTNRhOQuNbuvMQt7L7jMJLVg9bEymwB6qjats9gEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(7416014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JcMY/WkhUcKPtv+wte1TKhnreaXF1Fmfg5gLkPyGcGVDpZGPwzDHyxiz7xNnS09hk2vg/0bzc+X1/p2ukn0oGDy88MJmxVqHZVOS3sbVeXpl9KF36V9SWUs7qCSujKCmjYt3OkO95y/MfbzeMw6OMi2PR5b7YK+FcbSc5TdPUsFnnA/fgo1kTe3Lspe4D6MSvxPxVrRCvHbZus5Ix0JOiNKJFiN0iIs+LCNRr1jhUTWEc2DiPP3kiEDEbecBRGRsDQgVU8xazkiPjsg7SW9TBbddvieIeEpAIK4M4AjQ9eyuewDCQ07noCblQhsaj5xDGPcStORLb+ExLtXwx/xo8lnJh/6aKUKw8tPMHs9s1YypoFA97DYWl8YnTw9XBNC7noo3lywbBRlKaK9PUWYBvXSar6DgC6ezLAsKz3v3bfzizmF6WmB5xXdC0YfoMMHU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:49:44.5501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea2edfb-61c4-4825-fe34-08df2479d832
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

v13 of kernel support for in-place conversion is now in kvm-x86 staging,
but not yet fully upstream, so pull in just the header definitions
needed for in-place conversion for now.

This patch should be replaced with a full kernel header sync once the
kernel support fully lands.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 linux-headers/linux/kvm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index aea4ab5c69..7850bd4642 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -987,6 +987,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_S390_HPAGE_2G 249
 #define KVM_CAP_PPC_COMPAT_CAPS 250
+#define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1637,6 +1638,21 @@ struct kvm_memory_attributes {
 	__u64 flags;
 };
 
+/* Available with KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES */
+#define KVM_SET_MEMORY_ATTRIBUTES2              _IOWR(KVMIO,  0xd2, struct kvm_memory_attributes2)
+
+struct kvm_memory_attributes2 {
+	union {
+		__u64 address;
+		__u64 offset;
+	};
+	__u64 size;
+	__u64 attributes;
+	__u64 flags;
+	__u64 error_offset;
+	__u64 reserved[11];
+};
+
 #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
 
 #define KVM_CREATE_GUEST_MEMFD	_IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
-- 
2.43.0


