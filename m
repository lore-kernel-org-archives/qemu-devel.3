Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F65DC25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 06:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU3E-0003HN-Rh; Mon, 27 May 2024 02:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2k-00030Y-V9; Mon, 27 May 2024 02:41:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2i-0007Gf-RM; Mon, 27 May 2024 02:41:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7E07A6A3F0;
 Mon, 27 May 2024 09:41:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CAA90D83E8;
 Mon, 27 May 2024 09:40:56 +0300 (MSK)
Received: (nullmailer pid 50264 invoked by uid 1000);
 Mon, 27 May 2024 06:40:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Palmer Dabbelt <palmer@rivosinc.com>,
 Bin Meng <bmeng@tinylab.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 02/19] gitlab/opensbi: Move to docker:stable
Date: Mon, 27 May 2024 09:40:33 +0300
Message-Id: <20240527064056.50205-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
References: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Palmer Dabbelt <palmer@rivosinc.com>

The OpenSBI build has been using docker:19.03.1, which appears to be old
enough that v2 of the manifest is no longer supported.  Something has
started serving us those manifests, resulting in errors along the lines
of

    $ docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA --tag $IMAGE_TAG .gitlab-ci.d/opensbi
    Step 1/7 : FROM ubuntu:18.04
    18.04: Pulling from library/ubuntu
    mediaType in manifest should be 'application/vnd.docker.distribution.manifest.v2+json' not 'application/vnd.oci.image.manifest.v1+json'

This moves to docker:stable, as was suggested by the template.  It also
adds the python3 package via apt, as OpenSBI requires that to build.

Reviewed-by: Bin Meng <bmeng@tinylab.org>
Message-ID: <20230303202448.11911-2-palmer@rivosinc.com>
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
(cherry picked from commit 7bc1286b81d4e8380b3083beed1771c67ce87af3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/opensbi.yml b/.gitlab-ci.d/opensbi.yml
index 04ed5a3ea1..9a651465d8 100644
--- a/.gitlab-ci.d/opensbi.yml
+++ b/.gitlab-ci.d/opensbi.yml
@@ -42,9 +42,9 @@
 docker-opensbi:
   extends: .opensbi_job_rules
   stage: containers
-  image: docker:19.03.1
+  image: docker:stable
   services:
-    - docker:19.03.1-dind
+    - docker:stable-dind
   variables:
     GIT_DEPTH: 3
     IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
diff --git a/.gitlab-ci.d/opensbi/Dockerfile b/.gitlab-ci.d/opensbi/Dockerfile
index 4ba8a4de86..5ccf4151f4 100644
--- a/.gitlab-ci.d/opensbi/Dockerfile
+++ b/.gitlab-ci.d/opensbi/Dockerfile
@@ -15,6 +15,7 @@ RUN apt update \
         ca-certificates \
         git \
         make \
+	python3 \
         wget \
     && \
     \
-- 
2.39.2


