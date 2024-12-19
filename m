Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D797E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJIc-0000zZ-3e; Thu, 19 Dec 2024 11:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOX-0006DT-KM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOW-0008AI-03
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9nMTxyosvlBNmWHbdS3uU97thxBhf1W17a5325xukk=;
 b=I0X8XtTksjAg5r9WDZkXE95XIzqLSXCESAbmPct8zwhYc8oxqJLCyIPiG+BFFTpbYP457i
 DcN+E7yc/DX5ZYS+mAbv1mGdZHH+ZBdefAsAFYWsE/vukYs/hBvbYpCyjHXT7VkoiXEwbK
 X7oSnBF7T/rbK71V4eWdyV3Cge1TAjI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-80rFSyrUNfylHPk1a0ExHw-1; Thu, 19 Dec 2024 07:12:38 -0500
X-MC-Unique: 80rFSyrUNfylHPk1a0ExHw-1
X-Mimecast-MFC-AGG-ID: 80rFSyrUNfylHPk1a0ExHw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386321c8f4bso437059f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610356; x=1735215156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9nMTxyosvlBNmWHbdS3uU97thxBhf1W17a5325xukk=;
 b=gbl973onmp5OGaCLU7wkcnd40uZCHJN1QGUHKYvXsq+h4llISD9QX58AkmJT3ldZZI
 0idAF7XRkW27snWTjkcgxGjrKtFs1T2ql1XOGC48uRI5uI4pCMbDCfOl4+CDBJaac9Mv
 OgL3n+rJiSQrNaImCVAaOpOy5A2k+7uR561fRygTUKJtHV5haLp9Y+zgaV8QucJFW1aP
 70H4NvRKZwQgqRxoGeUWDiWnJ22oedO/UFX4JLC9vGuEpkiExeqJ0pXnj/oQnPWn3bPy
 KYAMP6retaoT4NPWopnEI6w2aWEG1xJc0p/hFdOK1iqcA19M6tYyiZFjjKmKHyYmydkH
 GSvA==
X-Gm-Message-State: AOJu0Yx0JNORx/1Mop6glHWt0E58dX3ymw46XgcRnZy8O91ONOTRHjxF
 +BX9XGY1d04/HpAjNQ2S93iFp3LqmJAnk8PLITlHZS329rkcyWa+o8OOqxvJIECrjNZrIpZOv1l
 bder6RECgxbtwA5e5TCjFORhUCkEQ0ZKJm5q5P61eRyed3XsSy9b41btljC0/QBwjnUx6/iS2V7
 oSf6rM82RSJd/i+CHGjL9UKKCR9pUL4CCNNJby
X-Gm-Gg: ASbGncvnn/YazxB/ylKseL/A1VhuGAf99cCIMpFJKauBJg/PQcJuNS30ITZvVrgTKW0
 4gtnGBZjbMpJSlObXqW3DDyeQyA6zexplEYpvQ4GquuDzTHWf4qmkkU3NniZa6FBruyRMgf1p1x
 bnr8KAqlfLIUwGfI+oE5Q5Wc1UF7z+iPHuikltBZdNwu7+BBs5nmGlnPNXX2W2ET/MBAJorczWl
 2MC6rZgD0uAhwgQEZM+7nahLqEpxyIZ7JBKIWUq2UYisnPHi1DAaY3V9UmF
X-Received: by 2002:a05:6000:184b:b0:385:df4e:3645 with SMTP id
 ffacd0b85a97d-388e4d9c528mr5233242f8f.50.1734610356160; 
 Thu, 19 Dec 2024 04:12:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUh2M9/mnSogeQ773STUYnJzJNd5S5eWvf3oRcRQezB6U0AwDcAXGbiOpHZ9UUI+vGCXK0XQ==
X-Received: by 2002:a05:6000:184b:b0:385:df4e:3645 with SMTP id
 ffacd0b85a97d-388e4d9c528mr5233203f8f.50.1734610355678; 
 Thu, 19 Dec 2024 04:12:35 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4fcsm16696415e9.29.2024.12.19.04.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 08/10] rust: qom: make INSTANCE_POST_INIT take a shared
 reference
Date: Thu, 19 Dec 2024 13:12:14 +0100
Message-ID: <20241219121216.416905-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 4 ++--
 rust/qemu-api/src/qom.rs         | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 72a4cea042c..6792d13fb77 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -145,7 +145,7 @@ impl ObjectImpl for PL011State {
     type ParentType = SysBusDevice;
 
     const INSTANCE_INIT: Option<unsafe fn(&mut Self)> = Some(Self::init);
-    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = Some(Self::post_init);
+    const INSTANCE_POST_INIT: Option<fn(&Self)> = Some(Self::post_init);
 }
 
 impl DeviceImpl for PL011State {
@@ -206,7 +206,7 @@ unsafe fn init(&mut self) {
         }
     }
 
-    fn post_init(&mut self) {
+    fn post_init(&self) {
         let sbd: &SysBusDevice = self.upcast();
 
         sbd.init_mmio(&self.iomem);
diff --git a/rust/qemu-api/src/qom.rs b/rust/qemu-api/src/qom.rs
index 861f1e50ac4..5934eb0cc50 100644
--- a/rust/qemu-api/src/qom.rs
+++ b/rust/qemu-api/src/qom.rs
@@ -163,11 +163,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
     // SAFETY: obj is an instance of T, since rust_instance_post_init<T>
     // is called from QOM core as the instance_post_init function
     // for class T
-    //
-    // FIXME: it's not really guaranteed that there are no backpointers to
-    // obj; it's quite possible that they have been created by instance_init().
-    // The receiver should be &self, not &mut self.
-    T::INSTANCE_POST_INIT.unwrap()(unsafe { &mut *obj.cast::<T>() })
+    T::INSTANCE_POST_INIT.unwrap()(unsafe { &*obj.cast::<T>() })
 }
 
 unsafe extern "C" fn rust_class_init<T: ObjectType + ClassInitImpl<T::Class>>(
@@ -459,7 +455,7 @@ pub trait ObjectImpl: ObjectType + ClassInitImpl<Self::Class> {
 
     /// Function that is called to finish initialization of an object, once
     /// `INSTANCE_INIT` functions have been called.
-    const INSTANCE_POST_INIT: Option<fn(&mut Self)> = None;
+    const INSTANCE_POST_INIT: Option<fn(&Self)> = None;
 
     /// Called on descendent classes after all parent class initialization
     /// has occurred, but before the class itself is initialized.  This
-- 
2.47.1


