Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AFDC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa7T-0005s5-50; Tue, 29 Sep 2026 11:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7F-0005lp-UQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:38 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xBa7D-0001Qp-BY
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:51:37 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-48439feca17so3271197f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790697093; x=1791301893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mo2H2454pgzwXQizQ9mmVpilIP+aDCvsipICKA+Bkms=;
 b=t2J+6yfAgeuOcF1bWFH5cNShtrEjha+EenzxeijjdFD6p04zkubogwByu8gzkOP1Wa
 9+519rdoS1rdUF2fq4zHjjLAwVssaqvaZFHPKIupxjJKYnMomKPaBZ1Xv2I++u9gr82O
 LRL2RvUG76qOrKlDUPeSNCiTisBdhAu1W3PZte29ftYR1Ko0EMJHB/Xc07HZuFKwuMaO
 z/zGzbqDM/JCy8WRV4+lT0Wpn0cDPLYV/oOueGoZewQMCPPxYmBMGWtQyRGy1ejhSnOO
 m7qHhOruA1fAd4JiSO8zXUjgvyCpJkQMphJjSdMp8A9sbG44kAxr38NHo2aSI4rmeqf/
 vcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697093; x=1791301893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mo2H2454pgzwXQizQ9mmVpilIP+aDCvsipICKA+Bkms=;
 b=jKNfWG17R1WIVyNHx6zl6nhXChjldTPiIFRi/15WZeoTexGD2OnOmmuxcH3ob+FAt/
 1p7kOIuqXty1jN+/PhNNDrBt7O0uY1wP1NUXdLl3yEiErXZzWaW9vPx0ZUsnqWn7gS6q
 yXAaNZfd+pytKJa6wIEaUBj51XdBrArpyOZZQQRT0ycxaX+ARP9raZLzQPcDt0x4ipK1
 kX4mP7gsFcOwGCP/5NX174FL2alDMTOrYGAfox01qBezPgsR0fsPMxtwCofxXnPrFJhc
 RRt+n2jDINj3K5nR5XO+EVPXrg5+fN0/ICIg4ikFx2c7xP1HdNdEjWRougBdGqqAbjsP
 4/sA==
X-Gm-Message-State: AFq9FYL2Vbw95U5lI7aY36ICVx22PRkj3/+aXs+9mI0rT7y/7pHYxzs3
 Sz5IxfwCZXKlO6gr8yh7juANrhUyXuKbeD6Z0Sl6RMK0jJ3eG4qdruBO+cpenhlKHSvEcHG06nq
 AgTHR
X-Gm-Gg: AYBFou1xIe+1bpDIL0U2+9HiZ/BlKVUpmhs1SVeWSH07cVuDvtOAsWi14etK85z5WTm
 zjgVlRkLWOZlZ3K6z6ev7/G2eJ4ZoPkMFWvSw2fwyj5HK1xAC743uBFBaBoV/49G/knTECMNtHj
 ISur7je2CrlpyoCumkKbgGudIwD/e69cO/5kPeJEUZX8+knowfgNZTiV+OuQDdTJmcNwr4SAVfk
 xxX2KQTDicoZPRJS9+NommCPttO8iUnsRVlV9jGrPQFxv79szV1mN8uWvsMMucGyW5Cqd7JJwD2
 ykJn4yHnDthtI8dUdJP4jjPd0SqqKYr6SH8WBRw8Wme48OLyuw3cPzbU0Y5LIlqD8md4w4l9qs0
 vmwKfIRXyqZKsty7u6E+mI173IKQ17tl8gg2sAC8bUSVWH3lURXbMFFxeKFoLdJe2PZkm7M0KOL
 Kr4H2L1x3hg0uW0QbaGYiDe2Emuwl7fkWlqqOTzJ7xgJ25a05VwXO13NHH/g==
X-Received: by 2002:a05:6000:2c0b:b0:48a:fdb2:f2f4 with SMTP id
 ffacd0b85a97d-48afdb2f312mr74331f8f.57.1790697093501; 
 Tue, 29 Sep 2026 08:51:33 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:37e8:6d0c:7fb:398c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af508b13fsm4416852f8f.27.2026.09.29.08.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:51:32 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 2/9] iotests/040: cover large and fragmented commit runs
Date: Tue, 29 Sep 2026 17:51:18 +0200
Message-ID: <20260929155125.3151111-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929155125.3151111-1-den@openvz.org>
References: <20260929155125.3151111-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=den@openvz.org; helo=mail-wr2-x10.google.com
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

From: Denis V. Lunev <den@openvz.org>

040 never commits runs long enough to span more than one block-status
query, so the answer that commit_iteration() is about to start caching
goes untested.

Add two cases on a base <- mid <- active chain, committing mid so the
job takes the regular commit path rather than active commit, and compare
base against a snapshot of mid taken before the commit. One case mixes
multi-megabyte data, zero and hole runs, the other fragments them down
to single clusters with every transition off the 512K boundary.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/040     | 102 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/040.out |   4 +-
 2 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5c18e413ec..e01c9385ba 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -25,13 +25,14 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_img_create, qemu_io, compare_images
 import struct
 import errno
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 mid_img = os.path.join(iotests.test_dir, 'mid.img')
 test_img = os.path.join(iotests.test_dir, 'test.img')
+reference_img = os.path.join(iotests.test_dir, 'reference.img')
 
 class ImageCommitTestCase(iotests.QMPTestCase):
     '''Abstract base class for image commit test cases'''
@@ -951,6 +952,105 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
         self.vm.qmp('block-job-complete', device='commit')
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
+class TestCommitLargeRuns(iotests.QMPTestCase):
+    """Commit runs long enough to cross commit_iteration()'s cached span."""
+
+    MB = 1024 * 1024
+    CLUSTER = 64 * 1024
+
+    # Runs several COMMIT_BUFFER_SIZE (512K) chunks long, of every kind.
+    SIZE = 32 * MB
+    LAYOUT = [
+        (0, 4 * MB, 'data'),
+        (4 * MB, 6 * MB, 'hole'),
+        (10 * MB, 4 * MB, 'data'),
+        (14 * MB, 6 * MB, 'zero'),
+        (20 * MB, 4 * MB, 'data'),
+        (24 * MB, 8 * MB, 'hole'),
+    ]
+
+    # The same, with every transition off the 512K boundary.
+    SIZE_FRAGMENTED = 384 * CLUSTER  # 24M
+    LAYOUT_FRAGMENTED = [
+        (0, 45 * CLUSTER, 'data'),
+        (45 * CLUSTER, 55 * CLUSTER, 'hole'),
+        (100 * CLUSTER, CLUSTER, 'data'),
+        (101 * CLUSTER, 49 * CLUSTER, 'zero'),
+        (150 * CLUSTER, 80 * CLUSTER, 'data'),
+        (230 * CLUSTER, CLUSTER, 'hole'),
+        (231 * CLUSTER, 69 * CLUSTER, 'data'),
+        (300 * CLUSTER, 83 * CLUSTER, 'zero'),
+        (383 * CLUSTER, CLUSTER, 'hole'),
+    ]
+
+    def setUp(self):
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for img in (backing_img, mid_img, test_img, reference_img):
+            if os.path.exists(img):
+                os.remove(img)
+
+    def build_images(self, layout, size):
+        # A pattern of its own in base, so a misplaced cluster shows up.
+        qemu_img_create('-f', iotests.imgfmt, backing_img, str(size))
+        qemu_io('-c', f'write -P 0x11 0 {size}', backing_img)
+
+        qemu_img_create('-f', iotests.imgfmt, '-b', backing_img, '-F',
+                        iotests.imgfmt, mid_img, str(size))
+        for offset, length, kind in layout:
+            if kind == 'data':
+                qemu_io('-c', f'write -P 0x22 {offset} {length}', mid_img)
+            elif kind == 'zero':
+                qemu_io('-c', f'write -z {offset} {length}', mid_img)
+
+        # What base must equal once mid is committed into it.
+        qemu_img('convert', '-f', iotests.imgfmt, '-O', iotests.imgfmt,
+                 mid_img, reference_img)
+
+        # An empty layer above mid, so top_node=mid is not the active one.
+        qemu_img_create('-f', iotests.imgfmt, '-b', mid_img, '-F',
+                        iotests.imgfmt, test_img, str(size))
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'base',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': backing_img},
+        })
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'mid',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': mid_img},
+            'backing': 'base',
+        })
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'active',
+            'driver': iotests.imgfmt,
+            'file': {'driver': 'file', 'filename': test_img},
+            'backing': 'mid',
+        })
+
+    def commit_and_verify(self):
+        self.vm.cmd('block-commit', job_id='commit0', device='active',
+                    top_node='mid', base_node='base')
+        self.wait_until_completed(drive='commit0')
+
+        self.vm.cmd('blockdev-del', node_name='active')
+        self.vm.cmd('blockdev-del', node_name='mid')
+        self.vm.cmd('blockdev-del', node_name='base')
+        self.assertTrue(compare_images(reference_img, backing_img))
+
+    def test_commit_large_runs(self):
+        self.build_images(self.LAYOUT, self.SIZE)
+        self.commit_and_verify()
+
+    def test_commit_fragmented_runs(self):
+        self.build_images(self.LAYOUT_FRAGMENTED, self.SIZE_FRAGMENTED)
+        self.commit_and_verify()
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 1bb1dc5f0e..d2e2a2d98f 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-.................................................................
+...................................................................
 ----------------------------------------------------------------------
-Ran 65 tests
+Ran 67 tests
 
 OK
-- 
2.53.0


