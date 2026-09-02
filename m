Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17258C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gdf-0005n4-Gg; Wed, 02 Sep 2026 04:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdd-0005lR-Mn; Wed, 02 Sep 2026 04:48:09 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x1gdb-0007Ab-A1; Wed, 02 Sep 2026 04:48:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 6CB1282A51;
 Wed, 02 Sep 2026 11:48:03 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:b72::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id xlfWR5raWmI0-O2q1Wxsv; Wed, 02 Sep 2026 11:48:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1788338882;
 bh=exZaTsdYoGch2d7FjN2q4hJoPa32EIkgrsRAXKpiKzU=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xIspBOaGVTV/UeE4IUN6zjixBwXIykitnpyr/uTeO3+YXg6rtwLmnS9zSUk3OAigN
 Tk+7pgb7PUB2Udt1kqP0vA01gtZnhP76qGO08JXBSeYmibjN3IG1To/JUES9HiQ4T0
 0QAVV9+xgTbe8MYCirwm1ol/18Sn5qBO5lObsQTo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, vsementsov@yandex-team.ru,
 Eric Blake <eblake@redhat.com>
Subject: [PULL 4/8] iotests: add coverage for NBD transmission commands
Date: Wed,  2 Sep 2026 11:47:50 +0300
Message-ID: <20260902084754.140103-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902084754.140103-1-vsementsov@yandex-team.ru>
References: <20260902084754.140103-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
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

NBD_CMD_CACHE has no coverage anywhere in the tree. Nothing ever
sends it: our own NBD client does not implement the command, and
neither qemu-io nor 'qemu-nbd --list' can issue one, so the only
clients reaching this server path are external ones.

Add a test driven by libnbd, gated the way nbd-multiconn already is,
and start it with the case the command exists for. The export is a
qcow2 image over a fully written backing file, so a prefetch has
visible work to do.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260827161002.310688-2-den@openvz.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/nbd-commands     | 140 ++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |   5 +
 2 files changed, 145 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-commands
 create mode 100644 tests/qemu-iotests/tests/nbd-commands.out

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
new file mode 100755
index 00000000000..4c1cd33db74
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -0,0 +1,140 @@
+#!/usr/bin/env python3
+# group: rw auto quick
+#
+# Test NBD transmission commands against a qemu NBD export
+#
+# Copyright (C) 2026 Virtuozzo International GmbH
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+from types import ModuleType
+
+import iotests
+from iotests import qemu_img_create, qemu_img_map, qemu_io
+
+
+base = os.path.join(iotests.test_dir, 'base')
+top = os.path.join(iotests.test_dir, 'top')
+# Larger than the maximum payload size an export can advertise
+size = 64 * 1024 * 1024
+pattern = 0xa5
+nbd_sock = os.path.join(iotests.sock_dir, 'nbd_sock')
+nbd_uri = 'nbd+unix:///exp?socket=' + nbd_sock
+nbd: ModuleType
+
+DEPTH_LOCAL = 1
+DEPTH_BACKING = 2
+
+
+class TestNbdCommands(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img_create('-f', iotests.imgfmt, base, str(size))
+        qemu_io('-c', f'write -P {pattern} 0 {size}', base)
+        qemu_img_create('-f', iotests.imgfmt, '-b', base,
+                        '-F', iotests.imgfmt, top, str(size))
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+        self.vm.cmd('blockdev-add', {
+            'driver': iotests.imgfmt,
+            'node-name': 'n',
+            'file': {'driver': 'file', 'filename': top},
+            'backing': {
+                'driver': iotests.imgfmt,
+                'node-name': 'base',
+                'file': {'driver': 'file', 'filename': base},
+            },
+        })
+        self.vm.cmd('nbd-server-start', {
+            'addr': {'type': 'unix', 'data': {'path': nbd_sock}}
+        })
+        self.vm.cmd('block-export-add', {
+            'type': 'nbd',
+            'id': 'exp',
+            'node-name': 'n',
+            'name': 'exp',
+            'writable': True,
+            'allocation-depth': True,
+        })
+
+        self.h = None
+        self.connect()
+
+    def tearDown(self):
+        self.disconnect()
+        self.vm.shutdown()
+        for f in (top, base, nbd_sock):
+            try:
+                os.remove(f)
+            except OSError:
+                pass
+
+    def connect(self, structured=True, extended=True):
+        self.disconnect()
+        h = nbd.NBD()
+        h.set_request_structured_replies(structured)
+        h.set_request_extended_headers(extended)
+        h.add_meta_context('base:allocation')
+        h.add_meta_context('qemu:allocation-depth')
+        # Let the server, not libnbd, reject the out of range requests below
+        h.set_strict_mode(h.get_strict_mode() &
+                          ~(nbd.STRICT_BOUNDS | nbd.STRICT_PAYLOAD))
+        h.connect_uri(nbd_uri)
+        self.assertEqual(h.get_structured_replies_negotiated(), structured)
+        self.assertEqual(h.get_extended_headers_negotiated(), extended)
+        self.h = h
+
+    def disconnect(self):
+        if self.h is not None:
+            self.h.shutdown()
+            self.h = None
+
+    def block_status(self, count=size):
+        """Map each meta context in the reply to its list of extents."""
+        reply = {}
+
+        def cb(meta, _offset, entries, _err):
+            reply.setdefault(meta, []).extend(zip(entries[0::2],
+                                                  entries[1::2]))
+
+        self.h.block_status(count, 0, cb)
+        return reply
+
+    def top_extents(self):
+        """Which parts of the top image are local, once qemu has let go."""
+        self.disconnect()
+        self.vm.shutdown()
+        return [(e['start'], e['length'], e['depth'])
+                for e in qemu_img_map(top)]
+
+    def test_cache_copies_on_read(self):
+        maximum = self.h.get_block_size(nbd.SIZE_MAXIMUM)
+        self.assertLess(maximum, size)
+        self.assertEqual(self.block_status()['qemu:allocation-depth'],
+                         [(size, DEPTH_BACKING)])
+
+        self.h.cache(maximum, 0)
+
+        self.assertEqual(self.top_extents(),
+                         [(0, maximum, 0), (maximum, size - maximum, 1)])
+        qemu_io('-c', f'read -P {pattern} 0 {size}', top)
+
+    def test_cache_past_end_of_export(self):
+        self.assertRaises(nbd.Error, self.h.cache, size + 1, 0)
+
+    def test_read_bound_by_max_payload(self):
+        maximum = self.h.get_block_size(nbd.SIZE_MAXIMUM)
+        self.assertRaises(nbd.Error, self.h.pread, maximum + 65536, 0)
+
+
+if __name__ == '__main__':
+    try:
+        # Easier to use libnbd than to try and set up parallel
+        # 'qemu-nbd --list' or 'qemu-io' processes, but not all systems
+        # have libnbd installed.
+        import nbd  # type: ignore
+
+        iotests.main(supported_fmts=['qcow2'])
+    except ImportError:
+        iotests.notrun('Python bindings to libnbd are not installed')
diff --git a/tests/qemu-iotests/tests/nbd-commands.out b/tests/qemu-iotests/tests/nbd-commands.out
new file mode 100644
index 00000000000..8d7e9967009
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -0,0 +1,5 @@
+...
+----------------------------------------------------------------------
+Ran 3 tests
+
+OK
-- 
2.43.0


