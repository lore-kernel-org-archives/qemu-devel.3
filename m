Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EF5CC6B2D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 18:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH3ww-0002d3-0n; Wed, 14 Oct 2026 14:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xH3wt-0002cm-R2
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:43:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xH3wr-0003nA-2o
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 14:43:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792003411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7PpPH8r3e9IsjA7i0B0C9Y4nL27XG2EoYSZo7bRpmYs=;
 b=Mkll41KeC9OLpLGo6UFar7vEMv3FPSebcWyIfgT8G23sWFd5xQGqsSycENkr1ZbKEEF4pT
 6/SjZDZKO3tJRWD7vBLW9xilIAd87Qm20p8WHn46t6z5iq+a9jIJt6aHwmgJUHrG8X4Cxt
 8S5JXI+u5NR7v+mgBQzIgEG7nDUsyjg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-R0_TIu6-M-Opy9RPqj9ibA-1; Wed,
 14 Oct 2026 18:43:28 +0000
X-MC-Unique: R0_TIu6-M-Opy9RPqj9ibA-1
X-Mimecast-MFC-AGG-ID: R0_TIu6-M-Opy9RPqj9ibA_1792003407
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E17EB18004AD; Wed, 14 Oct 2026 18:43:26 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C823180057F; Wed, 14 Oct 2026 18:43:24 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL v3 11/15] iotests/migrate-bitmaps-postcopy-test: add a bitmap
 on a second node
Date: Wed, 14 Oct 2026 13:42:45 -0500
Message-ID: <20261014184309.664714-28-eblake@redhat.com>
In-Reply-To: <20261014184309.664714-17-eblake@redhat.com>
References: <20261014184309.664714-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 .../tests/migrate-bitmaps-postcopy-test       | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index b2b37ada4b2..53f7dafc79a 100755
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
@@ -212,6 +231,9 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):

         # check that bitmaps are migrated and persistence works
         check_bitmaps(self.vm_b, nb_bitmaps)
+        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node='drive1', name='bitmap0')
+        self.assert_qmp(result, 'return/sha256', self.drive1_sha256)
         self.vm_b.shutdown()
         # recreate vm_b, so there is no incoming option, which prevents
         # loading bitmaps from disk
-- 
2.56.0


