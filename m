Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF977CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESCB-0001BQ-LP; Wed, 07 Oct 2026 10:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xES1M-0006Sb-Nj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:49:33 -0400
Received: from mail-westcentralusazon11013061.outbound.protection.outlook.com
 ([40.93.201.61] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xES1A-00041v-FK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:49:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKNEyMkJZTppOBC4IQLSlpRQOR/7U019pOsmAX4rvxVCJfKEzwQjoInJjBdSDTiC0aO5BOoMbYF+B2pDESlgn93JSLquKCl2Q4WZtcD9471JV8v/Ms5/YEv73jN01gnpz7PDdmoJktfiuF91AkvDyfc1WBF6Vnkpq2X4eQRKfnk6tPDut4+1fLc0LGYfv2RjQf3yQ+RAKpKgHRi3H7vDg/V0yHuKYOkqX82mjxba0Uc574AOD7rf0Z2KzQtgUtEcbX+OJKzoRIwKO+2c+4kuqLVYXDdsQJZG5NiK1h94+Etij7tY3A07lCPtCyAruQ8B/mqgbSOxEQb9SLIk4eg4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scaGR2rhnkwk3tH8oZYS4Q9kgBWjg9/XG+5wa3XbDVE=;
 b=NaFSU0xCI5uPXrhHl+pWREfWwt/I/SwTxFGHENWZ11oGtx2QovQ08wd+2Jpn3L+2mwkONjoSycNPgUuqiFfRGNypNZbrYQ95nHnQQGtFIzuK6yTuLkRiWlM/kTlnzqYSiaO2nwMCMOUiJmkP3V0Dqve4WnblI6sdhvxRfi99UOBqHygVxvz52vAYlWMRsbkpd6b0d/VpVe1zz8KyExFGkCIhq5o8v69QOyZkN3n8JvIWq2VhM9o0g8XUKztSlO9ZV0014L9JYMzI2nRfuco2wOd2rrV7mclV7z4+67eIk6rXmN06CJgtFQytz9xDjCxUNN9a+SaiviVK0CN4Fpxe3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scaGR2rhnkwk3tH8oZYS4Q9kgBWjg9/XG+5wa3XbDVE=;
 b=N9Vk2bjb3I4jAuUTBjzkYftG8dzp3+KjqRRaIp6GWrkYVk16ouvNLH2es7Pjqz19vAr08jD9QjudTorrgmbtEVxHS1+WYyW3LpcSGfuazdtu38LSlSpiy/0D0+Dp47CbNx23DP6aZJvJZ7/asbb8q2HpkP9OKi8u8PucviiUiks=
Received: from BN9PR03CA0905.namprd03.prod.outlook.com (2603:10b6:408:107::10)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 13:43:49 +0000
Received: from IA0PEPF0000003D.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::79) by BN9PR03CA0905.outlook.office365.com
 (2603:10b6:408:107::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:43:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003D.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:43:46 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:43:45 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 09/19] accel/kvm: Handle guest_memfd flags internally when
 creating instances
Date: Wed, 7 Oct 2026 08:41:33 -0500
Message-ID: <20261007134323.1606088-10-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003D:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: a76f6379-9cde-4b70-bd93-08df247902f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|7416014|376014|36860700016|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 7aocnHFjSvNCATbVXVKdsW03BMH3CEfZwzvpXwJan89AZLU7aLOmaJ+I8OC4uafAMsmUUM3/faNQdZfYL4x8kULpWcU+UC15dMe/wa1c+9AnaKdk2CsufV5nBjf39U+qLhewzGVkiIFiQN28nJ2j9xHuLICnoG2ZcTDHdnMXTRi5HyAmUtGNx2arEf+j81W8LLtBtTDBp1MNjxUtFKSuclPiqmCGdcWJqbiKDX0BCs9gpx1ZXEvOVRWJZFFXgAyqtCPuWELNznS7S9pwr1YOhBHwAkN4XjbBmZ1rI9XExWtPZn1SMjh6+tA3Am0uYYoecv5Dblu5OPo9c71XeRdYkJeQ0DmtVInIrQeJRZ9YGVMJdz/oh8iTcGXg9DIVCrq8ihMCUSgJzFbTiB0RRkkNTglh9iS7shOSM/t/EMSndgJfpeGLnyZ7MI6bJfQys1xmsUKovOW8t/BefUy/oi0aFmxzIH0OUoMrbweOyjeOh+FF/rZonCa2KOfWTh4KU55i9gwnRRDT8/Co/iTyN3jmtdxi72dykrRqjBHQ7XZzpbT1K03l8/DVViLtXxQiGl9XcAf9KPwbVRejxDjY/qPtABrL+IHBUMsS6dlyyV6cuITMYRKZW2bP6FaUMe7tOGhX3FflgnHrLpdjSy1Mm+5o6ifil6KNMT5xWvD5HboO+buF6Z9pDnHQ0uXx+gHybNDsFhk6S7DqZjV6r7U8w1p2EQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(7416014)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B2rKC0vguG9zGuViTo9RdkMRhi7F8mq4WRy/OT3J911JqGhvsbpIYNSU4Rr9pTVTA48eEoUsSVpbEzT7lTslUOL3sR3Nun459BQ+S8/Fi0znP4xqLrdzZAj2GNg21oakL3XPALs7XDPmjcMxq6VsW/TuY4xoOH4IoLnkZJbCveZg6/pHwcCIcLtWb8ZPGPPKqq2tI4RZXZ3y2RDEluIP/eFl6zSEUWFOhKmGwSHUd7LtNkWmviH53XBSvitMzvW2laUbd+GrK07QrTHz9gl5GakwL7/UTfc3ASPdXQX+6AVCfuNp2Q0fpZn7yZMqP23/FkiuCg126ErS9ZlI+nJODY3Fgy+O+cNAxcHvHaL7PSMf8GiKf8gtS7jPaQGbi0mVhqYetgiBH1Ldn8H+aRAKDUHNQ0gtZQD5f+KNTdx1acLTjM1IhBxMhKnrm4+xhkyJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:43:46.7464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76f6379-9cde-4b70-bd93-08df247902f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
Received-SPF: permerror client-ip=40.93.201.61;
 envelope-from=Michael.Roth@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Current hostmem code (which is callable even outside of KVM) specifies
guest_memfd flags directly, which requires pulling in kernel headers.
Additionally, it will eventually require additional knowledge that is
more suitable for KVM-aware code (e.g. whether or not to default to
private memory for confidential VMs).

Instead, push the determination for what flags are needed down into the
KVM/guest_memfd code so they can be handled internally based on VM
type/configuration and avoid further potential leakage of KVM-specific
code to general code.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c      | 26 ++++++++++++++++++++++++--
 accel/stubs/kvm-stub.c   |  2 +-
 backends/hostmem-memfd.c |  5 +----
 include/system/kvm.h     |  2 +-
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 862539aed4..8cd1671ad5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4857,7 +4857,8 @@ void kvm_mark_guest_state_protected(void)
     kvm_state->guest_state_protected = true;
 }
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+static int kvm_create_guest_memfd_flags(uint64_t size, uint64_t flags,
+                                        Error **errp)
 {
     int fd;
     struct kvm_create_guest_memfd guest_memfd = {
@@ -4897,6 +4898,27 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
     return fd;
 }
 
+int kvm_create_guest_memfd(uint64_t size, Error **errp)
+{
+    /*
+     * There isn't currently any use for non-mmap()'able gmem instances
+     * outside of kvm_create_guest_memfd_private(), so hardcode it here
+     * for general use.
+     *
+     * Additionally, *_INIT_SHARED is needed for non-confidential VMs, and
+     * confidential VMs will default to this as well to allow similar flows
+     * for initializing the VM's initial memory contents as with normal
+     * guests. In the future, the initial state may become a global policy
+     * decision based on the confidential VM configuration, in which case
+     * this would likely be the right place to decide whether or not to set
+     * the flag since it would likely be a globally-configured option.
+     */
+    return kvm_create_guest_memfd_flags(size,
+                                        GUEST_MEMFD_FLAG_MMAP |
+                                        GUEST_MEMFD_FLAG_INIT_SHARED,
+                                        errp);
+}
+
 int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
 {
     if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
@@ -4904,5 +4926,5 @@ int kvm_create_guest_memfd_private(uint64_t size, Error **errp)
         return -1;
     }
 
-    return kvm_create_guest_memfd(size, 0, errp);
+    return kvm_create_guest_memfd_flags(size, 0, errp);
 }
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 9fe58efe91..26003b01a3 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -139,7 +139,7 @@ bool kvm_hwpoisoned_mem(void)
     return false;
 }
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
+int kvm_create_guest_memfd(uint64_t size, Error **errp)
 {
     error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index c1ea6eefbd..d3b17232f0 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -70,10 +70,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
             return false;
         }
 
-        fd = kvm_create_guest_memfd(backend->size,
-                                    GUEST_MEMFD_FLAG_MMAP |
-                                    GUEST_MEMFD_FLAG_INIT_SHARED,
-                                    errp);
+        fd = kvm_create_guest_memfd(backend->size, errp);
     } else {
         fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                                m->hugetlb, m->hugetlbsize, m->seal ?
diff --git a/include/system/kvm.h b/include/system/kvm.h
index b1e43ddc93..2a1501bba6 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -547,7 +547,7 @@ void kvm_mark_guest_state_protected(void);
  */
 bool kvm_hwpoisoned_mem(void);
 
-int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
+int kvm_create_guest_memfd(uint64_t size, Error **errp);
 int kvm_create_guest_memfd_private(uint64_t size, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
-- 
2.43.0


