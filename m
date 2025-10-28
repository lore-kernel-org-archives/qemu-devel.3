Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73DBCCF9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 10:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDgoo-0005s6-M0; Tue, 28 Oct 2025 06:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDgoF-0005bH-F6
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:20:15 -0400
Received: from sg-1-31.ptr.blmpb.com ([118.26.132.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vDgo2-0001sk-J2
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 06:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761646721;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=zvHdl+wWHOB+VeJgQE82SVVMbZQtCopVyudakAiLOR0=;
 b=cr4cEed9VnzMoOvgk2WHlyc4nQRoPtDlQCBBBCnnAvfHhFbVT3nY/OSWlX225Q90tD2qzh
 vQ67PzzeLLBda6rRWPi991TVm9SM+NUgHiCehn8MRIlkm1dq/EbX1+drMMAqxTSvVT4bdh
 U0xHrs433idPm7RladgDlm+MqvLT6GqhMHrv9fomC0kv7SaCziSucdoaDj8pTyTOkL+p42
 t91FzaQzD/kKvAArHJTSUYWeOLCHxrF+znT4jN4jD6LxyyifYoKCaa+I3uz5CZyT6qtzZd
 07yvEsQFngl267TpOZ1i/TbW9utQBniXbXhHX4AjodQDBL1CHGoIAqxZwf4jyw==
To: <zhao1.liu@intel.com>, <pbonzini@redhat.com>, 
 <manos.pitsidianakis@linaro.org>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Lms-Return-Path: <lba+26900987f+47dc6e+nongnu.org+chenmiao@openatom.club>
Cc: <chao.liu@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>
From: "chenmiao" <chenmiao@openatom.club>
Message-Id: <45032bb11a9006cb7a6e1c30ca6299d40cef614c.1761644606.git.chenmiao@openatom.club>
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with
 ESMTPS; Tue, 28 Oct 2025 18:18:38 +0800
Content-Transfer-Encoding: 7bit
Subject: [RFC PATCH v2 4/5] rust/hw/core: Provide some interfaces for the GPIO
 device
Date: Tue, 28 Oct 2025 10:18:28 +0000
Mime-Version: 1.0
X-Original-From: chenmiao <chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.31;
 envelope-from=chenmiao@openatom.club; helo=sg-1-31.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In irq.rs, we added a new get method for the InterruptSource type to determine
whether an InterruptSource is null. This eliminates the need to repeatedly
call self.cell.get().is_null() for null checks during comparisons.
Additionally, we exposed the slice_as_ptrmethod to support external usage with
the &[InterruptSource]type.

In qdev.rs, we implemented the init_gpio_out_namedfunction, which corresponds
to the C function qdev_init_gpio_out_named. We also refactored the
init_gpio_outfunction to reuse the init_gpio_out_namedinterface.

Signed-off-by: chenmiao <chenmiao@openatom.club>
---
 rust/hw/core/src/irq.rs  |  6 +++++-
 rust/hw/core/src/qdev.rs | 12 +++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/rust/hw/core/src/irq.rs b/rust/hw/core/src/irq.rs
index e0d7784d97..dd5d0cadbc 100644
--- a/rust/hw/core/src/irq.rs
+++ b/rust/hw/core/src/irq.rs
@@ -71,6 +71,10 @@ pub fn pulse(&self) {
     pub fn raise(&self) {
         self.set(true);
     }
+
+    pub fn get(&self) -> bool {
+        !self.cell.get().is_null()
+    }
 }
 
 impl<T> InterruptSource<T>
@@ -91,7 +95,7 @@ pub(crate) const fn as_ptr(&self) -> *mut *mut bindings::IRQState {
         self.cell.as_ptr()
     }
 
-    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::IRQState {
+    pub const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::IRQState {
         assert!(!slice.is_empty());
         slice[0].as_ptr()
     }
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index c3097a284d..1d7a0b7c1a 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -17,7 +17,7 @@
 
 pub use crate::bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use crate::{
-    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out_named, ResettableClass},
     irq::InterruptSource,
 };
 
@@ -399,11 +399,17 @@ fn do_init_gpio_in(
     }
 
     fn init_gpio_out(&self, pins: &[InterruptSource]) {
+        self.init_gpio_out_named(pins, "", pins.len());
+    }
+
+    fn init_gpio_out_named(&self, pins: &[InterruptSource], name: &str, n: usize) {
+        let c_name = CString::new(name).expect("gpio name new failed");
         unsafe {
-            qdev_init_gpio_out(
+            qdev_init_gpio_out_named(
                 self.upcast().as_mut_ptr(),
                 InterruptSource::slice_as_ptr(pins),
-                pins.len() as c_int,
+                c_name.as_ptr(),
+                n as c_int,
             );
         }
     }
-- 
2.43.0

