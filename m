Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1B7C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 17:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJxj0-0005hy-Vp; Tue, 27 May 2025 13:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxiy-0005gZ-NY
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uJxiw-0006hk-Su
 for qemu-devel@nongnu.org; Tue, 27 May 2025 13:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748365462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8BpKjEJltmzcm/OLNaNl+hh0ixQXBWzKCZWpkn3gDY=;
 b=KVzQMfAQ1IIPnC3nL2QfveK9ekMpvk0TZb9goDFwW/k9vuYQM19z1UNKeg4vJkRup7wx50
 DfQQmlCtt9IBIMUSvFnPAHVXzZlD44fU/nre46choWYBGKj5ZrY3N1Hryw1HqdQOYs+peK
 qiuZ2JdNUowKkm9KBWrrbJ2ACEj7I5c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-4bXJiNk-Ol27uMS0vmdbEw-1; Tue, 27 May 2025 13:04:20 -0400
X-MC-Unique: 4bXJiNk-Ol27uMS0vmdbEw-1
X-Mimecast-MFC-AGG-ID: 4bXJiNk-Ol27uMS0vmdbEw_1748365456
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad51ceda1d9so3651566b.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 10:04:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365455; x=1748970255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8BpKjEJltmzcm/OLNaNl+hh0ixQXBWzKCZWpkn3gDY=;
 b=dwr1QQ/rxdzrLNCHiRxPhUJQtwBKmpF3i+vcSxIuU+Zp7n7Ii/iXgmisElw7VD97NS
 9cS7GAYlggflmx+XekFs2ajjQkdo4Uj/zBpXVjagtkxCZ0ZRs3wPHiGnx6Ag4Q909uOY
 gKMcpcNqeK6mD22CQxLVQ0AabrxKBC6pCe+i//cCAyEtlBTKnxThP0gxKm/d02wM2gML
 7/tGZyWDEM5RjSlSmHJUtUwor7xq4WS8ADOqP4RKazrYNRUY9NMnOO/K3aAGFupPQkZt
 zFXVZtEwoFui99V4+RwmreH/xwBSlCiR/SnHStjRnmNxd6TYXarE9kgrbjY2MYKOf0qQ
 4oSg==
X-Gm-Message-State: AOJu0Yz8z4Qlx8q3yPN2MjAevTPJK2j35M05ba7x+yNbKQo5as5IkTdA
 UuooPpxQc+oOmlKe5zi05pCOYBaOSGN9EenPAmAJY7ioZSNpCmO7n57oPIRAyP7n14btij1CQiO
 WUHL5bP2C7thCBC//SCZM4qKZmV2kVO/aPvrSl78/ZLr8s/VNJNPc96axwQtrOiGGowXVKtOXNj
 U1VGHZDw89xptHULdMI/0TF7rLWgumpOTnaV/yvirA
X-Gm-Gg: ASbGncsuRk3AUiO+SXsKcEpYnQBjCIWZ+HdVIjH1T9rqa2eUQ+OMes6uuSkqLrG340I
 HvpFhUJBzvQx84Uq5TwwUc3A/N6QDsa1DgzKM3eDahrrdrthACgmaZMTiCZTTo+JscjxOnG68MT
 KR/EwK22KRv9DKzUG8y1pv8P/voldsPAVw09nsEYe3TLKxywpaU5DWC4SWgwQjkKszpFxcCUt81
 UvqZrKxBYREm8NTVmiPG7zDkK3e9CE/WWMHIWopbuqKZE5UFejU7Shgb9dSsfHB0Yj6YAV0ucQq
 dIP2Uk4PF2vcKQ==
X-Received: by 2002:a17:907:c1e:b0:ad8:55d8:38b7 with SMTP id
 a640c23a62f3a-ad89888d678mr161594266b.7.1748365455260; 
 Tue, 27 May 2025 10:04:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0deVlRLi5YZvAYmuPNc+rsjSmR4hrl2Qq6DmZN5KnWkgeeSH+5FB9M1l5cPVAl4NLDtac2Q==
X-Received: by 2002:a17:907:c1e:b0:ad8:55d8:38b7 with SMTP id
 a640c23a62f3a-ad89888d678mr161588866b.7.1748365454765; 
 Tue, 27 May 2025 10:04:14 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8954b1601sm84478766b.64.2025.05.27.10.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 10:04:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 4/6] rust: add qemu-api doctests to "meson test"
Date: Tue, 27 May 2025 19:04:02 +0200
Message-ID: <20250527170404.1580482-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527170404.1580482-1-pbonzini@redhat.com>
References: <20250527170404.1580482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 248aaed1370..0fdde54bf8e 100644
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
index c647493f712..10e8210f30f 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -44,6 +44,15 @@ rust.test('rust-qemu-api-tests', _qemu_api_rs,
 qemu_api = declare_dependency(link_with: [_qemu_api_rs],
   dependencies: [qemuutil_rs, qemu_api_macros, qom, hwcore, chardev, migration])
 
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


