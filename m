Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31FAF4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgti-00031q-EA; Fri, 17 Apr 2026 06:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDgta-0002iC-8H
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:58:00 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDgtY-0001hl-Gk
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:57:57 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de
 [80.134.214.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 065BB20B712B;
 Fri, 17 Apr 2026 03:57:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 065BB20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776423465;
 bh=hkvpr9QCwBz+aAxOE4MLQ16OiKG8v7Bh8aJx066T5TY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y1uj1HM/fKCyvdDoBgRqm5KPgSqUuCU5IBK7lkT0ODgu807lNDX4HLDygbCnYLJ7U
 LNCehxjd6mjE9oJNou5fw3IscyspowhJVKcM23Hxz2UCQNs2jm59OOOpcg9TTEy8AI
 dzp0uVO9TpyAgcnx/BVb09RJYia4Kaa96VypdLI4=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 22/34] target/i386/mshv: migrate Synic SINT MSRs
Date: Fri, 17 Apr 2026 12:56:06 +0200
Message-Id: <20260417105618.3621-23-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Migrate HyperV SynIC SINT MSRs. We can only read/write those if SCONTROL
is enabled in the guest, hence we have to split the SINT MSR out and
make reading/writing them dependent on that MSR.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/msr.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
index b26375e4c2..4881e15f4b 100644
--- a/target/i386/mshv/msr.c
+++ b/target/i386/mshv/msr.c
@@ -303,6 +303,8 @@ int mshv_get_msrs(CPUState *cpu)
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     size_t i, j;
     uint32_t name;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    bool synic_enabled;
 
     set_hv_name_in_assocs(assocs, n_assocs);
 
@@ -329,6 +331,27 @@ int mshv_get_msrs(CPUState *cpu)
 
     store_in_env(cpu, assocs, n_assocs);
 
+    /* Read SINT MSRs only if SynIC is enabled */
+    synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
+    if (synic_enabled) {
+        QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            assocs[i].name = HV_REGISTER_SINT0 + i;
+        }
+
+        ret = mshv_get_generic_regs(cpu, assocs, HV_SINT_COUNT);
+        if (ret < 0) {
+            error_report("Failed to get SynIC SINT MSRs");
+            return -errno;
+        }
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            uint64_t hv_sint_value = assocs[i].value.reg64;
+            x86cpu->env.msr_hv_synic_sint[i] = hv_sint_value;
+        }
+    }
+
     return 0;
 }
 
@@ -363,6 +386,8 @@ int mshv_set_msrs(const CPUState *cpu)
     struct hv_register_assoc assocs[MSHV_MSR_TOTAL_COUNT];
     int ret;
     size_t i, j;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    bool synic_enabled = x86cpu->env.msr_hv_synic_control & 1;
 
     load_from_env(cpu, assocs, n_assocs);
 
@@ -395,5 +420,21 @@ int mshv_set_msrs(const CPUState *cpu)
         return -errno;
     }
 
+    /* SINT MSRs can only be written if SCONTROL has been set, so we split */
+    if (synic_enabled) {
+        QEMU_BUILD_BUG_ON(MSHV_MSR_TOTAL_COUNT < HV_SINT_COUNT);
+
+        for (i = 0; i < HV_SINT_COUNT; i++) {
+            assocs[i].name        = HV_REGISTER_SINT0 + i;
+            assocs[i].value.reg64 = x86cpu->env.msr_hv_synic_sint[i];
+        }
+
+        ret = mshv_set_generic_regs(cpu, assocs, HV_SINT_COUNT);
+        if (ret < 0) {
+            error_report("Failed to set SynIC SINT MSRs");
+            return -errno;
+        }
+    }
+
     return 0;
 }
-- 
2.34.1


