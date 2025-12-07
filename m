Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AA4D2CE17
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Dec 2025 04:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vS6TK-0001cP-Dn; Sat, 06 Dec 2025 23:34:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vS5XE-0002ul-69
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 22:34:08 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chenmiao.ku@gmail.com>)
 id 1vS5X3-0002Tm-GB
 for qemu-devel@nongnu.org; Sat, 06 Dec 2025 22:34:01 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so3039402b3a.3
 for <qemu-devel@nongnu.org>; Sat, 06 Dec 2025 19:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765078428; x=1765683228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYQYrBtyfKJUAHag5BzfJ2Xcf0l0PHjigYu6ruxK0gU=;
 b=mCqhMVgSYTupCxvSl0a2p1Bd65IKi1t3SGE+vKv3n1uZOohAIky8ZYGihrgE4N305h
 xzWW2bBvIYH8X0cBrQxsjcf3vWQmxLK+xHBiTKnAzyeLpSJKg0Xn4sAe+AsKU9Xqdd0v
 KZPBUGWQJaPw7WAxTjwKoWtlJ56RZjcaEn821o08niPlzaxokAqv7xDktWD9IAgfWWDw
 lomKfdZetRm83g1od+tSM/ay7Xvv8wx5MM6ep04ewO7xWj2eqRYn5mIb1iGIkcHK8smd
 9Si0yk+eZ1DmcbJro6ptWaOMHShpoyTc4CElf6BO4+QDmFD2NBFtzql82XbsIT7aiUnn
 MbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765078428; x=1765683228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TYQYrBtyfKJUAHag5BzfJ2Xcf0l0PHjigYu6ruxK0gU=;
 b=h/NdoOoMU5vfksgg55Nxgj1SkcashB3oX6y2gnt/xvkH0COI0xiskQxwZolhSypkf1
 5w6wFDIxJUf/y2psd7qHLFgIXJVg39xmx2h1KRigB6Wun1FK42ZrDywJaIz9UE4Hdcbe
 vYvlaVyWf2TGP5WnlsKyDbobddGST7DHGCBzhpw57iL2ICoWgAnPrXTVsTRbbvMFeQHu
 zn3V+0p94UtCCQz1MoKJ9d99O7DnCNSXRi/Pt6umRVxqmNZWlpIkiqx9G5FCuEA5hs7k
 /totoMnZ/PNO4tqzVeEJ4cHc6rRtcF1ftfvgTymYj41uOpfFvl5/82rrBrMYWaasX+6+
 HpVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbubH5G+ZsphBwMmuxQK0ZQ8hqZZUpbXQcrUaEItQLnUp5lS5Dm/B7enrtkUHN9p4fsR7HfyO5JPE+@nongnu.org
X-Gm-Message-State: AOJu0Yywa5kL6jn6lb0dvD8LxjnS6uE97kEnF6WDVThaAUolp1+G9KKA
 YO+44zBYweWDJSzyih1mieafKuW+Q+k9aU8XsC/5WzYLxoqeSOrSvpKcU50aJtBc0JXGLQ==
X-Gm-Gg: ASbGncuDbkUcrR7RuIN5uTXn4dPpueRgWX63OlAC+5oZ/pQqqDCduZEP1cqKLf9hqXQ
 Y2P96Vd59lQsvlrLugQtN33b9Vmmo4//oMirdcuATwAkdDXZp8/6GX1wzYIdiOcpRWZtVAnfEiv
 C1JXQNqYugJv1ku9Uiw6mOMUvLj7ZtA/hVCdLAnI8IIBibeRUS3wMIpSMmObTXKOQ11oyaVUefB
 QZ4GGcvGqobLW26Diwj+Xc7nsl+Dl1a3aTDDEt9Ywu6YTGNsbTxk5Wwhm2WXrSxXrgBQ0BqJdD5
 GwSyFTiSzR9FBFv2QUUJt51L0fDzPzZfbCf4AHngJiq6aTY/YYKW7X7LwIBlAavqniNeE1OAc0K
 D76/vBMW1O4DTjoSP+sBdQA0f5muV6V1CgD5VqSCD+DT4E5TnwqBzQGQUg2gvw/4SQUk52zMGEI
 Mm+hVIxtISiZulVvd25KYUmppHhu+BmLIZVoMccPFY9pc6EA==
X-Google-Smtp-Source: AGHT+IHLKeAyCUZ8NBnh10nkmhn9X2UWmYQZyZk1k2lI1Wod142J5tzz9PMYLXTZNInaffP16H73Cw==
X-Received: by 2002:a05:6a21:32a0:b0:34f:4309:ed32 with SMTP id
 adf61e73a8af0-36617e6f4e5mr4032494637.23.1765078427849; 
 Sat, 06 Dec 2025 19:33:47 -0800 (PST)
Received: from nyaos.localdomain ([166.0.199.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bf6a1caeea7sm8496390a12.24.2025.12.06.19.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Dec 2025 19:33:47 -0800 (PST)
From: ChenMiao <chenmiao.ku@gmail.com>
To: zhao1.liu@intel.com, pbonzini@redhat.com, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, philmd@linaro.org
Cc: chao.liu@openatom.club , dzm91@openatom.club , qemu-rust@nongnu.org,
 qemu-devel@nongnu.org, hust-os-kernel-patches@googlegroups.com,
 chenmiao <chenmiao@openatom.club>
Subject: [PATCH v3 1/4] rust/hw/core: Add the BusState of rust version
Date: Sun,  7 Dec 2025 03:33:28 +0000
Message-ID: <4e3b8548a26867260f137c719d3c26a24d7954bd.1765077679.git.chenmiao@openatom.club>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1765077679.git.chenmiao@openatom.club>
References: <cover.1765077679.git.chenmiao@openatom.club>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=chenmiao.ku@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Dec 2025 23:34:09 -0500
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


