Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F65C98325
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vE0-0007PP-PB; Thu, 24 Sep 2026 21:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vDk-0007Ew-E0
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:59:29 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vDg-0006QF-KH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:59:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsGPBoUk0Zi+6nagpjpahol78VUWXwayn+LVESCgOKmFS4jWElS+rZXRVFqPrUnE/pEYRuTfztDSgPOau9mC9e16F218MdSejzYIOoAJDmBLfZuB1dudPcCk6ql8PUBpdUGkjgNTNwimKDw2EwqFVcieoeVogJY9F7UMikVG5e69/pjWV+ZsbDtS60gGEhtXBQUfqMD/G92IjplEHj+9eQKwcupIxT0ngCWg64B6Ch3TWhhENqL7SUS+Y38r/3Iq0Yg8S5PBydfPfd31Enve4o9dPIQx6d2655j8MTXUOIZnmslE8K+5OIQzbil+JkbA5EPsJKnOjfhngQEETblotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiW2Gcdvbz4xxi4IG4aivzAZoLzzbo8XeKClAc2yeiw=;
 b=eOo+hz6DKt1dOcixNhjEyUGhn5xWesfCewES7NauAa1D3PaaReGTz4NMw329GtAJMLfEzlGoAc5J/M35rmBthQlb33CGH8iaTfLd3Oy9hpwZqP6cRAczAp2lwg1BRI1sW6JlVZ3jZwIz002hFd98LE3fz2/hFBQ3q0oElGN/cooKCnfKCnXZM+G4chMhSio1yW+LQnZJAVaGxOA0uS6UfYq91FySfcg1cSzmO+0ydMhn3XXgst+c2ABmRu4n1nCUMJ3CqTwPi8vUhqTw/tDNez3n7498YTURvktWdcA1Wcxmc0HFY5sXKCo5Qqeqh+y3hNjurRhrWzDbFHZEH843Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiW2Gcdvbz4xxi4IG4aivzAZoLzzbo8XeKClAc2yeiw=;
 b=St4abpqOpG2sR2uL3CD4jC4T/XUfCpO3Mpe7npkLNirQVRHajqY0DnpPAlL4k11LNAI4uCT410kJKKqWyRHsVGl11nYl2dU/rjxa1ZW1CmLPu6oFPa5REchO/QC3F66Xv1cUdEBF449h8/HTYaA0bKOmiXin0VHEGjoi4o+zdIA=
Received: from SJ0PR03CA0345.namprd03.prod.outlook.com (2603:10b6:a03:39c::20)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 01:59:20 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::8e) by SJ0PR03CA0345.outlook.office365.com
 (2603:10b6:a03:39c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 01:59:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 01:59:19 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 20:59:15 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v6 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Date: Thu, 24 Sep 2026 20:43:07 -0500
Message-ID: <20260925015700.1260501-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925015700.1260501-1-michael.roth@amd.com>
References: <20260925015700.1260501-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fba6fec-65fe-404a-0922-08df1aa89cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2sLmtXVV8UVvq1s1Ku2XeezEkNX60BOvH1gHxajfTW/tOO88/phNsMV3GflgdJZz1FUPPEQLx4aBs32Pt3nTT1+Elk8c9TE6WgGPt5W273oIljQCaGTftrZq+LX/h7EEULsI5nsggCKssbjqYtTR50lbzFOqFfhOvtFzimdWdEnZc004zT18KSTvJTlZHNGP+kXarsR2luyRM+QoAIjSvDv8EdhHkuu/ylxEuQTCuRYIyhr21FSpFa+Os3PDKL8H7FC+yYsFq70KgprEV2TtwAopgjFbKss1sysAMB96JIVwD3BbA2tvEamcATJqmKlAPeSvIbWsNcIV2rizECEWC1QZqn2SN+eJwqQSPV/Wpk6jvsTj4pAQEFrYmUwpNwiIraemdHg8ZAfe3IycVKvi0Ajm3A+bb1FR4CW1tAwCyShgz9na/yBIhrb2dNzXCshbccjiEB2F0G7Sx6+ugocawrmcOtXKbhIFbXKvwXeCY5qW3lsYnKQbX2bNuy1sW5AiVgs9a6hwbzdYj1MLB3MXj3l9Pe6+6bLiZWrBJ/3tZwfxf069HYvzpzY7PtBNjRbeng4YMNLKJ0ww0WR0eaGjkcBaxvbENlSY5S88a7Sz+IxFDxC0CLilrNGX434fZ9Mv3id7/t30SI94o89xC6bp0BTPgx1dh+cB1MF1pVCqkQAaYzu6/Ddnlcy/3yZk2ibUSZi1v3OIwIMHcwaNZHZNhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ULg3U+V1JM5chxW32mbZ1XDPBJEV4IkwwTLB8hnJIArbGBIvzgKPw4A7dgO9j3Oy1vjP6RIKLGOGZnV15vKmEMbSTgC14jUpZLm4T3KgzJCJgOQsIJe9NEOiuPHTSjHli1jzyjbTAmxHJvV/nzJqfhiLAO8UYYw2HloRIputlyIjB8CL4QYKZQ3QiKQYKcadRs1dYN/vjxk2p3XSlsl6xexpkEJS+wpeHp3QJt3r8MdcNE9LbtUPyY5pbAlarCHqWInZVtL2B5zmYB60/bF22iriJ+W0RnQiFGYAxx7pr92rbkanHbndHIqJohQX0Fd9ZuUQmxZ3YJqb/B35i37cMI4K+bEd5LzShpFVVVDd/nN9Oe/stA+fGrpOy4DRO/Nux82Fr40XT0M0wQv8IdLbeKlPOk+czr0/r/9+g1WRlppnXlEVJHzD79ftb82aPzTt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 01:59:19.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fba6fec-65fe-404a-0922-08df1aa89cae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Michael.Roth@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

With the mmap support of guest memfd, KVM allows userspace to create
guest memfd serving as normal non-private memory for X86 DEFAULT VM.
However, KVM doesn't support private memory attribute for X86 DEFAULT
VM.

Make kvm_guest_memfd_supported not rely on KVM_MEMORY_ATTRIBUTE_PRIVATE
and check KVM_MEMORY_ATTRIBUTE_PRIVATE separately when the machine
requires guest_memfd to serve as private memory.

This allows QEMU to create guest memfd with mmap to serve as the memory
backend for X86 DEFAULT VM.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 8 ++++++--
 accel/stubs/kvm-stub.c | 5 +++++
 include/system/kvm.h   | 1 +
 system/physmem.c       | 9 +++++++++
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a8..cdc7554082 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1627,6 +1627,11 @@ int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size)
     return kvm_set_memory_attributes(start, size, 0);
 }
 
+bool kvm_private_memory_attribute_supported(void)
+{
+    return !!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
 /* Called with KVMMemoryListener.slots_lock held */
 static void kvm_set_phys_mem(KVMMemoryListener *kml,
                              MemoryRegionSection *section, bool add)
@@ -3058,8 +3063,7 @@ static int kvm_init(AccelState *as, MachineState *ms)
     kvm_supported_memory_attributes = kvm_vm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
     kvm_guest_memfd_supported =
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
-        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2) &&
-        (kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE);
+        kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 32b4b07403..3d34e3b99d 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -143,3 +143,8 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
     return -ENOSYS;
 }
+
+bool kvm_private_memory_attribute_supported(void)
+{
+    return false;
+}
diff --git a/include/system/kvm.h b/include/system/kvm.h
index 714b8c7b01..d29624034c 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -551,6 +551,7 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp);
 
 int kvm_set_memory_attributes_private(hwaddr start, uint64_t size);
 int kvm_set_memory_attributes_shared(hwaddr start, uint64_t size);
+bool kvm_private_memory_attribute_supported(void);
 
 int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private);
 
diff --git a/system/physmem.c b/system/physmem.c
index bd5f41cb02..1b3f327ed5 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2192,6 +2192,15 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
+
+        if (!kvm_private_memory_attribute_supported()) {
+            error_setg(errp, "cannot set up private guest memory for %s: "
+                       "KVM does not support private memory attribute",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            qemu_mutex_unlock_ramlist();
+            goto out_free;
+        }
+
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_coordinated_discard_require(true);
-- 
2.43.0


