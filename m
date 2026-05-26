Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD18CD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1F-00021K-Te; Tue, 26 May 2026 13:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1E-00020N-JH
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1C-0007wf-Gx
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwejE0qUh6l3AKjAZStBy9OZpi/ahgfNspmEiwXOJAI=;
 b=Qup/mtKWGXtdjqMNGnKg7Petgb13KedHO45bbKA2mLVM5/ZS8D0HeCIOyD6SMmbkyXOI+p
 gLbCS9au4JtrPlZ4kp8Jf4QbP2l/N6aQLTCx9yczpbghZp+AzIeWRREUa9eByi536JWwxd
 OSiIL+Pgk6hodDnWj8bhI4gCLInjyE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-P6LOR12FNTaFfG0KmkeVTg-1; Tue, 26 May 2026 13:56:40 -0400
X-MC-Unique: P6LOR12FNTaFfG0KmkeVTg-1
X-Mimecast-MFC-AGG-ID: P6LOR12FNTaFfG0KmkeVTg_1779818199
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso7464757f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818199; x=1780422999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IwejE0qUh6l3AKjAZStBy9OZpi/ahgfNspmEiwXOJAI=;
 b=PsqCKXkazDa9I9QO6ox4EXcfc+e2aKf16NYpREIbRT2Rcjk6+BLKMv1nI2lpFfP/GC
 266O1xjo0Jat4329b1Hygxk1VL8iQ2NPFrJOV5M7ru+PXQe+7HnF/zLNYh498LfmHOGv
 oS3ulhLSLUTzKq8JQUQkzrszDq/sSO4VbnQO3VS7/Rk/nmED7cgbCMJ2KwjnsYVM/ZHd
 /hd22yvgdZkIf8JlMz95AjmdwKVaqUX4Zh9QqcBbOBSHBtYXLGvnDwJ2jsKULcR0sFHM
 lbVQLpmtdu42MJwICPid/ADm77Bc56QWT70aCTsS27+mw02dI0ipF5CNiB2Z4L4DJUmU
 TckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818199; x=1780422999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IwejE0qUh6l3AKjAZStBy9OZpi/ahgfNspmEiwXOJAI=;
 b=hXwIwg+yVBeQhYJKoXKpTGW5o7hMSWBEcha8reXWqJtQEFm7oGoAEMJFA96EJ1uSvT
 bCOIxLejcsHZMyuaXuqdnVB8t+36SK5vdRIBBmblb86VZ2oUTYEufRe8dN03xlGKARVH
 6Ul/lNruic3p4dqkZ0hRBGLxq31LBT6tl4qHMTpQoFAoNB9zYO1iHl3gnqaakGxcm3c2
 NE3P0MYvd1vXNYP0250/3maQemq5HAmQ+bpDwZw9yf2NbdDtC6XqbaZmkX/mGzoIQBg9
 7p4yKhSrERiKjtZLmjF5d8PUr8zOmPlUiJo7pxmAv0sP+mqQJR3dcf68qw/9wxCSNKfY
 Ejjg==
X-Gm-Message-State: AOJu0Yyw4vCh5cKR3BAbzbPAnmBwJ6Yyq7gzrbsFrHYI0xR42WX6J8km
 OUzmVoRJ6CBCQ06PfuUMEe2lMwDh7B0ZoPrwOZCaM3ilKwRXN0AVzNKyeuVwGbcCSRJQGVuaLf/
 Q1yWbgHtJ/lQ98L/5kIVd8gtwbHSXvqORXVWmvxvUBIz851g2KlERW+ApHAfF5QpKeg2knzmLCX
 oHpQdB4EdrOSdRfvm5GnrysfXplO+6ykh27EweqaJb
X-Gm-Gg: Acq92OH/Ioka7f6UE8/5x7HYmAfNjkLUtJQDQsm+LBEOqsbvgZGctntb6GCxulEqgfN
 377LsThbn5GPLSyGFpkoAgdCMTQlwcUzx4EUqYrEGIOtXf+zYSwrjE/+M3MuGjhjVVnxA0Knw1a
 RjQ2uHddZbd1//dfdSB3di5gs3sgs17Io/HW5X6aHnOKfsusVTGaWTg73qh39cOqtu0CyCQPUv/
 ZVoyZbsSvpFgHPqlLM/2N4DfaO1rbWKroAWMIeK/q21yyxoi+TZgQ4iFMGlB8CDxYKrSIMioU2j
 HodjLxF3SNRw3+ee/ifbjQu1m+c6+xeCQMHYdMtidPfw1GolMzpZt5u9vYnuMIwIR37mOobpjWz
 qNu/ZFiCzVoJUKg0XsbFd8woQWWKWXfIGxaBSiJq9FtA+yH0Me94mN8VWS7ezEY/OQL21Pf+Ftd
 Ir4MN11Vo73OTvZxDi5YhzYjuh/fc=
X-Received: by 2002:a05:6000:26c4:b0:45e:739b:2750 with SMTP id
 ffacd0b85a97d-45eb30ec2e2mr30809568f8f.9.1779818199393; 
 Tue, 26 May 2026 10:56:39 -0700 (PDT)
X-Received: by 2002:a05:6000:26c4:b0:45e:739b:2750 with SMTP id
 ffacd0b85a97d-45eb30ec2e2mr30809523f8f.9.1779818198846; 
 Tue, 26 May 2026 10:56:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9de2dsm35996346f8f.4.2026.05.26.10.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 07/19] rust/qobject: add from/to JSON bindings for QObject
Date: Tue, 26 May 2026 19:56:06 +0200
Message-ID: <20260526175618.227743-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These are used by tests.  However it could even be an idea to use
serde_json + transcoding and get rid of the C version...

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/qobject/mod.rs | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index 76b167104d1..d2dde9ba0f1 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -23,6 +23,7 @@
 use common::assert_field_type;
 pub use deserializer::from_qobject;
 pub use error::{Error, Result};
+use foreign::prelude::*;
 pub use serializer::to_qobject;
 
 use crate::bindings;
@@ -114,6 +115,22 @@ fn refcnt(&self) -> &AtomicUsize {
         let qobj = self.0.get();
         unsafe { AtomicUsize::from_ptr(addr_of_mut!((*qobj).base.refcnt)) }
     }
+
+    pub fn to_json(&self) -> String {
+        let qobj = self.0.get();
+        unsafe {
+            let json = bindings::qobject_to_json(qobj);
+            glib_sys::g_string_free(json, glib_sys::GFALSE).into_native()
+        }
+    }
+
+    pub fn from_json(json: &str) -> std::result::Result<Self, crate::Error> {
+        let c_json = std::ffi::CString::new(json)?;
+        unsafe {
+            crate::Error::with_errp(|errp| bindings::qobject_from_json(c_json.as_ptr(), errp))
+                .map(|qobj| QObject::from_raw(qobj))
+        }
+    }
 }
 
 /// Rust equivalent of the C `QOBJECT` macro; for internal use only, because
-- 
2.54.0


