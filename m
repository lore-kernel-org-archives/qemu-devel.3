Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD759CFD2F6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 14:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLxG-00029E-Ja; Sat, 29 Nov 2025 09:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vPLwQ-0001z7-Ud
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:28:53 -0500
Received: from sg-1-13.ptr.blmpb.com ([118.26.132.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vPLwJ-0000wX-9M
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1764426510;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Q7GAq65ALZiNekqSL+tWMcLPurYu/ToQPTuazfohejU=;
 b=BajCxC2wwGcc3W6u5SrbMTSHSk2yXdmMqa6MfUfqrJ7WnXUkD+x5hfZ8TerA+Fy3c6aHC6
 6tkW5U6FZZgT/UW3WXZz5ATk4vpUgvildF3wfKApNk1u1wpKKLkBPfu3oYCEHCCaiPN4Ww
 NRxOD5Wgd08QWFMuTfNnA/6JAgs/LWTN3ZvlN6EX5sQNq3dy5v1vyHz/x9NcnCfGGzVfd8
 +IbiteKTMMS7riJBNQZxsNQc37PTFluw6jRGHVMzdO8oQuHVIfWzL6Pr36p/E9pzZ/cJXD
 o90U4JRpVZwnJasgLG77z8elxhcdX+Y8/V9nvOJLfVrIJ0ar0qrAD+tTCPaHOw==
To: <zhao1.liu@intel.com>, <pbonzini@redhat.com>, 
 <manos.pitsidianakis@linaro.org>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
Cc: <chao.liu@openatom.club>, <dzm91@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>, 
 "chenmiao" <chenmiao@openatom.club>
From: "Chen Miao" <chenmiao@openatom.club>
X-Original-From: Chen Miao <chenmiao@openatom.club>
Message-Id: <69e22b6002d411a8edee3f589c568ce8217c2f37.1764426204.git.chenmiao@openatom.club>
Received: from nyaos.localdomain ([114.249.49.233]) by smtp.feishu.cn with
 ESMTPS; Sat, 29 Nov 2025 22:28:28 +0800
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.43.0
X-Lms-Return-Path: <lba+2692b030d+f03c2d+nongnu.org+chenmiao@openatom.club>
Subject: [RFC PATCH V3 3/4] rust/hw/core: Provide some interfaces for the GPIO
 device
Date: Sat, 29 Nov 2025 14:28:21 +0000
Received-SPF: pass client-ip=118.26.132.13;
 envelope-from=chenmiao@openatom.club; helo=sg-1-13.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: chenmiao <chenmiao@openatom.club>

In qdev.rs, we implemented the init_gpio_out_named function, which corresponds
to the C function qdev_init_gpio_out_named. We also refactored the
init_gpio_out function to reuse the init_gpio_out_named interface.

Signed-off-by: Chen Miao <chenmiao@openatom.club>
---
 rust/hw/core/src/qdev.rs | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index c3097a284d..28da94dd0a 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -17,7 +17,7 @@
 
 pub use crate::bindings::{ClockEvent, DeviceClass, Property, ResetType};
 use crate::{
-    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out_named, ResettableClass},
     irq::InterruptSource,
 };
 
@@ -399,11 +399,22 @@ fn do_init_gpio_in(
     }
 
     fn init_gpio_out(&self, pins: &[InterruptSource]) {
+        self.init_gpio_out_named(pins, "unnamed-gpio-out", pins.len());
+    }
+
+    fn init_gpio_out_named(&self, pins: &[InterruptSource], name: &str, n: usize) {
+        let c_name = if name.is_empty() {
+            CString::new("unnamed-gpio-out").unwrap()
+        } else {
+            CString::new(name).unwrap()
+        };
+
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

