Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BE0CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fDb-00052l-0p; Tue, 14 Oct 2025 09:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDT-0004qC-GL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDP-0000xu-Pz
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mS+v14KcHsr+muZI98IFf3wSVAEOdlp3uBgp4JAsLiM=;
 b=TT71WzleJ8mDxJuiHt48CluDwg31HiUjIa99oAHruVoNntaoioKzd9IsDRQj4+IMBR+rYt
 LZs8HtQMlDxPLTj1PTmRc8L8z4wcn17kqETBkEbmKX86RQ+jNHDTH8tWM1sc688axo/WUA
 VWuXM+6psd4swcOGU6TgquRkQ74sZKI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-wbeHQ7O4PLyLPemlWDktQA-1; Tue, 14 Oct 2025 09:37:19 -0400
X-MC-Unique: wbeHQ7O4PLyLPemlWDktQA-1
X-Mimecast-MFC-AGG-ID: wbeHQ7O4PLyLPemlWDktQA_1760449039
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e3e177893so38373125e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449038; x=1761053838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mS+v14KcHsr+muZI98IFf3wSVAEOdlp3uBgp4JAsLiM=;
 b=N80AgnKDeUMXjdglHWWn5xm7KqPN6atX9oqGEsvnWH2WflIRrs9cmW/lDOmLLRAfog
 K3KBZn8GsPM9mMceldY/XivhWh2d7iLKoAPulR3/o3OWbn0ArSG+35UcH72JoZMC7HOJ
 IF0HXVAsny/FE4q9IEYLMn/WxnKovkW8f2zUZtx9FPRT/4m0M+kgT9dGqQPo4UyeePD0
 wdfOL8PQF1OyR6Qdf7nZWr7TItL4CzJTMn4253+/GMjvcZ6NRCPm/4+F4K9CO0RzM0Q0
 L8gtmGXXvMpcw/59ZtJt6S3skCuStZStwgCAgiLe6Tc4/Q3VGLJx2zXwtZ8K9rXFanYc
 +NoQ==
X-Gm-Message-State: AOJu0YweJyicVWKFhgcitr/UDB4YsasDktxAgDiYR0GjrZugb1vNMQ9X
 Aa4xFA1R0IwYRslQjiGNJ4Y+fZ2/jZspAiZtBQXZnDDaiKD1deyCAlqQi2miFRNF92tlvEoP7Bt
 30Of0ntSJhC/HO4bhS563wXExtWvmTa6C7MWrqCtoofT2v1WA1ZRxpI34GDpVUeEDuguXL6srq8
 wBM1jBgsbBUlE2hEM8GLDe9SbHqAVQrglargWQMTsq
X-Gm-Gg: ASbGnctj7Xk9Ni8h7GcvQ2acItht8os+Pn07cxXxz/s/JKDjvUstWB/diDoj0AgkB9x
 ic8V+4bndlUC6qUcE4e4Dk5uHjkZziDAPG7GFvkTTpgxbTDmiQFqJEnG8i85mtFi5BI3j+0xSx+
 xCC8r84pqeOh7MtOeeL/dlYwx0H9GwQrqchA5hj9XaeAXoF5GctosawrMV1rxLBv9UqkEJpCPQD
 IlIYZgINnNfrTRpjX2uajqKnh56o5wnxFwSNMhok6ayinh3Bgq8hMH1mfabVR3dlJxvixpCSDW2
 Rl5PPFvjMoeqVI7I36JdJiPYdVIjruqb/EZIB1Ct2L1ZwC1aoDoUE+eUhzXHSKNpwD1r1uZ8Swf
 qPtYPMVbpJjN3iI3nHJxNnzt044UsZUjbBnrLZApRtaE=
X-Received: by 2002:a05:600c:c08f:b0:46f:b327:ecfb with SMTP id
 5b1f17b1804b1-46fb327ef42mr98968325e9.9.1760449037698; 
 Tue, 14 Oct 2025 06:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOzzYvEZNYIU+xDwcqH4jE17d+dcWVQh5lXMnUdRGNsOdgt6Ri/yG9FfVWWzg0+3PwgCnDLQ==
X-Received: by 2002:a05:600c:c08f:b0:46f:b327:ecfb with SMTP id
 5b1f17b1804b1-46fb327ef42mr98968095e9.9.1760449037187; 
 Tue, 14 Oct 2025 06:37:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d404sm23972223f8f.3.2025.10.14.06.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 02/28] rust: bits: disable double_parens check
Date: Tue, 14 Oct 2025 15:36:47 +0200
Message-ID: <20251014133713.1103695-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It is showing in the output of the bits! macro when using the nightly
toolchain, though it's not clear if it is intentional or a bug.
Shut it up for now.

Link: https://github.com/rust-lang/rust-clippy/issues/15852
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20251010145756.787800-1-pbonzini@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-macros/src/lib.rs | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 3e21b67b471..3bf315c4c0a 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -401,7 +401,14 @@ pub fn bits_const_internal(ts: TokenStream) -> TokenStream {
     let ts = proc_macro2::TokenStream::from(ts);
     let mut it = ts.into_iter();
 
-    BitsConstInternal::parse(&mut it)
-        .unwrap_or_else(syn::Error::into_compile_error)
-        .into()
+    let out = BitsConstInternal::parse(&mut it).unwrap_or_else(syn::Error::into_compile_error);
+
+    // https://github.com/rust-lang/rust-clippy/issues/15852
+    quote! {
+        {
+            #[allow(clippy::double_parens)]
+            #out
+        }
+    }
+    .into()
 }
-- 
2.51.0


