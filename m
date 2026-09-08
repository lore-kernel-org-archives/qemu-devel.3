Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025DBC79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x42sd-0005eq-Nq; Tue, 08 Sep 2026 16:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42sb-0005ee-Sg
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:57:21 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x42sZ-0007dC-9p
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 16:57:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBQy4h9DrXD+MjW1TWFypuUtVYSr3RNDFXTUF8LMYhFRXUHng0kNTpKSnn0bK3OS00r5jRowmb6WM8xESu+2FTeSYkgELYTVws/+IR+iHv7N/+pdgTcgkn4Drl4wGU0wLWm6LAYOH/wLmSm6PAQrI7wqmwifNpMUU8m9YCHQf4HJG0lMuNAZe1AeEEvyFdvaMhk6YbyCK7EA6Oa1MaOQW0vOf4D69eRSrMreWSnKNGThB3t9t/7ld56a0UfKYg+zJiBZUWaxLVaT78SVSN1KWLmPW8gu5I0WVPbNliLPsRnY+jQsycOdTxksXdRY7DVB3wedi2QslYp1jY2HgxvSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSaVACk1QKzdOchQHcxYxDY+BjmYwoEOlDOMHbWhWwE=;
 b=nAcUWzNgxVj4OS0yI2QhaeaYDbX6fBGXyp4uyPCJNoeH4Ud7byMSaIysmZCHmNEVVusUWvty2ahnOWp6lD+XxUiAfgJHafEtGByXGVgNCr8sZ1sdKSzWZVMGkMDErK39ntmoGPIG2WS6YUBPuq0fbiOTfSImpzFSLsDdgQGdjM1Vep5QAzuZmgrTWVw7FT+p1tgCfRCCa99iKkAAJidA9m0NpeukTUTGlRvh8AmcFt7MlGdW4XuAPfe6RbWa8NrC1U/e5Rx/7DeKcOSsplUa0TTVh8kK7AwqgNIJ2UycG7M+UJtozzNncxrpNq6yy6cw/d6xLUDpJV+C3ystyNUntg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSaVACk1QKzdOchQHcxYxDY+BjmYwoEOlDOMHbWhWwE=;
 b=rPBbVxfETOTA5bJpoPZOt5QFy92Rb9Xd2gT5eVXCVJiX79b7rYO7ECPXXpG8zQY0fC3qd/NHfMiWGsQ57+g3BSQI4qk2vlUtSMuYWGi+wYq9fFSPJ0TKyZXZT2e3WuDDrF9+XDxrn/RrMhjugc9X/BFfieT13fVg2v0YY2nr9qk=
Received: from CH0P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::26)
 by CH1PPF989868826.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Tue, 8 Sep
 2026 20:57:12 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11c:cafe::4e) by CH0P221CA0017.outlook.office365.com
 (2603:10b6:610:11c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 20:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 20:57:11 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 15:57:07 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <ashish.kalra@amd.com>, <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v2 19/19] hostmem: Automatically select set guest-memfd=on for
 in-place conversion
Date: Tue, 8 Sep 2026 15:48:39 -0500
Message-ID: <20260908205236.838281-20-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: 1079e8a9-5bc7-4881-ac27-08df0debc120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|7416014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7ECmAbuWaaXUcZVjS8kbs1ieW3B/hIsegoohwckfyA/pTABgtj+ly670HPoXOaXdG0r+OBnVccpn2nMMsedR3znVrC/RtBtLfF64ecKt/A91Y3MBAKcELbQavQukSR1B5zDzgiwHYHzUBP1p7/EmL+mqMkvoJx+ZibiRwgGX6DRo97XKQjfsQfnEcB/m/xDAGq8faRxb+ANhzgiF9ykCk7NFU5PEF+6Lalq1kcl3t+zCUAnVZebtdh+W1q1LeZ1xX4vIqZf4quK+ob38EjBwZ7VxOfTx9RZ9mILwN2NJPg7qf4j2ny/kC7d1Cdm1o7YQD2uIYbvbbLfWGiIObCBLv12RDxab4fh27M502uKSq3lXmG3kGAyHMeUACxSC72crI17c6J8BgvjjUOwuzAh0+Z57CJm/cpUC19sWyn4iN7UmwlpaLPssS5P7L4Nvr0mL6ylsbRzhUDGgiqqqY2B2jiCfCtqcW7CmStXM9UbRqEDb+QW38mnmqYHLLk/eamokCQ3zOCWJ597Hq9oSudSY/7obF8P1eqSQB0IZYHSW/JI9Mr3elsulACffuJInOUaPnwQd73jwXXnruN2Ev3JumjoN1fFR/bB4WLCcx1zTI1PsYi9aMW6GKoNMRt6Iapdcexd6r65GqZcuBSpjb4YCnsoGmjIj+leYTQr6MtsMwM2xjYFDaluO8301WzZ4wl4QAhGEz9O+NmRarbQ0QtvaJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: L09sqQot4BjpjhvmCZvPrao5me5QQ6/pMcr+STWd0aihJiwzWGkyrMYDqNK5nVb2maa86ZXZL8TL8eKgCoaRueZfKycKHGJwvgPoK16C8nzwqqG0ZtHnC3vTYY+lMAkY53YfbHu8sxbg68aP4L2rYaPKBB6VD/TfLT/52ME2JwSFg4+1dqZRzQCJyRBXWVgVKIEOJzx4qKDhO3JIh69KmRcOT3ENNxclyAkvq80ohwu80ALH3GbT1VWdAw0bxaKdnVu77Z2Ec1lqZ0ufkQQZW4FAFM+AMSsKAAfxMYGcgeDgmzAKrL79xVxESeIXLUMAGvny/AAIxk5PlNJUMRVjTYJAz/lCdCv9WklmsZTYa9mhvV3yuSUovlUN/Z4mL0GpVwjmMgTy0bloAQNROGaVpokLp9ldTeKS7rHOL0mWTiADNjuc2Stt6eCHb89qvOm7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:57:11.8236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1079e8a9-5bc7-4881-ac27-08df0debc120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Michael.Roth@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
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

When in-place conversion is enabled, both the shared memory and private
memory must come from the same guest_memfd instance. Thus, the
memory-backend-memfd options must in turn correspond to a guest_memfd
instance, e.g. guest-memfd=on must be specified. Since there is no
use-case for enabling in-place conversion without setting
guest-memfd=on, just set it automatically if in-place conversion is
enabled.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-memfd.c | 34 ++++++++++++++++++++++++----------
 qapi/qom.json            |  5 +++--
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index de51cf738a..85ed973082 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -19,6 +19,9 @@
 #include "qom/object.h"
 #include "migration/cpr.h"
 #include "system/kvm.h"
+#include "qapi/qapi-visit-common.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
@@ -35,7 +38,7 @@ struct HostMemoryBackendMemfd {
      * private pages.  Instead, this flag marks the memory backend will
      * 100% use the guest-memfd pages in-place.
      */
-    bool guest_memfd;
+    OnOffAuto guest_memfd;
 };
 
 static bool
@@ -43,6 +46,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
     g_autofree char *name = host_memory_backend_get_name(backend);
+    MachineState *machine = MACHINE(qdev_get_machine());
     int fd = cpr_find_fd(name, 0);
     uint32_t ram_flags;
 
@@ -55,7 +59,9 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         goto have_fd;
     }
 
-    if (m->guest_memfd) {
+    if (m->guest_memfd == ON_OFF_AUTO_ON ||
+        (m->guest_memfd == ON_OFF_AUTO_AUTO &&
+         machine_require_guest_memfd_convert_in_place(machine))) {
         /*
          * NOTE: guest-memfd ignores seal=on/off because it always
          * implicitly seals the FD by definition.
@@ -91,16 +97,24 @@ have_fd:
                                           backend->size, ram_flags, fd, 0, errp);
 }
 
-static bool
-memfd_backend_get_guest_memfd(Object *o, Error **errp)
+static void
+memfd_backend_get_guest_memfd(Object *o, Visitor *v,
+                              const char *value, void *opaque,
+                              Error **errp)
 {
-    return MEMORY_BACKEND_MEMFD(o)->guest_memfd;
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(o);
+
+    visit_type_OnOffAuto(v, value, &m->guest_memfd, errp);
 }
 
 static void
-memfd_backend_set_guest_memfd(Object *o, bool value, Error **errp)
+memfd_backend_set_guest_memfd(Object *o, Visitor *v,
+                              const char *value, void *opaque,
+                              Error **errp)
 {
-    MEMORY_BACKEND_MEMFD(o)->guest_memfd = value;
+    HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(o);
+
+    visit_type_OnOffAuto(v, value, &m->guest_memfd, errp);
 }
 
 static bool
@@ -191,9 +205,9 @@ memfd_backend_class_init(ObjectClass *oc, const void *data)
                                               "Huge pages size (ex: 2M, 1G)");
     }
 
-    object_class_property_add_bool(oc, "guest-memfd",
-                                   memfd_backend_get_guest_memfd,
-                                   memfd_backend_set_guest_memfd);
+    object_class_property_add(oc, "guest-memfd", "OnOffAuto",
+                              memfd_backend_get_guest_memfd,
+                              memfd_backend_set_guest_memfd, NULL, NULL);
     object_class_property_set_description(oc, "guest-memfd",
                                           "Use guest memfd");
 
diff --git a/qapi/qom.json b/qapi/qom.json
index 20d6fefb04..32df7cb794 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -772,7 +772,8 @@
 #     resizing of the memory (default: true)
 #
 # @guest-memfd: if true, use guest-memfd to back the memory region.
-#     (default: false, since: 11.2)
+#     (default: true for Confidential VMs with in-place conversion,
+#     false otherwise, since: 11.2)
 #
 # Since: 2.12
 ##
@@ -781,7 +782,7 @@
   'data': { '*hugetlb': 'bool',
             '*hugetlbsize': 'size',
             '*seal': 'bool',
-            '*guest-memfd': 'bool' },
+            '*guest-memfd': 'OnOffAuto' },
   'if': 'CONFIG_LINUX' }
 
 ##
-- 
2.43.0


