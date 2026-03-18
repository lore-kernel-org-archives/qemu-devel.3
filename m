Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68DDFB5EAB
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mKq-0000t8-MT; Wed, 18 Mar 2026 04:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKo-0000s8-Af
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKl-0001nx-Hx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773822772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wIJ7DrPgVmjwpgfX5YS474vIHpoL5e37oQePzDSoBEo=;
 b=fAfDReLvhcGBW7hx69bRZqWGie+gb2lGgvEDLPX/+YhiVGkGx18zgU5Q5L9+1iuHeBy5Ma
 15aEqXpKHlL+yUtQBHi7cd086eAUc52B2IP04+lNQOzMoYatSCDlx2SrCpzxZGAM1GqXey
 GTegS6O5GT6UBMxonS854M9xoNHvasg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-jsaMgZ63OBuLrDC7dn2Q0w-1; Wed, 18 Mar 2026 04:32:51 -0400
X-MC-Unique: jsaMgZ63OBuLrDC7dn2Q0w-1
X-Mimecast-MFC-AGG-ID: jsaMgZ63OBuLrDC7dn2Q0w_1773822769
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-485c45885e6so3402545e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773822768; x=1774427568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIJ7DrPgVmjwpgfX5YS474vIHpoL5e37oQePzDSoBEo=;
 b=EiVVyuK3hsHyDA470aYWW9RhrP8UjbS7NvH991yXuTMJd3/aVtWDugeI8YQ8U78i0g
 21ZDMP1gLEHTuXUAjRSLtLaEXzEqgtZ7oGmS/WCuA5j9gY7EhKaiOygV7oiO530Owss8
 gsvP55nW5vk/cPw3Y9Nqvb5gNHCOf/kKsjml1RoHbpGj/GdpfuN3nxMwSJZdZqI1nAAV
 3jcH9VURPHaS9rmkhKnuA/YO97jU0p9JXfPlZJYmqc3yeQeUZ9pWdQp8Iqp9NA6TgJuZ
 7beQCdyFJyEzH/f0DIsXp10OGxFdDxw1m1Gi4sj7GXeoTYuR5Qo1iQlTgRAmREXa65HW
 aqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773822768; x=1774427568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wIJ7DrPgVmjwpgfX5YS474vIHpoL5e37oQePzDSoBEo=;
 b=rxKvxNWUi+Zor5KElz8SSKxPDJDSv9sa72drkqV2LehkdrO8YaU+HNM3FbWifZYOgf
 dD7ymgGzmgHLtUbB7whZInJIVY2oxMoZzzhSTr+5Z3PVgpIHCWtvVRevjbG2m8+iJHdU
 IpXIrhEEwm9mOggXy88CKWWwyXgj1FpRQ7LU1B79LvBBskwnhEQQmIxAlptDOUhx8Kpj
 KOGKIm+ISCNKfHowVJUwqleQySNs3WA1OyPZ7qea/RVbTALg4WAAxD8w/zgsCIIOjsfP
 epRv7XXVUt3fB2I3ZbLE74F42Jgon5qYIj5Kf2NWEkkgFEfoocC056GmtPAUvPAwHJFx
 X3Vw==
X-Gm-Message-State: AOJu0YwYKLBfKbXPXHtg0zb8rtiunDO3PZag7qgAUcRLegCpHEOqZDL3
 CImwnAO3rGuzdEfKDIpdmOM15LvGMFF7a+C4vfTUlf7u05LMjYYISs1j7PNPDt2Mc+/VvN+ilRB
 UOsCnyZAdc+R/YSgavFT1jTG2RxjZEBacwXw5/VAY5GKA6FC8b/IoResaUKl7J4/j+BsLaaNOsG
 KUnQnkX+tMshs4ZuXID35JFIsTe7D9LzYj42MjJN7L
X-Gm-Gg: ATEYQzxM7S92OUJ/c1yzrNjzLM6NxOufZn2tVRkfrHuReVwCuswxm41TUynX5UThypE
 u6r7mXZL89R7LUdvqvrAA+sq3ycg439S9Wqf7eAin7yqWpdEvlIfkr0lagD+jyPLjBHcAwum+9w
 +k+UrIb4YAm96eIylUH5sXJmPqBvWXqQ/7lrIcQGADskLGm2cNcWSuKhqPHfxE0ch1D+trBL606
 AZK41eQgLTC77LYs2PvuriYcMPx5blobY2D87tHDXYIy3aoS93D0PLWaXkHNSq1mMaRWwBBHPQV
 iZT9tf3YBoSs3fQfy5g9smK107n+YsQSbiJqTggXpAYO3Kzpuv6Ks5Fim3gomR8XgGEsydQPAYF
 xZDg9pOR61VJqPYOHOk3NeLi8zGqDD6CkywTHpGPUNBiSzoTw1hoTaX5J7fGBZBpD57BVeTFhkP
 LBs3+rGYPV4zxRLc+YMknkIm9QEeY=
X-Received: by 2002:a05:600c:8b52:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-486f4421c57mr37873955e9.6.1773822767528; 
 Wed, 18 Mar 2026 01:32:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8b52:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-486f4421c57mr37873425e9.6.1773822766945; 
 Wed, 18 Mar 2026 01:32:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f4e5495csm21231305e9.2.2026.03.18.01.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 01:32:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/4] rust: suggest passing --locked to "cargo install"
Date: Wed, 18 Mar 2026 09:32:38 +0100
Message-ID: <20260318083238.1132609-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318083238.1132609-1-pbonzini@redhat.com>
References: <20260318083238.1132609-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Without the option, cargo will try using the latest version of the
dependencies of bindgen-cli. While it will obviously respect the
constraints in Cargo.toml, old versions of Cargo do not have
version-constrained resolution and will choke on dependencies
that need Rust 2024.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/build-platforms.rst                      | 2 +-
 meson.build                                         | 2 +-
 tests/docker/dockerfiles/fedora-rust-nightly.docker | 2 +-
 tests/docker/dockerfiles/ubuntu2204.docker          | 2 +-
 tests/lcitool/refresh                               | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index 6e3088d524a..3d23dfbd779 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -114,7 +114,7 @@ Rust build dependencies
   bindgen tool, which is too big to package and distribute.  The minimum
   supported version of bindgen is 0.60.x.  For distributions that do not
   include bindgen or have an older version, it is recommended to install
-  a newer version using ``cargo install bindgen-cli``.
+  a newer version using ``cargo install --locked bindgen-cli``.
 
   QEMU requires Rust 1.83.0.  This is available on all supported platforms
   except for the ``mips64el`` architecture on Debian bookworm.  For all other
diff --git a/meson.build b/meson.build
index d016482db1b..62fab727f4e 100644
--- a/meson.build
+++ b/meson.build
@@ -114,7 +114,7 @@ if have_rust
   bindgen = find_program('bindgen', required: get_option('rust'))
   if not bindgen.found() or bindgen.version().version_compare('<0.60.0')
     if get_option('rust').enabled()
-      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install bindgen-cli"')
+      error('bindgen version ' + bindgen.version() + ' is unsupported. You can install a new version with "cargo install --locked bindgen-cli"')
     else
       if bindgen.found()
         warning('bindgen version ' + bindgen.version() + ' is unsupported, disabling Rust compilation.')
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 043b42a0a9b..38381ef8f59 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -179,7 +179,7 @@ RUN set -eux && \
   test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \
   test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
 ENV PATH=$CARGO_HOME/bin:$PATH
-RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
+RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli
 RUN $CARGO --list
 # As a final step configure the user (if env is defined)
 ARG USER
diff --git a/tests/docker/dockerfiles/ubuntu2204.docker b/tests/docker/dockerfiles/ubuntu2204.docker
index 23b33d6ad44..44e763f571a 100644
--- a/tests/docker/dockerfiles/ubuntu2204.docker
+++ b/tests/docker/dockerfiles/ubuntu2204.docker
@@ -162,7 +162,7 @@ ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends cargo
-RUN cargo install bindgen-cli
+RUN cargo install --locked bindgen-cli
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 259e6ea0729..79a280feab4 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -147,7 +147,7 @@ fedora_rustup_nightly_extras = [
     '  test "$RUSTDOC" = "$(/usr/local/cargo/bin/rustup +nightly which rustdoc)" && \\\n',
     '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
-    'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
+    'RUN /usr/local/cargo/bin/rustup run nightly cargo install --locked bindgen-cli\n',
     'RUN $CARGO --list\n',
 ]
 
@@ -158,7 +158,7 @@ ubuntu2204_rust_extras = [
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
     "  apt install -y --no-install-recommends cargo\n",
-    'RUN cargo install bindgen-cli\n',
+    'RUN cargo install --locked bindgen-cli\n',
 ]
 
 debian_all_test_cross_compilers = [
-- 
2.53.0


