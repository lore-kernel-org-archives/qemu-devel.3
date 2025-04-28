Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCABC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IEK-0000Uh-JK; Mon, 28 Apr 2025 02:44:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IC8-0005ON-Nm; Mon, 28 Apr 2025 02:42:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IC6-0007Ji-2H; Mon, 28 Apr 2025 02:42:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2255003f4c6so46525155ad.0; 
 Sun, 27 Apr 2025 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822538; x=1746427338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNwwwrl7RJR+XvFix+3I8P23cqfaFaCyk2+AY4/Mz0Q=;
 b=b6UjC7yEPDcWuJlqAwtxPpquY2jFt/1mTP3AsYsEDDLmV5oqbgatRz15defEfpU69p
 AVlql5+g51pTiFtZAVIIC2a6M61wLdn696BH48ARSyUf/ISVA+zICLVbdV/jm2mxna5Y
 LCdvPZXikQKK1SQ6MhMLuMSEvR4PT4QK4wTwbRkVmQ3gz6Jd3C46h7DNuqAXE78vyggU
 Cig2x/+EgJyfRv8owh1musJkMRjCi84/dSiqLtxvWMbf0TPPKlnf17DjJOjDNhXtfmWV
 NpWmj76nu3NWwIEl2NYi+x7aQ78cpVrn4KIO8ZZX3AMUl6VYnwHm5wB+zFwPaUBxcMP/
 iFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822538; x=1746427338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNwwwrl7RJR+XvFix+3I8P23cqfaFaCyk2+AY4/Mz0Q=;
 b=UhG/mEWWwe4ysuhBDk34RIOIPRQbCKeGWx0KTwwi3RVCgBdlFY8MGJnp30DyvX/yPk
 Cxnx4ZaijDtaIl3e+OCrNxPwyYWET94P3xsdyBR3J5oAtLTe1McIyk7JUg8tR77Nkiv9
 OLoZ5hmQbN67a4ilycL4pYK4UECx7diJ6cTD9PMFB7oDYLztrxQa17n8wErDX+5G3F7B
 LQ5d0WQzfOsrDE803gZnPOaJRcGJzfHW7ktXeTu+WcdbJ3Qf4o0fuZ1Yh6eFh/O6bKhV
 m6QMGYw7N2xtDGR+YqMFyOZnrX+bDiXrv52ZDFmWw3kB63oilvoO5WK38Usym06OEMQe
 S8Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKowEXJWSU7ieajXF5vkMbIZvm9u/krK1GQS+naIvgWDNKwNmvg5ibi0fpZqL+sor4o022RcuZNKw=@nongnu.org,
 AJvYcCVLxNMEjyTFAB0EY4bHJZdAPCdCg4vSxR3p9Gf1ERWTdjrTSlr/JYl85I+QKPPEGCfADhfp+1jlN4vT+g==@nongnu.org,
 AJvYcCVf3e0CVdXCXeTRBLujdWPJ3FTdOKzVZv3Yl3lQJiOez3iMhojTK2U5hVwBAouXyKM9UrAwSl0WQg==@nongnu.org,
 AJvYcCW6myqQF7MA+FoATSvk6Z/Hc2MuWl6SJR1o9BKihkBotf1liEBtt5/2Mq7+DIbPxRCW8Su9x0PB79I0xw==@nongnu.org
X-Gm-Message-State: AOJu0YxjBBVcspYOUVZGHs/TwbnCzB2YBgtA4KOZwThtkaxPBIn7ROW8
 NCy0/5CW46LMSckPrfyywsD+PLXIa3ChHGpm7IUY7b6D3DpEuWm1Zus8x43W
X-Gm-Gg: ASbGncsjhr5qynAWMO4WKiM0jxCe5803ROOHenPNb0wHsoJNoEiJFIzNWdJlavYiaof
 pS+VETyLkrK45/YzIP/qGXtBHL/nlaJaw+W2xzyNSOrFul/l1kHgMxuknJk8w6i68/Lh9VB5Vmu
 xsL6CjElbXD1PrPXXvHBNyUSdl0I4Y1mSAAbVlko+AhhvKh25BKD1eI/VXfFYNn5c87tzTURWpt
 sxZ0+PRUS4I7US5fm0e50XLYGBUYHgUr9H8PgdLaRfVP94dqMIn2JUhuvhIWyL8LMVULA6qHSpz
 9DQd2oFRrMfshG+GtfiwDhCgdeColNK8u2tnlQ==
X-Google-Smtp-Source: AGHT+IF/xXTCDS8WdC2brXQez0mtJvz1TNNEJoWG1hHdw+LzWmlY4pW7cKPvxEKlwQLmoKbFi2G22A==
X-Received: by 2002:a17:902:ce8f:b0:224:b60:3cd3 with SMTP id
 d9443c01a7336-22dbf5f080dmr158540675ad.19.1745822538187; 
 Sun, 27 Apr 2025 23:42:18 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:42:17 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
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
Subject: [PATCH v3 20/20] gitlab: Enable CI for wasm build
Date: Mon, 28 Apr 2025 15:39:09 +0900
Message-ID: <ade0deb2dc65618a91755590f6729485b4001b94.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x629.google.com
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

V3:
- Resolved patch conflicts against the latest upstream master branch.

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index d4f145fdb5..118371e377 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -115,3 +115,30 @@
     - du -chs ${CI_PROJECT_DIR}/*-cache
   variables:
     QEMU_JOB_FUNCTIONAL: 1
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
index 431bc07d8f..248aaed137 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -792,3 +792,12 @@ coverity:
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
2.43.0


