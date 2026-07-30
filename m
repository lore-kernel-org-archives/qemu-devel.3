Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982A1C54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH7a-0004w5-EF; Wed, 29 Jul 2026 23:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7H-0004hK-Uh
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:29 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH7E-00030u-3h
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=/gX7vydUrF0eZ3CQcu0iax3KTvhaY4aX0Vs4FvDZaLo=; b=hiDBo0GUW2Vf9BD
 EsYmAF1ZqSBzEsQfK98tbpGqce5WYvGTW2OGWK2BHKja4MK5VcoHgB17TAeo+QImoiSUjgWYQIAtO
 XOlV6mlG30Ag16TFELwyJrFA6ahUSLNHDSn3bVjFFGxPxgJJM+IrXioq5kbX8nEcd7PQdFBaZv0Re
 TQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 40/50] test: helper-to-tcg docker tests
Date: Thu, 30 Jul 2026 05:10:14 +0200
Message-ID: <20260730031025.12926-41-anjo@rev.ng>
In-Reply-To: <20260730031025.12926-1-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a docker container with LLVM versions 15-21 and a docker test for
building helper-to-tcg and running end-to-end tests along with running
check-tcg, for testing targets such as Hexagon.

Signed-off-by: Anton Johansson <anjo@rev.ng>
--
NOTE: Last I checked I had some troubles with C++17 support within the
container, was a while ago though.
---
 tests/docker/dockerfiles/debian-llvm.docker | 38 +++++++++++++++++++
 tests/docker/test-helper-to-tcg             | 41 +++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-llvm.docker
 create mode 100755 tests/docker/test-helper-to-tcg

diff --git a/tests/docker/dockerfiles/debian-llvm.docker b/tests/docker/dockerfiles/debian-llvm.docker
new file mode 100644
index 0000000000..7bfc084a34
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-llvm.docker
@@ -0,0 +1,38 @@
+FROM docker.io/library/debian:11-slim
+
+RUN apt update && \
+    DEBIAN_FRONTEND=noninteractive apt install -yy eatmydata && \
+    DEBIAN_FRONTEND=noninteractive eatmydata \
+    apt install -y --no-install-recommends \
+        bison \
+        ca-certificates \
+        flex \
+        gawk \
+        libmpc-dev \
+        libmpfr-dev \
+        libglib2.0-dev \
+        libpixman-1-dev \
+        make \
+        ninja-build \
+        rsync \
+        pkgconf \
+        wget \
+        lsb-release \
+        software-properties-common \
+        gnupg \
+        meson \
+        python3-pip \
+        python3-setuptools \
+        python3-venv \
+        python3-wheel
+
+RUN /usr/bin/pip3 install tomli
+
+RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh
+RUN ./llvm.sh 15 all
+RUN ./llvm.sh 16 all
+RUN ./llvm.sh 17 all
+RUN ./llvm.sh 18 all
+RUN ./llvm.sh 19 all
+RUN ./llvm.sh 20 all
+RUN ./llvm.sh 21 all
diff --git a/tests/docker/test-helper-to-tcg b/tests/docker/test-helper-to-tcg
new file mode 100755
index 0000000000..0c27040d60
--- /dev/null
+++ b/tests/docker/test-helper-to-tcg
@@ -0,0 +1,41 @@
+#!/bin/bash -e
+
+TEST_COMMAND=""
+TARGET_LIST=""
+
+cd "$BUILD_DIR"
+
+# Checks helper-to-tcg builds and passes unit tests
+# for targetted LLVM versions.  Run meson from QEMU source so helper-to-tcg tests can find
+# `tcg-global-mappings.h`.
+for version in {15..21}; do
+    llvm_config=llvm-config-${version}
+    build_dir="${BUILD_DIR}/build-helper-to-tcg-${version}"
+    cxx=$(${llvm_config} --bindir)/clang++
+    [ ! -d ${build_dir} ] && mkdir ${build_dir}
+    CXX=${cxx} meson setup ${build_dir} ${QEMU_SRC}/subprojects/helper-to-tcg -Dllvm_config_path=${llvm_config}
+    meson compile -C ${build_dir}
+    meson test -C ${build_dir} --suite 'helper-to-tcg:helper-to-tcg'
+done
+
+# Runs check-tcg for all LLVM versions
+llvm_config_main=llvm-config-15
+bin_main=$(${llvm_config_main} --bindir)
+cc_main=${bin_main}/clang
+cxx_main=${bin_main}/clang++
+for version in {15..21}; do
+    llvm_config=llvm-config-${version}
+    build_dir=build-qemu-${version}
+    bin=$(${llvm_config} --bindir)
+    cxx=${bin}/clang++
+    cc=${bin}/clang
+    [ ! -d ${build_dir} ] && mkdir ${build_dir}
+
+    pushd ${build_dir}
+
+    TARGET_LIST=${TARGET_LIST:-$DEF_TARGET_LIST} \
+    build_qemu "--cc=${cc_main} --cxx=${cxx_main} -Dhelper-to-tcg:llvm_config_path=${llvm_config} --enable-debug-tcg"
+    check_tcg
+
+    popd
+done
-- 
2.52.0


