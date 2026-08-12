Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD3EC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFTp-0001bK-IV; Wed, 12 Aug 2026 16:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFTm-0001T2-1V
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:23:14 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFTk-0007KJ-DY
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:23:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPy7G3kMN1U9lVxwIg3kJVvzOFbz9JorbD2z2MqHs1Two2ttiN7E0XOjSQ0gB7ZEEBxs4Pn+0zcFu/2vzc3qAZwBTog5CcNIUPSyETTprQTh77lGT15EZgbZvILnK68KDzJPuhl4MKgiysSt8VIhMFeewrWZOyHOEiCGbnNjjB46IJp1fZIIyEvM1dgO2SYW7iRk4ugl5vqo9r5oaPjSgC5RGv3vKFByxCzn0Bx6Vxk/pYbVCbr2r/qRiUhfx2Box/v1ks//gKooi+tXZcgNeDY3hEmscvqHid5Xcxn2M6SoDgeH/Hhto2ND+mj7EfkoH30I5b9nbA4DvuHyXt6XUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMAQLdR4S0qexBe221Ejud4O0iSt1b8JnENnEYkTSj8=;
 b=fEn+anGOLeZpdUZ3Pzi5VBHazozZyZD2cEvraLoRiAU01Pn0Joh0ikT7rWJ1aRuXvZ5Ei/DMhDetwCHJGQmQJ03oDTo04GSvw5OZW7r8RI+T/O1aF2u734OJq5vSjoJrSU7afgcgldJxuoz/VZoYfjXNIiaubrWQma7Vke7QSFr6uh/sjOIwFWhOiuusC1BCf/wSlkitrHSLHUggSB5NY0i2xVWt0NBlAyQEP+7255VIiA+7htlETAJOrtC+JowDAN31PG5CKRgr4NNSQhSZHiS10EvbO+tOFZkt8riTp2mbG8JN0r/Wb/oVWxpqkkJ5RaRySyACupgKUeKsiwDUbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMAQLdR4S0qexBe221Ejud4O0iSt1b8JnENnEYkTSj8=;
 b=iVYT2ZnS/ollwrytpuCYa+A1YIXlTnv0J7MecTfGlas4+BvacowBKfzPjJeKqjljk8DJKDQ0MdRPtmBlGD3DEcrtV7auzXAKaONdaGV8oOe3VxrfZfPs912t809TlhC+b5qMMjvUwo7M7oQ2gyK49Qe/0VpJG+UtUhHcr5eo9Jk=
Received: from BY3PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:254::8)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 20:23:05 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::af) by BY3PR05CA0003.outlook.office365.com
 (2603:10b6:a03:254::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Wed, 12
 Aug 2026 20:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 20:23:05 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:23:04 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 01/12] kvm: Decouple memory attribute check from
 kvm_guest_memfd_supported
Date: Wed, 12 Aug 2026 15:16:39 -0500
Message-ID: <20260812201938.198915-2-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 8968c704-4a5b-466d-00a9-08def8af8413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: s3jG0oq0RWB20HQE+mV6NAZx1aMm4dXa5nuwtQuAQzGcjfiXOTmJeDTaGZNbd2lGNg0Zt8HSPdrd/yl7CjfhZFQKLDbSr8gLJ2hyCVGB9vOFRDvpm7RmNZov8UhmtlpEIEP0VPDZl6WvLVsPU3sxMlLjudd9NuMF47TrVrONvwF/r2zVgS0qUGLB2pm0v05mZN/NdN+ikLGBDSpFh2VCvPygL5yGdx1tIbOzMoBLSQWdoM8TlwtZagvvXtcPaQM5bI3iT8UtG40+bCOg65IiJORzduNDUk87ivpqeoerA1Z1UZZecya31nMnbMOzubPTdKmN4fqyRSV0ipqNJnRrTRDERVi1RVD0YNJJedIpP1C5uNEKU8Eym2HNMiRfdXcGtPc+xvUD2znzyrR8B/vvCZ0w3D0XiNxddYd4HfKz0995uq7uy9od43HmKe7Kaw+VGyuIkWFBMIRw+FKTmlH+nkqdA1jfSHfk/dwTv7Jelntw6Y+JxUduS5uKhuvXjXuCiCovllKbcqu/nghQSAaHpv3Wgeqi43mv1KNAs+gkFXcZ6yvpifxKdJUmQUolSDs0ZhtPvnFR29B5gM7k1UeIOa6IBC5lyJ6yw8DE5ny2uWCuF6SG593PzFcyvWMRUhD9lyOoKmx338E25y/bz7Bs1vnsLpNcUMZNK74+38zn5cmHMojKbjGRSmI13KqjcfeDNgRMw0IYKLUdZNWJVJeU6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tb9BjfXRRVaVF51idkudP3wHn2HHSRjhl5xkJQPfKD7MWFkRXPhjHsnapWWqIAItZlweP9sToxKPDwKr/Sb2NEBfL2b0LXpuKQwevShZ1YL13AbeqBrotYlN6JPJAinCDpIRCK7X2Zq5ljpMR/JXUhsaz/3Lqqr989CpBlUBUMI+GZ5UNruOCdWkKGDtaupEsZdhyajO3CqiDl3F1kwvrxiU4aLro6+0pcANRXEIbXx5TU33ZdXbqpRP4syhz7pQdN6tcEzvKFQRjqp+P6oudjA6ZCnIBYgbpuB4fztFDwn8TJLCfk+F251LX9r5kmPCVKloJdRfH51DvWULQq80JnRjUhJkAVhvJhLpVeEYu5rb60HqAz+B9nahp9mqFglqbLdvoX6cL1Qqc+Xe83PP7mtjkSi1nmlmYJNEbKGP6XpWvrPNdQSMZMTicqpF7uM+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:23:05.0629 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8968c704-4a5b-466d-00a9-08def8af8413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Michael.Roth@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 8 ++++++--
 accel/stubs/kvm-stub.c | 5 +++++
 include/system/kvm.h   | 1 +
 system/physmem.c       | 8 ++++++++
 4 files changed, 20 insertions(+), 2 deletions(-)

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
index c21ea92915..406338f165 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2192,6 +2192,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
                        object_get_typename(OBJECT(current_machine->cgs)));
             goto out_free;
         }
+
+        if (!kvm_private_memory_attribute_supported()) {
+            error_setg(errp, "cannot set up private guest memory for %s: "
+                       "KVM does not support private memory attribute",
+                       object_get_typename(OBJECT(current_machine->cgs)));
+            goto out_free;
+        }
+
         assert(new_block->guest_memfd < 0);
 
         ret = ram_block_coordinated_discard_require(true);
-- 
2.43.0


