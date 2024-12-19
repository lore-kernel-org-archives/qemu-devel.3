Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C878E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 16:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOJFV-0001nd-SH; Thu, 19 Dec 2024 11:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOI-00065m-TW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOFOH-000887-BA
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 07:12:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734610348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqbmpoLQyfb2UAoXyBV1EOkxQeun0T/cCIXmsB4p+Sw=;
 b=LeL45Zt3hBuL0W6Y4EXPzwFFEFpTgBkS9knwJtZNzmB5hS3fAFxYl10CB4KDqT/WPRIhm1
 LIU1vu26T+lhlkK4weMELGG+SiPbJzwV/b+t823MPj4qBqY0zgqkbhEDSz6E4NZ2epm+Kp
 LpkuWtEaWjOpHwaWht0OghY584HDnGo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-cjgOhLUvMWC5uv65QPs9Yw-1; Thu, 19 Dec 2024 07:12:27 -0500
X-MC-Unique: cjgOhLUvMWC5uv65QPs9Yw-1
X-Mimecast-MFC-AGG-ID: cjgOhLUvMWC5uv65QPs9Yw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385e3cbf308so332600f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 04:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734610345; x=1735215145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqbmpoLQyfb2UAoXyBV1EOkxQeun0T/cCIXmsB4p+Sw=;
 b=iLmb4CCLoc6DfhJ94oQFxo/K/RAk/JNP44Bo3IO59tusVZdgvU/UkOYP2W4uSZm6d9
 SrBxFCwqXbsnslt71UipeTCRkMA6Vb71TL6PjCSsY78DwNPWtGqcFn0rjVaYDKA1ijOG
 LGQG/KvPSIpNNkkiFKKmnVqdhJYFdBMBSZnM6cFlSOGHiMla1ZN/Pfbp34pXoPdqXj43
 wQApFJA8102BwFf2mAIRC1hcAeDHiE5dN9HD0gOoN/wDnOQe3HQ3PT7KwFU6YCSZqWF0
 RHee0htY5gyGdOtEhP2jLZTapjb0aaIeI34GL33PKV/kdEaTSPQ45EAdwMTOcUHxB+SI
 A2Zw==
X-Gm-Message-State: AOJu0YwV92FYg/0Zzk7VEPqEt+wpOD+RdaePK0/ylOmgG2V0LvqMj6mJ
 Vf4D9Y6bMU43vy6eV+AodT/5l4pgU87j/E254Z2RfbdgPyOlvY3rUVyU4gfyh3TelGDF39HXym1
 2g3sfR63+Tj5v8Qz/SsUjzRZSErKm73rl0i5kdYz1sFu7jzvDFRTDUSBvCTQreK6ccHzBFEHsk+
 F4uEhhHCKlmQYIt/kOZ8giwtQt6wAdzUWnXsjT
X-Gm-Gg: ASbGncvKMatVfzpntLqA1vSbJM8MxKunYF2ar2UJElh6juu3j/ucZ5xhtVqNuCs8sOj
 96ZcsH3GKXabCYYtJfehztqf6nWuu2Sm0fuN6+pw2sTzdvNPfKPa4OR0Sj+dmqYaXDuSdx1yOji
 af69njh+/Oy8h9tLXTU8TMEozILT8/9sIfqcFgLLGzbDBIVdphNyqArCCAs1BwxVF+YqQDa2uWL
 8DpN4H3MPmMXisjVIq6wN1Euq0fKthVkG1SL2Vk9x1+AncOhet925eTDiga
X-Received: by 2002:a05:6000:4b0e:b0:386:3db6:2775 with SMTP id
 ffacd0b85a97d-388e4d8a6d1mr6487621f8f.25.1734610345114; 
 Thu, 19 Dec 2024 04:12:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmhl4axdIZriMSkZ7wACfJo+CMThnd4qeBvW38nmBDRihMD+to10bkB0vMJsDp0g+d+vzJsg==
X-Received: by 2002:a05:6000:4b0e:b0:386:3db6:2775 with SMTP id
 ffacd0b85a97d-388e4d8a6d1mr6487584f8f.25.1734610344669; 
 Thu, 19 Dec 2024 04:12:24 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b015absm50490235e9.13.2024.12.19.04.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 04:12:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
Subject: [PATCH 03/10] rust: macros: check that the first field of a
 #[derive(Object)] struct is a ParentField
Date: Thu, 19 Dec 2024 13:12:09 +0100
Message-ID: <20241219121216.416905-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241219121216.416905-1-pbonzini@redhat.com>
References: <20241219121216.416905-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
 rust/qemu-api-macros/src/lib.rs | 61 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 74a8bc7503e..778b698be45 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -19,6 +19,27 @@ fn from(err: CompileError) -> Self {
     }
 }
 
+fn get_fields<'a>(
+    input: &'a DeriveInput,
+    msg: &str,
+) -> Result<&'a Punctuated<Field, Comma>, CompileError> {
+    if let Data::Struct(s) = &input.data {
+        if let Fields::Named(fs) = &s.fields {
+            Ok(&fs.named)
+        } else {
+            Err(CompileError(
+                format!("Named fields required for {}", msg),
+                input.ident.span(),
+            ))
+        }
+    } else {
+        Err(CompileError(
+            format!("Struct required for {}", msg),
+            input.ident.span(),
+        ))
+    }
+}
+
 fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
     let expected = parse_quote! { #[repr(C)] };
 
@@ -32,38 +53,28 @@ fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
     }
 }
 
-#[proc_macro_derive(Object)]
-pub fn derive_object(input: TokenStream) -> TokenStream {
-    let input = parse_macro_input!(input as DeriveInput);
-    let name = input.ident;
+fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+    let name = &input.ident;
+    let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
+
+    Ok(quote! {
+        ::qemu_api::assert_field_type!(#name, #parent,
+            ::qemu_api::qom::ParentField<<#name as ::qemu_api::qom::ObjectImpl>::ParentType>);
 
-    let expanded = quote! {
         ::qemu_api::module_init! {
             MODULE_INIT_QOM => unsafe {
                 ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
             }
         }
-    };
-
-    TokenStream::from(expanded)
+    })
 }
 
-fn get_fields(input: &DeriveInput) -> Result<&Punctuated<Field, Comma>, CompileError> {
-    if let Data::Struct(s) = &input.data {
-        if let Fields::Named(fs) = &s.fields {
-            Ok(&fs.named)
-        } else {
-            Err(CompileError(
-                "Cannot generate offsets for unnamed fields.".to_string(),
-                input.ident.span(),
-            ))
-        }
-    } else {
-        Err(CompileError(
-            "Cannot generate offsets for union or enum.".to_string(),
-            input.ident.span(),
-        ))
-    }
+#[proc_macro_derive(Object)]
+pub fn derive_object(input: TokenStream) -> TokenStream {
+    let input = parse_macro_input!(input as DeriveInput);
+    let expanded = derive_object_or_error(input).unwrap_or_else(Into::into);
+
+    TokenStream::from(expanded)
 }
 
 #[rustfmt::skip::macros(quote)]
@@ -71,7 +82,7 @@ fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStrea
     is_c_repr(&input, "#[derive(offsets)]")?;
 
     let name = &input.ident;
-    let fields = get_fields(&input)?;
+    let fields = get_fields(&input, "#[derive(offsets)]")?;
     let field_names: Vec<&Ident> = fields.iter().map(|f| f.ident.as_ref().unwrap()).collect();
     let field_types: Vec<&Type> = fields.iter().map(|f| &f.ty).collect();
     let field_vis: Vec<&Visibility> = fields.iter().map(|f| &f.vis).collect();
-- 
2.47.1


