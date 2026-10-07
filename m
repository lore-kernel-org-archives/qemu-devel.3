Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210D5CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xERxG-0005Yx-Qx; Wed, 07 Oct 2026 09:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERwa-0005XR-CV
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:44:32 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERwV-0003Zx-Nc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWJyorRjodP3teolZk45NhcdjDhmYOuCgfndMSWt0ni2PRiMVJrRENwdhgWh+h1Nbd4iXTWMT80kgkKJfdPrs0fkIagEYnT7y//kvIoy+NSNkrLpXY/S1UDUZhez148Wa9Sh77x7PbxQzW0px46LTSSD36+2BOAl1rpyI1cwP10ZXkWmnfY/P5VWnKyFQ2u+orsI69GEv2/uTwHYEZkG9O5JsBSIu2B0bzvtITlHtDLKPLYIioRXjyCzOvKZjtzA1YOYCATvVai5y6cnnL0xx/I/Kl+LvmlAIEm28A9k1aTq8ITPqO0V/eiTDXAKr00qGjpNU+ys48N6Hv8WNOQ4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K5b+au/VVkoKHroFGCgTNT6skp3J34/XiCuG7wL8Hs=;
 b=ng95/XsAp/mGI7/47Ki2Hmnd3s0CUqlzHcAmPuAyT2ZaKfKn38zlOMrSVg2jSyV+IZIjbx/UkraYafsU7vdIJqjgpAE9BGrYUqA8jkHYtfTXnt124tr50crGH5uF2uXYR9EdlAqLC6o9Gy35QLe3X0OXL6y0mkIWVdy7aiwLCdvm82Ug0LlbyeceQ3tTsllE0lS8BNmudqKtvqscuEiZ9Lud85LqUqvlwvZsbdTWwaU1YivL5T1oEGj7EMy7IKYC2EFC35VBKBs9YwkIQl/RnB3Ev5FUx6R5hLrwkw1+Otdn9WvQkNnLBzF1H1RSIn6Hd/+8JoshcJk7AtK7fH1stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9K5b+au/VVkoKHroFGCgTNT6skp3J34/XiCuG7wL8Hs=;
 b=cZROhLrXACnnLbVRA7Tx3HsQhGeobnPR3bgTPVVDP+RNDKbK3zB9HEosJ+ZP7WbDNDxYW7GFcvTFVDMYXFeLWH86iNfW3U9CZ6oWUhC8E/NqJ/Xd2wI0wmtsR7FBjGthuSojajwBU/J7Av7KBP7DKmMPQvoEhMaBR5m13SrXQig=
Received: from YT3PR01CA0142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::24)
 by CH1PR12MB9718.namprd12.prod.outlook.com (2603:10b6:610:2b2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:44:14 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:b01:83:cafe::81) by YT3PR01CA0142.outlook.office365.com
 (2603:10b6:b01:83::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:44:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:44:14 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:44:06 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 10/19] system/memory: Default to guest_memfd for RAM for
 in-place conversion
Date: Wed, 7 Oct 2026 08:41:34 -0500
Message-ID: <20261007134323.1606088-11-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|CH1PR12MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a30e544-2045-49d9-907a-08df2479134d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|7416014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IA3ru05ElPhKkwoMWTXanNgFi9bkVlgBkx9oCa5kcsYLBk8ZE1Gl6WpEb24BNEqdjDDV/LiNYFAZ+CiAnz5F3Tmus/GVQCj6LqdxSQbITY6hbwQ1tu4GFKVZ/tJ2hGq94FPTjSgyYvFU/sHc74njz42ttZLzh2Ewu/9I7zv9tyHOmoSiC7YabbY/le9LgLVTeSCEw35qvPQflmS0+taXnENB8MCpZtycil6UiuPS7RzG9rP/iIaWrnUMLnL6VLhNQoxwHwFknktDVf19JVdY16CjHk2Y7vq5V+qy5s/P2SVukDxm7ZZMeNKHCK2vBvJESeqPUN2fZKV++6N1mjzHZhd3dIZ3QNGQ2cDFYjNAcjtIyllpTUA9knq0GdKR9/TjTpNMxOVGBx7/ZbCI1hJmVUfh6U+M/ghB/Go8IykZS7PV0lugI2AkE8M4fgD9nksJT7msZI6CRioRDUYtpq3qbu3Y3dmBoj3C6mwim2iJE/1Z/1k4Alqk9IvEiOq0y9y4e/8NuLBlurGiDxqoLIcRekh0TKULRBhDUMman6rWAFmzJpUXJX0u+K688UIcAASu8GbP4zQu9BrW62gdJxIgvDTUxkwHW4aO3CRm422MH5SzgUT/pYpqv+C4+6jEBuXyaUDHkB7g0dfks7ahTf/5K0jqMi0OoD0docMhEWqkyRDszWl0Pcb2dmoNm3AZxpksobkrUEcjiSRQIg1BfnqqOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1nLTJTU/Gn8vMZpL2ZNj9gQQ6BJd1b/lDl2GWFl0D7brROmr5bhACxPXsgWW8mg0lbN0GZx5LIpUCsbnraQ+5Cb+4YBEpu5mnA2zPo7ZCTQcW/YD+3XrEOL79LsfoL558UiEExxwKOdCZo9ePVRsMxhBqF/WsjwB8ke+x/SW6Su6yOMpcJTVy83CKd/FMJKMN+f+Yick598DEOJGah3VTDa3061TOYlu/g1J8ZI7PSX+xgVJIQDjTRfeu2LB/rHhCUDqaN0TS4gQ8Z+Girz9szC+zKM6e3a5EamnsUbopk9+raUSpUWEGzZcncYnDu8MJKS/AbfWWdhvHK8cEj3cvCY8vEoKbBEyCn4hL+KAWZL09sp2xPEa5ihdmOHuulJ5fqSjFfUyfKXUzzDRoieVkkrpbvm97QMv8vi/nvBpMmr5swVmyVdjG8OlxukAExxN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:44:14.2932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a30e544-2045-49d9-907a-08df2479134d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9718
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Michael.Roth@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

memory_region_init_ram_guest_memfd_private() is called in some cases
(legacy BIOS regions / IGVM regions) to allocate a new RAM region with a
guest_memfd FD under the covers to handle private memory since the GPA
range can be converted between shared/private guest RAM.

When in-place conversion is enabled, the conversions happen with the
guest_memfd inode itself, so the same inode must be used for both shared
and private memory. Handle this accordingly when convert-in-place=true.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 system/memory.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index f1910af8a0..4d302fb55b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3598,10 +3598,27 @@ bool memory_region_init_ram_guest_memfd_private(MemoryRegion *mr,
                                                 uint64_t size,
                                                 Error **errp)
 {
-    if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
-                                                RAM_GUEST_MEMFD_PRIVATE, errp)) {
-        return false;
+    if (machine_require_guest_memfd_convert_in_place(current_machine)) {
+        int fd = kvm_create_guest_memfd(size, errp);
+        if (fd < 0) {
+            return false;
+        }
+
+        if (!memory_region_init_ram_from_fd(mr, owner, name, size,
+                                            RAM_SHARED |
+                                            RAM_GUEST_MEMFD_PRIVATE |
+                                            RAM_GUEST_MEMFD_SHAREABLE,
+                                            fd, 0, errp)) {
+            close(fd);
+            return false;
+        }
+    } else {
+        if (!memory_region_init_ram_flags_nomigrate(mr, owner, name, size,
+                                                    RAM_GUEST_MEMFD_PRIVATE, errp)) {
+            return false;
+        }
     }
+
     memory_region_register_ram(mr, owner);
     return true;
 }
-- 
2.43.0


