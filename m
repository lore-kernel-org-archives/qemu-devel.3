Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2FBCE8D49
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 05:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srA9g-0000yt-Dc; Thu, 19 Sep 2024 01:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA97-0006An-E1; Thu, 19 Sep 2024 01:56:10 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srA94-0007Mx-5r; Thu, 19 Sep 2024 01:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726725362; x=1758261362;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T5fYW0Qp5HK4dCgA8zTvCnqjoH/YS2wAEp4x5hqFcPU=;
 b=AgIUn0wAOmyWH5nd+5LYF06Ul+SQb8qqvtyp//P6flDeTDou7al/BY7O
 HS1rTvC4kau7YzUiqRkGXLhQudBVpbhvGJ4NbIw0poN1hJp/fzx3w4HkF
 ccFHma0oWfKIm3tqgTgbyf7LwdzZ/BFKpG+/uJ7Oa+7Pe5l8fqmp5VvJf
 EDSy5/xDAWEPw/pTO0gDs8Q0azw9M3oUurbp96XSjauI0+juWNEk8Modb
 EkxsqjmM5nkiy9YURvm4ER2SRW7ZXuij/AwsyRaJ+SDBrj5yomIv36luZ
 Cz+HTCKriBEQA0b2bUr+vT506YGBv0+VYQT3+Dq9MDH+bVrqfSMr2OHEl w==;
X-CSE-ConnectionGUID: 1D8MgndRRIyk482ALta/6Q==
X-CSE-MsgGUID: SwImmHm/QMSyfeMLYr4Amw==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25813539"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="25813539"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2024 22:55:55 -0700
X-CSE-ConnectionGUID: izHbtgFiQeKuhayuq/BgHg==
X-CSE-MsgGUID: 8GpqZCUxQfG5uQ4iHEKGyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; d="scan'208";a="69418665"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2024 22:55:49 -0700
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
Subject: [RFC v2 04/12] hw/core/machine: Split machine initialization around
 qemu_add_cli_devices_early()
Date: Thu, 19 Sep 2024 14:11:20 +0800
Message-Id: <20240919061128.769139-5-zhao1.liu@intel.com>
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

Split machine initialization and machine_run_board_init() into two parts
around qemu_add_cli_devices_early(), allowing initialization to continue
after the CPU creation from the CLI.

This enables machine to place the initialization steps with CPU
dependencies in post_init().

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/core/machine.c   | 10 ++++++++++
 include/hw/boards.h |  2 ++
 system/vl.c         |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 076bd365197b..7b4ac5ac52b2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1645,6 +1645,16 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
 
     accel_init_interfaces(ACCEL_GET_CLASS(machine->accelerator));
     machine_class->init(machine);
+}
+
+void machine_run_board_post_init(MachineState *machine, Error **errp)
+{
+    MachineClass *machine_class = MACHINE_GET_CLASS(machine);
+
+    if (machine_class->post_init) {
+        machine_class->post_init(machine);
+    }
+
     phase_advance(PHASE_MACHINE_INITIALIZED);
 }
 
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a49677466ef6..9f706223e848 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -33,6 +33,7 @@ const char *machine_class_default_cpu_type(MachineClass *mc);
 
 void machine_add_audiodev_property(MachineClass *mc);
 void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp);
+void machine_run_board_post_init(MachineState *machine, Error **errp);
 bool machine_usb(MachineState *machine);
 int machine_phandle_start(MachineState *machine);
 bool machine_dump_guest_core(MachineState *machine);
@@ -271,6 +272,7 @@ struct MachineClass {
     const char *deprecation_reason;
 
     void (*init)(MachineState *state);
+    void (*post_init)(MachineState *state);
     void (*reset)(MachineState *state, ShutdownCause reason);
     void (*wakeup)(MachineState *state);
     int (*kvm_type)(MachineState *machine, const char *arg);
diff --git a/system/vl.c b/system/vl.c
index 8540454aa1c2..00370f7a52aa 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2659,12 +2659,14 @@ static void qemu_init_board(void)
     /* process plugin before CPUs are created, but once -smp has been parsed */
     qemu_plugin_load_list(&plugin_list, &error_fatal);
 
-    /* From here on we enter MACHINE_PHASE_INITIALIZED.  */
     machine_run_board_init(current_machine, mem_path, &error_fatal);
 
     /* Create CPU topology device if any. */
     qemu_add_cli_devices_early();
 
+    /* From here on we enter MACHINE_PHASE_INITIALIZED.  */
+    machine_run_board_post_init(current_machine, &error_fatal);
+
     drive_check_orphaned();
 
     realtime_init();
-- 
2.34.1


