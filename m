Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B20C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLOy-0008VX-5c; Thu, 04 Jul 2024 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNq-0007rw-2A
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:20 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sPLNl-0002S6-8j
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 08:16:17 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ee91d9cb71so1391331fa.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720095369; x=1720700169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+7NsildlwdPQvya89L8R2V+Gz+X4TQT3UR+alA0+QE=;
 b=mZBjo+c09hxXAhZkEXBUDNp5knnbh8yEgHdn5jGmztCw7MqbIJ/+7oISi4ZGnUAx9x
 l+mHd9eT0LLg6Ufy+tAmtsvNSm9tAIym37wPNa2evWF+e4sqJTeo2G2wCVfzKLJtXksi
 LkIPAHeI+h8dQocaXiwoxAPwj8WPV4Z9RBmKD4zmgZBrmgPi+Va9jo1xL/neSkfxdCBt
 XwE85e5x64laAwh3nDKUL3NbXbbwK6ObV1SHD3IuObH6MkwvWW1H7OP9/Wl9DRt4p2Xp
 NDfrV9c22qurGTZNUReEZh/PUtZKYgIhVcDM8BdC3dv5WdEwqYsfs02Wt872xYVzy1bQ
 2KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720095369; x=1720700169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+7NsildlwdPQvya89L8R2V+Gz+X4TQT3UR+alA0+QE=;
 b=bch5AJBcXMsXBk+h3M0usijiX/xtn5YshvbFsgBAhSkLiKWth12M9vi9At9K6D0bK3
 J2zVyGU8QhdE9PcVoNls17upnNm1xhgoaYWQLczv6CMzlgHhnzTHqzOKZhb2MFYQYebZ
 y6ZoA6rLOgTs5s0AiKDprK1J7RkpzcMGvaAd9J1mbgROQVFf7nBB0L2FoifxgSmD1dbq
 ZI+M1OBwfc3DqvstXyqVZHC6AdlwW9z+KqRypywXIoMfNqsORNZN/1KMf+P59AhySeSg
 ugzNKRdpIrBgsyI6otV86rnUSC4n+Ivf4mBaqoWXjZahHKJd/fxMdbXGO6IVX604eHjO
 oQaQ==
X-Gm-Message-State: AOJu0YyCMqiPhIov++VERC75t3KTQADIpmfnUNmILYsE0f9FEIC1Yrua
 weGFuSWiYhGtzU4ekxFXBDZICWec9u0nXkYtjDDVp+/GFL3AvhsrEXf0b9asFM2n4yG6NXRfHbe
 1pYs=
X-Google-Smtp-Source: AGHT+IGywjsHMPfl5vR3+VrjMeCv32eUtm9GB5lycr+SGGsxF6qtGyeWiyAbXxg006XO55Zo5i31Tg==
X-Received: by 2002:a2e:be0f:0:b0:2ec:5699:5e6 with SMTP id
 38308e7fff4ca-2ee8ed9fc91mr12525301fa.26.1720095369553; 
 Thu, 04 Jul 2024 05:16:09 -0700 (PDT)
Received: from localhost.localdomain (adsl-241.37.6.160.tellas.gr.
 [37.6.160.241]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm22471015e9.32.2024.07.04.05.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 05:16:09 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH v4 6/7] DO NOT MERGE: add rustdoc build for gitlab pages
Date: Thu,  4 Jul 2024 15:15:42 +0300
Message-ID: <a65a7353c4e2990b11ef68555fbaec7391be9719.1720094395.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Deploy the generated rustdocs for my personal rust qemu fork on gitlab.

The URL is:

https://rust-for-qemu-epilys-aebb06ca9f9adfe6584811c14ae44156501d935ba4.gitlab.io/pl011/index.html

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 64 +++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 19 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 0eec570310..a2fedc87bd 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -716,31 +716,57 @@ build-tools-and-docs-debian:
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
+    - rustup component add rustfmt
+    - DEBIAN_FRONTEND=noninteractive apt-get update -y
+    - DEBIAN_FRONTEND=noninteractive apt-get install -y python3-venv meson libgcrypt20-dev zlib1g-dev autoconf automake libtool bison flex git libglib2.0-dev libfdt-dev libpixman-1-dev ninja-build make libclang-14-dev
+    - cargo install bindgen-cli
+    - mkdir ./build/
+    - cd ./build/
+    - ../configure --enable-system --disable-kvm --target-list=aarch64-softmmu --enable-with-rust
+    - ninja "bindings-aarch64-softmmu.rs"
+    - cp ./bindings-aarch64-softmmu.rs ../rust/qemu-api/src/bindings.rs.inc
+    - cd ../rust/pl011/
+    - cargo tree --depth 1 -e normal --prefix none | cut -d' ' -f1  | xargs
+      printf -- '-p %s\n'  | xargs cargo doc --no-deps --document-private-items --target x86_64-unknown-linux-gnu
+    - cd ./../..
+    - mv ./rust/pl011/target/x86_64-unknown-linux-gnu/doc ./public
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


