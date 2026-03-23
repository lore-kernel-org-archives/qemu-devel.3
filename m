Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A62F46124
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4frC-0001pF-KR; Mon, 23 Mar 2026 10:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fp4-0000jS-Gc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:05 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fp0-00072n-Oo
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 10:00:00 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 263DA20B6F21;
 Mon, 23 Mar 2026 06:59:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 263DA20B6F21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274388;
 bh=z5pOF/uzO+7evYgTyZgR0PS2QiZuE42WF+kRFN/Qu/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MQP4it7X9kjqgaHAjWwpRdEqThg3YMJoToaoQvka51y29N8Ugk20eIlhJC5YTwPIM
 bxHknKSLeeuYASMTxJ1IgWzKolt5GcpPcNmBBgaTDQbGAfckyodyuJytvoBtHziXvn
 wbTt6GXiLKzkF9TPxqm1MJpyyEZXat0HH774cp/g=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 24/32] accel/mshv: introduce SaveVMHandler
Date: Mon, 23 Mar 2026 14:58:04 +0100
Message-Id: <20260323135812.383509-25-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
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

This mechanism is used to handle more imperative partition-wide steps
that have to be taken as part of a migration routine.

Currently it's a skeleton that will just pause/resume the partition as
part of a migration. It will later be extended with more specific steps
like reference time and hypercall pages.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/mshv-all.c | 75 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index d1bf148bb8..365288b901 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -39,6 +39,8 @@
 #include "system/mshv.h"
 #include "system/mshv_int.h"
 #include "system/reset.h"
+#include "migration/qemu-file-types.h"
+#include "migration/register.h"
 #include "trace.h"
 #include <err.h>
 #include <sys/ioctl.h>
@@ -47,6 +49,9 @@ bool mshv_allowed;
 
 MshvState *mshv_state;
 
+static int pause_vm(int vm_fd);
+static int resume_vm(int vm_fd);
+
 static int init_mshv(int *mshv_fd)
 {
     int fd = open("/dev/mshv", O_RDWR | O_CLOEXEC);
@@ -80,6 +85,64 @@ static int set_time_freeze(int vm_fd, int freeze)
     return 0;
 }
 
+static void mshv_save_state(QEMUFile *f, void *opaque)
+{
+    return;
+}
+
+static int mshv_load_state(QEMUFile *f, void *opaque, int version_id)
+{
+    return 0;
+}
+
+static int mshv_save_prepare(void *opaque, Error **errp)
+{
+    MshvState *s = opaque;
+    int ret;
+
+    ret = pause_vm(s->vm);
+    if (ret < 0) {
+        error_setg(errp, "Failed to pause VM for migration");
+        return -1;
+    }
+
+    return 0;
+}
+
+static void mshv_save_cleanup(void *opaque)
+{
+    MshvState *s = opaque;
+    int ret;
+
+    ret = resume_vm(s->vm);
+    if (ret < 0) {
+        error_report("Failed to resme VM after  migration");
+    }
+}
+
+static int mshv_load_setup(QEMUFile *f, void *opaque, Error **errp)
+{
+    MshvState *s = opaque;
+    int ret;
+
+    ret = pause_vm(s->vm);
+    if (ret < 0) {
+        error_setg(errp, "Failed to pause VM for migration restore");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int mshv_load_cleanup(void *opaque)
+{
+    MshvState *s = opaque;
+
+    resume_vm(s->vm);
+
+    return 0;
+}
+
 static int pause_vm(int vm_fd)
 {
     int ret;
@@ -454,6 +517,15 @@ static int mshv_init_vcpu(CPUState *cpu)
     return 0;
 }
 
+static SaveVMHandlers savevm_mshv = {
+    .save_prepare = mshv_save_prepare,
+    .save_state = mshv_save_state,
+    .save_cleanup = mshv_save_cleanup,
+    .load_setup = mshv_load_setup,
+    .load_state = mshv_load_state,
+    .load_cleanup = mshv_load_cleanup,
+};
+
 static int mshv_init(AccelState *as, MachineState *ms)
 {
     MshvState *s;
@@ -509,6 +581,9 @@ static int mshv_init(AccelState *as, MachineState *ms)
                                   0, "mshv-memory");
     memory_listener_register(&mshv_io_listener, &address_space_io);
 
+    /* register custom handlers for migration events */
+    register_savevm_live("mshv", 0, 1, &savevm_mshv, s);
+
     return 0;
 }
 
-- 
2.34.1


