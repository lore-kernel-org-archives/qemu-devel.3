Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D77ED116EA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Nov 2025 16:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vPNy6-0001QA-PV; Sat, 29 Nov 2025 11:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vPN6l-0001jR-Sj
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 10:43:35 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vPN6k-0007bz-95
 for qemu-devel@nongnu.org; Sat, 29 Nov 2025 10:43:35 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-343774bd9b4so2248964a91.2
 for <qemu-devel@nongnu.org>; Sat, 29 Nov 2025 07:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764431013; x=1765035813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYQYrBtyfKJUAHag5BzfJ2Xcf0l0PHjigYu6ruxK0gU=;
 b=SC4I3+lNyLz2h60iUqeAjDk0rDdn9P+UP/dsIxD2hj3dJbDHtLNBcFcSR+9vbwmQBg
 RXlixBy9SDmR0iXEL+hkqUrDGeR2n1llxvgRDnown0OW249YJUAhZViqSqJIoVjFH0Dj
 h+Pby3+86H+0NGHaGG3GCQTg7YW989I8EahOCuE/iJH4vI9aRNtkHBFb0mD5+rFBpA2C
 y3x9LuVP9FEUXUWDpPjK1B1bF/5zLBdil71VuU0n76GKKpBxk8StO0ncExo7fRCTfu+M
 luxE4tJhbpr+xk+GlaJioccYVhm3k7VNI9FhIMeg7o9kz9vakIDImPhiiHdSy9Rvr8wV
 CC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764431013; x=1765035813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TYQYrBtyfKJUAHag5BzfJ2Xcf0l0PHjigYu6ruxK0gU=;
 b=ZzXdJ2SivH2k1g1ksgDL6pwRQvOFHmXrn0yFIBl2vUmEDn4k2xzdYlsq6z2X9Cw7VA
 8gmqlfWRXu1o3DvXwbw9eOhYRvo4k0HAyUKbPE07GQ4m4O+C192ZzbHp7qR+xsHQI76l
 1/AXQ5luOtqqZWYejyZJ2TUt+HB4pf7r1Nbv1nBkBmO85dzOJuzwGHR6uGTd9x3M8ah+
 J10cOt+SjiOLeQgpfMrPL3ZnNUo9c+8jKYEBZVD6ncf7P7w2C9cUqMa4sfVm0fFsymwZ
 YCZtep9OG0/OfioGDzySQQIYljMLaXrEzstsIVk/rmtqcky4T6HfZL/VhA7YsUM6scJy
 7NBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrTtPJQRfkye/r3AlDg+kXTjSuFcYaPLXLQDiDJv2mt9oZR3JDWYek1nx1C8RnLz3oo3rYJ1KGs+iK@nongnu.org
X-Gm-Message-State: AOJu0YwebPVd2xafSsH/H1KTle3sMhvUUc/+RbULatJ0/XpKoewznxWY
 lYW5nw6HWQaj+pdgkSrd6LFdsSOhRTXyUJ7+HNimDzUo6CdBToO3Wl/1
X-Gm-Gg: ASbGncvZYQ513fTZr/njARrrDCz183tyhwOvz4jMhjEmAjhVxHiqx3A1Jz0f15aPJyH
 bI+khXbJZLolitVrUKoZc/SYYEylcznAmazKL+C0kq8i3Dhic7E9p18uKAHe1oZuamGD9LfTGma
 ClA4vu7j2iud2ko1qhUTYd4VhyZukSwSitwNkMwfEvGIUQMZuSqXAEMyh9jMAaKVLSaBXufMRvw
 whriVPGCjhlWWiGzwkSfSSFQNprRRP7H4hj7z9X4WNBuRWFnfklV0mLryFFw8X9QGe/nph9kNpE
 Sfxo3hyowgplelvF1DjBxqCvJH3X5FapXkNFW69zeVm5bmns+pSlWsxA5hqqkI68N0xtaWOpJ2o
 1aslfBDEjNlTLsRm0Q7uOp5Uu2DWTmfOiZsrYTI2PyYISiZ6AVO9863XWl/ILlOJ1L45sSrTcfM
 G8Se/P9MYOIgubttZXhcra6nc4yLWTg35V8qfqLyaXqDJhbA==
X-Google-Smtp-Source: AGHT+IFGADgMZeoPFYsyuLQg/56m5CSR3OcjwtVJ7hQIqFyGj5vDKBOWCyFXt9ilhVm9MdUX1lx9Lg==
X-Received: by 2002:a17:90b:3503:b0:340:be44:dd0b with SMTP id
 98e67ed59e1d1-34733f5d2femr25991880a91.34.1764431012822; 
 Sat, 29 Nov 2025 07:43:32 -0800 (PST)
Received: from nyaos.localdomain ([166.0.199.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3476a546ed0sm11799767a91.3.2025.11.29.07.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Nov 2025 07:43:32 -0800 (PST)
From: ChenMiao <chenmiao.ku@gmail.com>
To: zhao1.liu@intel.com, pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
Cc: chao.liu@openatom.club , dzm91@openatom.club , qemu-rust@nongnu.org,
 qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 chenmiao <chenmiao@openatom.club>
Subject: [RESEND RFC PATCH V3 1/4] rust/hw/core: Add the BusState of rust
 version
Date: Sat, 29 Nov 2025 15:43:18 +0000
Message-ID: <4e3b8548a26867260f137c719d3c26a24d7954bd.1764426204.git.chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764426204.git.chenmiao@openatom.club>
References: <cover.1764426204.git.chenmiao@openatom.club>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=chenmiao.ku@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 29 Nov 2025 11:38:36 -0500
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
Message-ID: <20251129154318.vniu0RTs7_WiWlSw5GwABeDazbpjZIPMSmQ3F9NskyQ@z>

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


