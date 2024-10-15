Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC768D216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hR7-00024A-69; Tue, 15 Oct 2024 09:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hR2-00023l-NA
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hR0-0001Dm-Tk
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20vvSyFpZURhPY07pvl6EKKD9oQ8iAAak08m0L+pzSY=;
 b=V3qBAUZBEfpt+IlYQwfOR2fEPKkLPaXy9OsAWPiDTobVl5cxJr75Iua3TojJCJh0i3RSZX
 b+LIEHlepCmlCLtXN9xiOzvT8L5qleFVfkLbtFx/zn2WtkLToRlK1Fevq1f3UG0T8kqaD4
 cZcEsjsim5GNOrCQv5hcrg04brRylQA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-wZbqc7OkOUSKCqq96gXbFg-1; Tue, 15 Oct 2024 09:17:55 -0400
X-MC-Unique: wZbqc7OkOUSKCqq96gXbFg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d67f4bf98so1440819f8f.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:17:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998272; x=1729603072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20vvSyFpZURhPY07pvl6EKKD9oQ8iAAak08m0L+pzSY=;
 b=YDflC7Pq+QLooRKtKOHAs53nzHit7VP6eKjHcNarHM55oNr2hq4I4oB562uKJh/jQI
 WINo3/v0bVFFHgrgKva/cpQ93l3R1cuXOOHgGXPvwY5ZP2oF5kZrhil/6/GBwvqX9veG
 S+gdij6S9eYuo+iiEfOj6PdslXcr6pS852yOZQ+L8FMnocZqs+eNfmEZ1Nws5kboIMa8
 wFh1OaWxRFSngJETIy8FrcI7SSIjzR1sSdmbjovXK7eK52zG2X24fb2DeDA7itPf4aBw
 v9+ss+Px5Kgz0IitpekCI40U30TaZv/JlnJz5v6Hi3UCPA9jNIJbobNsyf0muyecP5Se
 f8IQ==
X-Gm-Message-State: AOJu0YxChvc0k+fP+PoBAk58nGnsdafhgg8TSbIgEOnBgvVdjfNNGlg0
 Zc+Qon6HYbRnhoY8zfn2Ps6vLHN+jxZin0IcX5cuDZZ5RINT1yJaBR5fgM9Eo2CoiqfHFMy4V5t
 9xkN5eH5KEfBk73vLxr1Z4k0Rmb6m64tWkZeEJRYf/D6FyJDwABDv6C959afUQPzqPwAH3aDenR
 jrrRibf1YZ3Q69VWqFbFvfrHq5RSjntfpURDXIUUA=
X-Received: by 2002:a05:6000:1568:b0:37d:476d:2d58 with SMTP id
 ffacd0b85a97d-37d86d50563mr246503f8f.45.1728998272140; 
 Tue, 15 Oct 2024 06:17:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4mddPrdb45gV5NBoEKhlQc+PATGqGnWPTKEfPL9FP1OuhPMgYp/iDN/rmLsvcjcxMWlmaNw==
X-Received: by 2002:a05:6000:1568:b0:37d:476d:2d58 with SMTP id
 ffacd0b85a97d-37d86d50563mr246470f8f.45.1728998271556; 
 Tue, 15 Oct 2024 06:17:51 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fbf81b4sm1560697f8f.79.2024.10.15.06.17.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:17:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/16] rust: patch bilge-impl to allow compilation with 1.63.0
Date: Tue, 15 Oct 2024 15:17:22 +0200
Message-ID: <20241015131735.518771-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Apply a patch that removes "let ... else" constructs, replacing them with
"if let ... else" or "let ... =3D match ...".  "let ... else" was stabilize=
d in
Rust 1.65.0.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitattributes                                |  2 +
 subprojects/bilge-impl-0.2-rs.wrap            |  1 +
 .../packagefiles/bilge-impl-1.63.0.patch      | 45 +++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

diff --git a/.gitattributes b/.gitattributes
index 6dc6383d3d1..9ce7a19581a 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -5,3 +5,5 @@
 *.rs            diff=3Drust
 *.rs.inc        diff=3Drust
 Cargo.lock      diff=3Dtoml merge=3Dbinary
+
+*.patch         -text -whitespace
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.=
2-rs.wrap
index eefb10c36c2..b24c34a9043 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -5,3 +5,4 @@ source_filename =3D bilge-impl-0.2.0.tar.gz
 source_hash =3D feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000=
adb2d8
 #method =3D cargo
 patch_directory =3D bilge-impl-0.2-rs
+diff_files =3D bilge-impl-1.63.0.patch
diff --git a/subprojects/packagefiles/bilge-impl-1.63.0.patch b/subprojects=
/packagefiles/bilge-impl-1.63.0.patch
new file mode 100644
index 00000000000..987428a6d65
--- /dev/null
+++ b/subprojects/packagefiles/bilge-impl-1.63.0.patch
@@ -0,0 +1,45 @@
+--- a/src/shared/discriminant_assigner.rs
++++ b/src/shared/discriminant_assigner.rs
+@@ -26,20 +26,20 @@
+         let discriminant_expr =3D &discriminant.1;
+         let variant_name =3D &variant.ident;
+=20
+-        let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) =3D discriminan=
t_expr else {
++        if let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) =3D discrimi=
nant_expr {
++            let discriminant_value: u128 =3D int.base10_parse().unwrap_or=
_else(unreachable);
++            if discriminant_value > self.max_value() {
++                abort!(variant, "Value of variant exceeds the given numbe=
r of bits")
++            }
++
++            Some(discriminant_value)
++        } else {
+             abort!(
+                 discriminant_expr,
+                 "variant `{}` is not a number", variant_name;
+                 help =3D "only literal integers currently supported"
+             )
+-        };
+-
+-        let discriminant_value: u128 =3D int.base10_parse().unwrap_or_els=
e(unreachable);
+-        if discriminant_value > self.max_value() {
+-            abort!(variant, "Value of variant exceeds the given number of=
 bits")
+         }
+-
+-        Some(discriminant_value)
+     }
+=20
+     fn assign(&mut self, variant: &Variant) -> u128 {
+--- a/src/shared/fallback.rs
++++ b/src/shared/fallback.rs
+@@ -22,8 +22,9 @@
+             }
+             Unnamed(fields) =3D> {
+                 let variant_fields =3D fields.unnamed.iter();
+-                let Ok(fallback_value) =3D variant_fields.exactly_one() e=
lse {
+-                    abort!(variant, "fallback variant must have exactly o=
ne field"; help =3D "use only one field or change to a unit variant")
++                let fallback_value =3D match variant_fields.exactly_one()=
 {
++                    Ok(ok) =3D> ok,
++                    _ =3D> abort!(variant, "fallback variant must have ex=
actly one field"; help =3D "use only one field or change to a unit variant")
+                 };
+=20
+                 if !is_last_variant {
--=20
2.46.2


