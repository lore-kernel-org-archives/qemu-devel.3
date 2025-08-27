Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1FCCA0FF9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urKsT-0006YN-Eq; Wed, 27 Aug 2025 14:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKr0-00052o-9o
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1urKqp-0005rx-5T
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756319183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DznUdjNOyIWbRJG/98qm0Xg/nsiZRE997Fa9oQK3UAg=;
 b=ZBbL6/Uy40m16SxdfcFCZUBiTTj0Us4EF62ucNO02lLZJ2ziwTCL6r5ZsxfQaIXXHCaXNJ
 8P5QTvC3T+uCx/Vwr9jLPhwPoPN9k9Nen1E/Az+kkP/PWCkP2yRtgEFXL3DhmtYoRoE1+H
 s52Eg9NVShYuNOA2WMzDMeL5wjNO7vg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-Lk4vHeHnNuSdworDKfn4fA-1; Wed, 27 Aug 2025 14:26:22 -0400
X-MC-Unique: Lk4vHeHnNuSdworDKfn4fA-1
X-Mimecast-MFC-AGG-ID: Lk4vHeHnNuSdworDKfn4fA_1756319181
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3cd2c0effddso49589f8f.3
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 11:26:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756319180; x=1756923980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DznUdjNOyIWbRJG/98qm0Xg/nsiZRE997Fa9oQK3UAg=;
 b=Z9MtDcHpbN0D5X7LRj0E7nbH7jURXl54RHrYeGskMoeEd5JKIzrkAKxpJ4EmCX2jog
 trw9JqM6gm426M4abSmkv3+T14m8k+EzNsr+nQLR+TjyO0kxsiopAKE+61nIXspxp0NI
 sBiauZ6/f3EEPl8xhPpyMvcA7iZhLNWXkD/Fy2ecSaYoEplGjLn5QnyRwHEMGqCrLVHj
 T2QNQ8WlPBCn9+wMVfxlhy8334cQ7MYDLFtiAjRPbE3Z6G0hTGxxMFU7Pta7yj10zbD9
 cm7FQUCAtlcsW1rEeFA4XJWlxYlFUqNO5YsX4Ss3NGAdkpRfgEA99ZDcN5IzO2Az0N3w
 zu2w==
X-Gm-Message-State: AOJu0YynBGPyeysnkONaLjAPoCQ2x+iDLnogFQbWknPoxwUwLJfb1wwW
 aJoPzHze5xtQ8gYfwcNPJtOgKpi5XrG75TpvxSs1Fnuov1bTEcnPuim/D0d99u3P8t5frlBA0ir
 aCVCkXqLXHnCyAT4ZhExWhx9HaCSW/wAp9VOcW73iDCEUR3ifqQwegwOidz2DbJt+hUYNJ+TGZg
 yQT3/wmZNNZue8N7eKAnEQ/HW0YH4dhEPkLXWa6F2H
X-Gm-Gg: ASbGncuF04RYeIR2WA+IljIBOtCcbhtNU13dACRgnW/Qn0K9Q1MQfIRlIrMvv82WJGx
 Nr5gRKLMaBRrxAOoW66e02oOTjy0fUJodRYXtp6KjdqITHw37Ds04oQpC0AHgUAz9uxbEKmKn/N
 eSm1GRIE0o72/iIv0J3Hqv4joHcSUqTdDaLuHUxdokzIRuslV+yrEDDJCFTFipZJ+8EtRGA43TD
 c/MMySKqJJQMOPjC9q6FNB1t0XRvu248sUGVJ6Gd6zUZzdja1+qoGWmA2zfSPPhGswmJp8bvCW9
 hw2Xq+IuH8EFYmTXUmVcHu8dTEwzqQEAFsQR5pSUfoGFsADjgCZqYm91hqEuqOt+H+u6onu6cBD
 y+QmkmUNFAHflgBov3S2OkvaIsF+SiJBq3zIrejXBXy8=
X-Received: by 2002:a05:6000:2004:b0:3c7:caf5:f9af with SMTP id
 ffacd0b85a97d-3c7cb0542b2mr13809420f8f.57.1756319180226; 
 Wed, 27 Aug 2025 11:26:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESvaM4e1LlUuB20tw4KebihFZWqAWun27TYBPdTU6Xnpdd3HvS7ok1h6kjKDUOWV16/stJvQ==
X-Received: by 2002:a05:6000:2004:b0:3c7:caf5:f9af with SMTP id
 ffacd0b85a97d-3c7cb0542b2mr13809401f8f.57.1756319179740; 
 Wed, 27 Aug 2025 11:26:19 -0700 (PDT)
Received: from [10.163.96.123] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f30fe02sm38812525e9.18.2025.08.27.11.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 11:26:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 12/14] rust/qemu-api-macros: make derive(Object) friendly when
 missing parent
Date: Wed, 27 Aug 2025 20:25:30 +0200
Message-ID: <20250827182533.854476-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827182533.854476-1-pbonzini@redhat.com>
References: <20250827182533.854476-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Link: https://lore.kernel.org/r/20250826133132.4064478-5-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index b525d89c09e..a6147418891 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -85,7 +85,15 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     is_c_repr(&input, "#[derive(Object)]")?;
 
     let name = &input.ident;
-    let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
+    let parent = &get_fields(&input, "#[derive(Object)]")?
+        .get(0)
+        .ok_or_else(|| {
+            Error::new(
+                input.ident.span(),
+                "#[derive(Object)] requires a parent field",
+            )
+        })?
+        .ident;
 
     Ok(quote! {
         ::qemu_api::assert_field_type!(#name, #parent,
-- 
2.51.0


