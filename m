Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F71062868
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Hqh-0006ix-Cc; Wed, 11 Mar 2026 07:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w0Hqf-0006iH-RT
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:35:33 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w0Hqe-0006GZ-9P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 07:35:33 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.53])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8422820B7128;
 Wed, 11 Mar 2026 04:35:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8422820B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1773228931;
 bh=VQhmCCz13ebRrgK1mip1yFxADBIv5/zsub4TZBKPLKM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YRRc/bpNT8qe5iZ0Uqyy+BONpFOB46UaLMWcWOnvqKGKQUC28yQhLaWeuMODDvLzi
 R4xQ+O+plvFpdEnPARzWQegj0JML4vAMmJ+Lo3lHyy7Gh18fgTjQP22quLfQmcE4Qz
 x1K//d8OX6oVnAidIk9X5cttAvtL2uZRwas8E2/s=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v2 7/9] target/i386/mshv: populate xsave area offsets
Date: Wed, 11 Mar 2026 12:35:03 +0100
Message-Id: <20260311113505.1177878-8-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


