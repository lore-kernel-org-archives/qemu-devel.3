Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65619C79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42sE-0005Io-VC; Tue, 08 Sep 2026 16:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42sD-0005Ib-Fu
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:56:57 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42sB-0007Zx-UJ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AW2t5Yq1LKgfuJ+09CdYG+/T6oayMkvJVqGLGUnzHv7mniap6qS7JkbGQSgliGaDQbjuYg5RqZa9PR3SSOGjIhotSLjTMtvQKZI9ywQkpHdLXyKyaxka+TbFrO2Z2n2yqeZtLNhQxsRD6wICI+q5+3ejKtBk7wSXNsRcjdf4ZpfyN0W1jIlM3rXx9VoQF0VI083e6BBlochuhLrKR7Fkx1QKd5wr/F1EeSWodFmVY8YGVmA92mgxL0KScffaDaWbXj47qESerCmd7buobRlPrttL3plLgcdnCWzMqFEyMKumzAUym7Bxe/alVtntHOqUuDLQ5vwS0TXLmcP1XwrZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=islPSdAv3aOpi4qv1aJQ0BKdtr6UuSvrO+JTUDaa/2k=;
 b=U12imN8N35rlRzQmDKerjT03TdPzerxCpAPO/Ul33NaNJ+iT7aj/AwV9Oai4waB4yhxjlyN6N9v961ZEAsnw1R8tPUgRHMAQC+b2RPCChfNDW1w6ZquELq0jh7ITAvtDL21H9woVglYSPJzCNZCYb5wkE+8zzHbVVujF1d35kGYV293smuDw6rKHz476sYRaPF46EHIGCa98aRNuA7uEn+n/M6SJCw+dYo6+wp4WahTZubT6QflhJuJIWpb6dprqcKYLw10jvkiCCDNTTyArHy6NdoGCPu0oMF5K/KqJDWgKla2lbekxtyxIkchPRLxbPr9b/ruMCwHHoyF3cz/Ujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=islPSdAv3aOpi4qv1aJQ0BKdtr6UuSvrO+JTUDaa/2k=;
 b=Khv6ls17WKuWdrJWzTr69uSqNYqMLzsi5ZAU6EYNBDbO/fP16490hvBVmiKKwa+H5cxYt4gVbf69YR0GwMvfuCzZ1R17FwpjFOS1bJ6qygOpGH1SktVfrA78q4lfLXXuZ6bGqZcr2BarDkOhHjWLQqiHyoRXuSrqcMu61rpxpGs=
Received: from CH0PR03CA0419.namprd03.prod.outlook.com (2603:10b6:610:11b::8)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 20:56:49 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::64) by CH0PR03CA0419.outlook.office365.com
 (2603:10b6:610:11b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 20:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:56:47 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:56:46 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 18/19] accel/kvm: Disable discard for in-place conversion
Date: Tue, 8 Sep 2026 15:48:38 -0500
Message-ID: <20260908205236.838281-19-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908205236.838281-1-michael.roth@amd.com>
References: <20260908205236.838281-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a7232e0-a3bd-476a-485e-08df0debb2a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|36860700016|376014|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bCCJg/M8Otm6O51aLYAtkbmdt8r7t85tvwbh8awv4veBitd2r4zRDukfSQVrfx+6SR9KOOrEkHsT8m05N9OX2YkY/Xd2AbPXaWGvLNutDfZ70EFPsC8ZtaZxEJZr7JGA8VY9kpzKQoUf8hUStSBMdpRbn4VkXx7VDC62ikr9Umuk8ksbSakU1soc9JtX+c/jRe1XQlfVJLXY4qvRO3k4M5QdVhWk/1b2aM9maH5foW2l3DzWlsYq9aILYKQEhb1gUkMb0nyOnHrRIMXTnYThQ8ufNnq/d77ucCIA8D50NCr/hJq0KFNHT0xLOJ9Qa7AWoaQsgJOCTSjcfQvUnAO6MSRZTsaGB/gWNYYz99qbrv4lVMV+W35sp1ePEPwo0eapbjUXv/U0zEeASPnCkBifog+A3fA11BAN4uPUq7mCpo1FOmw2g6oOMi/PhT2X6McCQgkP4Fs0tPLNCb1hI5nWiwf8S4Wj/eGQT3lyFf0cWqPdrco4NXFDmeKOwOotoZPGEHzdX0AHOYM+P/4bO8dMDx1iRy7TN2dIPqecjnufv4reqeIqRwMlmhx8Znj0BVkE9jZ/B+OvZZ3A4M36vNvMdkymm55TvBKJaHMATKElNWFL13DbTPE6kOkS3pkwuVe3/6RNQXMJR5oRPTnFVV4b+w+Ht5+Lue/xkURMwqq6ZpJJDCJqGr83uC61azMruv5iCvsTw1EwgPJhSn/epU5g9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(36860700016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DJX6QXa0qZxKG8SHAIuJNJdAxC2Tth2qxIvKgxTmb5GGm7dWECushR09FH5mfVqFVQLSHGplHzsZvGhTyEiOBzHVT9XmtiPO4QBgcE8HWdb/Sv145XMoOXsp2znKH2EfUpuGLJJTnKvEPFWeCzzI66lJ2kRMpSkYuq+seRhDL/6BmXLDsdavvDGULWUaMNTLJFRRGo5vIZSXDFyGtLExW1VhroyzOIrEplstFU3CtUSXPvBrUnToHdbqOTExP0Jp5Wj5OD8wGouAqSS0HG1lNCkLpKrxNgHNWrefzRYJK/JeOHgeNif0lCuzWXEehBgXe1lPiynX14zzz2QmHV4uwrq/b7Pve7h5eApr+OPdF5NM50FV0tJfeCBaeVcXjIMOdcwy/z7nWBeRoZ/R0ARmYQeC4gu0FEpXEl72V8/VROWCMfRBCYQ9brxrmUcuPdl6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:56:47.4945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7232e0-a3bd-476a-485e-08df0debb2a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=Michael.Roth@amd.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When using in-place conversion, there is no need to discard memory after
conversion because the same memory will continue to be used after the
conversion to back the same GPA. Discarding it would only cause
unnecessary reallocation of memory after each conversion. Instead, only
enable it for non-in-place conversions.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ff07050935..b28c9fbd33 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3611,17 +3611,19 @@ static int kvm_post_convert_section(MemoryRegionSection *section, bool to_privat
         }
     }
 
-    if (to_private) {
-        if (rb->page_size != qemu_real_host_page_size()) {
-            /*
-             * shared memory is backed by hugetlb, which is supposed to be
-             * pre-allocated and doesn't need to be discarded
-             */
-            return 0;
+    if (!machine_require_guest_memfd_convert_in_place(current_machine)) {
+        if (to_private) {
+            if (rb->page_size != qemu_real_host_page_size()) {
+                /*
+                 * shared memory is backed by hugetlb, which is supposed to be
+                 * pre-allocated and doesn't need to be discarded
+                 */
+                return 0;
+            }
+            ret = ram_block_discard_shared_range(rb, offset, size);
+        } else {
+            ret = ram_block_discard_guest_memfd_range(rb, offset, size);
         }
-        ret = ram_block_discard_shared_range(rb, offset, size);
-    } else {
-        ret = ram_block_discard_guest_memfd_range(rb, offset, size);
     }
 
     return ret;
-- 
2.43.0


