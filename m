Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA58E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZ3-0001W3-S4; Wed, 11 Dec 2024 11:27:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYx-0000lT-E7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYv-0000GI-PP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfgHZQsWMegaPfnFVxg+hSLnTIKU6Rd3BgTVCCd8fno=;
 b=MmJhfIPDAM8+YlSXZK4jYHVnIIGrzeVp1D9BNtyTnirD/8emIhuuFqNwBAaEDmxxPoSc+H
 nflKduzz/4Y+Qf0N6NDxAdoRW1rnFsRdSPJTV4qkq8BPmztcKoSsq6gIGx7sV6fB/VMzrf
 khYO/Pbk6+GQVurCsrAqAixoyLastmY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-vp5MxJovNXOZOHCUsrJAug-1; Wed, 11 Dec 2024 11:27:43 -0500
X-MC-Unique: vp5MxJovNXOZOHCUsrJAug-1
X-Mimecast-MFC-AGG-ID: vp5MxJovNXOZOHCUsrJAug
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa5a0a35384so503904866b.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934462; x=1734539262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfgHZQsWMegaPfnFVxg+hSLnTIKU6Rd3BgTVCCd8fno=;
 b=DOcJ4kEXG1Hn3ZdeGZ0QGVm1ofMo4QyYMy9EcPE1nk1dBLDWBVlt0RrE4Un3njF4LH
 JWHRalzLJveB5itVzNZ9vcLm+LuRSj2KIrVxCOd4mpd0S7SReKgif6MyRK44wy7DCzsM
 pnGxKjZ1j6/QP2vkNZht2EDMzetlY2AKx9pdkDrCvMpt7DEpv5PJq4vYkgLIAtevTds0
 flu0TqfNp/lNF3zaPSTOX6mFNHTHvlqi+ovAT47zjJWzecaXayclj/k4bnkZGYI1u5ps
 FJl4gRUcrVSeBnEJZDWKB/5xi+dH8BMez8JscQMNaWMg4KTUV82tzxzeAupl/LcGyHgD
 CdKQ==
X-Gm-Message-State: AOJu0YyRToju9bFvPE1uVRTRQ+1F9/pGj5eQwwV5Il+/jSuzL+pyrcXO
 7phrhyW4nDBawbxVnIO0qDWkf+lv19hqCnhBms8l/oKow/YJs4eXeEwM17vN+WrAvAdXIcQIOkP
 bgL1t9QHjwSkQB3Knkzl0ZNxw4J8naOQ1jpb/euglwmQPco5XFt4FhVSPrv+XDNGWa71i5ceGX+
 SWCHJMTW43gGJJvBNq47nlEzJmZDBPKlSWeu/q
X-Gm-Gg: ASbGncuCYJ2Aw3qQI/28Hm0tCwoJ5kDyElHWlRk5waayWKVJNLoLd9HS0lcU49QDbWx
 m/tYNbnsUypjMNw7ialhZuAJEcQCAbm8HduPr+wRZJjc6w6sgpeuHJHCs3RI5dVqAvO4O/71Kq8
 lGPh27vNMf7n5wpmrfnWBwqlaeJ5GhemPca7d0U++Q2Nr6BSr6bfsg+VLw4nWXsUp9socz2F+WZ
 ADHPF6HBP3/GxQv51Y/2sXDDkLa8nxAkQ3x8Xz5LD9z3ehGGj4qhUW4
X-Received: by 2002:a17:906:311a:b0:aa5:2575:e75d with SMTP id
 a640c23a62f3a-aa6b1141c72mr348935366b.2.1733934461836; 
 Wed, 11 Dec 2024 08:27:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqLeBPutf+x1YKZGwpLGI01fC3RgTTeOumZojvU5ZRPIXU5kWzPEkkjWFRrS1KYNPlybOtfg==
X-Received: by 2002:a17:906:311a:b0:aa5:2575:e75d with SMTP id
 a640c23a62f3a-aa6b1141c72mr348932566b.2.1733934461379; 
 Wed, 11 Dec 2024 08:27:41 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa650ea7369sm715147466b.74.2024.12.11.08.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Junjie Mao <junjie.mao@hotmail.com>
Subject: [PULL 09/49] rust: fix a couple style issues from clippy
Date: Wed, 11 Dec 2024 17:26:39 +0100
Message-ID: <20241211162720.320070-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

These are reported as clippy::semicolon_inside_block and clippy::as_ptr_cast_mut.

clippy::semicolon_inside_block can be configured not to lint single-line
blocks; just go with the default.

Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs     | 8 +++++---
 rust/hw/char/pl011/src/memory_ops.rs | 4 +++-
 rust/qemu-api/tests/tests.rs         | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 476cacc8449..317a9b3c5ad 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -2,7 +2,7 @@
 // Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-use core::ptr::{addr_of, addr_of_mut, NonNull};
+use core::ptr::{addr_of_mut, NonNull};
 use std::{
     ffi::CStr,
     os::raw::{c_int, c_uchar, c_uint, c_void},
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
+        sysbus_realize_and_unref(sysbus, addr_of_mut!(error_fatal));
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
2.47.1


