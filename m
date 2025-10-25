Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E062CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 14:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCfEr-00042z-3N; Sat, 25 Oct 2025 10:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZI-0001cO-3x
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:24 -0400
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZ9-0003jO-G9
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761395940;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Cr1r4g0XwhyFPDsnU3OhA7flyT1rakbQqvrL6AK0Ffo=;
 b=KY5YP2u442Acs7mz06X7DsiPtsNBLcKjibLEVdwZ7vsaAfuQ+9SSnse89K/SY0k+PeuoL9
 UMk5TuAX6yKG0cwpWEhRT8N0HHrFG7PKmYvBHT1IL1WzGASMx3+DDKSukXV3lFxPM/4TzP
 Amt61jjdYNtk5etdYGrbKdviEj+1RHZaw7OrPTG71zB32jneYbbPcaYBx2yFAg/U1swUt0
 Zahg9orMXADx/eTZf70w9vIuhHqeiebYjpmJpYs7ht7zB2ncT3Agor1Oefe3ziygcUe7mB
 zANGfDtAPq2ONYM2a70P+XMTJfK1z8pO41Wvy+l+udSUMlMymzEh38DD6eZPsw==
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268fcc4e2+d1ff83+nongnu.org+chenmiao@openatom.club>
From: "chenmiao" <chenmiao@openatom.club>
X-Original-From: chenmiao <chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
Cc: <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, 
 <hust-os-kernel-patches@googlegroups.com>
Subject: [RFC 4/5] rust: hw: core: Provide some interfaces for the GPIO device
Date: Sat, 25 Oct 2025 12:38:52 +0000
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with
 ESMTPS; Sat, 25 Oct 2025 20:38:58 +0800
X-Mailer: git-send-email 2.43.0
To: <pbonzini@redhat.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>
Message-Id: <20251025123853.63139-5-chenmiao@openatom.club>
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=118.26.132.17;
 envelope-from=chenmiao@openatom.club; helo=sg-1-17.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 25 Oct 2025 10:27:12 -0400
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
index e0d7784..dd5d0ca 100644
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
index c3097a2..1d7a0b7 100644
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

