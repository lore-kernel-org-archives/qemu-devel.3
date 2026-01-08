Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8164D185F2
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnI-0007cv-An; Thu, 08 Jan 2026 08:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnG-0007bt-67
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnD-00080h-8D
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=24uu20SH0A5RmWohW/685UZSc7h5TVZr0Shnp1cHoEY=;
 b=LSkOWSoUfrVj4Xc59Tg9x5jp//4rxr/XNRzILhLJbF5HbHtxgNi9dO/QwaN7BbUJlHa6Ny
 OAKkxNZ10fkmq2nRwrzi7iw4pLdHFOggd6PMp/nWR5OpgmVgqmWVluK0R6SU/YFn+AxTmr
 8bFdVAcfozcc7jjWVufohXaHDlNyBb4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-bARp6NvaOYmmnuwfE-roWQ-1; Thu, 08 Jan 2026 08:11:07 -0500
X-MC-Unique: bARp6NvaOYmmnuwfE-roWQ-1
X-Mimecast-MFC-AGG-ID: bARp6NvaOYmmnuwfE-roWQ_1767877867
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4325aa61c6bso2068210f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877865; x=1768482665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24uu20SH0A5RmWohW/685UZSc7h5TVZr0Shnp1cHoEY=;
 b=ao1Pnfb501s1ruzHhNzZLdZfU3J9ggAgvsVSGNFE4BuZkjpb4BOegpjmjvRgn16PaI
 5tViTECPDQBWKg5iCi9QFg5TAIBnIiGrS9XLxQC6WHoUp59b7fveqf8/U/RLCQEIKtTW
 c6O3aqk/sLn8OqmOXxSZUGkY8t/wT8Z1nQrJgdespIRO35a8av6BxAwBAnGstVV0W3bN
 EO0/QxjNbyZLAwnQ74p3TgnEoxSs7YIcfcug87GQvckBbJ8YGy4ut8uKvtCp1xDejjO4
 3COMhsXYEtSRI64Xjs+ENtIL41Ngs6Dx25S2Cx2Dy6iDh/YG9k1zNst+YtI5nw/JFDJG
 0png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877865; x=1768482665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=24uu20SH0A5RmWohW/685UZSc7h5TVZr0Shnp1cHoEY=;
 b=YsSauTAQ0IiIaU90Qf5VBRRl+sEKdlQA65ODTMJDe2KDy/kWn3vrnvSho1wTVSSMCG
 Uc0zZSYydlkCfnNt/XKkZCeuBeWhUbZf6HYYpiCtwdfpUz4GhTvGApvIGmRle6tzJq3F
 cGvQENit94bIW+tBbi48a7ZJ7nkJDOto+qyG98BAoS5HrCM5uaHCrK+q5G3b1JtnmiXA
 P49hXZh7Rw+IjRZ/eNtECf1byk7rLMryppAHY+ckSEx8WWGhWCHAEncVVDacYyiq0PdT
 SAs6Zn+ll7cI/X8k3Wvddro1poN23JHmeEQrNeQLdIhC7bX+604RcW7IucodPBoYYI3T
 2xFg==
X-Gm-Message-State: AOJu0YxZ0fhiY65b6w8h/QMa0c1HV1ArnTb6LZyrsOsc0EnmINSvGXB2
 g9Xtdm2mQ5ao7fyuIMMbuI7JvXWBwRAaQbIsZiEfnbI4+qHNE6NLe91ZZ5v6BD+K5Jo8oDuUa9o
 PYZPYgp2uQzdJovwRvhH4VcZT7mbhwDEMXCKSZPeVtUYcIvSgkIn/37ANuVpj/HKFJ/YyBq1W14
 EqkgnDjmU8Dx+X9OKnT0OP3NOBhCUugvf8r8/Q24Qy
X-Gm-Gg: AY/fxX6NBjdmcSCYLi2q8XvV69weRqEYE7R0j0lbNXnsSg8+j2NS2AKsIP8ekv+6fXh
 ShHFMX/PxX/Lc2g2OfDWqXfKn9D/VZQ9LkaQ9L2YkQ/v6wejRxiMdbWHdusskHe2Vohw7QAMKj/
 I8mSbcyL4d3149J7DmmhyDbsvgPNtayjaywL1DgC62qMKWZ0+YnNVbMOuIB2KTwvX1Za2h2RHEA
 1GyCXl99FtjCTcORn9W6LUNKowqTvv4Vo4I5O21hIRqsJDORnnC7U7zV5I3TymwEbz0e44wyDwT
 yZ4cKy31MvGJMs6XRl/J5L8pacCnTQjMkOOzGTwF+kfoV/Cv/o4WQV6ivo+XDUnI6F2TDiwKHNY
 6O8lY45uQ86jbUvkVQajJ8IUHRo+0osetqr/QfTUp5O53jpbOBj8hNVTlZ2yxNCTuXiRPoWtog6
 URlwdqisu/0qG2Ew==
X-Received: by 2002:a05:6000:4024:b0:431:808:2d50 with SMTP id
 ffacd0b85a97d-432c3628270mr7910121f8f.13.1767877865223; 
 Thu, 08 Jan 2026 05:11:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvittNCdbmpfD2E/UnLYDT9eFkNlLTgyzUxBRwqQaAyJ/ztD9DUB9Z6TDup7+DvYUKcUJ6Uw==
X-Received: by 2002:a05:6000:4024:b0:431:808:2d50 with SMTP id
 ffacd0b85a97d-432c3628270mr7910093f8f.13.1767877864765; 
 Thu, 08 Jan 2026 05:11:04 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432d286cdecsm2534047f8f.7.2026.01.08.05.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 07/16] rust/qobject: add from/to JSON bindings for QObject
Date: Thu,  8 Jan 2026 14:10:34 +0100
Message-ID: <20260108131043.490084-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

These are used by tests.  However it could even be an idea to use
serde_json + transcoding and get rid of the C version...

Co-authored-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/wrapper.h          |  1 +
 rust/util/src/qobject/mod.rs | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/rust/util/wrapper.h b/rust/util/wrapper.h
index 0907dd59142..c88820a5e5b 100644
--- a/rust/util/wrapper.h
+++ b/rust/util/wrapper.h
@@ -37,3 +37,4 @@ typedef enum memory_order {
 #include "qobject/qobject.h"
 #include "qobject/qlist.h"
 #include "qobject/qdict.h"
+#include "qobject/qjson.h"
diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index b95dddddedc..95d41cec4f1 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -23,6 +23,7 @@
 use common::assert_field_type;
 pub use deserializer::from_qobject;
 pub use error::{Error, Result};
+use foreign::prelude::*;
 pub use serializer::to_qobject;
 
 use crate::bindings;
@@ -112,6 +113,22 @@ fn refcnt(&self) -> &AtomicUsize {
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
2.52.0


