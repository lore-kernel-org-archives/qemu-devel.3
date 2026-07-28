Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DC9C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokqI-00010L-P0; Tue, 28 Jul 2026 12:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wokqF-0000zc-H4; Tue, 28 Jul 2026 12:39:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wokqD-0004lO-FD; Tue, 28 Jul 2026 12:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1785256773; bh=oO3REX05MBkFM/JYl+LUmfk5geaduv1YQ2weccFA7dc=;
 h=From:To:Cc:Subject:Date;
 b=nxFLI5keAaDXA9ey+EKYHRx9N+bPgqObJCqLgIfCKFKyXC/zn2REJ06kSNrYVjfD0
 qdRHkj9TP7N8/9LBKo+7klSsJ1ysOr/VhuXoT77xXAGqhAE/uBm5iUpioQfKHalshi
 2HFy/ajVTLyZpIvE21sXm4x90AbfIowF7CDW/3wztqO+mrBK3SwSyn9qCM8aN2nYvJ
 lgsWKu59LASFeXICnMSnS4aTgbIyJVICHJXeCmj4lxan6TU9OCLXiO5gbSHBqQlgPT
 I26jjYfOOyPnMPMakQHFfiyB+dsNSw1b939GHTFQX7yjJNxum9xZqLUvJz0qFU6jc2
 +SgRSx8aTfSUA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 369861C63C2;
 Tue, 28 Jul 2026 19:39:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE26F3F869D;
 Tue, 28 Jul 2026 19:39:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6030629E9D; Tue, 28 Jul 2026 19:39:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for-11.1?] qemu-iotest 161: fix race
Date: Tue, 28 Jul 2026 19:39:16 +0300
Message-ID: <20260728163919.369020-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

qemu-iotest 161 fails intermittedly due to a race condition:

qemu:block / io-qcow2-161             ERROR            2.08s   exit status 1
――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
stderr:
--- tests/qemu-iotests/161.out
+++ scratch/qcow2-file-161/161.out.bad
@@ -34,6 +34,8 @@
 *** Commit and then change an option on the backing file

 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=1048576
+qemu-img: TEST_DIR/t.IMGFMT.base: Failed to get "write" lock
+Is another process using the image [TEST_DIR/t.IMGFMT.base]?
 Formatting 'TEST_DIR/t.IMGFMT.int', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.int backing_fmt=IMGFMT
 { 'execute': 'qmp_capabilities' }

This test is run right after a previous test, where we've
killed qemu process which holds the test image open.
It looks like when the next test is started (with creating
the image files), old qemu is still running, so we're racing
with that qemu, and qemu-img is unable to lock the image file
properly.

We can add some `sleep $little-amount` here, but it is simpler
and more reliable to just remove the image files, so that new
ones are created.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2867
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index f25effab936..0b8ba0b19e2 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -106,6 +106,7 @@ echo
 echo "*** Commit and then change an option on the backing file"
 echo
 # Create the images again
+rm -f -- "$TEST_IMG.base" "$TEST_IMG.int"
 TEST_IMG="$TEST_IMG.base" _make_test_img $IMG_SIZE
 TEST_IMG="$TEST_IMG.int" _make_test_img -b "$TEST_IMG.base" -F $IMGFMT
 _make_test_img -b "$TEST_IMG.int" -F $IMGFMT

