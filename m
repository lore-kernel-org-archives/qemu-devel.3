Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DA8E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1W-0004UM-Rq; Fri, 20 Dec 2024 09:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1E-0004RA-OH
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1C-0006Zt-Ue
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBnoMQiocVwxb195C5dPLUMqfWHTI2r8yktVChDs01k=;
 b=dqYcT0NMIQZcmBDqtvaoqioVIxKNURgw522bF2QFnXmcptIvPVsp5BeE5ThrEM/iBYSIq3
 GVgKXd62i1ZgPyJsbjL4OGGPvslzWlwJATXiRJdUnm4t7UTKCVL85G32ePytFrtKUd0gM4
 uYQqVO3eXGL5RW9xSl8csfaA+o6/l7k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-rRHoOZWWMOKcxJpXQp3TJg-1; Fri, 20 Dec 2024 09:30:16 -0500
X-MC-Unique: rRHoOZWWMOKcxJpXQp3TJg-1
X-Mimecast-MFC-AGG-ID: rRHoOZWWMOKcxJpXQp3TJg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43646b453bcso11453005e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705015; x=1735309815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBnoMQiocVwxb195C5dPLUMqfWHTI2r8yktVChDs01k=;
 b=X+ZwjPRB3XiniGlHxrbldkg6PkGNnUkukNSg3vdEVtIN7NewO7kgbj1oHZ3RuAuwsp
 AIJ9N4KnaXbCwAOV9G7SzMa1i5b9YQA+lOXXf7R3BOLqeeO40q7Ys8ETQY5Fg34QNh9G
 ilzSCouDDI6OAXGnIbaG90hL3rkAMV6AXF6qFUQgpcPLoerLnmxarPb1rfT5xPVWH4TP
 SSK99lgGRyVvDC9O2u+X/o3OW4vqQ2rMcFdsV39elvzWQunyVRbxZRqX0fdElEDdgoqg
 /5xynV9UKbNdfNNX9P7RY1d8s0MbgU6RtJaInGQO4+DdTuej0F37RgygG9BF5ZIxnGx0
 5ggA==
X-Gm-Message-State: AOJu0Ywd8E8dnLDACkJ32644t6ToFghXZliMoPuDxOg8bdtfelEDpy/o
 8a0Xfu634U/wdyKspxmIbt2ZyOQBBrLvznh5giGxVbY5cvHGg6UTsmrP4wdMOvebgYlTgDCHybR
 ZEl3B9mB3dXBmXrD0vBr4c1R4kFY8Zdkm+A3UqwaQcVE2FhLyz/Bes2JUxWpqTO9p5ZVYrFVXRE
 p05uV2vSOAm8cuotAA91sZmvqplzf69pZIro0R
X-Gm-Gg: ASbGncuNFESj/3ARyoLsLB68KkRGk74FHK7GzPjaEiahC/kPn2IJxJ3/2koBl/pit5A
 G86vkfiuJMVaLa6ipqWQV5xwartB8i8JqpUoUmCbJ68XYZ4Gx6METaNyX3l9q9KxweEjzWFS9vC
 TcqdCJEJea4/IHxZsgSRl3gFJmNIiGM+DB9WH5WpgHSdgejZ1yWEeKS2DtRb9FzvljRm7KwxH+r
 Z237qtspxcks5xVJWT93U3tUbBu9sitN1O5oE2nPEOI0gltaTsrjdqDeez2
X-Received: by 2002:a05:600c:1c0b:b0:436:1ac2:1ad2 with SMTP id
 5b1f17b1804b1-436686469d0mr27737375e9.19.1734705014991; 
 Fri, 20 Dec 2024 06:30:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl+ewunVjR6mCinfVZP+thQDwAsqkHpYJCgLoAuS8zEHmuseEDKxqGa6DmjfD0VI9ZoD7XUA==
X-Received: by 2002:a05:600c:1c0b:b0:436:1ac2:1ad2 with SMTP id
 5b1f17b1804b1-436686469d0mr27737085e9.19.1734705014576; 
 Fri, 20 Dec 2024 06:30:14 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366128a44fsm46908405e9.43.2024.12.20.06.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 07/12] rust: pl011: only leave embedded object initialization
 in instance_init
Date: Fri, 20 Dec 2024 15:29:49 +0100
Message-ID: <20241220142955.652636-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Leave IRQ and MMIO initialization to instance_post_init.  In Rust the
two callbacks are more distinct, because only instance_post_init has a
fully initialized object available.

While at it, add a wrapper for sysbus_init_mmio so that accesses to
the SysBusDevice correctly use shared references.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 18 ++++++++++--------
 rust/qemu-api/src/sysbus.rs      | 12 ++++++++++++
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 215f94a6e4a..72a4cea042c 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -145,6 +145,7 @@ impl ObjectImpl for PL011State {
     type ParentType = SysBusDevice;
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
+    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = Some(Self::post_init);
 }
 
 impl DeviceImpl for PL011State {
@@ -183,14 +184,6 @@ unsafe fn init(&mut self) {
                 Self::TYPE_NAME.as_ptr(),
                 0x1000,
             );
-
-            let sbd: &mut SysBusDevice = self.upcast_mut();
-            sysbus_init_mmio(sbd, addr_of_mut!(self.iomem));
-        }
-
-        for irq in self.interrupts.iter() {
-            let sbd: &SysBusDevice = self.upcast();
-            sbd.init_irq(irq);
         }
 
         // SAFETY:
@@ -213,6 +206,15 @@ unsafe fn init(&mut self) {
         }
     }
 
+    fn post_init(&mut self) {
+        let sbd: &SysBusDevice = self.upcast();
+
+        sbd.init_mmio(&self.iomem);
+        for irq in self.interrupts.iter() {
+            sbd.init_irq(irq);
+        }
+    }
+
     pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
         use RegisterOffset::*;
 
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 8193734bde4..b96eaaf25f2 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -38,6 +38,18 @@ const fn as_mut_ptr(&self) -> *mut SysBusDevice {
         addr_of!(*self) as *mut _
     }
 
+    /// Expose a memory region to the board so that it can give it an address
+    /// in guest memory.  Note that the ordering of calls to `init_mmio` is
+    /// important, since whoever creates the sysbus device will refer to the
+    /// region with a number that corresponds to the order of calls to
+    /// `init_mmio`.
+    pub fn init_mmio(&self, iomem: &bindings::MemoryRegion) {
+        assert!(bql_locked());
+        unsafe {
+            bindings::sysbus_init_mmio(self.as_mut_ptr(), addr_of!(*iomem) as *mut _);
+        }
+    }
+
     /// Expose an interrupt source outside the device as a qdev GPIO output.
     /// Note that the ordering of calls to `init_irq` is important, since
     /// whoever creates the sysbus device will refer to the interrupts with
-- 
2.47.1


