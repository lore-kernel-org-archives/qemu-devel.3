Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B8DCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cU7-0003fW-U0; Tue, 30 Sep 2025 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cT4-0001xS-56
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cSf-0004yd-H9
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ur2CFh9jHfPfPO1oX0i6A1mMPpaXQriNnJj9tG5ZE2k=;
 b=Cyo2olNBjftg2ZwOwQCKpWNB9JlyqDBJ9BB3CoSrpgNiTNnXiAGnj50Bz+NRrb4imnQBNd
 /noZwKj6am+OtJgLH6AdLY8vBFEt5FhX4Iu+AH1jgNnNzV0/GkRiLM+6KEqfKshjYwc9MY
 mB/FNWfU3KVlZypqnhQs7ahPiOu+6pw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-l03ZvknAO1y6Vsz_ltPfGA-1; Tue,
 30 Sep 2025 11:40:09 -0400
X-MC-Unique: l03ZvknAO1y6Vsz_ltPfGA-1
X-Mimecast-MFC-AGG-ID: l03ZvknAO1y6Vsz_ltPfGA_1759246807
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 234F61800284; Tue, 30 Sep 2025 15:40:07 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE30A19560B4; Tue, 30 Sep 2025 15:40:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 23/23] build-sys: pass -fvisibility=default for wasm bindgen
Date: Tue, 30 Sep 2025 19:37:44 +0400
Message-ID: <20250930153746.573875-24-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Message-ID: <20250924120426.2158655-27-marcandre.lureau@redhat.com>
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
index 762c533a31..55c8202a4d 100644
--- a/meson.build
+++ b/meson.build
@@ -4256,6 +4256,10 @@ if have_rust
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
index 7214d94408..bc51c7f160 100644
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
index 2a49bd1633..ddf5c2f51d 100644
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
index 21e12148da..71fdac696c 100644
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
index 7ca69939ce..094b43355a 100644
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


