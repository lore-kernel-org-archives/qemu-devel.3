Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45DDC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrWg-0004oo-K3; Wed, 20 Mar 2024 04:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrWe-0004bq-Sy
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:42:20 -0400
Received: from mail-dm6nam10on2061a.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61a]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrWc-0007ah-So
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs7bFV8hc6uuicIA7e8/OGoqoUHwGGsU6cxkabjS5OdhOzqywtZsnCaD0mKlgl16LzpNl2MxEh0v9wJ/Q1o8d1Vzf3dU6+s7NI2iZbsi++uE6oDW6aQnq93IrSJB5ww1DBJlnwv5nqIPE2USt/TwD28anHUmvvQ/ngGvQuGUZdjIBbTcTndFlg77ZbUhAk+alNJhDrSlpGYHvkPpNtLH0/Q8moGthgh+FE+3CkL2NMM9T9a2LVxNlzNppDoB61MQ8Uyems+JU3WsaN5uhsitjwe3eRY2yzIe2y9kglJdmOwiqxP3oEQfwVZKqh7s3K3JgtnnjmIVWzKACxBp7+XNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb5xn8wWzGmLkl9z1YSLuY3GvBtE0Frzq/FHmDOAUrA=;
 b=nXRI0sXwF21y1p0k6SvYsR3j+9+sUeahoMcFZQ+1qejxDiF1UjpDMHLlK9Z3Qdz5pTNXTFrUfvNy0wgUS0zaR0ie3W6U95QdfydYIVAlNr4nISjC3a+bl34ht2PQWy0alk4DCSB08tHPrAFeA0iuK6uiywGNx07QIVTkfCvUwzMUb2Ziq7hnLbEyHaI5M9hQBDfxNa8WoaOcZnZJ74SDEXNiEYoU0k1+hbWLecFmTBvleECuXKye5+l7Cracl9bhS7hw8DtvxMsFPrgr2xoVuLZxsexLsxgK2jFkrNV6pKEz8Hn7ho9dmM7BuFtzH8ifwv5qNZLrTQZ1gzwaG2KHMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb5xn8wWzGmLkl9z1YSLuY3GvBtE0Frzq/FHmDOAUrA=;
 b=EF6CpeQ8gW0fMgC4FfjU2NE/ZWe9I+UWcvaRNAf/gDbE5blyCQRqV8OgVCZ5EOrmK9hd7ejVM0wFnOxhuO6Kh0/CJWOWl8abXgwCdz7/XnJ7rKLSEMxi+TyXaJOC6Dmrro7lemgwTvfcsKdNV4MMsDmOHTmi2NPzMHjmkcGYorc=
Received: from SA1PR02CA0013.namprd02.prod.outlook.com (2603:10b6:806:2cf::11)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 08:42:15 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::73) by SA1PR02CA0013.outlook.office365.com
 (2603:10b6:806:2cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 08:42:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:42:15 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:42:10 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 11/49] physmem: Introduce
 ram_block_discard_guest_memfd_range()
Date: Wed, 20 Mar 2024 03:39:07 -0500
Message-ID: <20240320083945.991426-12-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d58d843-0fe7-4a5b-a42c-08dc48b9a4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXd3BXwSVsKOooEJTZz2EmA76bwt3Yqb2YCWeK8kF4FexrdCVxGl90rEsMxBzxxDdT65AIbfraBgB2SzLEbX7K6N+0VdBNBGFB95NQYJLx9vwaes4v/K7cutnpZiLdKfTItNep9h7B7fohcJHwWI9R1oJH3BnztdJ864Bj8pzx6Q1EN544ipeh7vySRWQ+xhkqoMd2RdkQLF+zd+8SxdmwF1oYUx18p0qzTb8cc+kgXDhPVzdcbYMTPswLxoIsLW3QF/JcZW8dW/inuas9HzTloiiGaDIktUq5dTwkokStK1MSuUu6tvowp5Yp05FExHcp1YUjd2BsQh0PBAV3hUqFZ9eE57Y3jWSmuG/2TK1e/x1iTA9JLEEE7P6yySvLqDj2mut1faRbQpbQEew+35p4r4ftVCN/nkVkg9ksOpoeU6TixJ12ZnWLvL9pml+LAgT8x+fUkf9GpbiuFR6pZD/gEAkwbReIJk6pOhGUZSbrYX1UWYqsMYuqFEK5QMi5tsBptkRS9nv2UDas2oLsqvo2wCUMGSPhYbmjWfalWfENS+S4YBEezM7Yv2XK05YqI0s/1ZUCC/aCuusSFJ+FV1XRjNXKhUuYsua3/+znM8hmeVe7rOTTFkjTDf4KDguai1a4EILmIABQttW35PNqjV31KUh/XddvZvlLG/CVCUJA9jXxRJB3SeLz2UZyZMUcEbEXGsEEL4xkbg/TxXj76hObk6NTqUsxXJs6mpVt9gTlZQef2ZpftsdFBHO472PiGg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:42:15.1125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d58d843-0fe7-4a5b-a42c-08dc48b9a4dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
Received-SPF: permerror client-ip=2a01:111:f400:7e88::61a;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

When memory page is converted from private to shared, the original
private memory is back'ed by guest_memfd. Introduce
ram_block_discard_guest_memfd_range() for discarding memory in
guest_memfd.

Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
Changes in v5:
- Collect Reviewed-by from David;

Changes in in v4:
- Drop ram_block_convert_range() and open code its implementation in the
  next Patch.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 include/exec/cpu-common.h |  2 ++
 system/physmem.c          | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6346df17ce..6d5318895a 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -159,6 +159,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
 
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+                                        size_t length);
 
 #endif
 
diff --git a/system/physmem.c b/system/physmem.c
index 3a4a3f10d5..8be8053cf7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3705,6 +3705,29 @@ err:
     return ret;
 }
 
+int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
+                                        size_t length)
+{
+    int ret = -1;
+
+#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+                    start, length);
+
+    if (ret) {
+        ret = -errno;
+        error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
+                     __func__, rb->idstr, start, length, ret);
+    }
+#else
+    ret = -ENOSYS;
+    error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
+                 __func__, rb->idstr, start, length, ret);
+#endif
+
+    return ret;
+}
+
 bool ramblock_is_pmem(RAMBlock *rb)
 {
     return rb->flags & RAM_PMEM;
-- 
2.25.1


