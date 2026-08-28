Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A58C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzxqI-0002g3-JJ; Fri, 28 Aug 2026 10:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqG-0002eT-Sn
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:04 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzxqE-0000eA-3Y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 10:46:04 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso12863765e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787928361; x=1788533161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sudiIuAM/uHqM1+yV/O4MXxcGiv04xIH8Dio7xR7rac=;
 b=LjSeOduGqsY5tUq107bV/WFnpaSa62ubi03DfzTPvu0/ycXbyN2HYXBKBAvzBSccKf
 JzcFjxtDoETtRWxit+croHx2rShomLMo3crwh6SGzXJwHo+jiZXzbTOytokJDrt0eg9N
 jtG9n7bNHubf6bHI/KHRcg0fmUUPfGFAC8DV4TPGzpZdzTP95AZnfLSIEQh2JNdF8OMo
 W3mhsaoiPmOboGxpmj4kocpope8pQAVJq6FND6p2dRJL1x7yE441OLA7FWR8wTSX37Po
 /5bdvJObxz9+md7C2Yp7hfJcEe1EGjj4r2R2bDTQ/wVqJC3UVgctM9IjPzs2q3ULdpUa
 BhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787928361; x=1788533161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sudiIuAM/uHqM1+yV/O4MXxcGiv04xIH8Dio7xR7rac=;
 b=EsPPYkQ7W8kgv/KvEwKzsQBE7JzlzeQzOqXXf/HXK/qcuf9W51zqX2YEHa96CMMoFf
 I0QaPvn18aSPOSpKfn8Wcm/zBDTKmruHJSkKVeErcvbFzbNL5eap+WU79Ykxz8j/S7El
 YIUUv8+RytdtIQqTTAhhPVkj6rykzRj14AjTvdWELnj8v9Pgv6XarIGsbKoqXsF+O4cC
 D9pPKJM74bigFpzrk8PjgzDrbVZxkF+6OcHznJniHjRzYDjs5NPazQ5cRPJuhxbZiO5o
 OnrNyX2XDLrfA2CO/yqlHury0797ltZr51pGV4RfA+wl5rfXUPgb8SkPqrl6rPbjTkT7
 RDLQ==
X-Gm-Message-State: AFuF++mdvlDN6F/nE6Swd9aY6wod0RQgbb9YFfUYYlRvyZLNGTpIPLVb
 JaLdXDq9qSp0TrHDEZgq4WN/7TFF86vE9pYj1f1VD8wRa1ZJOX0qGDCLW5LbayZ+Yi5SH5yOWRD
 N2N9w
X-Gm-Gg: AR+sD13fJ8YVLWe6/36dAY7OWKMHAl0TkxlsLtjKLKCIRPSb0FHHS42AJUUe1l3TL3J
 jWi6WNu8IaFfwM2cQfeVgoUq5wUmk2zA90SlhaTgU2RWYPXstSbUsrroY2cd1hia2ZtQJ3kP5Iz
 JIjUVrBbw9T2BNPbRnfI1OBeGyEuINYLFwm1aeWzRY929+Us/Z/ptJjRlEVTrJM2+o/UnxFs8Bd
 OyuFj3LVgeiHtihL60y3TlwNVzeIskWxkY8r8TjPvy5/Zd9S312fY8X0/VeDLQSfklLDvdiwRg8
 TBczANe8PXRmv0wskwIvoIGZSriLG+wLoMiDsoX2GdB2da57Wj3x+LqoabZFDAxh9alFedhEqCz
 s7/HhL3vbnTJ+I4XnEeqFQFqljYRSiYxTZLAsvxd6nItu1JqdsDh0Ai9cj8aOx3XT+zOVHGFqHW
 7qB3IrvgAsjzHs2hy13KwyzgFST8F870KL7fmsjLd6Q39QNM6nWO3wvWZBCw==
X-Received: by 2002:a05:600c:354f:b0:493:c47f:3c55 with SMTP id
 5b1f17b1804b1-49b91c1ece1mr123144035e9.5.1787928360582; 
 Fri, 28 Aug 2026 07:46:00 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9458:da19:ab04:373a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm53730925e9.4.2026.08.28.07.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:46:00 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 2/9] iotests/040: cover large and fragmented commit runs
Date: Fri, 28 Aug 2026 16:45:47 +0200
Message-ID: <20260828144554.1741910-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828144554.1741910-1-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
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
multi-megabyte data and hole runs, the other fragments them down to
single clusters with every transition off the 512K boundary.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: John Snow <jsnow@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 tests/qemu-iotests/040     | 95 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/040.out |  4 +-
 2 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5c18e413ec..57e32b99c1 100755
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
@@ -951,6 +952,98 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
         self.vm.qmp('block-job-complete', device='commit')
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
+class TestCommitLargeRuns(iotests.QMPTestCase):
+    """Commit runs long enough to cross commit_iteration()'s cached span."""
+
+    MB = 1024 * 1024
+    CLUSTER = 64 * 1024
+
+    # Runs several COMMIT_BUFFER_SIZE (512K) chunks long, both kinds.
+    SIZE = 32 * MB
+    LAYOUT = [
+        (0, 4 * MB, 'data'),
+        (4 * MB, 6 * MB, 'hole'),
+        (10 * MB, 4 * MB, 'data'),
+        (14 * MB, 6 * MB, 'hole'),
+        (20 * MB, 4 * MB, 'data'),
+    ]
+
+    # The same, with every transition off the 512K boundary.
+    SIZE_FRAGMENTED = 384 * CLUSTER  # 24M
+    LAYOUT_FRAGMENTED = [
+        (0, 45 * CLUSTER, 'data'),
+        (100 * CLUSTER, CLUSTER, 'data'),   # data island in a hole
+        (150 * CLUSTER, 80 * CLUSTER, 'data'),
+        # [230C, 231C) is a hole island in a data run
+        (231 * CLUSTER, 69 * CLUSTER, 'data'),
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


