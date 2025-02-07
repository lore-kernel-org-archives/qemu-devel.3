Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA44DC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQS-000865-MM; Fri, 07 Feb 2025 05:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQQ-00080E-Op
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQP-0004MU-13
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aKHP+M1YbRMZ4IFrh+t3bRBHjugSohWNkvOiKtYRuX0=;
 b=UaAUiSWpIRWZf17yN1D7gFgshzvAzkdivKrC0jOuk86Nmrz+9ebyS9NVeOo8MdrAevQNFG
 Ea4JW2pQVbZJH594U6yjlhpypLnHRq42UfIYVtDUg0bMyZVZeFE06yl7EpHY0Ky9qWl1aT
 t09HE7NLjUv/Ioet7W7Z+Tix+0E61V0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-Cm-MlBMpNX-bD5gx_R60VQ-1; Fri, 07 Feb 2025 05:17:27 -0500
X-MC-Unique: Cm-MlBMpNX-bD5gx_R60VQ-1
X-Mimecast-MFC-AGG-ID: Cm-MlBMpNX-bD5gx_R60VQ
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa67f03ca86so137824466b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923444; x=1739528244;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKHP+M1YbRMZ4IFrh+t3bRBHjugSohWNkvOiKtYRuX0=;
 b=GMSUq9/aZbZldIDUT6+UNv5zdJI+rV5FrUvKJX4PWsjSvB75D0cg9nknnrryIyQKUc
 x91CNASTtLIRcVFyJQX9rryTs2/TwYfC5GeWOOrfX+deI7TvYFXdfZy3gCFfXF+d3JLC
 GDKtT3hH0DsjW6ODHkAciGi6ojeSqbO4ighqxwxEaH0ORNI2eCgd1iUMiylk9M3XHcGW
 ppq1MbU5pfKj3SKJnX3S25iTdBHh8UQfCoEhAariNGjmpaD6oG0oKDzNn+fC9J2UFcLv
 Hy+Yzrt3Vw8vGLwE2WxuyPfpG96zUEnIf3I9xvcygccSFwTbocjp7zIlUEupzaGRzrhQ
 AKtA==
X-Gm-Message-State: AOJu0YxvfL0F0OO1tMsEsCrC4TMUzRG4F4TWSsp17jTYeg70MBTCUWU1
 9dDv+SrbnfWNtNLHJnxY4OrZxma9EDGzuDvkJxh6fINDgkIpVwh/i0sVc1eT8L25BFi52Cta8ut
 0c47bH0+EpE2mBuCs1lqTz3Q5290nA5DytkL7XEhFBJzHeDhs2Yx+tsEHtcKkLwOKi6htaYkM5e
 ix2w5VMdFAOKRjEwJSooXcqvHwanpM8S2cfgAFU6E=
X-Gm-Gg: ASbGncsKvPO49whNTx2/NcagMpXq2DmY+YKqHVJ8uM+i9+OtJ9FtEj/YiLdroln/cTh
 M6Dc+17lkdfhJ1ybJAQ4ZkgNS8e1LVkVL7ZJXeXwJVgQ0SMqpmpmHW2rhPQA2KrYmBItnbzgyui
 1ien0+Zod3fckFBfvAF66oR014ThHAW4RtJJRIbyBvUEEvn92XfBtLddkw24BzpPg9evjHwg9Gi
 fzEH4i120UyEOBfWDg088pwAw2UlI0GxBx/25ztp89WxpJXNXqv3IgOFwlNSJ/kfQdbrxKnzbga
 ExQpUg==
X-Received: by 2002:a05:6402:2392:b0:5de:4a8b:4c9c with SMTP id
 4fb4d7f45d1cf-5de4a8b4fc4mr3255591a12.32.1738923444191; 
 Fri, 07 Feb 2025 02:17:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfsoSU1JKMR6X86QsmGLSD3TaYkv4VQukNlw/UjcAmcXXn4FgyZ4tohgtK6GEsxcTAsO+s9g==
X-Received: by 2002:a05:6402:2392:b0:5de:4a8b:4c9c with SMTP id
 4fb4d7f45d1cf-5de4a8b4fc4mr3255525a12.32.1738923443524; 
 Fri, 07 Feb 2025 02:17:23 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b85a4dsm2272828a12.47.2025.02.07.02.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:17:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 11/12] rust: chardev, qdev: add bindings to qdev_prop_set_chr
Date: Fri,  7 Feb 2025 11:16:22 +0100
Message-ID: <20250207101623.2443552-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Because the argument to the function is an Owned<Chardev>, this also
adds an ObjectType implementation to Chardev.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  1 +
 rust/qemu-api/meson.build        |  1 +
 rust/qemu-api/src/chardev.rs     | 19 +++++++++++++++++++
 rust/qemu-api/src/lib.rs         |  1 +
 rust/qemu-api/src/qdev.rs        |  9 +++++++++
 5 files changed, 31 insertions(+)
 create mode 100644 rust/qemu-api/src/chardev.rs

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 5e4e75133c8..22f3ca3b4e8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -15,6 +15,7 @@
         sysbus_mmio_map, sysbus_realize, CharBackend, Chardev, QEMUChrEvent,
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
index 8cc095b13f6..1d7112445e2 100644
--- a/rust/qemu-api/src/lib.rs
+++ b/rust/qemu-api/src/lib.rs
@@ -17,6 +17,7 @@
 pub mod c_str;
 pub mod callbacks;
 pub mod cell;
+pub mod chardev;
 pub mod irq;
 pub mod memory;
 pub mod module;
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 2ec1ecc8489..0041c66ed0c 100644
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
@@ -299,6 +300,14 @@ fn init_clock_out(&self, name: &str) -> Owned<Clock> {
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


