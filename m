Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EA8CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqPx-00075B-E4; Thu, 23 Oct 2025 04:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBqPt-0006zU-3z; Thu, 23 Oct 2025 04:11:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBqPp-0005jb-56; Thu, 23 Oct 2025 04:11:24 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59N8B471071845
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Oct 2025 17:11:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=HCFiz1S1b6I1iKxAHjbd3TDsQoWjLO5k05+NL3oD3BQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761207074; v=1;
 b=iJyPWuEpPcs+vTa9ZXATweR48P+6Kn7E0jLNkClk9RM+0wx6NjXi43EMmpSCNpPe
 aW43P3uzLAgy6RjJ/sOFL5AIYu9gpSLzOD+0tZRGB6qWXmT/O6C7Xrug0qBYPCgq
 LrfWu09NK7xS+OEYrG+BqP0q+qbF8TB6SNxbxqhA5pJc5PpdhAkbln/HV9E/E113
 p60hViYA8aKOk/Z9jqtjhdy34Thmwwmjkcj5JkTSWF257v16bbRqj1w6ZH8jrzbC
 +4YekIDO5O/BhvkQmRh4E1zHOlT/s0cP7kbp14+HBvGynpqDnirRe2G+ym+h97Nf
 0WegOpHi1Vo4oOq2qzCiQA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 23 Oct 2025 17:10:59 +0900
Subject: [PATCH 2/2] iotests: Run iotests with sanitizers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-iotests-v1-2-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
References: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit 2cc4d1c5eab1 ("tests/check-block: Skip iotests when sanitizers
are enabled") changed iotests to skip when sanitizers are enabled.
The rationale is that AddressSanitizer emits warnings and reports leaks,
which results in test breakage. Later, sanitizers that are enabled for
production environments (safe-stack and cfi-icall) were exempted.

However, this approach has a few problems.

- It requires rebuild to disable sanitizers if the existing build has
  them enabled.
- It disables other useful non-production sanitizers.
- The exemption of safe-stack and cfi-icall is not correctly
  implemented, so qemu-iotests are incorrectly enabled whenever either
  safe-stack or cfi-icall is enabled *and*, even if there is another
  sanitizer like AddressSanitizer.

To solve these problems, direct AddressSanitizer warnings to separate
files to avoid changing the test results, and selectively disable
leak detection at runtime instead of requiring to disable all
sanitizers at buildtime.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 tests/qemu-iotests/meson.build   |  8 --------
 tests/qemu-iotests/testrunner.py | 12 ++++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index fad340ad5957..56b04468274a 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -2,14 +2,6 @@ if not have_tools or host_os == 'windows'
   subdir_done()
 endif
 
-foreach cflag: qemu_ldflags
-  if cflag.startswith('-fsanitize') and \
-     not cflag.contains('safe-stack') and not cflag.contains('cfi-icall')
-    message('Sanitizers are enabled ==> Disabled the qemu-iotests.')
-    subdir_done()
-  endif
-endforeach
-
 bash = find_program('bash', required: false, version: '>= 4.0')
 if not bash.found()
   message('bash >= v4.0 not available ==> Disabled the qemu-iotests.')
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 14cc8492f9fb..e2a365899414 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -263,10 +263,21 @@ def do_run_test(self, test: str) -> TestResult:
             Path(env[d]).mkdir(parents=True, exist_ok=True)
 
         test_dir = env['TEST_DIR']
+        f_asan = Path(test_dir, f_test.name + '.out.asan')
         f_bad = Path(test_dir, f_test.name + '.out.bad')
         f_notrun = Path(test_dir, f_test.name + '.notrun')
         f_casenotrun = Path(test_dir, f_test.name + '.casenotrun')
 
+        env['ASAN_OPTIONS'] = f'detect_leaks=0:log_path={f_asan}'
+
+        def unlink_asan():
+            with os.scandir(test_dir) as it:
+                for entry in it:
+                    if entry.name.startswith(f_asan.name):
+                        os.unlink(entry)
+
+        unlink_asan()
+
         for p in (f_notrun, f_casenotrun):
             silent_unlink(p)
 
@@ -312,6 +323,7 @@ def do_run_test(self, test: str) -> TestResult:
                               description=f'output mismatch (see {f_bad})',
                               diff=diff, casenotrun=casenotrun)
         else:
+            unlink_asan()
             f_bad.unlink()
             return TestResult(status='pass', elapsed=elapsed,
                               casenotrun=casenotrun)

-- 
2.51.0


