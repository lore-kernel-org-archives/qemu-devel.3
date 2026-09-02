Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A21C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gdi-0005qW-61; Wed, 02 Sep 2026 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdf-0005ms-Bf; Wed, 02 Sep 2026 04:48:11 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdb-0007B8-GV; Wed, 02 Sep 2026 04:48:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id E025982A62;
 Wed, 02 Sep 2026 11:48:05 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b72::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xlfWR5raWmI0-k6AXxjNG; Wed, 02 Sep 2026 11:48:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788338885;
 bh=Syx2uB5uU+sBiAi4YVEthtJZa+fTMLKKLKJyxkfFWEo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0PlLkEWFrxlvC3NVO4yqV4+tmmJYd8Sw16kqYkILcTe4RWjj8AB+WoEIPmGULP9Z7
 lGE8QNSZGOOd2d9b3OXtD80Iteb/VLp11fyTvHS2+0IzILNghIBSTwI0X6z6nuAt2v
 wzIjrhH971A2wzwvSkr9+toq+rf3lIo/4/L+Ybok=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 8/8] iotests/nbd-commands: cover the command flags and sparse
 replies
Date: Wed,  2 Sep 2026 11:47:54 +0300
Message-ID: <20260902084754.140103-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902084754.140103-1-vsementsov@yandex-team.ru>
References: <20260902084754.140103-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

No test sends the NBD command flags, so the server paths behind them
go unexercised. Send them from the new client.

A structured read answers a hole with an offset and a length rather
than a cluster of zeroes. Lay out data, a hole and data again, and
read the three arrangements a hole can appear in, since a leading hole
and a hole between two extents take different turns through
nbd_co_send_sparse_read(). NBD_CMD_FLAG_DF asks for one chunk instead,
which is the same layout sent as real zeroes. Check the chunk
boundaries in both forms, and that the data still reads back.

NBD_CMD_FLAG_REQ_ONE caps the extent array at one entry, so the block
status reply covers only the first cluster of the three asked about.
That a reply may describe less than was requested is also how the
server keeps NBD_MAX_BLOCK_STATUS_EXTENTS from being exceeded on a
long fragmented range, and a client assuming full coverage believes
stale status.

NBD_CMD_FLAG_FAST_ZERO becomes BDRV_REQ_NO_FALLBACK. A cluster aligned
zero can be done by marking the cluster, while zeroing part of a
cluster over a backing file needs the read modify write the flag
forbids, so check both the success and the ENOTSUP.

NBD_CMD_FLAG_FUA is added to a write and a trim.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260827161002.310688-6-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/nbd-commands     | 72 ++++++++++++++++++++++-
 tests/qemu-iotests/tests/nbd-commands.out |  4 +-
 2 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index 09e811724b1..adfd4a495cb 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -25,6 +25,7 @@ nbd: ModuleType
 
 DEPTH_LOCAL = 1
 DEPTH_BACKING = 2
+CLUSTER = 65536
 
 
 class TestNbdCommands(iotests.QMPTestCase):
@@ -90,7 +91,7 @@ class TestNbdCommands(iotests.QMPTestCase):
             self.h.shutdown()
             self.h = None
 
-    def block_status(self, count=size, wanted=None):
+    def block_status(self, count=size, wanted=None, flags=0):
         """Map each meta context in the reply to its list of extents."""
         reply = {}
 
@@ -99,9 +100,9 @@ class TestNbdCommands(iotests.QMPTestCase):
                                                   entries[1::2]))
 
         if wanted is None:
-            self.h.block_status(count, 0, cb)
+            self.h.block_status(count, 0, cb, flags)
         else:
-            self.h.block_status_filter(count, 0, wanted, cb)
+            self.h.block_status_filter(count, 0, wanted, cb, flags)
         return reply
 
     def top_extents(self):
@@ -158,6 +159,71 @@ class TestNbdCommands(iotests.QMPTestCase):
         for wanted in (['base:allocation'], ['qemu:allocation-depth']):
             self.assertEqual(sorted(self.block_status(wanted=wanted)), wanted)
 
+    def read_chunks(self, count, offset, flags=0):
+        chunks = []
+
+        def cb(subbuf, off, status, _err):
+            chunks.append((off, len(subbuf), status))
+
+        self.h.pread_structured(count, offset, cb, flags)
+        return chunks
+
+    def make_sparse(self):
+        """Lay out data, a hole and data again, one cluster each."""
+        self.h.pwrite(b'z' * CLUSTER, 0)
+        self.h.zero(CLUSTER, CLUSTER)
+        self.h.pwrite(b'z' * CLUSTER, 2 * CLUSTER)
+
+    def test_read_sparse_chunks(self):
+        self.make_sparse()
+
+        first = (0, CLUSTER, nbd.READ_DATA)
+        hole = (CLUSTER, CLUSTER, nbd.READ_HOLE)
+        second = (2 * CLUSTER, CLUSTER, nbd.READ_DATA)
+
+        # A hole is an offset and a length, not a cluster of zeroes,
+        # wherever it falls in the reply
+        self.assertEqual(self.read_chunks(2 * CLUSTER, 0), [first, hole])
+        self.assertEqual(self.read_chunks(2 * CLUSTER, CLUSTER),
+                         [hole, second])
+        self.assertEqual(self.read_chunks(3 * CLUSTER, 0),
+                         [first, hole, second])
+
+        self.assertEqual(self.h.pread(CLUSTER, CLUSTER), bytes(CLUSTER))
+        self.assertEqual(self.h.pread(CLUSTER, 0), b'z' * CLUSTER)
+
+    def test_read_dont_fragment(self):
+        self.make_sparse()
+
+        self.assertEqual(self.read_chunks(3 * CLUSTER, 0, nbd.CMD_FLAG_DF),
+                         [(0, 3 * CLUSTER, nbd.READ_DATA)])
+
+    def test_block_status_req_one(self):
+        hole = nbd.STATE_HOLE | nbd.STATE_ZERO
+        self.make_sparse()
+
+        alloc = self.block_status(3 * CLUSTER)['base:allocation']
+        self.assertEqual(alloc, [(CLUSTER, 0), (CLUSTER, hole), (CLUSTER, 0)])
+
+        # One extent, so the reply covers less than was asked for and the
+        # client has to come back for the rest
+        alloc = self.block_status(3 * CLUSTER, flags=nbd.CMD_FLAG_REQ_ONE)
+        self.assertEqual(alloc['base:allocation'], [(CLUSTER, 0)])
+
+    def test_write_and_trim_fua(self):
+        self.h.pwrite(b'y' * 4096, 4096, nbd.CMD_FLAG_FUA)
+        self.assertEqual(self.h.pread(4096, 4096), b'y' * 4096)
+        self.h.trim(4096, 4096, nbd.CMD_FLAG_FUA)
+
+    def test_fast_zero(self):
+        self.h.zero(CLUSTER, CLUSTER, nbd.CMD_FLAG_FAST_ZERO)
+        self.assertEqual(self.h.pread(CLUSTER, CLUSTER), bytes(CLUSTER))
+
+        # Zeroing part of a cluster needs the fallback the flag forbids
+        with self.assertRaises(nbd.Error) as caught:
+            self.h.zero(4096, 4096, nbd.CMD_FLAG_FAST_ZERO)
+        self.assertEqual(caught.exception.errno, 'ENOTSUP')
+
     def test_cache_past_end_of_export(self):
         self.assertRaises(nbd.Error, self.h.cache, size + 1, 0)
 
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
index 2f7d3902f23..281b69efeac 100644
--- a/tests/qemu-iotests/tests/nbd-commands.out
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -1,5 +1,5 @@
-.......
+............
 ----------------------------------------------------------------------
-Ran 7 tests
+Ran 12 tests
 
 OK
-- 
2.43.0


