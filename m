Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B950ACE8D4C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA9h-00017n-FN; Thu, 19 Sep 2024 01:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA96-00066M-9u; Thu, 19 Sep 2024 01:56:07 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA91-0007Mt-RH; Thu, 19 Sep 2024 01:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725360; x=1758261360;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CwVrpvp1WDScgEYLWjHPu+YgDBg0b3NbDgIP9DAGUe8=;
 b=beRd1qGqvdk9X6315+XZAJjWw5uRzK8JCzzNoGAFMTesyTDLRdFQvqQc
 QlaVsXOHS1fU6WDuRk1ON8aRZe6XZwzWdUIDGo3tphFR1ei7wFJ5ACLW5
 ISipIWb0/DNwfE0O6BDEBXXMliTLcDeRjNcZo9xxZ81yzUHgtmBsbbVks
 i9AyqHtlaXlxnihO7S4aPeuFuxuqytl3A4mBmQn5A4exstncbNmiER0dR
 8hHSI7L51IaZOGfbyMAT/1FUq/uqKdQyFrATT0isB9Sq912As4f6Ww1G0
 ULmFpm6T7j+VSpBH5vhVIUzofpsL6nDinj0elCNpKLmFkx0kl6iJfNYzY A==;
X-CSE-ConnectionGUID: WrzRQWdiT0WKDsz0+NL1oA==
X-CSE-MsgGUID: yx4M9gbjRyGYQB/ejwZHqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813515"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813515"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:55:49 -0700
X-CSE-ConnectionGUID: cnG4W7PSTWykvtbW1B+1LQ==
X-CSE-MsgGUID: X7u2e1dAQ1u80SUmmx+ZsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418644"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:55:43 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC v2 03/12] system/vl: Create CPU topology devices from CLI early
Date: Thu, 19 Sep 2024 14:11:19 +0800
Message-Id: <20240919061128.769139-4-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919061128.769139-1-zhao1.liu@intel.com>
References: <20240919061128.769139-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Custom topology will allow user to build CPU topology from CLI totally,
and this replaces machine's default CPU creation process (*_init_cpus()
in MachineClass.init()).

For the machine's initialization, there may be CPU dependencies in the
remaining initialization after the CPU creation.

To address such dependencies, create the CPU topology device (including
CPU devices) from the CLI earlier, so that the latter part of machine
initialization can be separated after qemu_add_cli_devices_early().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 system/vl.c | 55 +++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index c40364e2f091..8540454aa1c2 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1211,8 +1211,9 @@ static int device_help_func(void *opaque, QemuOpts *opts, Error **errp)
 static int device_init_func(void *opaque, QemuOpts *opts, Error **errp)
 {
     DeviceState *dev;
+    long *category = opaque;
 
-    dev = qdev_device_add(opts, NULL, errp);
+    dev = qdev_device_add(opts, category, errp);
     if (!dev && *errp) {
         error_report_err(*errp);
         return -1;
@@ -2623,6 +2624,36 @@ static void qemu_init_displays(void)
     }
 }
 
+static void qemu_add_devices(long *category)
+{
+    DeviceOption *opt;
+
+    qemu_opts_foreach(qemu_find_opts("device"),
+                      device_init_func, category, &error_fatal);
+    QTAILQ_FOREACH(opt, &device_opts, next) {
+        DeviceState *dev;
+        loc_push_restore(&opt->loc);
+        /*
+         * TODO Eventually we should call qmp_device_add() here to make sure it
+         * behaves the same, but QMP still has to accept incorrectly typed
+         * options until libvirt is fixed and we want to be strict on the CLI
+         * from the start, so call qdev_device_add_from_qdict() directly for
+         * now.
+         */
+        dev = qdev_device_add_from_qdict(opt->opts, category,
+                                         true, &error_fatal);
+        object_unref(OBJECT(dev));
+        loc_pop(&opt->loc);
+    }
+}
+
+static void qemu_add_cli_devices_early(void)
+{
+    long category = DEVICE_CATEGORY_CPU_DEF;
+
+    qemu_add_devices(&category);
+}
+
 static void qemu_init_board(void)
 {
     /* process plugin before CPUs are created, but once -smp has been parsed */
@@ -2631,6 +2662,9 @@ static void qemu_init_board(void)
     /* From here on we enter MACHINE_PHASE_INITIALIZED.  */
     machine_run_board_init(current_machine, mem_path, &error_fatal);
 
+    /* Create CPU topology device if any. */
+    qemu_add_cli_devices_early();
+
     drive_check_orphaned();
 
     realtime_init();
@@ -2638,8 +2672,6 @@ static void qemu_init_board(void)
 
 static void qemu_create_cli_devices(void)
 {
-    DeviceOption *opt;
-
     soundhw_init();
 
     qemu_opts_foreach(qemu_find_opts("fw_cfg"),
@@ -2653,22 +2685,7 @@ static void qemu_create_cli_devices(void)
 
     /* init generic devices */
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
-    qemu_opts_foreach(qemu_find_opts("device"),
-                      device_init_func, NULL, &error_fatal);
-    QTAILQ_FOREACH(opt, &device_opts, next) {
-        DeviceState *dev;
-        loc_push_restore(&opt->loc);
-        /*
-         * TODO Eventually we should call qmp_device_add() here to make sure it
-         * behaves the same, but QMP still has to accept incorrectly typed
-         * options until libvirt is fixed and we want to be strict on the CLI
-         * from the start, so call qdev_device_add_from_qdict() directly for
-         * now.
-         */
-        dev = qdev_device_add_from_qdict(opt->opts, NULL, true, &error_fatal);
-        object_unref(OBJECT(dev));
-        loc_pop(&opt->loc);
-    }
+    qemu_add_devices(NULL);
     rom_reset_order_override();
 }
 
-- 
2.34.1


