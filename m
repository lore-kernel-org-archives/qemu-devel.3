Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADAFCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 18:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGLKw-0006jh-P9; Tue, 04 Nov 2025 13:00:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLFL-0001KO-5g
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:55:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vGLFI-00070X-LL
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 12:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762278903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/JyZOAu8kJZG1l3piTbT+IR3lNXsnQ6tJXrxHnnA3CY=;
 b=O1ZvQ682A0hvpwfMZAS8ZiLIBclOviMZC8HVHP8W0F0nWL+1UGBLAjAQLzPR3uU2Zn4h9G
 yZrinqNLR9tUXH0US3yPfWD7t9+5z0zu/XHBAWPY0YhFLIB43sP1BmTzOF18UNCZ8bIEwb
 PnXmGTFWLFPtcfjw42KWhtkPH3MnK6g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-b1m9NJHSMhmM6S18MRXiyg-1; Tue,
 04 Nov 2025 12:55:01 -0500
X-MC-Unique: b1m9NJHSMhmM6S18MRXiyg-1
X-Mimecast-MFC-AGG-ID: b1m9NJHSMhmM6S18MRXiyg_1762278900
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7596C18002F9; Tue,  4 Nov 2025 17:55:00 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30170180044F; Tue,  4 Nov 2025 17:54:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 20/27] iotests: Run iotests with sanitizers
Date: Tue,  4 Nov 2025 18:54:08 +0100
Message-ID: <20251104175415.525388-21-kwolf@redhat.com>
In-Reply-To: <20251104175415.525388-1-kwolf@redhat.com>
References: <20251104175415.525388-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

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
Message-ID: <20251023-iotests-v1-2-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/testrunner.py | 12 ++++++++++++
 tests/qemu-iotests/meson.build   |  8 --------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 14cc8492f9..e2a3658994 100644
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
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index fad340ad59..56b0446827 100644
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
-- 
2.51.1


