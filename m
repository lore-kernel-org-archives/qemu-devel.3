Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DA6C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 10:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trDwj-00083U-By; Sun, 09 Mar 2025 06:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwi-000838-2o
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1trDwg-00041g-Hf
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 06:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741516305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpP0mKR1bYf8x/BopqJJucrB8oxIRdemZl6JUWYmoLk=;
 b=G048KqRL5/UH7IhSVqF0yeio9WnrJsjQfCO5ocmNaBcnvuj+5Z0C5lFLrfEQmDVNU6GDJO
 jJ1IsMNwi+jzC11i57bQCvL6XX4sAe1dlCwR9vu/KpomWqttEjao0WSkAFHto1BapkKdBN
 nQg3QdQC6748p1mCKIvg9K3rJ8qkUW0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-2JADQTNEP4q9HxD7HLNsjw-1; Sun, 09 Mar 2025 06:31:42 -0400
X-MC-Unique: 2JADQTNEP4q9HxD7HLNsjw-1
X-Mimecast-MFC-AGG-ID: 2JADQTNEP4q9HxD7HLNsjw_1741516301
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3911232fd8bso1941488f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 03:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741516301; x=1742121101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rpP0mKR1bYf8x/BopqJJucrB8oxIRdemZl6JUWYmoLk=;
 b=J5kwlwDXNd1ojPXbxpNBv1GBXythiMVcbBraiU/d029+g4eoCWYOitVqwfDsYRsUfU
 rnhs0K5v9gtOzStDhMV9raMC7T0P7xMWrsmUXtchTdcrNXN2mThgGntXtg0faCZfH2WF
 piqdcYhXmFYQ4ekwSnaPsw8KZr76ewmWGWFbUOtCZrG0KHgL9ftH8F00LkvvLABgqVAx
 V98RtiB4C8h4XVIcNhFbAMhdpIGlWhB3gKkj9BHQJ0VP3WerZHRDvLqPClda8j92t0f+
 NzQFf3cyLwkMHh1+yZMgoAULSBVdxToAmhMDLJdRlKhXcXMz4HWfdyszLdYAI+MKWJis
 T6yw==
X-Gm-Message-State: AOJu0Yxi2zlCRD3rsJJGOQK0V7XfdLhtVzE0nb0UTYvHce+pCkp+C2Qv
 11kZTGGWDOj8L461WEpBjwEoiokfPGep1e8n2eH4zGGaepyo7K+/LDOAM19CSANbp72VOJ9/4b3
 nAzkY5CwflPD45Y7TToGMjKkSy4l9nWIYzwl5wD32cuBir3mtxnRI+RU9290u5McQShpKbnfPSv
 CUsJq20C30+7TrOieCVmyNxM+x2utPzeVyhx8EwGs=
X-Gm-Gg: ASbGncvO9Zn97cZHRqRtiuR51wvmrr5FRVwEhg1qY6qLrSdlFKk0mGAMEv1Txs1sQwO
 L1QYvVXWySEQGGRlAZPXc271ASWU1GthJR95xE56Z7PVEccD6Cy4EHEMWgmQSE9wJ081k6aIc4J
 a2SLPveyQs0phk+P0fSkFZEvlUprTj+Txtq3BBnFUhcgxUoMQiMttzBQUZslDmb228UlEFTCHRa
 dKoj1+wbVMJIwha3iX1trC3TGyJkOBX6cIEXzMDSocLQ6Hs8I/8oIYFWtU7iZdkm7LSAJX8mQsE
 SDvXXN5hK/ZKJ30JFSHyQg==
X-Received: by 2002:a5d:47a2:0:b0:391:12a5:3c95 with SMTP id
 ffacd0b85a97d-39132d6b98dmr5849368f8f.22.1741516300769; 
 Sun, 09 Mar 2025 03:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC8xW0p15YI0G2kw5a9Cy55asrzW+m2sD/bDeBFe7BXW4JBK2+fzFvwTNG2qWioZFSZ37nrQ==
X-Received: by 2002:a5d:47a2:0:b0:391:12a5:3c95 with SMTP id
 ffacd0b85a97d-39132d6b98dmr5849353f8f.22.1741516300321; 
 Sun, 09 Mar 2025 03:31:40 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.122.167])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8b0461sm114507295e9.4.2025.03.09.03.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 03:31:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/25] rust: irq: wrap IRQState with Opaque<>
Date: Sun,  9 Mar 2025 11:31:02 +0100
Message-ID: <20250309103120.1116448-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309103120.1116448-1-pbonzini@redhat.com>
References: <20250309103120.1116448-1-pbonzini@redhat.com>
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


