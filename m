Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDFCCF34A1
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 12:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swKlW-0004NC-JE; Thu, 03 Oct 2024 08:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swKlU-0004Mf-2i; Thu, 03 Oct 2024 08:17:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swKlR-0001k3-Vr; Thu, 03 Oct 2024 08:17:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C866B94E58;
 Thu,  3 Oct 2024 15:16:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B3C4814B975;
 Thu,  3 Oct 2024 15:16:57 +0300 (MSK)
Received: (nullmailer pid 1173626 invoked by uid 1000);
 Thu, 03 Oct 2024 12:16:57 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH trivial] gitlab-ci/build-oss-fuzz: print FAILED marker in case
 the test failed and run all tests
Date: Thu,  3 Oct 2024 15:16:56 +0300
Message-Id: <20241003121656.1173612-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

currently, if an oss-fuzz fails, the script does just `exit 1`
without any additional output, and looking at the build log in
the gitlab ci it is not clear what actually failed, without
looking at build-oss-fuzz script and seeing this `exit 1`.

Print easily recognizable error message about test failure, so
it becomes obvious what exactly has failed.

While at it, continue running other tests even in case of
failure, and exit non-zero if at least one test failed.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 .gitlab-ci.d/buildtest.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 87848c2ffe..25c481e43a 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -628,12 +628,15 @@ build-oss-fuzz:
     - CC="clang" CXX="clang++" CFLAGS="-fsanitize=address"
       ./scripts/oss-fuzz/build.sh
     - export ASAN_OPTIONS="fast_unwind_on_malloc=0"
+    - failures=0
     - for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f
                       | grep -v slirp); do
         grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
         echo Testing ${fuzzer} ... ;
-        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
+        "${fuzzer}" -runs=1 -seed=1 || { echo "FAILED:"" ${fuzzer} exit code is $?"; failures=$(($failures+1)); };
       done
+    - echo "Number of failures:"" $failures"
+    - test $failures = 0
 
 build-tci:
   extends: .native_build_job_template
-- 
2.39.5


