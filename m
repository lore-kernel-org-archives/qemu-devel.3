Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED276CAC5B0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 12:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1OGs-0001WO-Lg; Wed, 24 Sep 2025 08:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OGV-0001Eo-Io
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1v1OGL-000672-FE
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 08:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758715577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ooQRsOUgbnumjRQG8JC2ZTKZngxQiW5ebaHPN6+i6/0=;
 b=GnEMQVa+AZCowr+FrtMSkfnJhahRRwf8UHZaIJqOQ0E/HeJgScnAdfzbnEkCVoMum7L3/+
 CFnqHSxtO+SvPeebNRaJ9ZtEc+Y0iwvSwsDIdI2/L716oXXfmUZDQ8DoYrAZ8Ootn7h1pb
 SS6Jg26QbhdkU2EhVe/qRJM+vDlFcCk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-58ZJ7oDeOfSjKTuZ3LUqdQ-1; Wed,
 24 Sep 2025 08:06:12 -0400
X-MC-Unique: 58ZJ7oDeOfSjKTuZ3LUqdQ-1
X-Mimecast-MFC-AGG-ID: 58ZJ7oDeOfSjKTuZ3LUqdQ_1758715570
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67F2A1800451; Wed, 24 Sep 2025 12:06:10 +0000 (UTC)
Received: from localhost (unknown [10.44.22.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73EC43000198; Wed, 24 Sep 2025 12:06:07 +0000 (UTC)
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
Subject: [PATCH v2 13/27] lcitool/qemu: include libclang-rt for TSAN
Date: Wed, 24 Sep 2025 16:04:10 +0400
Message-ID: <20250924120426.2158655-14-marcandre.lureau@redhat.com>
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml      | 1 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml        | 1 +
 tests/docker/dockerfiles/centos9.docker               | 1 +
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 +
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 +
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 +
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 +
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 +
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 +
 tests/docker/dockerfiles/debian.docker                | 1 +
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 +
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 +
 tests/docker/dockerfiles/fedora.docker                | 1 +
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 +
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 +
 tests/lcitool/projects/qemu.yml                       | 1 +
 18 files changed, 18 insertions(+)

diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
index bbcb5dd4ac..f446217f2c 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml
@@ -36,6 +36,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
+  - libclang-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
index 00eb1b0f91..25c3368c54 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml
@@ -36,6 +36,7 @@ packages:
   - libcap-ng-dev
   - libcapstone-dev
   - libcbor-dev
+  - libclang-dev
   - libcmocka-dev
   - libcurl4-gnutls-dev
   - libdaxctl-dev
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index a942835a1d..33c62033ce 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -25,6 +25,7 @@ RUN dnf distro-sync -y && \
         capstone-devel \
         ccache \
         clang \
+        compiler-rt \
         ctags \
         cyrus-sasl-devel \
         daxctl-devel \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index bba6de4e2d..d4d3cebfdc 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -30,6 +30,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       gettext \
                       git \
                       hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 8bbcd75157..cd9c9a0def 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -30,6 +30,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       gettext \
                       git \
                       hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 455b84424c..21a5bbc81d 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -30,6 +30,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       gettext \
                       git \
                       hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 8b8993ffe4..c41a4805fe 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -30,6 +30,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       gettext \
                       git \
                       hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index c89cb6c680..77d5d43f4b 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -30,6 +30,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       gettext \
                       git \
                       hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index 4e10d9501f..9e60fe0eb4 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -30,6 +30,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       gettext \
                       git \
                       hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index cf61cb7f4a..dc683bd498 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -30,6 +30,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       gettext \
                       git \
                       hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 1782e0e90f..ef6e961460 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -30,6 +30,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       gettext \
                       git \
                       hostname \
+                      libclang-rt-dev \
                       libglib2.0-dev \
                       llvm \
                       locales \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 62f89e4d8c..ef9ba62f2a 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -43,6 +43,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcap-ng-dev \
                       libcapstone-dev \
                       libcbor-dev \
+                      libclang-rt-dev \
                       libcmocka-dev \
                       libcurl4-gnutls-dev \
                       libdaxctl-dev \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index fd71dd8790..bdbcebda8d 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -32,6 +32,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                capstone-devel \
                ccache \
                clang \
+               compiler-rt \
                ctags \
                cyrus-sasl-devel \
                daxctl-devel \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index ed7d270984..3c54486d2f 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -25,6 +25,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                bzip2 \
                ca-certificates \
                ccache \
+               compiler-rt \
                ctags \
                dbus-daemon \
                diffutils \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index e367c53c09..f758efd2b7 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -32,6 +32,7 @@ exec "$@"\n' > /usr/bin/nosync && \
                capstone-devel \
                ccache \
                clang \
+               compiler-rt \
                ctags \
                cyrus-sasl-devel \
                daxctl-devel \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index 60763857bb..d71dbc30c7 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -19,6 +19,7 @@ RUN zypper update -y && \
            ca-certificates \
            ccache \
            clang \
+           clang-devel \
            ctags \
            cyrus-sasl-devel \
            dbus-1 \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index ea67c7602a..146ad7fce2 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -42,6 +42,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       libcap-ng-dev \
                       libcapstone-dev \
                       libcbor-dev \
+                      libclang-dev \
                       libcmocka-dev \
                       libcurl4-gnutls-dev \
                       libdaxctl-dev \
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index f22fc46fdc..301d0e1ea0 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -44,6 +44,7 @@ packages:
  - libcacard
  - libcap-ng
  - libcbor
+ - libclang-rt
  - libcurl
  - libdrm
  - libepoxy
-- 
2.51.0


