Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D844FC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 08:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKuiU-0002bt-Gu; Fri, 30 May 2025 04:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiH-0002XO-74
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKuiF-0004cn-AR
 for qemu-devel@nongnu.org; Fri, 30 May 2025 04:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748592214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I9UYi4Cy39R5dTUfo2DeyIIhvEGm6Vs7YuCFqZJ0aIg=;
 b=Nmy5OmbHaEbFH84WhJhXN8CEqmx3sjYpMloOvwhAsysriFqH8Y3vQYyae+oSyaCA2Q0wvY
 smGvyaPRG+RdQro4lT8Nv+AjsS/EY6x9G469hNeB4IgHKSioQBy2cp1hu8po7+OBQLmFxW
 pWUdLKrNBLaHXdkdxyrn1j9feEWmlAE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-Jgx-WSZ6NNCmeyhh0vJvyg-1; Fri, 30 May 2025 04:03:33 -0400
X-MC-Unique: Jgx-WSZ6NNCmeyhh0vJvyg-1
X-Mimecast-MFC-AGG-ID: Jgx-WSZ6NNCmeyhh0vJvyg_1748592212
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so90907466b.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 01:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748592212; x=1749197012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9UYi4Cy39R5dTUfo2DeyIIhvEGm6Vs7YuCFqZJ0aIg=;
 b=qGxucVlUgaY0vSbEMe5htEt2fkVu/ms1YC4iIwJjlZCyLJSAmbGATVTXLFfA4e/2N+
 D317ci2Z0dxYKFxW02vRlUnr5ecE5IL+Wki88DEzqDrwsxDanI7rl73lELtAU8FxW+3C
 j/xRfc+QBYsD1LZJl7EeR5zG+SrIGZquFWvm1PGSGRDd2fwfnLFx/azSV7tiuZ93Mj21
 QBE0tIyg8/+hiQ6Rq0sqCXis5r2gYHieVqiUUdfmMIfjMhx0IRWWVA0SUlmHVZrElEc2
 VkwdKwnRV7r1hDdKxSi07rANh0/4oYEr9EcrOWCRoe+EU5WD+eDDTzTtUO45dgYHCaRH
 FwqA==
X-Gm-Message-State: AOJu0YxK4qbghgkAZZOGr7/ZOP3Yq/d4g+4xTZDTYqBh2be+c0nxQ0K6
 Ali7vQdj771yV3zCXTGH/noryAhQj1WQKiLoCl5HA4pX+GeQS1Yl1LA/bHsugVU/QuDCOsEqW8i
 fcS3MX+cz+jKWVlcn3cqTRI0GxTs6cRaudOsmdSvTu1trKwIi6+JvAA9E9+c9IFDkFCC+pe+FR0
 DQcAl19cx2eQUmVI2SNDMotHCEpOmMGsLxp9tqrwRA
X-Gm-Gg: ASbGnculfJBpX9aOnjUaI458Zi0T8z6Y7SKWfYiQTWjyyzcEZp5bFV5AKzL21BuGxJJ
 s5Huu/F99G+POMyagVXGlzKBA60ZrBPczrw/AmhfMBZge4lN7BEP9Hdi7Ua11aceh/SKXi0ovNu
 ZbNN16hDt2xSvEgyuHoR3oW5mcgJUsupbCoLUSzeePoZ5istz+s4l0fdrVLc56KW4s/ScQeljyJ
 5Wd8gmz92f/ZJrP8nRqd8NobEYCH29xSHXlygndN/ik9+Wp4aDs3ZDxBHrUFwOKq51dbKae9Kv0
 FceFEpLlkMQA3g==
X-Received: by 2002:a17:907:9450:b0:ad8:9c97:c2da with SMTP id
 a640c23a62f3a-adb36bfb187mr113379466b.40.1748592211526; 
 Fri, 30 May 2025 01:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkp5F1NC9thYzOG8he490C6v6/TNy0j9MFH/yK+eGJ5b5OxeIRWqOL8unQCi4NlxlUbKXnDg==
X-Received: by 2002:a17:907:9450:b0:ad8:9c97:c2da with SMTP id
 a640c23a62f3a-adb36bfb187mr113358666b.40.1748592208152; 
 Fri, 30 May 2025 01:03:28 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada6ad39479sm281821066b.124.2025.05.30.01.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 01:03:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/14] rust: qdev: support returning errors from realize
Date: Fri, 30 May 2025 10:03:00 +0200
Message-ID: <20250530080307.2055502-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530080307.2055502-1-pbonzini@redhat.com>
References: <20250530080307.2055502-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs |  5 +++--
 rust/hw/timer/hpet/src/device.rs |  5 +++--
 rust/qemu-api/src/qdev.rs        | 10 ++++++----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index bd5cee04647..1e715e91bc3 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -175,7 +175,7 @@ fn properties() -> &'static [Property] {
     fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&device_class::VMSTATE_PL011)
     }
-    const REALIZE: Option<fn(&Self)> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
 
 impl ResettablePhasesImpl for PL011State {
@@ -619,9 +619,10 @@ fn event(&self, event: Event) {
         }
     }
 
-    fn realize(&self) {
+    fn realize(&self) -> qemu_api::Result<()> {
         self.char_backend
             .enable_handlers(self, Self::can_receive, Self::receive, Self::event);
+        Ok(())
     }
 
     fn reset_hold(&self, _type: ResetType) {
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index e3ba62b2875..68c82b09b60 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -724,7 +724,7 @@ fn post_init(&self) {
         }
     }
 
-    fn realize(&self) {
+    fn realize(&self) -> qemu_api::Result<()> {
         if self.int_route_cap == 0 {
             // TODO: Add error binding: warn_report()
             println!("Hpet's hpet-intcap property not initialized");
@@ -751,6 +751,7 @@ fn realize(&self) {
 
         self.init_gpio_in(2, HPETState::handle_legacy_irq);
         self.init_gpio_out(from_ref(&self.pit_enabled));
+        Ok(())
     }
 
     fn reset_hold(&self, _type: ResetType) {
@@ -1042,7 +1043,7 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         Some(&VMSTATE_HPET)
     }
 
-    const REALIZE: Option<fn(&Self)> = Some(Self::realize);
+    const REALIZE: Option<fn(&Self) -> qemu_api::Result<()>> = Some(Self::realize);
 }
 
 impl ResettablePhasesImpl for HPETState {
diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 1279d7a58d5..81052097071 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -12,10 +12,11 @@
 pub use bindings::{ClockEvent, DeviceClass, Property, ResetType};
 
 use crate::{
-    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, Error, ResettableClass},
+    bindings::{self, qdev_init_gpio_in, qdev_init_gpio_out, ResettableClass},
     callbacks::FnCall,
     cell::{bql_locked, Opaque},
     chardev::Chardev,
+    error::{Error, Result},
     irq::InterruptSource,
     prelude::*,
     qom::{ObjectClass, ObjectImpl, Owned},
@@ -108,7 +109,7 @@ pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl + IsA<DeviceState> {
     ///
     /// If not `None`, the parent class's `realize` method is overridden
     /// with the function pointed to by `REALIZE`.
-    const REALIZE: Option<fn(&Self)> = None;
+    const REALIZE: Option<fn(&Self) -> Result<()>> = None;
 
     /// An array providing the properties that the user can set on the
     /// device.  Not a `const` because referencing statics in constants
@@ -134,10 +135,11 @@ fn vmsd() -> Option<&'static VMStateDescription> {
 /// readable/writeable from one thread at any time.
 unsafe extern "C" fn rust_realize_fn<T: DeviceImpl>(
     dev: *mut bindings::DeviceState,
-    _errp: *mut *mut Error,
+    errp: *mut *mut bindings::Error,
 ) {
     let state = NonNull::new(dev).unwrap().cast::<T>();
-    T::REALIZE.unwrap()(unsafe { state.as_ref() });
+    let result = T::REALIZE.unwrap()(unsafe { state.as_ref() });
+    unsafe { Error::ok_or_propagate(result, errp); }
 }
 
 unsafe impl InterfaceType for ResettableClass {
-- 
2.49.0


