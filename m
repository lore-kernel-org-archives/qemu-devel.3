Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F535CD13D2
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 21:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIw17-0000zs-TD; Tue, 11 Nov 2025 16:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIw01-0000IP-PZ
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:34:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vIvzz-0002Gu-Mf
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 16:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762896839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p5/pNDPxmWXSW9ibWFFaeN5+HXMRwTQf4MumZt267PQ=;
 b=esIzXNy75t4GqL5nkw0AUnV351JZFqJu22fMn3v/DAHPL2Vul6QMw40u9ZYgVoFw1AqcNf
 WH5ekKJlKy1Ii0VT4UTSbusynrqHrjYhLbtwLRCGAHI8z+lpScfqpRxgMQ4bR+2dH5ibQt
 fGlElHp+7GZ+X02m/Tw0c+qD0+twM9g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-AC6jVBARNIqwtna1C3Wd_w-1; Tue,
 11 Nov 2025 16:33:55 -0500
X-MC-Unique: AC6jVBARNIqwtna1C3Wd_w-1
X-Mimecast-MFC-AGG-ID: AC6jVBARNIqwtna1C3Wd_w_1762896834
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D464919560A2; Tue, 11 Nov 2025 21:33:54 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.225.214])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40FFF30044E8; Tue, 11 Nov 2025 21:33:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 24/28] tests/qemu-iotests: Improve the dry run list to speed
 up thorough testing
Date: Tue, 11 Nov 2025 22:32:34 +0100
Message-ID: <20251111213238.181992-25-kwolf@redhat.com>
In-Reply-To: <20251111213238.181992-1-kwolf@redhat.com>
References: <20251111213238.181992-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

When running the tests in thorough mode, e.g. with:

 make -j$(nproc) check SPEED=thorough

we currently always get a huge amount of total tests that the test
runner tries to execute (2457 in my case), but a big bunch of them are
only skipped (1099 in my case, meaning that only 1358 got executed).
This happens because we try to run the whole set of iotests for multiple
image formats while a lot of the tests can only run with one certain
format only and thus are marked as SKIP during execution. This is quite a
waste of time during each test run, and also unnecessarily blows up the
displayed list of executed tests in the console output.

Thus let's try to be a little bit smarter: If the "check" script is run
with "-n" and an image format switch (like "-qed") at the same time (which
is what we do for discovering the tests for the meson test runner already),
only report the tests that likely support the given format instead of
providing the whole list of all tests. We can determine whether a test
supports a format or not by looking at the lines in the file that contain
a "supported_fmt" or "unsupported_fmt" statement. This is only heuristics,
of course, but it is good enough for running the iotests via "make
check-block" - I double-checked that the list of executed tests does not
get changed by this patch, it's only the tests that are skipped anyway that
are now not run anymore.

This way the amount of total tests drops from 2457 to 1432 for me, and
the amount of skipped tests drops from 1099 to just 74 (meaning that we
still properly run 1432 - 74 = 1358 tests as we did before).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251014104142.1281028-3-thuth@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/check | 42 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index d9b7c1d598..3941eac8e2 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -17,6 +17,7 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 import os
+import re
 import sys
 import argparse
 import shutil
@@ -82,7 +83,7 @@ def make_argparser() -> argparse.ArgumentParser:
     g_env.add_argument('-i', dest='aiomode', default='threads',
                        help='sets AIOMODE environment variable')
 
-    p.set_defaults(imgfmt='raw', imgproto='file')
+    p.set_defaults(imgproto='file')
 
     format_list = ['raw', 'bochs', 'cloop', 'parallels', 'qcow', 'qcow2',
                    'qed', 'vdi', 'vpc', 'vhdx', 'vmdk', 'luks', 'dmg', 'vvfat']
@@ -137,15 +138,50 @@ def make_argparser() -> argparse.ArgumentParser:
     return p
 
 
+def dry_run_list(test_dir, imgfmt, testlist):
+    for t in testlist:
+        if not imgfmt:
+            print('\n'.join([os.path.basename(t)]))
+            continue
+        # If a format has been given, we look for the "supported_fmt"
+        # and the "unsupported_fmt" lines in the test and try to find out
+        # whether the format is supported or not. This is only heuristics
+        # (it can e.g. fail if the "unsupported_fmts" and "supported_fmts"
+        # statements are in the same line), but it should be good enough
+        # to get a proper list for "make check-block"
+        with open(os.path.join(test_dir, t), 'r', encoding='utf-8') as fh:
+            supported = True
+            check_next_line = False
+            sd = "[ \t'\"]"           # Start delimiter
+            ed = "([ \t'\"]|$)"       # End delimiter
+            for line in fh:
+                if 'unsupported_fmt' in line:
+                    if re.search(sd + imgfmt + ed, line):
+                        supported = False
+                        break
+                elif 'supported_fmt' in line or check_next_line:
+                    if re.search(sd + 'generic' + ed, line):
+                        continue      # Might be followed by "unsupported" line
+                    supported = re.search(sd + imgfmt + ed, line)
+                    check_next_line = not ']' in line and \
+                            ('supported_fmts=[' in line or check_next_line)
+                    if supported or not check_next_line:
+                        break
+            if supported:
+                print('\n'.join([os.path.basename(t)]))
+
+
 if __name__ == '__main__':
     warnings.simplefilter("default")
     os.environ["PYTHONWARNINGS"] = "default"
 
     args = make_argparser().parse_args()
 
+    image_format = args.imgfmt or 'raw'
+
     env = TestEnv(source_dir=args.source_dir,
                   build_dir=args.build_dir,
-                  imgfmt=args.imgfmt, imgproto=args.imgproto,
+                  imgfmt=image_format, imgproto=args.imgproto,
                   aiomode=args.aiomode, cachemode=args.cachemode,
                   imgopts=args.imgopts, misalign=args.misalign,
                   debug=args.debug, valgrind=args.valgrind,
@@ -189,7 +225,7 @@ if __name__ == '__main__':
 
     if args.dry_run:
         with env:
-            print('\n'.join([os.path.basename(t) for t in tests]))
+            dry_run_list(env.source_iotests, args.imgfmt, tests)
     else:
         with TestRunner(env, tap=args.tap,
                         color=args.color) as tr:
-- 
2.51.1


