Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C763CFD2F6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 14:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPLxG-00029W-OA; Sat, 29 Nov 2025 09:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vPLwQ-0001z8-V9
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:28:53 -0500
Received: from sg-1-12.ptr.blmpb.com ([118.26.132.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vPLwJ-0000wO-15
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 09:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1764426507;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=TYQYrBtyfKJUAHag5BzfJ2Xcf0l0PHjigYu6ruxK0gU=;
 b=UWjMfHyNcLEeXvUzvZuR3QRFLggkvuMCpQhNTy/t5olhFfbKwn96SB0IZh/jOLRccfvLLv
 OClSmTNczu44+gKVnOCGIxGWSqqZQFMM0y354z03Uilg/VJBU4UHjLDYMAdK/msHjQpCLf
 afKSBi3bVMcoajk2gZXELrjXv3SNT3YgPjZBZ1DLCjo3L+0M5J213E6N+9N7MvHOr8tvPp
 K76eMpQ7oSpLB5kf7JqFs4Nw4SrvRvHDRikv4WIricyx8XaPbykS7+Ud1AQ4230LCCae+Y
 MEqp1Wqz3aRYzrpSoypE9XDr768vhYprF8gJDEe91Po5zdx1gaSQx0ZPhsZBJQ==
To: <zhao1.liu@intel.com>, <pbonzini@redhat.com>, 
 <manos.pitsidianakis@linaro.org>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>
From: "Chen Miao" <chenmiao@openatom.club>
Subject: [RFC PATCH V3 1/4] rust/hw/core: Add the BusState of rust version
X-Mailer: git-send-email 2.43.0
Cc: <chao.liu@openatom.club>, <dzm91@openatom.club>, <qemu-rust@nongnu.org>, 
 <qemu-devel@nongnu.org>, <hust-os-kernel-patches@googlegroups.com>, 
 "chenmiao" <chenmiao@openatom.club>
Date: Sat, 29 Nov 2025 14:28:19 +0000
Message-Id: <4e3b8548a26867260f137c719d3c26a24d7954bd.1764426204.git.chenmiao@openatom.club>
X-Original-From: Chen Miao <chenmiao@openatom.club>
X-Lms-Return-Path: <lba+2692b0309+90d328+nongnu.org+chenmiao@openatom.club>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Received: from nyaos.localdomain ([114.249.49.233]) by smtp.feishu.cn with
 ESMTPS; Sat, 29 Nov 2025 22:28:24 +0800
Received-SPF: pass client-ip=118.26.132.12;
 envelope-from=chenmiao@openatom.club; helo=sg-1-12.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A Rust version implementation has been designed for BusState,
which will be used for the subsequent I2CBus implementation.

Signed-off-by: Chen Miao <chenmiao@openatom.club>
Signed-off-by: Chao Liu <chao.liu@openatom.club>
---
 rust/hw/core/meson.build |  1 +
 rust/hw/core/src/bus.rs  | 44 ++++++++++++++++++++++++++++++++++++++++
 rust/hw/core/src/lib.rs  |  3 +++
 3 files changed, 48 insertions(+)
 create mode 100644 rust/hw/core/src/bus.rs

diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 1560dd20c6..efcda50fef 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -50,6 +50,7 @@ _hwcore_rs = static_library(
     [
       'src/lib.rs',
       'src/bindings.rs',
+      'src/bus.rs',
       'src/irq.rs',
       'src/qdev.rs',
       'src/sysbus.rs',
diff --git a/rust/hw/core/src/bus.rs b/rust/hw/core/src/bus.rs
new file mode 100644
index 0000000000..d3fbf519d4
--- /dev/null
+++ b/rust/hw/core/src/bus.rs
@@ -0,0 +1,44 @@
+// Copyright 2025 HUST OpenAtom Open Source Club.
+// Author(s): Chen Miao <chenmiao@openatom.club>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::ffi::CStr;
+
+pub use bindings::BusClass;
+use common::Opaque;
+use qom::{qom_isa, IsA, Object, ObjectDeref, ObjectType};
+
+use crate::{bindings, DeviceImpl};
+
+#[repr(transparent)]
+#[derive(Debug, common::Wrapper)]
+pub struct BusState(Opaque<bindings::BusState>);
+
+unsafe impl Send for BusState {}
+unsafe impl Sync for BusState {}
+
+unsafe impl ObjectType for BusState {
+    type Class = BusClass;
+    const TYPE_NAME: &'static std::ffi::CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_BUS) };
+}
+
+qom_isa!(BusState: Object);
+
+pub trait BusStateImpl: DeviceImpl + IsA<BusState> {}
+
+impl BusClass {
+    pub fn class_init<T: BusStateImpl>(self: &mut BusClass) {
+        self.parent_class.class_init::<T>();
+    }
+}
+
+pub trait BusMethods: ObjectDeref
+where
+    Self::Target: IsA<BusState>,
+{
+    // TODO: Since the bus does not currently provide services to other
+    // components, we have not implemented any functions yet.
+}
+
+impl<R: ObjectDeref> BusMethods for R where R::Target: IsA<BusState> {}
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
index b40801eb84..10cc516664 100644
--- a/rust/hw/core/src/lib.rs
+++ b/rust/hw/core/src/lib.rs
@@ -13,3 +13,6 @@
 
 mod sysbus;
 pub use sysbus::*;
+
+mod bus;
+pub use bus::*;
-- 
2.43.0

