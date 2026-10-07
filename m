Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C281CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xES6Z-0007wA-Vo; Wed, 07 Oct 2026 09:54:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERzs-00067a-UW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:48:00 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xERzn-0003yD-FZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 09:47:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqt/sP5TL/HsAabUYSIi9jKA8HqO9w/UFms8uZDsdtJmpDq2lCp1UxkX14F6mXYggWrMFgGPhdz1f4ikflo3kNJbx3IhNX4dHpwFnUVWFMl066u7NwofHWvDguSZ7Ti9DKcmfjX+/phVM/SId+TYBlnzBAzAqwH75eUvmMzO1F1IptCcxfw5kvwUEiGXHD5fBmubAdUTX1oRsMNQ5vLRKSCcWwQhWgvj0Q6UO1DT9ZmBEsIPwAhqEg7v+QqN/zMWANcPBIo/AC5xGwNqWOF48xxmQjprEa9ptvvlqyt35CEXitBEcUXLF8JNknQ9JofAUD2ArWRX7JF5A4JsrhXy8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA3BNPZUnrX60+4PCB//BWtHDdSBGd4H9sokr4s2wnE=;
 b=CYIXjMb3ddulQtCRZqGGpLkS8P7kCCPjJeMfZKPQmL4RkwGhK/vOS//uaBT3tT2gZQPKwgWDQtNxXgDshh6PEHxgAkoJ74RchUrsqODakXHzdB5LRt9pqb+A0wdNolqXRgRC5kp7gI1+P6K/wIaqseYcew0M6gLc7G73mkR5Xazd5dSkDP4hNEHiMdHvk9nlSYZLc2rvmbHtTjHC0AvfgS3LrN57P0nbqOg7Aya7KivQyG1GtCBfSqhblG8DSKMHSerY7W8qjSpkJnHUU92FD+On4F7O97WIbyraSOfZ8xp5pFazfesEGLB5z2z8b+cY8lTSX73rHhtJcuhqhS5v/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA3BNPZUnrX60+4PCB//BWtHDdSBGd4H9sokr4s2wnE=;
 b=hfL5GQqBKCbd/NL0VSoKZaP2tvGkpLkXMjGN8GUL8RcdM/hpO3+r9JsZjjnarkp8xOKU/09zUAAWfwkos+WP4LZNUr8VuVTce6KTv6KrtYSGWLpyA578qFlecsLDvj5bfOyH/Ictt3VpuBxPdMo1hj6pQ/S2LdfWqjvH09smYXI=
Received: from PH7PR17CA0063.namprd17.prod.outlook.com (2603:10b6:510:325::27)
 by DS5PPFD22966BE3.namprd12.prod.outlook.com (2603:10b6:f:fc00::662)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 13:47:37 +0000
Received: from BY1PEPF000264B0.namprd02.prod.outlook.com
 (2603:10b6:510:325:cafe::7e) by PH7PR17CA0063.outlook.office365.com
 (2603:10b6:510:325::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 13:47:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B0.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 13:47:36 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 08:47:33 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <armbru@redhat.com>, <pankaj.gupta@amd.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, <ashish.kalra@amd.com>,
 <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: [PATCH v3 19/19] hostmem: Automatically select set guest-memfd=on for
 in-place conversion
Date: Wed, 7 Oct 2026 08:41:43 -0500
Message-ID: <20261007134323.1606088-20-michael.roth@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B0:EE_|DS5PPFD22966BE3:EE_
X-MS-Office365-Filtering-Correlation-Id: 290f23e3-49a2-4e2c-db4e-08df24798bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|7416014|376014|18002099003|260925022911599003|260925021311599003|260925021911599003|10067099003|56012099006|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: q0GdopUIaiQC4cv76KNlQH+MF7UEeFQp12kdKebgTQpbmbNT+BRDhSsDlwb+mwDZPzLLgO3M2YTPMYBvyfdTY/4FwK3XtRQgVI8DvFgBHEYnzHnVrKrj72vdts71NnlAU7A4c2ZqFpo4Adai+C7TiOykfS93OHbB9Sowq9wV+oTBoklhuevTRVygac8urU2+0M9fhdY5GsLgQA7jxxTqSRDTCMZ8MdP3xSPlUBdANG3Ela3kPB0PjO92IZsrU9St2g96troD8nJB8snoFfI/YHI6GtHEnnsiRLcG3BOFxzzV4MKwIknGUppaHyeTIY2ZcLNgg+vN55JycTXdLHMy0S8qImJxrnPNmkfbP8zNAIzZJ6vd9IlwXOeQ8hB8HUzFBVRWcFpCq29NvRoBAXyaL+73qLUeHpwd7qiUv3iR8EE16pAPShAVykn4+1wWJbVWK0sAmJvwNya9IU6s/Rm3NCE7c4AGRvnkE2gBDt79gMJASU6j0kXGW7zU3E3JhC9BABMBYGd+mT7+Woh30++3JJsRA9x5oOriS9z04DeuYrqzUYsayioqT99UWWYdxS1FA2kX6ALNAyEdw0v/ekqdbJ3itUPjRjiXdD7rQ4QrUzYCxa8UaJjsKTrnIO2a/O68vyTdpS5nbVoGTxOS0ZuZWDedejWlvj3dxvc6dhP3ZstS3yjQj10eb2AIoLdQk7rF8uKIYZ9fSWX/2OAWJSQxYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(7416014)(376014)(18002099003)(260925022911599003)(260925021311599003)(260925021911599003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +P/Sfvp30Jwcga4Bvf55WAt7OefFbcnSV7yuINRrLqIX4kYm5B+vzPMvhLLTlvUyMEvrjL58jeeg5rkVh6aBkTUc1CssRYpEp+uemQfsPSAPlPerPUCtZEISAXjQykdjDZBkJNunB5eWiwcS3JW4lpu1KyO017yto2D9neM1Iruqpt58pCiEDi52sqDBFTLiQ6HgxKarlocFH8+VgH+aRisey/uP2BuVjh7esan75XPyDJ0h4sH8uegGpZL/Aemjklr5FAnOj6bVw6WTIgqkHAuKC502xhw8zxFwwBM/Tb+Z8DZsN4wTpSwaIWWgLDpkhQOKlbCM3PKV6ay/r/AUuu+o5Yi4daISe5jIIj1hNC8RxsudoMt2FCCjQm4DSi/wEtUp9TqllUF7J+NABsoijaquZA+l5zBTbvi3EhMwTl+J3pyWrqP/ea1vbsNzb5On
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 13:47:36.2621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 290f23e3-49a2-4e2c-db4e-08df24798bbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFD22966BE3
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Michael.Roth@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

When in-place conversion is enabled, both the shared memory and private
memory must come from the same guest_memfd instance. Thus, the
memory-backend-memfd options must in turn correspond to a guest_memfd
instance, e.g. guest-memfd=on must be specified. Since there is no
use-case for enabling in-place conversion without setting
guest-memfd=on, just set it automatically if in-place conversion is
enabled (unless guest-memfd has been explicitly set to 'off', in which
case generate an informative error message).

Also update the 'guest-memfd' documentation to note this behavior.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 backends/hostmem-memfd.c    | 13 ++++++++++++-
 docs/system/guest-memfd.rst | 21 +++++++++++++++++++++
 qapi/qom.json               |  5 +++--
 3 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index d3b17232f0..11873b4e0e 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -21,6 +21,8 @@
 #include "system/kvm.h"
 #include <linux/kvm.h>
 #include "qapi/qapi-visit-common.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev.h"
 
 OBJECT_DECLARE_SIMPLE_TYPE(HostMemoryBackendMemfd, MEMORY_BACKEND_MEMFD)
 
@@ -45,6 +47,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 {
     HostMemoryBackendMemfd *m = MEMORY_BACKEND_MEMFD(backend);
     g_autofree char *name = host_memory_backend_get_name(backend);
+    MachineState *machine = MACHINE(qdev_get_machine());
     int fd = cpr_find_fd(name, 0);
     uint32_t ram_flags;
 
@@ -57,7 +60,9 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         goto have_fd;
     }
 
-    if (m->guest_memfd == ON_OFF_AUTO_ON) {
+    if (m->guest_memfd == ON_OFF_AUTO_ON ||
+        (m->guest_memfd == ON_OFF_AUTO_AUTO &&
+         machine_require_guest_memfd_convert_in_place(machine))) {
         /*
          * NOTE: guest-memfd ignores seal=on/off because it always
          * implicitly seals the FD by definition.
@@ -72,6 +77,12 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
         fd = kvm_create_guest_memfd(backend->size, errp);
     } else {
+        if (machine_require_guest_memfd_convert_in_place(machine)) {
+            error_setg(errp, "the current machine requires in-place conversion,"
+                             " which is not compatible with setting"
+                             " guest-memfd=off");
+            return false;
+        }
         fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                                m->hugetlb, m->hugetlbsize, m->seal ?
                                F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
index d62a214a91..4477756424 100644
--- a/docs/system/guest-memfd.rst
+++ b/docs/system/guest-memfd.rst
@@ -53,6 +53,27 @@ exposed as an experimental for the time being:
  * guest_memfd does not currently support the hugetlb=on option
  * guest_memfd does not currently support Transparent Huge Pages
 
+In-place conversion
+-------------------
+
+Newer kernels now support using a guest-memfd instance for both
+private and shared memory at the same time by re-using the same
+physical backing pages if a guest converts a GPA range between
+shared and private. This is known as "in-place conversion".
+
+For some confidential computing architectures, like SEV-SNP and
+TDX, this mode offers better performance due to not needing to
+deallocate/reallocate between 2 separate pools of shared vs. private
+memory every time the guest converts memory between shared/private.
+For other architectures, this is the only supported mode of
+operation.
+
+When in-place conversion is enabled, it is necessary to use the
+memory-backend-memfd backend with guest-memfd=on as shown in the
+"Usage" section. Because of this, guest-memfd=auto (which is the
+default) will result in the parameter being automatically enabled
+if the confidential guest type enables in-place conversion.
+
 References
 ----------
 
diff --git a/qapi/qom.json b/qapi/qom.json
index 84166c2457..5d66e67087 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -756,8 +756,9 @@
 # @guest-memfd: if 'on', use guest-memfd to back the memory region.
 #     See the :doc:`/system/guest-memfd` documentation for more
 #     details.  If 'auto', the option will default to 'off'
-#     currently, but in the future it may result in the option being
-#     set to 'on' for QEMU configurations that explicitly require it.
+#     unless the QEMU configuration explicitly requires it to be set,
+#     e.g. if in-place conversion is enabled for confidential guest
+#     types like sev-snp-guest.
 #     (default: auto, since: 11.2)
 #
 # Features:
-- 
2.43.0


