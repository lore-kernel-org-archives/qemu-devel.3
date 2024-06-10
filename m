Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB5CC27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjgH-0000XD-HL; Mon, 10 Jun 2024 14:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGjg9-0000Sy-Jy
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:23:38 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sGjg7-0006BE-Qy
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:23:37 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52c32d934c2so2343196e87.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718043814; x=1718648614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNSC7+YfInJHGM0e7SPiMj3ud9COeB0Hq7ik61VnjtI=;
 b=p/ysV9c6Tmwk/MXttyiTrUESc2p0lhWyvDXomO7g9gXj5xstexzt0ultOyTzSXBv6X
 JA/18KDk+PJw4OetYQXa4DbBUmUqm88WOxq4Imvszbc1fEYjDJSUwZ0weYGpICsgSx2D
 7himaAIadlPcOn4B5igq2A4PS+XWQjmAoQaoAt2VAa0sGcC7HlLIF0NnfwGGMfwgnnVz
 DTNei+8/wybcAkMgHZ6zhRoLlHFPN+MupwPKgfySxz2T9/EDRy9ScABigZkO62momKdw
 ek8Q4LJ+LmFJGLAv3bCmJCG0NNSpQYXXy9JZERTbg/05pyZrnRsWMbM3VCdJL/A3/cMt
 Ne+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718043814; x=1718648614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNSC7+YfInJHGM0e7SPiMj3ud9COeB0Hq7ik61VnjtI=;
 b=rNm4Mk9/oXtlVUBlgFzePgeQUPX/hEZlJNV9KE4L/ZsvI8fedeOiPF2lgnY5W5Ky3l
 AYQDQVzR0qiwVVT9g2gEisKtCNiNBKsI4o0LwUHhzb8gqtIvpE3yMjHhnKzrMGBSXORQ
 KJ4jWYIEhikbFX1Ujdg35hgPjam+1+YkHTPYcS+G8kutNXojkcS7filSxe7XDFPRc36+
 Nb4QX90Ok7c/S7rwQutATTDF/8M5/NATT+5XcuAV1gQfLO6NZvNZe+43B/mnh7sccaVX
 +i2qOt7xJHCuNCHFi9l48jpMkZbeia1TkU1NmfhRJWl3dwQSAp/d5e/wT7xfkkPxhEci
 ruQw==
X-Gm-Message-State: AOJu0Yzx1VfyhXPtddrXJXDSwHsODaHDwxFYEyHGnWdSuEiTiExcdvsI
 Z+Sjo/TQrzSB40P3NmCNRO7sRunRZPXU29jXUdB563epvcYauM48GnpnWDDN0DJjg7lutkqI/DB
 yraM=
X-Google-Smtp-Source: AGHT+IE5nH88iEnVnh+LQrhOy51QZPD7zfrVmKdr4lX9tYzkULdz1aJGTGtW4OlHuG04RkjJ0xDZdQ==
X-Received: by 2002:a05:6512:33d3:b0:52c:93b0:3bb with SMTP id
 2adb3069b0e04-52c93b00469mr142637e87.48.1718043813946; 
 Mon, 10 Jun 2024 11:23:33 -0700 (PDT)
Received: from localhost.localdomain (adsl-33.37.6.162.tellas.gr.
 [37.6.162.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42161147811sm135487395e9.18.2024.06.10.11.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 11:23:33 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH v1 3/6] DO NOT MERGE: add rustdoc build for gitlab pages
Date: Mon, 10 Jun 2024 21:22:38 +0300
Message-ID: <01551761cd74fc370eb118b3de1b47dfaf53d4f2.1718040303.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 55 +++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91c57efded..1cd6519506 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -715,31 +715,48 @@ build-tools-and-docs-debian:
 # For contributor forks we want to publish from any repo so
 # that users can see the results of their commits, regardless
 # of what topic branch they're currently using
+# pages:
+#   extends: .base_job_template
+#   image: $CI_REGISTRY_IMAGE/qemu/debian:$QEMU_CI_CONTAINER_TAG
+#   stage: test
+#   needs:
+#     - job: build-tools-and-docs-debian
+#   script:
+#     - mkdir -p public
+#     # HTML-ised source tree
+#     - make gtags
+#     # We unset variables to work around a bug in some htags versions
+#     # which causes it to fail when the environment is large
+#     - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= htags
+#         -anT --tree-view=filetree -m qemu_init
+#         -t "Welcome to the QEMU sourcecode"
+#     - mv HTML public/src
+#     # Project documentation
+#     - make -C build install DESTDIR=$(pwd)/temp-install
+#     - mv temp-install/usr/local/share/doc/qemu/* public/
+#   artifacts:
+#     when: on_success
+#     paths:
+#       - public
+#   variables:
+#     QEMU_JOB_PUBLISH: 1
+# The Docker image that will be used to build your app
 pages:
-  extends: .base_job_template
-  image: $CI_REGISTRY_IMAGE/qemu/debian:$QEMU_CI_CONTAINER_TAG
-  stage: test
-  needs:
-    - job: build-tools-and-docs-debian
+  image: rust:latest
   script:
-    - mkdir -p public
-    # HTML-ised source tree
-    - make gtags
-    # We unset variables to work around a bug in some htags versions
-    # which causes it to fail when the environment is large
-    - CI_COMMIT_MESSAGE= CI_COMMIT_TAG_MESSAGE= htags
-        -anT --tree-view=filetree -m qemu_init
-        -t "Welcome to the QEMU sourcecode"
-    - mv HTML public/src
-    # Project documentation
-    - make -C build install DESTDIR=$(pwd)/temp-install
-    - mv temp-install/usr/local/share/doc/qemu/* public/
+    - cd ./rust/pl011/
+    - cargo tree --depth 1 -e normal --prefix none | cut -d' ' -f1  | xargs
+      printf -- '-p %s\n'  | xargs cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
+    - cd ./../..
+    - mv ./rust/pl011/target/doc ./public
   artifacts:
     when: on_success
     paths:
       - public
-  variables:
-    QEMU_JOB_PUBLISH: 1
+  rules:
+    # This ensures that only pushes to the default branch will trigger
+    # a pages deploy
+    - if: $CI_COMMIT_REF_NAME == $CI_DEFAULT_BRANCH
 
 coverity:
   image: $CI_REGISTRY_IMAGE/qemu/fedora:$QEMU_CI_CONTAINER_TAG
-- 
γαῖα πυρί μιχθήτω


