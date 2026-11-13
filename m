Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF5606A32D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XVcf+IUd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsLF-0001uW-3B; Fri, 13 Nov 2026 09:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRsJk-0008CD-8G
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xRsJh-0007Jd-UB
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:31:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794580309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrUJBGn2vUH1UR3OPTAuN/Q+khfW6r7FRV+4klOWrSI=;
 b=XVcf+IUd8/e9YcAFLZr0zMI92ctUlPR1vO6975l9L8N7/nfx7kARm2+YZ924N0W7Ddu/QJ
 W507wajatS8g7U5bex7isxzyTeTsczzYAVix0Tk8zW6zAWaX+QJyNnPRLh+toewEwg66VZ
 NvqVMDnAYbhooUhm88hAZAiMegWKlBQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-unVLsp4HMbum1UhllGDX8A-1; Fri,
 13 Nov 2026 09:31:46 -0500
X-MC-Unique: unVLsp4HMbum1UhllGDX8A-1
X-Mimecast-MFC-AGG-ID: unVLsp4HMbum1UhllGDX8A_1794580305
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 102DF1955F14; Fri, 13 Nov 2026 14:31:45 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F24844B; Fri, 13 Nov 2026 14:31:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL v2 4/6] iotests: Add new nbd-robustness test
Date: Fri, 13 Nov 2026 08:30:32 -0600
Message-ID: <20261113143132.2414774-12-eblake@redhat.com>
In-Reply-To: <20261113143132.2414774-8-eblake@redhat.com>
References: <20261113143132.2414774-8-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
---
 tests/qemu-iotests/tests/nbd-robustness     | 132 ++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-robustness.out |   5 +
 2 files changed, 137 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-robustness
 create mode 100644 tests/qemu-iotests/tests/nbd-robustness.out

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
2.56.0


