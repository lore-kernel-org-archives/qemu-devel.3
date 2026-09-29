Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802E8CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhfY-0007Gz-FG; Tue, 29 Sep 2026 19:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhfR-00078y-Dk
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:55:25 -0400
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhfP-0007za-IM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:55:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6xiiUVPoB7PcSBvch5FOMzwMmkJvylVNrz8w4+CiA7i9DM8ZQ8pkDmm+tt6NfmdeJYUlbasaCSsm9hhcO8Sco+SX2wawRZFgtK46YTgSdNsBlmhfBHNhpjvrFp9t9sory8pE/vpcVvfhNLN5lOeM+Pj/cAOqwsn439ujqP9qJjHv16AE3+kjLoM5gu2A8bHq/WfT1cBQxWhQQulRoDVP/TrJpE8rhMx8CzZnpNJOOTjfe/f/4b+r6OLlWrkYBy2pJFH24fspgBxoz44z6Dr9kErtuRFvP+zvFjJFDo0V2JVP9rKeH8jOLc4IVAikwY8H6qp3FJwx1OdTqhWxP82Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRj3zg+9itdYyS6z7QNXQBDIItCdYPar+DU2LFF/qUc=;
 b=cCJe3FugwfyGkMt1EOcp66reyR3J3D7XOha+PgeIRKFmBG56FdPI11H7rHI8fm1ZyEzsDDEyZdMf+VeYUXDiJ9aT3v92Om6Rf3juNuUT07Pi8OxBe6Gmi4RL3XxGabYwK/RzligsYY5cmcXaW6ZLRXnD4aBjzzvyAIlmHpLPl4CWDj4cb+sSprbOA0mHJ4IsmoNeTVSy8gDDym2ALqmqBparJIynK5WuZ4uu/Ug7zpPAAJIwzvregYKAx1RUlIElQh9t899LW6tad4hFrj/qoQgCEfOY+xrsbCCIjLQIVyPrHqPe9Y6aWHBVEI55dH1VbzWgBSzFpaeQO52ykEu+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRj3zg+9itdYyS6z7QNXQBDIItCdYPar+DU2LFF/qUc=;
 b=bTqnt9IeslzIjFx9rglkSd67is7ESGvfnWQQIaMpTsqp2hUruLEhsuP+8pLXQFbtw8BMOHATvxYlSWDc+81ImZWpcqjestze9JevdCpj/RLwbkX8KYbIU/MieWMwaeo4nADVtNOW8sYZJsOPmkF/sgT7lQT1Dn5dPrgVLDNPlac=
Received: from BN0PR02CA0037.namprd02.prod.outlook.com (2603:10b6:408:e5::12)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Tue, 29 Sep
 2026 23:55:18 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:e5:cafe::10) by BN0PR02CA0037.outlook.office365.com
 (2603:10b6:408:e5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Tue,
 29 Sep 2026 23:55:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:55:17 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:55:17 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v7 02/12] kvm: Detect guest-memfd flags supported
Date: Tue, 29 Sep 2026 18:50:08 -0500
Message-ID: <20260929235109.1398509-3-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929235109.1398509-1-michael.roth@amd.com>
References: <20260929235109.1398509-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: ec180172-d1e3-4fd8-8143-08df1e851d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: TaKRQ/LCNafRw6FU3gr5FmRM3UBjlvM6fiLJaKuppr6tcwlxyixL87nZXXAamHDMowu4lxiw1zhmAMxuhEDVtfcCXp6TnceW2+Vpbns589/02zaZzd/ac0hQY9snWXY5O19ReKkjQfLmKOrDg8t3yBaNm+uCeCaXfRpkfaqQDkmB2m6RjuF69gqwU8mxuCz2IXESkVjVt6RDoPe5XSka+1PjedSpSInuG9vmdcLeWkA3is8MXDs5oeQa/k0iHD9Hs+DROdGHP+YsHbNuA2hohvKsLS0Dk67paWqmmIBiCM2J0cYcXEnAcUr2t9ZUYpHWhsapH9DxoltpEjBSavqVkoymHz1IVLlk8Z8c7KWJ4AZDbKfNYhAeE3Ru585TXyOYRg4LqlTMGLDHnyWQFOLQjJPES9UEIj7EEudfdqOs+RltcXVpiXiQZUeLHS/BMs5jorgODiO8/RvWDr4J+w6+GiwLyZkurXIJ4abXb3QEXfDi2deRvL1Al69P+ItDYIEltPyJZn7a4vwTm4Hakrl4W5pJ2kzbEwAd5pYw4pQsn3Z8NZmTE0h+ju7c2qcEc6RG2dIbGqhGGjeP/N76MZ+PkeYIhvFzu8JxDys/vV8R0mEGqxuogHtOHlLiKQ12lnInX50Kav2kurBddZDbn8NW2cjiXX+Q6zhFktxXbMnC6q+bbYK2vKk7M6zlyAZu3flBHPWXN4D8lsRyabfbMZQYRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: u/1IrETqjCdPkk1zb4tR5R9OUBPTpGqEfWKbe9FyYCt8F5qWQy+2AKBl0zaPcz/8gKp+v1NUlZ9AJuGwtEXQ1tmppfGVwCnn1izS84dFOsDRhJYN4VygOx0G6WTU3LJ15RqS4ZoXYtMqncC9Y/PzMtEYXIbJ4jqbj9Fft+Yg+fH8A9yDkOebSdt5p1VYovsIEGhtmUkpzV1bRhbE41phqsALEI8ZJB8Svg5lYUQlANQbmt2OqvgeRxVpOa47rdnlJPre3EOb4owbEjpMRgds8GRXQWTu9o+fRl51eJ8U7zWCpkTwF2QWuK+h18fNFQgQ5xRTyBVftXPwXa47M7FTdWTGI5FrSr1al6qjirEVDlhyoUy7syLxseTdhyKyZEUFuzRsp1W/nPTi1gErWD5CqGAkArYrBiJRiak7W6VcXeTvGfxU3rBM4dEw19Tv5oAU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:55:17.9060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec180172-d1e3-4fd8-8143-08df1e851d36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=Michael.Roth@amd.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: Peter Xu <peterx@redhat.com>

Detect supported guest-memfd flags by the current kernel, and reject
creations of guest-memfd using invalid flags.  When the cap isn't
available, then no flag is supported.

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cdc7554082..120cab1e22 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -107,6 +107,7 @@ bool kvm_pre_fault_memory_supported;
 static bool kvm_immediate_exit;
 static uint64_t kvm_supported_memory_attributes;
 static bool kvm_guest_memfd_supported;
+static uint64_t kvm_guest_memfd_flags_supported;
 static hwaddr kvm_max_slot_size = ~0;
 
 static const KVMCapabilityInfo kvm_required_capabilities[] = {
@@ -3065,6 +3066,8 @@ static int kvm_init(AccelState *as, MachineState *ms)
         kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD) &&
         kvm_vm_check_extension(s, KVM_CAP_USER_MEMORY2);
     kvm_pre_fault_memory_supported = kvm_vm_check_extension(s, KVM_CAP_PRE_FAULT_MEMORY);
+    kvm_guest_memfd_flags_supported =
+        kvm_vm_check_extension(s, KVM_CAP_GUEST_MEMFD_FLAGS);
 
     if (s->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
         s->kernel_irqchip_split = mc->default_kernel_irqchip_split ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
@@ -4760,6 +4763,13 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         return -1;
     }
 
+    if (flags & ~kvm_guest_memfd_flags_supported) {
+        error_setg(errp, "Current KVM instance does not support "
+                   "guest-memfd flag: 0x%"PRIx64,
+                   flags & ~kvm_guest_memfd_flags_supported);
+        return -1;
+    }
+
     fd = kvm_vm_ioctl(kvm_state, KVM_CREATE_GUEST_MEMFD, &guest_memfd);
     if (fd < 0) {
         error_setg_errno(errp, errno, "Error creating KVM guest_memfd");
-- 
2.43.0


