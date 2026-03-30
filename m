Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FC9FF493A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 05:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w74nZ-0008Uc-8Q; Mon, 30 Mar 2026 01:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w74nP-0008UJ-Jp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:04:15 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w74nM-0000tk-Ko
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 01:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774847052; x=1806383052;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uB5hZL02kf+UCJUlzQM8BF3GydpZBlRmoe2BMjmxlsI=;
 b=AvA+SGUNiffDcaJqVpHGFucYLJ+d7hMNjthYVnciL7jwtAog42mh2N6D
 t/nkAGo9UF6q1GJYNhG8NJ87JsjUGtx+LSSPEErCd+W5f71GQOH1EVVPL
 A8/r0onSysjqsbNoI7HC+B+7wnSTG8eL4sEL4S6XlJu6LLJVJcs5gndBL
 sZZXRBugtcKGGZFGY80p0hFSC5MeVLmmq86I0g83LBx9pj5CkB1Ys28hW
 SzvrSi64Nyvj8RrB9nZYsnx69Gf1KJi5AStCqZOP6eE0OfQWtxyrPnur5
 pRYk0NUYlOc5V49nLFUjipdjI167Z8wf4AEG5u7dBJ/5azrQpynqbkMSD Q==;
X-CSE-ConnectionGUID: s94FMtI9SRGDCEIEytoW1A==
X-CSE-MsgGUID: /AoxKB54QNS23MT6IcB2qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="93410530"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="93410530"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 22:04:06 -0700
X-CSE-ConnectionGUID: SUP2hOa6Q2aQQouqXL9Eog==
X-CSE-MsgGUID: 23G4wYxrS96onc0sYqKpjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="221547545"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 29 Mar 2026 22:04:04 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=83?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH for v11.0] hw/acpi: Do not save/load cpuhp state
 unconditionally
Date: Mon, 30 Mar 2026 13:30:08 +0800
Message-Id: <20260330053008.2721532-1-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

Commit 7aa563630b6b ("pc: Start with modern CPU hotplug interface
by default") removed the .needed callback (vmstate_test_use_cpuhp)
from vmstate_cpuhp_state in both piix4.c and ich9.c.

However, PIIX4 is also used by non-PC boards - MIPS Malta, which does
not select CONFIG_ACPI_CPU_HOTPLUG. For MIPS Malta, the linker resolves
vmstate_cpu_hotplug to the stub one in acpi-cpu-hotplug-stub.c, which is
a zero-initialized VMStateDescription with .fields == NULL.

Before commit 7aa563630b6b, .needed() of PIIX4's vmstate_cpuhp_state
returned false for MIPS Malta since PIIX4PMState always initialized the
field cpu_hotplug_legacy as true. Malta implicitly relies on this
initial value to bypass vmstate_cpuhp_state. However, this is unstable
because Malta itself does not support CPU hotplugging, whether via the
legacy way or the modern way.

Commit 7aa563630b6b removed .needed() check for vmstate_cpuhp_state,
this broke the existing dependency that Malta had relied on, forcing
Malta to save and load vmstate_cpuhp_state during the save/load process,
which in turn caused a segmentation fault due to NULL fields in the
stub-compiled code.

Fix this by bringing back the .needed = cpuhp_needed callback for
vmstate_cpuhp_state of PIIX4, that checks
MachineClass::has_hotpluggable_cpus. Boards that do not support CPU
hotplug (only MIPS Malta) will skip this subsection entirely, which
is both correct and consistent with the previous behavior.

At the same time, add a similar .needed() check to ICH9. Although no
boards with ICH9 are affected by this issue, this helps avoid potential
issues in the future.

Reproducer (MIPS Malta):
  $ qemu-img create -f qcow2 dummy.qcow2 32M
  $ qemu-system-mipsel -nographic \
      -drive if=none,format=qcow2,file=dummy.qcow2
  [Type "C-a c" to get the "(qemu)" monitor prompt)]
  (qemu) savevm foo    # segfault

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 7aa563630b6b ("pc: Start with modern CPU hotplug interface by default")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Tested with the following cases:
 * savevm for MIPS Malta
 * i386 migration:
   pc v10.2 (before 7aa563) <-> pc v10.2 (with this fix)
   q35 v10.2 (before 7aa563) <-> q35 v10.2 (with this fix)
   pc v10.2 (w/o this fix) <-> pc v10.2 (with this fix)
   q35 v10.2 (w/o this fix) <-> q35 v10.2 (with this fix)
   pc v11.0 (w/o this fix) <-> pc v11.0 (with this fix)
   q35 v11.0 (w/o this fix) <-> q35 v11.0 (with this fix)
---
 hw/acpi/ich9.c  | 8 ++++++++
 hw/acpi/piix4.c | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index bbb1bd60a206..5c7dfb2c69db 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -184,10 +184,18 @@ static const VMStateDescription vmstate_tco_io_state = {
     }
 };
 
+static bool cpuhp_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return mc->has_hotpluggable_cpus;
+}
+
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "ich9_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = cpuhp_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 43860d122780..9b7f50c7afac 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -195,10 +195,18 @@ static const VMStateDescription vmstate_memhp_state = {
     }
 };
 
+static bool cpuhp_needed(void *opaque)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+
+    return mc->has_hotpluggable_cpus;
+}
+
 static const VMStateDescription vmstate_cpuhp_state = {
     .name = "piix4_pm/cpuhp",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = cpuhp_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, PIIX4PMState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


