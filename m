Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B397C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 21:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMZS8-0004tc-Qc; Tue, 03 Jun 2025 17:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS5-0004tE-Ki
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uMZS0-00065l-TJ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 17:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748987140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zkj45g1a0czvtLZjGoji78CoCfioZAX7u5QHfK6wwwM=;
 b=LvMWDSswz9ZlevzmHT1cOqQdUGZyYMOch6QnTNRZhtSBmLIbleDvORw7Gszhrck1m9E8CQ
 iXxZKDqRefpexWSovanDZ1GMKgMY8rO9GLORrsvqtDG1NyrPZ45Rc6W/AJrRftkz47DDPG
 qlXuej8A8P760nh42L9a0HinrKsa7bc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-A-TVhQIuPgC2-izKZbBwug-1; Tue, 03 Jun 2025 17:45:38 -0400
X-MC-Unique: A-TVhQIuPgC2-izKZbBwug-1
X-Mimecast-MFC-AGG-ID: A-TVhQIuPgC2-izKZbBwug_1748987138
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso2940030f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 14:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748987137; x=1749591937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkj45g1a0czvtLZjGoji78CoCfioZAX7u5QHfK6wwwM=;
 b=jSsAcWXseuvjdsU6ON29aN30VwKQKQkixw+4HHpzbWwTl8+AVAiGVd8QxWlvCWA/IS
 snkjJPj7bJ54HFQ3tz4/mgSgJRfCcA577V/Zl6g6RF7qo48VFJFYyRp+7WzmrovEJJMm
 SWr+7DGA/qk1pBpes/ULUrwum6eKrqNh8krZIorycWLQRIBMz3Ncv+W2D5cOPzag69Z+
 8Of+2k5kVYN2822wF0UqTS+w1AwhvAbEG0W4QTSjUya7gXRB95p6ZuiCImUkwc7gCpqG
 0ctIpiLO+8OGeA+C3g4ulzoxN6eK2gbcQyIyRHwreRu4CsiG8NIHcXkncOqzc6AmbGDl
 A84g==
X-Gm-Message-State: AOJu0Yw2tviTI9JM57xSMNHtxejnwsBKtKsjthL278/sb+F8SoRQrNZG
 MSAN7iB+oKK7vC+NTKom2llc4G/xfmVQBT8RrV5MP+ADCtdiXcYN6vB+kLb7Q2yLuVFwwQlP71g
 TUGweLfTfBTvg73degLkArczmeGrt9YpL5eLMnWCZu6xTZQzVxM361GjucV44T1+t0Hhyr2CBa9
 r4DyuQ3Dl+5yb/Sz9e7sQ8Gl3IhSWLas2IDH2jBixt
X-Gm-Gg: ASbGnctS0ZM8HEfVyTDAyP3yEYpOa6+GqsgUWy/IejKyo9GhZPeKVVC1WjIVGyptq5G
 5XKkrOKyVhFGvehwXiOZIrHDDHpn1CLeFKjCPMuULz3rJqE5ijsLL0BiJZyIzDMDkjfw9i/geXr
 U4zTV51WN0tOzNjFdglC/sN7vatrhfaC15lllufHaAkJrhTVntTXZuH6duQbyYraolcE3JeU/HZ
 t8EPHjz6n893uxXRnFjEDlsFMJWdBy0qG18oOZgRAYrcngd9/6LPDp+siUKcQnyB+sSXJzSSvgQ
 hM/L21mjVPAIZhqmC5ZvHiCa
X-Received: by 2002:a05:6000:4023:b0:3a4:e706:532b with SMTP id
 ffacd0b85a97d-3a51d9747a0mr237658f8f.43.1748987136902; 
 Tue, 03 Jun 2025 14:45:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4QVaD745zny/ZiJV2op78IhdXBGfTRbEnEbDXo804pp45wUc9bDkVY0DMr6HpScj/MuHNJw==
X-Received: by 2002:a05:6000:4023:b0:3a4:e706:532b with SMTP id
 ffacd0b85a97d-3a51d9747a0mr237644f8f.43.1748987136424; 
 Tue, 03 Jun 2025 14:45:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb0654sm175023525e9.21.2025.06.03.14.45.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 14:45:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/16] rust: add qemu-api doctests to "meson test"
Date: Tue,  3 Jun 2025 23:45:12 +0200
Message-ID: <20250603214523.131185-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603214523.131185-1-pbonzini@redhat.com>
References: <20250603214523.131185-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Doctests are weird.  They are essentially integration tests, but they're
"ran" by executing rustdoc --test, which takes a compiler-ish
command line.  This is supported by Meson 1.8.0.

Because they run the linker and need all the .o files, run them in the
build jobs rather than the test jobs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst                 |  2 ++
 .gitlab-ci.d/buildtest-template.yml |  3 ++-
 .gitlab-ci.d/buildtest.yml          | 11 +++--------
 rust/qemu-api/meson.build           |  9 +++++++++
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 11328c05b45..f66f2bef60b 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -66,6 +66,8 @@ be run via ``meson test`` or ``make``::
 
    make check-rust
 
+Note that doctests require all ``.o`` files from the build to be available.
+
 Supported tools
 '''''''''''''''
 
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 118371e377d..fea4e8da2f1 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -76,7 +76,8 @@
       fi
     - section_end buildenv
     - section_start test "Running tests"
-    - $MAKE NINJA=":" $MAKE_CHECK_ARGS
+    # doctests need all the compilation artifacts
+    - $MAKE NINJA=":" MTESTARGS="--no-suite doc" $MAKE_CHECK_ARGS
     - section_end test
 
 .native_test_job_template:
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index ca1a9c6f709..d888a600637 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -41,7 +41,7 @@ build-system-ubuntu:
     IMAGE: ubuntu2204
     CONFIGURE_ARGS: --enable-docs --enable-rust
     TARGETS: alpha-softmmu microblazeel-softmmu mips64el-softmmu
-    MAKE_CHECK_ARGS: check-build
+    MAKE_CHECK_ARGS: check-build check-doc
 
 check-system-ubuntu:
   extends: .native_test_job_template
@@ -115,7 +115,7 @@ build-system-fedora:
     CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg --enable-rust
     TARGETS: microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
-    MAKE_CHECK_ARGS: check-build
+    MAKE_CHECK_ARGS: check-build check-doc
 
 build-system-fedora-rust-nightly:
   extends:
@@ -127,12 +127,7 @@ build-system-fedora-rust-nightly:
     IMAGE: fedora-rust-nightly
     CONFIGURE_ARGS: --disable-docs --enable-rust --enable-strict-rust-lints
     TARGETS: aarch64-softmmu
-    MAKE_CHECK_ARGS: check-build
-  after_script:
-    - source scripts/ci/gitlab-ci-section
-    - section_start test "Running Rust doctests"
-    - cd build
-    - pyvenv/bin/meson devenv -w ../rust ${CARGO-cargo} test --doc -p qemu_api
+    MAKE_CHECK_ARGS: check-build check-doc
 
   allow_failure: true
 
diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 62068352b0b..b532281e8c0 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -45,6 +45,15 @@ rust.test('rust-qemu-api-tests', _qemu_api_rs,
 qemu_api = declare_dependency(link_with: [_qemu_api_rs],
   dependencies: [qemu_api_macros, qom, hwcore, chardev, migration])
 
+# Doctests are essentially integration tests, so they need the same dependencies.
+# Note that running them requires the object files for C code, so place them
+# in a separate suite that is run by the "build" CI jobs rather than "check".
+rust.doctest('rust-qemu-api-doctests',
+     _qemu_api_rs,
+     protocol: 'rust',
+     dependencies: qemu_api,
+     suite: ['doc', 'rust'])
+
 test('rust-qemu-api-integration',
     executable(
         'rust-qemu-api-integration',
-- 
2.49.0


