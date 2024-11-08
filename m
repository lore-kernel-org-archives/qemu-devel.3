Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA192D64074
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJK-00024w-2d; Fri, 08 Nov 2024 13:02:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ7-0001w0-Ro
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJ6-0001wa-2h
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XeSGVNmsvm8LjvUgxmz8ceo62A+bkZyrWMrM+uvspEY=;
 b=BS6KwieEI2L6fksuG3MsAXkqkk6CLvhumZ5jCjZwOYeZefqwvOZsZHR041b0A+9W4sA+dB
 aBM2tL7M2rbYxrlhD7C91x/rBYmM6esViJu29tU5CVtXTfxCzIumgdzgKTbQyZjB3UvTlU
 QSJQEX9Puv3GIdT+NrScob9totVWbHw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-nRwnEMYJOHe6mJE1LV9HFQ-1; Fri, 08 Nov 2024 13:02:02 -0500
X-MC-Unique: nRwnEMYJOHe6mJE1LV9HFQ-1
X-Mimecast-MFC-AGG-ID: nRwnEMYJOHe6mJE1LV9HFQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43157e3521dso16472315e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088921; x=1731693721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XeSGVNmsvm8LjvUgxmz8ceo62A+bkZyrWMrM+uvspEY=;
 b=ThjLFBBr11BsHlNJw1wJ6f9MbU+T84/VP5BKXP5M6OH/YCRTUce94UwujQ+qV04iFe
 Ag/Ds3zY3Sry5aefb7MKwyHn6HrN2ftcLf1+pllV4uAyGGhwhZfp4WNaZ/s/fIiqXn1l
 F8fAdGC/fXF/ztviuP9sieubSew4Cdg0HcghXwC0ABo6tH2dleajfF0mSJohqfd8lCOT
 GGJ/yb+fShSkCsrdy02aac1kfvuvf28EfNtbnNli3zueG9nCM2J2iQ2D62u0NLHepYfK
 6mLCp52f6ER9w2kU44HHw8lWD6IGVuWAddAVOB+wVrFKhYrMy421WjaaHZ8aQVhR6pn0
 eRcQ==
X-Gm-Message-State: AOJu0YydUeRLSdZVU7BtlR51tdDVZDzuApe/3KSN9o+/+WltFfuA5JTs
 GI1KQuHqmix9MCp28slnEH3SxfF9J9+PtEzW0uGyUJ7ChOn230oQdChDUkZRo6xULiNLE8q02OU
 60KfqypwvRf+FgzBaARjkxRHBT9Xi8HG/ZvSmV8tQuPl+viQjde4OZ7kGaEJUtXM1QRFMamwse0
 rm5sFRrcIAjnzIqWKfMnAAzEx+VZGCbRCbq6ZSpCs=
X-Received: by 2002:a5d:5f54:0:b0:37d:4cd5:ffec with SMTP id
 ffacd0b85a97d-381f18632f7mr3182738f8f.2.1731088920709; 
 Fri, 08 Nov 2024 10:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6MqM3XTfMyjxqmlzETlnQUy/HeyRMRGH1cmQXnh4xpMFRmbqcFDS5aOLRww384l+1I8Gakw==
X-Received: by 2002:a5d:5f54:0:b0:37d:4cd5:ffec with SMTP id
 ffacd0b85a97d-381f18632f7mr3182685f8f.2.1731088920024; 
 Fri, 08 Nov 2024 10:02:00 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97c976sm5513147f8f.28.2024.11.08.10.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:01:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 07/11] rust: fix a couple style issues from clippy
Date: Fri,  8 Nov 2024 19:01:35 +0100
Message-ID: <20241108180139.117112-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These are reported as clippy::semicolon_inside_block and clippy::as_ptr_cast_mut.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs     | 6 ++++--
 rust/hw/char/pl011/src/memory_ops.rs | 4 +++-
 rust/qemu-api/tests/tests.rs         | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 2a85960b81f..7f40e7f71fa 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -499,7 +499,9 @@ pub fn update(&self) {
         let flags = self.int_level & self.int_enabled;
         for (irq, i) in self.interrupts.iter().zip(IRQMASK) {
             // SAFETY: self.interrupts have been initialized in init().
-            unsafe { qemu_set_irq(*irq, i32::from(flags & i != 0)) };
+            unsafe {
+                qemu_set_irq(*irq, i32::from(flags & i != 0));
+            }
         }
     }
 
@@ -601,7 +603,7 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
         let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
 
         qdev_prop_set_chr(dev, c_str!("chardev").as_ptr(), chr);
-        sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
+        sysbus_realize_and_unref(sysbus, addr_of!(error_fatal).cast_mut());
         sysbus_mmio_map(sysbus, 0, addr);
         sysbus_connect_irq(sysbus, 0, irq);
         dev
diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
index 169d485a4d2..c4e8599ba43 100644
--- a/rust/hw/char/pl011/src/memory_ops.rs
+++ b/rust/hw/char/pl011/src/memory_ops.rs
@@ -33,7 +33,9 @@
             // SAFETY: self.char_backend is a valid CharBackend instance after it's been
             // initialized in realize().
             let cb_ptr = unsafe { core::ptr::addr_of_mut!(state.as_mut().char_backend) };
-            unsafe { qemu_chr_fe_accept_input(cb_ptr) };
+            unsafe {
+                qemu_chr_fe_accept_input(cb_ptr);
+            }
 
             val
         }
diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 43a4827de12..925f5a3c77b 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -74,6 +74,6 @@ impl Class for DummyClass {
 
     unsafe {
         module_call_init(module_init_type::MODULE_INIT_QOM);
-        object_unref(object_new(DummyState::TYPE_NAME.as_ptr()) as *mut _);
+        object_unref(object_new(DummyState::TYPE_NAME.as_ptr()).cast());
     }
 }
-- 
2.47.0


