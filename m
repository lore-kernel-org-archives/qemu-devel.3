Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BB0F4613C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4heb-0005PP-PH; Mon, 23 Mar 2026 11:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he5-0005Et-7s
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w4he2-0007tg-F7
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 11:56:48 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b97c44417ffso308065766b.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 08:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774281405; x=1774886205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1oma/2M52OpMZuRml+itk1LXlVo2CNGKYp1jWRb5jw=;
 b=HcIysI8jiuucHbzkuHubu/M40fZN1Uro4L9mUTJ6j0L8UW8cwqN8SezgxAh+wHwmJh
 MnyXh5JRNk71hxkL+YhJckABcIrAdhhpwSm2EJlH3YNbsQS9JzffN+Tl7lztZp3NpHYP
 xiMLJ68p5+Fb4b58awbzFf6xsYndGHRNjsYfxtvmPY7rwU/PBdYVfiUgg570wCxoTz2+
 FzbLIdwHLsnA9XYXpVH2tKa/Qj7jkjlf5LC77CkItR9HpQPJIQggoB+Gtblk8pxAXrGW
 ogH5HXV/lm2RtixvHtrSDKTod0ZKxWKhd6kDws4HmJiBvDg28x94V/YBB/p3YduV8Bto
 8aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774281405; x=1774886205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W1oma/2M52OpMZuRml+itk1LXlVo2CNGKYp1jWRb5jw=;
 b=kcSQ7CxBMrWYNwvGQ0435MbbO6dOnZOX9SC/1CwF6Et6SKfwXXAWA7GN0sCkjsSz1q
 ZEwKFuOMvpi3kaXxsPD/4ATHDHHjXkX1rwhGAt8Y7nwMgtft/4LwGBZITr2q7S8+QY3/
 AfiGBDbpTjb6/T5eENjQ0Bpo3FMvPO9mtet/aZWHd9F8hazU23WkSYfZNOf1wlBA9kqM
 lcH6kljaFQvo5/iWn9UyTwhneI+PsbMYPz7eCSIDvsb1G0efA8XoR2+vlzjLYpuuZMNF
 uJ/qKLbnHUtcjXiqfgpXMJNGNsY7tQ3hFOu5Juy6xZo1qGt2gvmOWhANz9Go2DoHwQb0
 D6EQ==
X-Gm-Message-State: AOJu0Ywgh3DF2iaDWx7Pv3uFdtYQXOlDzDrjgWKN4jxi2Dc5rgzDFcoQ
 GutCjGVmsFihj9hc8/PyChWQW9sdTj6U6qbDr21w2z40g2GkT1leiD8RPFVRZJF42p8=
X-Gm-Gg: ATEYQzyIMoCm03iPWFuaKVIdQfzEH3OvL5q6sxH+zkS0rYK/hh+MOHba1ZAoyENiph/
 0SkyqTczQ/pQhlhnQW/iOOC2DV5vJQADtUuNJ0Imw/vfxbhELCC3cjaU1n+AU+aZHAqsUzAfjp4
 WIEvWSkqE8GNttEfd/b8MJ2nP1wwCXYeeNgj17x8OywdgExEPP0i2bsdCzZOKFDpdESPFPQWlrC
 PCpRpqgpA+EeJOsYffqMS6GMOU0T5SNetaZ5EToxLwjuuGF41SlwppXBYW7wRL86L8+QIDQfJ0x
 seOMUVuyLIOP5hYwT60orx/e4YD2WYDxDOA/mE+hB5OWx6/GPZFknP2vLZkwf95Hymk5mlaR/7R
 859X0hLjhvUK097IR6pD2y/NIUImXBlqHgAOi79WkxEpe1cLhvfXTzjN4zQSkYXKImIkonDke/M
 KTDyyD4QZlC4nFyAI72pX/cFQ=
X-Received: by 2002:a17:907:9407:b0:b98:6c41:a758 with SMTP id
 a640c23a62f3a-b986c41b5c2mr303922266b.19.1774281404593; 
 Mon, 23 Mar 2026 08:56:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b98335ddfb9sm506680166b.37.2026.03.23.08.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 08:56:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A2F055F8ED;
 Mon, 23 Mar 2026 15:56:38 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 8/8] tests: Replace ncat with socat in migration test and drop
 ncat from containers
Date: Mon, 23 Mar 2026 15:56:37 +0000
Message-ID: <20260323155637.145015-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323155637.145015-1-alex.bennee@linaro.org>
References: <20260323155637.145015-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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
Message-ID: <20260320155107.2143191-9-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


