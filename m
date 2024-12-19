Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D865E7718A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 08:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBy4-0004aX-Nu; Thu, 19 Dec 2024 03:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBy2-0004ZQ-St
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOBy0-000592-TX
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734597188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfN/9GQVfhxdzR3tEbIrQoWnaMvt0ggSFeNUo7cpLhw=;
 b=AaAN+piWo676q/qSFOGnbVABo5D2pCahVqd8jQfSOayBKn62f/1I0oFR0rprOgojAUlAof
 eW2cgJDWxYEPoaz//tcYzZNnlaxwj/2wyPSql8brq4JF5J7yTXBaJtUVBiT+yncFL56q+K
 sV6QzWKYtk8SKPyhcGvgzP9y7JGZgUE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-nkFEBQSDNbqI8M91HITnnA-1; Thu, 19 Dec 2024 03:33:07 -0500
X-MC-Unique: nkFEBQSDNbqI8M91HITnnA-1
X-Mimecast-MFC-AGG-ID: nkFEBQSDNbqI8M91HITnnA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e27c5949so347204f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 00:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734597185; x=1735201985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfN/9GQVfhxdzR3tEbIrQoWnaMvt0ggSFeNUo7cpLhw=;
 b=JnK11wIw1bBHk2lBSxbIo0k+2xfRuwNyFPoTX7x0ZqxaoKvVDU20dKMdjruaIbFzEb
 IzVjq6XpGDBt4TPcKGR9rLbkUjOU0Qavi9pE8Rc84mv9aQzNLMJn9qcOdf0CEuwUNcFV
 e7eBmtu0Dlm50ny3n00ZJ5RN0Rxl65B+nEU4/g5kYS821FuCrWH4Cyil6nvmpaL/Rfqa
 oFSQnkAOOYdqb5OyaGsQ8K2zpzcgNwbW9um0bZ6far9GE1CoNY2mzIZr/3XlauEdgtPM
 8e2lQT/2pCnsK5cranYICZethLV8paklIzkK0NN3vMNInBsULMHF5DG8y9WDfei7QkE6
 /kYw==
X-Gm-Message-State: AOJu0YyrvBrcPTV70eKtDqjDLXqhF9lapsYCAjRpKBYn1yQZJKbTgC5U
 R0zhmNktc/624Jpn0tCxgqi+1z11MGCTs1ZSVBeOW+zZpojSpcKLQKLamYFtLpek5KWJHrZhkd3
 TsG94FCIuK4KgOrm9juRJnlPg2/+ENndOPj2Ehq1EEMf1XeD0RzpattqH/A0fCo11yYwbMjVc7j
 CnrcvM0u0rJ65pB84k5Kwmj1zs3JdxrtPiR7FS
X-Gm-Gg: ASbGncseQdM3EfSuwG7aeHg+7u4ZnPWtTZNhx9GGwOakr4KgZFDzSQZ5mRTyPG3xpS+
 pYIXp8U80jvWS5Os8hdc+n1nZVFF8DoPXl3mu8RCz2Pnbz5iZpylHAUq0lWbJgI4wfkLKX3SHBR
 4J0zhgPhwJlXgM66onp2qQSrSkVUbitmEfqt8u042Ieszv77kcTTadET11J0qkObZ7YTCPHtQrn
 /FVB1iqGlqlVuQOHdcdJlb2lBCjWFelQAM19vF46wl9trmrgPyfC8muCfPq
X-Received: by 2002:a05:6000:4916:b0:386:37f5:99e7 with SMTP id
 ffacd0b85a97d-388e4d64938mr5959489f8f.33.1734597185072; 
 Thu, 19 Dec 2024 00:33:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6tZMVwBA7gyFZ5L/qy4qkPy8xuADDK7kUaGu2ZLlU02ZkIR5eJwLLWgmHCt5KQePV7L8Eow==
X-Received: by 2002:a05:6000:4916:b0:386:37f5:99e7 with SMTP id
 ffacd0b85a97d-388e4d64938mr5959455f8f.33.1734597184659; 
 Thu, 19 Dec 2024 00:33:04 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8add5asm964519f8f.107.2024.12.19.00.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 00:33:02 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
	qemu-rust@nongnu.org
Subject: [PULL 17/41] rust/qemu-api: Use device_class_set_props_n
Date: Thu, 19 Dec 2024 09:32:04 +0100
Message-ID: <20241219083228.363430-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219083228.363430-1-pbonzini@redhat.com>
References: <20241219083228.363430-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Richard Henderson <richard.henderson@linaro.org>

This means we can update declare_properties to drop the
zero terminator at the end of the array as well.

Cc: qemu-rust@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241216035109.3486070-18-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/device_class.rs | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/device_class.rs b/rust/qemu-api/src/device_class.rs
index 03d03feee83..c98f0b2c7da 100644
--- a/rust/qemu-api/src/device_class.rs
+++ b/rust/qemu-api/src/device_class.rs
@@ -7,7 +7,6 @@
 use crate::{
     bindings::{self, DeviceClass, DeviceState, Error, ObjectClass, Property, VMStateDescription},
     prelude::*,
-    zeroable::Zeroable,
 };
 
 /// Trait providing the contents of [`DeviceClass`].
@@ -31,7 +30,7 @@ pub trait DeviceImpl {
     /// device.  Not a `const` because referencing statics in constants
     /// is unstable until Rust 1.83.0.
     fn properties() -> &'static [Property] {
-        &[Zeroable::ZERO; 1]
+        &[]
     }
 
     /// A `VMStateDescription` providing the migration format for the device
@@ -87,7 +86,10 @@ fn vmsd() -> Option<&'static VMStateDescription> {
         if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
             dc.vmsd = vmsd;
         }
-        bindings::device_class_set_props(dc, <T as DeviceImpl>::properties().as_ptr());
+        let prop = <T as DeviceImpl>::properties();
+        if !prop.is_empty() {
+            bindings::device_class_set_props_n(dc, prop.as_ptr(), prop.len());
+        }
     }
 }
 
@@ -134,7 +136,7 @@ macro_rules! define_property {
 macro_rules! declare_properties {
     ($ident:ident, $($prop:expr),*$(,)*) => {
         pub static $ident: [$crate::bindings::Property; {
-            let mut len = 1;
+            let mut len = 0;
             $({
                 _ = stringify!($prop);
                 len += 1;
@@ -142,7 +144,6 @@ macro_rules! declare_properties {
             len
         }] = [
             $($prop),*,
-            $crate::zeroable::Zeroable::ZERO,
         ];
     };
 }
-- 
2.47.1


