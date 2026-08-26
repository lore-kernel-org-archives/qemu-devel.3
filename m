Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FD96C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGwq-0006XG-VJ; Wed, 26 Aug 2026 12:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwq-0006WO-0F
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:58:00 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwo-000360-6a
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:59 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so179916966b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787763476; x=1788368276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/t5s7xa7MIPf4HMotnoE+nqwnLijFlGOAxgQ9Zhk2OA=;
 b=r8smniCEbiHO4Ky5+V8QHRUZBXPjeqFzberkbYDhBwBL5mE4XMZGC2fpFVW56sEPkV
 pcvfOWMTRF0lKS4UK9odTyEXCHjxIzHXcyf6wCeZnKH2AvQEe25Fqndojixs/05Imz97
 Bow4k4WEj4Zcw0a5oESA3lJI+QtvA7ePvqK81pECWFOgtDbr4IwUCv77WvOxiqzHjvHb
 U/AzlTEhxdmtAXHmFjyJmWXb/K2Vm1Idb5YJDzr0mwHhoCyTw7/K+619mR0c52xVq8oQ
 KFBsttTZ3YyMMtI68j30i8NWIOlF6qHJorlnbBN5t3vs16xkYXUO11YfmTnWly1X7vLf
 D3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787763476; x=1788368276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/t5s7xa7MIPf4HMotnoE+nqwnLijFlGOAxgQ9Zhk2OA=;
 b=mo81CyDB+oO+pG4d9GsJRCK5+vtiSh4vYzlKi/JgphokU1gkkQrX7IKP9XNTQKNQaH
 BWAgfwU1oPZZqDu7Gr8pQcwXvMg4iM04dujuLVnpsBTxRJGBUVrHJ7lF1Kcy4srOkcKc
 KszFcIFbXPkWQX4/Z2rJRXdTr2xKj5mrspOzuBzsUFixAIxmrTkUGJC/TZwYqfrOEu+4
 j3xT+yXegK2k9WnSNVlYfBnk9pT8ZZfryFjzLCPJK/3lI1LU+/ycFDjpE1/OC2vyh83H
 xrRuvHMhF5DXW9E5fTJPzX5zvGG15jqkMptMIQzmkClYATHkrmiiomQwUI/ig+xAgPBk
 fM4A==
X-Gm-Message-State: AFuF++kHkHF1MKyVqPsCFnkE05htHETjpIkXc7MTFEmDAQiqjCIq/LaP
 Hn3hrtxSSHBqCzl9F7OLni+LpjJDaGHJTiuLijZe+Mv/oNg8F5z8mVpcwCtU54t0QgVrttX41sR
 GVQQw
X-Gm-Gg: AR+sD11aQPPFOIWDPZclWoOPN+eC+YJ2KNn+4uCwNyXzqmRpEWQU8+o3L5kV1jRQcoE
 kBU/SrachY+5dmxPBhFhgkGBXfatEEUu7R9wD4vNp/LMLi1Yxvv3PjJjhqITlcAhE0MPQoffwxd
 gZV4xtTjDXfSSA04tOuriJp7aEiMBWNcvi91YOrNjFFb1010tsFDxA9ZyZeDipd/wqdDMHMLypq
 M151V5z1Ke3Zzg345rc8RVB0f32zB17EDxSlUUjX3A0+F9OuJfYkRGl5mFZotiT/X5kQ6/MKGGF
 8nf3h7e/8tQdDnt5eFjeDkUD/l0EIGdgnYyu+gmHP0T06TajmbiWXd/XiwNMraAKfi8SRJVuE5R
 qFkF8zgnB8mquDMaUbZIeOyrOFsQ5zy2neYn7fRD5taNus3Nv+dqTUaKQHrnGE16vvA/SAKzmZK
 cq68I8GY8VhL8VnUY1rSVRER4Pz6cPuZWeC4zu6o042/GBVbzJWhBw1ahU
X-Received: by 2002:a17:907:6c16:b0:c12:3059:4071 with SMTP id
 a640c23a62f3a-c250c330fdcmr1012465166b.15.1787763476417; 
 Wed, 26 Aug 2026 09:57:56 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac46sm650557766b.29.2026.08.26.09.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:57:55 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 5/5] iotests/nbd-commands: cover the command flags and sparse
 replies
Date: Wed, 26 Aug 2026 18:57:47 +0200
Message-ID: <20260826165747.3768674-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826165747.3768674-1-den@openvz.org>
References: <20260826165747.3768674-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=den@openvz.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

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
---
 tests/qemu-iotests/tests/nbd-commands     | 86 +++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |  4 +-
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
index 683a8303e3..f727ea3161 100755
--- a/tests/qemu-iotests/tests/nbd-commands
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -26,6 +26,7 @@ nbd: ModuleType
 
 DEPTH_LOCAL = 1
 DEPTH_BACKING = 2
+CLUSTER = 65536
 
 
 class TestNbdCommands(iotests.QMPTestCase):
@@ -161,6 +162,91 @@ class TestNbdCommands(iotests.QMPTestCase):
             for wanted in (['base:allocation'], ['qemu:allocation-depth']):
                 self.assertEqual(self.contexts_reported(h, wanted), wanted)
 
+    def read_chunks(self, h, count, offset, flags=0):
+        chunks = []
+
+        def cb(subbuf, off, status, err):
+            chunks.append((off, len(subbuf), status))
+
+        h.pread_structured(count, offset, cb, flags)
+        return chunks
+
+    @staticmethod
+    def make_sparse(h):
+        """Lay out data, a hole and data again, one cluster each."""
+        h.pwrite(b'z' * CLUSTER, 0)
+        h.zero(CLUSTER, CLUSTER)
+        h.pwrite(b'z' * CLUSTER, 2 * CLUSTER)
+
+    def test_read_sparse_chunks(self):
+        with self.open_nbd() as h:
+            self.make_sparse(h)
+
+            first = (0, CLUSTER, nbd.READ_DATA)
+            hole = (CLUSTER, CLUSTER, nbd.READ_HOLE)
+            second = (2 * CLUSTER, CLUSTER, nbd.READ_DATA)
+
+            # A hole is an offset and a length, not a cluster of zeroes,
+            # wherever it falls in the reply
+            self.assertEqual(self.read_chunks(h, 2 * CLUSTER, 0),
+                             [first, hole])
+            self.assertEqual(self.read_chunks(h, 2 * CLUSTER, CLUSTER),
+                             [hole, second])
+            self.assertEqual(self.read_chunks(h, 3 * CLUSTER, 0),
+                             [first, hole, second])
+
+            self.assertEqual(h.pread(CLUSTER, CLUSTER), bytes(CLUSTER))
+            self.assertEqual(h.pread(CLUSTER, 0), b'z' * CLUSTER)
+
+    def test_read_dont_fragment(self):
+        with self.open_nbd() as h:
+            self.make_sparse(h)
+
+            self.assertEqual(self.read_chunks(h, 3 * CLUSTER, 0,
+                                              nbd.CMD_FLAG_DF),
+                             [(0, 3 * CLUSTER, nbd.READ_DATA)])
+
+    def status_extents(self, h, count, flags=0):
+        extents = []
+
+        def cb(meta, offset, entries, err):
+            if meta == 'base:allocation':
+                extents.extend(zip(entries[0::2], entries[1::2]))
+
+        h.block_status(count, 0, cb, flags)
+        return extents
+
+    def test_block_status_req_one(self):
+        hole = nbd.STATE_HOLE | nbd.STATE_ZERO
+
+        with self.open_nbd() as h:
+            self.make_sparse(h)
+
+            self.assertEqual(self.status_extents(h, 3 * CLUSTER),
+                             [(CLUSTER, 0), (CLUSTER, hole), (CLUSTER, 0)])
+
+            # One extent, so the reply covers less than was asked for and
+            # the client has to come back for the rest
+            self.assertEqual(self.status_extents(h, 3 * CLUSTER,
+                                                 nbd.CMD_FLAG_REQ_ONE),
+                             [(CLUSTER, 0)])
+
+    def test_write_and_trim_fua(self):
+        with self.open_nbd() as h:
+            h.pwrite(b'y' * 4096, 4096, nbd.CMD_FLAG_FUA)
+            self.assertEqual(h.pread(4096, 4096), b'y' * 4096)
+            h.trim(4096, 4096, nbd.CMD_FLAG_FUA)
+
+    def test_fast_zero(self):
+        with self.open_nbd() as h:
+            h.zero(CLUSTER, CLUSTER, nbd.CMD_FLAG_FAST_ZERO)
+            self.assertEqual(h.pread(CLUSTER, CLUSTER), bytes(CLUSTER))
+
+            # Zeroing part of a cluster needs the fallback the flag forbids
+            with self.assertRaises(nbd.Error) as caught:
+                h.zero(4096, 4096, nbd.CMD_FLAG_FAST_ZERO)
+            self.assertEqual(caught.exception.errno, 'ENOTSUP')
+
     def test_cache_past_end_of_export(self):
         with self.open_nbd() as h:
             self.assertRaises(nbd.Error, h.cache, size + 1, 0)
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
index 2f7d3902f2..281b69efea 100644
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
2.53.0


