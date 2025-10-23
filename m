Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DC1CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 13:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBvnZ-0004hu-MY; Thu, 23 Oct 2025 09:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1vBvnV-0004c7-68
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mkletzan@redhat.com>)
 id 1vBvnQ-0005Dw-Ps
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 09:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761227762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5buUGn4k9DX+q2F1RhrNr2ZKOcfJSYeoiQxFdqNeag=;
 b=KXHLXPoaknbwc4jiy0vUjB0+QUEkx73BQoQEd3VeX9L8WRKjvuIv8Z7FQsCG75lsKtPqm2
 +si9IVl8Zg67Axu67m3Q2HdClA/JIbtEnvBqi9CMQGzriSAzHRMKJCFavHAsq0eZRIe+2l
 D9HiwRLn2mQDrSvss92Q1ox3Cj21ePQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-IhcWmvWxNOm0sqidJp_SRA-1; Thu, 23 Oct 2025 09:54:21 -0400
X-MC-Unique: IhcWmvWxNOm0sqidJp_SRA-1
X-Mimecast-MFC-AGG-ID: IhcWmvWxNOm0sqidJp_SRA_1761227660
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-427a125c925so740893f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 06:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761227660; x=1761832460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5buUGn4k9DX+q2F1RhrNr2ZKOcfJSYeoiQxFdqNeag=;
 b=dP/H/DqvT2yPiBBcA/ROuweF9coECIifq/Z5SjITrkL2Iy3XN0Di9pDteM1ujOdtIj
 Cuvyq2uvcrwlvdm5Pjna+s3F+rRDdm7Bc7xy1TUKVsbKmgq8HmsliY9xZfpBpuvT/Zxk
 fuwshKcDyt+8TJbaF9dHM+iCwaCVMbteZ3Ub7AWZvFOw9L6c5eHFN6GJl/rpBxTmwMMh
 +Kj1fJY+zrEsesaEENxgSCkriSl/H+feKuOyiFITjVGRHma25Q38YHwqaPqOz3tcH8/U
 g/BZ85/LmRMf7Ari3Y6xu1149sE33ubB8tpklyqfy20W7+klY+PPHI+mqAg/KquDQAhr
 ZMKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr+Vgyzds9GUQhhz+Gbim1Xfb90bzDCFEUwFdE4/DqeoCkEPRXiDPPwJvmq8bPsQCqH6OJ/MZeNqE9@nongnu.org
X-Gm-Message-State: AOJu0YyJOkbmL9w7GGbx69nM0yxcbCo864Ukt3Hhzmre6dDS42Oi1p6E
 z0jcuYzbng9pGr49T1HhJi218KU23OqRivGPzAXyA46eoSyMm4OEN8e/xXwFXoAlSnBx5lIPwCa
 e0qL1Msaru8uxYx/qyH5UEq/zjZPYMzxWhhsfzrrIQFCDgqZuY89MxHNC
X-Gm-Gg: ASbGnctusmdWHLBMpZJ3M4v/4+TNuFEY7HN8dYVA7XlJO1zx9D0vYJnFnVdupTZL/aM
 nATIus2cGF861Gt3oeZopkcRsdz++JFK8NscKh1fm4BOggqz4LB8iIgiQ06SFwWdJQ8qra6yugS
 jNdV9HUVmBxyCdzTe9L/LUcOSMEl8iaQVPoa+yVmix+aJl21951TRdYO6+oPEtx9CkakBbfi7yn
 pmSjRX11o7DuA3Fc85NgjlXDnQql+1hpJTY7fZvQ6u6/joHtbtMuVFMJdXdhxABpOQnooX4TFIE
 qizk/xgaSvM7Mmvi+KdvCkkwDHTGQB80mV8SN04GempAqjqgmcHXRGcENNWyiPzVLQ7gFK+xtk0
 Cz8G8ir3c
X-Received: by 2002:a05:6000:3101:b0:429:58f:325 with SMTP id
 ffacd0b85a97d-429058f036bmr2848309f8f.24.1761227659679; 
 Thu, 23 Oct 2025 06:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFejbUlPbzCH3uCz+ZgnJK5kXySxpIVtgcMvDzvRZHLG6XILZgP8tgn3JIe0coLBlL38iMvFg==
X-Received: by 2002:a05:6000:3101:b0:429:58f:325 with SMTP id
 ffacd0b85a97d-429058f036bmr2848286f8f.24.1761227659196; 
 Thu, 23 Oct 2025 06:54:19 -0700 (PDT)
Received: from wheatley.localdomain ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429898ccd88sm5005195f8f.36.2025.10.23.06.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 06:54:18 -0700 (PDT)
Received: from wheatley.pinto-pinecone.ts.net (wheatley.k8r.cz [127.0.0.1])
 by wheatley.localdomain (Postfix) with ESMTP id 6B063DC7C867;
 Thu, 23 Oct 2025 15:54:18 +0200 (CEST)
From: Martin Kletzander <mkletzan@redhat.com>
To: 'Manos Pitsidianakis ' <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, qemu-devel@nongnu.org
Subject: [RFC PATCH 1/2] rust: Make common::Wrapper work with non-tuple
 structs as well
Date: Thu, 23 Oct 2025 15:54:08 +0200
Message-ID: <d51fd56a47b55bd700788514383293a304832531.1761226974.git.mkletzan@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761226974.git.mkletzan@redhat.com>
References: <cover.1761226974.git.mkletzan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mkletzan@redhat.com;
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

From: Martin Kletzander <mkletzan@redhat.com>

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
---
 rust/qemu-macros/src/lib.rs | 49 ++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/rust/qemu-macros/src/lib.rs b/rust/qemu-macros/src/lib.rs
index 50239f228be2..074ba2189eec 100644
--- a/rust/qemu-macros/src/lib.rs
+++ b/rust/qemu-macros/src/lib.rs
@@ -10,8 +10,8 @@
     punctuated::Punctuated,
     spanned::Spanned,
     token::Comma,
-    Attribute, Data, DeriveInput, Error, Field, Fields, FieldsUnnamed, Ident, Meta, Path, Token,
-    Variant,
+    Attribute, Data, DeriveInput, Error, Field, Fields, FieldsNamed,
+    FieldsUnnamed, Ident, Index, Member, Meta, Path, Token, Type, Variant,
 };
 
 mod bits;
@@ -42,26 +42,52 @@ fn get_fields<'a>(
     Ok(&fs.named)
 }
 
-fn get_unnamed_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<&'a Field, Error> {
+fn get_wrapped_field<'a>(input: &'a DeriveInput, msg: &str) -> Result<(Member, &'a Type), Error> {
     let Data::Struct(ref s) = &input.data else {
         return Err(Error::new(
             input.ident.span(),
             format!("Struct required for {msg}"),
         ));
     };
-    let Fields::Unnamed(FieldsUnnamed { ref unnamed, .. }) = &s.fields else {
+    if let Fields::Unnamed(FieldsUnnamed { ref unnamed, .. }) = &s.fields {
+        if unnamed.len() != 1 {
+            return Err(Error::new(
+                s.fields.span(),
+                format!("A single field is required for {msg}"),
+            ));
+        }
+        return Ok((Member::Unnamed(Index::from(0)), &unnamed[0].ty));
+    }
+
+    let Fields::Named(FieldsNamed { ref named, .. }) = &s.fields else {
         return Err(Error::new(
             s.fields.span(),
-            format!("Tuple struct required for {msg}"),
+            format!("A tuple struct or a single field named 'inner' is required for {msg}"),
         ));
     };
-    if unnamed.len() != 1 {
+
+    if named.len() != 1 {
         return Err(Error::new(
             s.fields.span(),
             format!("A single field is required for {msg}"),
         ));
     }
-    Ok(&unnamed[0])
+
+    if let Field{ ident: Some(ref ident), .. } = named[0] {
+        if ident != "inner" {
+            return Err(Error::new(
+                ident.span(),
+                format!("The only field must be named 'inner': {msg}"),
+            ));
+        }
+
+        return Ok((Member::Named(ident.clone()), &named[0].ty))
+    }
+
+    Err(Error::new(
+        s.fields.span(),
+        format!("A single field struct is requried for {msg}"),
+    ))
 }
 
 fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), Error> {
@@ -129,8 +155,7 @@ fn derive_opaque_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     is_transparent_repr(&input, "#[derive(Wrapper)]")?;
 
     let name = &input.ident;
-    let field = &get_unnamed_field(&input, "#[derive(Wrapper)]")?;
-    let typ = &field.ty;
+    let (member, typ) = &get_wrapped_field(&input, "#[derive(Wrapper)]")?;
 
     Ok(quote! {
         unsafe impl ::common::opaque::Wrapper for #name {
@@ -143,15 +168,15 @@ pub unsafe fn from_raw<'a>(ptr: *mut <Self as ::common::opaque::Wrapper>::Wrappe
             }
 
             pub const fn as_mut_ptr(&self) -> *mut <Self as ::common::opaque::Wrapper>::Wrapped {
-                self.0.as_mut_ptr()
+                self.#member.as_mut_ptr()
             }
 
             pub const fn as_ptr(&self) -> *const <Self as ::common::opaque::Wrapper>::Wrapped {
-                self.0.as_ptr()
+                self.#member.as_ptr()
             }
 
             pub const fn as_void_ptr(&self) -> *mut ::core::ffi::c_void {
-                self.0.as_void_ptr()
+                self.#member.as_void_ptr()
             }
 
             pub const fn raw_get(slot: *mut Self) -> *mut <Self as ::common::opaque::Wrapper>::Wrapped {
-- 
2.51.0


