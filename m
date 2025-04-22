Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DA8C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 05:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u76Hc-0002V9-EA; Tue, 22 Apr 2025 01:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76DR-0003hP-Mm; Tue, 22 Apr 2025 01:30:42 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u76DP-0008Dn-Ke; Tue, 22 Apr 2025 01:30:41 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-226185948ffso52644125ad.0; 
 Mon, 21 Apr 2025 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745299837; x=1745904637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=239sog6AsGRpOuiETXgLR1hsZQlcMmDhDGFK29CX7lo=;
 b=Nm14sWB+0ElN92Tt/rcIVbC5IdeubZ5zskez8sBibMdZc1MYuQWRU6HffS2EhIYGWx
 qor/fBG2KqibUimyUoYOqF+grewuWbPGokv98mKwRKY7bLYsH05fojreX0kQfjoL1PcA
 MJVxFDkhMVwgo7+aIdUe27AIw1wFl/sIoKu0wYd9aWzPsIeQEBQxZDuWSGNTMRMXZSY+
 xH6KH0fTNGJaq9V9YeVM8cOjIGgsJAbozTOGLUZsx4qbCJXPsDqDGvL/bafYE002FMTk
 2rQloAN1LT32OJDKKWq4x5Sj14G0FQAArjU+13uPRKVtAprps/VPyBkxHZJOvheS/e5k
 jQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745299837; x=1745904637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=239sog6AsGRpOuiETXgLR1hsZQlcMmDhDGFK29CX7lo=;
 b=aPJPr355TUpmtcCXsWlO/HgKu1JQky0l23/JeK1W+G8HHhBk389aRsKflOsE8UB+XW
 5oyIW8Zepf6Pd8ZmAt+Fop2Q0egxO6iwLLVB/99H6gchj6Zyk9Y54jrd2gixzAkV/P73
 3nBDH8CkDweP0iYVYjXgeHtMtS/ZqAH1/HPEPpmqw032XjULxdo263znGsslyanKt9rn
 uPxF8aSuFUECgK+mNVOpl/NALs4442DC2oiasp2OHtleamjls0MaDJtZDiHHY1VmTQA7
 07G9amHNxIvQaf76X7BSjXyB67SXRe4Halk8IBRQ2O8xmk2A2kX2ZPuS3Meszr4xS7Ty
 5Iyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU13+eHHqKnM4HB5XEfUNuA+0Y3O2zSmSYgA5ITcMafNQu6vds9oDJ0EwiaJ63SafyoiQp+RaxYrJzMmA==@nongnu.org,
 AJvYcCVPPzhQLj/lFqcV8XHTpfBHJnkCgt6mimRvx2DJAMJ+qmuy5l6KDwm4HidLB+DJTMRfCXynY+N79Q==@nongnu.org,
 AJvYcCVYR/0qlsWYwIMsRLFgnuqw1ejIoxtNwgTWdLxFxa6yX1IH2NhEg1uGA6I4sqAp8oIsumPFM1dqBwI=@nongnu.org,
 AJvYcCXCQEdF+DufTuwP6Zg/k/s3oLhHRITiKlhROvkxLTSs+L4iU0Oj7Krb9hx0qv+6ARvuglLJJrBhxDw3Pw==@nongnu.org
X-Gm-Message-State: AOJu0YzARfbdlKppOsmJ+3uTAgjirYjQK1WD1Oz4UUudJ3C/kWqSK/+a
 6KttR49YbiHKO9ZxQkhoG7iEd9i8b2xGeVsjj35giNQ5IG0iP8p2mYbxWd2b
X-Gm-Gg: ASbGncu5XYkKV/7EQriyk2lhYzxoL9/SfVXJGXtrRY+RRgsnSIYqabOD7YeML7ELKZ7
 xq2DG7j91l07EM3jyM5CnNJZHEy2pn17Y5XaCKqBz9pAzDx0d+NOx8Sv4nQ7WPQBWoQ5GEyajHz
 +TASo3lYpfhOlO9ZPWe1zNfR7l8GYvjX4M/EWF2j+QDtNeMFwNWvRs7/J77atILmgkj10j7P6Vq
 eT/uPDuoy0R/04+P/hhHKyOJj/2/EoVrUTtiytakXVE5WsJj/h4aPLijIU0+LJij5QPiWxut/Zc
 CwRr0CGx1ui7ymyNq/IMCPqWFGtTSx5EaBooxw7P+n1xYu2AhfrkuQQ7uR+CMmv/KhiETw==
X-Google-Smtp-Source: AGHT+IGGRtHx5fim4xGmJq6v8vkziresfB5+BAuQyo6/891rk0skJGXxaEivPZeVzgS3/6wX99cASQ==
X-Received: by 2002:a17:903:22c9:b0:220:ff3f:6cc0 with SMTP id
 d9443c01a7336-22c536080bemr230986565ad.38.1745299836831; 
 Mon, 21 Apr 2025 22:30:36 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:e142:4a4f:1ebb:3ca4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb4483sm75692085ad.118.2025.04.21.22.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 22:30:36 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v2 20/20] gitlab: Enable CI for wasm build
Date: Tue, 22 Apr 2025 14:27:24 +0900
Message-Id: <a9ae4d0fbcde4d837e55c07715a169bcde495895.1745295397.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1745295397.git.ktokunaga.mail@gmail.com>
References: <cover.1745295397.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add GitLab CI job that builds QEMU using emscripten. The build runs in the
container defined in tests/docker/dockerfiles/emsdk-wasm32-cross.docker.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 .gitlab-ci.d/buildtest-template.yml | 27 +++++++++++++++++++++++++++
 .gitlab-ci.d/buildtest.yml          |  9 +++++++++
 .gitlab-ci.d/container-cross.yml    |  5 +++++
 3 files changed, 41 insertions(+)

V2:
- Split the Dockerfile addition from the previous 18th patch into a separate
  commit.

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 39da7698b0..67167d68a5 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -126,3 +126,30 @@
     - du -chs ${CI_PROJECT_DIR}/*-cache
   variables:
     QEMU_JOB_AVOCADO: 1
+
+.wasm_build_job_template:
+  extends: .base_job_template
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
+  before_script:
+    - source scripts/ci/gitlab-ci-section
+    - section_start setup "Pre-script setup"
+    - JOBS=$(expr $(nproc) + 1)
+    - section_end setup
+  script:
+    - du -sh .git
+    - mkdir build
+    - cd build
+    - section_start configure "Running configure"
+    - emconfigure ../configure --disable-docs
+          ${TARGETS:+--target-list="$TARGETS"}
+          $CONFIGURE_ARGS ||
+      { cat config.log meson-logs/meson-log.txt && exit 1; }
+    - if test -n "$LD_JOBS";
+      then
+        pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
+      fi || exit 1;
+    - section_end configure
+    - section_start build "Building QEMU"
+    - emmake make -j"$JOBS"
+    - section_end build
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 00f4bfcd9f..0f92d5313a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -801,3 +801,12 @@ coverity:
       when: never
     # Always manual on forks even if $QEMU_CI == "2"
     - when: manual
+
+build-wasm:
+  extends: .wasm_build_job_template
+  timeout: 2h
+  needs:
+    job: wasm-emsdk-cross-container
+  variables:
+    IMAGE: emsdk-wasm32-cross
+    CONFIGURE_ARGS: --static --disable-tools --enable-debug --enable-tcg-interpreter
diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
index 34c0e729ad..3ea4971950 100644
--- a/.gitlab-ci.d/container-cross.yml
+++ b/.gitlab-ci.d/container-cross.yml
@@ -94,3 +94,8 @@ win64-fedora-cross-container:
   extends: .container_job_template
   variables:
     NAME: fedora-win64-cross
+
+wasm-emsdk-cross-container:
+  extends: .container_job_template
+  variables:
+    NAME: emsdk-wasm32-cross
-- 
2.25.1


