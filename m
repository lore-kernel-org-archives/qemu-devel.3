Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A61CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1I-00022P-SD; Tue, 26 May 2026 13:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1H-00021P-2p
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1E-0007xN-S5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGNiVyk3smt3QCBdx3Hb8LIxSZAyBf2ULYTGIW9VfTc=;
 b=C3p1jxzkKID7oQ1ddQA+O6mU0xMTbZA0CqU5zH5t6ivQZ+x/Nd7sgGn3gzIRPIyWchjHTv
 yEQvKo9SsDApbeCV/nIFoQJkxkfVuVAEHvHXkw64J99JVr7N0HChwmmw6gGLuttiXG6FDO
 hzVKcIoNwXR5bb13PoEtsovn3Q/47Og=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-dkaBYBsLN9irGJoVyTBkeQ-1; Tue, 26 May 2026 13:56:42 -0400
X-MC-Unique: dkaBYBsLN9irGJoVyTBkeQ-1
X-Mimecast-MFC-AGG-ID: dkaBYBsLN9irGJoVyTBkeQ_1779818201
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45aeac88af4so8810858f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818201; x=1780423001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GGNiVyk3smt3QCBdx3Hb8LIxSZAyBf2ULYTGIW9VfTc=;
 b=U1g1rHZ0QHYDRTdYdFrG4+1KQDCKWnu6xVhUn1Gh6MsakXK8AHyQ2GUqeSkL5aIJV4
 MNeLgdeEaPtY0oZiKzAVCBbcTtyNs50gUEojrn5kCSHZJJYU2TBH/iIz1DXa1OOOpcGj
 yVbbdwcB1V8zbOl9+3RJ0bK4RDAxF+16iCnNnMonZlERWuhvfILA2kCVBDBdXz7hl1Tn
 BD8LUFt+kZxFvFepLVngf/KK7vuDu8pOmePt6W4Ngj81IzY+mCEwNdR7x96MUjPJ5zW9
 QNkoquP0IQ29+PPV3ANlCXH5gzlo7ig/b+1AfYP51wGiMzZfnNE5HPVEnHlsj5tDql1J
 DLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818201; x=1780423001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GGNiVyk3smt3QCBdx3Hb8LIxSZAyBf2ULYTGIW9VfTc=;
 b=YoXpV5QYOtWu99C/Qu/Jy2B3nRddUGR/EbtOrT2AfEIe+mj3895mbz53aedXe5+Czw
 P4rTseLH1Dqq2aWaz9sEDh5o1GWQocsJURHsecIJy7qUjx3dt9kpBJBAoha+sPJJHsVm
 pvPGdqXVo13yaVkYldXTt+kq81ij/WmsCps5IsIpiaHTyUQCNWI35hdSUGeKvLyifU9Q
 GoUei2PAxB+tPkEWTrYfZwwyTSCOFnP9X7B4zNnl2vsUEp/Q67Nitqa84X+EHs/Ssz9r
 hB+DSjMY/hT+r+6KITAGwmCCyJ68LNxvxpUwpsZ/p1kRdJwDCbHEfqhiEkEFA30LQ9/U
 TqfQ==
X-Gm-Message-State: AOJu0YxlHJPq5PxpVqb6cMr5IKx7EJS0o80qrx1ovyZ82OihVhCZF137
 5ooojXLIb5AIhCca5udMKYC/84X2geIHxpyxBjDT+/vF0Su2olv8Fxn2rF6pmvvK+UXKWeVCSIK
 CCmw4qa+++bw8CE3b0mI3UsAHw8iorxXQQYYl1o1L7P6eLQBh6TDMt9CU7AKzLqa6yyehUEgm4V
 DbbXA8YPWFE8o+GTCkYzRJM5yDaaALD89LA9Wp2iQc
X-Gm-Gg: Acq92OE9JzLIwWWR9TlKnSFlsXLZYvNVnftRicK7RGN9dF0j35Tfjk9k7blv6DmMnzu
 fSyFgM0H9KpHLfHCjAu0Quj0L3Cd9/PEnE4QIxeJ7T3359gLNCBdBWS0aYmGZPVimjt3+cO4cbd
 KWg9KT8H7+fXbGergsoxkQho+8KgSW8LT4s4U8bShY+IyMJvL0Adk5KO7e5VfKvwtSxWYpUG+vp
 6UGbntu2ftMjPPFtSSLBxAIYlvdJmv/uF2UPaTFNqagCkHSbbTtooXTOjCODuyoHskHFsqWOE6J
 5jixzHP/wgrQdB4z8MabjBWSp+JX/aMtxliTcu7YRFEbaaSnx3aJcELevudq1x9FOree7n+gl5A
 2Mk1VozD+8nHOJd6VYwb5YeGfcQCZrnNMR6F9SBj0IDzkOZcV64STkEuKGc9aDp09ruIGSoIcfR
 gz2zKJiI93g430oW8fc1ysf2frOxg=
X-Received: by 2002:a05:600c:a402:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-490426adf66mr270778695e9.13.1779818201458; 
 Tue, 26 May 2026 10:56:41 -0700 (PDT)
X-Received: by 2002:a05:600c:a402:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-490426adf66mr270778305e9.13.1779818201028; 
 Tue, 26 May 2026 10:56:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm336792355e9.11.2026.05.26.10.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:56:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 08/19] rust/qobject: add Display/Debug
Date: Tue, 26 May 2026 19:56:07 +0200
Message-ID: <20260526175618.227743-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/util/src/qobject/mod.rs | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/rust/util/src/qobject/mod.rs b/rust/util/src/qobject/mod.rs
index d2dde9ba0f1..3e22dc8bb3f 100644
--- a/rust/util/src/qobject/mod.rs
+++ b/rust/util/src/qobject/mod.rs
@@ -12,6 +12,7 @@
 mod serialize;
 mod serializer;
 
+use core::fmt::{self, Debug, Display};
 use std::{
     cell::UnsafeCell,
     ffi::{c_char, CString},
@@ -272,6 +273,33 @@ fn drop(&mut self) {
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
2.54.0


