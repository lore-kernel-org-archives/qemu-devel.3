Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA1C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6RZu-0000ij-IP; Tue, 15 Sep 2026 07:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6RZM-0000fB-8t
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:43:26 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6RZ3-0005Pp-N3
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 07:43:11 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso24913655e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 04:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789472584; x=1790077384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CrNy0DGUAMNQACpRIKae6EFwhUPs4CrGUyns6CD/7LI=;
 b=WcmrLTsA2KVXO4MiCxo48oY8g2AtQrqzKyzPK8OD0yW64xrzz315M7FxrmxSuXm0G+
 GTWg8YlPdfN0m6AI3SSkKgwVp2r4tv7kzJnqoM1Xrl0xGknmXWBSkGOnV0vqDoqIVZmL
 fNCXzE63LsfH8RwNd+pJXXnrOAGTlpMzVdBHPEzKaEDRBtLCaVshcISE+B4xIzlfAuSX
 pjEpwGfaUPFWULdrVfT0bkT9hzIn3UcewyG4h7l+ISmf7i1Lay3pMQeZEY6iyDNN2EiQ
 svnfmOfx1BIvafx4SMnd/e0iB2u3LcnODY1Or0JJFW76/+NuCCB/1t4sRn+aCbLUNzkW
 A5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789472584; x=1790077384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CrNy0DGUAMNQACpRIKae6EFwhUPs4CrGUyns6CD/7LI=;
 b=Bnb/nHqp8a6qA6iGfoJ31L10uQt5spKorWGCb0JVA2+7HeLRQDv/fURtt6tHEvqy+q
 u34DG+zFQxL6A9GFEuicStOFcG5szcDWQqMB3qpgbnr+qC38a/4QqweeF/T6EntBqczi
 GE3oWJx8qxmzq5RM4QSOgQENfkEuE5E6n+6/AE70mmjmKrMrX+MhZQPPaQL7cpyuIP9E
 1XaoXZP0I3n+XOayRaLzM0wt93SFEzNAkFUgtUHpr4p91NfhRurytyplQ+69YLhFqP+O
 9pjmGASLWPAvWlvGLXpgeG/gEw3MhGI72hCCvZuJnDVoafWITdBvw0UzwLkt9IeCDk+c
 YKzA==
X-Gm-Message-State: AFuF++lEo1IA38NDEEkxao2irNd7zyvsO6uryIXiCF37asaQ0G3U4cKx
 3RkuKG/oXGxsG3BaTWPYXNYK7qgwPVshJysZMe/scGLtOYuH3WOtOhr4TMML6rrKUdrk01tXcT0
 7CvX+
X-Gm-Gg: AYBFou04r7jo42xY0Ems4WiU877JDtJvO3ELyIysADf7eq29On+fNICo0at764q3poX
 M54gjXOJyrPRZE+WBp2xpj9VrLEYh6TBRgSzG2+dYAs4k60LaLqieneR0N1ZJhs179ZGDmEImB/
 N8w0s60xyOEI1sjsyqaClJnffTnXM4bg3H/jTZz25oHMpaHoD/NfVH1pfp98CwCbCrc3Nse9y97
 FEURgC0JTQ5tQxF4XAvKQ6F+tiuPXsMd5YOSPkr6VQGNlmw+Ut0z/Dbd+BQL40O/bTmLkoGcgkL
 wHoETflAxPWsCxC5hm3Al9ajkFmvSgY/Yj0hwSBs57jqKsKylG5+pZGQa4p21Nc/POiNq0WUKPs
 qQZ3DY6PuOxtf/88pZAQQ5vem4HaS22ZcuVPq43Ne4HkMJRNRJAklBLAiD+8nDn0L/PzwTXOmYB
 byzP0lz9YYnmq0hMm2Zvi9t4xQaJCwtHDPYsW7M+mX+ZW0mdSEmb7d6YQpMMxW4NpSJgAqU0ZGz
 Kv93BU=
X-Received: by 2002:a05:600c:4ecd:b0:49d:2450:68ac with SMTP id
 5b1f17b1804b1-49e7a64ad0bmr157000595e9.5.1789472583777; 
 Tue, 15 Sep 2026 04:43:03 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:33e6:6107:4678:322f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e4b5sm33648081f8f.22.2026.09.15.04.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:43:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 2/3] iotests: cover storing a parallels dirty bitmap
Date: Tue, 15 Sep 2026 13:42:57 +0200
Message-ID: <20260915114258.3862446-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915114258.3862446-1-den@openvz.org>
References: <20260915114258.3862446-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
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

From: Denis V. Lunev <den@openvz.org>

parallels-bitmap covers loading a bitmap and parsing the Format
Extension. Storing one is the other direction and is not covered at all.

Nothing compares a stored bitmap with the writes it describes: test 165
compares a hash across a VM restart, which the same code produces and
consumes, so a serialization wrong in both directions passes it. Write
known ranges and read the bitmap back over NBD, in the shapes the
storage code decides between: short ranges, a chunk dirty as a whole, a
dirty run shorter than the cluster which serializes it, and a dirty
tail.

A bitmap which does not fit is refused when it is created, as the L1
table shares the Format Extension cluster with the feature headers of
the bitmaps already there. One which fits an empty cluster does not fit
next to seven others, and those seven have to survive the refusal.

The rest is read out of the image file, as that is what the next open
will see: a removal has to reach it when the command is given rather
than when the node is closed, and the in use flag has to go with an
inactivation and come back when the node is activated again. A bitmap
which can not be written used to be lost in silence, so blkdebug fails
the write of its data cluster: the loss has to be reported while the
guest data still goes through, and the flag has to survive the failed
inactivation.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qemu-iotests/tests/parallels-bitmap     | 178 +++++++++++++++++-
 tests/qemu-iotests/tests/parallels-bitmap.out |  45 +++++
 2 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/parallels-bitmap b/tests/qemu-iotests/tests/parallels-bitmap
index 814b56b32c..be0ba8185d 100755
--- a/tests/qemu-iotests/tests/parallels-bitmap
+++ b/tests/qemu-iotests/tests/parallels-bitmap
@@ -25,7 +25,8 @@ import uuid
 from qemu.utils import VerboseProcessError
 
 import iotests
-from iotests import qemu_nbd_popen, qemu_img, qemu_img_map, log, file_path
+from iotests import qemu_nbd_popen, qemu_img, qemu_img_create, qemu_img_map, \
+    qemu_io, log, file_path, QemuStorageDaemon
 
 iotests.script_initialize(supported_fmts=['parallels'])
 
@@ -258,3 +259,178 @@ def check_multi_l1():
 
 
 check_multi_l1()
+
+
+# Storing a bitmap. The driver has to produce the extension itself here,
+# so the images are real ones rather than hand crafted clusters.
+
+INUSE_MAGIC = 0x746F6E59
+INUSE_OFF = 0x2c
+EXT_OFF = 0x38
+TRACKS_OFF = 0x1c
+
+stored = file_path('stored')
+copy = file_path('copy')
+STORED = '9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69'
+OTHER = '11111111-2222-3333-4444-555555555555'
+
+
+def read_header(off, fmt):
+    with open(stored, 'rb') as f:
+        return struct.unpack_from(fmt, f.read(0x40), off)[0]
+
+
+def in_use():
+    return read_header(INUSE_OFF, '<I') == INUSE_MAGIC
+
+
+def bitmaps_in_file():
+    """The bitmaps the image file holds right now, node open or not."""
+    ext_off = read_header(EXT_OFF, '<Q') * 512
+    if ext_off == 0:
+        return []
+    with open(stored, 'rb') as f:
+        f.seek(ext_off)
+        ext = f.read(read_header(TRACKS_OFF, '<I') * 512)
+
+    names, pos = [], EH_SIZE
+    while pos + FH_SIZE <= len(ext):
+        magic, _, data_size, _ = struct.unpack_from('<QQII', ext, pos)
+        if magic == 0:
+            break
+        if magic == BITMAP_MAGIC:
+            names.append(struct.unpack_from('<16s', ext, pos + FH_SIZE + 8)[0])
+        pos += FH_SIZE + ((data_size + 7) & ~7)
+    return names
+
+
+def bitmaps_reported():
+    info = iotests.qemu_img_info('-f', iotests.imgfmt, stored)
+    data = info.get('format-specific', {}).get('data', {})
+    return [b['name'] for b in data.get('bitmaps', [])]
+
+
+def make_image(*bitmaps, size='8M', cluster_size=None):
+    opts = ['-o', f'cluster_size={cluster_size}'] if cluster_size else []
+    qemu_img_create('-f', iotests.imgfmt, *opts, stored, size)
+    for name in bitmaps:
+        qemu_img('bitmap', '--add', '-f', iotests.imgfmt, stored, name)
+
+
+def refuse(reason, size):
+    """Add a fine grained bitmap which the Format Extension can not hold."""
+    log(f'--- {reason}')
+    make_image(size=size, cluster_size=512)
+    res = qemu_img('bitmap', '--add', '-g', '512', '-f', iotests.imgfmt,
+                   stored, STORED, check=False)
+    log(iotests.filter_testfiles(res.stdout).strip())
+
+
+def open_node():
+    daemon = QemuStorageDaemon(qmp=True)
+    daemon.cmd('blockdev-add',
+               {'driver': iotests.imgfmt, 'node-name': 'n0',
+                'file': {'driver': 'file', 'filename': stored}})
+    return daemon
+
+
+def stored_dirty(name, size, *writes):
+    """Dirty the given ranges, then read the stored bitmap back over NBD."""
+    log(f'--- {name}')
+    make_image(STORED, size=size)
+    qemu_io('-f', iotests.imgfmt,
+            *[arg for w in writes for arg in ('-c', w)], stored)
+
+    opts = f'driver=nbd,server.type=unix,server.path={nbd_sock}' \
+           f',x-dirty-bitmap=qemu:dirty-bitmap:{STORED}'
+    with qemu_nbd_popen('--read-only', f'--socket={nbd_sock}',
+                        f'--bitmap={STORED}', '-f', iotests.imgfmt, stored):
+        mapping = qemu_img_map('--image-opts', opts)
+
+    for chunk in mapping:
+        if not chunk['data']:
+            log('    dirty %d MiB + %d KiB' % (chunk['start'] // (1 << 20),
+                                               chunk['length'] // 1024))
+
+
+# A bitmap is stored as an L1 table of clusters holding its serialized
+# bits, with an entry of one standing for a chunk which is dirty as a
+# whole. Both of those have to describe exactly what was written.
+stored_dirty('three separate ranges', '64M',
+             'write -P 0x11 0 64k', 'write -P 0x22 4M 128k',
+             'write -P 0x33 40M 64k')
+stored_dirty('the whole image', '8M', 'write -P 0x11 0 8M')
+stored_dirty('less than a cluster', '4M', 'write -P 0x11 0 1M')
+stored_dirty('the tail of the image', '8M', 'write -P 0x11 6M 2M')
+
+# The L1 table shares the Format Extension cluster with the feature
+# headers and the end of features marker, and a small cluster with a fine
+# granularity does not leave room for it. The marker needs room of its own
+# behind the L1 table, so a bitmap which fills the cluster to within a
+# header of the end can not be stored either.
+refuse('a bitmap too large for the Format Extension cluster', '4G')
+refuse('a bitmap leaving no room for the end of features marker', '104M')
+
+# The cluster holds every bitmap of the image at once, so what still fits
+# depends on what is stored there already.
+log('--- a bitmap which does not fit next to the ones already stored')
+make_image(size='64M', cluster_size=512)
+for i in range(1, 9):
+    bm_uuid = '9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a%02d' % i
+    add_out = qemu_img('bitmap', '--add', '-f', iotests.imgfmt, stored,
+                       bm_uuid, check=False)
+    if add_out.returncode != 0:
+        log('    bitmap %d refused' % i)
+        log('    ' + iotests.filter_testfiles(add_out.stdout).strip())
+        break
+
+log('--- the ones which did fit are all still there')
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- removing a bitmap reaches the image right away')
+make_image(STORED, OTHER)
+qsd = open_node()
+log(f'    stored before: {len(bitmaps_in_file())} bitmaps')
+qsd.cmd('block-dirty-bitmap-remove', {'node': 'n0', 'name': STORED})
+log(f'    stored after:  {len(bitmaps_in_file())} bitmaps, '
+    'without a clean close')
+qsd.stop()
+
+log('--- the in use flag comes back when a node is activated again')
+make_image(STORED)
+qsd = open_node()
+log(f'    in use while open:         {in_use()}')
+qsd.cmd('blockdev-set-active', {'node-name': 'n0', 'active': False})
+log(f'    in use after deactivation: {in_use()}')
+qsd.cmd('blockdev-set-active', {'node-name': 'n0', 'active': True})
+log(f'    in use after activation:   {in_use()}')
+qsd.stop()
+
+# The bitmap data cluster is allocated right behind the only data cluster,
+# so it starts at sector 4096 of a 4M image with the default cluster size.
+log('--- a bitmap which can not be written is reported, not lost in silence')
+make_image(STORED, size='4M')
+err_opts = (f'driver={iotests.imgfmt},file.driver=blkdebug,'
+            f'file.image.driver=file,file.image.filename={stored},'
+            f'file.inject-error.0.event=none,'
+            f'file.inject-error.0.iotype=write,'
+            f'file.inject-error.0.sector=4096')
+err_out = qemu_io('--image-opts', err_opts, '-c', 'write -P 0x11 0 64k',
+                  check=False)
+for err_line in iotests.filter_generated_node_ids(err_out.stdout).splitlines():
+    if 'Lost persistent bitmaps' in err_line:
+        log('    ' + err_line.strip())
+log(f'    in use after the failure:  {in_use()}')
+
+log('--- but the guest data went through, and the image says it is in use')
+read_out = qemu_io('-f', iotests.imgfmt, '-r', '-c', 'read -P 0x11 0 64k',
+                   stored)
+log(read_out.stdout, filters=[iotests.filter_generated_node_ids,
+                              iotests.filter_testfiles,
+                              iotests.filter_qemu_io])
+log('    %d bitmaps stored' % len(bitmaps_reported()))
+
+log('--- and the image is still readable')
+info_out = qemu_img('info', '-f', iotests.imgfmt, stored, check=False)
+log('image opened' if info_out.returncode == 0
+    else iotests.filter_testfiles(info_out.stdout).strip())
diff --git a/tests/qemu-iotests/tests/parallels-bitmap.out b/tests/qemu-iotests/tests/parallels-bitmap.out
index ebfc0acb4d..994c67390e 100644
--- a/tests/qemu-iotests/tests/parallels-bitmap.out
+++ b/tests/qemu-iotests/tests/parallels-bitmap.out
@@ -47,3 +47,48 @@ image opened
 Start NBD server
 dirty 32-64 GiB
 Kill NBD server
+--- three separate ranges
+Start NBD server
+Kill NBD server
+    dirty 0 MiB + 64 KiB
+    dirty 4 MiB + 128 KiB
+    dirty 40 MiB + 64 KiB
+--- the whole image
+Start NBD server
+Kill NBD server
+    dirty 0 MiB + 8192 KiB
+--- less than a cluster
+Start NBD server
+Kill NBD server
+    dirty 0 MiB + 1024 KiB
+--- the tail of the image
+Start NBD server
+Kill NBD server
+    dirty 6 MiB + 2048 KiB
+--- a bitmap too large for the Format Extension cluster
+qemu-img: Operation add on bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69 failed: Bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69 with granularity 512 does not fit into the Format Extension cluster: every bitmap of the image would need 16464 bytes of it, 488 are available
+--- a bitmap leaving no room for the end of features marker
+qemu-img: Operation add on bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69 failed: Bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69 with granularity 512 does not fit into the Format Extension cluster: every bitmap of the image would need 496 bytes of it, 488 are available
+--- a bitmap which does not fit next to the ones already stored
+    bitmap 8 refused
+    qemu-img: Operation add on bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a08 failed: Bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a08 with granularity 65536 does not fit into the Format Extension cluster: every bitmap of the image would need 536 bytes of it, 488 are available
+--- the ones which did fit are all still there
+    7 bitmaps stored
+--- removing a bitmap reaches the image right away
+    stored before: 2 bitmaps
+    stored after:  1 bitmaps, without a clean close
+--- the in use flag comes back when a node is activated again
+    in use while open:         True
+    in use after deactivation: False
+    in use after activation:   True
+--- a bitmap which can not be written is reported, not lost in silence
+    qemu-io: Lost persistent bitmaps during inactivation of node 'NODE_NAME': Can't save dirty bitmap 9b7b8b2e-1c4a-4d3f-8e6a-1f2d3c4b5a69: IO error: Input/output error
+    in use after the failure:  True
+--- but the guest data went through, and the image says it is in use
+qemu-io: warning: Dropping the Format Extension of node 'NODE_NAME', which does not look like one: Wrong parallels Format Extension magic: 0x1111111111111111, expected: 0xab234cef23dcea87
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+    0 bitmaps stored
+--- and the image is still readable
+image opened
-- 
2.53.0


