Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9D2C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKEs-0003hR-3B; Tue, 06 May 2025 11:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEp-0003fW-LS
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCKEn-0001wd-JT
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746545380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqAmlc5xorC7DUYYAMTvmDQnZIdhQQMyM8InBOMPed4=;
 b=WZS18ErlP/VCrAGj01LfsNMQw9S+utQnhBtZrTm4BoqrjYqJhGDAAGXAH10H6dEAfiRfcp
 R3XfSCBehMRweiZ7ySoV5r28HeWu5UBdJircm1xVigBg4vblgG89JcxbBxE2E5akPkwEMi
 HgvixdJ3hWS3aheVUwXJgV63hS4OqtQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-hleaDwvgMkWXYGGFgMIbIg-1; Tue, 06 May 2025 11:29:39 -0400
X-MC-Unique: hleaDwvgMkWXYGGFgMIbIg-1
X-Mimecast-MFC-AGG-ID: hleaDwvgMkWXYGGFgMIbIg_1746545378
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4298so2960590f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545377; x=1747150177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqAmlc5xorC7DUYYAMTvmDQnZIdhQQMyM8InBOMPed4=;
 b=JdRc0752miuo/Oys623PKTg2nn6vHH0+lK9ZL/uTKcztaM4XV7k9oYtVSsExNbJ9P8
 WUehZ+Van1weEx5vLIbCs2HfH/dRdCAi9Ige+so3pB2qWSc8WN5cRLcoxvqrzl5PzBSp
 eTj20J4J/rmmRy2cf/Af6ju4nvbOdHtdxyTV5BtqvYLTnfE5vcOrPA/A1dSL2WW7LyHN
 dbu86QVHqdHrI9FWCy71dpsIpO4bbR5Vp2va2jKN0HWZyjnKvX/iJ85l+r9O64eMXZZT
 RlQZwFUeUY6CzahjDJLXH3p0mdv1AwEebpP0Jup5r7a0kngzgXans4FjATA0l9EYnR/s
 TT8g==
X-Gm-Message-State: AOJu0YyPFtPZ8YoosWBeo5g4uDuug3RJ43p9Sa3k3P8PfZuqRp+Or9DX
 +3gSjAADEybk/1OsWuau0gnENXDUpZfzEkKJkVpVvIA2pZZ9RzbjeG2WJdAWcaS0rO6/XWoxJbt
 yPT2auZEnhxH3CYDzHLv2tilUGwrSevyofKl+UHWDmfyrkjg3yyDyxzIQ8n/Q1QgGXWfF+zObOF
 bawvkQNzFUiG98kFHd0ZA7P56BJ4e1miv4rGV5
X-Gm-Gg: ASbGnctk2w46bzLKEBNw4XRnOk+N1WG2Se1qcwbQQPDIg4UmJc1yNsE9xcgfRM4PHLS
 qb7jDd+gK5yNjngsxHxaS/zvmnHtyeIkHdxBjWq/oUzhypIt68WAlADaGN0S+EhoFVdbgbqp5rI
 vKNdyOxFFE+wsg6mWbDms3SJCskzrxajwu4O2J2itszsA8FGvzX4n7K9dIWNItfR7WFEvS6qOKK
 +ByJ+WM7Tas0PGLFIlIDs+pRF49v2QgpL+IszGgPHbnaMo5d0PPGQCDElEiZxntq0N9zV03QUzU
 60KApqEQhA9wjOk=
X-Received: by 2002:a05:6000:2902:b0:3a0:8c3e:5a4b with SMTP id
 ffacd0b85a97d-3a0ac0da235mr3274587f8f.16.1746545376845; 
 Tue, 06 May 2025 08:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWiujdMwZ3Brl7RMktzF4M9/LToye1+nbmRVBodrtcPMJmkOiuA7vJC8DT2ybruBa/cm0d4Q==
X-Received: by 2002:a05:6000:2902:b0:3a0:8c3e:5a4b with SMTP id
 ffacd0b85a97d-3a0ac0da235mr3274553f8f.16.1746545376266; 
 Tue, 06 May 2025 08:29:36 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441bc264e2dsm152571775e9.12.2025.05.06.08.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 08:29:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 04/30] rust: let bilge use "let ... else"
Date: Tue,  6 May 2025 17:28:59 +0200
Message-ID: <20250506152927.222671-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506152927.222671-1-pbonzini@redhat.com>
References: <20250506152927.222671-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"let ... else" was stabilized in 1.65.0; bumping the minimum supported
Rust version means we don't need to patch it out anymore.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                           |  3 --
 subprojects/bilge-impl-0.2-rs.wrap            |  1 -
 .../packagefiles/bilge-impl-1.63.0.patch      | 45 -------------------
 3 files changed, 49 deletions(-)
 delete mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index c7dfba98de1..8167ff49aa9 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -76,9 +76,6 @@ are missing:
 
 * ``cast_mut()``/``cast_const()`` (1.65.0).  Use ``as`` instead.
 
-* "let ... else" (1.65.0).  Use ``if let`` instead.  This is currently patched
-  in QEMU's vendored copy of the bilge crate.
-
 * Generic Associated Types (1.65.0)
 
 * ``CStr::from_bytes_with_nul()`` as a ``const`` function (1.72.0).
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
index d14c3dc769b..4f84eca1ccd 100644
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ b/subprojects/bilge-impl-0.2-rs.wrap
@@ -5,7 +5,6 @@ source_filename = bilge-impl-0.2.0.tar.gz
 source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
 #method = cargo
 patch_directory = bilge-impl-0.2-rs
-diff_files = bilge-impl-1.63.0.patch
 
 # bump this version number on every change to meson.build or the patches:
 # v2
diff --git a/subprojects/packagefiles/bilge-impl-1.63.0.patch b/subprojects/packagefiles/bilge-impl-1.63.0.patch
deleted file mode 100644
index 987428a6d65..00000000000
--- a/subprojects/packagefiles/bilge-impl-1.63.0.patch
+++ /dev/null
@@ -1,45 +0,0 @@
---- a/src/shared/discriminant_assigner.rs
-+++ b/src/shared/discriminant_assigner.rs
-@@ -26,20 +26,20 @@
-         let discriminant_expr = &discriminant.1;
-         let variant_name = &variant.ident;
- 
--        let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) = discriminant_expr else {
-+        if let Expr::Lit(ExprLit { lit: Lit::Int(int), .. }) = discriminant_expr {
-+            let discriminant_value: u128 = int.base10_parse().unwrap_or_else(unreachable);
-+            if discriminant_value > self.max_value() {
-+                abort!(variant, "Value of variant exceeds the given number of bits")
-+            }
-+
-+            Some(discriminant_value)
-+        } else {
-             abort!(
-                 discriminant_expr,
-                 "variant `{}` is not a number", variant_name;
-                 help = "only literal integers currently supported"
-             )
--        };
--
--        let discriminant_value: u128 = int.base10_parse().unwrap_or_else(unreachable);
--        if discriminant_value > self.max_value() {
--            abort!(variant, "Value of variant exceeds the given number of bits")
-         }
--
--        Some(discriminant_value)
-     }
- 
-     fn assign(&mut self, variant: &Variant) -> u128 {
---- a/src/shared/fallback.rs
-+++ b/src/shared/fallback.rs
-@@ -22,8 +22,9 @@
-             }
-             Unnamed(fields) => {
-                 let variant_fields = fields.unnamed.iter();
--                let Ok(fallback_value) = variant_fields.exactly_one() else {
--                    abort!(variant, "fallback variant must have exactly one field"; help = "use only one field or change to a unit variant")
-+                let fallback_value = match variant_fields.exactly_one() {
-+                    Ok(ok) => ok,
-+                    _ => abort!(variant, "fallback variant must have exactly one field"; help = "use only one field or change to a unit variant")
-                 };
- 
-                 if !is_last_variant {
-- 
2.49.0


