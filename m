Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9A8D64074
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJO-00029E-Ff; Fri, 08 Nov 2024 13:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJJ-00023a-9d
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJH-0001xs-MF
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uynPjKqvjPdBbc/TZoxPs1tE8K2Uir/0YKLh2NR6k6I=;
 b=E6wwbHqqqWbDD/OxyZfBXjVcPO8RUucALaLNvgt/JmP6iefMwzqul8uu3+aqs3M3aXE71/
 gvopVav94J4+jwdXrq6XBx3CecOvU+04SV1l+dpfip1VZ+1535reNv33dky6FiBPrrgeLG
 ZHCCdTH5lU4hZPwAefL7gsmxD6ma5qE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-5JU1HG3bNwyf9NtS4I212w-1; Fri, 08 Nov 2024 13:02:12 -0500
X-MC-Unique: 5JU1HG3bNwyf9NtS4I212w-1
X-Mimecast-MFC-AGG-ID: 5JU1HG3bNwyf9NtS4I212w
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso1334385f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:02:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088930; x=1731693730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uynPjKqvjPdBbc/TZoxPs1tE8K2Uir/0YKLh2NR6k6I=;
 b=AqtOTGbEsOF6Vq1JYkyUhT94MAnh/UOLwfqomiTjvoGJ8g81bd2em1i+imEIDSQPNx
 cZzENzLylOdIkm7wEzaoZTvXSmWmiWkXARtV84jszczCsxVhNW4LipZ+F/lASxSe+yuI
 0MzRudnv3btsBb09y63cS/CR3xWDlEXbq6t7IKGo+Sya51XEcHB1GXFpRoIVYqCLeFo6
 Tuyok6RSOklcnvZMTymtKHtE/JXZMHOrX3376/Qp8fLwksD+0Hps3bpU8WHuLqk6+lpA
 cbqnLUy2oya1u5vGVtg2LRV6PFyUsC0rA6FSe7CFePXsT3mKfOcOHA2vjxtb0sBPc5uC
 wGrg==
X-Gm-Message-State: AOJu0YxTAyV7+S/bVODHtEmjYGBSytj5WY940OHNWVyzGKoE74+MYQ45
 /HG5YkqCgBt/DcdT83B1i6iJnjodYULFOwnaHIlALf0plgUFSGTQpLan9Mi/up8wYwZ1JpXvK3S
 hJyQMkSouonAMNPtthos/agL+ojDX1s4HhAY+0UQfvORE1aWAjJh83kuP39mpdiKDwQcbpZ31GE
 h4E5jrlPwJteMdcXsqXFpY/My/+zr3j6Yvfi2mM9c=
X-Received: by 2002:a5d:64a1:0:b0:37d:460d:2d07 with SMTP id
 ffacd0b85a97d-381f0f5849amr4484979f8f.10.1731088930406; 
 Fri, 08 Nov 2024 10:02:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsZ4wZZY5P6H1a5W18sCQR59R0+5Giwiagz0mJ7cx4Pisoaa2JQ90AMCbQmi5qvooHA0scmg==
X-Received: by 2002:a5d:64a1:0:b0:37d:460d:2d07 with SMTP id
 ffacd0b85a97d-381f0f5849amr4484918f8f.10.1731088929917; 
 Fri, 08 Nov 2024 10:02:09 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5f77sm79887345e9.43.2024.11.08.10.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:02:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 11/11] rust: ci: add job that runs Rust tools
Date: Fri,  8 Nov 2024 19:01:39 +0100
Message-ID: <20241108180139.117112-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Code checks, as well as documentation generation, are not yet tied
to "make check" because they need new version of the Rust toolchain
(even nightly in the case of "rustfmt").  Run them in CI using the
existing nightly-Rust container.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml                | 14 ++++++++++++++
 .gitlab-ci.d/buildtest.yml                         | 14 ++++++++++++++
 .../docker/dockerfiles/fedora-rust-nightly.docker  |  4 ++++
 tests/lcitool/refresh                              |  4 ++++
 4 files changed, 36 insertions(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 39da7698b09..612e968ff19 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -79,6 +79,20 @@
     - $MAKE NINJA=":" $MAKE_CHECK_ARGS
     - section_end test
 
+.rust_test_job_template:
+  extends: .base_job_template
+  stage: test
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
+  script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start test "Running Rust code checks"
+    - cd build
+    - pyvenv/bin/meson devenv -w ../rust ${CARGO-cargo} fmt --check
+    - make clippy
+    - pyvenv/bin/meson devenv -w ../rust ${CARGO-cargo} doc --no-deps
+    - pyvenv/bin/meson devenv -w ../rust ${CARGO-cargo} test --doc
+    - section_end test
+
 .native_test_job_template:
   extends: .common_test_job_template
   artifacts:
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 336223484d8..5250b61f089 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -142,6 +142,20 @@ check-system-fedora:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
+check-rust-fedora-rust-nightly:
+  extends: .rust_test_job_template
+  needs:
+    - job: build-system-fedora-rust-nightly
+      artifacts: true
+  variables:
+    IMAGE: fedora-rust-nightly
+    MAKE_CHECK_ARGS: check
+  artifacts:
+    when: on_success
+    expire_in: 2 days
+    paths:
+      - rust/target/doc
+
 functional-system-fedora:
   extends: .functional_test_job_template
   needs:
diff --git a/tests/docker/dockerfiles/fedora-rust-nightly.docker b/tests/docker/dockerfiles/fedora-rust-nightly.docker
index 9180c8b5222..a8e4fb279a7 100644
--- a/tests/docker/dockerfiles/fedora-rust-nightly.docker
+++ b/tests/docker/dockerfiles/fedora-rust-nightly.docker
@@ -155,6 +155,7 @@ ENV PYTHON "/usr/bin/python3"
 RUN dnf install -y wget
 ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo
 ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc
+ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo
 RUN set -eux && \
   rustArch='x86_64-unknown-linux-gnu' && \
   rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \
@@ -165,10 +166,13 @@ RUN set -eux && \
   ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \
   chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \
   /usr/local/cargo/bin/rustup --version && \
+  /usr/local/cargo/bin/rustup run nightly cargo --version && \
   /usr/local/cargo/bin/rustup run nightly rustc --version && \
+  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \
   test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"
 ENV PATH=$CARGO_HOME/bin:$PATH
 RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli
+RUN $CARGO --list
 # As a final step configure the user (if env is defined)
 ARG USER
 ARG UID
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 51012783c0f..6720516b942 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -121,6 +121,7 @@ fedora_rustup_nightly_extras = [
     "RUN dnf install -y wget\n",
     "ENV RUSTUP_HOME=/usr/local/rustup CARGO_HOME=/usr/local/cargo\n",
     "ENV RUSTC=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustc\n",
+    "ENV CARGO=/usr/local/rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/cargo\n",
     "RUN set -eux && \\\n",
     "  rustArch='x86_64-unknown-linux-gnu' && \\\n",
     "  rustupSha256='6aeece6993e902708983b209d04c0d1dbb14ebb405ddb87def578d41f920f56d' && \\\n",
@@ -131,10 +132,13 @@ fedora_rustup_nightly_extras = [
     "  ./rustup-init -y --no-modify-path --profile default --default-toolchain nightly --default-host ${rustArch} && \\\n",
     "  chmod -R a+w $RUSTUP_HOME $CARGO_HOME && \\\n",
     "  /usr/local/cargo/bin/rustup --version && \\\n",
+    "  /usr/local/cargo/bin/rustup run nightly cargo --version && \\\n",
     "  /usr/local/cargo/bin/rustup run nightly rustc --version && \\\n",
+    '  test "$CARGO" = "$(/usr/local/cargo/bin/rustup +nightly which cargo)" && \\\n',
     '  test "$RUSTC" = "$(/usr/local/cargo/bin/rustup +nightly which rustc)"\n',
     'ENV PATH=$CARGO_HOME/bin:$PATH\n',
     'RUN /usr/local/cargo/bin/rustup run nightly cargo install bindgen-cli\n',
+    'RUN $CARGO --list\n',
 ]
 
 ubuntu2204_bindgen_extras = [
-- 
2.47.0


