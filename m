Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFB4C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 16:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibey-0000yv-TE; Thu, 13 Feb 2025 11:01:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibeo-0000uC-V2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tibel-0005XQ-4a
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 11:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739462496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+SMasJt000rT1ae4EhUEs5xt45LQa6MMA6T4RmgKLs=;
 b=NQFnqXED52jLMFsn1QZhh+SYL1Y+9DG9qjPaUugWWBmpkvLSP3j1J/GjKRr1qa3NR7ouNB
 L0XzApyNKk/GwVTZcQcrleSTTOJ61w9fVzm0lDkcPT6u5s9REacmEB1X9mk9vv9T060m0h
 zBHwzLCV+lg20fF+isSUrqg2sTFoVKU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-f2meafQUNS-3l7Hzskm6Tw-1; Thu, 13 Feb 2025 11:01:34 -0500
X-MC-Unique: f2meafQUNS-3l7Hzskm6Tw-1
X-Mimecast-MFC-AGG-ID: f2meafQUNS-3l7Hzskm6Tw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f28a4647eso341220f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 08:01:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462492; x=1740067292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S+SMasJt000rT1ae4EhUEs5xt45LQa6MMA6T4RmgKLs=;
 b=jGRNLN8XdaFSh0hPFD0OfW4GcEcwiyDLqTQveIRTXjF0i5bqqJcyGfkqSyaMLH7Yts
 goralXXDqRGYaYQAbVrqg5UdF0kPukgLI0xAHixkm+P0kL5fF6a9e7fTAaWJWHS02o1W
 r3oVvFO+gvbMmi50VFq9llQfs61sACSRpoG6awAxGJuyEPHPwVMIo4Y/VqEPurmmSqZR
 9HBYb8HMnTnnTHNRPgtexvE+hjCNdEDu2Yne+zIZsOHXanyWvi2vSjfe0sqLJSXAUlef
 /gzCj/lQROe1j01duYTwtCXoOkXUnbAPONTUDY/A3HiJ3mtBBzIoOornnJ0NaNGepto7
 w8gg==
X-Gm-Message-State: AOJu0YwX5EOsxRtA8QJ166kPP61LlNFHSR21UabJVvYDRdnm32IyFk9t
 GrEGRa46b8cGSN8Bo6vN01t6Gq13tBgK3anaua+C0q97REnio9/OD2sxm71ebePxGhXkUZfeDO1
 bBTi2JlBFgnsu2jX3BxH5f7p0I4zmneoucb3g5Tn0/lOldK3tlzEEL0TYZpJGQF4V5+lOoYv4GY
 GC2kC7pHSJlbVg3rGeD3JgOZrg5T+s67yHMU8tq84=
X-Gm-Gg: ASbGnct526d/tWWkkZlL+0kMzaK8iHQgAad1W7w6zD7qtUfgADjeTsI/pj1ZAa9pwgM
 kDSamiBQ0tW2NqPEIT+RT/LlEZj6CaljOCoX2KxIdUlZovH9QHH6pUvijLb27f5ZyVlQdq7TVUk
 TPjvXvPyA/enExIhrPlCvrAoeaNAV77/hsqb7TuXu4KpZjOGcIvYFz8pUwVp1HSUzKRg2Z5BlzK
 Ae0+JKtH6ROKHOeZ0CsJd6+TkZhVYgD5DnDuzMsnQ3WRwpQkjQQ3JWwQQ3VJB/j4WzyVsoRAfjZ
 mO/dtghkJN3yuUdPCEzsy+JZxsh8xAbPk4J8sFp/5UmYTQ==
X-Received: by 2002:a5d:47af:0:b0:38d:de45:bf98 with SMTP id
 ffacd0b85a97d-38f244d6481mr4693589f8f.8.1739462492186; 
 Thu, 13 Feb 2025 08:01:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFwGxN7AEXtFao+iZL6ulae/eZoNGoDW+fdOz5CHBb1iLUDoq6Y+EfHKr41tk5ixLrU/unVg==
X-Received: by 2002:a5d:47af:0:b0:38d:de45:bf98 with SMTP id
 ffacd0b85a97d-38f244d6481mr4693419f8f.8.1739462490087; 
 Thu, 13 Feb 2025 08:01:30 -0800 (PST)
Received: from [192.168.126.123] (93-38-211-213.ip72.fastwebnet.it.
 [93.38.211.213]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b432asm2207575f8f.6.2025.02.13.08.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 08:01:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 12/27] rust: chardev, qdev: add bindings to qdev_prop_set_chr
Date: Thu, 13 Feb 2025 17:00:39 +0100
Message-ID: <20250213160054.3937012-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213160054.3937012-1-pbonzini@redhat.com>
References: <20250213160054.3937012-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Because the argument to the function is an Owned<Chardev>, this also
adds an ObjectType implementation to Chardev.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  3 ++-
 rust/qemu-api/meson.build        |  1 +
 rust/qemu-api/src/chardev.rs     | 19 +++++++++++++++++++
 rust/qemu-api/src/lib.rs         |  1 +
 rust/qemu-api/src/qdev.rs        |  9 +++++++++
 5 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 rust/qemu-api/src/chardev.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5e4e75133c8..4e959073711 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -12,9 +12,10 @@
     bindings::{
         error_fatal, qdev_prop_set_chr, qemu_chr_fe_accept_input, qemu_chr_fe_ioctl,
         qemu_chr_fe_set_handlers, qemu_chr_fe_write_all, qemu_irq, sysbus_connect_irq,
-        sysbus_mmio_map, sysbus_realize, CharBackend, Chardev, QEMUChrEvent,
+        sysbus_mmio_map, sysbus_realize, CharBackend, QEMUChrEvent,
         CHR_IOCTL_SERIAL_SET_BREAK,
     },
+    chardev::Chardev,
     c_str, impl_vmstate_forward,
     irq::InterruptSource,
     memory::{hwaddr, MemoryRegion, MemoryRegionOps, MemoryRegionOpsBuilder},
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 80eafc7f6bd..45e30324b29 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -20,6 +20,7 @@ _qemu_api_rs = static_library(
       'src/bitops.rs',
       'src/callbacks.rs',
       'src/cell.rs',
+      'src/chardev.rs',
       'src/c_str.rs',
       'src/irq.rs',
       'src/memory.rs',
diff --git a/rust/qemu-api/src/chardev.rs b/rust/qemu-api/src/chardev.rs
new file mode 100644
index 00000000000..74cfb634e5f
--- /dev/null
+++ b/rust/qemu-api/src/chardev.rs
@@ -0,0 +1,19 @@
+// Copyright 2024 Red Hat, Inc.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+//! Bindings for character devices
+
+use std::ffi::CStr;
+
+use crate::{bindings, prelude::*};
+
+pub type Chardev = bindings::Chardev;
+pub type ChardevClass = bindings::ChardevClass;
+
+unsafe impl ObjectType for Chardev {
+    type Class = ChardevClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_CHARDEV) };
+}
+qom_isa!(Chardev: Object);
diff --git a/rust/qemu-api/src/lib.rs b/rust/qemu-api/src/lib.rs
index e4316b21cf2..2a338a888a0 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -18,6 +18,7 @@
 pub mod c_str;
 pub mod callbacks;
 pub mod cell;
+pub mod chardev;
 pub mod irq;
 pub mod memory;
 pub mod module;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 64ba3d90981..73343e10b96 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -16,6 +16,7 @@
     bindings::{self, Error, ResettableClass},
     callbacks::FnCall,
     cell::bql_locked,
+    chardev::Chardev,
     prelude::*,
     qom::{ClassInitImpl, ObjectClass, ObjectImpl, Owned},
     vmstate::VMStateDescription,
@@ -297,6 +298,14 @@ fn init_clock_out(&self, name: &str) -> Owned<Clock> {
             Owned::from(&*clk)
         }
     }
+
+    fn prop_set_chr(&self, propname: &str, chr: &Owned<Chardev>) {
+        assert!(bql_locked());
+        let c_propname = CString::new(propname).unwrap();
+        unsafe {
+            bindings::qdev_prop_set_chr(self.as_mut_ptr(), c_propname.as_ptr(), chr.as_mut_ptr());
+        }
+    }
 }
 
 impl<R: ObjectDeref> DeviceMethods for R where R::Target: IsA<DeviceState> {}
-- 
2.48.1


