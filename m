Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E32C56201
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZQS-0000mq-Qf; Wed, 05 Aug 2026 07:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <snambakam@linux.microsoft.com>)
 id 1wrZQP-0000kt-VT
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:04:41 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <snambakam@linux.microsoft.com>) id 1wrZQO-0000Da-01
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:04:41 -0400
Received: from fedora.hsd1.wa.comcast.net (unknown [52.148.140.42])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0C6B920B7169;
 Wed,  5 Aug 2026 04:04:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C6B920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1785927858;
 bh=2Lr3z941HXJaQ18Cjd5S16Yzqdy/e1fawMbuefz9a3E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P2C64b5oh8gvtnqw/fn3FIlU9TIcefbqXyc3HB47Dqukunlt6YGQnN9tze9G4q+tT
 8ehEW1bT18v13xqQNwdUi9VWwMJs2Mm6m858EgfEoRbMlW9GS237DV/FTKVGJU/1vR
 rVe6gUUAhvVZfzIUSwWDYNQnWyjIHpVPeBUSMiD0=
From: Sriram Nambakam <snambakam@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org
Subject: [RFC PATCH v1 5/5] target/i386/kvm: read plane config via
 address_space API
Date: Wed,  5 Aug 2026 04:04:32 -0700
Message-ID: <20260805110432.25167-6-snambakam@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805110432.25167-1-snambakam@linux.microsoft.com>
References: <20260805110432.25167-1-snambakam@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=snambakam@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

Match the vm-planes-merged integration result: read the guest
vm_plane_config/calling-area through address_space_read() (with the
address-spaces/memory/thread includes) instead of the
cpu_physical_memory_read() helpers, and pick up the kvm_para.h
whitespace from the header re-sync. This delta originated in the
integration branch's merge-commit conflict resolution.
---
 include/standard-headers/linux/kvm_para.h |  2 +-
 target/i386/kvm/kvm.c                     | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/standard-headers/linux/kvm_para.h b/include/standard-headers/linux/kvm_para.h
index def451c43c..3094d70c8d 100644
--- a/include/standard-headers/linux/kvm_para.h
+++ b/include/standard-headers/linux/kvm_para.h
@@ -27,7 +27,7 @@
 #define KVM_HC_MIPS_EXIT_VM		7
 #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
 #define KVM_HC_CLOCK_PAIRING		9
-#define KVM_HC_SEND_IPI		10
+#define KVM_HC_SEND_IPI			10
 #define KVM_HC_SCHED_YIELD		11
 #define KVM_HC_MAP_GPA_RANGE		12
 #define KVM_HC_VM_PLANES_CONFIG		13
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 5ac7962e61..b8a68a1c56 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -21,6 +21,7 @@
 #include <sys/utsname.h>
 #include <sys/syscall.h>
 #include <sys/resource.h>
+#include <sys/mman.h>
 
 #include <linux/kvm.h>
 #include <linux/kvm_para.h>
@@ -36,6 +37,8 @@
 #include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "system/ramblock.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
 #include "kvm_i386.h"
 #include "../confidential-guest.h"
 #include "sev.h"
@@ -47,6 +50,7 @@
 #include "gdbstub/enums.h"
 #include "qemu/host-utils.h"
 #include "qemu/main-loop.h"
+#include "qemu/thread.h"
 #include "qemu/ratelimit.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -6665,9 +6669,12 @@ static int kvm_handle_hc_vm_planes_config(X86CPU *cpu, struct kvm_run *run)
         int plane_fd;
         unsigned int i;
 
-        cpu_physical_memory_read(plane_gpa + 0,  &load_offset, 8);
-        cpu_physical_memory_read(plane_gpa + 8,  &memory_size, 8);
-        cpu_physical_memory_read(plane_gpa + 16, &entry_point, 8);
+        address_space_read(&address_space_memory, plane_gpa + 0,
+                           MEMTXATTRS_UNSPECIFIED, &load_offset, 8);
+        address_space_read(&address_space_memory, plane_gpa + 8,
+                           MEMTXATTRS_UNSPECIFIED, &memory_size, 8);
+        address_space_read(&address_space_memory, plane_gpa + 16,
+                           MEMTXATTRS_UNSPECIFIED, &entry_point, 8);
 
         /*
          * joergroedel plane model: a plane has exactly one vCPU per
@@ -6685,8 +6692,9 @@ static int kvm_handle_hc_vm_planes_config(X86CPU *cpu, struct kvm_run *run)
         }
 
         memset(cmdline_buf, 0, sizeof(cmdline_buf));
-        cpu_physical_memory_read(plane_gpa + 156, cmdline_buf,
-                                 sizeof(cmdline_buf));
+        address_space_read(&address_space_memory, plane_gpa + 156,
+                           MEMTXATTRS_UNSPECIFIED, cmdline_buf,
+                           sizeof(cmdline_buf));
         cmdline_buf[sizeof(cmdline_buf) - 1] = '\0';
         memcpy(ps->cmdline, cmdline_buf, sizeof(ps->cmdline));
 
@@ -6899,8 +6907,9 @@ static int kvm_handle_hc_vm_planes_activate(X86CPU *cpu, struct kvm_run *run)
             return 0;
         }
 
-        cpu_physical_memory_read(gpa + (plane_id * VM_PLANE_CFG_STRIDE) + 16,
-                                 &entry_point, 8);
+        address_space_read(&address_space_memory,
+                           gpa + (plane_id * VM_PLANE_CFG_STRIDE) + 16,
+                           MEMTXATTRS_UNSPECIFIED, &entry_point, 8);
         if (!entry_point) {
             error_report("vm_planes: plane %" PRIu64 " bad entry_point",
                          plane_id);
-- 
2.55.0


