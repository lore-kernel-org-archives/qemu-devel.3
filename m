Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82795C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricSW-0000ca-PT; Fri, 08 Mar 2024 10:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSU-0000by-QX
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:30 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricST-000417-9O
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709912910; x=1741448910;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6WGcGPLsmeM9ujwFnIiG1nYtUcObQiTkGIz1UZVazz0=;
 b=S0HgMHGVoCHpRi0IZ+DTLdewIYp+bwaaW6KwzNn2n+nsVf1otiHZJo0F
 45S/Jw4efojA6lgFHWpL32tbWQfKR9SDmVgjmHi5114+8WVv7VUBeZWLo
 jeRKLyDkqfLNI4Rf4metBc5GA8UcpSg3SEi94Jtapogk4Fo1xoqf71HK7
 0wZ5nTtw6Nw+6g8XZRf6X/scvkZugQX1eHVjSx1HfDH9id70a+x+VhIR2
 kxyMc5cDcrWfzi1Exb9TnIcc2HpXfbhArTGvtPs0Ouh6Ljbc8EtRPifbP
 yf48aMMQd4z0ZxLB9BkmXPV2Gm2FZfyBRQg86tQwvHQP8qAWvAHyO/UXl Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4561053"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4561053"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; d="scan'208";a="10400332"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 07:48:24 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoling Song <xiaoling.song@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 05/13] tests/unit/test-smp-parse: Use CPU number macros in
 invalid topology case
Date: Sat,  9 Mar 2024 00:01:40 +0800
Message-Id: <20240308160148.3130837-6-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
References: <20240308160148.3130837-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Use MAX_CPUS/MIN_CPUS macros in invalid topology case. This gives us the
flexibility to change the maximum and minimum CPU limits.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Xiaoling Song <xiaoling.song@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-smp-parse.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 1874bea08609..84e342277452 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -323,15 +323,21 @@ static const struct SMPTestData data_generic_invalid[] = {
                         "sockets (2) * cores (4) * threads (2) "
                         "== maxcpus (16) < smp_cpus (18)",
     }, {
-        /* config: -smp 1
-         * should tweak the supported min CPUs to 2 for testing */
-        .config = SMP_CONFIG_GENERIC(T, 1, F, 0, F, 0, F, 0, F, 0),
+        /*
+         * config: -smp 1
+         * The test machine should tweak the supported min CPUs to
+         * 2 (MIN_CPUS + 1) for testing.
+         */
+        .config = SMP_CONFIG_GENERIC(T, MIN_CPUS, F, 0, F, 0, F, 0, F, 0),
         .expect_error = "Invalid SMP CPUs 1. The min CPUs supported "
                         "by machine '" SMP_MACHINE_NAME "' is 2",
     }, {
-        /* config: -smp 512
-         * should tweak the supported max CPUs to 511 for testing */
-        .config = SMP_CONFIG_GENERIC(T, 512, F, 0, F, 0, F, 0, F, 0),
+        /*
+         * config: -smp 512
+         * The test machine should tweak the supported max CPUs to
+         * 511 (MAX_CPUS - 1) for testing.
+         */
+        .config = SMP_CONFIG_GENERIC(T, MAX_CPUS, F, 0, F, 0, F, 0, F, 0),
         .expect_error = "Invalid SMP CPUs 512. The max CPUs supported "
                         "by machine '" SMP_MACHINE_NAME "' is 511",
     },
@@ -575,8 +581,8 @@ static void machine_generic_invalid_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
 
     /* Force invalid min CPUs and max CPUs */
-    mc->min_cpus = 2;
-    mc->max_cpus = 511;
+    mc->min_cpus = MIN_CPUS + 1;
+    mc->max_cpus = MAX_CPUS - 1;
 }
 
 static void machine_with_dies_class_init(ObjectClass *oc, void *data)
-- 
2.34.1


