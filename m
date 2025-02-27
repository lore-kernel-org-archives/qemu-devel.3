Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A168CC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tneo9-0006dY-8M; Thu, 27 Feb 2025 09:24:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemc-0003qG-Kj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnema-000460-GJ
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpP0mKR1bYf8x/BopqJJucrB8oxIRdemZl6JUWYmoLk=;
 b=FOpKrbpxgszyryqLe4YdgRxtHnZDr6wwya219/k1IYQOZ3NoVlpXlPMlVsw4fUctGXEUjt
 e5xK3A/BeV8FTE+37SYZTieqGOWV5yT6ZUBpRDupVOFAJQyBcdNom9Dlq+z68vtYXDiQqv
 9rQNjFhxzU2idMMThHOW5RTRqdn+cv0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-CIdWP2I5P8ij9o5Mj7lbqg-1; Thu, 27 Feb 2025 09:22:34 -0500
X-MC-Unique: CIdWP2I5P8ij9o5Mj7lbqg-1
X-Mimecast-MFC-AGG-ID: CIdWP2I5P8ij9o5Mj7lbqg_1740666153
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-abecbdb4272so119852666b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666152; x=1741270952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpP0mKR1bYf8x/BopqJJucrB8oxIRdemZl6JUWYmoLk=;
 b=icSwCFl6mNFBE5aXiQYzBBKtrKnlS3Vrl1617s+jz1197CBD1sr48Tr2Je1YYbZs/W
 88g9VTMBSl5TJLi1nAnR6IYVj5KTx679LvftcaCol98gP8nvlt2qXRnV716qDtXUbu2o
 Vo7OmkzEyV83aewObYIBjfe0t6zjlEtHaH4pR3sqF6yKQ0nOWgeiPW2kNmgkdM0XwtQz
 MjvbqNn8qF9EIDPq8XQoGDBOZgNFF+K9wVcTV4VCMWeccmd3I+6Pl01pjS5hkLn3Ffu1
 MiY1Egm9TRK5uigfB2aLQIVrQRmmhZfaR4CE2dFjmv48uMOULMp6q6DjCVQNjqSNtex4
 kkHg==
X-Gm-Message-State: AOJu0YyZBSSwkZlb4W/52vUUNd0bEkVECpwSOemT77F++D7eRX30Lem8
 76SXEyMIBSw/mGBf7q5OrBqYTUds63KtCbuuSQC8nCAaLVLy5vqVmnrOP+MQwGVNspwCc3bQWz6
 OEUKcXfIE32MwC5MA0V03qUdgq5tU9GqCp8Kjntf1YLI3bgpxOIEj1i0Pt9NPCT2r0Yv0QvF5j1
 NNXuYCtPWwv1W5GCyfZHAOTgQrVLl+hvFDgcRMBbM=
X-Gm-Gg: ASbGncuH3Cj77cwYA0YFOsVqbtjDzZhRWcA906FaEYAOF20bkpqHIuUbRS90HlezwAi
 hHmVRupSYi1wpqJk1hiVFPARz5r2fF0dPzZmLIr6f5MZDz0QiMg0bbYcji4kxv8grEEqHq2t+NT
 69J0bN+VUnfwB5Ae2js11ok9NmUZoRZ+GllJ3U7x4Hmpcvx8odlBM2LxwK2OXFREKWkRYMPLKIP
 hVrUEOUrQW6/4me3vYUtwgHnUXzAvw427N44mgT00SGExQD8JzxbyPR+TqYS61MtPR+TvVV51m/
 QrF24JIeDF0Y3NgbNsrs
X-Received: by 2002:a17:907:9686:b0:ab7:d7fd:6250 with SMTP id
 a640c23a62f3a-abed1015488mr1399571166b.43.1740666152606; 
 Thu, 27 Feb 2025 06:22:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvCk74a5ejhjBllkAOfm++110zW0HlAe/VNXfUAjWC6HXkOqOgZGXaU+RkRq9U/kJeZk+vSA==
X-Received: by 2002:a17:907:9686:b0:ab7:d7fd:6250 with SMTP id
 a640c23a62f3a-abed1015488mr1399568666b.43.1740666152200; 
 Thu, 27 Feb 2025 06:22:32 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dbc43sm131935466b.51.2025.02.27.06.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 05/12] rust: irq: wrap IRQState with Opaque<>
Date: Thu, 27 Feb 2025 15:22:12 +0100
Message-ID: <20250227142219.812270-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/irq.rs    | 15 ++++++++++-----
 rust/qemu-api/src/sysbus.rs |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 34c19263c23..1222d4fde30 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -8,10 +8,16 @@
 
 use crate::{
     bindings::{self, qemu_set_irq},
+    cell::Opaque,
     prelude::*,
     qom::ObjectClass,
 };
 
+/// An opaque wrapper around [`bindings::IRQState`].
+#[repr(transparent)]
+#[derive(Debug, qemu_api_macros::Wrapper)]
+pub struct IRQState(Opaque<bindings::IRQState>);
+
 /// Interrupt sources are used by devices to pass changes to a value (typically
 /// a boolean).  The interrupt sink is usually an interrupt controller or
 /// GPIO controller.
@@ -21,8 +27,7 @@
 /// method sends a `true` value to the sink.  If the guest has to see a
 /// different polarity, that change is performed by the board between the
 /// device and the interrupt controller.
-pub type IRQState = bindings::IRQState;
-
+///
 /// Interrupts are implemented as a pointer to the interrupt "sink", which has
 /// type [`IRQState`].  A device exposes its source as a QOM link property using
 /// a function such as [`SysBusDeviceMethods::init_irq`], and
@@ -40,7 +45,7 @@ pub struct InterruptSource<T = bool>
 where
     c_int: From<T>,
 {
-    cell: BqlCell<*mut IRQState>,
+    cell: BqlCell<*mut bindings::IRQState>,
     _marker: PhantomData<T>,
 }
 
@@ -79,11 +84,11 @@ pub fn set(&self, level: T) {
         }
     }
 
-    pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
+    pub(crate) const fn as_ptr(&self) -> *mut *mut bindings::IRQState {
         self.cell.as_ptr()
     }
 
-    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut IRQState {
+    pub(crate) const fn slice_as_ptr(slice: &[Self]) -> *mut *mut bindings::IRQState {
         assert!(!slice.is_empty());
         slice[0].as_ptr()
     }
diff --git a/rust/qemu-api/src/sysbus.rs b/rust/qemu-api/src/sysbus.rs
index 04821a2b9b3..48803a655f9 100644
--- a/rust/qemu-api/src/sysbus.rs
+++ b/rust/qemu-api/src/sysbus.rs
@@ -79,6 +79,7 @@ fn mmio_map(&self, id: u32, addr: u64) {
     fn connect_irq(&self, id: u32, irq: &Owned<IRQState>) {
         assert!(bql_locked());
         let id: i32 = id.try_into().unwrap();
+        let irq: &IRQState = irq;
         unsafe {
             bindings::sysbus_connect_irq(self.as_mut_ptr(), id, irq.as_mut_ptr());
         }
-- 
2.48.1


