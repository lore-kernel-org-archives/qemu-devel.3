Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2771098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c8I-0007cY-F5; Fri, 20 Mar 2026 11:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c87-0007Yd-04
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:20 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c84-0005Xj-Kq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:18 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-664f8bef4e7so2978890a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021875; x=1774626675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlhWqsULp6KJ73cY3Vo3UNgwju5e7z4CYT++su60MZw=;
 b=u/G8xh9+uQAhT/DFtah4Wk4S9xBwzu3KDNd+XT9fvNt6SLKNzX+hAa0ZqndNrFu+Dt
 iHPtl7hMiacf6ZyovL9owtilcyjEpHBCL5PwMPhDVXMK0IsM+lhLyHtVjsDqraR0tQjY
 HvEr3q1BRC8kfG/RWbocWbh5rDVpk/w7QaUMJylFZeoDAm1AS7nFVppIYmjQkhm3IBMD
 l3EEtXkx167ezchOcOO+vHreMMfZ0bpTFd29b/rkCKnOsI7pnAs4Y0qSHbwKjAj5leDI
 4YLJRwcj8lFx20rhoaWb0Nlpp7OlhdPVMm+6Wm6jY1/CQiEj0ZI9hlzpvQl+/NwkrU60
 jnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021875; x=1774626675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FlhWqsULp6KJ73cY3Vo3UNgwju5e7z4CYT++su60MZw=;
 b=EuwivvpTcKXJeBroBaLvedwPyfPr4MNjnwgQRy78Aa+JZbNV4loP69f+2Wjm3GE2WG
 5K2PtLH4S1pqY5ZNHX3t87yLsKmWm1S1iRoXj0Ga3RmW5Am2OSCdW794eFMoeo0ebtgr
 +mqPL33K7q17TIDTTvzQuRbWgXAUr0aLcamth5a7Un3FEsV2SKa3cdopPwDRvU6OGcNp
 FNd+qLUcEwGrlpGozRXlV2PQXAMqjwMOaeHj60TczT3augLBSwzfzzQrc1KHaVy9XfZr
 EBvweM3D4JRCavd24gNU7LqQI8VpvrLoR0MJM6mtAsJmwc0pP1n9OsC9rWcVOwz5+G84
 c5Vg==
X-Gm-Message-State: AOJu0YxOvZEgIDNvNYPNYcXw6Yq2OO7oQn7UmveNni0Yk2x7NCIdcBJA
 tcBSKf6iZav63KzM3sCbcyiG2pMWdIubpHocWUqAKfVf7M8Klxzqad3oRByy9iWm02I=
X-Gm-Gg: ATEYQzzdzzBxV/Kzel1FF3c1aX+bC5acaOLQ1IyViJ17peeJ/+BaoyGwlsVMI6o4wj0
 OWXn8mwtOpLaqdqTTUvzRZuaYBOyx7hp89y/KyfJq2u/gUc7K+lBxMUBShQvHVfeQxTS5CNWrUv
 FS494GXzAv5475iM5249SimFH0owYW2SH1wXfM/UvuglF7w19JhqtzQG25cl1tfqZkO2OJxF8+E
 mQB9wJnjZIS3Li1LxSoHeOQjh3+1ffFYX7NDG0SKDEY2+FF/iyvLhFqadvB63XprRqPtqH2EP5e
 vBet+vaYCHo0mvUbvO8quiERkPCNKWo6SpDZ8rqf+XLH6ZTq8WwL4O2r5Vksck9F+Ro1ujlfPve
 fyYMgyEZXQJqKomjwubSe0AUvQOu3NQpyCu+JCWJSYdwJM0zcuVaQJGeOWmtLGb9p4m3gVvDjpq
 HWEZQwsXQMpoVJndt+ysdy2Rg=
X-Received: by 2002:a05:6402:35c7:b0:667:447d:cbb1 with SMTP id
 4fb4d7f45d1cf-668c8ffd1bdmr2644115a12.1.1774021874928; 
 Fri, 20 Mar 2026 08:51:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668cd050c4esm1426961a12.0.2026.03.20.08.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A13BE5F946;
 Fri, 20 Mar 2026 15:51:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 8/8] tests: Replace ncat with socat in migration test and
 drop ncat from containers
Date: Fri, 20 Mar 2026 15:51:07 +0000
Message-ID: <20260320155107.2143191-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320155107.2143191-1-alex.bennee@linaro.org>
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260316183016.239526-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
 tests/docker/dockerfiles/ubuntu2204.docker            | 1 -
 tests/functional/migration.py                         | 4 ++--
 tests/lcitool/projects/qemu.yml                       | 1 -
 21 files changed, 2 insertions(+), 22 deletions(-)

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
index 38381ef8f59..8766f952ac8 100644
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
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 44e763f571a..fb5b03e7a1b 100644
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
index b78a1d7f2e0..131d9c4ec81 100644
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
2.47.3


