Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80587CCF9EB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 14:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCfEk-0003yh-3A; Sat, 25 Oct 2025 10:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZF-0001bH-2d
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:21 -0400
Received: from sg-1-40.ptr.blmpb.com ([118.26.132.40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao@openatom.club>)
 id 1vCdZ8-0003jG-Iq
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 08:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1761395937;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=pVMloPN1g9fl6a5oBE0FeDpy/NkXLu/pcvpPddum0PM=;
 b=Qdbu+FLyjhZLBr5vQn9XU4bLiEIU8ocsaHsB3n8IYWISfKe+/s1RlbtnoRJruNepTdtUeL
 A8Ria8da8iEmPlumPdROw8/cilmeANYPqLm161Yng11QfvayOG32qMZxojHMBbLCoD69xe
 opWlr/4Zr+Eq8FaQ/nmVLRK5kaDxwdCu+rotKr4C7K6D/lw/uSOGMnq5OJRBbNqiKGaCU5
 /1U/Cws3X1EgqQLSXtj0fl/3Ukx2inI4/HmquFWaZJz3UosLsFJmKH2tPkaXRSlMqzyc4t
 U2zZVL64ytzcaCDSpe15PujS3YCudAjiiCJOzbtsZpTFYUl6ZhhSgamu30t1FQ==
Cc: <qemu-rust@nongnu.org>, <qemu-devel@nongnu.org>, 
 <hust-os-kernel-patches@googlegroups.com>
Message-Id: <20251025123853.63139-2-chenmiao@openatom.club>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: chenmiao <chenmiao@openatom.club>
Received: from nyaos.localdomain ([114.249.194.57]) by smtp.feishu.cn with
 ESMTPS; Sat, 25 Oct 2025 20:38:54 +0800
To: <pbonzini@redhat.com>, <manos.pitsidianakis@linaro.org>, 
 <richard.henderson@linaro.org>, <philmd@linaro.org>
X-Mailer: git-send-email 2.43.0
From: "chenmiao" <chenmiao@openatom.club>
Subject: [RFC 1/5] rust: hw: core: Add the BusState of rust version
Date: Sat, 25 Oct 2025 12:38:49 +0000
X-Lms-Return-Path: <lba+268fcc4df+2ac5f0+nongnu.org+chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.40;
 envelope-from=chenmiao@openatom.club; helo=sg-1-40.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A Rust version implementation has been designed for BusState,
which will be used for the subsequent I2CBus implementation.

Signed-off-by: chenmiao <chenmiao@openatom.club>
---
 rust/hw/core/meson.build |  1 +
 rust/hw/core/src/bus.rs  | 51 ++++++++++++++++++++++++++++++++++++++++
 rust/hw/core/src/lib.rs  |  3 +++
 3 files changed, 55 insertions(+)
 create mode 100644 rust/hw/core/src/bus.rs

diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 1560dd2..efcda50 100644
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
index 0000000..c87d18d
--- /dev/null
+++ b/rust/hw/core/src/bus.rs
@@ -0,0 +1,51 @@
+// Copyright 2025 HUST OpenAtom Open Source Club.
+// Author(s): Chen Miao <chenmiao@openatom.club>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use std::{ffi::CStr, ptr::addr_of_mut};
+
+pub use bindings::BusClass;
+use common::Opaque;
+use qom::{qom_isa, IsA, Object, ObjectCast, ObjectDeref, ObjectType};
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
+pub trait BusStateMethods: ObjectDeref
+where
+    Self::Target: IsA<BusState>,
+{
+    fn bus_realize(&self) {
+        assert!(bql::is_locked());
+        unsafe {
+            bindings::qbus_realize(
+                self.upcast().as_mut_ptr(),
+                addr_of_mut!(util::bindings::error_fatal),
+            );
+        }
+    }
+}
+
+impl<R: ObjectDeref> BusStateMethods for R where R::Target: IsA<BusState> {}
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
index b40801e..10cc516 100644
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

