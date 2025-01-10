Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A9BE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2t-0000jv-VR; Fri, 10 Jan 2025 13:47:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1y-0000Dc-Du
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1v-000168-T3
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aX24Q+tB77pzEZ+uLwRAl7jQIydZqUxNNDKMiOl7mBs=;
 b=U+/7rWXKMesPdOqR4EiUSMHxQXfTinlbXrazhUbOA3+JEECCjF6VcFpBPkbVajiq5wlbzc
 MAXsmPmHMrDhMLOxCIIZpbuv9sui1jAsZ4QwpMlqjlC5cMYiLrWB9zctSIMfdPMGJw3Mca
 +9TSk8XXeD+ts+M/jSnXXgx+WaPmdXM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-sR28UJ-6PPqAS5NupQN1mA-1; Fri, 10 Jan 2025 13:46:44 -0500
X-MC-Unique: sR28UJ-6PPqAS5NupQN1mA-1
X-Mimecast-MFC-AGG-ID: sR28UJ-6PPqAS5NupQN1mA
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d88d37abd0so2352981a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534802; x=1737139602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aX24Q+tB77pzEZ+uLwRAl7jQIydZqUxNNDKMiOl7mBs=;
 b=hHgYGFCFPxpips8+xMI0kzO0jk6mb6gddV7FoH5MHujdv4TqXwiKd1RfvX/OOwm1jT
 XiV/J6njzyROgR7vl30YMGrbPt4ZwNdUF89eCjbHOOGcdhu2XCl/IpXcZviBRmR2XPki
 4XJW+N8QBGYA/eYaFMpEoubZU9KXkyFJULQmQLfIe2Jo04Flb3dBtoo+CnLLTN8xX6tK
 iW0dipvobOYPZjiyn61JOU0OoX3BCaAmURYY6pmDlXElt3C2eIcD1HIxzy5E/AhDdRTW
 NLahCyr1owAcBarUWi0ZqjcouaHCbIZJ9/rTyAzJTCTBL5zEGIfxLWGVqjeTzjVfx0nz
 QicA==
X-Gm-Message-State: AOJu0Yz54Rx6MpzTQ5vOUtXnVLWXORSSaB9FBFDnJJT39gd4fs0Z6gx+
 jmUT66Tm4Kupqv0YmwlvM2SJ8kYhFTpZ9CzL0qX3CKge++YGJfbg44/xzFl8IYXAnAF50I5rnFU
 q+VwKJLLyvG+QGPdDIAaVjdthJvUZLlREN1Pm9rgYGYqPrWWlYLIuSnefimiyMFhhAC+tZZyJdy
 OlE9vclWCmWBa5+wSWQWr3ir5Cq9TTtCKdWidi4yA=
X-Gm-Gg: ASbGncs9MkGZfvLjI+Pvj8185V38AxB/PO6OIHi/eESYeHweeB/bU8dBWK7eE81J132
 waZqyvq/OQS3LjUxCSkabwij89mxgA2GIddsCsJk0TBBNcwettDHaANRrLSKlFCRflv519cH4BD
 EX20SashnskHU4QjSXiYztjlBtoHnzNxSOgoDnUKrIMmx8ukNd1gf2u3FwvbyLRciIYy8CjhQPY
 m6oVQg9Hl7YKIS5Uy+GIxQ5CspIP2BBjCL/TGkz8BnF6nMdUn2qbf6FkkY=
X-Received: by 2002:a05:6402:358a:b0:5d9:a62:33e with SMTP id
 4fb4d7f45d1cf-5d972e162b0mr10754146a12.15.1736534802480; 
 Fri, 10 Jan 2025 10:46:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyMqyWmrW0lTH/osdKXu5ANogZss5mgSvFJOeeXdy9sX4c4pbArHla0T+meklCekNzPvBYjA==
X-Received: by 2002:a05:6402:358a:b0:5d9:a62:33e with SMTP id
 4fb4d7f45d1cf-5d972e162b0mr10754132a12.15.1736534802098; 
 Fri, 10 Jan 2025 10:46:42 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c39fsm1936978a12.13.2025.01.10.10.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 09/38] rust: pl011: only leave embedded object initialization
 in instance_init
Date: Fri, 10 Jan 2025 19:45:50 +0100
Message-ID: <20250110184620.408302-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Leave IRQ and MMIO initialization to instance_post_init.  In Rust the
two callbacks are more distinct, because only instance_post_init has a
fully initialized object available.

While at it, add a wrapper for sysbus_init_mmio so that accesses to
the SysBusDevice correctly use shared references.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
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


