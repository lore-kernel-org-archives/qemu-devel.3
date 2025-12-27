Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC704E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQX-0003tg-Ec; Sat, 27 Dec 2025 04:17:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQV-0003fO-M7
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQQ-0002k0-HW
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIxIm1q5tYjU5GatZa6c3wxEnNz1WzWG0Tw3dE7ZdZs=;
 b=gCNw/fhhyhyBPxn+/qtb8CSPZoNpKul1zfesGddBQnw+AO2aNDKeBIUjXvYfctMkjq/tUu
 ztrfMvqma9r3fsaK2685fWFxJkcjQpxrOFN7GD5qabFXgWonAfHq0Hn2QjYIlGCjc1QJo7
 4n8ZcTwrObErYkGV8MuR5bjcidGG/dc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-L12XIUo_NqWb9_ahV-SnfQ-1; Sat, 27 Dec 2025 04:17:24 -0500
X-MC-Unique: L12XIUo_NqWb9_ahV-SnfQ-1
X-Mimecast-MFC-AGG-ID: L12XIUo_NqWb9_ahV-SnfQ_1766827043
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779b432aecso45556395e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827041; x=1767431841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIxIm1q5tYjU5GatZa6c3wxEnNz1WzWG0Tw3dE7ZdZs=;
 b=hBWqCpzziomhDN7BkhCRKKkXNPUy2/2lFZ/u4oheVz0ldzEJeHet9yMqOVHRU+8dxl
 s4Dk0wYSSRfALCYoRCJx3bJo9lc95vAho/R3R5n746HDKwM9+iwyqxb1rM9rno1Rtyv5
 4hHMShc8pLf8w7yJWlVJJVNyFcXQwYTeVZUIST0FDQdh14bgcZpOgTvmqNhOq/cIJdif
 NLeGNvuTnzsA6YY/9EuRuAbxAQZv4dYmcfRrUnzJhO+oBkvK83/j8hHIQj9SBNXW/xRg
 e0PPnhtdDs6wukYxLUUZQlUzJUHMxYCT/n0YiLwEBE2bjeKh4aQU6xIEZEw2bA/hkRYM
 lVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827041; x=1767431841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fIxIm1q5tYjU5GatZa6c3wxEnNz1WzWG0Tw3dE7ZdZs=;
 b=PpR0DjvmPB0yoWBTgP7G+Isrc7bJrZD7U5GwTJMVZFmKV/pzvd5xENS3zzOLb/88BO
 LRdldayrWJUe691fn+XNJP42vhgtLheUENXSBeg7r7vKkxv1SswOEjmNdnbhV2Nj/WpM
 2psL/noXu9gE0gCrgzXIo2AePsUCJpBQ/UP3tFjTEQodF+6IJF4mqVARMIj26383GZmY
 yMv/1droK1F3jNDPj8UXnvFXrN9VsEgIGSa+0ynM5c2ehsp/jwDQiWYqN/JQXrwnb1EA
 fTdr8zLSb1jUYILdRYWC0CMhGVkoYgaEQbnwH18hpGciy0y/PnKj352hZIqWK+jUXbeN
 AuRg==
X-Gm-Message-State: AOJu0Yy+pAiVw1SuTpaDnyAnzqOtacp+S1Ks8lrIddxuM7Fbsp0YtC8/
 dm6nNFvAnTYYo3YicQTIwlRV5TOCVFIIdNDgVZnu6QDBmd4R/3DdBbO7tnDfYnzOkU6BNmKmoUv
 llJL9F6f/HpylNEo/0vg+30HubKUyYbLKRCjr7gRppwio6156uWdQN+raTM78smiv9FwEZKB6qM
 OjCcWnDDcKAnqmV5vzd7lu3XUZWARG1cSrt2WELVLj
X-Gm-Gg: AY/fxX5x54WkqhTgRRsnhahjJGdFPBTH7WsOy8ONV1H9MOB9OabOHo3lHsaOTJ59ivw
 g4U4KVVB06oD2ASjvhTbUn1YtGTQVEnRov958rLHSO11GF3GjDgWBZ1HVvwWEI57+4WYcEX7xdX
 5iosw1w1JG/L37to/6G6KPSTJhsnDqCpwjxxtujhnh7H6ceTIhAzsiyYGwuWwxhDxSzy+6O80Ke
 F5ZFspQKsuAbB5HMKWjh/FqwqOKeedk7mhmMRoVwhIlePL0G9Z57c2WgukwiWqj0+gTwHIbvIJZ
 AFZdLu5Z10QyTRcLvo/MxF6X9BkyRY7+RxhWRGl/jTmGBuxdkaJiPwr2S+FcYHzX5ofzYggW2nF
 cumOIA+xI6c/hh6tFKIZ9rbeTjyQExjPSq/D+iSCf9TY6WZvqvpp5YeigqUFHDd2DO4TbYcuIcG
 Xu1oEHFPOpfZ4Ttf0=
X-Received: by 2002:a05:600d:101:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-47d1957b7c8mr189516735e9.24.1766827041318; 
 Sat, 27 Dec 2025 01:17:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOoNu16LC9DsIevHM2UHAPf7uAJC5pto81x1sFonitHhE1M0RBKHsdpLzxp4Ql1H7sckNEHg==
X-Received: by 2002:a05:600d:101:b0:475:de14:db1e with SMTP id
 5b1f17b1804b1-47d1957b7c8mr189516565e9.24.1766827040920; 
 Sat, 27 Dec 2025 01:17:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82feasm50100215f8f.24.2025.12.27.01.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 031/153] rust: remove unused --cfg arguments
Date: Sat, 27 Dec 2025 10:14:18 +0100
Message-ID: <20251227091622.20725-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-macros/meson.build                                 | 5 -----
 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build       | 3 ---
 subprojects/packagefiles/proc-macro-error-1-rs/meson.build   | 1 -
 .../packagefiles/proc-macro-error-attr-1-rs/meson.build      | 3 ---
 4 files changed, 12 deletions(-)

diff --git a/rust/qemu-macros/meson.build b/rust/qemu-macros/meson.build
index 0f27e0df925..17b2a4e2e24 100644
--- a/rust/qemu-macros/meson.build
+++ b/rust/qemu-macros/meson.build
@@ -2,11 +2,6 @@ _qemu_macros_rs = rust.proc_macro(
   'qemu_macros',
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
-  rust_args: [
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"',
-  ],
   dependencies: [
     attrs_rs_native,
     proc_macro2_rs_native,
diff --git a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
index 42b03dcd53c..04617b875c5 100644
--- a/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
+++ b/subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
@@ -26,9 +26,6 @@ _bilge_impl_rs = rust.proc_macro(
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_args: [
     '--cap-lints', 'allow',
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"',
   ],
   dependencies: [
     itertools_dep,
diff --git a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
index 10c2741085c..8ba558e1330 100644
--- a/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-1-rs/meson.build
@@ -23,7 +23,6 @@ _proc_macro_error_rs = static_library(
     '--cap-lints', 'allow',
     '--cfg', 'use_fallback',
     '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"',
     '-A', 'non_fmt_panics'
   ],
   dependencies: [
diff --git a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
index c4c4c5e397c..a85d7c07143 100644
--- a/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
+++ b/subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
@@ -17,9 +17,6 @@ _proc_macro_error_attr_rs = rust.proc_macro(
   override_options: ['rust_std=2018', 'build.rust_std=2018'],
   rust_args: [
     '--cap-lints', 'allow',
-    '--cfg', 'use_fallback',
-    '--cfg', 'feature="syn-error"',
-    '--cfg', 'feature="proc-macro"'
   ],
   dependencies: [
     proc_macro2_dep,
-- 
2.52.0


