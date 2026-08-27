Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB38C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzcgD-0004ZB-SK; Thu, 27 Aug 2026 12:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcg9-0004Xx-Ts
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzcg6-0007uO-TS
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:10:13 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso12491275e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787847009; x=1788451809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QohvP1NuFolML60rOIlVMw7WVZtA/95muTj1bso9dvQ=;
 b=S+d4HHWMcYfGcXKDzbtrKBajXnVr+55GvUQw6ra2nc0/xS1xi696OUxBtVlrFsbNze
 QLBaA0JSTiAp/0N5bbc+bDpu3bOUJAj5VVdC+Q2DrroLFWYl1p255tTkoog7JAAaztT1
 IK9djovtuvHn9ii3Bp7FEEDA7j3Df3tIcecn64BMbkfX3qPK43q9X4qsjceTKrKYZPCI
 8QWGeOE44iPXi6GfjsRfUZqLcouuaWb36nwRC3HIJSZDwkeb2H2fnlO7wcZby0sm8237
 GVLhIlwDpdMf0F2rcXgT6YFs3rXvcIBr10Q8Gl6ouQtEAEpK0S8YCqDPrHakrNPRu9Ih
 Xaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787847009; x=1788451809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QohvP1NuFolML60rOIlVMw7WVZtA/95muTj1bso9dvQ=;
 b=MJSjHvD1Xek0tOuelNKM7lejbLXh8+esRnyakO4W4KQPytY5tsTxWylG5mn1+oYbnv
 eP3kXsTqN22ENMIYulhf/oPn8QHxg9GOyTj/svVXoMOZSL0tZ7Qm1YqsGM4g3jWK8tXm
 SlRbZNFtw0bxTHbgprFYpINT9sdYFZLXkeTcLdY8tfMJ4iHhdYhOaIElgzQnyHOJ32eo
 H2fWDjSff/PmibV/BGaC/nKY0v74RvtOE4CkexwiPTFs7KiEiC5OU4I3woA0exGmX+Ed
 I6xtJw6atLvoYVRokPiw4HGX1QSp27rZLHWKvutcNlT83rKMets459bt+hzEyOPp227T
 B7fQ==
X-Gm-Message-State: AFuF++k21akTEPgeL3Cn5t2/MeE6OQZW4X+csZFLLgTdplw0D/RhRDvK
 xwTpOr6DDDZEEG9zLaF+kUHd0lH+wd6XbXYH67jrVjhrhWch5T19NSGEZ9CiYoWZLhJWQeDwj5R
 yybv2
X-Gm-Gg: AR+sD104KzlB9umEd14ynAUKvZE2T2rOr9loOiLyuAKMHBXSgWOy+hOSWz14Vyp9umP
 N2saaVmZ0oNXX8A4TROtzv91WFVz7ykYNqXqscK/QP9zS1VUkbPtwauBKKZKri9LkvJzMgjqTVJ
 Lr95ZLeYT+o/yRnmEOl6Rbx3pzLD7fGnKX7NpghmIAT6PLOJNE3+1bwqec9274QWkf7kxp7ugvB
 5VOX8jJNwAyJ4m8+8Bq+2h80lpTgV69DoVVMIozeDbo/ynlBTY40BZgon/LVEKNNnZq7n3wsAUi
 9c/meLXOmbhnHzF9sTp4LKVpMS6LvaOVLGyrveQM720vdulOtBwGXoM9pgqgGpYPzrk/f3UCt6Y
 i3Z3w9GvfYZqyMKxawVBPaUraaDTtk6Ltez4LZ+fg6eLmh+E96IGOGC/dbLpOa/KvZKm3zp/Mch
 nY4uLHGkJBud4MXFxmLMJoA9KYZ79GK0xnGAfHR5fml7KlhcxY
X-Received: by 2002:a05:600c:3546:b0:499:bdf1:7578 with SMTP id
 5b1f17b1804b1-49b91c19d68mr366395e9.3.1787847009265; 
 Thu, 27 Aug 2026 09:10:09 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:e57e:de8:330d:26d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd5771a3sm71359465e9.4.2026.08.27.09.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 09:10:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 1/5] iotests: add coverage for NBD transmission commands
Date: Thu, 27 Aug 2026 18:09:58 +0200
Message-ID: <20260827161002.310688-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827161002.310688-1-den@openvz.org>
References: <20260827161002.310688-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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
---
 tests/qemu-iotests/tests/nbd-commands     | 140 ++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |   5 +
 2 files changed, 145 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-commands
 create mode 100644 tests/qemu-iotests/tests/nbd-commands.out

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
new file mode 100755
index 0000000000..4c1cd33db7
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
index 0000000000..8d7e996700
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-commands.out
@@ -0,0 +1,5 @@
+...
+----------------------------------------------------------------------
+Ran 3 tests
+
+OK
-- 
2.53.0


