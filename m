Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3815BF53D85
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:30:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CiA-000629-QQ; Mon, 16 Mar 2026 14:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2Chx-00060Q-1t
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2Chs-0000L9-Lf
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A4cs/WoPLQnWNlEl5/zoGSatlx4DSq8YhCv3P3hjqdg=;
 b=Bl9pILPZ9cN16b3vJqefm44YR8txhGuU4VXPmckiFNPVKuOFpkDOnN/DiKD55TuleTrJKJ
 +qHHkD81DB5w2B5qQtC1Jq2EABCfJeh2KUhx7DYJIpHl0i3iJFhk1BPVIb0IIlgYWNseg8
 +mFiqeVIfHEyZWoM2HICFCTo6UeV5no=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-349-2OLTVDCrPGmwIaDCB-yNOA-1; Mon,
 16 Mar 2026 14:30:21 -0400
X-MC-Unique: 2OLTVDCrPGmwIaDCB-yNOA-1
X-Mimecast-MFC-AGG-ID: 2OLTVDCrPGmwIaDCB-yNOA_1773685820
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A32F3195606A; Mon, 16 Mar 2026 18:30:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.101])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12CAE1800760; Mon, 16 Mar 2026 18:30:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests: Replace ncat with socat in migration test and drop
 ncat from containers
Date: Mon, 16 Mar 2026 19:30:16 +0100
Message-ID: <20260316183016.239526-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Thomas Huth <thuth@redhat.com>

nmap / ncat has a somewhat problematic license (e.g. saying claiming
that derived work is also considered for software that "is designed
specifically to execute Covered Software and parse the results", e.g.
by executing ncat from your own program, you might already fall into
this category) - so for example in openSUSE 16, you can only find it
in the "non-OSS" repository.

We are currently only using it in the migration functional test, and
that likely does not fall into this "derived work" category yet (since
it is also doing some other stuff), but still, to be safe, we should
move away from using it now.

Unfortunately, switching to one of the other flavors of netcat is
also not a real option (see commit f700abbbeb6ab68a3446d1fb168a934d),
but socat should be a solid replacement here instead.

To avoid that someone else easily uses ncat again, let's also remove
it from our container files now.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/ci/setup/debian/debian-13-ppc64le.yaml        | 1 -
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml      | 1 -
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml        | 1 -
 tests/docker/dockerfiles/alpine.docker                | 1 -
 tests/docker/dockerfiles/centos9.docker               | 1 -
 tests/docker/dockerfiles/debian-amd64-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-arm64-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-armhf-cross.docker    | 1 -
 tests/docker/dockerfiles/debian-i686-cross.docker     | 1 -
 tests/docker/dockerfiles/debian-mips64el-cross.docker | 1 -
 tests/docker/dockerfiles/debian-mipsel-cross.docker   | 1 -
 tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 1 -
 tests/docker/dockerfiles/debian-riscv64-cross.docker  | 1 -
 tests/docker/dockerfiles/debian-s390x-cross.docker    | 1 -
 tests/docker/dockerfiles/debian.docker                | 1 -
 tests/docker/dockerfiles/fedora-rust-nightly.docker   | 1 -
 tests/docker/dockerfiles/fedora-win64-cross.docker    | 1 -
 tests/docker/dockerfiles/fedora.docker                | 1 -
 tests/docker/dockerfiles/opensuse-leap.docker         | 1 -
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 -
 tests/functional/migration.py                         | 4 ++--
 tests/lcitool/projects/qemu.yml                       | 1 -
 22 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/scripts/ci/setup/debian/debian-13-ppc64le.yaml b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
index 25d96cea460..b16d6d58f8e 100644
--- a/scripts/ci/setup/debian/debian-13-ppc64le.yaml
+++ b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
@@ -101,7 +101,6 @@ packages:
   - make
   - mtools
   - multipath-tools
-  - ncat
   - nettle-dev
   - ninja-build
   - openssh-client
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index 6a72eabca9e..b58fcda0fa3 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -102,7 +102,6 @@ packages:
   - make
   - mtools
   - multipath-tools
-  - ncat
   - nettle-dev
   - ninja-build
   - openssh-client
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 6001da12504..fa439db4ca1 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -100,7 +100,6 @@ packages:
   - make
   - mtools
   - multipath-tools
-  - ncat
   - nettle-dev
   - ninja-build
   - openssh-client
diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index c0303feb48a..a7ee85fcda7 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -76,7 +76,6 @@ RUN apk update && \
         ndctl-dev \
         net-tools \
         nettle-dev \
-        nmap-ncat \
         numactl-dev \
         openssh-client \
         pcre2-dev \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 6b1aa6dc0de..41a1225856e 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -87,7 +87,6 @@ RUN dnf --quiet distro-sync -y && \
                 ncurses-devel \
                 nettle-devel \
                 ninja-build \
-                nmap-ncat \
                 numactl-devel \
                 openssh-clients \
                 pam-devel \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index c386b658b04..6fad808e1b6 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 9d83ab7a32e..889d8a1a755 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index c2077ec7a2c..988c87075f6 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index db9f04ee93d..d720ebb0bca 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian-mips64el-cross.docker b/tests/docker/dockerfiles/debian-mips64el-cross.docker
index 7758afd80aa..90a2ef15574 100644
--- a/tests/docker/dockerfiles/debian-mips64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-mips64el-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian-mipsel-cross.docker b/tests/docker/dockerfiles/debian-mipsel-cross.docker
index cba7f43870f..b7e36b3d974 100644
--- a/tests/docker/dockerfiles/debian-mipsel-cross.docker
+++ b/tests/docker/dockerfiles/debian-mipsel-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 24f946d1441..a70fbee0c1d 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index f476cf65eaa..9ada5ecce0d 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index a60b4ab01d1..a1de94ff9aa 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -37,7 +37,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       locales \
                       make \
                       mtools \
-                      ncat \
                       ninja-build \
                       openssh-client \
                       pkgconf \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 6c6ab0256ea..c34923b253d 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -109,7 +109,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       make \
                       mtools \
                       multipath-tools \
-                      ncat \
                       nettle-dev \
                       ninja-build \
                       openssh-client \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 043b42a0a9b..0c5739140d7 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -96,7 +96,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        ncurses-devel \
                        nettle-devel \
                        ninja-build \
-                       nmap-ncat \
                        numactl-devel \
                        openssh-clients \
                        pam-devel \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index 818485c4ba2..751789e849b 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -42,7 +42,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        make \
                        mtools \
                        ninja-build \
-                       nmap-ncat \
                        openssh-clients \
                        python3 \
                        python3-PyYAML \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index 32aaf01aff4..ec787aa7027 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -96,7 +96,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        ncurses-devel \
                        nettle-devel \
                        ninja-build \
-                       nmap-ncat \
                        numactl-devel \
                        openssh-clients \
                        pam-devel \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index d693f2c6f85..52ef1176b5a 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -86,7 +86,6 @@ RUN zypper update -y && \
            lzo-devel \
            make \
            mtools \
-           ncat \
            ncurses-devel \
            ninja \
            openssh \
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 23b33d6ad44..d5e5e372a40 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -107,7 +107,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       make \
                       mtools \
                       multipath-tools \
-                      ncat \
                       nettle-dev \
                       ninja-build \
                       openssh-client \
diff --git a/tests/functional/migration.py b/tests/functional/migration.py
index e995328e833..2395119d6c6 100644
--- a/tests/functional/migration.py
+++ b/tests/functional/migration.py
@@ -84,6 +84,6 @@ def migration_with_exec(self):
             self.skipTest('ncat is not available')
         with Ports() as ports:
             free_port = self._get_free_port(ports)
-            dst_uri = 'exec:ncat -l localhost %u' % free_port
-            src_uri = 'exec:ncat localhost %u' % free_port
+            dst_uri = 'exec:socat TCP-LISTEN:%u -' % free_port
+            src_uri = 'exec:socat - TCP:localhost:%u' % free_port
             self.migrate(dst_uri, src_uri)
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 5e34e953514..bee7a620ca9 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -83,7 +83,6 @@ packages:
  - meson
  - mtools
  - ncursesw
- - netcat
  - nettle
  - ninja
  - nsis
-- 
2.53.0


