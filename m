Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D3DE7FDC3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzt5-0000IS-VZ; Mon, 02 Feb 2026 14:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzsv-0000Ce-EH; Mon, 02 Feb 2026 14:46:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzst-0003D3-R6; Mon, 02 Feb 2026 14:46:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E3A9D185097;
 Mon, 02 Feb 2026 22:46:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9605135B279;
 Mon, 02 Feb 2026 22:46:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 05/69] tests/docker: handle host-arch selection for
 all-test-cross
Date: Mon,  2 Feb 2026 22:45:28 +0300
Message-ID: <20260202194638.939438-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

When building on non-x86 we get a bunch but not all of the compilers.
Handle this in the Dockerfile by probing the arch and expanding the
list available.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-14-alex.bennee@linaro.org>
(cherry picked from commit 6da616bb17004f9332b2798353ebef88cac61cc2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index 5aa43749eb..ef69bbc8a5 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -23,7 +23,9 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         bison \
         ccache \
         clang  \
+        dpkg-dev \
         flex \
+        gcc \
         git \
         libclang-rt-dev \
         ninja-build \
@@ -33,16 +35,11 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         python3-venv \
         python3-wheel
 
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
-        apt install -y --no-install-recommends \
-        gcc-aarch64-linux-gnu \
+# All the generally available compilers
+ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
         libc6-dev-arm64-cross \
         gcc-arm-linux-gnueabihf \
         libc6-dev-armhf-cross \
-        gcc-hppa-linux-gnu \
-        libc6-dev-hppa-cross \
-        gcc-m68k-linux-gnu \
-        libc6-dev-m68k-cross \
         gcc-mips-linux-gnu \
         libc6-dev-mips-cross \
         gcc-mips64-linux-gnuabi64 \
@@ -51,18 +48,25 @@ RUN DEBIAN_FRONTEND=noninteractive eatmydata \
         libc6-dev-mips64el-cross \
         gcc-mipsel-linux-gnu \
         libc6-dev-mipsel-cross \
-        gcc-powerpc-linux-gnu \
-        libc6-dev-powerpc-cross \
-        gcc-powerpc64-linux-gnu \
-        libc6-dev-ppc64-cross \
         gcc-powerpc64le-linux-gnu \
         libc6-dev-ppc64el-cross \
         gcc-riscv64-linux-gnu \
         libc6-dev-riscv64-cross \
         gcc-s390x-linux-gnu \
-        libc6-dev-s390x-cross \
-        gcc-sparc64-linux-gnu \
-        libc6-dev-sparc64-cross && \
+        libc6-dev-s390x-cross
+
+RUN if dpkg-architecture -e amd64; then \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
+  fi && \
+  echo "compilers: ${AVAILABLE_COMPILERS}"
+
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+        apt install -y --no-install-recommends \
+        ${AVAILABLE_COMPILERS} && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
 
 
-- 
2.47.3


