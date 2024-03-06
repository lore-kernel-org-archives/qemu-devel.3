Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC6BC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnlZ-0007Sd-Gz; Wed, 06 Mar 2024 04:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlY-0007Ri-5q
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:48 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnlV-0002EH-GL
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:40:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718045; x=1741254045;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6WGcGPLsmeM9ujwFnIiG1nYtUcObQiTkGIz1UZVazz0=;
 b=mAOU7EqSsZgXZAlQVW4BGtNRlf9SOLa8dSeN8Zn6Qk8BzxQZwEO007pz
 dI/XiYk4W26078hOB016wkeeQt4nNf4MuVgLTs6g4jt00RbZ3A8shwGZA
 4DcIFzBD+mDn05XKC6FmUhkzIN5myfqeVb1teLeU/NM/+wubi91JLelye
 0rRSEwdqkoniShaqboO55hQRh//gcjoA/J3HFKID0zmiVkhqTsfWEF/Vw
 74VKKVFlBwXCdF7dWl0vtw7h+TYUv7eduX2qBScVW6XnXeJ5Ha/1W8fam
 a8BmPSUW+/Cjrt0GYPhonjv2vjeViHSn2q+AWMe06oQUjUvSMVR7+MSKe Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897863"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897863"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:40:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854149"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:40:42 -0800
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
Subject: [PATCH 06/14] tests/unit/test-smp-parse: Use CPU number macros in
 invalid topology case
Date: Wed,  6 Mar 2024 17:53:59 +0800
Message-Id: <20240306095407.3058909-7-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
References: <20240306095407.3058909-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


