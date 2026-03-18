Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3A7FCD0D2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2m9j-0006fQ-MM; Wed, 18 Mar 2026 04:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2m9d-0006eW-3s
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2m9Y-0006MW-NN
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773822079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wIJ7DrPgVmjwpgfX5YS474vIHpoL5e37oQePzDSoBEo=;
 b=aqgia+1UzzUWA9ieErCar9YcVswypk2cSYmJrezfACuY7SsF3h1ztN3/W//PeeUAwsaceX
 dLYlojv3ZQ7j6opvN0UObC47F5vt6AJCeKpUF0a57QOp9H2TsD7oY67L3uCF763KuAw8c2
 AcWUKVuYnH0nzat45sONa4DEmlTxcbk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-PDHbwZvRPNGIjKOMMcrczg-1; Wed, 18 Mar 2026 04:21:17 -0400
X-MC-Unique: PDHbwZvRPNGIjKOMMcrczg-1
X-Mimecast-MFC-AGG-ID: PDHbwZvRPNGIjKOMMcrczg_1773822076
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4839fc4cef6so8128075e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773822075; x=1774426875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wIJ7DrPgVmjwpgfX5YS474vIHpoL5e37oQePzDSoBEo=;
 b=OR5vT8xv7SWTwXZRvbAaNkC8HFCPhJ//z/P0bQue2B1XyhIIPNFuzGc8Li1lbCnP2F
 PmcLAEeYbTlZ3/e8vL/Cp7MVS9H22P4iW/+nCR1rEbiYm2GbliqOnuCCp/4RosGc7nIh
 pei921flYncQVJdnMKrvxqYGouA4U8ja9WFuh3L0kuiLHISo3hdKv/VdwNIyVFdyhzfJ
 CS5Kf5EzU0OQVvVLnSHcCGwz3EhMe6kCwJz09BmJF5RihXhXRCEQoaz/HoC84Utcjpc0
 4CHtl3aK1eHz0e2MFggJRKZoCjZJIuYiD66xVxdCj/YTpXgXHFxXQVHtuGHaOlFciHLZ
 aQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773822075; x=1774426875;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wIJ7DrPgVmjwpgfX5YS474vIHpoL5e37oQePzDSoBEo=;
 b=XU8NO0Zo4xePsbqH4UYXqyVgBwD8PkLD98Io5ciYOChi0yJKLUTeGGInqyCkVeN27Y
 5XQPSCbdX1ZcSi55pKU65Wi9xyb95ZZ3qzgvX7A8wZGjTuT3op7Hd31a9yq4NienrQcw
 FdtuUNqIRqg8q8vyYJfqvNtlg6LoiNxbA8vIKIFZ0YKYqSAungrnV9TdDW7Zz+RfY894
 pgi24BRQwTWXAgkcGa+HifXexMS2yoSxBTo5NSu7tEq7PjqS3V7DTkTBJmig68/pRu+T
 iSuq1nCbrntkllluhrDPuWybLZsz0/MjMUKIUT35E6hH79Y1XiAy8rDoHgKTjtOf815B
 O6ew==
X-Gm-Message-State: AOJu0Yzzwvn5lLIINbgSNoi9f+ZkvD7LOakVkFYmRyFc4Ebqoq4GNnvK
 g0QcqZGHwIJTcKsLv1BkplHofyIRsCNtUsh7DkeKO5h+uqpBIUR06pbNxL+5iQn+neEt1t+q1q2
 WrkEs+DG00D7tULsSw+nNFdDNL8EKHUR/jtUMQBlE0dBOFRWhJ1+5JEMWG/EC6A3aofj/kpeCuY
 LjikQm2edIh2O4wg0hk8FNQDNPjRxmw8HpowvyLCL9
X-Gm-Gg: ATEYQzyQQfg8q5Yls7j5txnuvddHb15NnLm47vNGlE56WwGG7S86P2zclaDuth+2g53
 qHp9NC2DnGCKm+SY+oKHrt+/dL4TsKmCN+BElE4vKflYrWtD8BBiR00Pml369rolDCNdlja7xXV
 +aC3IksfQOjAUj1sLHG8Ly9auYeKJF/axVQ0dZhw5VtVR6hXPVOIkWUwJA/yS2XnLUAH3NoO+3j
 Li3aLAkbtCDJ33gZ0lcgX6VZycGj/4Dcc1sKX8CbAm8WsY4wQ5M2OrWUJmjB58TJr+WWsGP+CVS
 gh5vJhmRTafBikX6ZNAYgugiMeRVxx24Te5SdNvkGCo0nS1FsbIW/VeQ3m/Mh7Btlb2QG2knyC+
 DZgL3rqkhHtLdxVuu6PHqOVEiF93XmnHaxeLSmA2ufp7boI0ZNlkELnfbT9rikGviXBqkbstmIF
 pyp0yVUPCdAnv/X2cJhkL3FixWX14=
X-Received: by 2002:a05:600c:a0d:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-486f40c1975mr41165845e9.9.1773822075347; 
 Wed, 18 Mar 2026 01:21:15 -0700 (PDT)
X-Received: by 2002:a05:600c:a0d:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-486f40c1975mr41165435e9.9.1773822074833; 
 Wed, 18 Mar 2026 01:21:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856eaeca12sm212955275e9.12.2026.03.18.01.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 01:21:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] rust: suggest passing --locked to "cargo install"
Date: Wed, 18 Mar 2026 09:21:13 +0100
Message-ID: <20260318082113.1127992-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
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


