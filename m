Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD683C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLQO-0007ob-8k; Fri, 07 Feb 2025 05:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQM-0007hg-HW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLQL-0004Lq-04
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:17:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zMrreiA6fXml/tyoB0xwdzip2po3nTWUJjLq04bCbM=;
 b=IvYEJZ72oWYtUSSx4XRXvato5E8FkAOh96jAoKZb7d+ZOdUznF8/CddXVMiQj5sVSnYbPC
 UARdTWNaLhv41T/B/QiP6OvWNLZatNJ2kwnStVeSZLq6+qvYAmNAATHw0lrUWsNn2cCSde
 OQhpb9IL9tAKlBiO5EV2Ghh5T9OyKNI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-CJXagb1hP5CU44sSqsF9Hg-1; Fri, 07 Feb 2025 05:17:23 -0500
X-MC-Unique: CJXagb1hP5CU44sSqsF9Hg-1
X-Mimecast-MFC-AGG-ID: CJXagb1hP5CU44sSqsF9Hg
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab2e44dc9b8so312118166b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923441; x=1739528241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zMrreiA6fXml/tyoB0xwdzip2po3nTWUJjLq04bCbM=;
 b=Sqg9O7QTEVy0KLeXvq9hnUp1aWim+m657Y1Qgy/lTwbedKf/yRu2zpCs7v83uLtOVU
 /64Wo2qhXajVS8fcrPZkq59wdlkmFt+knwPrjKfnTQt9+4eqF0sGPJTOpWwaT1H1jtw+
 T9Lze1LdvXfDuqT9rOCLZfe5krkzbsBjew6c8sI5uSECvKusHWrUG5uHRDoP5jHyMLGA
 7V0IjiHDBJeYBlg4I+sygZKNrqVNsRf/8oI4jR/qS3al21KXSGLybdiVAp0ULvclpCiS
 wR5d1BKR1PGtVur+iVeT+R1HPpenIvRl9659Qkd7XHxhtSRgUR/iN9pcoEy1RfMxGLeS
 PfpA==
X-Gm-Message-State: AOJu0YwZbbr0bJCD9HyG6HfjR81Der2Yx1GcilQ6TKuGf2XjH8shWvKI
 xR4vpqs3Xab0bljUx4nCIHx8YOw9an5NWORcmPtnyVb5dIaKDPlP/7xonAwse2opsp1ol3Na7vb
 WBNpdaCkYfKg6Tu+M72iIB6dM62O+8MlcdoWaRQL+f8yqodPPbmYCVN3gIMAdiyoMioRN6rZ1iL
 RNVW57BeFJk+BoWg+Yci4VTNMevZvPZigi7MboOrY=
X-Gm-Gg: ASbGncuOyMFRK+lTUtViR5rmU8v1R0gqwPlUw5++k7o+5PBdqr6Jb9yZ1BZxccsecrd
 Yd/CkMGAzp3y4us49E7jzRIGHAtwm5so2c9pbMVmNiTEHFZxH9AOalhDi6ceAAGHHeyBvW3HNpy
 6X8yGqhvM2VgP6E1UIiUjwiWCsdGZcb4fP4We/Wb8k8IjwnOnUxFm4j0vNBaAgHDpIOqarKe5hg
 EUOwuIqrykjj7B5LTn+PpQZ2mPbOrixcDiq+n7+hFR0T2lLFVCQsvSIFBzht9kjE7OcN5DVlF5E
 YZfD2A==
X-Received: by 2002:a17:907:6d0e:b0:ab6:cdc2:3417 with SMTP id
 a640c23a62f3a-ab76e8cef13mr685456966b.15.1738923441006; 
 Fri, 07 Feb 2025 02:17:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6CjID0RSFN1ybO48T/D2riX1cvSrYvRckWhyBsi/kD+UvPszJG/T/VWvUl46MIRHbYT/twA==
X-Received: by 2002:a17:907:6d0e:b0:ab6:cdc2:3417 with SMTP id
 a640c23a62f3a-ab76e8cef13mr685452266b.15.1738923440500; 
 Fri, 07 Feb 2025 02:17:20 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab78405313dsm146061166b.55.2025.02.07.02.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:17:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 10/12] rust: irq: define ObjectType for IRQState
Date: Fri,  7 Feb 2025 11:16:21 +0100
Message-ID: <20250207101623.2443552-11-pbonzini@redhat.com>
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

This is a small preparation in order to use an Owned<IRQState> for the argument
to sysbus_connect_irq.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/irq.rs | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 638545c3a64..835b027d5e5 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -5,11 +5,12 @@
 //! Bindings for interrupt sources
 
 use core::ptr;
-use std::{marker::PhantomData, os::raw::c_int};
+use std::{ffi::CStr, marker::PhantomData, os::raw::c_int};
 
 use crate::{
-    bindings::{qemu_set_irq, IRQState},
+    bindings::{self, qemu_set_irq},
     prelude::*,
+    qom::ObjectClass,
 };
 
 /// Interrupt sources are used by devices to pass changes to a value (typically
@@ -21,7 +22,8 @@
 /// method sends a `true` value to the sink.  If the guest has to see a
 /// different polarity, that change is performed by the board between the
 /// device and the interrupt controller.
-///
+pub type IRQState = bindings::IRQState;
+
 /// Interrupts are implemented as a pointer to the interrupt "sink", which has
 /// type [`IRQState`].  A device exposes its source as a QOM link property using
 /// a function such as [`SysBusDeviceMethods::init_irq`], and
@@ -91,3 +93,10 @@ fn default() -> Self {
         }
     }
 }
+
+unsafe impl ObjectType for IRQState {
+    type Class = ObjectClass;
+    const TYPE_NAME: &'static CStr =
+        unsafe { CStr::from_bytes_with_nul_unchecked(bindings::TYPE_IRQ) };
+}
+qom_isa!(IRQState: Object);
-- 
2.48.1


