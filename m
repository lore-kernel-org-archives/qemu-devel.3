Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDDBC54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 15:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ricT3-000149-H0; Fri, 08 Mar 2024 10:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricT1-00013e-5v
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:49:03 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1ricSz-000449-BL
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 10:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709912942; x=1741448942;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vf3I/tff1LAPx6iIpRAFiHDNzjYLXmXU3Gy0u0/iRyo=;
 b=SJOwVm7ldEGH+UZm/m+jyDHfYgfQ7kG1y1HFpXZVMP5NWEhw0uGPR3L6
 OcfsevGCbFrRgx1Xi00VHXS1PSfJXQRhmZyUtsygUFnOe46Nhmda/Eqyh
 WCwTEoZgEPLvbOstMYRdGY/GadIvtSSD7P97M1U69xYv0cUvgR61Tal+Z
 3RGlzgQ9RFTC3uMbKIIBIXuntNmGk8vSzdmXAMpRhWjoRYaA5lqw+2Ypk
 IMmlYil+XfJPT8bDv65YKwZ0sacHOi14aghYTJAaKT1nj542faNkHRxVg
 L3EgEl8x1jfMldw18AG/sphe7m0mj2mp4CukL/A1orI4irgfNYo8jzBDZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4561128"
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; 
   d="scan'208";a="4561128"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2024 07:48:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,110,1708416000"; d="scan'208";a="10400367"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 08 Mar 2024 07:48:47 -0800
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
Subject: [PATCH v2 13/13] tests/unit/test-smp-parse: Test "parameter=0" SMP
 configurations
Date: Sat,  9 Mar 2024 00:01:48 +0800
Message-Id: <20240308160148.3130837-14-zhao1.liu@linux.intel.com>
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

The support for "parameter=0" SMP configurations is removed, and QEMU
returns error for those cases.

So add the related test cases to ensure parameters can't accept 0.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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


