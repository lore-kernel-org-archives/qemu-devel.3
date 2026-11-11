Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386BA606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TfRcutKB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzNt-0008UM-22; Tue, 10 Nov 2026 22:52:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNr-0008QG-MP
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNp-0007Ni-Iv
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794369144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQey4jsGrhUt0ZwEtQIa2PPXxdz1oC6d1Y293m8BGtI=;
 b=TfRcutKBpP42meMww//+dLD1CPNYZA2mlXniob6tLCqbQZ3uFAVgoayFQ5bbJ8bxbJxDRB
 ZhE4wcEOcxathVSCBmp9iz6jj/Sh8WrO+oIdbx8r/P/NMuN+dvsssod8GqtBBJnoi2PFgF
 IfxRz2Ii85ozTI3btrMR+iJIsg0DOiM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-6TYNEQf6ND2ou5za189I5g-1; Tue,
 10 Nov 2026 22:52:21 -0500
X-MC-Unique: 6TYNEQf6ND2ou5za189I5g-1
X-Mimecast-MFC-AGG-ID: 6TYNEQf6ND2ou5za189I5g_1794369140
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84BFD1800562; Wed, 11 Nov 2026 03:52:20 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D194B3001DA0; Wed, 11 Nov 2026 03:52:18 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 8/8] iotests: Add another nbd-robustness test
Date: Tue, 10 Nov 2026 21:51:33 -0600
Message-ID: <20261111035200.1751734-18-eblake@redhat.com>
In-Reply-To: <20261111035200.1751734-10-eblake@redhat.com>
References: <20261111035200.1751734-10-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Convert the proof of concept test by TonySD into another case of the
iotest. This is yet another instance where a hard-coded exchange is
easier than forcing libnbd into producing an exchange that violates
the protocol.  Swapping the order with the previous patch shows the
assertion failure that was previously reachable.

Based-on: https://gitlab.com/qemu-project/qemu/-/work_items/4843
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20261110155356.1520433-12-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/tests/nbd-robustness     | 73 +++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-robustness.out |  4 +-
 2 files changed, 75 insertions(+), 2 deletions(-)

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
2.56.0


