Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51152E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:50:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvMP-0004kx-DV; Wed, 04 Dec 2024 14:48:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIvMN-0004ka-9N
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:48:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tIvML-0000kR-RZ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733341709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nJthT6e/Pqvou+fw6hbat5zS++X5MHIYNr2IUczZZog=;
 b=YoV3Wow5vmw6OkhWnHGvv5T7TQTBAAnLMtq0nGyzT/De57D6WoXyP0f7LyRM44e41fyNaX
 PAuzgRF4INfk/AyKLe+H3DJGGNTtcIaKYr0MEAhX7IIrqpohiM4ROkl9rqk9vbM2Tb5E1k
 ohg7nUt/XXv9sr+vDssBqXE53uS2Hwc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-UlkCUscVOnSgQTdRNml8XA-1; Wed,
 04 Dec 2024 14:48:25 -0500
X-MC-Unique: UlkCUscVOnSgQTdRNml8XA-1
X-Mimecast-MFC-AGG-ID: UlkCUscVOnSgQTdRNml8XA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 88B5E1954AFF; Wed,  4 Dec 2024 19:48:24 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.92])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91AEE19560A2; Wed,  4 Dec 2024 19:48:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 5/7] gitlab: enable ccache with Cirrus CI
Date: Wed,  4 Dec 2024 19:48:05 +0000
Message-ID: <20241204194807.1472261-6-berrange@redhat.com>
In-Reply-To: <20241204194807.1472261-1-berrange@redhat.com>
References: <20241204194807.1472261-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add rules to configure the use of ccache with Cirrus CI jobs,
and preserve the cache across jobs.

The HomeBrew PATH was already present, but incorrect, while
the FreeBSD PATH was missing.

About 1 GB is enough to get a 99% hit rate on a pristine rebuild
with no code changes. Setting it much higher than this will
trigger ENOSPC problems on the FreeBSD builders due to limited
disk size.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/cirrus.yml       | 3 ++-
 .gitlab-ci.d/cirrus/build.yml | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 2bd3cb35c9..af20082a01 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -43,6 +43,7 @@ x64-freebsd-14-build:
     UPDATE_COMMAND: pkg update; pkg upgrade -y
     INSTALL_COMMAND: pkg install -y
     CLEAN_COMMAND: pkg clean -y --all
+    PATH_EXTRA: /usr/local/libexec/ccache
     CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu
     TEST_TARGETS: check
 
@@ -56,7 +57,7 @@ aarch64-macos-build:
     UPDATE_COMMAND: brew update
     INSTALL_COMMAND: brew install
     CLEAN_COMMAND: brew cleanup --prune=all
-    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
+    PATH_EXTRA: /opt/homebrew/opt/ccache/libexec:/opt/homebrew/gettext/bin
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index d26a2a788c..5c86278bf8 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -5,6 +5,7 @@
 
 env:
   CIRRUS_CLONE_DEPTH: 1
+  CCACHE: "@CCACHE@"
   CI_REPOSITORY_URL: "@CI_REPOSITORY_URL@"
   CI_COMMIT_REF_NAME: "@CI_COMMIT_REF_NAME@"
   CI_COMMIT_SHA: "@CI_COMMIT_SHA@"
@@ -27,7 +28,14 @@ build_task:
     - git clone --depth 100 "$CI_REPOSITORY_URL" .
     - git fetch origin "$CI_COMMIT_REF_NAME"
     - git reset --hard "$CI_COMMIT_SHA"
+  obj_cache:
+    folder: ccache
   step_script:
+    - export CCACHE_BASEDIR="$(pwd)"
+    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
+    - export CCACHE_MAXSIZE="1000M"
+    - ccache --zero-stats
+    - ccache --show-stats
     - mkdir build
     - cd build
     - ../configure --enable-werror $CONFIGURE_ARGS
@@ -38,6 +46,7 @@ build_task:
         $MAKE -j$(sysctl -n hw.ncpu) $TARGET V=1 ;
       done
     - find . -not -path 'meson-logs/*' -delete
+    - ccache --show-stats
   always:
     build_result_artifacts:
       path: build/meson-logs/*log.txt
-- 
2.46.0


