Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C7BC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsCs-0001dV-GU; Fri, 17 Jan 2025 14:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCr-0001ca-Ix
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tYsCo-0002Dy-Pu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 14:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737142831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsBnnC+UEglMSUQPR072ZGcFxRcTecgJCzaWCd7nUBI=;
 b=PGtV3oAR7sfEEURqhQLy2FJtu2YiWcLc6mKtaVn4AbQvfgdk2XB5CMU/jAmLSXufdEFhMw
 Tagrp2LlGqs9gFzCM3saOapoFypoy67g5pR2RfbhcLVXUKVvMjGigWex/ZT2KE+jUJQjQK
 r8gJyc3/gVR8KX5IdKpzHKCoq+bFg6I=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-Z5s4_zLoOBaWtnYWIM4Xyw-1; Fri, 17 Jan 2025 14:40:29 -0500
X-MC-Unique: Z5s4_zLoOBaWtnYWIM4Xyw-1
X-Mimecast-MFC-AGG-ID: Z5s4_zLoOBaWtnYWIM4Xyw
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aa68fd5393cso323188966b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 11:40:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737142827; x=1737747627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QsBnnC+UEglMSUQPR072ZGcFxRcTecgJCzaWCd7nUBI=;
 b=t3+gL5nWTvakN/6S3JntnqsI3Ojq9YjBW+/2U5CE2mTebZTgOSzy3+O+7f/ySMYEEy
 UYE0YikWXVcflqTS9s6j6Tkbpx2YF5cyHlHM27d4JIE5PY1KOndtSVNSOucT/o4hTgVG
 i4oXdkad9OpDLn8R1gkAMa+a3rodzR70pf+qNr5J6TLfBzGinEQLO8oVk0ZeUTRkIkpj
 PGYV76v5ilXWtsLKYbPMi4R1CDpGIJ5P41PwhSQhOwKb0AwJzaDmn1NcrOpsiIg6wPu8
 5BMQPZ9qM0ieN9CjvhB1r67QU3ehfY/mYZdhVxA5Tqhtzg2KTITNR1g0P22BPN7lyClI
 +gNw==
X-Gm-Message-State: AOJu0YyWKVlHq4WG5bVVyNLQjjr+5LEDMLhp0Mgkd2BsQoqCnC6uVfWK
 hTHAput6ph4htx+AkOtz4znFtJP36i39WhHg0Ds4EOUruC0JktZvjHC9cO9haSLATafRLxTmVvy
 uSo+740KDzt9JD15TQs5OyeJTdqIMR0aaIM6k6S7ZR06B0AJCfeSmqYH9bUnKasnZh3rwvu2ZcV
 vLgM+lWzQH5icVekRxtC7n3PtPfN+e1gJQk7zV+0k=
X-Gm-Gg: ASbGncuVcj+wMN4mXi82zIK5l3uTrV5I0D5RQGZN+24vrQ03q2+TgWSR8OaaHbPzvmX
 IJzTsED/6kS2WjbayN+B+aBHFoBWDjcYAYD1ZdJIsVM38i+OfhQjl2+Fd+3UkB2UqJiOfxWPgGt
 e3zAit33MMWjzY6fqOTIs70YO3IK3ZwcI9EM9//Gx6JaiHhT/utJe53O5TyZijy8ovMTMNPMmww
 fJSp2P5DkNHS88bKK5vtkTUfTB0YyGooBpU0/PnHcvo4lM9kdxisEUAuBD7dA==
X-Received: by 2002:a17:906:99c2:b0:ab2:faed:fad5 with SMTP id
 a640c23a62f3a-ab38cc8f4afmr295071966b.15.1737142827096; 
 Fri, 17 Jan 2025 11:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxdrZHqpDe6C9QrkUsgwubTEYk4OqEheVEYW7WoWLeoplqUR4CKOTcrdanHRbuMe6isWiOGg==
X-Received: by 2002:a17:906:99c2:b0:ab2:faed:fad5 with SMTP id
 a640c23a62f3a-ab38cc8f4afmr295069966b.15.1737142826671; 
 Fri, 17 Jan 2025 11:40:26 -0800 (PST)
Received: from [192.168.10.47] ([176.206.124.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c57034sm218647366b.34.2025.01.17.11.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 11:40:26 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 09/10] rust: bindings: add Sync markers to types referred to
 by MemoryRegionOps
Date: Fri, 17 Jan 2025 20:40:02 +0100
Message-ID: <20250117194003.1173231-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117194003.1173231-1-pbonzini@redhat.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

This is needed for the MemoryRegionOps<T> to be declared as static;
Rust requires static elements to be Sync.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 19 ++++++++++++++++++-
 rust/qemu-api/src/irq.rs      |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 8a9b821bb91..3f61264ab80 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -21,7 +21,24 @@
 #[cfg(not(MESON))]
 include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
 
-unsafe impl Send for Property {}
+// SAFETY: these are implemented in C; the bindings need to assert that the
+// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
+unsafe impl Sync for BusState {}
+unsafe impl Sync for CharBackend {}
+unsafe impl Sync for Chardev {}
+unsafe impl Sync for Clock {}
+unsafe impl Sync for DeviceState {}
+unsafe impl Sync for MemoryRegion {}
+unsafe impl Sync for ObjectClass {}
+unsafe impl Sync for Object {}
+unsafe impl Sync for SysBusDevice {}
+
+// SAFETY: this is a pure data struct
+unsafe impl Sync for CoalescedMemoryRange {}
+
+// SAFETY: these are constants and vtables; the Sync requirements are deferred
+// to the unsafe callbacks that they contain
+unsafe impl Sync for MemoryRegionOps {}
 unsafe impl Sync for Property {}
 unsafe impl Sync for TypeInfo {}
 unsafe impl Sync for VMStateDescription {}
diff --git a/rust/qemu-api/src/irq.rs b/rust/qemu-api/src/irq.rs
index 378e5202951..638545c3a64 100644
--- a/rust/qemu-api/src/irq.rs
+++ b/rust/qemu-api/src/irq.rs
@@ -43,6 +43,9 @@ pub struct InterruptSource<T = bool>
     _marker: PhantomData<T>,
 }
 
+// SAFETY: the implementation asserts via `BqlCell` that the BQL is taken
+unsafe impl<T> Sync for InterruptSource<T> where c_int: From<T> {}
+
 impl InterruptSource<bool> {
     /// Send a low (`false`) value to the interrupt sink.
     pub fn lower(&self) {
-- 
2.47.1


