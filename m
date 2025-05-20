Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C751FC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLCi-0000CS-QR; Tue, 20 May 2025 07:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLCc-0008QN-Al
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:10 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLCa-0001Kp-GC
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:10 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id B8ECC2068320;
 Tue, 20 May 2025 04:31:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8ECC2068320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740716;
 bh=+C8oPQWTbM0TkBZdInbt0LFkfJTPQQwK8XvexWWBHbc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Tg6KKQX0P2qLTIyAqp5kPw4sYwbu1rzw2+h8Xxn64H5vV+IRF3eQf5VQvIGrnlJur
 J5zvXzWV3KinrvLhHP/vSXt1JOZhE/xOXVFrurjYKo1OkJJPRpg6aMyAREBxaDnSoy
 pHvHtx64Ui0B6Wme8TRHs53+lT4pYxJjhiZXneiM=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 14/25] target/i386/mshv: Add CPU create and remove logic
Date: Tue, 20 May 2025 13:30:07 +0200
Message-Id: <20250520113018.49569-15-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Implement MSHV-specific hooks for vCPU creation and teardown in the
i386 target. A list of locks per vCPU is maintained to lock CPU state in
MMIO operations.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 61 +++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index c4b2c297e2..0ba1dacaed 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -14,6 +14,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
+#include "qemu/lockable.h"
 #include "qemu/error-report.h"
 #include "qemu/typedefs.h"
 
@@ -30,6 +32,36 @@
 #include "trace-accel_mshv.h"
 #include "trace.h"
 
+#include <sys/ioctl.h>
+
+static QemuMutex *cpu_guards_lock;
+static GHashTable *cpu_guards;
+
+static void add_cpu_guard(int cpu_fd)
+{
+    QemuMutex *guard;
+
+    WITH_QEMU_LOCK_GUARD(cpu_guards_lock) {
+        guard = g_new0(QemuMutex, 1);
+        qemu_mutex_init(guard);
+        g_hash_table_insert(cpu_guards, GUINT_TO_POINTER(cpu_fd), guard);
+    }
+}
+
+static void remove_cpu_guard(int cpu_fd)
+{
+    QemuMutex *guard;
+
+    WITH_QEMU_LOCK_GUARD(cpu_guards_lock) {
+        guard = g_hash_table_lookup(cpu_guards, GUINT_TO_POINTER(cpu_fd));
+        if (guard) {
+            qemu_mutex_destroy(guard);
+            g_free(guard);
+            g_hash_table_remove(cpu_guards, GUINT_TO_POINTER(cpu_fd));
+        }
+    }
+}
+
 int mshv_store_regs(CPUState *cpu)
 {
 	error_report("unimplemented");
@@ -62,20 +94,37 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 
 void mshv_remove_vcpu(int vm_fd, int cpu_fd)
 {
-	error_report("unimplemented");
-	abort();
+    /*
+     * TODO: don't we have to perform an ioctl to remove the vcpu?
+     * there is WHvDeleteVirtualProcessor in the WHV api
+     */
+    remove_cpu_guard(cpu_fd);
 }
 
+
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
 {
-	error_report("unimplemented");
-	abort();
+    int ret;
+    struct mshv_create_vp vp_arg = {
+        .vp_index = vp_index,
+    };
+    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
+    if (ret < 0) {
+        error_report("failed to create mshv vcpu: %s", strerror(errno));
+        return -1;
+    }
+
+    add_cpu_guard(ret);
+    *cpu_fd = ret;
+
+    return 0;
 }
 
 void mshv_init_cpu_logic(void)
 {
-	error_report("unimplemented");
-	abort();
+    cpu_guards_lock = g_new0(QemuMutex, 1);
+    qemu_mutex_init(cpu_guards_lock);
+    cpu_guards = g_hash_table_new(g_direct_hash, g_direct_equal);
 }
 
 void mshv_arch_init_vcpu(CPUState *cpu)
-- 
2.34.1


