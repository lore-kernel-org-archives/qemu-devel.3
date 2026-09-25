Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB03C9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vEX-00082t-RE; Thu, 24 Sep 2026 22:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vEP-0007gn-Rc
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:00:10 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vEN-0006dr-UH
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 22:00:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs81xrCK7BkxVIjQMLe+mGcqQlqgosUOt0gXI5gmNI/2W28dx2KcHkKpWoa+OvNwiOgx7KxceQK/6XJRpoV9qztoji5g+WYVqYmoFECqT7cedChq2T1SzZlYo/CRVvmJl6+Hse1K+q0c9k3wrUMdv9Ag0ymjTFIqHYkFTvchb5KvfSN/Bq4Yika+c0r1d2TugvheKBQEnoYQni46oFy9GHbYu2jwHADigGNwlOWd0V35KRsem4FU+Jn+G435nj2BQKbyMlKlET13pChVVrKsm+w7lstG8lOa21P4Uh4Iuq/lau1AqHb0w3wDJMmSowjtW0TmSXSP8aZuWZ5wo6PmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqOCq80wst6hd+j3A8zmXak1oz3A5JChzBn/NUFNwoQ=;
 b=dhIVTdpiNHJSvV7kok+fVhh0uYopU++aLfyFIhxc0mP/gcImiVFqpbSeT3+n3nxOSDBe8ac/UAdasjSJ9dNxstuOLv1jOwzijs79b8Ash2Ce5zF8va7gl2iSWZk/MMIIwCeCTscoYrKeaOCQotA5AM9oyKfsviGmjKko1RtJLGny+0SP5ZP1UJYF0AvV6AQP1idI8LQroCTLvuwL5fK7axRAq8i4Wl34dqfgdEXWYf1PDfgFLn6Xka72Xkap78cXIkgz0NOlM+YATlkNjTAD71okjSaxr9BmP3zpUqvr5vNcVrU7eZqGCKRj0GRW5hOi1sjzlJhyifzUiY0PntqNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqOCq80wst6hd+j3A8zmXak1oz3A5JChzBn/NUFNwoQ=;
 b=ts9YRq10zfsbGM1vrXGpiPw1CN+gquGMKHR0HUVlDPS0dTRhyBpPGTHU5ikWzhAK3CT/ErVjqWFJuW3N2XQJj5QZAsQHw11t4ljteZE9HaqItjnOnz5YCogR3liP1lFM4x6RYsdh/ENbR/1CD2oyvdyiHZeHHx+iRSFoFKiQz/0=
Received: from MW4PR03CA0336.namprd03.prod.outlook.com (2603:10b6:303:dc::11)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 01:59:58 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:303:dc:cafe::69) by MW4PR03CA0336.outlook.office365.com
 (2603:10b6:303:dc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 01:59:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 01:59:58 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 20:59:57 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>, Fabiano Rosas
 <farosas@suse.de>
Subject: [PATCH v6 03/12] kvm: Provide explicit error for
 kvm_create_guest_memfd()
Date: Thu, 24 Sep 2026 20:43:09 -0500
Message-ID: <20260925015700.1260501-4-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: f80cc580-5a87-445e-4d44-08df1aa8b3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|11063799006|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: IioMS02GmMsFx94Kh4mIXlKiZDiaE1Ka93K4jtVy/bB/PX62kIja+ycjs/41HsCbCBLgw8VjnWtHU7ZqYMqI+0y2QDmm8RhZrGXzws0/Wg86BJwch2XkmNxqqraAIM2Yx2bIVbMuDimyyWrtqNrk6EIWg8Au4IBzSWHoGU3NYo4WCIoVzeuqT9v6ryMz0m0gpsXh8t1icMDYBzdIauEqQr4cdCe6tAiU3HgLeJzP7jv5rZrMWAGtI65VY4eWwuAj7oIXPE1dtYTcSnMEt7nGP1fA73BIVoUNH8l62gHiZ+sM/nrBj7GoLeMkLqXFYVN73RUM6Doh7WX9szJ4DZ4QECQ/cjE1tJafaTPf/cigc18mMJs77YlfGqAqKaklePdkUGt+SkfxWawRAFARtK9c9b6wLYv9PJQfS2MdD+YBxEFFPybe87/8TqQvtToPqOmxHObrgU+oC8CQlMW+KqvYaFw5+wFB06613xGWCvxRfF/nNbYcabW0VLdn/vfr9oZg4bCIsGg8OsQPg1DmPvIjj5GRYs+Ax6wawSMbQt4zpbR0G6YLQ+5IbmBUkUbPpI+UzRf3n13nNAqda54fedWEphKXWB2IoWhomVXQXMXvpFRviylb8/uhGajttk7p/igEuBdG7zL1CSzmCi5q17AxhW/TZCoupHX8osicuWSULjveKPYHLC5x3KxznYKWpsvntlQlbAu4DPwR+6sONZQuTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KbHkpUCVfSM09Hksa8lG5fwyGizg0dX1hGu+X/YDJ07yG5aAZY1yiYE3EnzUyG3DRgLe4ALk19zz7w5dcNjYZiomDah209bShYgIF/YhIF3cFBZuN/N2LdO5i7hmdo3rDjtq3T9tj0OupmcBwRYTGhTxwSNE5sfkFjpWHb939Fhxe+VOCVs9hLqWIGKiKlp2zLM7sVYfHdcRCmQ8CXZgHkU1NCLdRd8u+OGxWUwCrdvf+qcze1QT0P0qhg09scCXqpWDP/CwFqc/H+Meeztr12qpuO1EbTOGeZjNzenS2F+UFLq6Ka/Mbk+u6K5/+US+6TTMEpmTfmX5o+0lv+AZc+a4NYZd3N3Tq+hMZKzDru744ZbBayJsaQkpZ8rBoka9lWufvEeKAdJVZCxGEKkheclhM4ydyq5PhwPv4ST0TThRKGl6bR/McutrS4hiVuC7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 01:59:58.0581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80cc580-5a87-445e-4d44-08df1aa8b3b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

From: Peter Xu <peterx@redhat.com>

So that there will be a verbal string returned when kvm not enabled, or
kvm not compiled.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Michael Roth <michael.roth@amd.com>
Reviewed-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c    | 11 +++++++++++
 accel/stubs/kvm-stub.c |  1 +
 2 files changed, 12 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 120cab1e22..0b1407e4ea 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -4758,6 +4758,17 @@ int kvm_create_guest_memfd(uint64_t size, uint64_t flags, Error **errp)
         .flags = flags,
     };
 
+    /*
+     * kvm_create_guest_memfd() can be invoked from generic hostmem code
+     * where KVM might be compiled but not necessarily enabled. Because
+     * of this, check for KVM support explicitly before continuing with
+     * any KVM-specific checks.
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


