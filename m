Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05524E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1V-0004UG-1p; Fri, 20 Dec 2024 09:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1N-0004SA-Lb
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1K-0006bF-SN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oLxf8SYyc8CAW4GO5JtinxFGsZxKuKqfgDppOT1xqOU=;
 b=Y8k9W6zO5586ykU6BdGydZnLEKMbaTIZ7z2gQDUW0IcmZ8mF2be1xAU/YoOYmUgEhYyKwl
 7YV6LKWVXAq+pChZ8MkTOjl5Eil5C4isNthct1vMSTCzsvWNTf7C3AFLDn065sf8eULZ6g
 9xUDASF7PEyUl39l4am9qj8iXITCtng=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Qf08Vmz2PMOv96ystZmCyQ-1; Fri, 20 Dec 2024 09:30:21 -0500
X-MC-Unique: Qf08Vmz2PMOv96ystZmCyQ-1
X-Mimecast-MFC-AGG-ID: Qf08Vmz2PMOv96ystZmCyQ
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361a8fc3bdso11135455e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705020; x=1735309820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oLxf8SYyc8CAW4GO5JtinxFGsZxKuKqfgDppOT1xqOU=;
 b=Jnym0RuAmTeZ4BEC5lbBsGxri8CWBcdJRiNCwUQS67/nIdUGfhCb7d2Oqq/S/Y/isX
 N7GBBt4iWTqKThs+UIyANitByKRK/GJ+ct8PA8yntMioQQSgVUtnyOniXQsFL/GtL9Xx
 FR27BsWuqrLhsnQGPbPeMjuVIzZsqueWVtC8mwWB8LQxbh1bhtxYD5nu56PLnzRAIdvV
 BjZkq+fqR4IR/OpPlgSQn/9ZMpkF811qJCXeJc7CycHzfA1g+BP/gfCyBZA+3UR9Ng4f
 UBOIHJZsbPatiuJQHJUQoagfReHQRp53gAL9WmglHiTMxlR2c9K2oByoCKvhcXMdOMBU
 7FnQ==
X-Gm-Message-State: AOJu0YzglDfwPxa9Vp4h9k6fEHx3v1MKFGboevyDc7M7vtY9tnnLz/Oh
 84Z/XWZrayc2ofX9O9fZiu0fH3+1t51WX9YLtj435cd2LMtr1N8idklRwRBaQ1xOZR9WmtjGK/h
 fKvRwEq4RxGz2bpO6NBrsvUa6IY62YDWpDTLxnTlB0qhkNy2zSZdrJj3T6kFxvQgn9vH6/WJPx9
 WmYIsVKZM/WAE4kkktiYKKu6EUjHvXhqF7q3n4
X-Gm-Gg: ASbGncsI1VyOsBWLNYdL2uTePlo1LJngWlpCzXqjNgACLm9oNatG3bHoYEP+lQzv2dc
 QKm0Lny5zb0fJ63cwWN5YRht6h/8KGFZR49VsrpiarbrlUboc+1h30RhG6gC/CiH3elOILwC/tD
 fpNVO30WvskP3bUxyvOTsj5CpmVtQYH5vdBOO1S3L/d3MWBfTM+83u0INR8iXZvMSRjLg2ATqqR
 1eCU5UX/35SxN2LZy+B1Y3tAfYDmRUqJXz/28p2hOVLXDFR5edCanH7jNRy
X-Received: by 2002:a05:600c:4f09:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4366864636dmr28668225e9.17.1734705019643; 
 Fri, 20 Dec 2024 06:30:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+NnV0YF5Sr7YZ3y8TjPcAqyNNQXLBS8X8FBLy35qksVx98k94lBzfvCM1SFQ8v9Rv56x/0w==
X-Received: by 2002:a05:600c:4f09:b0:434:a711:ace4 with SMTP id
 5b1f17b1804b1-4366864636dmr28667835e9.17.1734705019127; 
 Fri, 20 Dec 2024 06:30:19 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8a6abesm4186372f8f.90.2024.12.20.06.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 09/12] rust: qdev: expose inherited methods to subclasses of
 SysBusDevice
Date: Fri, 20 Dec 2024 15:29:51 +0100
Message-ID: <20241220142955.652636-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The ObjectDeref trait now provides all the magic that is required to fake
inheritance.  Replace the "impl SysBusDevice" block of qemu_api::sysbus
with a trait, so that sysbus_init_irq() can be invoked as "self.init_irq()"
without any intermediate upcast.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  6 ++----
 rust/qemu-api/src/irq.rs         |  3 +--
 rust/qemu-api/src/prelude.rs     |  2 ++
 rust/qemu-api/src/sysbus.rs      | 17 +++++++++--------
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 6792d13fb77..994c2fc0593 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -207,11 +207,9 @@ unsafe fn init(&mut self) {
     }
 
     fn post_init(&self) {
-        let sbd: &SysBusDevice = self.upcast();
-
-        sbd.init_mmio(&self.iomem);
+        self.init_mmio(&self.iomem);
         for irq in self.interrupts.iter() {
-            sbd.init_irq(irq);
+            self.init_irq(irq);
         }
     }
 
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 6258141bdf0..378e5202951 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -24,8 +24,7 @@
 ///
 /// Interrupts are implemented as a pointer to the interrupt "sink", which has
 /// type [`IRQState`].  A device exposes its source as a QOM link property using
-/// a function such as
-/// [`SysBusDevice::init_irq`](crate::sysbus::SysBusDevice::init_irq), and
+/// a function such as [`SysBusDeviceMethods::init_irq`], and
 /// initially leaves the pointer to a NULL value, representing an unconnected
 /// interrupt. To connect it, whoever creates the device fills the pointer with
 /// the sink's `IRQState *`, for example using `sysbus_connect_irq`.  Because
diff --git a/rust/qemu-api/src/prelude.rs b/rust/qemu-api/src/prelude.rs
index 6f32deeb2ed..4ea70b9c823 100644
--- a/rust/qemu-api/src/prelude.rs
+++ b/rust/qemu-api/src/prelude.rs
@@ -16,3 +16,5 @@
 pub use crate::qom::ObjectType;
 
 pub use crate::qom_isa;
+
+pub use crate::sysbus::SysBusDeviceMethods;
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index b96eaaf25f2..e6762b5c145 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -32,18 +32,17 @@ fn class_init(sdc: &mut SysBusDeviceClass) {
     }
 }
 
-impl SysBusDevice {
-    /// Return `self` cast to a mutable pointer, for use in calls to C code.
-    const fn as_mut_ptr(&self) -> *mut SysBusDevice {
-        addr_of!(*self) as *mut _
-    }
-
+/// Trait for methods of [`SysBusDevice`] and its subclasses.
+pub trait SysBusDeviceMethods: ObjectDeref
+where
+    Self::Target: IsA<SysBusDevice>,
+{
     /// Expose a memory region to the board so that it can give it an address
     /// in guest memory.  Note that the ordering of calls to `init_mmio` is
     /// important, since whoever creates the sysbus device will refer to the
     /// region with a number that corresponds to the order of calls to
     /// `init_mmio`.
-    pub fn init_mmio(&self, iomem: &bindings::MemoryRegion) {
+    fn init_mmio(&self, iomem: &bindings::MemoryRegion) {
         assert!(bql_locked());
         unsafe {
             bindings::sysbus_init_mmio(self.as_mut_ptr(), addr_of!(*iomem) as *mut _);
@@ -54,10 +53,12 @@ pub fn init_mmio(&self, iomem: &bindings::MemoryRegion) {
     /// Note that the ordering of calls to `init_irq` is important, since
     /// whoever creates the sysbus device will refer to the interrupts with
     /// a number that corresponds to the order of calls to `init_irq`.
-    pub fn init_irq(&self, irq: &InterruptSource) {
+    fn init_irq(&self, irq: &InterruptSource) {
         assert!(bql_locked());
         unsafe {
             bindings::sysbus_init_irq(self.as_mut_ptr(), irq.as_ptr());
         }
     }
 }
+
+impl<R: ObjectDeref> SysBusDeviceMethods for R where R::Target: IsA<SysBusDevice> {}
-- 
2.47.1


