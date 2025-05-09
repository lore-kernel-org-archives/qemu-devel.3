Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CBBC3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 04:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDFHe-0007tx-GR; Fri, 09 May 2025 00:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1uDDAx-00062z-E2
 for qemu-devel@nongnu.org; Thu, 08 May 2025 22:09:23 -0400
Received: from mxhk.zte.com.cn ([63.216.63.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1uDDAv-0000xV-24
 for qemu-devel@nongnu.org; Thu, 08 May 2025 22:09:23 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Ztsr61rY9z5B1Jt;
 Fri,  9 May 2025 10:09:10 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
 by mse-fl1.zte.com.cn with SMTP id 54928PVw085199;
 Fri, 9 May 2025 10:08:25 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid32;
 Fri, 9 May 2025 10:08:26 +0800 (CST)
Date: Fri, 9 May 2025 10:08:26 +0800 (CST)
X-Zmail-TransId: 2af9681d639a240-271dd
X-Mailer: Zmail v1.0
Message-ID: <20250509100826883Qfb-U1cCkGDsr7nr9_Bbt@zte.com.cn>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <peterx@redhat.com>, <farosas@suse.de>
Cc: <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIXSBtaWdyYXRpb246IEZpeCBtaWdyYXRpb24gZmFpbHVyZSB3aGVuIGFpYSBpcyBjb25maWd1cmVkIGFzICdhcGxpYy1pbXNpYyc=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 54928PVw085199
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 681D63C6.000/4Ztsr61rY9z5B1Jt
Received-SPF: pass client-ip=63.216.63.35; envelope-from=liu.xuemei1@zte.com.cn;
 helo=mxhk.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 May 2025 00:24:23 -0400
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

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

Address an error in migration by discarding 'riscv_aplic' and 'riscv_imsic'
in vmstate_register_with_alias_id() when aia is configured as
'aplic-imsic' in riscv kvm vm.

Previously, the fields in the vmsds of 'riscv_aplic' and 'riscv_imsic' can
only be initialized under certain special conditions in commit 95a97b3fd2.
However, the corresponding ses of these vmsds are inserted into the
savevm_state.handlers unconditionally. This led to migration failure
characterized by uninitialized fields when save vm state:
qemu-system-riscv64: ../migration/vmstate.c:433: vmstate_save_state_v:
Assertion 'first_elem || !n_elems || !size' failed.

Fixes: 95a97b3fd2 ("target/riscv: update APLIC and IMSIC to support KVM AIA")
Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
migration/savevm.c | 17 +++++++++++++++++
1 file changed, 17 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0c12e373b4..db53ce6d55 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -71,6 +71,8 @@
#include "yank_functions.h"
#include "system/qtest.h"
#include "options.h"
+#include "hw/intc/riscv_aplic.h"
+#include "system/kvm.h"

const unsigned int postcopy_ram_discard_version;

@@ -902,6 +904,21 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
{
SaveStateEntry *se;

+    /* Drop "riscv_aplic" if emulated aplic is used*/
+    if (!g_strcmp0(vmsd->name, "riscv_aplic")) {
+        RISCVAPLICState *aplic = opaque;
+        if (!riscv_use_emulated_aplic(aplic->msimode)) {
+            return 0;
+        }
+    }
+
+    /* Drop "riscv_imsic" if kvm_kernel_irqchip is true */
+    if (!g_strcmp0(vmsd->name, "riscv_imsic")) {
+        if (kvm_irqchip_in_kernel()) {
+            return 0;
+        }
+    }
+
/* If this triggers, alias support can be dropped for the vmsd. */
assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);

--
2.27.0

