Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADD6E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe26-0004ye-VN; Fri, 20 Dec 2024 09:31:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1K-0004Ra-C2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1I-0006ao-Py
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9nMTxyosvlBNmWHbdS3uU97thxBhf1W17a5325xukk=;
 b=Fl6Xa/O/Z5tGLfmnQRsnt8p09Hk7zi0UCOl2lv+bSTri4Aej6SVdpe0Iz5sbdwtVwB+2lm
 qymcNpyfCMmz/L/s7gEUyzV6GT9ZzEW4PWmPCWVDYJ4OQrsKWHBLIioADeNi85qHa7e5++
 PhVrwh8QFC8n3xNwaDxxmB/RrJ5pQpM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-jzTjaoisM32Xt8q1yzda4w-1; Fri, 20 Dec 2024 09:30:19 -0500
X-MC-Unique: jzTjaoisM32Xt8q1yzda4w-1
X-Mimecast-MFC-AGG-ID: jzTjaoisM32Xt8q1yzda4w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43621907030so16664235e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705017; x=1735309817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u9nMTxyosvlBNmWHbdS3uU97thxBhf1W17a5325xukk=;
 b=qjCzb2/7nudZhK6gzx39ZJIaRHU+ikSYfHVYu4iFVrEyM4hojahp8QkpyYCaE41LM/
 QcLG9axYhNIR2t+fQj+uFNsKYc68jpoaMPRRRR7uKEL4ZbZM0Qiss0R4ssTn2qAJNdTd
 8lLvU32t5m3qH/MRzvqCNpJRIKElb+LTCtPgidzB9mY+gySzE0z0CTgN4kz43gocC9Uj
 to1hl6YN0sshr3GUNmpXKFXuS6WEhjxi3SEjztAGXN79EIsp2pc7mpk9IH+721OOhYSN
 wXn0+6IggUIjsxz2CCbUKAO+0WwIbj1pOaYVF3KthKN16mZXaY6dKB/cg/BIp3j3oODs
 DJoA==
X-Gm-Message-State: AOJu0YyYe1FXcjN6vmQDzETy0BiiH1LvxpgeBpQs3F1G1B4tKUH6ztd5
 rhMQR7+xbhF1LwIuHUvI+w0QdrC2LDOVUJz1QnXQ2k+kABs+uBAs07Yx+q2WfyELPqKQo9kezk5
 nZ+HApCHLDw/xXAb9l4NkH6ZkXSmSOurVfarurDkxICMJp+GFhRbz5ow60y11+oWTI91azz8kd+
 Y0VscF9KzQ/IYkVxbV/TYvBfY5aVWB8qw8iDOT
X-Gm-Gg: ASbGncsmD2GmE6ljXsFghKMDpklSfuaHZPaqhWBTsZQw6zR34hXsXSsJeXOoP+dy8ru
 qch6H9O86CvwZGeX4wZbNkzrSKkQS5qBqSUGmeMOtKX9F03GKszPx870LPLXVrJBLPptyR7dbZ2
 sOQ/eGNYmp3Ie35CLs+R6RzjbW+LoOoL7DOR3UzNQtrMEsYkGyBA7qyodHQPaKWzvHs/5DPKSMR
 mkabT8T8/ZvMo0a5DOFI4MQQ41gJxVqvEk/pbteTuRlNH++581lRgCnqyXd
X-Received: by 2002:a5d:6f16:0:b0:382:40ad:44b2 with SMTP id
 ffacd0b85a97d-38a221fadadmr3226265f8f.34.1734705017594; 
 Fri, 20 Dec 2024 06:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMdSfYDHnwHgFPcEvubGZ+vNK9FWo7WkKZ58ryPBo0nFuBdtxeEjxS9+aS35ZbKylegm5Keg==
X-Received: by 2002:a5d:6f16:0:b0:382:40ad:44b2 with SMTP id
 ffacd0b85a97d-38a221fadadmr3226233f8f.34.1734705017138; 
 Fri, 20 Dec 2024 06:30:17 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8b874asm4149698f8f.109.2024.12.20.06.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 08/12] rust: qom: make INSTANCE_POST_INIT take a shared
 reference
Date: Fri, 20 Dec 2024 15:29:50 +0100
Message-ID: <20241220142955.652636-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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


