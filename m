Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23872C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf62e-00050N-Hz; Tue, 27 Feb 2024 17:35:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62c-0004zt-HW
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:14 -0500
Received: from mail-co1nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2416::600]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62Z-0002Zj-RN
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma1XM4V0driY+zgOvBwiplwPAu/vSBfYhK+v3V5e4VKPLyqxQ6xoZRlMfexbwSoqSirO0LSDMsgTJWWF8H2Dr90gqyMWUUCAGKduXLKtrmIL8ZiAAs8oe5IRyC84o27/veaMrhB8A0Nj8p0VBbWLJArKNHx/0nnh8nDx+L5Zfg5RNc6w/XlQixTqkSE1BzrMVNBbKjPwdC8KKSk9cb6tA29Hilw+iLivbu0XyAzSFqPT1KE+B+y31tfs2DwOtDd/Cwqx/CgL1hS/rUiZtmF3xdSKzOgRmH7Ftj+qxIAQTqcSsugTmS78qOnaNb1Vgjuphu55ZFBJKFr2GdNSr+BCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDrI3N58J7SFiy9JJ9en+2EcReLLK7/jTUf6/gRoIlg=;
 b=O3o3Bfa3cBV1Q+LgFK0eFoM6KvkonQx9Zl2zEf4HCQcbE6Df6WxNRGwsR3vgZ4zrCSIymJU2xusQlyBvMpiuZMCdZxDB61/u6q4ZTDsTJG8hdNqa2io97gIFDnhf70oDEIb9Bg5tmk+owUEhiJSpz0Q0F/ZCQ9qVPb9RjVJ2yDsoiqqwpZWhjV36Q247+cew5Zb6sO4YeDfpZYbXq6M+Pr9gIPxgYKVxwC4vLcfGcljqE/Gm/1Z97qmIqawwOd397xjpeu/Q9qYXjS+7gbu3zjqG8sXu6qcK3TsQeRkL8YOja94m8hEkFYQvc0kTxKrHVVmQJy1o3ELnWZ3+itcNtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDrI3N58J7SFiy9JJ9en+2EcReLLK7/jTUf6/gRoIlg=;
 b=LnNBBrZ4cVVej34kt8ZXcDuU7UyT22IS2o4p6LXiX/BVPOzmFkC+qPtwzdp1YjG96G/z4jimSzE+vDPE4LF0tW5Wg3+M9Ydi+G/smxMgwt1pqEpydpfd4c2gnukc2jYm7uAV0YO9qyLfnv6X7963LoLhphL97WbrE5RN6bJrGII=
Received: from BN0PR04CA0162.namprd04.prod.outlook.com (2603:10b6:408:eb::17)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 22:35:07 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::64) by BN0PR04CA0162.outlook.office365.com
 (2603:10b6:408:eb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.50 via Frontend
 Transport; Tue, 27 Feb 2024 22:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 22:35:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 16:35:06 -0600
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 16:35:06 -0600
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, "David
 Hildenbrand" <david@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [QEMU][PATCH v3 1/7] softmmu: physmem: Split ram_block_add()
Date: Tue, 27 Feb 2024 14:34:55 -0800
Message-ID: <20240227223501.28475-2-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227223501.28475-1-vikram.garhwal@amd.com>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vikram.garhwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|DM4PR12MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: b44d4d1a-7a5c-4c58-692d-08dc37e45996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Jnnd64S77UGOIsCLWvrKQ02zHtEOsLrfbdPjj5ku65IBmp6dJkltrifOuMCav8R2L9m/YFYiosJ6lFnVyby/ATF1d9UtqbEa+2/CPanvWtL5UguH7QGHXGPHO4N6ggk9ghM2Q5FvIoYNtj/aUuerOqM2TzRv8BZGujPjNqOX8i5q6sJV2BmBaO0EL8zOeOkkvXyC3hrQIsU6ku2uRkdR7yr0SjPIcYYOgbT9gEyghbQiZ0g4KUoMq71vY2TsuXx8rIvS8ZVJHF0RJ9JRN11lfMJxLrpGzqft1XNy4joKw6t0niREWuk5Q2boGDh3L5fK3ufW5hi3JN7dK7a3zgj4gjF8V7cRbVYk2F344XuZnTvxJZJpvsMDwFNgrK4Qijyzc7lsx5Xx2xE5C7AGokWRVmWpcBu2YUmjd3VHv/NPCBBKg17UP6zRLy5WKay0Sv1ODkviDifh8V6ywkUltEoaOgXBZ9LXbkX+G68lSnMPeKa9nLrau/CwUM/4HcJ0ODNjazzY5eJ3a3b735Unc3SXy0tPym72NRb3Kt8Wb6ygg73r1FAdJp5vFlmD7h/7WcW8WAC9ikorRMBGJmrcR+h0EtZyI9Dws+trwOBL0nuxXyGery8QN1lzKor6A6FmB/8XdBYJItJdU9yc4RmuAtXXhsAvjOPfLHernloerS999DCpTyEGlpPVaET85uGppF2njAiAq3eFoqXeKxd+P3J43DZ+0LGE68CRmYXQIRv5bRNQZXcQTy0X39XTQHaBtz/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:35:07.4399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44d4d1a-7a5c-4c58-692d-08dc37e45996
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
Received-SPF: softfail client-ip=2a01:111:f403:2416::600;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Extract ram block list update to a new function ram_block_add_list(). This is
done to support grant mappings which adds a memory region for granted memory and
updates the ram_block list.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 include/exec/ram_addr.h |  1 +
 system/physmem.c        | 62 ++++++++++++++++++++++++++---------------
 2 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 90676093f5..c0b5f9a7d0 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -139,6 +139,7 @@ void qemu_ram_free(RAMBlock *block);
 int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
 
 void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
+void ram_block_add_list(RAMBlock *new_block);
 
 /* Clear whole block of mem */
 static inline void qemu_ram_block_writeback(RAMBlock *block)
diff --git a/system/physmem.c b/system/physmem.c
index e3ebc19eef..84f3022099 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1803,12 +1803,47 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
     }
 }
 
+static void ram_block_add_list_locked(RAMBlock *new_block)
+ {
+     RAMBlock *block;
+     RAMBlock *last_block = NULL;
+
+    /*
+     * Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
+     * QLIST (which has an RCU-friendly variant) does not have insertion at
+     * tail, so save the last element in last_block.
+     */
+    RAMBLOCK_FOREACH(block) {
+        last_block = block;
+        if (block->max_length < new_block->max_length) {
+            break;
+        }
+    }
+    if (block) {
+        QLIST_INSERT_BEFORE_RCU(block, new_block, next);
+    } else if (last_block) {
+        QLIST_INSERT_AFTER_RCU(last_block, new_block, next);
+    } else { /* list is empty */
+        QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
+    }
+    ram_list.mru_block = NULL;
+
+    /* Write list before version */
+    smp_wmb();
+    ram_list.version++;
+}
+
+void ram_block_add_list(RAMBlock *new_block)
+{
+    qemu_mutex_lock_ramlist();
+    ram_block_add_list_locked(new_block);
+    qemu_mutex_unlock_ramlist();
+}
+
 static void ram_block_add(RAMBlock *new_block, Error **errp)
 {
     const bool noreserve = qemu_ram_is_noreserve(new_block);
     const bool shared = qemu_ram_is_shared(new_block);
-    RAMBlock *block;
-    RAMBlock *last_block = NULL;
     ram_addr_t old_ram_size, new_ram_size;
     Error *err = NULL;
 
@@ -1846,28 +1881,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     if (new_ram_size > old_ram_size) {
         dirty_memory_extend(old_ram_size, new_ram_size);
     }
-    /* Keep the list sorted from biggest to smallest block.  Unlike QTAILQ,
-     * QLIST (which has an RCU-friendly variant) does not have insertion at
-     * tail, so save the last element in last_block.
-     */
-    RAMBLOCK_FOREACH(block) {
-        last_block = block;
-        if (block->max_length < new_block->max_length) {
-            break;
-        }
-    }
-    if (block) {
-        QLIST_INSERT_BEFORE_RCU(block, new_block, next);
-    } else if (last_block) {
-        QLIST_INSERT_AFTER_RCU(last_block, new_block, next);
-    } else { /* list is empty */
-        QLIST_INSERT_HEAD_RCU(&ram_list.blocks, new_block, next);
-    }
-    ram_list.mru_block = NULL;
 
-    /* Write list before version */
-    smp_wmb();
-    ram_list.version++;
+    ram_block_add_list_locked(new_block);
+
     qemu_mutex_unlock_ramlist();
 
     cpu_physical_memory_set_dirty_range(new_block->offset,
-- 
2.17.1


