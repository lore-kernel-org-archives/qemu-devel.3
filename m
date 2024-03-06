Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69E3C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 09:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhnm8-00085o-TP; Wed, 06 Mar 2024 04:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnm7-00085T-1m
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:41:23 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rhnm4-0002dF-7X
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 04:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709718080; x=1741254080;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AyRMlDMPyeK2zIKXag691XL6Lf4SeMfVoV8Ojv6fvFk=;
 b=gJReOePo5eCcVs/hZ3hpWiIoTGyTxLMiti5eoKhGyZsZEi0nYEl9aySW
 I8fcsbsM47eJ0osypxoz/+8owA/b9VvkEWz6aB+LzEP9OT4CqkfCtZAxI
 KTgyZYLWmoQ6oxwK0Cqlxmss6fJScx47jz2FLzwkEwl+4u/jZ5LVvaZb+
 6XNDrPemJ4sFaiOHa93OqYQjKIaK8cGJIrDK2XpGff0RbNK3JP+sBvO37
 Oz9x5sKVfXA8gJ0or9iyfnIY4LwTW68neQWCQSl1CCuHSZFMseAV1Rg4T
 M4+1vmL8+aBwLeyfO+UTfqjje72oZvClFDUIJzqQa2GPPzCQDyMYXhxiN A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14897959"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14897959"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2024 01:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="32854209"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 06 Mar 2024 01:41:06 -0800
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
Subject: [PATCH 14/14] tests/unit/test-smp-parse: Test "parameter=0" SMP
 configurations
Date: Wed,  6 Mar 2024 17:54:07 +0800
Message-Id: <20240306095407.3058909-15-zhao1.liu@linux.intel.com>
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

The support for "parameter=0" SMP configurations is removed, and QEMU
returns error for those cases.

So add the related test cases to ensure parameters can't accept 0.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tests/unit/test-smp-parse.c | 92 +++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index d39cfdc19bfe..8994337e12c7 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -524,6 +524,91 @@ static const struct SMPTestData data_full_topo_invalid[] = {
     },
 };
 
+static const struct SMPTestData data_zero_topo_invalid[] = {
+    {
+        /*
+         * Test "cpus=0".
+         * config: -smp 0,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(0, 1, 1, 1, 1, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "drawers=0".
+         * config: -smp 1,drawers=0,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 0, 1, 1, 1, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "books=0".
+         * config: -smp 1,drawers=1,books=0,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 0, 1, 1, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "sockets=0".
+         * config: -smp 1,drawers=1,books=1,sockets=0,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 0, 1, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "dies=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=0,\
+         *              clusters=1,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 0, 1, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "clusters=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=0,cores=1,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 0, 1, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "cores=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=0,threads=1,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 0, 1, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "threads=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=0,maxcpus=1
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 0, 1),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    }, {
+        /*
+         * Test "maxcpus=0".
+         * config: -smp 1,drawers=1,books=1,sockets=1,dies=1,\
+         *              clusters=1,cores=1,threads=1,maxcpus=0
+         */
+        .config = SMP_CONFIG_WITH_FULL_TOPO(1, 1, 1, 1, 1, 1, 1, 1, 0),
+        .expect_error = "Invalid CPU topology: CPU topology parameters must "
+                        "be greater than zero",
+    },
+};
+
 static char *smp_config_to_string(const SMPConfiguration *config)
 {
     return g_strdup_printf(
@@ -1173,6 +1258,13 @@ static void test_full_topo(const void *opaque)
         smp_parse_test(ms, &data, false);
     }
 
+    for (i = 0; i < ARRAY_SIZE(data_zero_topo_invalid); i++) {
+        data = data_zero_topo_invalid[i];
+        unsupported_params_init(mc, &data);
+
+        smp_parse_test(ms, &data, false);
+    }
+
     object_unref(obj);
 }
 
-- 
2.34.1


