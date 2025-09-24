Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FD7CAC5B3
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OK7-0006Nc-Pr; Wed, 24 Sep 2025 08:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OI5-0003e1-Ng
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:08:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OHx-0006OF-Tg
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758715675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jmZ3aRezN3Phgrla49j0eZYUUG98iuXItY1pd1Qwtg0=;
 b=DjrteJv0impVO7kjrkb4VI2aYhQm/0emOFISCrbLeHxmlig/DwknVQPWAYpOQ/DHwW8PWN
 W0idjE5/vXNJQGAw79vmRkNeA1EekmbRIBgVwMCPz7cVxw1E8ip9yNJiX/6kw9eWGTyARk
 m/R9LK483aK6CQsoTfkdQFhmUJBti3M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-fynl9IzIMoGE3AgttHNH9w-1; Wed,
 24 Sep 2025 08:07:50 -0400
X-MC-Unique: fynl9IzIMoGE3AgttHNH9w-1
X-Mimecast-MFC-AGG-ID: fynl9IzIMoGE3AgttHNH9w_1758715668
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 039C219560AD; Wed, 24 Sep 2025 12:07:48 +0000 (UTC)
Received: from localhost (unknown [10.44.22.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 675E71800446; Wed, 24 Sep 2025 12:07:45 +0000 (UTC)
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
Subject: [PATCH v2 27/27] WIP: enable rust for wasm/emscripten
Date: Wed, 24 Sep 2025 16:04:24 +0400
Message-ID: <20250924120426.2158655-28-marcandre.lureau@redhat.com>
In-Reply-To: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Note that Debian packaging & testing is currently lacking:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=979665 Furthermore,
emsdk is based on Ubuntu Jammy. So we use rustup for now.

bindgen doesn't use clang & libclang from /emsdk, it probably should but
libclang is missing https://github.com/emscripten-core/emsdk/issues/1605

Finally, there is a linking issue I don't understand and I can't solve yet:
wasm-ld: error: unable to find library -llibqemuutil.a
...

A manual test like this work:
emmake rustc -v --target wasm32-unknown-emscripten -C
linker=/emsdk/upstream/emscripten/emcc --crate-type bin --edition=2021
-C link-arg=-m32 test.rs -Clink-arg=libfoo.a

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure                                     |  4 +++
 .gitlab-ci.d/buildtest-template.yml           |  2 +-
 .gitlab-ci.d/buildtest.yml                    |  2 +-
 .../dockerfiles/emsdk-wasm32-cross.docker     | 27 ++++++++++++++++++-
 tests/docker/test-wasm                        | 12 +++++++++
 5 files changed, 44 insertions(+), 3 deletions(-)
 create mode 100755 tests/docker/test-wasm

diff --git a/configure b/configure
index 78445cbb4b..fdae1b4133 100755
--- a/configure
+++ b/configure
@@ -1228,6 +1228,10 @@ if test "$rust" != disabled && test -z "$rust_target_triple"; then
     rust_machine=apple
     ;;
 
+  emscripten)
+    rust_arch=wasm32
+    ;;
+
   linux)
     # detect android/glibc/musl
     if check_define __ANDROID__; then
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index d866cb12bb..307b927927 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -148,5 +148,5 @@
       fi || exit 1;
     - section_end configure
     - section_start build "Building QEMU"
-    - emmake make -j"$JOBS"
+    - CPATH="$CPATH:/emsdk/upstream/emscripten/cache/sysroot/include/fakesdl:/emsdk/upstream/emscripten/cache/sysroot/include/compat:/emsdk/upstream/lib/clang/18/include:/emsdk/upstream/emscripten/cache/sysroot/include" emmake make -j"$JOBS"
     - section_end build
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 34d8c1a496..dc0a0282b2 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -794,4 +794,4 @@ build-wasm:
     - job: wasm-emsdk-cross-container
   variables:
     IMAGE: emsdk-wasm32-cross
-    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
+    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter --enable-rust
diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
index 6b1642a207..85d0a0fd8d 100644
--- a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
+++ b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
@@ -17,10 +17,11 @@ ENV EM_PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
 ENV CFLAGS="-O3 -pthread -DWASM_BIGINT"
 ENV CXXFLAGS="$CFLAGS"
 ENV LDFLAGS="-sWASM_BIGINT -sASYNCIFY=1 -L$TARGET/lib"
-RUN apt-get update && apt-get install -y \
+RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y \
     autoconf \
     build-essential \
     libglib2.0-dev \
+    libfdt-dev \
     libtool \
     pkgconf \
     ninja-build \
@@ -46,6 +47,30 @@ pkgconfig = ['pkg-config', '--static']
 EOT
 EOF
 
+RUN apt-get update && apt-get install -y wget clang libclang-dev
+ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
+ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
+ENV RUSTDOC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustdoc
+ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo
+RUN set -eux && \
+  rustArch='x86_64-unknown-linux-gnu' && \
+  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \
+  url="https://static.rust-lang.org/rustup/archive/1.27.1/${rustArch}/rustup-init" && \
+  wget "$url" && \
+  echo "${rustupSha256} *rustup-init" | sha256sum -c - && \
+  chmod +x rustup-init && \
+  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \
+  /usr/local/cargo/bin/rustup target add wasm32-unknown-emscripten && \
+  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
+  /usr/local/cargo/bin/rustup --version && \
+  /usr/local/cargo/bin/rustup run nightly cargo --version && \
+  /usr/local/cargo/bin/rustup run nightly rustc --version && \
+  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \
+  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \
+  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
+ENV PATH=$CARGO_HOME/bin:$PATH
+RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
+
 FROM build-base AS zlib-dev
 ARG ZLIB_VERSION
 RUN mkdir -p /zlib
diff --git a/tests/docker/test-wasm b/tests/docker/test-wasm
new file mode 100755
index 0000000000..5f3e4c401c
--- /dev/null
+++ b/tests/docker/test-wasm
@@ -0,0 +1,12 @@
+#!/bin/bash -e
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+. common.rc
+
+cd "$BUILD_DIR"
+
+export CPATH="$CPATH:/emsdk/upstream/emscripten/cache/sysroot/include/fakesdl:/emsdk/upstream/emscripten/cache/sysroot/include/compat:/emsdk/upstream/lib/clang/18/include:/emsdk/upstream/emscripten/cache/sysroot/include"
+
+emconfigure $QEMU_SRC/configure --disable-docs --static --disable-tools --enable-debug --enable-tcg-interpreter --disable-sdl --enable-rust
+emmake make $MAKEFLAGS
-- 
2.51.0


