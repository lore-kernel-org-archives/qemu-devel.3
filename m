Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF49C369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76Gf-0001IC-2e; Tue, 22 Apr 2025 01:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76DK-0003O1-1i; Tue, 22 Apr 2025 01:30:35 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76DH-0008D4-Qq; Tue, 22 Apr 2025 01:30:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2264aefc45dso76093815ad.0; 
 Mon, 21 Apr 2025 22:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299829; x=1745904629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EyswPERNVPUmMfuIfE21udR+zks7HJrFsl2VmGBeB2w=;
 b=mqIYYFO1nEMVbMPYxFLnPYMeMTiGMiy7HLjGj4vv4YnOuYUUfEIhhZ6tlHEmbcukca
 zW0vNlPfX1d2ZktAYY78W9z7ZvKEKpkkp17aUkhDoH3SQw53G4PKq9Hvm8kFU3UGczcP
 /l+97Yjkq3uUZJ+IvqDQiiV0LHe4l6TnmXLoX8aMnhD+l+29uNiu0RVRmFc+TQPONwf3
 P8wAvSvJs033m+75J31VT4HFdZANOzR/XkEvWi8lEe3+qYKObgU/jUcbS7JDg2U+/GM1
 uvMiTeLZZh4lbeBUMMiwmnm3iS878RJ6DFjC8Ky8SPHe3RwL4oclPbI0ES8ag87yL6i9
 t5cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299829; x=1745904629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EyswPERNVPUmMfuIfE21udR+zks7HJrFsl2VmGBeB2w=;
 b=Zi/vTXrUW0jw8VDQarXPe0BDiWPQBZih3jHTZNgzxsUBBPTMQ4gtZXlh3CPnf1eC2m
 0Hgz/fw8tqRHZLJOkRqWhiJkDD6VLfAAKLdZVX6gxBH0rzN1cn87VADahqstybGw+kAs
 kZVau60qZutr79OXJ0utJszkDLz6thRxE6E3MF1BDC32q/3C5/cda94UQmrgR2o7vlPt
 10j572Ako8mDoqG35IhRjYTJJMYqFFT3oHUkfWi+BbgZpCXlD5rFokqLhfaSVsMPJLlC
 d064YyFeErZvM7zY4iwSvnxs5wicxFlcNAP/ka+6SJOIoQf4o3i7GSDKms9dnXfr1Snb
 2jag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDKgDAooc4yp4sZNj9soREzXbQPc+7j50cddob42E7+FH9Qm7bRa2fqIrE8sIgxGs85zHs7I1em4j3tw==@nongnu.org,
 AJvYcCVeFK9HtStEqkDMItB6dqROQQaIGGKj6rQKzXIpMPFFdjr07lrLYEE+7+HsnimiLTB635dJRpbaf9qYAA==@nongnu.org,
 AJvYcCWL/aigH2FHpjGhexBRBQ8Z+zD/cpnnh1aJw3NgJn+ANJm3L/Bq1V53ZZmVkZczxcCOxu8WivebCA==@nongnu.org,
 AJvYcCXs2bVI8sDsWJfZqYZmYMeH9RDTcb9FZZXRotk827kTdPm2O7w8yZEU4IgVSCxlCgnCOdPpBoG0N4c=@nongnu.org
X-Gm-Message-State: AOJu0YxZOpgTDJ4hu+mO0RDt+EyffBZpbCibqf/l9r57rjCcoKAHTOOE
 ewvkTGrIPzEbS8xJZmh/WyfQliX+FQnJpPibjJty3xAlDASDpm0YWvu9VtmF
X-Gm-Gg: ASbGnct9/Dwzxc/1fsHNreXfDqTNZbm0MOxyr1YV5UXHUl008fqLwfHDOn6kPqOUMTg
 Kb5I2dKXox11VavjUZmshjZy+sr0Vs3zbwfY3G35BLLOF0QLzmu3UZfMYrYZoH+SAGNeWf7UR/m
 AWW2/T1Qvp6os5BmAorKmz938tMBsmk+GgbgZmeIjGhJhws9WyOG0J7lN++LXDA0S20b5g5ZVhi
 w4yyz7flMEdbS8SwMp7eL3+Qf6OPctxgIr2JI7L/C368jF67WPCJrv+lmNtDqfrMN2BeAORirtM
 Ao3QDScTRE53KRJfOmWF64vQ25oG5Tib2/9S+OfwreZIgOY3A/5ROTJajlg=
X-Google-Smtp-Source: AGHT+IF866eeRMlWTJ5okWrqXs+r8BGchJhPURBo/iH1ZtCGUA/9C/H97nfcbV0T9/pDqgYGWsEh/w==
X-Received: by 2002:a17:902:f54c:b0:224:1074:63a2 with SMTP id
 d9443c01a7336-22c5361c436mr224374235ad.43.1745299829232; 
 Mon, 21 Apr 2025 22:30:29 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:30:28 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 19/20] tests: Add Dockerfile containing dependencies for
 Emscripten build
Date: Tue, 22 Apr 2025 14:27:23 +0900
Message-Id: <2c76c1bdc27786d54a267b52a861debb64f067f8.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The added Dockerfile is based on the emsdk image, which includes the
Emscripten toolchain. It also cross-compiles the necessary dependencies
(glib, libffi, pixman, and zlib) for the Emscripten target environment.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 MAINTAINERS                                   |   1 +
 .../dockerfiles/emsdk-wasm32-cross.docker     | 145 ++++++++++++++++++
 2 files changed, 146 insertions(+)
 create mode 100644 tests/docker/dockerfiles/emsdk-wasm32-cross.docker

V2:
- Split the Dockerfile addition from the previous 18th patch into a separate
  commit.
- Split the MAINTAINERS file change that adds emsdk-wasm32-cross.docker from
  the previous 19th patch into this commit.

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fb7fd79b6..58e4bdedba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -626,6 +626,7 @@ F: include/system/os-wasm.h
 F: os-wasm.c
 F: util/coroutine-wasm.c
 F: configs/meson/emscripten.txt
+F: tests/docker/dockerfiles/emsdk-wasm32-cross.docker
 
 Alpha Machines
 --------------
diff --git a/tests/docker/dockerfiles/emsdk-wasm32-cross.docker b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
new file mode 100644
index 0000000000..60a7d02f56
--- /dev/null
+++ b/tests/docker/dockerfiles/emsdk-wasm32-cross.docker
@@ -0,0 +1,145 @@
+# syntax = docker/dockerfile:1.5
+
+ARG EMSDK_VERSION_QEMU=3.1.50
+ARG ZLIB_VERSION=1.3.1
+ARG GLIB_MINOR_VERSION=2.84
+ARG GLIB_VERSION=${GLIB_MINOR_VERSION}.0
+ARG PIXMAN_VERSION=0.44.2
+ARG FFI_VERSION=v3.4.7
+ARG MESON_VERSION=1.5.0
+
+FROM emscripten/emsdk:$EMSDK_VERSION_QEMU AS build-base
+ARG MESON_VERSION
+ENV TARGET=/builddeps/target
+ENV CPATH="$TARGET/include"
+ENV PKG_CONFIG_PATH="$TARGET/lib/pkgconfig"
+ENV EM_PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
+ENV CFLAGS="-O3 -pthread -DWASM_BIGINT"
+ENV CXXFLAGS="$CFLAGS"
+ENV LDFLAGS="-sWASM_BIGINT -sASYNCIFY=1 -L$TARGET/lib"
+RUN apt-get update && apt-get install -y \
+    autoconf \
+    build-essential \
+    libglib2.0-dev \
+    libtool \
+    pkgconf \
+    ninja-build \
+    python3-pip
+RUN pip3 install meson==${MESON_VERSION} tomli
+RUN mkdir /build
+WORKDIR /build
+RUN mkdir -p $TARGET
+RUN <<EOF
+cat <<EOT > /cross.meson
+[host_machine]
+system = 'emscripten'
+cpu_family = 'wasm32'
+cpu = 'wasm32'
+endian = 'little'
+
+[binaries]
+c = 'emcc'
+cpp = 'em++'
+ar = 'emar'
+ranlib = 'emranlib'
+pkgconfig = ['pkg-config', '--static']
+EOT
+EOF
+
+FROM build-base AS zlib-dev
+ARG ZLIB_VERSION
+RUN mkdir -p /zlib
+RUN curl -Ls https://zlib.net/zlib-$ZLIB_VERSION.tar.xz | \
+    tar xJC /zlib --strip-components=1
+WORKDIR /zlib
+RUN emconfigure ./configure --prefix=$TARGET --static
+RUN emmake make install -j$(nproc)
+
+FROM build-base AS libffi-dev
+ARG FFI_VERSION
+RUN mkdir -p /libffi
+RUN git clone https://github.com/libffi/libffi /libffi
+WORKDIR /libffi
+RUN git checkout $FFI_VERSION
+RUN autoreconf -fiv
+RUN emconfigure ./configure --host=wasm32-unknown-linux \
+    --prefix=$TARGET --enable-static \
+    --disable-shared --disable-dependency-tracking \
+    --disable-builddir --disable-multi-os-directory \
+    --disable-raw-api --disable-docs
+RUN emmake make install SUBDIRS='include' -j$(nproc)
+
+FROM build-base AS pixman-dev
+ARG PIXMAN_VERSION
+RUN mkdir /pixman/
+RUN git clone  https://gitlab.freedesktop.org/pixman/pixman /pixman/
+WORKDIR /pixman
+RUN git checkout pixman-$PIXMAN_VERSION
+RUN <<EOF
+cat <<EOT >> /cross.meson
+[built-in options]
+c_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+cpp_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+objc_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+c_link_args = [$(printf "'%s', " $LDFLAGS | sed 's/, $//')]
+cpp_link_args = [$(printf "'%s', " $LDFLAGS | sed 's/, $//')]
+EOT
+EOF
+RUN meson setup _build --prefix=$TARGET --cross-file=/cross.meson \
+    --default-library=static \
+    --buildtype=release -Dtests=disabled -Ddemos=disabled
+RUN meson install -C _build
+
+FROM build-base AS glib-dev
+ARG GLIB_VERSION
+ARG GLIB_MINOR_VERSION
+RUN mkdir -p /stub
+WORKDIR /stub
+RUN <<EOF
+cat <<'EOT' > res_query.c
+#include <netdb.h>
+int res_query(const char *name, int class,
+              int type, unsigned char *dest, int len)
+{
+    h_errno = HOST_NOT_FOUND;
+    return -1;
+}
+EOT
+EOF
+RUN emcc ${CFLAGS} -c res_query.c -fPIC -o libresolv.o
+RUN ar rcs libresolv.a libresolv.o
+RUN mkdir -p $TARGET/lib/
+RUN cp libresolv.a $TARGET/lib/
+
+RUN mkdir -p /glib
+RUN curl -Lks https://download.gnome.org/sources/glib/${GLIB_MINOR_VERSION}/glib-$GLIB_VERSION.tar.xz | \
+    tar xJC /glib --strip-components=1
+
+COPY --link --from=zlib-dev /builddeps/ /builddeps/
+COPY --link --from=libffi-dev /builddeps/ /builddeps/
+
+WORKDIR /glib
+RUN <<EOF
+CFLAGS="$CFLAGS -Wno-incompatible-function-pointer-types" ;
+cat <<EOT >> /cross.meson
+[built-in options]
+c_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+cpp_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+objc_args = [$(printf "'%s', " $CFLAGS | sed 's/, $//')]
+c_link_args = [$(printf "'%s', " $LDFLAGS | sed 's/, $//')]
+cpp_link_args = [$(printf "'%s', " $LDFLAGS | sed 's/, $//')]
+EOT
+EOF
+RUN meson setup _build --prefix=$TARGET --cross-file=/cross.meson \
+    --default-library=static --buildtype=release --force-fallback-for=pcre2 \
+    -Dselinux=disabled -Dxattr=false -Dlibmount=disabled -Dnls=disabled \
+    -Dtests=false -Dglib_debug=disabled -Dglib_assert=false -Dglib_checks=false
+# FIXME: emscripten doesn't provide some pthread functions in the final link,
+#        which isn't detected during meson setup.
+RUN sed -i -E "/#define HAVE_POSIX_SPAWN 1/d" ./_build/config.h
+RUN sed -i -E "/#define HAVE_PTHREAD_GETNAME_NP 1/d" ./_build/config.h
+RUN meson install -C _build
+
+FROM build-base
+COPY --link --from=glib-dev /builddeps/ /builddeps/
+COPY --link --from=pixman-dev /builddeps/ /builddeps/
-- 
2.25.1


