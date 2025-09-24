Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A807CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OK0-0005xv-N1; Wed, 24 Sep 2025 08:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OI1-0003X0-3i
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OHp-0006Mn-Tj
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758715668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1m2pHWywfrRLUvLMktLjK/bEHRZ6iHxYBR9qqTKd0K0=;
 b=A3ZlMEty5Db088HmREuVJCZjSsObuIR8lvKL2OhEQJqN7Ya8yJPmdGUizgyOzHRECewpjS
 u/f3F4177UpG5B5WRikNwETOMbYKHUbqnEl8a0G/uMEMlW2yEhoEI9aYzxoM3N0v7Nsne9
 omBw0iyP3MkC3yZJ7Mzx5E41csajvTQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-28G4wHH4MI2PkQPuT7kllQ-1; Wed,
 24 Sep 2025 08:07:43 -0400
X-MC-Unique: 28G4wHH4MI2PkQPuT7kllQ-1
X-Mimecast-MFC-AGG-ID: 28G4wHH4MI2PkQPuT7kllQ_1758715661
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 49466195609F; Wed, 24 Sep 2025 12:07:41 +0000 (UTC)
Received: from localhost (unknown [10.44.22.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07DDF3000198; Wed, 24 Sep 2025 12:07:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 devel@lists.libvirt.org, qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: [PATCH v2 26/27] build-sys: pass -fvisibility=default for wasm bindgen
Date: Wed, 24 Sep 2025 16:04:23 +0400
Message-ID: <20250924120426.2158655-27-marcandre.lureau@redhat.com>
In-Reply-To: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Otherwise, no functions are generated:
https://github.com/rust-lang/rust-bindgen/issues/2989

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build                    | 4 ++++
 rust/bql/meson.build           | 1 +
 rust/chardev/meson.build       | 1 +
 rust/hw/char/pl011/meson.build | 1 +
 rust/hw/core/meson.build       | 1 +
 rust/migration/meson.build     | 3 ++-
 rust/qom/meson.build           | 1 +
 rust/system/meson.build        | 1 +
 rust/util/meson.build          | 1 +
 9 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 2f134c9e75..cd2b5fa863 100644
--- a/meson.build
+++ b/meson.build
@@ -4255,6 +4255,10 @@ if have_rust
   else
     bindgen_args_common += ['--merge-extern-blocks']
   endif
+  bindgen_c_args = []
+  if host_arch == 'wasm32'
+    bindgen_c_args += ['-fvisibility=default']
+  endif
   subdir('rust')
 endif
 
diff --git a/rust/bql/meson.build b/rust/bql/meson.build
index f369209dfd..d020a519bf 100644
--- a/rust/bql/meson.build
+++ b/rust/bql/meson.build
@@ -21,6 +21,7 @@ _bql_bindings_inc_rs = rust.bindgen(
   include_directories: bindings_incdir,
   bindgen_version: ['>=0.60.0'],
   args: bindgen_args_common,
+  c_args: bindgen_c_args,
 )
 
 _bql_rs = static_library(
diff --git a/rust/chardev/meson.build b/rust/chardev/meson.build
index 370895c111..e7ce02b3bc 100644
--- a/rust/chardev/meson.build
+++ b/rust/chardev/meson.build
@@ -20,6 +20,7 @@ _chardev_bindings_inc_rs = rust.bindgen(
   include_directories: bindings_incdir,
   bindgen_version: ['>=0.60.0'],
   args: bindgen_args_common + _chardev_bindgen_args,
+  c_args: bindgen_c_args,
 )
 
 _chardev_rs = static_library(
diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index ffdc8af53f..a33f32906e 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -12,6 +12,7 @@ _libpl011_bindings_inc_rs = rust.bindgen(
   include_directories: bindings_incdir,
   bindgen_version: ['>=0.60.0'],
   args: bindgen_args_common,
+  c_args: bindgen_c_args,
 )
 
 _libpl011_rs = static_library(
diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
index 81d8c77f9a..e1ae95ed61 100644
--- a/rust/hw/core/meson.build
+++ b/rust/hw/core/meson.build
@@ -41,6 +41,7 @@ _hwcore_bindings_inc_rs = rust.bindgen(
   include_directories: bindings_incdir,
   bindgen_version: ['>=0.60.0'],
   args: bindgen_args_common + _hwcore_bindgen_args,
+  c_args: bindgen_c_args,
 )
 
 _hwcore_rs = static_library(
diff --git a/rust/migration/meson.build b/rust/migration/meson.build
index 5e820d43f5..4f8e4ec9d3 100644
--- a/rust/migration/meson.build
+++ b/rust/migration/meson.build
@@ -22,7 +22,8 @@ _migration_bindings_inc_rs = rust.bindgen(
   include_directories: bindings_incdir,
   bindgen_version: ['>=0.60.0'],
   args: bindgen_args_common + _migration_bindgen_args,
-  )
+  c_args: bindgen_c_args,
+)
 
 _migration_rs = static_library(
   'migration',
diff --git a/rust/qom/meson.build b/rust/qom/meson.build
index 40c51b71b2..9df09f62b4 100644
--- a/rust/qom/meson.build
+++ b/rust/qom/meson.build
@@ -12,6 +12,7 @@ _qom_bindings_inc_rs = rust.bindgen(
   include_directories: bindings_incdir,
   bindgen_version: ['>=0.60.0'],
   args: bindgen_args_common,
+  c_args: bindgen_c_args,
 )
 
 _qom_rs = static_library(
diff --git a/rust/system/meson.build b/rust/system/meson.build
index 3ec140de01..0859f39745 100644
--- a/rust/system/meson.build
+++ b/rust/system/meson.build
@@ -20,6 +20,7 @@ _system_bindings_inc_rs = rust.bindgen(
   include_directories: bindings_incdir,
   bindgen_version: ['>=0.60.0'],
   args: bindgen_args_common + _system_bindgen_args,
+  c_args: bindgen_c_args,
 )
 
 _system_rs = static_library(
diff --git a/rust/util/meson.build b/rust/util/meson.build
index 87a893673d..9dcde4fae0 100644
--- a/rust/util/meson.build
+++ b/rust/util/meson.build
@@ -22,6 +22,7 @@ _util_bindings_inc_rs = rust.bindgen(
   include_directories: bindings_incdir,
   bindgen_version: ['>=0.60.0'],
   args: bindgen_args_common + _util_bindgen_args,
+  c_args: bindgen_c_args,
 )
 
 _util_rs = static_library(
-- 
2.51.0


