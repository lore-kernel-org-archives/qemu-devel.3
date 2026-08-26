Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FCDC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzGwo-0006Ua-6P; Wed, 26 Aug 2026 12:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwm-0006Sn-42
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:56 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wzGwk-00034K-5Y
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 12:57:55 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c25366c9b42so6491966b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787763472; x=1788368272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IuftN2fEp9SnVagrlzn2dqlH7W1Bg2kkfW1a6i9OQzo=;
 b=H72UZRDu5nCzFTl4xqhyETAmOVt46q27N82nyrhEdb45HTaOnP7tKVOvQMbnZ/cPk+
 GIYJpSMXJfbSqsFqKaU+9/2JFHqEOLB7DUVjQut0aeXrAqpdlfmmOKvVMtghwZXsXsmF
 Pzoed8Lzr7MUHuRigKNLP+5YyWCb7xNVg4IcJ8KGlbMUKqZh3a3a4mvvJXcuNSS5B7n6
 h695kuhjkj/vzJAMsUNksI2XzroVSAJxJDWGgo5zmkO6DbmLX4J7rU4GYcTt0JAm9q6p
 gIoVjQfkPuHdnLcKcSbUOqN9EM7on5/iVo6pZC27IVdNdz8pQzXCuPNO4OeOiZ1jMUll
 9stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787763472; x=1788368272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IuftN2fEp9SnVagrlzn2dqlH7W1Bg2kkfW1a6i9OQzo=;
 b=eP1HqmFQjHxYH7phqy3CUjGLZpnmp0IeB0iecVIZC/FQROYFM5SC5qPkpZyuxomcNg
 8l7sHIXMmhWNFTRrAhuSD2rAxSbow2fVQwT+JOZqcpiybjCBFQs/nvmpCtZTdiDa8r+s
 OxUWad6AIe5cIRsQCAMXqQ7eSsT5sXi2tIgQ7CkfsV4glflonBB6cGqSAq8Tdjv9HBEw
 u5f75yZTHfRB+qwCm5FNZ0TAX2X4IKBOhSEVDLaN5TMsvA/72iUXgqNjbcR0LMgXXc4g
 rv3FuaMQ1gkZn5dD+13OLnUiPFTSDzyd/f4YSwswFaYtEkVJvXsxwgSsv66hZsJtEbhZ
 V+VA==
X-Gm-Message-State: AFuF++krcU1yzV3oZtmXhsdkXm+/WGGnwBxq+3/gaY9vn831knSi51g9
 fy5CEZP3BcloUibu+p37wz5ObblNGkX44Z2SfbLyNzCmrHedLMnIRovaxkNa9N9eMzHja9D1iT1
 48+/i
X-Gm-Gg: AR+sD10S5Mief1f8jXth7ksqNEwnHrWHu0YE7SL8r+LoF2j2DvLXZzv63IH2JFShNUV
 b1JFQo1Tu0hO5laX8NDeopPZn7fIgOzsotAKD7P9UB+sZPccwh+z4RiuOwHxq5/a83I3g3FkTov
 SrmKwp19J+gYaVBhyjpHuj+HiEtB/B4WpkGHXKe0iNWU93osVK7ZAXs5O1qoUbrYQ9Y6EoJBRqV
 pJSce5J5bFQxeE9E+AuKugD9OZYnOgHHPm+z9dpK6s+85enosN7KJcqzbda3mJalQzgBKZZyhzQ
 NBDPBV2DFdoQYufrJ/n6JxxsSNH+Axfh0qyuAcbwPLnBFExSrqRVPrL8hRT7yoKd+14Qv1VpsJQ
 5ViUd4iDsazpuxz57P8YFB8khC/6RXQ7e3doeoXEnHfCmBmOZmKu0lvr2fN8t7SjdLNoK7Te9C1
 1fSFDDPmt+O5N6QfIuxqb5Ej3/wvns51xP3C5hv6hGEhpD0IVUBoMmytNlZXkJCaINF+Y=
X-Received: by 2002:a17:907:1c87:b0:c21:180c:d82d with SMTP id
 a640c23a62f3a-c250c3bfa5dmr1021714366b.20.1787763471800; 
 Wed, 26 Aug 2026 09:57:51 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:8a5:68e8:91b1:8a17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac46sm650557766b.29.2026.08.26.09.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:57:51 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/5] iotests: add coverage for NBD transmission commands
Date: Wed, 26 Aug 2026 18:57:43 +0200
Message-ID: <20260826165747.3768674-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826165747.3768674-1-den@openvz.org>
References: <20260826165747.3768674-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=den@openvz.org; helo=mail-ej1-x634.google.com
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
 tests/qemu-iotests/tests/nbd-commands     | 136 ++++++++++++++++++++++
 tests/qemu-iotests/tests/nbd-commands.out |   5 +
 2 files changed, 141 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-commands
 create mode 100644 tests/qemu-iotests/tests/nbd-commands.out

diff --git a/tests/qemu-iotests/tests/nbd-commands b/tests/qemu-iotests/tests/nbd-commands
new file mode 100755
index 0000000000..73baeb236f
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-commands
@@ -0,0 +1,136 @@
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
+from contextlib import contextmanager
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
+    def tearDown(self):
+        self.vm.shutdown()
+        for f in (top, base, nbd_sock):
+            try:
+                os.remove(f)
+            except OSError:
+                pass
+
+    @contextmanager
+    def open_nbd(self, structured=True, extended=True):
+        h = nbd.NBD()
+        h.set_request_structured_replies(structured)
+        h.set_request_extended_headers(extended)
+        h.add_meta_context('base:allocation')
+        h.add_meta_context('qemu:allocation-depth')
+        # Let the server, not libnbd, reject the out of range requests below
+        h.set_strict_mode(h.get_strict_mode() &
+                          ~(nbd.STRICT_BOUNDS | nbd.STRICT_PAYLOAD))
+        try:
+            h.connect_uri(nbd_uri)
+            self.assertEqual(h.get_structured_replies_negotiated(), structured)
+            self.assertEqual(h.get_extended_headers_negotiated(), extended)
+            yield h
+        finally:
+            h.shutdown()
+
+    def allocation_depth(self, h):
+        extents = []
+
+        def cb(meta, offset, entries, err):
+            if meta == 'qemu:allocation-depth':
+                extents.extend(zip(entries[0::2], entries[1::2]))
+
+        h.block_status(size, 0, cb)
+        return extents
+
+    def top_extents(self):
+        """Which parts of the top image are local, once qemu has let go."""
+        self.vm.shutdown()
+        return [(e['start'], e['length'], e['depth'])
+                for e in qemu_img_map(top)]
+
+    def test_cache_copies_on_read(self):
+        with self.open_nbd() as h:
+            maximum = h.get_block_size(nbd.SIZE_MAXIMUM)
+            self.assertLess(maximum, size)
+            self.assertEqual(self.allocation_depth(h),
+                             [(size, DEPTH_BACKING)])
+
+            h.cache(maximum, 0)
+
+        self.assertEqual(self.top_extents(),
+                         [(0, maximum, 0), (maximum, size - maximum, 1)])
+        qemu_io('-c', f'read -P {pattern} 0 {size}', top)
+
+    def test_cache_past_end_of_export(self):
+        with self.open_nbd() as h:
+            self.assertRaises(nbd.Error, h.cache, size + 1, 0)
+
+    def test_read_bound_by_max_payload(self):
+        with self.open_nbd() as h:
+            maximum = h.get_block_size(nbd.SIZE_MAXIMUM)
+            self.assertRaises(nbd.Error, h.pread, maximum + 65536, 0)
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


