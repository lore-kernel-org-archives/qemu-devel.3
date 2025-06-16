Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85F0C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 07:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR3qx-0000FX-9C; Mon, 16 Jun 2025 03:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1uR3q6-0008Ix-Jr; Mon, 16 Jun 2025 03:01:07 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1uR3q3-0007t1-85; Mon, 16 Jun 2025 03:01:05 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4bLLW31Lzkz4xVcQ;
 Mon, 16 Jun 2025 15:00:47 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
 by mse-fl2.zte.com.cn with SMTP id 55G70Wqk068171;
 Mon, 16 Jun 2025 15:00:32 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp04[null]) by mapi (Zmail) with MAPI id mid32;
 Mon, 16 Jun 2025 15:00:34 +0800 (CST)
Date: Mon, 16 Jun 2025 15:00:34 +0800 (CST)
X-Zmail-TransId: 2afb684fc11271d-ec39d
X-Mailer: Zmail v1.0
Message-ID: <20250616150034827wuHs_ffe3Qm8cqFXT7HeW@zte.com.cn>
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, <zhiwei_liu@linux.alibaba.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?W1BBVENIIHYzIFJFU0VORF0gbWlncmF0aW9uOiBGaXggbWlncmF0aW9uIGZhaWx1cmUgd2hlbiBhaWEgaXMgY29uZmlndXJlZCBhcyBhcGxpYy1pbXNpYw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 55G70Wqk068171
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 684FC11F.000/4bLLW31Lzkz4xVcQ
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Address an error in migration when aia is configured as 'aplic-imsic' in
riscv kvm vm by adding riscv_aplic_state_needed() and
riscv_imsic_state_needed() to determine whether the corresponding sates are
needed.

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
 Changes in v3:
 - Increase version_id and minimum_version_id

 hw/intc/riscv_aplic.c | 12 ++++++++++--
 hw/intc/riscv_imsic.c | 10 ++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 8bcd9f4697..4fa5f7597b 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -962,10 +962,18 @@ static const Property riscv_aplic_properties[] = {
     DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
 };

+static bool riscv_aplic_state_needed(void *opaque)
+{
+    RISCVAPLICState *aplic = opaque;
+
+    return riscv_use_emulated_aplic(aplic->msimode);
+}
+
 static const VMStateDescription vmstate_riscv_aplic = {
     .name = "riscv_aplic",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .needed = riscv_aplic_state_needed,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT32(domaincfg, RISCVAPLICState),
             VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 2169988167..6174e1a05d 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -398,10 +398,16 @@ static const Property riscv_imsic_properties[] = {
     DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
 };

+static bool riscv_imsic_state_needed(void *opaque)
+{
+    return !kvm_irqchip_in_kernel();
+}
+
 static const VMStateDescription vmstate_riscv_imsic = {
     .name = "riscv_imsic",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
+    .needed = riscv_imsic_state_needed,
     .fields = (const VMStateField[]) {
             VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
                                   num_pages, 0,
-- 
2.27.0

