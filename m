Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D20C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vyp-000494-20; Tue, 08 Sep 2026 09:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vyn-00048k-IP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:17 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vyb-0005wT-Ak
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHF6IT1ICyy2thr6VTMc7W6plBBlWb2SxiOe8CGV4RTr8UOvLNElk9uVthQKHqVL8NiK7zK9hu2v8U+CjAPLcg4K0949XO20csILZTUWCuolivnlzXXdHhoh6pl9J4u9+f+GWoQcGbQ96Fi3FC4Fu9MD1aeltQrzB0fEVZUP1h+87sbauZCskhEmAoV1yRwvo8XyMpUAe2GyB8B9SyVfzXw2onCaVJ/coE8UAL1A6P804NePtccvy+M+FalwVwtZRQOvd6hM/qrQbvUgnDKYyyvqbV32eLZGpldwldava+Xt9Onl5GM3YibYMlCHuAvS0o7sH37ASxAw6XqZArfweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwjrVJV+f4mWJDGj4PcbteJ6Zm8Y2erJlIsN7lWaEuc=;
 b=WJqV3SuaVQzBV32Tx7UCcgdaF4zmoyNS3p+A+WjFvEhsZlDD531Cfu8EzGzd4Vd/hVhYtzqT9QiO4Nf44MJjWRj8q5pyD9d//K/tMDdK2AnERzdWu13IswZDK8gMODjjiPSWUGyG5iqzKAE1XOSTs4BiFgyCSCEmKYo7IlVGzm8rnloTOqSP5Hb4rhoLJbOS72Ca5OXJBF3PTm3oxGBLbO9YUlY1KA3zrkRC1ACazzahGt5JjJis3dM2Xl1C64KLISqqza21NaoSQ7udJom7Zv4MgOqvEp5Db9qPvgd75ZFgg0z65Poz125vGJcq0Sjx+ncQOc7tMzdj+4ucLBSGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=nongnu.org
 smtp.mailfrom=amd.com; 
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwjrVJV+f4mWJDGj4PcbteJ6Zm8Y2erJlIsN7lWaEuc=;
 b=ErNgbZ3n/etqfa+0E2OJdKX4VUY7Dv983GOxiwnr8VQZ33LkmvpZiujTin0f5yG7b64nMH8OwvbTz63PA1RfdG1ta3EiMYtbKjj99qouHQIGvX6wyZ4sQvs5nfzZWdXtsCgsar3GaspkXGCyN6ByJm6VNp7NgHUFk7aQ+3pkSaI=
Received: from BN0PR07CA0020.namprd07.prod.outlook.com (2603:10b6:408:141::18)
 by MN2PR12MB4421.namprd12.prod.outlook.com (2603:10b6:208:26c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:34:54 +0000
Received: from BN3PEPF00022BC3.namprd05.prod.outlook.com
 (2603:10b6:408:141:cafe::37) by BN0PR07CA0020.outlook.office365.com
 (2603:10b6:408:141::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:34:53 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC3.mail.protection.outlook.com (10.167.248.215) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:34:52 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:34:52 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Date: Tue, 8 Sep 2026 08:30:53 -0500
Message-ID: <20260908133151.836685-4-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC3:EE_|MN2PR12MB4421:EE_
X-MS-Office365-Filtering-Correlation-Id: af43c3b6-f016-4eff-3b54-08df0dadf67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|6133799003|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6/meLEeB/EGJTh2m3icmz3F6j5uZwQFHMSrvnSJrTDxsRekqlQwa6BOeA5EOPd9Ye0OPU5x60HxBsnB5FkcXL5ip8dQCs9wFwtU9EOE8KfttSV8E6iMMf/U1UC+QBogApri6ZbWxowBWEy64FnBhntQrpxj4M/xDyEzXC8SeVr/OGC5Ywt/AOy5fYMIUX17iO99ez+s+D46i5cCgLG4rArrRUV1I6J23nBtsGV0v/zXDbOAmzZaqXB9fa9s3QfGr0PicN8bVNAseiiSO8HvLbh5f1l0cp2FmHbyY6TFexrBOwhnb93Ck21ybrjxixBNDyxMw+hY+HIz8By8ZJ1nLVsv07BC0e3SwwDFvwoveH2+5u2uIuDAdDnsUceYsCZNHZ14XCMxmKz1FhQyHc02HLLAaioXfPWXjy0hSnN0+33ZhKa6IrejeAIEAdqZz8Z6hcTuSJ/fy8AwAVFtANCmxjcl2/UKTnyrxmsjvfCi8XZToTKs8o25MNyJD+TfukFSpgKz0DqXswXGICuh/b7i3WF6WDCFJWJ9vYAG1QMfAgj06slu0KcDW2hHyGB8eIoL5LFmLHQP291pc5J+LApjgbzkSoABjmyb8cRBMIuMB3KN7CN331DqpyysZdIL2CwnXcJlAc622ZcMaZoaXxUD2dvXpImcIw+prIE0Ymo+ocHAJt9Dk8bVxaavFfC4W6Dwc/e9syBGb/3nZmYMWIhS9MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5JkIzvodp9Nxin/mCjJRF1HDM0N7onwpYMoZ5jWqpxG9KcMHKSVGsLcRe+fm+pfi6gR40ePJUmct4BAYttlmkU5hFOx64HRmYwQqjjrUdmai8t46wCXvgRRClVUjQWKTn5qOWSvnGFo+wfgfMN4OYao+oPlJRsZBviU8Farvb24+K6e/QSkzqQhm/7PPKt2g0y2h3sMB/RVv2XBuGNJatw2GRmdmeaxaFVZRRDckpEqc/xkJDcchB8U9yzTNVbBV2Ky6I2/Wt4WpZqdzXArcHOGn/0W5seuoJJOX971yxsPkMnszSjnXvaQnTui2oDJvJFYfV6xTBPET/EUzHc1rWDQ5ABalEupr5TdBwP8LSNJ/eVK9v7i1HQy3sa89dnfb1QdpmDzTHbkq2MgDpvDGXDP8+QlYHQDkcWlYkR1KBnQOxWpBLTEozKSOK7mfeodf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:34:52.4920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af43c3b6-f016-4eff-3b54-08df0dadf67d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4421
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=Michael.Roth@amd.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

So that there will be a verbal string returned when kvm not enabled, or
kvm not compiled.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 12 ++++++++++++
 accel/stubs/kvm-stub.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 120cab1e22..a851b8f628 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4758,6 +4758,18 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         .flags = flags,
     };
 
+    /*
+     * kvm_create_guest_memfd() can be invoked from generic hostmem code
+     * where KVM might be compiled but not necessarily enabled. Because
+     * of this, check for KVM support explictly before continuing with
+     * any KVM-specific checks.
+     *
+     */
+    if (!kvm_enabled()) {
+        error_setg(errp, "guest-memfd requires KVM accelerator");
+        return -1;
+    }
+
     if (!kvm_guest_memfd_supported) {
         error_setg(errp, "KVM does not support guest_memfd");
         return -1;
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 3d34e3b99d..acbd0785e0 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -141,6 +141,7 @@ bool kvm_hwpoisoned_mem(void)
 
 int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
 {
+    error_setg(errp, "KVM is not enabled");
     return -ENOSYS;
 }
 
-- 
2.43.0


