Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBE7606A542
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOdhfGiH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRzuG-0004Bt-H7; Fri, 13 Nov 2026 17:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRzuF-00044h-3N
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 17:38:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRzuC-0007rU-TO
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 17:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794609480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DuRjv5uyDKgngYsIV7UMpZFoPvwBZ0IH89zulFVjNA4=;
 b=gOdhfGiHdTSap7Mvl71DFYknLbugmaTmW42SMjLQgXEIdvTwm58oKpUyc0ObLeVmu78Rql
 Mv4JUNIGrB287dwa6PK4AM+k/qbi8/n73xb4pbOaPOscLRJgwWqYEg/e2zf6+e9mL5yR5A
 gCAAa5eFVP1Vtp3EbXMztKe01GdObYo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-HB19iSxjMmGza9e5dXniYw-1; Fri,
 13 Nov 2026 17:37:56 -0500
X-MC-Unique: HB19iSxjMmGza9e5dXniYw-1
X-Mimecast-MFC-AGG-ID: HB19iSxjMmGza9e5dXniYw_1794609475
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 829CB1800613; Fri, 13 Nov 2026 22:37:55 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88FD61956086; Fri, 13 Nov 2026 22:37:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, bea1e@proton.me,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 4/4] nbd: Add iotest exposing previous CVE fix
Date: Fri, 13 Nov 2026 16:34:52 -0600
Message-ID: <20261113223742.2546619-10-eblake@redhat.com>
In-Reply-To: <20261113223742.2546619-6-eblake@redhat.com>
References: <20261113223742.2546619-6-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Feifan Qian posted a sample script generated with the help of AI that
created a known-broken NBD server that intentionally replies to a
structured read with only a subset of bytes, to expose the leak of
heap data from qemu as an NBD client into an emulated IDE drive. Take
the idea of that test, but simplify it into a qemu-io test (much
lighter-weight NBD client, and easier access to see what bytes the NBD
client code is passing on) that more closely resembles paradigms in my
recent nbd-robustness iotest.  Also, expand the test to cover multiple
scenarios: in addition to the original test demonstrating a prefix of
20 bytes with unwritten tail, I expanded it to cover out-of-order
replies, a hole-only reply, and a completely empty reply.

Reported-by: Feifan Qian <bea1e@proton.me>
Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/3815
AI-used-for: tests
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 .../tests/nbd-structured-read-gaps            | 215 ++++++++++++++++++
 .../tests/nbd-structured-read-gaps.out        |   5 +
 2 files changed, 220 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-structured-read-gaps
 create mode 100644 tests/qemu-iotests/tests/nbd-structured-read-gaps.out

diff --git a/tests/qemu-iotests/tests/nbd-structured-read-gaps b/tests/qemu-iotests/tests/nbd-structured-read-gaps
new file mode 100755
index 00000000000..9f8b3b8b20b
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-structured-read-gaps
@@ -0,0 +1,215 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Test that NBD client zero-initializes any regions omitted by a server
+# sending incomplete or out-of-order structured read replies.
+#
+# Copyright (C) 2026 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import socket
+import struct
+import threading
+import iotests
+
+NBD_INIT_MAGIC = 0x4E42444D41474943
+NBD_OPTS_MAGIC = 0x49484156454F5054
+NBD_REP_MAGIC = 0x0003E889045565A9
+NBD_REQUEST_MAGIC = 0x25609513
+NBD_STRUCTURED_REPLY_MAGIC = 0x668E33EF
+
+NBD_FLAG_FIXED_NEWSTYLE = 1 << 0
+NBD_FLAG_NO_ZEROES = 1 << 1
+NBD_FLAG_HAS_FLAGS = 1 << 0
+
+NBD_OPT_ABORT = 2
+NBD_OPT_GO = 7
+NBD_OPT_STRUCTURED_REPLY = 8
+
+NBD_REP_ACK = 1
+NBD_REP_INFO = 3
+NBD_REP_ERR_UNSUP = (1 << 31) | 1
+NBD_INFO_EXPORT = 0
+
+NBD_CMD_READ = 0
+NBD_CMD_DISC = 2
+
+NBD_REPLY_FLAG_DONE = 1 << 0
+NBD_REPLY_TYPE_NONE = 0
+NBD_REPLY_TYPE_OFFSET_DATA = 1
+NBD_REPLY_TYPE_OFFSET_HOLE = 2
+
+
+def recvall(conn, size):
+    data = bytearray()
+    while len(data) < size:
+        chunk = conn.recv(size - len(data))
+        if not chunk:
+            raise EOFError("unexpected EOF")
+        data.extend(chunk)
+    return bytes(data)
+
+
+def send_option_reply(conn, option, reply_type, payload=b""):
+    conn.sendall(struct.pack(">QII", NBD_REP_MAGIC, option, reply_type))
+    conn.sendall(struct.pack(">I", len(payload)) + payload)
+
+
+def send_chunk(conn, flags, chunk_type, cookie, payload=b""):
+    hdr = struct.pack(">IHHQI", NBD_STRUCTURED_REPLY_MAGIC,
+                      flags, chunk_type, cookie, len(payload))
+    conn.sendall(hdr + payload)
+
+
+# Emulate a simple NBD server that only knows how to respond to 512-byte
+# structured reads from fixed offsets.
+class StructuredReadServer(threading.Thread):
+    def __init__(self, sock_path):
+        super().__init__(daemon=True)
+        self.sock_path = sock_path
+        self.ready = threading.Event()
+        self.error = None
+
+    def run(self):
+        try:
+            with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as srv:
+                srv.bind(self.sock_path)
+                srv.listen(1)
+                self.ready.set()
+                conn, _ = srv.accept()
+                with conn:
+                    conn.settimeout(10)
+                    self.negotiate(conn)
+                    self.transmission(conn)
+        except (OSError, EOFError, AssertionError, struct.error) as exc:
+            self.error = exc
+
+    def negotiate(self, conn):
+        conn.sendall(struct.pack(">QQH", NBD_INIT_MAGIC, NBD_OPTS_MAGIC,
+                                 NBD_FLAG_FIXED_NEWSTYLE | NBD_FLAG_NO_ZEROES))
+        recvall(conn, 4)  # client flags
+
+        while True:
+            magic, option, length = struct.unpack(">QII", recvall(conn, 16))
+            assert magic == NBD_OPTS_MAGIC
+            if length:
+                recvall(conn, length)
+
+            if option == NBD_OPT_STRUCTURED_REPLY:
+                send_option_reply(conn, option, NBD_REP_ACK)
+            elif option == NBD_OPT_GO:
+                info = struct.pack(">HQH", NBD_INFO_EXPORT, 65536,
+                                   NBD_FLAG_HAS_FLAGS)
+                send_option_reply(conn, option, NBD_REP_INFO, info)
+                send_option_reply(conn, option, NBD_REP_ACK)
+                return
+            elif option == NBD_OPT_ABORT:
+                send_option_reply(conn, option, NBD_REP_ACK)
+                return
+            else:
+                send_option_reply(conn, option, NBD_REP_ERR_UNSUP)
+
+    def transmission(self, conn):
+        """Trigger several non-compliant server behaviors based on the
+        client's offset. A compliant server would supply all 512 bytes."""
+        while True:
+            try:
+                hdr = recvall(conn, 28)
+            except EOFError:
+                return
+            magic, _flags, cmd, cookie, offset, length = struct.unpack(
+                ">IHHQQI", hdr)
+            assert magic == NBD_REQUEST_MAGIC
+
+            if cmd == NBD_CMD_DISC:
+                return
+            assert cmd == NBD_CMD_READ and length == 512
+
+            if offset == 0:
+                # Case 1: Short prefix with FLAG_DONE
+                payload = struct.pack(">Q", offset) + b"QEMU_NBD_PREFIX_DATA"
+                send_chunk(conn, NBD_REPLY_FLAG_DONE,
+                           NBD_REPLY_TYPE_OFFSET_DATA, cookie, payload)
+            elif offset == 512:
+                # Case 2: Out-of-order chunks with gaps + NONE|DONE
+                send_chunk(conn, 0, NBD_REPLY_TYPE_OFFSET_DATA, cookie,
+                           struct.pack(">Q", 768) + (b"\x11" * 128))
+                send_chunk(conn, 0, NBD_REPLY_TYPE_OFFSET_DATA, cookie,
+                           struct.pack(">Q", 576) + (b"\x22" * 64))
+                send_chunk(conn, NBD_REPLY_FLAG_DONE,
+                           NBD_REPLY_TYPE_NONE, cookie)
+            elif offset == 1024:
+                # Case 3: Leading & trailing gaps around OFFSET_HOLE
+                send_chunk(conn, NBD_REPLY_FLAG_DONE,
+                           NBD_REPLY_TYPE_OFFSET_HOLE, cookie,
+                           struct.pack(">QI", 1280, 128))
+            elif offset == 1536:
+                # Case 4: Immediate NONE|DONE with zero chunks
+                send_chunk(conn, NBD_REPLY_FLAG_DONE,
+                           NBD_REPLY_TYPE_NONE, cookie)
+
+
+class TestNBDStructuredReadGaps(iotests.QMPTestCase):
+    def setUp(self):
+        self.sock_path = os.path.join(iotests.sock_dir, "nbd.sock")
+        self.server = StructuredReadServer(self.sock_path)
+        self.server.start()
+        self.assertTrue(self.server.ready.wait(5))
+
+    def tearDown(self):
+        self.server.join(timeout=5)
+        self.assertIsNone(self.server.error)
+        if os.path.exists(self.sock_path):
+            os.unlink(self.sock_path)
+
+    @staticmethod
+    def parse_read_v(out):
+        """Reconstruct raw bytes from `qemu-io -c 'read -v ...'` output."""
+        buf = bytearray()
+        for line in out.splitlines():
+            # Format: "00000000:  51 45 4d 55 ...  QEMU_NBD_PREFIX_"
+            if ":  " not in line:
+                continue
+            hex_col = line.split(":  ", 1)[1][:49]
+            buf.extend(int(b, 16) for b in hex_col.split())
+        return bytes(buf)
+
+    def test_incomplete_and_out_of_order_reads(self):
+        # Force heap perturbation so uninitialized bytes show up (if not
+        # already set in caller, this favors values of 0x5A in unused heap)
+        os.environ.setdefault("MALLOC_PERTURB_", "165")
+        nbd_uri = f"nbd+unix:///?socket={self.sock_path}"
+        out = iotests.qemu_io(
+            "-f", "raw",
+            "-c", "read -v 0 512",
+            "-c", "read -v 512 512",
+            "-c", "read -v 1024 512",
+            "-c", "read -v 1536 512",
+            nbd_uri
+        )
+        data = self.parse_read_v(out.stdout)
+        self.assertEqual(len(data), 2048)
+
+        # Case 1 [0..512): 20-byte prefix + 492 zeroed bytes
+        self.assertEqual(data[0:20], b"QEMU_NBD_PREFIX_DATA")
+        self.assertEqual(data[20:512], b"\x00" * 492)
+
+        # Case 2 [512..1024): 0x22 at [576..640), 0x11 at [768..896),
+        # zeroes elsewhere
+        self.assertEqual(data[512:576], b"\x00" * 64)
+        self.assertEqual(data[576:640], b"\x22" * 64)
+        self.assertEqual(data[640:768], b"\x00" * 128)
+        self.assertEqual(data[768:896], b"\x11" * 128)
+        self.assertEqual(data[896:1024], b"\x00" * 128)
+
+        # Case 3 [1024..1536): OFFSET_HOLE + leading/trailing gaps all zeroed
+        self.assertEqual(data[1024:1536], b"\x00" * 512)
+
+        # Case 4 [1536..2048): empty NONE|DONE all zeroed
+        self.assertEqual(data[1536:2048], b"\x00" * 512)
+
+
+if __name__ == "__main__":
+    iotests.main(supported_protocols=["nbd"])
diff --git a/tests/qemu-iotests/tests/nbd-structured-read-gaps.out b/tests/qemu-iotests/tests/nbd-structured-read-gaps.out
new file mode 100644
index 00000000000..ae1213e6f86
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-structured-read-gaps.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.56.0


