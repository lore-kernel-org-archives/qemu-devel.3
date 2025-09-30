Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8459BCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 15:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3cTc-0002B3-In; Tue, 30 Sep 2025 11:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cSN-0000rW-7y
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v3cS8-0004ew-G8
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 11:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759246783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWeJNnTcKJt8+bbcTR5TOqXCZkjS97cTS+EkmonSu64=;
 b=Uq9sPxW00ROdGvS7KVanM+2javwCxX0RXvktIT5R7SQedGfnUOWMFosZM4xoFHfx0VHTy3
 +2H/49XU9Mplj3CzTpM+dXuz2ZtvzLdZWDiEl1EPwwQfnBmEv2XbuVkJ961NTYQyKcIOyU
 CMyi8aBv1A22W99ewF226fUBc3IS1CM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-m-dXnmNaNIWvj_5FBmMljw-1; Tue,
 30 Sep 2025 11:39:39 -0400
X-MC-Unique: m-dXnmNaNIWvj_5FBmMljw-1
X-Mimecast-MFC-AGG-ID: m-dXnmNaNIWvj_5FBmMljw_1759246778
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 250FD195609F; Tue, 30 Sep 2025 15:39:38 +0000 (UTC)
Received: from localhost (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C27F9195608E; Tue, 30 Sep 2025 15:39:36 +0000 (UTC)
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
Subject: [PULL 18/23] tests/lcitool: enable rust & refresh
Date: Tue, 30 Sep 2025 19:37:39 +0400
Message-ID: <20250930153746.573875-19-marcandre.lureau@redhat.com>
In-Reply-To: <20250930153746.573875-1-marcandre.lureau@redhat.com>
References: <20250930153746.573875-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Enable Rust on various distro images: alpine, centos, debian, fedora,
opensuse.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250924120426.2158655-19-marcandre.lureau@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker             |  2 ++
 tests/docker/dockerfiles/centos9.docker            |  2 ++
 tests/docker/dockerfiles/debian-amd64-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-arm64-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-armhf-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-i686-cross.docker  |  2 ++
 .../dockerfiles/debian-mips64el-cross.docker       |  2 ++
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  2 ++
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  2 ++
 .../docker/dockerfiles/debian-riscv64-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-s390x-cross.docker |  2 ++
 tests/docker/dockerfiles/debian.docker             |  2 ++
 .../docker/dockerfiles/fedora-rust-nightly.docker  |  2 ++
 tests/docker/dockerfiles/fedora.docker             |  2 ++
 tests/docker/dockerfiles/opensuse-leap.docker      |  2 ++
 tests/lcitool/refresh                              | 14 +++++++++++---
 16 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index b50fbc3dba..52adf9ccbb 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -138,3 +138,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index e7fc688ee9..0674d77826 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -142,3 +142,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 08621879dd..7f4674400d 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -188,3 +188,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 725cccbee1..c7cd54ee5c 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -187,3 +187,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 50f7e0e986..627d41c6de 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -184,3 +184,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index f53b77cb62..4e8b3a8293 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -184,3 +184,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index cca04a4594..6e88777f76 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -183,3 +183,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 59c6f92248..5f4e3fa963 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -183,3 +183,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 09de265c26..dfa690616d 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -186,3 +186,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index e6c463eff7..09b2953f32 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -189,3 +189,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index d7b2ca99ce..09a78c15ba 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -185,3 +185,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 2696cf2167..8dd893be4b 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -175,3 +175,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 167246f0f5..7d31c9f406 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -185,3 +185,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 56a1ad8a18..891a740fcb 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -162,3 +162,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index d71dbc30c7..75e1747780 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -148,3 +148,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 5c62cdde4a..645959318a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -63,7 +63,8 @@ add_user_mapping = [
     "  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi\n"
 ]
 
-def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None):
+def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None,
+                        enable_rust=True):
     filename = Path(src_dir, "tests", "docker", "dockerfiles", host + ".docker")
     cmd = lcitool_cmd + ["dockerfile"]
     if cross is not None:
@@ -75,6 +76,8 @@ def generate_dockerfile(host, target, project="qemu", cross=None, trailer=None):
     else:
         trailer = "\n".join(add_user_mapping)
 
+    if enable_rust:
+        trailer += "\nENV ENABLE_RUST 1\n"
     generate(filename, cmd, trailer)
 
 
@@ -180,7 +183,9 @@ try:
     generate_dockerfile("fedora", "fedora-41")
     generate_dockerfile("opensuse-leap", "opensuse-leap-15")
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
-                        trailer="".join(ubuntu2204_rust_extras))
+                        trailer="".join(ubuntu2204_rust_extras),
+                        # https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318
+                        enable_rust=False)
 
     #
     # Non-fatal Rust-enabled build
@@ -248,7 +253,10 @@ try:
                         project='qemu,qemu-win-installer',
                         cross="mingw64",
                         trailer=cross_build("x86_64-w64-mingw32-",
-                                            "x86_64-softmmu"))
+                                            "x86_64-softmmu"),
+                        # linking with rust is buggy:
+                        # https://github.com/mesonbuild/meson/pull/14991
+                        enable_rust=False)
 
     #
     # Cirrus packages lists for GitLab
-- 
2.51.0


