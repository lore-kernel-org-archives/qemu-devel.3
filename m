Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09485ECD6C5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:07:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCkc-0002pR-Iu; Wed, 11 Feb 2026 11:07:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1vqCXy-0007Kt-8f
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:34 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1vqCXw-0003Rj-Ri
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:54:34 -0500
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.59])
 by linux.microsoft.com (Postfix) with ESMTPSA id 1481520B7167;
 Wed, 11 Feb 2026 07:54:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1481520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1770825271;
 bh=WUeXzduWbvpr7w6Oai6mxm+22K0giCeVW4RrYBu0a1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gwyrdKh8U3uPK5lxUJjuZWZazScYSrGEmoxY6OHr0lcVRGBFsTMCzEg7lWRf63NFP
 E3tp+AAeROpi8XrEnJBGeRheNCZ0Xq28BR3hOy208iaFKjMUDY43+d/ZlsJJJ0RhAD
 oVrq+7k53ttqpkfQgtBvTUgqaiCc2c48osRFlGUE=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH 07/10] target/i386/mshv: set cpu model name on -cpu host
Date: Wed, 11 Feb 2026 16:54:07 +0100
Message-Id: <20260211155410.203883-8-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
References: <20260211155410.203883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Feb 2026 11:07:32 -0500
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

By registering a cpu_accel_class for mshv, we can report an accurate
model name on -cpu host.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index b862a7ff6a..38e0a045c2 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -24,10 +24,13 @@
 #include "hw/i386/apic_internal.h"
 
 #include "cpu.h"
+#include "host-cpu.h"
 #include "emulate/x86_decode.h"
 #include "emulate/x86_emu.h"
 #include "emulate/x86_flags.h"
 
+#include "accel/accel-cpu-target.h"
+
 #include "trace-accel_mshv.h"
 #include "trace.h"
 
@@ -1793,3 +1796,31 @@ int mshv_arch_post_init_vm(int vm_fd)
 
     return ret;
 }
+
+static void mshv_cpu_instance_init(CPUState *cs)
+{
+    X86CPU *cpu = X86_CPU(cs);
+
+    host_cpu_instance_init(cpu);
+}
+
+static void mshv_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_instance_init = mshv_cpu_instance_init;
+}
+
+static const TypeInfo mshv_cpu_accel_type_info = {
+    .name = ACCEL_CPU_NAME("mshv"),
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = mshv_cpu_accel_class_init,
+    .abstract = true,
+};
+
+static void mshv_cpu_accel_register_types(void)
+{
+    type_register_static(&mshv_cpu_accel_type_info);
+}
+
+type_init(mshv_cpu_accel_register_types);
-- 
2.34.1


