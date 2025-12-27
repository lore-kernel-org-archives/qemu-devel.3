Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F025DE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQj-0004xS-3I; Sat, 27 Dec 2025 04:17:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQh-0004wb-GO
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQf-00039N-TV
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GUnSWK/yLZHKNz7WpY3bYWHy/Ak2/CbbgzV5tUWVqa4=;
 b=CMlgyqdNVwOTZ/0MFnPKbPEUCoRur3YCYkTyQN4W2I/FlT7aLtZZI91WJCSY2NykD3tyYa
 56v1ycrh4jfdN0ZAmA/3KGnOx/ZTwaqusv0j3RSma5+kXy0REJrF6Zd24wllvNxUTcKu4D
 JL89A5lodf0LVIqrPCsK+5/9bfdTQCE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-B3iaAr5kOm-b__PQKX7AJg-1; Sat, 27 Dec 2025 04:17:39 -0500
X-MC-Unique: B3iaAr5kOm-b__PQKX7AJg-1
X-Mimecast-MFC-AGG-ID: B3iaAr5kOm-b__PQKX7AJg_1766827058
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so73395795e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827058; x=1767431858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GUnSWK/yLZHKNz7WpY3bYWHy/Ak2/CbbgzV5tUWVqa4=;
 b=MuoidLCsAsVRYbg8FGrAyoUfMKcDfI8WdWqqoiAsZ8REFsPnIrkcFwWYm1/vzL0++Y
 XOEzyvhUQo6qZvTUiu68vaLonY7GKXRdxomGFr/iJN9RdQdxDrArL9qSlM680Txe+wVg
 EP9VSvHKCNwmQsSFSMvCdIgkBUb8wvjCXRvUMBq8FdcbN65cSHNkj5yCLMiEKFZ7UAu8
 2RwIv/mLdWq0mWBQo3bult1hsHPQC2IGisEFbgnIZjK71QKShT5qZewg2AwNa94mkVwg
 1VroZG9/KMjGRYz4uspQyruye5kBux0QtnpiKOGoM8JwzFr53DsXrcX6/IDb0UHiZ1m/
 VHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827058; x=1767431858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GUnSWK/yLZHKNz7WpY3bYWHy/Ak2/CbbgzV5tUWVqa4=;
 b=xSsKR8YYIZ3K3hic0MqEmQYut2mk2fpnCMoRsYpm6hw067o7bqJFbvORmxdlZZCTxU
 tSq/yLsa0+A03cfmD4CQ4Nl2z6bvmIuf7mcya5OfMHw6qLQfs07Sh5096qzY7cqs+VoC
 hrFOnVPkK4e3KG75XrRCCnZtImVEU+45/Y8quG7Xz9TMfyCD0cPjUrKZJsBfAbmloWNw
 uxObcsOW4fNCfFGb0i/EfrABJAq9+F1mreeJ9OAeydkXYRKuA3eRfz96rpTEWp3EVxZa
 EcTIW5WZabY11O25WiZvxWgoMLxF4SXDkS99skJZyFEP+y0ZI9BmP0/WV9custqi7ns0
 LzPw==
X-Gm-Message-State: AOJu0YwuXIJkUCNV30Xx5d5f1tIeDjW3Phqb59KHVUqNQ94D3O394QW6
 W1nTAosZVQZ/HzF2y5WEs+sb1R78z8xs+ARpW9P7ODZjP6RoRyIrk3Qxluch1yYx/Xf7S35UemS
 5SoSX9dhdxe/27CX+6f6BP1K3iBgP+dYB4XQxieNcIZOApKfevsmOGpbpH2rvGbp+vhv0Ij2/CG
 fKDLwCDPsC0RV3uZ8Lq5vJq1+G5v4/Qp+X4j+l/vyS
X-Gm-Gg: AY/fxX5b9LYeuRznWyJ02jaUulEgXAq2tBy+9AU0uTvxah0nMFSlJCh32oRCHezU3AT
 znjJ70Io590FlMqPfJUgtgQJCnRT9lF+Q44FNnLsKLHY2wGE5PtLcc50a0AiKzQcoOx6mPVEZyH
 asd1K6yFOUbKqSGqOFKvt8It05YVwSAso/WkQF2QQjIunYue2KN82yG8VCUzBRDa5qsb7gEjlmh
 2WfblB69M2u13e9pwRjZ+vOwrZrIBm672kC52pTBKF27z/AXum/cOeB1oN0WUaG7xGnLdUPbAA1
 jzT9E1fIL7WZ5Y+AxeQ/mZkX7IpDYFdepJZrr+fP90WyvuOA9X23Yf7FJctpQmIEYvsQEH7onWB
 FnixFhlIsZfEkSqgtucO88+dzEMI6yE1vSRcV26ydkMkonLTQLKM4nL78/UOMMNRi8o9cU6BFzB
 oxoW/IE+0uR6ElRY8=
X-Received: by 2002:a05:600c:3b0e:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-47d1955b7d1mr273719465e9.3.1766827058088; 
 Sat, 27 Dec 2025 01:17:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu+X3PNjYuqA5fiL8dxjBzJO4FM6MiMLRp8jsBDAZLl3mQ9e0wZ+Eh68AL5Dd1S00h3eG13A==
X-Received: by 2002:a05:600c:3b0e:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-47d1955b7d1mr273719235e9.3.1766827057675; 
 Sat, 27 Dec 2025 01:17:37 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2724fe8sm568381795e9.1.2025.12.27.01.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 038/153] common: add prelude
Date: Sat, 27 Dec 2025 10:14:25 +0100
Message-ID: <20251227091622.20725-39-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/common/meson.build          | 13 +------------
 rust/common/src/lib.rs           |  5 +++++
 rust/common/src/prelude.rs       |  9 +++++++++
 rust/hw/char/pl011/src/device.rs |  2 +-
 rust/hw/timer/hpet/src/device.rs |  2 +-
 5 files changed, 17 insertions(+), 14 deletions(-)
 create mode 100644 rust/common/src/prelude.rs

diff --git a/rust/common/meson.build b/rust/common/meson.build
index 4b1cd35f639..57091b18fc4 100644
--- a/rust/common/meson.build
+++ b/rust/common/meson.build
@@ -4,18 +4,7 @@ _common_cfg = run_command(rustc_args,
 
 _common_rs = static_library(
   'common',
-  structured_sources(
-    [
-      'src/lib.rs',
-      'src/assertions.rs',
-      'src/bitops.rs',
-      'src/callbacks.rs',
-      'src/errno.rs',
-      'src/opaque.rs',
-      'src/uninit.rs',
-      'src/zeroable.rs',
-    ],
-  ),
+  'src/lib.rs',
   rust_args: _common_cfg,
   dependencies: [libc_rs, qemu_macros],
 )
diff --git a/rust/common/src/lib.rs b/rust/common/src/lib.rs
index 8311bf945da..6093d01a388 100644
--- a/rust/common/src/lib.rs
+++ b/rust/common/src/lib.rs
@@ -15,6 +15,11 @@
 pub mod opaque;
 pub use opaque::{Opaque, Wrapper};
 
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
+
 pub mod uninit;
 pub use uninit::MaybeUninitField;
 
diff --git a/rust/common/src/prelude.rs b/rust/common/src/prelude.rs
new file mode 100644
index 00000000000..7d38ea12055
--- /dev/null
+++ b/rust/common/src/prelude.rs
@@ -0,0 +1,9 @@
+//! Essential types and traits intended for blanket imports.
+
+pub use crate::bitops::IntegerExt;
+pub use crate::uninit::MaybeUninitField;
+
+// Re-export commonly used macros
+pub use crate::static_assert;
+pub use crate::uninit_field_mut;
+pub use qemu_macros::TryInto;
diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 18f40fdc58b..b7e8e393d2e 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -6,7 +6,7 @@
 
 use bql::BqlRefCell;
 use chardev::{CharFrontend, Chardev, Event};
-use common::{static_assert, uninit_field_mut};
+use common::prelude::*;
 use hwcore::{
     Clock, ClockEvent, DeviceImpl, DeviceMethods, DeviceState, IRQState, InterruptSource,
     ResetType, ResettablePhasesImpl, SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index 6e9c004ecae..e9c7afa24d5 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -11,7 +11,7 @@
 };
 
 use bql::{BqlCell, BqlRefCell};
-use common::{bitops::IntegerExt, uninit_field_mut};
+use common::prelude::*;
 use hwcore::{
     DeviceImpl, DeviceMethods, DeviceState, InterruptSource, ResetType, ResettablePhasesImpl,
     SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
-- 
2.52.0


