Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C563CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmY-0005oJ-0v; Wed, 01 Oct 2025 04:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmU-0005lP-Ij
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rm5-000656-VE
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sLvWPDiZQluuX0FdQeBQRWyJsw3tgbSgeYh0RBC+6e8=;
 b=diHEaV3Mb55NAECEMQcyllfom9xEyyXJHZRSeC+BYOM0h/7bxGygjGd2ngUYmONqDdNO9y
 ki9JUQZfRV/8pxhpJ4cs3le72ajF+cEb8gtw0SAwec80AVhdPmrMonjsIUSkRjmIPGTkcZ
 qjeNNmZVMr+dgVTLsYy/9qZ8xnCUPgE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-ULgWWLycOu6xsVJ6kn6bCA-1; Wed, 01 Oct 2025 04:01:16 -0400
X-MC-Unique: ULgWWLycOu6xsVJ6kn6bCA-1
X-Mimecast-MFC-AGG-ID: ULgWWLycOu6xsVJ6kn6bCA_1759305675
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b3d73e1ed87so82311866b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305674; x=1759910474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLvWPDiZQluuX0FdQeBQRWyJsw3tgbSgeYh0RBC+6e8=;
 b=AWlN2JV3xbfR7ETek7yks/xIZDR3TRfwAF0t9iNSgUnvJIOl/j4zIThgzyV9ty0H8n
 37r+FwQOVtY1VR7x30aG/kWlG7y1+cDjS2hwQYopK1Hwpclw72waX9wI0hDkZRXOS3CM
 iWZkaXbQoN7MN0OUVX129AkSJ0qPlMqS+p23j2itAmQNuQwTptyMtKRauwypizayx1Bz
 8Fr13b1BvzbmDbiMYzW266vEr+gpvyqhGDj0pG8ig4KT/6PcWZf89cVew40BufbqpVaH
 nceLP+3n55yvuAjQ04HtVKa2Mpi3BNaQ85UOOHBxq0APzjJ4K+MkkI70reAC2y3SVtYU
 qPgg==
X-Gm-Message-State: AOJu0Yy7lEB7T/JI8P0ZJgERNwOG9qvr22CqVSimEzJoM0gAr0F29o2i
 6vMHDx1FlC/bRWWCefGH9lHxNmv94xH0I7U6FBPU0l2yh2o0ZQhvSExSZJb2bc/HR7Xp9loOLYh
 WcS4ujFXsXHJU0sEiKboVjY/8VHW5OkKWOIcagEeM27+FhMEuOn/S/pTqGNnwMmdJJfNGDx+Zm0
 FJIqEx3G5UVbyGHsddT45LU7YsauZbhnVpj8ganU+R
X-Gm-Gg: ASbGnctWK16IfQXTp+ar3b+OEGi6Pd8IYYXIkKXsd9Znn3g3QAtNSJou2EVI7/pQNnF
 v5mKQnNLm8V5mIKY1hrGgDwX5cl7umC9Kys/NDV/k4CprPDifrNMlG0KTQLJeLy2Y5s3E9FsXzZ
 a69n+3e0Zy738/PU6J64HNIirZHMvcYI3bCeDg09Fj37NPruh2huQlNlB4CERt+SMl50Ti6Kv+X
 8BIlPzdCbbZPFmRSLMHi0IeFsO48HLwxurZJ5GlDLN3YYFwc15MCBSYhWsfpuOTyoYU+GnVyQ+3
 s/ejUxn9KYLIFvaIT1wxoHfBQt3SWCycF5JtaD01gVhGwxJ2oowd6n4P8V1yTe1NfXQD4mAC0/p
 oJzJcrXQAX6LpZ5wueGCH3jbwp5Oxtm9GalVGH09Ljxvod6+9Rp0=
X-Received: by 2002:a17:907:3d06:b0:b29:57b0:617f with SMTP id
 a640c23a62f3a-b46c3551d7bmr389669166b.1.1759305673463; 
 Wed, 01 Oct 2025 01:01:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNl5uDBcjTWdlbePuItCNpVFR1/yBRbgjA39Qn/2S4GFpr+EHUTfceNTBXQ89N5BppFxWgzw==
X-Received: by 2002:a17:907:3d06:b0:b29:57b0:617f with SMTP id
 a640c23a62f3a-b46c3551d7bmr389662666b.1.1759305672833; 
 Wed, 01 Oct 2025 01:01:12 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353efa4c35sm1308559266b.26.2025.10.01.01.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 08/14] rust/qobject: add Display/Debug
Date: Wed,  1 Oct 2025 10:00:45 +0200
Message-ID: <20251001080051.1043944-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/qobject/mod.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index 1c18a491720..b6e86f11a64 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -12,6 +12,7 @@
 mod serialize;
 mod serializer;
 
+use core::fmt::{self, Debug, Display};
 use std::{
     cell::UnsafeCell,
     ffi::{c_char, CString},
@@ -231,6 +232,33 @@ fn drop(&mut self) {
     }
 }
 
+impl Display for QObject {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        // replace with a plain serializer?
+        match_qobject! { (self) =>
+            () => write!(f, "QNull"),
+            bool(b) => write!(f, "QBool({})", if b { "true" } else { "false" }),
+            i64(n) => write!(f, "QNumI64({})", n),
+            u64(n) => write!(f, "QNumU64({})", n),
+            f64(n) => write!(f, "QNumDouble({})", n),
+            CStr(s) => write!(f, "QString({})", s.to_str().unwrap_or("bad CStr")),
+            QList(_) => write!(f, "QList"),
+            QDict(_) => write!(f, "QDict"),
+        }
+    }
+}
+
+impl Debug for QObject {
+    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
+        let val = self.to_string();
+        f.debug_struct("QObject")
+            .field("ptr", &self.0.get())
+            .field("refcnt()", &self.refcnt())
+            .field("to_string()", &val)
+            .finish()
+    }
+}
+
 macro_rules! match_qobject {
     (@internal ($qobj:expr) =>
         $(() => $unit:expr,)?
-- 
2.51.0


