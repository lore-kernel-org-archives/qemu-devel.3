Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7371DC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrXz-0006uM-UL; Wed, 20 Mar 2024 04:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrXx-0006r2-Ov
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:43:41 -0400
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2412::600]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrXv-0007q4-Vc
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIVcXwEY6KI1YTNOVA7QpmPqov9Xe0SV6+UXp1TDSZO8n2DflpVpk3FZgH9C/q0k29xejpC3InRgdwkdq5xA5AQkbfYZj5ClQxtyZzIm3fSWZncGp/s0rghtOVVbWpZczoUuxOzq9G+w1UiRrxvcKDWLEgl8+j6aBdLfmZ3FWEK32vVdS5fIO4DesNypC1aJ1GOtOuxo5ib3QyZzqd48HQZWLBUCjvrtuXy9nv8lP3fBpAbwT96dvGo5P/gXElKm4rEf7OGWIvorm88aCSzl+nD6NsmJ4hBQqHSeuHgOKjfl+vWCivjE8UOhOCxoJQ5IXlzLV/ejTAQK5LSzKAdKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTqtcVZjp5Czz38jYigxgL9NCDNjryBgjRqYPmRRX3g=;
 b=Qx4ebsWwJZM3c1/jFRay9haLEub0zUB0cfqVZ6NmHsMhkzLQLNTylOYnYfakvGg0IvyURvadt+hRzqGquwXPn/InHCukCffdIwx28onhlwFCK0ijL+qO65xqPOvuABT5CFMq0QNIpAhUtN1a/kwZP9FJTBDS6/Cfa+F4V65EKP07oJdOVAjepzMRLtvUIJRvySfY2pHSe2C7yGnk1vDGjUPzOECg+xonX8I8SKK5UFbnrU+lBIyXNLZ75T3B3D62/mgzU5jiHIFe2WtxqmfL8+H4qoymAwpgRRxaiidEpO2p/ls0mX+u9w6S035hhwDYXRYr1HLW2qDgRD5SZVYIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTqtcVZjp5Czz38jYigxgL9NCDNjryBgjRqYPmRRX3g=;
 b=mO5aasD6was/9ZE+WbLpwwdf5gYSKJDY9oJNqNiy17j8e+CDOstuDLuOZtSRp8zBXhwP32LUtwqow/+BpSiRokKytCcAPHknP9Ls1Xa1eRqRB4ljOE1fr5VgMbdttA+qjYu4QC/T9nHq3aW4rmXXInJxPVIBYrOD6BPPyuGgVRU=
Received: from PR0P264CA0083.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::23)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:43:36 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10a6:100:18:cafe::aa) by PR0P264CA0083.outlook.office365.com
 (2603:10a6:100:18::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 08:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:43:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:43:34 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 15/49] kvm/memory: Make memory type private by default if
 it has guest memfd backend
Date: Wed, 20 Mar 2024 03:39:11 -0500
Message-ID: <20240320083945.991426-16-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b6ec9d-d6af-44d8-81b2-08dc48b9d4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: miuzvejBctE+hSNFvabJuddQsm7nnWVcz2cLwsqJeGPcvG6/geias7G1NM0sbUvxumsuJcmyh4xFxFOdEsrs9cLiqfSpn0Z7ZFDsEfOc3Fjycr8y9JBUIuS+esPOiKuhu54LhtIlZdvVJd3SKXjwaHMDKoWAHawz128lBsTab1TaT1csvqC7TOPZbcKf+isIvr+hg2zwY47dKh9js5C59lvSbu/V7l95Jc99hku8nWgtyTY7hJvTBjUgpm2E/JsMobTqfZcOm+ifhjX/GsJ/Zm8V92lxec61M6FotCmNdKk8eY5uqind45x/zn6vcI7ztTwg/Z3o9oROZLQ672MXqlzsoDzU8wiKQkBQc8Oe4TEUNVst+KsF9ZDhKUb8VkeBPhbCv158J9WY3PWl7gafBfv5Wqxk1eTSGNJf0QvnTscFdSH0l1eOODvwtTpD4J8uGRxMCaKWGv/HCR1kmFIj+8R1AMU4guBPGbHeAYDNHBQYfe7tznT7qxI5Atlv7K2H69ieYc4jvIRTZ+Rk/Nubl3xG80gkPS3FuaLpqUtqo3xzaniYJf/84vA3oD1kjfGLxP7dcY9TlN+JwkxTujYh8bz8h4cKSewHXnRrq4k7K+7GFya97m8RJtvquJ/Jnx8jiNPGqJiWeJb2N9nHfL0I73qoKXETsWi++7dFzhyZ0W2n0jPu/D9fCRuLVWEtJRqXfBm59SxWw3cXMXULj3ba5yjfQCWEFzxPpupwZDA3hMnkzy+0vXD5DUFDBwg9FHE9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:43:35.2581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b6ec9d-d6af-44d8-81b2-08dc48b9d4a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
Received-SPF: permerror client-ip=2a01:111:f403:2412::600;
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

KVM side leaves the memory to shared by default, while may incur the
overhead of paging conversion on the first visit of each page. Because
the expectation is that page is likely to private for the VMs that
require private memory (has guest memfd).

Explicitly set the memory to private when memory region has valid
guest memfd backend.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 9a8b365a69..53ce4f091e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1451,6 +1451,16 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                     strerror(-err));
             abort();
         }
+
+        if (memory_region_has_guest_memfd(mr)) {
+            err = kvm_set_memory_attributes_private(start_addr, slot_size);
+            if (err) {
+                error_report("%s: failed to set memory attribute private: %s\n",
+                             __func__, strerror(-err));
+                exit(1);
+            }
+        }
+
         start_addr += slot_size;
         ram_start_offset += slot_size;
         ram += slot_size;
-- 
2.25.1


