Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B80FC1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnelU-0008CI-4Z; Thu, 27 Feb 2025 09:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekr-0007Ou-SZ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tneko-0003oU-1V
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5tiPQV4FLbVxra6ghak4CioHmf6+RCo+QEbLhSZJd4=;
 b=Qn8DgNNz5+1x4meZOc4yGYyd65m62XN5caK+kufH0GxiftwRnMDeOhhZ2zfMVe6LZcHdsi
 70UVJUyk0bDm2D/wGa/lQ+Ds1FK2f6ZhRzSCgFGB82j8rPpoxenbKn7pkOVnaqFwinGhOW
 /lj0sMX5OfiwPGbd76VZxSybMnHcHV8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Sw-MAk7nMGa61r4UEhPhyw-1; Thu, 27 Feb 2025 09:20:43 -0500
X-MC-Unique: Sw-MAk7nMGa61r4UEhPhyw-1
X-Mimecast-MFC-AGG-ID: Sw-MAk7nMGa61r4UEhPhyw_1740666041
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so106199166b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666040; x=1741270840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5tiPQV4FLbVxra6ghak4CioHmf6+RCo+QEbLhSZJd4=;
 b=w4u+ppRGAy+rZiqluE1UtS6nYYnWdckA+De9zzcSTqVSZrhG7fwZAuaH3MVy4mnnLr
 eVJsUs2Lpf3TkF4WYtaG9qEFvI92ERElDVPZbL32guHxkj327j7UfObZvPmTbpFe/NQt
 rz/QtJDcBN35LpBHOKlwm7pHQwaWScEY3jzBDXSmfCF4BEd+WIKAj/pxBiSxw7Fq14bR
 CFCyGzamMF1hRmIjLgAoR/NIEY2KhjPIxp4u0rYyghN3YIYdnKXjUVQ1R+uW+55R2khk
 5/gOfg0dnQgPg7bOy88KSiWrZr0TAu+OqhNYfJuN3F80PEeGtCr9/wqGKcOQxAtONfDE
 TTEQ==
X-Gm-Message-State: AOJu0YyVK+zs9u7ZrHMqpjPNxCEKCXBf/lzFMyC/O4Agzy9Q8YVfxDjx
 5ZiS4ikbKU+HA6/AXraASKz9dJ1hn/QdzBix1z46Vk0hmKl4VMDBCLVoQWZBcYzgqpw1vL11zQW
 yVOi3YksYNzSCjqnz8ZSNrFj+0BZ4WG0k4eYKOeu4q2uQyGI+9JONgAqLlkZRuEcYeWxaSqcz8D
 24lzypM06MthY6tkRlHtPPGPRkNlzteMYEBvhHLOI=
X-Gm-Gg: ASbGncuQglgLUE3ddREDnjjaKXiyB7j3llS9LENRtA1FYRRVpn3gXzcHC7YHPSgyEw1
 BjfQiUmW8AbnX6KBqkyMQpqB9M90bG4nhahNpqH8V1RUYlojpTk7Mh52Bg4YNjNk8lqsSBKq0aT
 9nJzc0QKXor2c27s3U756XWxTY5BlUYpLiNQG/7xnntebz2r+ZTUOWZ8LNg5SWrVUfyaVHxuyyU
 0BxNKoMFXNvugzEXKwtVR87fZ1FpbqAZTkijaLHcySy2jraK+KL3UhHhaP6sE+Ly43cZswpuDte
 hokVO/nO2pvuDCi45pM+
X-Received: by 2002:a17:907:7fa6:b0:abe:c8ff:32a7 with SMTP id
 a640c23a62f3a-abed0db724fmr1443989466b.31.1740666039622; 
 Thu, 27 Feb 2025 06:20:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcMSb6n5Zcu3jgk9dUkGkCUYM7m5rg1FYPOE8oahP9/0LN8kLAOJrNfIXPTntJzwieBIUUow==
X-Received: by 2002:a17:907:7fa6:b0:abe:c8ff:32a7 with SMTP id
 a640c23a62f3a-abed0db724fmr1443985766b.31.1740666039183; 
 Thu, 27 Feb 2025 06:20:39 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dc150sm131297766b.61.2025.02.27.06.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 21/34] rust: add SysBusDeviceImpl
Date: Thu, 27 Feb 2025 15:19:39 +0100
Message-ID: <20250227141952.811410-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

The only function, right now, is to ensure that anything with a
SysBusDeviceClass class is a SysBusDevice.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 5 ++++-
 rust/hw/timer/hpet/src/hpet.rs   | 4 +++-
 rust/qemu-api/src/sysbus.rs      | 8 +++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 59a689fdcd7..bea9723aed8 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -20,7 +20,7 @@
     prelude::*,
     qdev::{Clock, ClockEvent, DeviceImpl, DeviceState, Property, ResetType, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, Owned, ParentField},
-    sysbus::{SysBusDevice, SysBusDeviceClass},
+    sysbus::{SysBusDevice, SysBusDeviceClass, SysBusDeviceImpl},
     vmstate::VMStateDescription,
 };
 
@@ -176,6 +176,8 @@ impl ResettablePhasesImpl for PL011State {
     const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
 }
 
+impl SysBusDeviceImpl for PL011State {}
+
 impl PL011Registers {
     pub(self) fn read(&mut self, offset: RegisterOffset) -> (bool, u32) {
         use RegisterOffset::*;
@@ -746,3 +748,4 @@ impl ObjectImpl for PL011Luminary {
 
 impl DeviceImpl for PL011Luminary {}
 impl ResettablePhasesImpl for PL011Luminary {}
+impl SysBusDeviceImpl for PL011Luminary {}
diff --git a/rust/hw/timer/hpet/src/hpet.rs b/rust/hw/timer/hpet/src/hpet.rs
index 75ff5b3e8d6..b4ffccf815f 100644
--- a/rust/hw/timer/hpet/src/hpet.rs
+++ b/rust/hw/timer/hpet/src/hpet.rs
@@ -23,7 +23,7 @@
     qdev::{DeviceImpl, DeviceMethods, DeviceState, Property, ResetType, ResettablePhasesImpl},
     qom::{ObjectImpl, ObjectType, ParentField},
     qom_isa,
-    sysbus::SysBusDevice,
+    sysbus::{SysBusDevice, SysBusDeviceImpl},
     timer::{Timer, CLOCK_VIRTUAL},
 };
 
@@ -887,3 +887,5 @@ fn properties() -> &'static [Property] {
 impl ResettablePhasesImpl for HPETState {
     const HOLD: Option<fn(&Self, ResetType)> = Some(Self::reset_hold);
 }
+
+impl SysBusDeviceImpl for HPETState {}
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index fa36e12178f..fee2e3d478f 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -14,7 +14,7 @@
     irq::{IRQState, InterruptSource},
     memory::MemoryRegion,
     prelude::*,
-    qdev::{DeviceClass, DeviceState},
+    qdev::{DeviceClass, DeviceImpl, DeviceState},
     qom::{ClassInitImpl, Owned},
 };
 
@@ -25,10 +25,12 @@ unsafe impl ObjectType for SysBusDevice {
 }
 qom_isa!(SysBusDevice: DeviceState, Object);
 
-// TODO: add SysBusDeviceImpl
+// TODO: add virtual methods
+pub trait SysBusDeviceImpl: DeviceImpl + IsA<SysBusDevice> {}
+
 impl<T> ClassInitImpl<SysBusDeviceClass> for T
 where
-    T: ClassInitImpl<DeviceClass>,
+    T: SysBusDeviceImpl + ClassInitImpl<DeviceClass>,
 {
     fn class_init(sdc: &mut SysBusDeviceClass) {
         <T as ClassInitImpl<DeviceClass>>::class_init(&mut sdc.parent_class);
-- 
2.48.1


