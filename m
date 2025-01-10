Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7972AE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK35-0001n8-Bx; Fri, 10 Jan 2025 13:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK28-0000Fg-VS
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK26-00017V-AW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T21y/qv6KGXhkm5awrBknNed29ZtW5ncvJ4QzS+vajE=;
 b=BYq2cpHY79G++F6IwUc/ZGN8l8zUGT6igoX5X+XQnnOgUHVeE1TBtyq+JoN0ejJDxjnvO7
 J5baogjkRI+W0tRtq2sQ94Kskt8lBoW6xYomXk1aW3ynlEj7rveTscIFUxBs8tIylVwKX3
 3hZIJj/rkEzILCNBkE+DC/Z6TnktoBs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-zTxq1llnMIqKZX99AAlpWw-1; Fri, 10 Jan 2025 13:46:54 -0500
X-MC-Unique: zTxq1llnMIqKZX99AAlpWw-1
X-Mimecast-MFC-AGG-ID: zTxq1llnMIqKZX99AAlpWw
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d124077928so1969239a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534812; x=1737139612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T21y/qv6KGXhkm5awrBknNed29ZtW5ncvJ4QzS+vajE=;
 b=ZVXYa3zX9UOhqxKF+Rkjfj390xZx3knbp6erDAf2dZjsmhmqDFeQDl0fi+QDlHfL51
 Tm6kSy2A3opDWLIUcFh2WRikkAiEtgJVkZoZTxCEa7zKxhwyj0ZyncKTUg6gA7H9G/w5
 5ftbTQ50saov0w1Rzm+GDxT3aZa+zgUbtBSnZdUi9waqsfZ5lDPo+wziSGQzsbgLfAbW
 pfgfOetqI1/EI5KL2NwXp5CymEXhTKvEYHL/Uh38t97hvSsLKs09hqAGVQvqo/zFVIj8
 yAWN9HX0cKqqTPW5FZ5NQey7w9WT6hH/FvYgxnyDmnM8Lh5cQjBLVBiLcmzKTek9ChjW
 /MiQ==
X-Gm-Message-State: AOJu0YyexqaRY2RreN7Kpz/SgztNj0JOjBOwbD6oyIIr+hdaUi1ZYuJL
 1Y4XktUtMxFBv54Ji2bZuOOMRk3gWedUJJYRouxzNNtisLkJ/jwQ/dIkkyGJkyFxCGMhlzUhzBo
 o7DDFJfYdoB6xmwnpaSUl9Wq9/VQW6M7d6n5c43+67EJIhLjphpnmAqFoP8VUN8VW/laotK0WX0
 gXxkzPjShc3y5p00w05sVSyaIedM/BLsGtnM0Uhw4=
X-Gm-Gg: ASbGncvyb0IbdvruJbL4q/XlgHxpGX+iKrgyJTFmV0cTiYTJ35rkY/2YFYo5Sc1OIf3
 1M5A/VlWxebeJug1YIbsfQuZIR/azIeQUjLZmIgR+/g2gz0+hILOwb8fnuoNK+74fPyxmnZL4Km
 J+JvZIi/P2BBOSIgLKs00qSaAr74vkroJIzpCsF+KvtUu+Zehv92XGcPuTWGPWxa+rQhUnl31nY
 Wl/4bpQG7/BriTpaqXylpFJ+o440Rc+hBB7scNxtbIc9OUIoAv4Ul3uxF0=
X-Received: by 2002:a17:907:2cc5:b0:aab:cd45:5d3c with SMTP id
 a640c23a62f3a-ab2abdbfa0bmr1140054866b.50.1736534812444; 
 Fri, 10 Jan 2025 10:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFulgBXuRMrjbpVT2zuHYlxQVC5eIzqdaSHJsjFaLi/GNflO8mx/XmyaQVqrH6VZQ+Dt0rXEA==
X-Received: by 2002:a17:907:2cc5:b0:aab:cd45:5d3c with SMTP id
 a640c23a62f3a-ab2abdbfa0bmr1140052566b.50.1736534811930; 
 Fri, 10 Jan 2025 10:46:51 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c906004fsm192989866b.30.2025.01.10.10.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 13/38] rust: qdev: expose inherited methods to subclasses of
 SysBusDevice
Date: Fri, 10 Jan 2025 19:45:54 +0100
Message-ID: <20250110184620.408302-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


