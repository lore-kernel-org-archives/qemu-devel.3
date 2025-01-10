Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D5FE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2x-00012u-9W; Fri, 10 Jan 2025 13:47:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1w-0000C3-3w
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1q-00015Z-56
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VgkejbxfBm5Z+fcfrq4PM2AVjZL5LxnPI4rmsBdS2Ng=;
 b=Gju39WL4RiUyRssQ6YMfbe44ZNK4wpsNIyysq4ErXdD+koVF+tbvuYk+Ecu8i2HtX1pjxr
 UogesI3XpyIeuhuDeiE6h7iwyvgDQQDsGnYyNklG2phDi7y99Vc4kHp9zaznOhzoDw63V6
 9kDbn7v53z6+U9zuk1eNgkU7dbEYaws=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-wvQozBUSMjWkSxFN08LEcg-1; Fri, 10 Jan 2025 13:46:38 -0500
X-MC-Unique: wvQozBUSMjWkSxFN08LEcg-1
X-Mimecast-MFC-AGG-ID: wvQozBUSMjWkSxFN08LEcg
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d3fe75a9f0so2264524a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534796; x=1737139596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VgkejbxfBm5Z+fcfrq4PM2AVjZL5LxnPI4rmsBdS2Ng=;
 b=HOoXA2lFwIDPtYoxS+Im3RNy6nu1VCrsJxLsvKdV63Ir6A/XwykTNqg24tmv25cgwd
 mR967HVOr05TkDNy8vwKgkFBv9r8wQdd9XiHJ1SmaGesKKDylZzZvexeCixebu2jxj+o
 3BWN3J908zZguy/RToGA2VUM1WVtCtYz0mgwGzv3kptUI64mU7FBMFtj5fyXCkwNeRWZ
 jVF3t4JEmzxyOLwK5BzhPaCpBr843bPHIbD/ovJ3acqzowx2ID1M3RFLPQS2tzpe/1V/
 RgU6mWx61xlrgk+e0cVeeSbBwYGXAQNlJHg49tw8542N9YRq1a7uJ4uJD7PG9cyRd9Qh
 F7Zw==
X-Gm-Message-State: AOJu0YxaaRSqTCCLpBqmc5dSXp3lvTlD/pEe3FyW2qoGI3ZYP7pPoW7/
 /1sKMU3V5w5CI+15RGyishY/tgWywMpwNsVAlW8lVFgHqVDFNDlBrw82sP1eq2BzrBI/tdJgOZA
 yP4FrofHJO1EHXaPj7UADogMsVTxVNeH1qsRG3uQBtRaweQQDwJ92jX1Wa9XyINZcfOvnQcMT/O
 Nfy/+lFtbEbM2djosKIP7FoAsEUShqeRi+VqyiEI8=
X-Gm-Gg: ASbGncuFiNGY08GJm460fJzIC80ZjIE5x/LHADFZ3wSHiDwVRoC4a8rt/zw2EW4d4+9
 rZFeHLgrbJ5T8kY7MwLKa1xtsk/05gAx88g8A/q7NkZOfMqmXHLyXP9bktVtJmzVuSXi2CrBsle
 sGOkQzwygURjxo0NlgklLeoiB4I+i3nPygH/8EzCH0QE1He4s2cWhSELxGNYOwRFOwvSQ99B6F7
 Gvj9sAHxNCsI35m1JjnVal9FOTCtPq9A2PRJvP4lMDgeAnCnzHJggPPBMM=
X-Received: by 2002:a05:6402:51cf:b0:5d3:bc1d:e56d with SMTP id
 4fb4d7f45d1cf-5d972e70310mr10034831a12.31.1736534796159; 
 Fri, 10 Jan 2025 10:46:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6TPbCmZKnWbaWfGBaUn0/ENicWa7Esf12w48vFKCAWso9g2vdYvh+njXfN1tUVVQD5xHnAw==
X-Received: by 2002:a05:6402:51cf:b0:5d3:bc1d:e56d with SMTP id
 4fb4d7f45d1cf-5d972e70310mr10034801a12.31.1736534795644; 
 Fri, 10 Jan 2025 10:46:35 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c39fsm1936935a12.13.2025.01.10.10.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/38] rust: macros: check that the first field of a
 #[derive(Object)] struct is a ParentField
Date: Fri, 10 Jan 2025 19:45:47 +0100
Message-ID: <20250110184620.408302-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs | 46 +++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 160b283d7fd..0f04cca3841 100644
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
 
@@ -36,7 +57,12 @@ fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream
     is_c_repr(&input, "#[derive(Object)]")?;
 
     let name = &input.ident;
+    let parent = &get_fields(&input, "#[derive(Object)]")?[0].ident;
+
     Ok(quote! {
+        ::qemu_api::assert_field_type!(#name, #parent,
+            ::qemu_api::qom::ParentField<<#name as ::qemu_api::qom::ObjectImpl>::ParentType>);
+
         ::qemu_api::module_init! {
             MODULE_INIT_QOM => unsafe {
                 ::qemu_api::bindings::type_register_static(&<#name as ::qemu_api::qom::ObjectImpl>::TYPE_INFO);
@@ -53,30 +79,12 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
     TokenStream::from(expanded)
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
-}
-
 #[rustfmt::skip::macros(quote)]
 fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
     is_c_repr(&input, "#[derive(offsets)]")?;
 
     let name = &input.ident;
-    let fields = get_fields(&input)?;
+    let fields = get_fields(&input, "#[derive(offsets)]")?;
     let field_names: Vec<&Ident> = fields.iter().map(|f| f.ident.as_ref().unwrap()).collect();
     let field_types: Vec<&Type> = fields.iter().map(|f| &f.ty).collect();
     let field_vis: Vec<&Visibility> = fields.iter().map(|f| &f.vis).collect();
-- 
2.47.1


