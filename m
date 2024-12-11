Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AB3E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPZN-0003gc-5F; Wed, 11 Dec 2024 11:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZG-00032Y-BY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPZ9-0000L3-IQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xmqHi0FLBrnWkZWiScIbYdimPuw1BGqG3qZicgcwQCY=;
 b=ZszfHONu+6adHUEpr6BP5Uls/rbJZjvd5g1JRwppRxi+a8FCs/OZrk/4c5eNjYm7x24UaN
 g3bT1aiDxVfkeq6qTZF4vEy0O5XDZv6Wz8Nz7bG8c3vlEBwEm5M1q0bgIQPbSKaCUsZN9J
 9hjOJIMiYefyEAGTUUzvlq/X6RruITc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-7boqow8WMCaPdoCGoBm7RA-1; Wed, 11 Dec 2024 11:27:53 -0500
X-MC-Unique: 7boqow8WMCaPdoCGoBm7RA-1
X-Mimecast-MFC-AGG-ID: 7boqow8WMCaPdoCGoBm7RA
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8f0b1023bso64780306d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934472; x=1734539272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmqHi0FLBrnWkZWiScIbYdimPuw1BGqG3qZicgcwQCY=;
 b=ervbHevQNFCLTwSfXX+WXZrD5ZQDvJiIIqUkvpxhHI+tP6h2Our3fm0GQRutHkZcl4
 LmFw4bGndQA1cn2kzf6qx27UsQK4cEvyUzKC/2qd0uez7sPvDRZveU9wVZon//9PBFHy
 kj814+EPr2FZcU28aDCGIg7mnO+RCIDWy6BoOCO8qx8oQRPx1ioOTGREvyXT8VL2kWUc
 G4YRE3gfoVSh5RDK/xhzWQ2laT0BVqZULyQiT5ivsPLOcz3nWFz/g73RJ+eXWZhldRn3
 wG3hlbZZ7Tzlsf7XCCKj8p49se5F9CP2hnfYorGyJag8o1q6BvnhBdcgXOTY4EJjPm08
 03rw==
X-Gm-Message-State: AOJu0Yzp0BPLXTzQI0KXxT2JnPjBpRjMwz1fbFRaEH79gGy2EqJ4vWRh
 90ArgLTjl8eQk8oFq5spfU3SfXdi1FZVis3OkzLr4C6EO6BPPYd0EezF/MwFcDkn6a2qJkradzI
 d7vN+F3lqAedKBCLSjSwRFD3mOpHOUAPHr52NQkC5p1Jlx4wBJu0FZ6zOvRStYGJgxh7StqxRXW
 VBFccwnuuD64Gqrn6Q5I9+Z2QhlYPOYdhFboT7
X-Gm-Gg: ASbGncsVS6qxe3K9QlDnFwceZBnL8hQfNiqgvTCVvDYU1XwhJQnC9AaIe0B84/+DGrn
 jK5aBcSQLUQgR7V9Y2V+UBGeWetOtMARocM8d4bKwPpQP36nWD+QRZW6QeRkE0rpQEEXzhIa0Md
 EVGFBJblpHQyBrC2iuj0rfQluhDXkF1mYOdT+LsKucfTQ/TtR07N9Xz6qMxzZAMzQtn+FL7trUL
 JjPSeyJJ6z6lncjFnxwzkN1a125AhcRnX1q7/VHAFe5JuHOYooQvegY
X-Received: by 2002:a05:6214:d8d:b0:6d4:586:6285 with SMTP id
 6a1803df08f44-6dae29f2372mr5431106d6.11.1733934472547; 
 Wed, 11 Dec 2024 08:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOJ0zfWh5NEixr0fhiNt+8j5REnuFEmASotm8YgE8EViDvWCnEL1Byh6RumC06in+zq8ci2w==
X-Received: by 2002:a05:6214:d8d:b0:6d4:586:6285 with SMTP id
 6a1803df08f44-6dae29f2372mr5430576d6.11.1733934471998; 
 Wed, 11 Dec 2024 08:27:51 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d9004a6264sm45535776d6.87.2024.12.11.08.27.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/49] rust: ci: add job that runs Rust tools
Date: Wed, 11 Dec 2024 17:26:42 +0100
Message-ID: <20241211162720.320070-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 .gitlab-ci.d/static_checks.yml                | 24 +++++++++++++++++++
 .../dockerfiles/fedora-rust-nightly.docker    |  4 ++++
 tests/lcitool/refresh                         |  4 ++++
 3 files changed, 32 insertions(+)

diff --git a/.gitlab-ci.d/static_checks.yml b/.gitlab-ci.d/static_checks.yml
index ad9f426a52f..c0ba4533826 100644
--- a/.gitlab-ci.d/static_checks.yml
+++ b/.gitlab-ci.d/static_checks.yml
@@ -46,3 +46,27 @@ check-python-tox:
     QEMU_JOB_OPTIONAL: 1
   needs:
     job: python-container
+
+check-rust-tools-nightly:
+  extends: .base_job_template
+  stage: test
+  image: $CI_REGISTRY_IMAGE/qemu/fedora-rust-nightly:$QEMU_CI_CONTAINER_TAG
+  script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start test "Running Rust code checks"
+    - cd build
+    - pyvenv/bin/meson devenv -w ../rust ${CARGO-cargo} fmt --check
+    - make clippy
+    - make rustdoc
+    - section_end test
+  variables:
+    GIT_DEPTH: 1
+  allow_failure: true
+  needs:
+    - job: build-system-fedora-rust-nightly
+      artifacts: true
+  artifacts:
+    when: on_success
+    expire_in: 2 days
+    paths:
+      - rust/target/doc
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
2.47.1


