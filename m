Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A323CE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2e-0000PZ-MU; Fri, 10 Jan 2025 13:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK23-0000FJ-B7
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:47:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK21-00016x-73
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S8n0kCt4mcc85Mr2w6mSqVhxshepjHtJ4wm1nMTk3V4=;
 b=d6/xXZv/mr91602SGiCXm6gsQaOCK6TR6ZRpvZtYeUiq2Eg5LNX7/C4YlV+Ot7PPBtbAYF
 sLtcBvhnY69vhQWiPeGlG3NIOUXPxjfaekVjuG/6ks7Iu2m61cEU0v13cHiVgQc0N4qF6b
 On2W2tc8t3siV+ZhXfibPzfVRAVpGzk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237--YjIaeWzPGarHuSdY7cdaA-1; Fri, 10 Jan 2025 13:46:49 -0500
X-MC-Unique: -YjIaeWzPGarHuSdY7cdaA-1
X-Mimecast-MFC-AGG-ID: -YjIaeWzPGarHuSdY7cdaA
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab2e44dc9b8so133750966b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534807; x=1737139607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8n0kCt4mcc85Mr2w6mSqVhxshepjHtJ4wm1nMTk3V4=;
 b=wlNJBxpVIPXbE0LkK362ZbWkybelT1j6ZebPgbCqL1QInBuhpki3em7kB8e5VXVcRF
 /+3bCk/18cIVD3nL0b1ucP6Ka0c3HcZOvKBfPhBgT9qioeY6DbfmjreTSMjGKcMC6jA/
 C7LDiQ3weyb64LPteNV1UQJscXQUx+50Tmq6OXYiUeO4nRIzfW7sPB92QLuN6wXQLhmv
 7Qx5Sbtsi+XnoqyYe3PYa1ePPNUyGGe434A+0k5bJFX/Hnm1HbCJ/5SNQHiZs756sRq2
 eaZQ4CFfacb8q+FeTzvYpxTdr2SiO+b71+bSlkg/erUDrreUmkxiG+FrrI5y1B8PsSJ4
 Ak2A==
X-Gm-Message-State: AOJu0Ywu1ctc3PiIRdu5GqvVPiq08fqc+Hfh/Pn4HQTVxZwRCfSynDZt
 xuwz31iM+lm6LXAbYav26NySKOK5RZv/KlIb0xatZVF07ssUKlnM/Y6762zYrX75lLKZ2px8pL2
 igRACcf0KSY7fvcLc3myfSCaxvXKvj4Ilaa369j0wPCQOO/sfK+uUGglGv1Z3Fg1VuSW+Q5S2jx
 WHngsgHZoFEf6IH70fXUh0qi/qd7pos5/iQZWtEB4=
X-Gm-Gg: ASbGncvP5E5r8ypj0x1ziOeHV7c28tjn0nw/rKuvnWr5m/FrFujwlMwzJpfS+9QALgu
 xshJDWmxCuk7hl9MrRAsrZQJkQI5WyoDEwOMDjev61N7cRLsOjoMBAy0i/oXuyHIc5ralsxlVPT
 or3It9vMpC54LL+4x8I2qm1wniFoDwRtnypEmpvXbeXKCTXUXcEe2hKc6vyGdiOoQbHYgujkunG
 GsImEP6JGSDZtcGjlYXTpT4/dAXRWiFHWWo42nnUJ8ddfK1+AlxGt8AZsg=
X-Received: by 2002:a17:907:a089:b0:ab2:f255:59f5 with SMTP id
 a640c23a62f3a-ab2f2555c3dmr87351066b.16.1736534807187; 
 Fri, 10 Jan 2025 10:46:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/pE4egY3x8fmRItuhx93k3akiy43aBObtP9ylLHepB4lkfHNm544iV4bQfjZku5L7XD7++A==
X-Received: by 2002:a17:907:a089:b0:ab2:f255:59f5 with SMTP id
 a640c23a62f3a-ab2f2555c3dmr87348466b.16.1736534806738; 
 Fri, 10 Jan 2025 10:46:46 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2eadb6638sm57728466b.43.2025.01.10.10.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 11/38] rust: qemu-api-macros: extend error reporting facility
 to parse errors
Date: Fri, 10 Jan 2025 19:45:52 +0100
Message-ID: <20250110184620.408302-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Generalize the CompileError tuple to an enum, that can be either an error
message or a parse error from syn.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api-macros/src/lib.rs   | 27 ++++++++++-----------------
 rust/qemu-api-macros/src/utils.rs | 26 ++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 17 deletions(-)
 create mode 100644 rust/qemu-api-macros/src/utils.rs

diff --git a/rust/qemu-api-macros/src/lib.rs b/rust/qemu-api-macros/src/lib.rs
index 0f04cca3841..539c48df298 100644
--- a/rust/qemu-api-macros/src/lib.rs
+++ b/rust/qemu-api-macros/src/lib.rs
@@ -3,57 +3,50 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 use proc_macro::TokenStream;
-use proc_macro2::Span;
-use quote::{quote, quote_spanned};
+use quote::quote;
 use syn::{
     parse_macro_input, parse_quote, punctuated::Punctuated, token::Comma, Data, DeriveInput, Field,
     Fields, Ident, Type, Visibility,
 };
 
-struct CompileError(String, Span);
-
-impl From<CompileError> for proc_macro2::TokenStream {
-    fn from(err: CompileError) -> Self {
-        let CompileError(msg, span) = err;
-        quote_spanned! { span => compile_error!(#msg); }
-    }
-}
+mod utils;
+use utils::MacroError;
 
 fn get_fields<'a>(
     input: &'a DeriveInput,
     msg: &str,
-) -> Result<&'a Punctuated<Field, Comma>, CompileError> {
+) -> Result<&'a Punctuated<Field, Comma>, MacroError> {
     if let Data::Struct(s) = &input.data {
         if let Fields::Named(fs) = &s.fields {
             Ok(&fs.named)
         } else {
-            Err(CompileError(
+            Err(MacroError::Message(
                 format!("Named fields required for {}", msg),
                 input.ident.span(),
             ))
         }
     } else {
-        Err(CompileError(
+        Err(MacroError::Message(
             format!("Struct required for {}", msg),
             input.ident.span(),
         ))
     }
 }
 
-fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), CompileError> {
+fn is_c_repr(input: &DeriveInput, msg: &str) -> Result<(), MacroError> {
     let expected = parse_quote! { #[repr(C)] };
 
     if input.attrs.iter().any(|attr| attr == &expected) {
         Ok(())
     } else {
-        Err(CompileError(
+        Err(MacroError::Message(
             format!("#[repr(C)] required for {}", msg),
             input.ident.span(),
         ))
     }
 }
 
-fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+fn derive_object_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
     is_c_repr(&input, "#[derive(Object)]")?;
 
     let name = &input.ident;
@@ -80,7 +73,7 @@ pub fn derive_object(input: TokenStream) -> TokenStream {
 }
 
 #[rustfmt::skip::macros(quote)]
-fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, CompileError> {
+fn derive_offsets_or_error(input: DeriveInput) -> Result<proc_macro2::TokenStream, MacroError> {
     is_c_repr(&input, "#[derive(offsets)]")?;
 
     let name = &input.ident;
diff --git a/rust/qemu-api-macros/src/utils.rs b/rust/qemu-api-macros/src/utils.rs
new file mode 100644
index 00000000000..02c91aed7f6
--- /dev/null
+++ b/rust/qemu-api-macros/src/utils.rs
@@ -0,0 +1,26 @@
+// Procedural macro utilities.
+// Author(s): Paolo Bonzini <pbonzini@redhat.com>
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+use proc_macro2::Span;
+use quote::quote_spanned;
+
+pub enum MacroError {
+    Message(String, Span),
+    ParseError(syn::Error),
+}
+
+impl From<syn::Error> for MacroError {
+    fn from(err: syn::Error) -> Self {
+        MacroError::ParseError(err)
+    }
+}
+
+impl From<MacroError> for proc_macro2::TokenStream {
+    fn from(err: MacroError) -> Self {
+        match err {
+            MacroError::Message(msg, span) => quote_spanned! { span => compile_error!(#msg); },
+            MacroError::ParseError(err) => err.into_compile_error(),
+        }
+    }
+}
-- 
2.47.1


