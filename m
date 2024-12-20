Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFBEE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 14:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOe1W-0004UK-4z; Fri, 20 Dec 2024 09:30:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1P-0004Sn-BC
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tOe1L-0006bP-8M
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 09:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734705026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Szoag27KIkqUli3n0xSrTUcaxn0aravcRGL/6Nt+Rm8=;
 b=QmQ4b/Umxa9zicyRjKfaTsnh4kVNaGfrwSsbsh3nVxotzH+Bvd7jOks0xCs059iT5xE1kJ
 aSw+zjTI0Aa7J80hf+zGxVsOes6MZ5U6xvuPSmIdB2OLvGyAudXksQ0qiYO226Hg2XeeOm
 AhsXdBht8j7vCXq/xs8qXKE9or+hn7o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-AEFODpjZPZ6tQICh2AhyoA-1; Fri, 20 Dec 2024 09:30:24 -0500
X-MC-Unique: AEFODpjZPZ6tQICh2AhyoA-1
X-Mimecast-MFC-AGG-ID: AEFODpjZPZ6tQICh2AhyoA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385d735965bso1178949f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 06:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705022; x=1735309822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Szoag27KIkqUli3n0xSrTUcaxn0aravcRGL/6Nt+Rm8=;
 b=UykYY19OeyGPgESLmpBY6UJ7613RBHMSEKCCgq6zs+7aLrJbwsteFkOudmPxRZXoyY
 N/w22FPIS560BdCEsXBrTbCaEAQU+1M1G8rhDykUNCAr8BaagqMNiduiXwmR6KFO+vl2
 Wto3Ua6WkK8W1/U+LEigXUqjDoXEfas1pen35be2j2ZspPaZMmNupTr7cnF6l+QcvT3H
 iXy/nO2It6On4d6xRoHrYZ04qOBBv8VHr6Z1HAnCT1FqEADowivVsz4a3MY+dq0IqiRn
 b06fzFCQUJHKrNDixQmwBt1UhBam9ON1s+h4tJjr+LbbPBZIDXCriG0AL4XVQedx45fa
 HL9w==
X-Gm-Message-State: AOJu0YzMnyHeekvrGa72gMxMhSL5XVkHLo9TJ/SBATb73FzRrkeV/59D
 mroejnxHcCu+Uxllrfen0xMdgaBJZHTEpLtWknR5jcMg6tl5uIFNIci7TxqxPkFXuwHax4aY6ut
 cutQdl9i2pQTtoRf8/Q+Yf741s5gpYve5XaiHct2oq3U4f6L/Ce8JkD9JPS5yR5NbHt89nG9kM+
 LYmR/crmhfz/4Lv6KxxGByXNWWE1py5pElZdL3
X-Gm-Gg: ASbGncu0FLGAA6GRqDuX0tO3ekVNceEL5LrrQ9NlRh92m94e6INPhwbbINm0x9AScTX
 PK/afkip1NgzONE0WE4SMhEmsf+wJT/BiQLGSV8c/UtRt6TxWQOR/YtuNiXmeMb4uMv+/2md1ag
 mQ7VCvx+wCG9spyAVGv5pWR+50AvzKeqKY46CiqrIaV5mk/raSNhZo5CNBsiYEoq62ro2cKKAS6
 I43+qdixfIsAMWBkZuesHh9uVWE2Byhiph9KRAPTEiiubjjWvhWcBzRyI9r
X-Received: by 2002:a5d:6d07:0:b0:385:f2a5:ef6a with SMTP id
 ffacd0b85a97d-38a221eaa5fmr3293928f8f.15.1734705022197; 
 Fri, 20 Dec 2024 06:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcGREriZdYrwfdKOQVlcM1YTgvD2rFEL6BRQMB0vo4IR5CccD8ADRPKD3WlS4diVwqozNl3Q==
X-Received: by 2002:a5d:6d07:0:b0:385:f2a5:ef6a with SMTP id
 ffacd0b85a97d-38a221eaa5fmr3293884f8f.15.1734705021699; 
 Fri, 20 Dec 2024 06:30:21 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8330d4sm4154986f8f.29.2024.12.20.06.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:30:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com,
	junjie.mao@hotmail.com
Subject: [PATCH 10/12] rust: qemu-api-macros: extend error reporting facility
 to parse errors
Date: Fri, 20 Dec 2024 15:29:52 +0100
Message-ID: <20241220142955.652636-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220142955.652636-1-pbonzini@redhat.com>
References: <20241220142955.652636-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Generalize the CompileError tuple to an enum, that can be either an error
message or a parse error from syn.

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


