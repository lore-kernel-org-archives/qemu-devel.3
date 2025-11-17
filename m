Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358F0CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKttk-0003Yo-5E; Mon, 17 Nov 2025 02:43:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtt0-0003Rq-4V
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtsy-0005ve-Es
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763365371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/qrIn0AvFVaoDVF4vr0euvjESxVs46yfDtsWTtlMTM=;
 b=PpCWGel2CRTmdgi8JC2Hv8DRZipTJ5yxkBhvdZ4z5nyr/YdrxTYbBv4IrBi1R5kGlqRbGB
 +9uvE4mwxgE61dmcD/wLoXPbXOfUf6CqDky7gzmxU4CIWc9QxGPWQkv/CQn1udZpA6ocWG
 NzxCXwsomCEF4y9/L4vfkCT/CdForJM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-ests_dtlM6iFbbkN37kCWQ-1; Mon, 17 Nov 2025 02:42:49 -0500
X-MC-Unique: ests_dtlM6iFbbkN37kCWQ-1
X-Mimecast-MFC-AGG-ID: ests_dtlM6iFbbkN37kCWQ_1763365369
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a1e2b372so11292575e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 23:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763365368; x=1763970168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/qrIn0AvFVaoDVF4vr0euvjESxVs46yfDtsWTtlMTM=;
 b=pdkODSbdEGKVVYDEVEkM2V2enIQs87HDv8vEnAArUZS7KlAPDm7IeEwQVER/JlbzM9
 ZEFQ4eaLogoEtlkOVqEQwAM9Mpd8bVXJO5Z05gwaqhnh6evHLFjlnsEY+pwrWUUwduqX
 R2X54ti4fi/l3mTuOeFj8tZeiQaBU4m71RNW+TKZsS9iSOWJRPZD/2MI5X03Q4NyVNhg
 d/wmtXi+2haFr6CbZQPsSxj7t9BUOrd20R7J0kXQ+QD+zbAIq4Fl1RM4iDN27ApEI/ea
 2mjz8qyoApxqd5CeUNSt/6tsAFq8C2zp6+lntgmdGD4TuQu4hXUWMCNxNE9En4Oe4SZa
 0HPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763365368; x=1763970168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7/qrIn0AvFVaoDVF4vr0euvjESxVs46yfDtsWTtlMTM=;
 b=IBZshS7k6sLujx2o5ns4FLp1B1DYYfQdxiWv5cV2iAWScQSlXwgkTcI5e/VXP5df5e
 L30lFYwCGS6wcmiNEdxYv45Y1kjf5hYfelu/DiACYyqOm1RJkwr0JETo0mYL2Or/1il9
 G+Khsn0M+qnHzgEyt3+ZfUfe+n+c4O1bwug3KvAq95/OTXMi+6R9alN9C7PEH2kHIM4W
 9xq0bUiBjXcjPr/r8I+4DG3fudGJqvT9mIXtm807eYEK6DH62z7IsC5ayO7flYHpmp+P
 A+TqQBQJcGXyPhy1TJZKSzYPczx4cz30D+nHvNK1Mg298d4Yseq0cUxUgUkaYAX3KQsO
 WVJA==
X-Gm-Message-State: AOJu0YxdOasD8XX+RqbvUcQNr+HSvjVhClclxYX4k76ay2YQUjq0FBTi
 zArb+36eCqxn7rFZ51TPnYCXvHDZVg04JydWgt/M+UBxvccCRJz57Q3ZYFgng7hfcDBgKtmAVz9
 XJcp7SOnZPwFPCVqjE+J7H1djER2PhX57kE+xKv+83ydnGhCQJvnTg6FPZ4DRa0sO2C8yqecrWv
 42bxMbL7xJeRDKLlS0kWmXcg/u8Qwl3sU/MvWcawI1
X-Gm-Gg: ASbGncuAXODi6/Qf4Z/wSFXTnrq0gfv1j+VmZRVS7IwRfBQuPbFd/I+0/Y6VlSwpYh3
 GAyReddu2lveC6j23rBfpV0ynMIzd49UFp7fiYF9/SDAdtH5vVohAxP6+6swPIzs8pYqHqdtm1Z
 K5SVfbu0ThovTTqOG183udTgbM6NwyOtPRC6qrqXJfB9kk2/LJ3KqByyHbDy3wHKhlpWLf/OE0Y
 afdr+U/3UkRh12TMvdszrO1S+DeJIEB4zqP6f59fp7GRdyZAX5StqmRJKkwimuhvxzSluJHX++L
 gRfZkYfNMplgXZLaJbt4ntFMZPIfPpBwj7Irz+V94A5lGn/Q+tg3vRkjI2GkIuzjb0r8o+k/4IV
 IG9T7jEWqrtd92+ifWtgHcYwlvg4h/bM2gl1G1ipCRyddFKJOlOiniMeY5oZ3R4QKSyh3G7rcG8
 VUPE3p
X-Received: by 2002:a05:600c:4503:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-4778feb23dfmr97404265e9.36.1763365368336; 
 Sun, 16 Nov 2025 23:42:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGheM/f1OTkMQZwJPst9G+ieKpF0gUZlMwrJAkIuQzwGdTJtyn9KhW/OIelH1RaN/JHDTrOBg==
X-Received: by 2002:a05:600c:4503:b0:45b:80ff:58f7 with SMTP id
 5b1f17b1804b1-4778feb23dfmr97404055e9.36.1763365367922; 
 Sun, 16 Nov 2025 23:42:47 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779fab9b0esm73883205e9.12.2025.11.16.23.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 23:42:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 3/8] hwcore: add prelude
Date: Mon, 17 Nov 2025 08:42:33 +0100
Message-ID: <20251117074239.190424-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117074239.190424-1-pbonzini@redhat.com>
References: <20251117074239.190424-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
2.51.1


