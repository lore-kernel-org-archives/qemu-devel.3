Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED35CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 13:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzbIN-0000C2-Nu; Fri, 19 Sep 2025 09:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbGv-0006fU-Dz
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:35:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uzbGr-0003wU-1Y
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 09:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758288922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pLz9cqrFmTGKo0Hi+Gri1zdzl7wLm4Cno7na1LpeFvs=;
 b=FvGlxyVvkxIMnWnAcMHXNJIiD/+LKh8ia+IHCVHexOcw7leW3M9AalZKPXlAYalUqazp5n
 X56lX6iP9w+Y845KuWqA0kTORW40/3KNmxNtNtrIRV83IuI0nt7Qn+lu+3e58hwaJJYXFj
 L2QS/iDSgWp2IuMEVHyIEwzqreWpC0c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395--6PjukB-OYyNF0ZfN9QHDA-1; Fri,
 19 Sep 2025 09:35:19 -0400
X-MC-Unique: -6PjukB-OYyNF0ZfN9QHDA-1
X-Mimecast-MFC-AGG-ID: -6PjukB-OYyNF0ZfN9QHDA_1758288917
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21E5A1955F2F; Fri, 19 Sep 2025 13:35:17 +0000 (UTC)
Received: from localhost (unknown [10.45.242.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C3091800452; Fri, 19 Sep 2025 13:35:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Ed Maste <emaste@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: [PATCH 18/24] tests/lcitool: enable rust & refresh
Date: Fri, 19 Sep 2025 17:33:12 +0400
Message-ID: <20250919133320.240145-19-marcandre.lureau@redhat.com>
In-Reply-To: <20250919133320.240145-1-marcandre.lureau@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
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

Enable Rust on various distro images: alpine, centos, debian, fedora,
opensuse.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker             |  2 ++
 tests/docker/dockerfiles/centos9.docker            |  2 ++
 tests/docker/dockerfiles/debian-amd64-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-arm64-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-armhf-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-i686-cross.docker  |  2 ++
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  2 ++
 .../docker/dockerfiles/debian-riscv64-cross.docker |  2 ++
 tests/docker/dockerfiles/debian-s390x-cross.docker |  2 ++
 tests/docker/dockerfiles/debian.docker             |  2 ++
 .../docker/dockerfiles/fedora-rust-nightly.docker  |  2 ++
 tests/docker/dockerfiles/fedora.docker             |  2 ++
 tests/docker/dockerfiles/opensuse-leap.docker      |  2 ++
 tests/lcitool/refresh                              | 14 +++++++++++---
 14 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index b50fbc3dba..5a70647acb 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -138,3 +138,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index e7fc688ee9..03abbe07ae 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -142,3 +142,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 08621879dd..b4da02bd79 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -188,3 +188,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 725cccbee1..20585a09d4 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -187,3 +187,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 50f7e0e986..4eaec2fada 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -184,3 +184,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index f53b77cb62..d4a6d3b5dc 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -184,3 +184,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 09de265c26..29dfc0d54d 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -186,3 +186,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 79ec37616d..91dddb246f 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -89,3 +89,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index d7b2ca99ce..7a8992796e 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -185,3 +185,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 2696cf2167..c5b8a43fea 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -175,3 +175,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 167246f0f5..7f720f66f7 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -185,3 +185,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 56a1ad8a18..608d09728e 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -162,3 +162,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index d71dbc30c7..2b6d7efd94 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -148,3 +148,5 @@ ARG USER
 ARG UID
 RUN if [ "${USER}" ]; then \
   id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST 1
\ No newline at end of file
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 649568c5c2..c585baa89c 100755
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
+        trailer += "\nENV ENABLE_RUST 1"
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
@@ -237,7 +242,10 @@ try:
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


