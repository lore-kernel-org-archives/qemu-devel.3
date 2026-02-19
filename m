Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C453E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt3Ob-0007Nj-Da; Thu, 19 Feb 2026 07:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vt3OK-0007LJ-8Q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:44:26 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vt3OG-0008Bh-Ul
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:44:22 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7946761118;
 Thu, 19 Feb 2026 12:44:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABFCC116C6;
 Thu, 19 Feb 2026 12:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771505059;
 bh=cJg1NgQznUnttznUJrds2RCqpY/0hZTatzOPSK8Mf2Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tz4Pa2MLbMeRFcljC+ETWrA1WcQ1UAJl8zgQbZk6/BJJ8CbtljmQ/B4UWl4fHcH1D
 e/rKb0iQ85AMIwjfKxegunGS4x7hDI2UvPuzjaRIkODQYcQ6vwqIpQtIqWMpobYiqv
 +442Bgxc500MoWLE+d/4v09dSwdWONDA9ADipV5dOMMrQ4A/UvSyH9tAEoz1z1qnvH
 r6MEvR3XSR/I8xgP4J0ONNmUQZUC+3X90NKk0jo9QWyNKfv0xDUqRUZ8QdA2uErcEn
 n77mxIb7kGnQ7Z8IfonLhJMwdjNifsVFdQ4L5Sl6uca1IYKUVXEOQ9aQLiy2cW2Wwr
 sfuP8fhPxU9AQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 4/4] hw/hppa: Add emulation for the 64-bit A400 server
Date: Thu, 19 Feb 2026 13:44:08 +0100
Message-ID: <20260219124408.3515-5-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219124408.3515-1-deller@kernel.org>
References: <20260219124408.3515-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
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

From: Helge Deller <deller@gmx.de>

The A400 machine is the very first 64-bit-only machines which uses the 64-bit
PAT firmware and doesn't support 32-bit PDC any longer.  Long-term goal is to
support the MPE and HP-UX 11iv3 operating systems, which both require a machine
with PAT firmware.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 hw/hppa/machine.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 5ce4a17915..2cf4239a43 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -729,6 +729,14 @@ static void machine_HP_C3700_init(MachineState *machine)
     machine_HP_common_init_tail(machine, pci_bus, translate);
 }
 
+/*
+ * Create HP A400 server
+ */
+static void machine_HP_A400_init(MachineState *machine)
+{
+    machine_HP_C3700_init(machine);
+}
+
 static void hppa_machine_reset(MachineState *ms, ResetType type)
 {
     unsigned int smp_cpus = ms->smp.cpus;
@@ -822,6 +830,22 @@ static void HP_C3700_machine_init_class_init(ObjectClass *oc, const void *data)
     mc->default_ram_size = 1024 * MiB;
 }
 
+static void HP_A400_machine_init_class_init(ObjectClass *oc, const void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        TYPE_HPPA64_CPU,
+        NULL
+    };
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "HP A400-44 workstation";
+    mc->default_cpu_type = TYPE_HPPA64_CPU;
+    mc->valid_cpu_types = valid_cpu_types;
+    mc->init = machine_HP_A400_init;
+    mc->max_cpus = HPPA_MAX_CPUS;
+    mc->default_ram_size = 1024 * MiB;
+}
+
 static void HP_715_machine_init_class_init(ObjectClass *oc, const void *data)
 {
     static const char * const valid_cpu_types[] = {
@@ -860,6 +884,10 @@ static const TypeInfo hppa_machine_types[] = {
         .name = MACHINE_TYPE_NAME("C3700"),
         .parent = TYPE_HPPA_COMMON_MACHINE,
         .class_init = HP_C3700_machine_init_class_init,
+    }, {
+        .name = MACHINE_TYPE_NAME("A400"),
+        .parent = TYPE_HPPA_COMMON_MACHINE,
+        .class_init = HP_A400_machine_init_class_init,
     }, {
         .name = MACHINE_TYPE_NAME("715"),
         .parent = TYPE_HPPA_COMMON_MACHINE,
-- 
2.53.0


