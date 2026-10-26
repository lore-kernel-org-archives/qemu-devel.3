Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C965B606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=eg/HMYMq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLAa-0005BV-FT; Mon, 26 Oct 2026 09:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAX-000552-71; Mon, 26 Oct 2026 09:55:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAV-00008R-AB; Mon, 26 Oct 2026 09:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=yxbJ/l2meOd4EtUd7afdK1Af19/a1a1wJor5q4tZu1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eg/HMYMqmjNhwXV5HQ4/zjD+++GxbkrKdZw6kRHwYykiIL8BxLTt0RgWfnYPtk4yz
 mBajOO9qfykIVCYF/0/U3GGGX4ahggFY/pdtNb+rqT70FtOhvocrbjLa8/vIjvoKZq
 axhRkWI/S306+QYmxYiek5mVUZYS1e/iXeluYvEXJ9mE5Vvhsu3uyo4fr1BumerSPy
 yy5N4YvvKqbSPUqyswaIL7YtEciWoJExdIzQmxY5gHPucCWxDTX72eKn8sZp10cdf7
 aBP28slx5eznL6LM5XUwqgGXvBHTrgQv14hvoUmVTqmceNUQNWE+Hj91lEKiklkJMI
 lxVt6jNl4nHIg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB0761E127F;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A6A0644B8CB;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 91DCC9348D; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 73/91] iotests/migrate-bitmaps-postcopy-test: add
 a bitmap on a second node
Date: Mon, 26 Oct 2026 16:54:16 +0300
Message-ID: <20261026135441.1019505-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Denis V. Lunev" <den@openvz.org>

All bitmaps in the test live on drive0, so the source never switches
nodes after setup and the destination never resolves a node name from
the postcopy listen thread. Add a second drive with one bitmap and check
that it arrives intact.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20261006170738.453977-4-den@openvz.org>
[eblake: squash in fix to pass even after aborted run left behind stale
fifo, and to avoid check-python-minreqs lint failure]
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit faa80b9847b9f326d7570c512d52e0a22a5bd5b3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index c519e6db8c7..4ae1f30f2cd 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -27,6 +27,8 @@ debug = False
 
 disk_a = os.path.join(iotests.test_dir, 'disk_a')
 disk_b = os.path.join(iotests.test_dir, 'disk_b')
+disk_a1 = os.path.join(iotests.test_dir, 'disk_a1')
+disk_b1 = os.path.join(iotests.test_dir, 'disk_b1')
 size = '256G'
 fifo = os.path.join(iotests.test_dir, 'mig_fifo')
 
@@ -97,16 +99,26 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         self.vm_b.shutdown()
         os.remove(disk_a)
         os.remove(disk_b)
+        os.remove(disk_a1)
+        os.remove(disk_b1)
         os.remove(fifo)
 
     def setUp(self):
+        if os.path.exists(fifo):
+            os.remove(fifo)
         os.mkfifo(fifo)
         qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
         qemu_img('create', '-f', iotests.imgfmt, disk_b, size)
+        qemu_img('create', '-f', iotests.imgfmt, disk_a1, '1G')
+        qemu_img('create', '-f', iotests.imgfmt, disk_b1, '1G')
         self.vm_a = iotests.VM(path_suffix='a').add_drive(disk_a,
                                                           'discard=unmap')
         self.vm_b = iotests.VM(path_suffix='b').add_drive(disk_b,
                                                           'discard=unmap')
+        self.drive1_sha256 = ""
+        # A bitmap on a second node makes postcopy switch nodes after setup
+        self.vm_a.add_drive(disk_a1)
+        self.vm_b.add_drive(disk_b1)
         self.vm_b.add_incoming("exec: cat '" + fifo + "'")
         self.vm_a.launch()
         self.vm_b.launch()
@@ -127,6 +139,13 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
                                node='drive0', name='bitmap0')
         empty_sha256 = result['return']['sha256']
 
+        self.vm_a.cmd('block-dirty-bitmap-add', node='drive1',
+                      name='bitmap0', granularity=granularity)
+        self.vm_a.hmp_qemu_io('drive1', 'write 0 64k')
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive1', name='bitmap0')
+        self.drive1_sha256 = result['return']['sha256']
+
         apply_discards(self.vm_a, discards1)
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
@@ -199,6 +218,9 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         # check that bitmaps are migrated and persistence works
         check_bitmaps(self.vm_b, nb_bitmaps)
+        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive1', name='bitmap0')
+        self.assert_qmp(result, 'return/sha256', self.drive1_sha256)
         self.vm_b.shutdown()
         # recreate vm_b, so there is no incoming option, which prevents
         # loading bitmaps from disk
-- 
2.47.3


