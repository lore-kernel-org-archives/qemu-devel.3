Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB527606A329
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Va+5j/1F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3OM-0004fD-FA; Mon, 16 Nov 2026 15:33:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3NK-0002Rn-O1; Mon, 16 Nov 2026 15:32:29 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3NI-0004wg-95; Mon, 16 Nov 2026 15:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860768; bh=ReChRmTH6o+82kJvEruAiDnNEWtl/z56p4SurDKRSQk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Va+5j/1FfvGUkpOULjy1f9AYglzNHEUfznDYaemYm+8QpXQmFl8Go9cWYJaRmrAWq
 5Yzk/52LpHdqaOQ3G7gZXUkQMxphLqbSZpVib900mDDCOJsJMhhDs3V7HO5+cWJvaX
 eh3Ks2FNVzWPmuU+0TqqAeOfUOnYuyZZpcT9NbPlExY3aKbVmEHXjtgK1k9GNt+WEb
 oDgXFx+K3KQEN5SrbK08Xf4pK8yDziplrSkkZ4ATKjRa/l6uNgchHYSmCo9B9Ws9ZE
 lYWvBRvEBNB16t0ARXxUj8gNni2MAeg2Okxe+BWII9PkRHe4xTCRNfjS/ElVcvhFZR
 c15gxF1+fyIXA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2FB711E71D3;
 Mon, 16 Nov 2026 23:26:08 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2CC2545FC06;
 Mon, 16 Nov 2026 23:26:08 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0A1DAB8EC0; Mon, 16 Nov 2026 23:26:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 61/63] iotests: Add new nbd-robustness test
Date: Mon, 16 Nov 2026 23:25:40 +0300
Message-ID: <20261116202554.535325-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261116212645@cover.tls.msk.ru>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Blake <eblake@redhat.com>

Convert the proof of concept test by Sunday Jiang into an iotest. I
tried to get libnbd to trigger the situation, but forcing a block
status command when no status has been initiated is not something that
libnbd is willing to do. So this results in a hard-coded sequence of
bytes sent over a raw socket.  Swapping the order with the previous
patch shows the assertion failure that was previously reachable.

Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/4091
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261110155356.1520433-10-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 3e6759157ecb59525ae83a892c6219f6a123fa41)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/nbd-robustness b/tests/qemu-iotests/tests/nbd-robustness
new file mode 100755
index 00000000000..fe61a839250
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-robustness
@@ -0,0 +1,132 @@
+#!/usr/bin/env python3
+# group: rw auto quick
+#
+# Test cases for NBD robustness against malicious clients
+#
+# Copyright (C) 2026 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import socket
+import struct
+
+import iotests
+from iotests import qemu_img_create, qemu_io
+
+# Selected NBD Protocol Constants
+NBD_MAGIC_INIT = 0x4e42444d41474943          # "NBDMAGIC"
+NBD_MAGIC_OPTS = 0x49484156454f5054          # "IHAVEOPT"
+NBD_MAGIC_REPLY = 0x0003e889045565a9         # Reply magic
+NBD_MAGIC_EXT_REPLY = 0x6e8a278c             # Structured reply magic
+NBD_FLAG_C_FIXED_NEWSTYLE = 0x1
+NBD_OPT_GO = 7
+NBD_OPT_SET_META_CONTEXT = 10
+NBD_OPT_EXTENDED_HEADERS = 11
+NBD_REP_ACK = 1
+NBD_REP_INFO = 3
+NBD_CMD_BLOCK_STATUS = 7
+
+disk = os.path.join(iotests.test_dir, 'disk')
+size = '4M'
+nbd_sock = os.path.join(iotests.sock_dir, 'nbd_sock')
+
+
+class TestNbdRobustness(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img_create('-f', iotests.imgfmt, disk, size)
+        qemu_io('-c', 'w -P 1 0 2M', '-c', 'w -P 2 2M 2M', disk)
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+        self.vm.cmd('blockdev-add', {
+            'driver': iotests.imgfmt,
+            'node-name': 'n',
+            'file': {'driver': 'file', 'filename': disk}
+        })
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(disk)
+        try:
+            os.remove(nbd_sock)
+        except OSError:
+            pass
+
+    def recv_exact(self, s: socket.socket, n: int) -> bytes:
+        buf = bytearray()
+        while len(buf) < n:
+            chunk = s.recv(n - len(buf))
+            if not chunk:
+                raise EOFError(f"Unexpected EOF while reading {n} bytes "
+                               f"(got {len(buf)})")
+            buf.extend(chunk)
+        return bytes(buf)
+
+    def test_invalid_block_status(self):
+        with self.run_nbd_server(nbd_sock):
+            self.add_nbd_export('n', 'r')
+
+            # Use raw socket traffic to intentionally violate NBD protocol
+            with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
+                s.connect(nbd_sock)
+                # Server sends NBDMAGIC(8) + IHAVEOPT(8) + flags(2)
+                data = self.recv_exact(s, 18)
+                magic, opt, flags = struct.unpack(">QQH", data)
+                self.assertEqual(magic, NBD_MAGIC_INIT)
+                self.assertEqual(opt, NBD_MAGIC_OPTS)
+                self.assertEqual(flags, 0x3)
+
+                # Reply with flags(4) - just fixed newstyle flag
+                s.sendall(struct.pack(">I", NBD_FLAG_C_FIXED_NEWSTYLE))
+
+                # Request NBD_OPT_EXTENDED_HEADERS, no extra payload
+                s.sendall(struct.pack(">QII", NBD_MAGIC_OPTS,
+                                      NBD_OPT_EXTENDED_HEADERS, 0))
+
+                # Expect successful reply:
+                # magic(8) + option(4) + reply(4) + length(4)
+                data = self.recv_exact(s, 20)
+                magic, opt, reply, length = struct.unpack(">QIII", data)
+                self.assertEqual(magic, NBD_MAGIC_REPLY)
+                self.assertEqual(opt, NBD_OPT_EXTENDED_HEADERS)
+                self.assertEqual(reply, NBD_REP_ACK)
+                self.assertEqual(length, 0)
+
+                # Request NBD_OPT_GO, name but no info as payload
+                payload = struct.pack(">I", 1) + b'r' + struct.pack(">H", 0)
+                s.sendall(struct.pack(">QII", NBD_MAGIC_OPTS, NBD_OPT_GO,
+                                      len(payload)) + payload)
+
+                # Expect (and ignore) zero or more info packets before ack
+                while True:
+                    data = self.recv_exact(s, 20)
+                    magic, opt, reply, length = struct.unpack(">QIII", data)
+                    self.assertEqual(magic, NBD_MAGIC_REPLY)
+                    self.assertEqual(opt, NBD_OPT_GO)
+                    payload = self.recv_exact(s, length)
+                    if reply != NBD_REP_INFO:
+                        break
+                self.assertEqual(reply, NBD_REP_ACK)
+
+                # Send invalid NBD_CMD_BLOCK_STATUS with payload flag. This
+                # violates the NBD protocol (since no context was negotiated),
+                # but should not crash the server.
+                payload = struct.pack(">QI", 0x1000, 0)
+                s.sendall(struct.pack(">IHHQQQ", 0x21e41c71, 0x20,
+                                      NBD_CMD_BLOCK_STATUS, 1, 0,
+                                      len(payload)) + payload)
+
+                # Expect a rejection.
+                data = self.recv_exact(s, 32)
+                magic, flags, rtype, cookie, _, length = \
+                    struct.unpack(">IHHQQQ", data)
+                self.assertEqual(magic, NBD_MAGIC_EXT_REPLY)
+                self.assertEqual(rtype & 0x8000, 0x8000)
+                self.assertEqual(cookie, 1)
+                self.recv_exact(s, length)
+
+            self.assertTrue(self.vm.is_running())
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/tests/nbd-robustness.out b/tests/qemu-iotests/tests/nbd-robustness.out
new file mode 100644
index 00000000000..ae1213e6f86
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-robustness.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.47.3


