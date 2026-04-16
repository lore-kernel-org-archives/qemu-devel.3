Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30372F8A16B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 12:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDLZP-0008Qp-8t; Thu, 16 Apr 2026 08:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDLZM-0008PP-VX
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:11:41 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDLZL-0002Pm-8L
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 08:11:40 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6802720B7128;
 Thu, 16 Apr 2026 05:11:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6802720B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776341498;
 bh=aTVxvEVz5lQHNdZmbaeb9TChVHr9SVG0hmQSZJZieN0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dycYcJk4Yrs5dUJ/9VlczwO+vgC1457H2N8qCB0U9nw0eSLh3qxrB9V/A2cTk0WWC
 ySJruv41vTn9O/ib4RZkewCkNhBsDIUPB8wgaygNWYYE7VFKLjjYw9FHOnpvFJ4OTV
 Ip3edgRWyG6FeefS2E+lh5vyZR7b3VjC8PjiqeLw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>
Subject: [PATCH v6 7/9] target/i386/mshv: populate xsave area offsets
Date: Thu, 16 Apr 2026 14:11:14 +0200
Message-Id: <20260416121116.527927-8-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
References: <20260416121116.527927-1-magnuskulke@linux.microsoft.com>
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

This function is copied verbatim from kvm_cpu_xsave_init(), for MSHV we
need to populate the offsets similarly.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 target/i386/mshv/mshv-cpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 3b392533b4..ee25eb5f6f 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1706,11 +1706,42 @@ int mshv_arch_post_init_vm(int vm_fd)
     return ret;
 }
 
+static void mshv_cpu_xsave_init(void)
+{
+    static bool first = true;
+    uint32_t eax, ebx, ecx, edx;
+    int i;
+
+    if (!first) {
+        return;
+    }
+    first = false;
+
+    /* x87 and SSE states are in the legacy region of the XSAVE area. */
+    x86_ext_save_areas[XSTATE_FP_BIT].offset = 0;
+    x86_ext_save_areas[XSTATE_SSE_BIT].offset = 0;
+
+    for (i = XSTATE_SSE_BIT + 1; i < XSAVE_STATE_AREA_COUNT; i++) {
+        ExtSaveArea *esa = &x86_ext_save_areas[i];
+
+        if (!esa->size) {
+            continue;
+        }
+        host_cpuid(0xd, i, &eax, &ebx, &ecx, &edx);
+        if (eax != 0) {
+            assert(esa->size == eax);
+            esa->offset = ebx;
+            esa->ecx = ecx;
+        }
+    }
+}
+
 static void mshv_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    mshv_cpu_xsave_init();
 }
 
 static void mshv_cpu_accel_class_init(ObjectClass *oc, const void *data)
-- 
2.34.1


