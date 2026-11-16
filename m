Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145C4606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=lut3L/m0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3G7-0000Je-EQ; Mon, 16 Nov 2026 15:24:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Fh-00086r-OZ; Mon, 16 Nov 2026 15:24:35 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Fe-0004St-Il; Mon, 16 Nov 2026 15:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860377; bh=8FslejbiorBmxhMExlCo4mCX+3blUCGOc18RZeMs9ys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lut3L/m0mczEv+/evtjiEChfo8y38QrLuNEtCHnwXlFWfZo83x1UeHj9pdP8854+9
 85AXG8RF1kif99guAnj6/FGHOVTyO/mZMH7zxpVFKZYNGiCoyYXtfElbdoSTsqy3J8
 sUEeKF9AQBBKOq8bZQYUy81QlJ3ICFGd4vlqMZnUgMoTuB847dNpQ+Z5a60giI0oin
 VMaNgLriDhs30gGNKaJOlioj6HyYpJ/uloCdOaObaYWd14Nty/bF7T1UC5kYBtVaZU
 JNPAOthifgw7nH/HAJqoUWdCp7zeV+eJPc8oIE7JpALn4r6Zie9A50Tc0Fe2S0EYQr
 BouNbcMJMqdog==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E988F1E7175;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E606D45FBB5;
 Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A913FB8E44; Mon, 16 Nov 2026 23:19:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 59/59] iotests: Add another nbd-robustness test
Date: Mon, 16 Nov 2026 23:19:03 +0300
Message-ID: <20261116201922.534306-59-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
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

Convert the proof of concept test by TonySD into another case of the
iotest. This is yet another instance where a hard-coded exchange is
easier than forcing libnbd into producing an exchange that violates
the protocol.  Swapping the order with the previous patch shows the
assertion failure that was previously reachable.

Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/4843
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261110155356.1520433-12-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit e682c0e570179bd7fa01ea896358a8cdad196a3b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/nbd-robustness b/tests/qemu-iotests/tests/nbd-robustness
index fe61a839250..410dfca04e3 100755
--- a/tests/qemu-iotests/tests/nbd-robustness
+++ b/tests/qemu-iotests/tests/nbd-robustness
@@ -21,6 +21,7 @@ NBD_MAGIC_REPLY = 0x0003e889045565a9         # Reply magic
 NBD_MAGIC_EXT_REPLY = 0x6e8a278c             # Structured reply magic
 NBD_FLAG_C_FIXED_NEWSTYLE = 0x1
 NBD_OPT_GO = 7
+NBD_OPT_STRUCTURED_REPLY = 8
 NBD_OPT_SET_META_CONTEXT = 10
 NBD_OPT_EXTENDED_HEADERS = 11
 NBD_REP_ACK = 1
@@ -128,5 +129,77 @@ class TestNbdRobustness(iotests.QMPTestCase):
 
             self.assertTrue(self.vm.is_running())
 
+    def test_invalid_set_meta_context(self):
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
+                # Request NBD_OPT_STRUCTURED_REPLY, no extra payload
+                s.sendall(struct.pack(">QII", NBD_MAGIC_OPTS,
+                                      NBD_OPT_STRUCTURED_REPLY, 0))
+
+                # Expect successful reply:
+                # magic(8) + option(4) + reply(4) + length(4)
+                data = self.recv_exact(s, 20)
+                magic, opt, reply, length = struct.unpack(">QIII", data)
+                self.assertEqual(magic, NBD_MAGIC_REPLY)
+                self.assertEqual(opt, NBD_OPT_STRUCTURED_REPLY)
+                self.assertEqual(reply, NBD_REP_ACK)
+                self.assertEqual(length, 0)
+
+                # Request NBD_OPT_SET_META_CONTEXT with invalid length
+                # namelen(4) + str + queries(4) + {querylen(4) + str)
+                payload = struct.pack(">I", 1) + b'r'
+                payload += struct.pack(">II", 1, 1) + b'X'
+                s.sendall(struct.pack(">QII", NBD_MAGIC_OPTS,
+                                      NBD_OPT_SET_META_CONTEXT,
+                                      len(payload) + 1) + payload)
+
+                # Request NBD_OPT_GO, name but no info as payload
+                # (request is early, but does not hurt here)
+                payload = struct.pack(">I", 1) + b'r' + struct.pack(">H", 0)
+                s.sendall(struct.pack(">QII", NBD_MAGIC_OPTS, NBD_OPT_GO,
+                                      len(payload)) + payload)
+
+                # Expect error reply to SET_META_CONTEXT:
+                # magic(8) + option(4) + reply(4) + length(4)
+                data = self.recv_exact(s, 20)
+                magic, opt, reply, length = struct.unpack(">QIII", data)
+                self.assertEqual(magic, NBD_MAGIC_REPLY)
+                self.assertEqual(opt, NBD_OPT_SET_META_CONTEXT)
+                self.assertEqual(reply & 0x80000000, 0x80000000)
+                self.recv_exact(s, length)
+
+                # Expect early disconnect for unaligned GO. Could show up as
+                # either b'' or ConnectionResetError
+                try:
+                    data = s.recv(1)
+                    self.assertEqual(data, b'')
+                except ConnectionResetError:
+                    pass
+
+                # Further writes must trigger an error (EPIPE / ECONNRESET)
+                with self.assertRaises((BrokenPipeError, ConnectionResetError,
+                                        OSError)):
+                    s.sendall(b'X')
+
+            # QEMU should still be up
+            self.assertIsNone(self.vm.exitcode())
+            self.assertTrue(self.vm.is_running())
+            res = self.vm.cmd('query-status')
+            self.assertEqual(res['status'], 'running')
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/tests/nbd-robustness.out b/tests/qemu-iotests/tests/nbd-robustness.out
index ae1213e6f86..fbc63e62f88 100644
--- a/tests/qemu-iotests/tests/nbd-robustness.out
+++ b/tests/qemu-iotests/tests/nbd-robustness.out
@@ -1,5 +1,5 @@
-.
+..
 ----------------------------------------------------------------------
-Ran 1 tests
+Ran 2 tests
 
 OK
-- 
2.47.3


