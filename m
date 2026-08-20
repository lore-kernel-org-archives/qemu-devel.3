Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797D8C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zm-0000rf-Tt; Thu, 20 Aug 2026 12:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zl-0000n4-Sw
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zj-0005m3-HL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AekDmTCsqKE/7Em+fp4v05CEB3akDFAXUbS1t0WA4sE=;
 b=LrT4YERlMvdYHVw0R4uiarr0BwNC2qhUZ6sGd9+oj1CJJrN8P1bbqgQTFy5opylqM9V2cm
 oaZ+yfsxWx7hecy1+zM2EZgnDUzlarz2XSve1Dn+diGbAx8MorQBWQRPQbcoCQa9SJv7Dl
 k5cdEg/04IbGiT/rKdFhLdIGp2hk+IE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-IcNNSURlOCG1SzOUw6tFnQ-1; Thu, 20 Aug 2026 12:51:51 -0400
X-MC-Unique: IcNNSURlOCG1SzOUw6tFnQ-1
X-Mimecast-MFC-AGG-ID: IcNNSURlOCG1SzOUw6tFnQ_1787244710
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-482a2d55c4eso67511f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244710; x=1787849510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AekDmTCsqKE/7Em+fp4v05CEB3akDFAXUbS1t0WA4sE=;
 b=tOLQWc2B+hxcDtifIQpW9sEs/zQWfYlKOLHu9bcZhU1WH0vo9BDyg6z14y1V70oLCh
 MabLOfeUHGI/3jdCmhfjWZDJ6gBdYytkyfJwDX1+ct2bAXYf2gBvS+Vi93cPKmek502B
 hgDsx8DQMr1q9CBxlu1VbRKn2s5NTaDK7P2eyjIEkV/4tPNXVOae26vNEHAq8S2pJ+6p
 UHtxP9Mog8IXV1/KvVji4AAPdb145UoPI9Gu7M+Nh3rGk+PanCK6yLibGfgansE4DM/X
 QVHMQ1MnfUCLxzA5EuvWJNlI1XPpSSNVMhdw16ciRVrHlgYPfYR9LTWLwSAF696mGMSx
 hUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244710; x=1787849510;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AekDmTCsqKE/7Em+fp4v05CEB3akDFAXUbS1t0WA4sE=;
 b=GFFNm3c5AQbC78h5eFFd9WlBcw94vezL/uf5yR7OPrw2CoAmOmTkE5egxwUyf2PFpr
 FPVNDmvZHhuGXIuxmyfmbA6D6poTD2PV0egEm/rrnGJ2L62437AFf/Y8z5HkLBdTJa8K
 /tekWAMnxvnTz42jPM16KI9R/clEoumWhvsiWfeAnYrnTBdtd4/idtFeiZb7lTfEhf+X
 J+38O6n6xAhrK8/ZBiKt9a6nQ2aubOSgsFWQGuie0LZ1uStPcQiFdaHf9qPW40D27xf9
 GNPbckXE/cKRvPRAF2jophT6P4yVYCkH9tx7mlXFAXC+S35FYK36xfCsIoOA6EWqhwz7
 Lojw==
X-Gm-Message-State: AFuF++lRPvQVOCY8ivhz6SnOcqcLJjpRie/IZU8E9Mya3gtXYaOJ7i6C
 ClSTByT59NfniXEd7TilEX7uN73h20JmU7H3aTFZzYGsRH7i0C1mtvH4HD9KS/3wzXm4lliS+wA
 jbFPktqfWsjdrxfY0XWh3xoeTDoETqpSnpz77ByLOTekisZZRfh4zdN8sqV6r1HSwQF+MLQFFvy
 YgdK7A1PiViq/P48RoafIGr43IRYpCfGIQvo0CsH8m
X-Gm-Gg: AR+sD12J8c97fMLx3egKU2K8GRI4WArdstBG65lN1G2zjW2FrUk2CYX0Pd+No6WP5OB
 2nJAA1fhk4pYtbDJwnjcE0JD1DmAAvxkqNl1c/OzU6GfkTap2QtL/xAJA7ArsVylqbgVOYwVQ39
 xa+gyJAVHEn7NP/7CJBecrIM/L2kutI8FB6fG313JLxOWBu4MHPW+8vi3MOuSEJCb5r2ANZ/DZR
 3SOgVTA5A6PTQ0wHkKBncpiWZS1BjABSkfM7oS4bykHqcw5empS7KpsK4J03oQjqjlpLH7xNKB/
 ObSSLr3jNIgiOJ1anNcLE3doZFZV6wyXQnLwjgR4OzgODWlEPjqvIT+qhR69rHApaE4FVivAzoO
 ISvTib2ZmZi5+CGd3H8IUbifWyXbg7h5YvfIxSr8BG+LTiVziEUvE40zL3VIMdrSfPGJvDpMiV/
 5D1A8=
X-Received: by 2002:a5d:64e6:0:b0:474:530:9d with SMTP id
 ffacd0b85a97d-482b1fd894bmr24784304f8f.13.1787244709838; 
 Thu, 20 Aug 2026 09:51:49 -0700 (PDT)
X-Received: by 2002:a5d:64e6:0:b0:474:530:9d with SMTP id
 ffacd0b85a97d-482b1fd894bmr24784190f8f.13.1787244709315; 
 Thu, 20 Aug 2026 09:51:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d05a6sm15332584f8f.35.2026.08.20.09.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 39/53] dockerfiles: remove packages required by Avocado
Date: Thu, 20 Aug 2026 18:49:42 +0200
Message-ID: <20260820164957.1895963-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make our CI containers smaller, by removing a handful of packages that
were only included as dependencies of Avocado.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/docker/dockerfiles/alpine.docker               | 3 ---
 tests/docker/dockerfiles/centos9.docker              | 3 ---
 tests/docker/dockerfiles/debian-amd64-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian-arm64-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian-armhf-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian-i686-cross.docker    | 4 ----
 tests/docker/dockerfiles/debian-ppc64el-cross.docker | 4 ----
 tests/docker/dockerfiles/debian-riscv64-cross.docker | 4 ----
 tests/docker/dockerfiles/debian-s390x-cross.docker   | 4 ----
 tests/docker/dockerfiles/debian.docker               | 4 ----
 tests/docker/dockerfiles/fedora-rust-nightly.docker  | 4 ----
 tests/docker/dockerfiles/fedora-win64-cross.docker   | 4 ----
 tests/docker/dockerfiles/fedora.docker               | 4 ----
 tests/docker/dockerfiles/opensuse-leap.docker        | 4 ----
 tests/docker/dockerfiles/ubuntu2404.docker           | 4 ----
 .gitlab-ci.d/macos-14.vars                           | 2 +-
 scripts/ci/setup/debian/debian-13-ppc64le.yaml       | 4 ----
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml     | 4 ----
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml       | 4 ----
 tests/lcitool/projects/qemu.yml                      | 4 ----
 tests/vm/generated/freebsd.json                      | 4 ----
 21 files changed, 1 insertion(+), 79 deletions(-)

diff --git a/tests/docker/dockerfiles/alpine.docker b/tests/docker/dockerfiles/alpine.docker
index 118c6e8eeaf..8a5a355e89a 100644
--- a/tests/docker/dockerfiles/alpine.docker
+++ b/tests/docker/dockerfiles/alpine.docker
@@ -83,14 +83,11 @@ RUN apk update && \
         pixman-dev \
         pkgconf \
         pulseaudio-dev \
-        py3-numpy \
-        py3-pillow \
         py3-pip \
         py3-setuptools \
         py3-sphinx \
         py3-sphinx_rtd_theme \
         py3-wheel \
-        py3-yaml \
         python3 \
         rpm2cpio \
         rust \
diff --git a/tests/docker/dockerfiles/centos9.docker b/tests/docker/dockerfiles/centos9.docker
index 0d5b5fa7f59..e38cd692db9 100644
--- a/tests/docker/dockerfiles/centos9.docker
+++ b/tests/docker/dockerfiles/centos9.docker
@@ -96,9 +96,6 @@ RUN dnf --quiet distro-sync -y && \
                 pkgconfig \
                 pulseaudio-libs-devel \
                 python3 \
-                python3-PyYAML \
-                python3-numpy \
-                python3-pillow \
                 python3-pip \
                 python3-setuptools \
                 python3-sphinx \
diff --git a/tests/docker/dockerfiles/debian-amd64-cross.docker b/tests/docker/dockerfiles/debian-amd64-cross.docker
index 061cd8e9b82..823606dc52a 100644
--- a/tests/docker/dockerfiles/debian-amd64-cross.docker
+++ b/tests/docker/dockerfiles/debian-amd64-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-arm64-cross.docker b/tests/docker/dockerfiles/debian-arm64-cross.docker
index 3dfa60fdfd7..ed58e089ec0 100644
--- a/tests/docker/dockerfiles/debian-arm64-cross.docker
+++ b/tests/docker/dockerfiles/debian-arm64-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-armhf-cross.docker b/tests/docker/dockerfiles/debian-armhf-cross.docker
index 401c64269c1..0843f7428a9 100644
--- a/tests/docker/dockerfiles/debian-armhf-cross.docker
+++ b/tests/docker/dockerfiles/debian-armhf-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-i686-cross.docker b/tests/docker/dockerfiles/debian-i686-cross.docker
index 8b60c7b085f..caba08f842e 100644
--- a/tests/docker/dockerfiles/debian-i686-cross.docker
+++ b/tests/docker/dockerfiles/debian-i686-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-ppc64el-cross.docker b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
index 2a7e8cba056..17018c0dab7 100644
--- a/tests/docker/dockerfiles/debian-ppc64el-cross.docker
+++ b/tests/docker/dockerfiles/debian-ppc64el-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-riscv64-cross.docker b/tests/docker/dockerfiles/debian-riscv64-cross.docker
index 349de3a0bbb..2408d453c20 100644
--- a/tests/docker/dockerfiles/debian-riscv64-cross.docker
+++ b/tests/docker/dockerfiles/debian-riscv64-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian-s390x-cross.docker b/tests/docker/dockerfiles/debian-s390x-cross.docker
index 8bc42b1e00b..2b0a344c2c5 100644
--- a/tests/docker/dockerfiles/debian-s390x-cross.docker
+++ b/tests/docker/dockerfiles/debian-s390x-cross.docker
@@ -41,9 +41,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -51,7 +48,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/debian.docker b/tests/docker/dockerfiles/debian.docker
index 413986d3f07..064b2ad1f12 100644
--- a/tests/docker/dockerfiles/debian.docker
+++ b/tests/docker/dockerfiles/debian.docker
@@ -113,9 +113,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -123,7 +120,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc \
                       sed \
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 4f84b803798..dcad3af2a7f 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -104,10 +104,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        pkgconfig \
                        pulseaudio-libs-devel \
                        python3 \
-                       python3-PyYAML \
-                       python3-numpy \
-                       python3-opencv \
-                       python3-pillow \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/fedora-win64-cross.docker b/tests/docker/dockerfiles/fedora-win64-cross.docker
index c1e63feb46f..bce350dfd8d 100644
--- a/tests/docker/dockerfiles/fedora-win64-cross.docker
+++ b/tests/docker/dockerfiles/fedora-win64-cross.docker
@@ -44,10 +44,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        ninja-build \
                        openssh-clients \
                        python3 \
-                       python3-PyYAML \
-                       python3-numpy \
-                       python3-opencv \
-                       python3-pillow \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
index a6996917c4b..c541f5d5b18 100644
--- a/tests/docker/dockerfiles/fedora.docker
+++ b/tests/docker/dockerfiles/fedora.docker
@@ -104,10 +104,6 @@ exec "$@"\n' > /usr/bin/nosync && \
                        pkgconfig \
                        pulseaudio-libs-devel \
                        python3 \
-                       python3-PyYAML \
-                       python3-numpy \
-                       python3-opencv \
-                       python3-pillow \
                        python3-pip \
                        python3-setuptools \
                        python3-sphinx \
diff --git a/tests/docker/dockerfiles/opensuse-leap.docker b/tests/docker/dockerfiles/opensuse-leap.docker
index fc363c647cd..8d8631bbcf0 100644
--- a/tests/docker/dockerfiles/opensuse-leap.docker
+++ b/tests/docker/dockerfiles/opensuse-leap.docker
@@ -93,12 +93,8 @@ RUN zypper update -y && \
            pcre2-devel-static \
            pipewire-devel \
            pkgconfig \
-           python3-Pillow \
-           python3-PyYAML \
            python3-Sphinx \
            python3-base \
-           python3-numpy \
-           python3-opencv \
            python3-pip \
            python3-setuptools \
            python3-sphinx_rtd_theme \
diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index 27992e34fd9..f027eef022e 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -113,9 +113,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       openssh-client \
                       pkgconf \
                       python3 \
-                      python3-numpy \
-                      python3-opencv \
-                      python3-pillow \
                       python3-pip \
                       python3-setuptools \
                       python3-sphinx \
@@ -123,7 +120,6 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
                       python3-tomli \
                       python3-venv \
                       python3-wheel \
-                      python3-yaml \
                       rpm2cpio \
                       rustc-1.83 \
                       sed \
diff --git a/.gitlab-ci.d/macos-14.vars b/.gitlab-ci.d/macos-14.vars
index def77cfdea5..0c187624dd0 100644
--- a/.gitlab-ci.d/macos-14.vars
+++ b/.gitlab-ci.d/macos-14.vars
@@ -12,5 +12,5 @@ NINJA='/opt/homebrew/bin/ninja'
 PACKAGING_COMMAND='brew'
 PIP3='/opt/homebrew/bin/pip3'
 PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
-PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
+PYPI_PKGS='sphinx sphinx-rtd-theme tomli'
 PYTHON='/opt/homebrew/bin/python3'
diff --git a/scripts/ci/setup/debian/debian-13-ppc64le.yaml b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
index e64321357da..9acd99a7433 100644
--- a/scripts/ci/setup/debian/debian-13-ppc64le.yaml
+++ b/scripts/ci/setup/debian/debian-13-ppc64le.yaml
@@ -105,9 +105,6 @@ packages:
   - openssh-client
   - pkgconf
   - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
   - python3-pip
   - python3-setuptools
   - python3-sphinx
@@ -115,7 +112,6 @@ packages:
   - python3-tomli
   - python3-venv
   - python3-wheel
-  - python3-yaml
   - rpm2cpio
   - rustc
   - sed
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
index 12b0e38a220..5c948109df8 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml
@@ -106,9 +106,6 @@ packages:
   - openssh-client
   - pkgconf
   - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
   - python3-pip
   - python3-setuptools
   - python3-sphinx
@@ -116,7 +113,6 @@ packages:
   - python3-tomli
   - python3-venv
   - python3-wheel
-  - python3-yaml
   - rpm2cpio
   - rustc-1.83
   - sed
diff --git a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
index 56299f4cc2b..010b7f86aab 100644
--- a/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
+++ b/scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml
@@ -104,9 +104,6 @@ packages:
   - openssh-client
   - pkgconf
   - python3
-  - python3-numpy
-  - python3-opencv
-  - python3-pillow
   - python3-pip
   - python3-setuptools
   - python3-sphinx
@@ -114,7 +111,6 @@ packages:
   - python3-tomli
   - python3-venv
   - python3-wheel
-  - python3-yaml
   - rpm2cpio
   - rustc-1.83
   - sed
diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 7d185cda3cc..b3c99936723 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -91,11 +91,7 @@ packages:
  - pkg-config
  - pulseaudio
  - python3
- - python3-numpy
- - python3-opencv
- - python3-pillow
  - python3-pip
- - python3-PyYAML
  - python3-setuptools
  - python3-sphinx
  - python3-sphinx-rtd-theme
diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
index 08b6eb61553..dfa8b41a524 100644
--- a/tests/vm/generated/freebsd.json
+++ b/tests/vm/generated/freebsd.json
@@ -49,14 +49,10 @@
     "ncurses",
     "nettle",
     "ninja",
-    "opencv",
     "pixman",
     "pkgconf",
     "png",
-    "py311-numpy",
-    "py311-pillow",
     "py311-pip",
-    "py311-pyyaml",
     "py311-setuptools",
     "py311-sphinx",
     "py311-sphinx_rtd_theme",
-- 
2.55.0


