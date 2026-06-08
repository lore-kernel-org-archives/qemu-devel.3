Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4410CCD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbmz-0001sZ-83; Mon, 08 Jun 2026 11:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1wWbmy-0001s1-3T
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:20 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1wWbmv-0007rk-UF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:19 -0400
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de
 [79.254.29.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 48B7D202945;
 Mon,  8 Jun 2026 17:21:15 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org, marcel.apfelbaum@gmail.com, zhao1.liu@intel.com,
 berrange@redhat.com, mst@redhat.com, cohuck@redhat.com,
 mtosatti@redhat.com, Tom Lendacky <thomas.lendacky@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, coconut-svsm@lists.linux.dev,
 joerg.roedel@amd.com
Subject: [RFC PATCH 04/10] accel: Add nr_planes() op
Date: Mon,  8 Jun 2026 17:21:03 +0200
Message-ID: <20260608152109.356783-5-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Joerg Roedel <joerg.roedel@amd.com>

Add a new accelerator operation to request the highest supported plane
number of a given machine instance.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/accel-system.c      | 13 +++++++++++++
 include/accel/accel-ops.h |  3 +++
 include/qemu/accel.h      |  7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/accel/accel-system.c b/accel/accel-system.c
index 150af05bf5bf..968473b8692a 100644
--- a/accel/accel-system.c
+++ b/accel/accel-system.c
@@ -75,6 +75,19 @@ void accel_pre_resume(MachineState *ms, bool step_pending)
     }
 }
 
+uint8_t accel_nr_planes(MachineState *ms)
+{
+    AccelState *accel = ms->accelerator;
+    AccelClass *acc = ACCEL_GET_CLASS(accel);
+    uint8_t nr_planes = 1;
+
+    if (acc->nr_planes != NULL) {
+        nr_planes = acc->nr_planes(accel, ms);
+    }
+
+    return nr_planes;
+}
+
 /* initialize the arch-independent accel operation interfaces */
 void accel_init_ops_interfaces(AccelClass *ac)
 {
diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
index f46492e3fe15..1d5decb9359b 100644
--- a/include/accel/accel-ops.h
+++ b/include/accel/accel-ops.h
@@ -36,6 +36,9 @@ struct AccelClass {
     bool (*has_memory)(AccelState *accel, AddressSpace *as,
                        hwaddr start_addr, hwaddr size);
 
+    /* planes related hooks */
+    uint8_t (*nr_planes)(AccelState *as, MachineState *ms);
+
     /* gdbstub related hooks */
     int (*gdbstub_supported_sstep_flags)(AccelState *as);
 
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index d3638c7bfda7..2ecf33e1fa21 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -81,4 +81,11 @@ void accel_cpu_common_unrealize(CPUState *cpu);
  */
 int accel_supported_gdbstub_sstep_flags(void);
 
+/**
+ * accel_nr_planes:
+ *
+ * Returns the number of the highest support plane of a given MachineState.
+ */
+uint8_t accel_nr_planes(MachineState *ms);
+
 #endif /* QEMU_ACCEL_H */
-- 
2.53.0


