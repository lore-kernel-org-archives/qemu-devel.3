Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4935CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwm-0007gZ-76; Tue, 04 Nov 2025 11:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwU-0007eX-VK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwQ-00041j-8i
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5wMIUgZnokbZXnXaaEogUQr5YE0GfAtHUj41UaNzyg=;
 b=VbR2njPf04EI+ItIvSmyHOy5yZGUHZ9BQfjCIMnTcovYeL9PUNW8Bfd0uy5F0iYw7oyPOt
 l2gNFLKl9KCXYZdWAFLTPFJbSXi4ope+UV3xNgjDiCh5VVdSTLD9GZvmifxKp3SzYcoWta
 4eIliW6D7qU1FOHkVfy7iF+uAPOpGSQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-Ge6hI_1bPkCtJg-xH3tIpw-1; Tue, 04 Nov 2025 11:31:25 -0500
X-MC-Unique: Ge6hI_1bPkCtJg-xH3tIpw-1
X-Mimecast-MFC-AGG-ID: Ge6hI_1bPkCtJg-xH3tIpw_1762273884
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b70c6ff2639so323534666b.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273884; x=1762878684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R5wMIUgZnokbZXnXaaEogUQr5YE0GfAtHUj41UaNzyg=;
 b=Hzn+dK4csiYAsMpyy6dPdp2Bx/iGThsIeL3eqNZwXlTu57oEvSkkHAKWOniAb9nnMR
 YLPRj91lvNWO99JWAgBSSIatGnWWQRBXXSjpMi6iF6zp5dkwPCdZHsrYQakeOxdwWAQj
 Xsj7uT9R53X6O1/HEZrRA8YyWZqLmSKjzT4tdgaOEAFH7U3YNqrI8gkacL7tZBVbOG0v
 DjyOT19gljigZ5DpOLFkMTpz4hg2cWx504y8a1J/zmqnRSGmqDdHBxpCVGy1XfJn0HPx
 H26LAt870Vlh7Rkjle0d33GXpEJSTmw+BOGwcL4ZMW00a+rmFxn0wgZhOPrDIIufJL8L
 mKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273884; x=1762878684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R5wMIUgZnokbZXnXaaEogUQr5YE0GfAtHUj41UaNzyg=;
 b=AVPK9AbtAFIqw0zrR5sybUE8lS1cMhLoHK6W5yUYT8j2/3K6rqorK72KnxH17FX02Z
 O99hvK9PQOlEjxW38+cexp3q+H9aBchtqICrNLINbksYRKDI115F57643bvBXr11hdtE
 LL/4TDGY5cLzeCThSLs6tm1IhZsveAfLZDc8+OBK0xWCwt2hvwrnShmuBR0nD9r7xEOF
 q8zctjHh4lLPRJWyt2mQ+TMrj15GQJOQY00Y52hQXt15OZ3zsipFjZdEkPhCWTLQQYmp
 qNdOy7gespDLmQcMwF6J6r3RrC9pYvxQJUsCJ8UHg5Jcvc9JY/g8FHX2nBLpSkaZ4iOl
 OQfw==
X-Gm-Message-State: AOJu0YyUjU+16aZOun2oTyO8E82QACVTuxrGHb4WgFDh05vc+31Kp5WT
 WDhG/uA5/sEwSiJPHcQrP+f0MmfU4qLTe2zvTYnrKeVUoZbZYC0FEGwgA5gommRY7NpgIIbX3Pd
 zNvEOwXdl6bbFbHCLapar9CaSvfBZ8wl2Wp3qpNaUF9uxji988S8nCdkvjP4TY/YTK535UN0Fs5
 VlfSjuI+q5ptdfNbFjnTVeY+kShRovjDNwiMr9BivC
X-Gm-Gg: ASbGncv/O0Fus0XQdJfaNv6Trucg328sLJOcc6nvaT8T8kojHyl4bZY/5ubOlhWeakU
 yac3BenYQ0Iu4sIwSm6esAAcXAPxgs46loPos4LlnXQbSSYr1WOz5Zx/+M62p1AZkGxjZBY+8DG
 1uDmKpH5EhiZ5Fcl3FrqARO6R5q5bAoixvo54bWOphcLdquYS6Ez9gIMcUfKHh+hDwqmci80o8u
 ZAXy/4iK3oSP1G5HJ4Y45wCu6s4T66K6wf3l9y+JBTbuntExir/Sm3V2HPtRM1foP4umolNfpeW
 ii03+5DVfvmHJ7qv5WnzVDm0v7sty+qdnaP00Bukv6yxtiXI346hVOl2wWVwu3KLYPujFbwdbdQ
 8Z5IkviRyed3CAUHv/VQdOOqBhqp2KxSnesdgpECNHVC/ZicfjIsqhHGMdUnwpl/ZuG+2iGeqNk
 2GnWAl
X-Received: by 2002:a17:907:c0f:b0:b70:bbea:79e3 with SMTP id
 a640c23a62f3a-b70bbea7aa0mr730443166b.65.1762273883970; 
 Tue, 04 Nov 2025 08:31:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsDNn2Q+R8BgUcyfDR6U7DNYeVSyDqStQpAuPJSKtdx+uAxBG8Xv2DkFYw2nqL0wggM6MLVQ==
X-Received: by 2002:a17:907:c0f:b0:b70:bbea:79e3 with SMTP id
 a640c23a62f3a-b70bbea7aa0mr730439266b.65.1762273883311; 
 Tue, 04 Nov 2025 08:31:23 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723db0f1besm252182866b.31.2025.11.04.08.31.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] rust: add back to Ubuntu 22.04 jobs
Date: Tue,  4 Nov 2025 17:31:02 +0100
Message-ID: <20251104163102.738889-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104163102.738889-1-pbonzini@redhat.com>
References: <20251104163102.738889-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Ubuntu is now including updated versions of Rust (up to 1.85) for
its LTS releases.  Adjust the CI containers and re-add --enable-rust
to the Ubuntu jobs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst                   | 10 +++++-----
 .gitlab-ci.d/buildtest.yml                       |  2 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml |  2 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml   |  2 +-
 tests/docker/dockerfiles/ubuntu2204.docker       |  6 +++---
 tests/lcitool/mappings.yml                       |  4 ++--
 tests/lcitool/refresh                            |  4 ++--
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index fc2743658d4..e95784cdb55 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -117,14 +117,14 @@ Rust build dependencies
   a newer version using ``cargo install bindgen-cli``.
 
   QEMU requires Rust 1.83.0.  This is available on all supported platforms
-  with two exception: Ubuntu LTS releases 22.04 and 24.04, and the
-  ``mips64el`` architecture on Debian bookworm.  For all other
+  except for the ``mips64el`` architecture on Debian bookworm.  For all other
   architectures, Debian bookworm provides a new-enough Rust compiler
   in the ``rustc-web`` package.
 
-  It is expected that in the future Ubuntu will provide updated packages
-  like the existing ``rustc-1.82`` package.  The path to ``rustc`` and
-  ``rustdoc`` will have to be provided manually to the configure script.
+  For Ubuntu 22.04 ("Jammy") and 24.04 ("Noble") updated versions of
+  Rust are available through packages such as ``rustc-1.83`` package;
+  the path to ``rustc`` and ``rustdoc`` has to be provided manually to
+  the configure script.
 
   Some distros prefer to avoid vendored crate sources, and instead use
   local sources from e.g. ``/usr/share/cargo/registry``.  QEMU includes a
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 21f6d7e96fe..44df116139b 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -39,7 +39,7 @@ build-system-ubuntu:
     - job: amd64-ubuntu2204-container
   variables:
     IMAGE: ubuntu2204
-    CONFIGURE_ARGS: --enable-docs
+    CONFIGURE_ARGS: --enable-docs --enable-rust
     TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
     MAKE_CHECK_ARGS: check-build
 
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index 70063db198e..d303411391f 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -119,7 +119,7 @@ packages:
   - python3-wheel
   - python3-yaml
   - rpm2cpio
-  - rustc-1.77
+  - rustc-1.83
   - sed
   - socat
   - sparse
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 4f1a49be34a..4ee8630cc43 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -117,7 +117,7 @@ packages:
   - python3-wheel
   - python3-yaml
   - rpm2cpio
-  - rustc-1.77
+  - rustc-1.83
   - sed
   - socat
   - sparse
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index b393db55a8c..602d4196249 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -124,7 +124,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-wheel \
                       python3-yaml \
                       rpm2cpio \
-                      rustc-1.77 \
+                      rustc-1.83 \
                       sed \
                       socat \
                       sparse \
@@ -155,8 +155,8 @@ ENV LANG "en_US.UTF-8"
 ENV MAKE "/usr/bin/make"
 ENV NINJA "/usr/bin/ninja"
 ENV PYTHON "/usr/bin/python3"
-ENV RUSTC=/usr/bin/rustc-1.77
-ENV RUSTDOC=/usr/bin/rustdoc-1.77
+ENV RUSTC=/usr/bin/rustc-1.83
+ENV RUSTDOC=/usr/bin/rustdoc-1.83
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
index 8f0e95e1c56..a749cf8c515 100644
--- a/tests/lcitool/mappings.yml
+++ b/tests/lcitool/mappings.yml
@@ -70,8 +70,8 @@ mappings:
 
   rust:
     Debian12: rustc-web
-    Ubuntu2204: rustc-1.77
-    Ubuntu2404: rustc-1.77
+    Ubuntu2204: rustc-1.83
+    Ubuntu2404: rustc-1.83
 
 pypi_mappings:
   # Request more recent version
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 7fbdf6f340b..df186caffe6 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -152,8 +152,8 @@ fedora_rustup_nightly_extras = [
 ]
 
 ubuntu2204_rust_extras = [
-    "ENV RUSTC=/usr/bin/rustc-1.77\n",
-    "ENV RUSTDOC=/usr/bin/rustdoc-1.77\n",
+    "ENV RUSTC=/usr/bin/rustc-1.83\n",
+    "ENV RUSTDOC=/usr/bin/rustdoc-1.83\n",
     "ENV CARGO_HOME=/usr/local/cargo\n",
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-- 
2.51.1


