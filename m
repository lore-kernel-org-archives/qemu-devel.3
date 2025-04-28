Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED9BC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IES-0001Lo-3T; Mon, 28 Apr 2025 02:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IC0-00058j-Ti; Mon, 28 Apr 2025 02:42:20 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBx-0007JF-3r; Mon, 28 Apr 2025 02:42:15 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-224341bbc1dso46081005ad.3; 
 Sun, 27 Apr 2025 23:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822530; x=1746427330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HPP2G+ypt7YrX8hzAUA27wm3oJ/maSzQ00zwDCJ8YQQ=;
 b=VKgINTe1KdV9KqolyL77owYRUH8Zip8T2lL0E3rTJ+Lg8fOzFTuPoGU+i0w2aMiukM
 rYy5RsQlf9bPqQ5+BjlR8N3nCc6n8A95WXXQ0UN+TMtVZ17yvwf0A3YQP1Ql02OLlKRW
 hPdxtb4wIysfZlPasDGFNm4jqp0X5Z+O6TmPcg9lTl7CRFGtNaIta9Q23H3ytrhR6BcN
 Tx46pZCZItNbrZ3exOByV6XAzXHrCq05jd8S7RedbirEKVfnvKUCp6GtLeVQhYMG2rAC
 8ChaOxpPNm+aoXEMv+B1+/agKKYtVPQzuS9VMsnPrno6l5ecLLWKl7f3Wz0CbKK5XqZK
 yorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822530; x=1746427330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HPP2G+ypt7YrX8hzAUA27wm3oJ/maSzQ00zwDCJ8YQQ=;
 b=sNuDZCwdLgMAuanCBEd+3sG05S5qCsDEX5+MfCB27l0fbCV//lMWM6m+ncfiMWQlRq
 Ly17Yvf04kQYSQR9h+47eHjOWr2lGZePlhsCKSepU1VpHQa7gZpJADBRHDYnBduBYi5l
 duXLS7TLXmTI7FSWD1UaOybjQhNGos18nXs0xZB+4++/rP5Uzql4bgvwUlgtPVPcaCie
 3tAcV9Iyq3x16TKBrNmqK8nrG1S7qIH0PSCGcMe/xWTIwCS1QMEY7TKoEIyQTUGFYW6a
 o9Uh2p7dVXKEcaXgayDpqmYZh1EodJGlNDFCT89XHOo9hNbDFRjHhXF2KgIS1l2Eo4zJ
 5Czg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKdc3SXmp48MzN/xFCHMWtTPHZ1hnfTLycN0jBemrvxJTnMYRrf+mmjTQaiRfERm3Oo8vgu17gMCSz+g==@nongnu.org,
 AJvYcCVutPn6fhAB/ArTFNnBMJ0mOUJwQflyCwEbejfDmjs90bmCXijLfBJ+AK57kZCCgkWJnAdTL5BTvA==@nongnu.org,
 AJvYcCX6wfgY9kYQzgKaRUqXqCelxVMW4YIQli9OzYBnK6xHoZ6xtpXbUhkV9JqqWM4VXlERmLYBEnPlplc=@nongnu.org,
 AJvYcCXJJa9uuvilw7n52kwX72eUHgtYM9Y+gahDg2NMLU7jpI/wbqkPKJKOy0wx0KnTVXbOgRBCR++oAJZhCA==@nongnu.org
X-Gm-Message-State: AOJu0Ywa+wLug8S8yuy7ac0y8xPrj/xxsVieUzlUDiccn3xoSE0kwt+6
 TW9vYX/CTtlJgD19GYxGkNDcfOjJ31rRTMWG6cTdWGA+JYGByCIHVUCidmm4
X-Gm-Gg: ASbGncsstSyykePVoYK36d6aut4/NO1nXFANVHF+yw8xfiR+zKR58vlqfEhPfoyuY6N
 Skg+PaUOd1pdKqp46TZiPM3o49sZnGgrtBt+cOpxPBmlcCX0i0gGVsKGDf92VIuI1shwjzyimk0
 z4SKV+rAmyX6tuKTFR82csrO+yYl5g/Ag5Jdd5+NTPhqh1ZubIEWnDe55Kh+017PAPlFFXrt1xu
 8Pvv6TRz+buL4UegiTW9RafJYCMByWTBlOja4X7sJ+Ouhtx9Eoc2VS40KhIXDGfD+4x62CJDMzz
 kft8mO6dPalkdXE6JhHlSX4GaOYXqQ8lOGooEw==
X-Google-Smtp-Source: AGHT+IHRWN3JsCNfDZHbW955JRTfqsVw/h+K8xx0iThNgk+AM0ZZghQ0w1nuOaVl0h4f5oB7XeLWzw==
X-Received: by 2002:a17:903:320b:b0:225:abd2:5e39 with SMTP id
 d9443c01a7336-22dbf5f8179mr156498775ad.30.1745822530085; 
 Sun, 27 Apr 2025 23:42:10 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:42:09 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
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
Subject: [PATCH v3 19/20] tests: Add Dockerfile containing dependencies for
 Emscripten build
Date: Mon, 28 Apr 2025 15:39:08 +0900
Message-ID: <8bed6e9d46ef09328a87320928b5dec575d1e435.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62c.google.com
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

diff --git a/MAINTAINERS b/MAINTAINERS
index dd5a97ac36..2c5417b7e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -635,6 +635,7 @@ F: include/system/os-wasm.h
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
2.43.0


