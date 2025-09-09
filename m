Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B7BCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvxwA-0006KK-Py; Tue, 09 Sep 2025 08:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uvv1f-00009X-Oj; Tue, 09 Sep 2025 05:52:35 -0400
Received: from [115.124.30.97] (helo=out30-97.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uvv1W-00033s-8L; Tue, 09 Sep 2025 05:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1757411533; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=gdxCOjTq347NYfqTOrM1YGY3YxJeDGJ5zmIf4NPc2rs=;
 b=bUve2suO6Cy8qnaVC+NpZ4FLIuI9+Nr70tWRLdfTIrrJM7z6muXA9q0ZQPt9LRxqS8O+IwLIzFw4JqHoaw5yTYGfHjc3se6zMGpFoDVYDTp4w5e4bGofxt3f1U7KzrnRTEo0iEvL1Fbz9mICNJw/hkKqq6bU4LOSPda7wpH6/hs=
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0WndQHtm_1757411217 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 09 Sep 2025 17:46:57 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Tue, 09 Sep 2025 17:46:45 +0800
Subject: [PATCH 2/3] hw/intc: Save timers array in RISC-V mtimer VMState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-timers-v1-2-7ee18a9d8f4b@linux.alibaba.com>
References: <20250909-timers-v1-0-7ee18a9d8f4b@linux.alibaba.com>
In-Reply-To: <20250909-timers-v1-0-7ee18a9d8f4b@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757411216; l=4232;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=stR2NZygkLJHgnxSDo9w+i+TRSVf5TH1xDTP10RPuHA=;
 b=JFc73tNYBTpBjyajsP0cWALr7sOF8RviNQUao6vIXxzbwdAFnggzniHePgPI6jxapLa2pxNqu
 8yp48RCuERNDN4igWjPF5amTq0vSnVdSFPDXj/edLIIEkzAgCgEgnqT
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.97 (deferred)
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=lyndra@linux.alibaba.com; helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 08:58:43 -0400
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

The current 'timecmp' field in vmstate_riscv_mtimer is insufficient to keep
timers functional after migration.

If an mtimer's entry in 'mtimer->timers' is active at the time the snapshot
is taken, it means riscv_aclint_mtimer_write_timecmp() has written to
'mtimecmp' and scheduled a timer into QEMU's main loop 'timer_list'.

During snapshot save, these active timers must also be migrated; otherwise,
after snapshot load there is no mechanism to restore 'mtimer->timers' back
into the 'timer_list', and any pending timer events would be lost.

QEMU's migration framework commonly uses VMSTATE_TIMER_xxx macros to save
and restore 'QEMUTimer' variables. However, 'timers' is a pointer array
with variable length, and vmstate.h did not previously provide a helper
macro for such type.

This commit adds a new macro, 'VMSTATE_TIMER_PTR_VARRAY', to handle saving
and restoring a variable-length array of 'QEMUTimer *'. We then use this
macro to migrate the 'mtimer->timers' array, ensuring that timer events
remain scheduled correctly after snapshot load.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 hw/intc/riscv_aclint.c      |  6 ++++--
 include/migration/vmstate.h | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 318a9c8248432a8cd4c3f3fa990739917ecf7ca1..9f4c36e965e2aa379d75c0a9f656177f0dd82a45 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -323,13 +323,15 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_riscv_mtimer = {
     .name = "riscv_mtimer",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
             VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
                                   num_harts, 0,
                                   vmstate_info_uint64, uint64_t),
+            VMSTATE_TIMER_PTR_VARRAY(timers, RISCVAclintMTimerState,
+                                     num_harts),
             VMSTATE_END_OF_LIST()
         }
 };
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1ff7bd9ac425ba67cd5ca7ad97bcf570f9e19abe..255e403e5a103188712425d95a719d181e1a7202 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -522,6 +522,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
 }
 
+#define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
+    .name       = (stringify(_field)),                                    \
+    .version_id = (_version),                                             \
+    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t),     \
+    .info       = &(_info),                                               \
+    .size       = sizeof(_type),                                          \
+    .flags      = VMS_VARRAY_UINT32 | VMS_ARRAY_OF_POINTER | VMS_POINTER, \
+    .offset     = vmstate_offset_pointer(_state, _field, _type),          \
+}
+
 #define VMSTATE_STRUCT_SUB_ARRAY(_field, _state, _start, _num, _version, _vmsd, _type) { \
     .name       = (stringify(_field)),                                     \
     .version_id = (_version),                                              \
@@ -1035,6 +1045,10 @@ extern const VMStateInfo vmstate_info_qlist;
 #define VMSTATE_TIMER_PTR_ARRAY(_f, _s, _n)                              \
     VMSTATE_ARRAY_OF_POINTER(_f, _s, _n, 0, vmstate_info_timer, QEMUTimer *)
 
+#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
+VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
+                                                        QEMUTimer *)
+
 #define VMSTATE_TIMER_TEST(_f, _s, _test)                             \
     VMSTATE_SINGLE_TEST(_f, _s, _test, 0, vmstate_info_timer, QEMUTimer)
 

-- 
2.43.0


