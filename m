Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A767D185EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnJ-0007e7-If; Thu, 08 Jan 2026 08:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnG-0007cE-RE
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnF-00080y-3j
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b03v/X6J7oomQaGRutqWEu7f8gmtoiSOE8nhF1tA+Qc=;
 b=Z8W4zuE5vNHIfPQarfldUrkYZgdy/50/1FfCXqcJMdPTMeRr0A1k45vAZDh5s0FXJ6RKTt
 MFNl+J5ilrELGZkVrmSCVXFITbnxrKX8GVidCXtzYYGzF5Vc376Fjbu/JRQ4m0/TTQvKpP
 IQKNzC1ROY2juLnRas5pNJcucQL4K+w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-1zXU6DFqOXeVQe8My_ZNCw-1; Thu, 08 Jan 2026 08:11:10 -0500
X-MC-Unique: 1zXU6DFqOXeVQe8My_ZNCw-1
X-Mimecast-MFC-AGG-ID: 1zXU6DFqOXeVQe8My_ZNCw_1767877869
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779edba8f3so27560635e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877868; x=1768482668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b03v/X6J7oomQaGRutqWEu7f8gmtoiSOE8nhF1tA+Qc=;
 b=rTh8ymSJsgLHYRvaHH5YhAZDBYHnj9jWJWrdkWNs8/MBtzqmCf7PkAQAwZIKVRgPaK
 e0tyKj5azH+BBgpYdoMQedvat+wad2rR73cFXL+vvRBOmdm7P6b9I+LnTAV+OH+4c8zd
 mRBRKzv7SV/6CzM4JrGdECn5buvN1lpUuuXGzRinEJgqSaAImIUnH0HMAPZNJvKd5aPn
 dsZhPveKX1dfy/Hj/XzhKkuDVEAtu0rcm1Fye4dcnOu5cHrJKGFPNmuZ64+FIcL241YG
 xjXpC6CWNWgcOX7JRIlVLQPzTB19YuLruL0/dtZW/LEbTcYx4BL4y4I0/+hwdgWYEomU
 q3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877868; x=1768482668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b03v/X6J7oomQaGRutqWEu7f8gmtoiSOE8nhF1tA+Qc=;
 b=mf4I4P/pGiwhw9zosQ03qLNcKe0aBbPcQ+ztO93lNT+kq+F+zfBeUNT/JYz7C9AwCX
 /MoFnGOlKyA3t95ZaDbN5C7Ohf48WTNS7JrnzZ7Ko0wQ4kAK21aTDxFDq+O2ruegdIR5
 COkTOs8l0MyYCuqxUxgbxpsKgXEyNtddRpZKE0Y0eI2D8+RLCUzsDoqbt7g6Yq/GUtA0
 KzCrGbULXGL+wUNMiE7qSAB1mKIgYsDSaQ3+RdUgI6ntKBj9rcT9DjCdEkAQKoYiIdFk
 d/c1jopUGDO9WfMbOnaMqhOMfhHLG9+aCp5B6bgjJ7KHsUwiCXg7s1RhERiAxs+lbs2J
 UDGw==
X-Gm-Message-State: AOJu0YyVIKoHu+2eoD3jASNgsh3HVZc213sqKzGEmP17B8/+M/O48sBI
 YaRLQZLcmtDZUlEFPOqg36wMIwmSETi1cl47446swJCSUa+LhNvhXig+EHbM9Wo4B44Fs5tbRaC
 DStHKMTl3fudG7DsPi9JRHtU1DVyiyIwx3/tqbWsXkvDDLpOCth7XlxTGvRh0RgVc9u8BvHRK66
 4cflt3dqTXPRYJwYGjK+oNv7pGAURUTEj7zPj66yPn
X-Gm-Gg: AY/fxX7APQECUEuJicdkt5ZlXxvGDSaI4+nxgkVEVZ3DRr0aaByH3JYIMyu8H2fAsdr
 AhITd4LUjMgpcowhcGKPKGJJ06fQOZFJWhDxgCN80+QFHQ0efhDCTM94p6jotuGoga8H9XvYCEB
 LKcxkssAGz9nZaXtZz32x9K2/TvsvVk5jKHRX8k4vfnx6RQ5AOK0p6tcXiKAW2J4s5d49QuPC+k
 H2USPMXiOQrOmB5HSWCXys1nOl0qC7KwqBHGiOeN4VV9Re5LdR3GsAtiS4GtImW/ls2ItnxW03U
 lYA78UPiIkrmPBgNxIThJcAFUzq86ZkxA+Wp2hApY5H4yVbFn/efvEhAYIZr4r0bVJ78ATgCfbP
 IQI5P9aLYqY/n7ZLW/oC+FlNl+Z7HzThLCsIct+lV5t5ycwVuMM5fuEGo5jrrmS9B/sV9z6FX80
 2c0wndqRCtbVkpXQ==
X-Received: by 2002:a05:600c:444c:b0:477:9f34:17b8 with SMTP id
 5b1f17b1804b1-47d84b0a9e5mr75664165e9.1.1767877868551; 
 Thu, 08 Jan 2026 05:11:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgeAw6U45pzrqLZ+eF+lmM3Y5HhM8mwGDLIgKhDNBeRWq37Htljn5SujciM9nPWOyXkRNf2g==
X-Received: by 2002:a05:600c:444c:b0:477:9f34:17b8 with SMTP id
 5b1f17b1804b1-47d84b0a9e5mr75663875e9.1.1767877868110; 
 Thu, 08 Jan 2026 05:11:08 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm163472975e9.1.2026.01.08.05.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 08/16] rust/qobject: add Display/Debug
Date: Thu,  8 Jan 2026 14:10:35 +0100
Message-ID: <20260108131043.490084-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 95d41cec4f1..8033b5fafa0 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -12,6 +12,7 @@
 mod serialize;
 mod serializer;
 
+use core::fmt::{self, Debug, Display};
 use std::{
     cell::UnsafeCell,
     ffi::{c_char, CString},
@@ -270,6 +271,33 @@ fn drop(&mut self) {
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
2.52.0


