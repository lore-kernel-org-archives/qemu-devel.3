Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACD7E8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQl-00054E-Hg; Sat, 27 Dec 2025 04:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQk-00051n-9L
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQi-0003E6-Ia
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/gCmmzBIF+KM2x1EnkEGwKPoQsC1VbJV5BydwbuYfs=;
 b=feyHm5+m4RU9snon+yOQWumFQyfo60WZzd46YVexq/3Tp3MVW0sT5XhFk9EYZYHxCwZkQL
 MpW2NjUPD/mUktKLipBj4xj4RDc4/9S8+FNrV01VzYNN33HC1EIKUqfJbWmgD1prWzgGnC
 AnwYNamH3ru/vaOzNdaPKBxFdvaUdu0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-rwVkcEpIPXWHmm6l-8nHVQ-1; Sat, 27 Dec 2025 04:17:41 -0500
X-MC-Unique: rwVkcEpIPXWHmm6l-8nHVQ-1
X-Mimecast-MFC-AGG-ID: rwVkcEpIPXWHmm6l-8nHVQ_1766827060
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so77991055e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827060; x=1767431860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/gCmmzBIF+KM2x1EnkEGwKPoQsC1VbJV5BydwbuYfs=;
 b=ir1WOkqJhn53sLM5TV2WM2rX9X+Wwj0YMkHX6l1hvobouRXT/2GcXR49DOaHVT+KL5
 Tzgb+uRbPru24DHGDEnHI1nbeIHcHpV0uLUxmb6HhWM9U9a/QyCxS6YlrAOBg2FtZb4D
 FOsSn17ft1MhpEmzNmWTtKfzMYkrxExiCEZyG7pN9O2Wq0HfhwlXOhqEHFNWEmoXpHND
 iqtTLg56Xm8jw2x0c5LLc/7OV+3rf8z64Lgzpw685jJCxwETSv1+dKK9eME7vIyRwmeu
 7Vdk9Ea5Lzl0s6UjGiMMP6fD/S+QKfU5i02cvL8Xbo509pWloHseSvJ4H9ht+Deu1Vfz
 KK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827060; x=1767431860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4/gCmmzBIF+KM2x1EnkEGwKPoQsC1VbJV5BydwbuYfs=;
 b=Ooiqpm4Z1TzNdywtsV3yBdHcLfaip6auG63aydObYXyT4aKB5pKxmHw7+bv2u23K36
 8vdWNV/lVMdg1FLP5N5gFP2XlVVnkl5e6RVQa4ejozwL8GMWi51V34cjH1+ZUJine0DC
 9EGU3t2Vl+KKcKtCTVHTxavOBeCw8wa9GRX+cD8wPSBr2VspGGXxIPmeePUd0TMoU9oB
 CeZwn2lCtMXB9zgDFhH3frdXFcUzh0L9m2d4ObBaDSsvKVdy65qvO+nBdxTVXtcuX7t0
 +a70EyqhRhUatrfnn44S264YMc5gegI532eJObhzjqof2mLqWuvThuelOyPcqWSnnUNs
 rhdw==
X-Gm-Message-State: AOJu0Yw8iXPa5zUGtFxVfhFgYrN8y7RpjEmU6QD5eI+Lw3uOWa5psyoZ
 Kg3rEoV2n8kFp4Kg2FFsNnLTNRjJY94Jivx5tlg9d2Qguk+UxJ9mFLwMg1NKFv26ycsnsGl8ceZ
 k6GZe1b5ccJrC/+ztiO1vOA43pKIjnbRXfo89A53ii6eA9ByMqB1BNNP5gZGmJYSrh0I+41zdFn
 reajUxZB+q3GBi9QVROaLsGSY1PFLmzxqcX3Ap7nkr
X-Gm-Gg: AY/fxX79u27XmVAuToNWgc/Zkgk/3lNX/foT7XDaDHC0RpiQnsAGDCFelzaaUd/Cg6V
 6OEsb5yKRHioVm4FStaUj2S2VGXdwMy+IBvOEoybIn2smJguFVgdqtqA+2+u4MXHpY9e/tUj5xT
 adUvog+Cw2WmzpcPU2+CDvKTlfntr1EX7jw0AY8niyAofnQcY7PFBMmZZDVwSfvzZTUMLx9E5fC
 azcnQGfS+LJtgJU09IvMGD08dA0ptREbMdj1dOr9j4Zvl+4k/SNDMJNXPSXdvzWOKdb/yc48oT8
 KW/A3w4YqIDgANNyVtljW2EZTr8AP951NaUxA4AUoEuMLS32em8vzeOZcukzz6+q+cpskqcHhTf
 QqQNXEGhnrIfN7znxzZCZQzIECwyrm772dRrVspg0oCg4UULIB50VuBJTYBOfAAOwD0nmoe5pKC
 EZP16PFLMbYtih5cQ=
X-Received: by 2002:a05:600c:3ba3:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-47d1958c90cmr283360495e9.28.1766827059779; 
 Sat, 27 Dec 2025 01:17:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFXzL5fFBOCR8SLXi3YbZKWcuIyCUjtAMyIvjFYjix0rCzfZIE+yheFNDEaXF37WFD8XMd9Q==
X-Received: by 2002:a05:600c:3ba3:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-47d1958c90cmr283360315e9.28.1766827059276; 
 Sat, 27 Dec 2025 01:17:39 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1aee5sm50854018f8f.4.2025.12.27.01.17.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 039/153] hwcore: add prelude
Date: Sat, 27 Dec 2025 10:14:26 +0100
Message-ID: <20251227091622.20725-40-pbonzini@redhat.com>
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
 rust/hw/char/pl011/src/device.rs |  5 +----
 rust/hw/core/meson.build         |  1 +
 rust/hw/core/src/lib.rs          |  5 +++++
 rust/hw/core/src/prelude.rs      | 14 ++++++++++++++
 rust/hw/core/tests/tests.rs      |  2 +-
 rust/hw/timer/hpet/src/device.rs |  5 +----
 6 files changed, 23 insertions(+), 9 deletions(-)
 create mode 100644 rust/hw/core/src/prelude.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index b7e8e393d2e..164f27d5bb2 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -7,10 +7,7 @@
 use bql::BqlRefCell;
 use chardev::{CharFrontend, Chardev, Event};
 use common::prelude::*;
-use hwcore::{
-    Clock, ClockEvent, DeviceImpl, DeviceMethods, DeviceState, IRQState, InterruptSource,
-    ResetType, ResettablePhasesImpl, SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
-};
+use hwcore::{prelude::*, ClockEvent, IRQState};
 use migration::{
     self, impl_vmstate_forward, impl_vmstate_struct, vmstate_fields, vmstate_of,
     vmstate_subsections, vmstate_unused, VMStateDescription, VMStateDescriptionBuilder,
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 1560dd20c6b..fa1765a2302 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -51,6 +51,7 @@ _hwcore_rs = static_library(
       'src/lib.rs',
       'src/bindings.rs',
       'src/irq.rs',
+      'src/prelude.rs',
       'src/qdev.rs',
       'src/sysbus.rs',
     ],
diff --git a/rust/hw/core/src/lib.rs b/rust/hw/core/src/lib.rs
index b40801eb843..491743d2b9d 100644
--- a/rust/hw/core/src/lib.rs
+++ b/rust/hw/core/src/lib.rs
@@ -8,6 +8,11 @@
 mod irq;
 pub use irq::*;
 
+// preserve one-item-per-"use" syntax, it is clearer
+// for prelude-like modules
+#[rustfmt::skip]
+pub mod prelude;
+
 mod qdev;
 pub use qdev::*;
 
diff --git a/rust/hw/core/src/prelude.rs b/rust/hw/core/src/prelude.rs
new file mode 100644
index 00000000000..c544c317b39
--- /dev/null
+++ b/rust/hw/core/src/prelude.rs
@@ -0,0 +1,14 @@
+//! Essential types and traits intended for blanket imports.
+
+pub use crate::qdev::Clock;
+pub use crate::qdev::DeviceState;
+pub use crate::qdev::DeviceImpl;
+pub use crate::qdev::DeviceMethods;
+pub use crate::qdev::ResettablePhasesImpl;
+pub use crate::qdev::ResetType;
+
+pub use crate::sysbus::SysBusDevice;
+pub use crate::sysbus::SysBusDeviceImpl;
+pub use crate::sysbus::SysBusDeviceMethods;
+
+pub use crate::irq::InterruptSource;
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index 247d812866d..b39d1501d5b 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -5,7 +5,7 @@
 use std::{ffi::CStr, ptr::addr_of};
 
 use bql::BqlCell;
-use hwcore::{DeviceImpl, DeviceState, ResettablePhasesImpl, SysBusDevice};
+use hwcore::prelude::*;
 use migration::{VMStateDescription, VMStateDescriptionBuilder};
 use qom::{prelude::*, ObjectImpl, ParentField};
 use util::bindings::{module_call_init, module_init_type};
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index e9c7afa24d5..7ab9897cdfb 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -12,10 +12,7 @@
 
 use bql::{BqlCell, BqlRefCell};
 use common::prelude::*;
-use hwcore::{
-    DeviceImpl, DeviceMethods, DeviceState, InterruptSource, ResetType, ResettablePhasesImpl,
-    SysBusDevice, SysBusDeviceImpl, SysBusDeviceMethods,
-};
+use hwcore::prelude::*;
 use migration::{
     self, impl_vmstate_struct, vmstate_fields, vmstate_of, vmstate_subsections, vmstate_validate,
     VMStateDescription, VMStateDescriptionBuilder,
-- 
2.52.0


