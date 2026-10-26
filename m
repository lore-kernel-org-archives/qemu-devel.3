Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F09606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Psoqbzs9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJa4-0000C8-Gt; Mon, 26 Oct 2026 08:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLJa0-0000AQ-KU; Mon, 26 Oct 2026 08:13:32 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLJZw-00060k-MP; Mon, 26 Oct 2026 08:13:32 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9052B6024D;
 Mon, 26 Oct 2026 12:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03F41F031E0;
 Mon, 26 Oct 2026 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793016807;
 bh=DO7fmdKNQbyUPASIcHxOAyfnvNGc9EMQYXs1JLAEbic=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Psoqbzs9YRBEqhNkyxebIj8xTNWyWEFVNl6Mt6Avd4CQfamT2hz2Rt9IKtD9Ltf4o
 bOGXgN3MTsE2mtBJyYQxKkivKC2fYFk/ZXl9ootma9/iD6ir0Ztr77FZ4kdUZObv1j
 B666J+zDaVBEUYBYicKZbi29TujYyQFV9RoM2GK0988qqoULSXcxKwZKhPPZ1k8E7P
 A4M1B0XvMyiTDw1OtA57f8WCdKVuVJvv+4Wjoi4bugv8tLhMT9r7WHe8HdkfUCMI6G
 O9i/SA8JqwW+LM4SDwPiMmSVaiJyueL0BmwuWJcQhsKTHjSj6g8G1WyZV59dajXwN3
 Cslb/hSH32O7g==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Sam Li <faithilikerun@gmail.com>, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v15 5/7] iotests: test the zoned format feature for qcow2 file
Date: Mon, 26 Oct 2026 13:12:53 +0100
Message-ID: <20261026121259.3354561-6-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026121259.3354561-1-cassel@kernel.org>
References: <20261026121259.3354561-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sam Li <faithilikerun@gmail.com>

The zoned format feature can be tested by:
$ tests/qemu-iotests/check -qcow2 zoned-qcow2

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes by Niklas Cassel:
- drop the zone append size limit from the image the test creates
- test, on a second image with zone resource limits, that each zone
  error is reported with its own errno, and the zone resource
  management of writes, OPEN ZONE and FINISH ZONE
- test that a zoned image needs version 3 and zones of whole clusters,
  and that resetting a zone leaves the data of the other zones alone
- test that a closed zone that a write fills no longer counts as an
  active zone
- list the test in the qcow2 section of MAINTAINERS
---
 MAINTAINERS                              |   1 +
 tests/qemu-iotests/tests/zoned-qcow2     | 322 +++++++++++++++++++++++
 tests/qemu-iotests/tests/zoned-qcow2.out | 258 ++++++++++++++++++
 3 files changed, 581 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/zoned-qcow2
 create mode 100644 tests/qemu-iotests/tests/zoned-qcow2.out

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ca1751e30..f870adfb11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4518,6 +4518,7 @@ L: qemu-block@nongnu.org
 S: Supported
 F: block/qcow2*
 F: docs/interop/qcow2.rst
+F: tests/qemu-iotests/tests/zoned-qcow2*
 
 qcow
 M: Kevin Wolf <kwolf@redhat.com>
diff --git a/tests/qemu-iotests/tests/zoned-qcow2 b/tests/qemu-iotests/tests/zoned-qcow2
new file mode 100755
index 0000000000..cc89bd5337
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2
@@ -0,0 +1,322 @@
+#!/usr/bin/env bash
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Test zone management operations for qcow2 file.
+#
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+status=1 # failure is the default!
+
+file_name="zbc.qcow2"
+file_name2="zbc2.qcow2"
+_cleanup()
+{
+  _cleanup_test_img
+  _rm_test_img "$file_name"
+  _rm_test_img "$file_name2"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ../common.rc
+. ../common.filter
+. ../common.qemu
+
+# This test only runs on Linux hosts with qcow2 image files.
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+echo
+echo "=== Initial image setup ==="
+echo
+
+$QEMU_IMG create -f qcow2 $file_name -o size=768M -o zone.size=64M -o \
+zone.capacity=64M -o zone.conventional_zones=0 \
+-o zone.max_open_zones=6 -o zone.max_active_zones=8 -o zone.mode=host-managed
+
+IMG="--image-opts -n driver=qcow2,file.driver=file,file.filename=$file_name"
+# A second image, for cases 5 to 7
+IMG2="--image-opts -n driver=qcow2,file.driver=file,file.filename=$file_name2"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "=== Testing a qcow2 img with zoned format ==="
+echo
+echo "case 1: test zone operations one by one"
+
+echo "(1) report zones[0]:"
+$QEMU_IO $IMG -c "zrp 0 1"
+echo
+echo "report zones[0~9]:"
+$QEMU_IO $IMG -c "zrp 0 10"
+echo
+echo "report zones[-1]:"  # zones[-1] dictates the last zone
+$QEMU_IO $IMG -c "zrp 0x2C000000 2" # 0x2C000000 / 512 = 0x160000
+echo
+echo
+echo "(2) open zones[0], zones[1], zones[-1] then close, finish, reset:"
+$QEMU_IO $IMG << EOF
+zo 0 0x4000000
+zrp 0 1
+zo 0x4000000 0x4000000
+zrp 0x4000000 1
+zo 0x2C000000 0x4000000
+zrp 0x2C000000 2
+zc 0 0x4000000
+zrp 0 1
+zc 0x4000000 0x4000000
+zrp 0x4000000 1
+zc 0x2C000000 0x4000000
+zrp 0x2C000000 2
+zf 0 0x4000000
+zrp 0 1
+zf 64M 64M
+zrp 0x4000000 2
+zf 0x2C000000 0x4000000
+zrp 0x2C000000 2
+zrs 0 0x4000000
+zrp 0 1
+zrs 0x4000000 0x4000000
+zrp 0x4000000 1
+zrs 0x2C000000 0x4000000
+zrp 0x2C000000 2
+EOF
+
+echo
+echo "(3) append write with (4k, 8k) data"
+$QEMU_IO $IMG -c "zrp 0 12" # the physical block size of the device is 4096
+echo "Append write zones[0], zones[1] twice"
+$QEMU_IO $IMG << EOF
+zap -p 0 0x1000 0x2000
+zrp 0 1
+zap -p 0 0x1000 0x2000
+zrp 0 1
+zap -p 0x4000000 0x1000 0x2000
+zrp 0x4000000 1
+zap -p 0x4000000 0x1000 0x2000
+zrp 0x4000000 1
+EOF
+
+echo
+echo "Reset all:"
+$QEMU_IO $IMG -c "zrp 0 12" -c "zrs 0 768M" -c "zrp 0 12"
+echo
+echo
+
+echo "case 2: test a sets of ops that works or not"
+echo "(1) append write (4k, 4k) and then write to full"
+$QEMU_IO $IMG << EOF
+zap -p 0 0x1000 0x1000
+zrp 0 1
+zap -p 0 0x1000 0x1ffd000
+zap -p 0 0x1000000 0x1000000
+zrp 0 1
+EOF
+
+echo "Reset zones[0]:"
+$QEMU_IO $IMG -c "zrs 0 64M" -c "zrp 0 1"
+
+echo "(2) write in zones[0], zones[3], zones[8], and then reset all"
+$QEMU_IO $IMG << EOF
+zap -p 0 0x1000 0x1000
+zap -p 0xc000000 0x1000 0x1000
+zap -p 0x20000000 0x1000 0x1000
+zrp 0 12
+zrs 0 768M
+zrp 0 12
+EOF
+
+echo "case 3: test zone resource management"
+echo "(1) write in zones[0], zones[1], zones[2] and then close it"
+$QEMU_IO $IMG << EOF
+zap -p 0 0x1000 0x1000
+zap -p 0x4000000 0x1000 0x1000
+zap -p 0x8000000 0x1000 0x1000
+zrp 0 12
+zc 0 64M
+zc 0x4000000 64M
+zc 0x8000000 64M
+zrp 0 12
+EOF
+
+echo "(2) reset all after 3(1)"
+$QEMU_IO $IMG << EOF
+zrs 0 768M
+zrp 0 12
+EOF
+
+echo
+echo "case 4: WP cache crash consistency under concurrent appends"
+echo "(1) concurrent writes to the same sequential zone (zone 5 @ 320M)"
+# Three concurrent aio_writes at WP, WP+4K, WP+8K. Data writes are
+# permitted to complete out of order
+$QEMU_IO $IMG <<EOF
+aio_write -q -P 0xa1 0x14000000 4k
+aio_write -q -P 0xa2 0x14001000 4k
+aio_write -q -P 0xa3 0x14002000 4k
+aio_flush
+zrp 0x14000000 1
+read -q -P 0xa1 0x14000000 4k
+read -q -P 0xa2 0x14001000 4k
+read -q -P 0xa3 0x14002000 4k
+EOF
+
+echo "(2) concurrent writes to different sequential zones (zones 6, 7, 9)"
+# Spread across three zones. No per-zone interaction; each zone's WP
+# must advance independently.
+$QEMU_IO $IMG <<EOF
+aio_write -q -P 0xb1 0x18000000 4k
+aio_write -q -P 0xb2 0x1C000000 4k
+aio_write -q -P 0xb3 0x24000000 4k
+aio_flush
+zrp 0x18000000 1
+zrp 0x1C000000 1
+zrp 0x24000000 1
+read -q -P 0xb1 0x18000000 4k
+read -q -P 0xb2 0x1C000000 4k
+read -q -P 0xb3 0x24000000 4k
+EOF
+
+echo "(3) reset zones with no in-flight writes (zones 5, 6)"
+# Reset zones 5 and 6 (which we wrote in (1) and (2)). WP should drop
+# back to zone_start; data reads must return zero (unallocated
+# post-reset).
+$QEMU_IO $IMG -c "zrs 0x14000000 64M" -c "zrs 0x18000000 64M" \
+              -c "zrp 0x14000000 1" -c "zrp 0x18000000 1" \
+              -c "read -q -P 0 0x14000000 4k" \
+              -c "read -q -P 0 0x18000000 4k"
+
+echo "(4) BLKRESETALL after concurrent writes"
+# Reset everything first, refill three zones with concurrent writes,
+# then RESETALL. Each zone's WP must return to its start.
+$QEMU_IO $IMG <<EOF
+zrs 0 768M
+aio_write -q -P 0xc1 0x14000000 4k
+aio_write -q -P 0xc2 0x18000000 4k
+aio_write -q -P 0xc3 0x1C000000 4k
+aio_flush
+zrp 0x14000000 1
+zrp 0x18000000 1
+zrp 0x1C000000 1
+zrs 0 768M
+zrp 0x14000000 1
+zrp 0x18000000 1
+zrp 0x1C000000 1
+EOF
+
+echo
+echo "case 5: zone errors are reported with distinct errnos"
+$QEMU_IMG create -f qcow2 $file_name2 -o size=8M -o zone.size=1M -o \
+zone.capacity=1M -o zone.conventional_zones=0 \
+-o zone.max_open_zones=1 -o zone.max_active_zones=2 \
+-o zone.mode=host-managed > /dev/null
+echo "(1) write not at the write pointer of zones[0]"
+echo "(2) write past the capacity of zones[0]"
+echo "(3) open zone limit: zones[0] explicitly open, write zones[1]"
+echo "(4) active zone limit: zones[0] closed, zones[1] open, open zones[2]"
+$QEMU_IO $IMG2 << EOF
+write -q 4k 4k
+write -q 0 1028k
+zo 0 1M
+write -q 1M 4k
+write -q 0 4k
+zc 0 1M
+write -q 1M 4k
+write -q 2M 4k
+zo 2M 1M
+zrp 0 3
+EOF
+
+echo
+echo "case 6: zone resource accounting (max_open_zones=1, max_active_zones=2)"
+echo "(1) an empty zone is not opened beyond the active zone limit"
+$QEMU_IO $IMG2 << EOF
+zrs 0 8M
+write -q 0 4k
+zc 0 1M
+write -q 1M 4k
+zc 1M 1M
+write -q 2M 4k
+zrp 0 3
+EOF
+echo "(2) an explicit open of an empty zone respects the open zone limit"
+$QEMU_IO $IMG2 << EOF
+zrs 0 8M
+zo 0 1M
+zo 1M 1M
+zrp 0 2
+EOF
+echo "(3) at the active zone limit: open a closed zone, then an empty one"
+$QEMU_IO $IMG2 << EOF
+zrs 0 8M
+write -q 0 4k
+write -q 1M 4k
+write -q 4k 4k
+write -q 2M 4k
+zrp 0 3
+EOF
+echo "(4) finish an empty zone, with zones[0] explicitly, then implicitly open"
+$QEMU_IO $IMG2 << EOF
+zrs 0 8M
+zo 0 1M
+zf 1M 1M
+zrs 0 8M
+write -q 0 4k
+zf 1M 1M
+zrp 0 2
+EOF
+echo "(5) a write past the capacity of zones[1] leaves zones[0] open"
+$QEMU_IO $IMG2 << EOF
+zrs 0 8M
+write -q 0 4k
+write -q 1M 1028k
+zrp 0 2
+EOF
+
+echo
+echo "case 7: zones consist of whole clusters, in a version 3 image"
+echo "(1) a zone smaller than a cluster is refused"
+$QEMU_IMG create -f qcow2 $file_name2 -o size=1M -o cluster_size=64K \
+-o zone.size=16K -o zone.capacity=16K -o zone.mode=host-managed
+echo "(2) a version 2 image is refused"
+$QEMU_IMG create -f qcow2 $file_name2 -o compat=0.10 -o size=1M \
+-o zone.size=64K -o zone.capacity=64K -o zone.mode=host-managed
+echo "(3) resetting zones[1] leaves the data of zones[3] alone"
+$QEMU_IMG create -f qcow2 $file_name2 -o size=1M -o cluster_size=16K \
+-o zone.size=16K -o zone.capacity=16K -o zone.conventional_zones=0 \
+-o zone.mode=host-managed > /dev/null
+$QEMU_IO $IMG2 << EOF
+write -q -P 0x5a 48k 4k
+write -q -P 0xa5 16k 4k
+zf 16k 16k
+zrs 16k 16k
+zrp 16k 1
+read -q -P 0 16k 16k
+read -q -P 0x5a 48k 4k
+EOF
+
+echo
+echo "case 8: a closed zone that a write fills is no longer active"
+$QEMU_IMG create -f qcow2 $file_name2 -o size=8M -o zone.size=1M -o \
+zone.capacity=1M -o zone.conventional_zones=0 \
+-o zone.max_open_zones=2 -o zone.max_active_zones=3 \
+-o zone.mode=host-managed > /dev/null
+echo "(1) writing zones[2] closes zones[0], as only two zones can be open"
+echo "(2) filling zones[0] leaves zones[1] and zones[2] active: zones[3] opens"
+$QEMU_IO $IMG2 << EOF
+write -q 0 4k
+write -q 1M 4k
+write -q 2M 4k
+zrp 0 3
+write -q 4k 1020k
+zo 3M 1M
+zrp 0 4
+EOF
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/zoned-qcow2.out b/tests/qemu-iotests/tests/zoned-qcow2.out
new file mode 100644
index 0000000000..0ac4934a62
--- /dev/null
+++ b/tests/qemu-iotests/tests/zoned-qcow2.out
@@ -0,0 +1,258 @@
+QA output created by zoned-qcow2
+
+=== Initial image setup ===
+
+Formatting 'zbc.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib zone.mode=host-managed zone.size=67108864 zone.capacity=67108864 zone.conventional_zones=0 zone.max_active_zones=8 zone.max_open_zones=6 size=805306368 lazy_refcounts=off refcount_bits=16
+
+=== Testing a qcow2 img with zoned format ===
+
+case 1: test zone operations one by one
+(1) report zones[0]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+
+report zones[0~9]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+
+report zones[-1]:
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+
+
+(2) open zones[0], zones[1], zones[-1] then close, finish, reset:
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:3, [type: 2]
+qemu-io> qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:3, [type: 2]
+qemu-io> qemu-io> start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:3, [type: 2]
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x20000, zcond:14, [type: 2]
+qemu-io> qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:14, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x160000, len 0x20000, cap 0x20000, wptr 0x180000, zcond:14, [type: 2]
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io>
+(3) append write with (4k, 8k) data
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+Append write zones[0], zones[1] twice
+qemu-io> After zap done, the append sector is 0x0
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x18, zcond:2, [type: 2]
+qemu-io> After zap done, the append sector is 0x18
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x30, zcond:2, [type: 2]
+qemu-io> After zap done, the append sector is 0x20000
+qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20018, zcond:2, [type: 2]
+qemu-io> After zap done, the append sector is 0x20018
+qemu-io> start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20030, zcond:2, [type: 2]
+qemu-io>
+Reset all:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x30, zcond:4, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20030, zcond:4, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+
+
+case 2: test a sets of ops that works or not
+(1) append write (4k, 4k) and then write to full
+qemu-io> After zap done, the append sector is 0x0
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:2, [type: 2]
+qemu-io> After zap done, the append sector is 0x10
+qemu-io> After zap done, the append sector is 0x10000
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x20000, zcond:14, [type: 2]
+qemu-io> Reset zones[0]:
+start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+(2) write in zones[0], zones[3], zones[8], and then reset all
+qemu-io> After zap done, the append sector is 0x0
+qemu-io> After zap done, the append sector is 0x60000
+qemu-io> After zap done, the append sector is 0x100000
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:2, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60010, zcond:2, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100010, zcond:2, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> case 3: test zone resource management
+(1) write in zones[0], zones[1], zones[2] and then close it
+qemu-io> After zap done, the append sector is 0x0
+qemu-io> After zap done, the append sector is 0x20000
+qemu-io> After zap done, the append sector is 0x40000
+qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:2, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20010, zcond:2, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40010, zcond:2, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> qemu-io> qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x10, zcond:4, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20010, zcond:4, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40010, zcond:4, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io> (2) reset all after 3(1)
+qemu-io> qemu-io> start: 0x0, len 0x20000, cap 0x20000, wptr 0x0, zcond:1, [type: 2]
+start: 0x20000, len 0x20000, cap 0x20000, wptr 0x20000, zcond:1, [type: 2]
+start: 0x40000, len 0x20000, cap 0x20000, wptr 0x40000, zcond:1, [type: 2]
+start: 0x60000, len 0x20000, cap 0x20000, wptr 0x60000, zcond:1, [type: 2]
+start: 0x80000, len 0x20000, cap 0x20000, wptr 0x80000, zcond:1, [type: 2]
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+start: 0x100000, len 0x20000, cap 0x20000, wptr 0x100000, zcond:1, [type: 2]
+start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120000, zcond:1, [type: 2]
+start: 0x140000, len 0x20000, cap 0x20000, wptr 0x140000, zcond:1, [type: 2]
+start: 0x160000, len 0x20000, cap 0x20000, wptr 0x160000, zcond:1, [type: 2]
+qemu-io>
+case 4: WP cache crash consistency under concurrent appends
+(1) concurrent writes to the same sequential zone (zone 5 @ 320M)
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0018, zcond:2, [type: 2]
+qemu-io> qemu-io> qemu-io> qemu-io> (2) concurrent writes to different sequential zones (zones 6, 7, 9)
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0008, zcond:2, [type: 2]
+qemu-io> start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0008, zcond:2, [type: 2]
+qemu-io> start: 0x120000, len 0x20000, cap 0x20000, wptr 0x120008, zcond:2, [type: 2]
+qemu-io> qemu-io> qemu-io> qemu-io> (3) reset zones with no in-flight writes (zones 5, 6)
+start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+(4) BLKRESETALL after concurrent writes
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0008, zcond:2, [type: 2]
+qemu-io> start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0008, zcond:2, [type: 2]
+qemu-io> start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0008, zcond:2, [type: 2]
+qemu-io> qemu-io> start: 0xa0000, len 0x20000, cap 0x20000, wptr 0xa0000, zcond:1, [type: 2]
+qemu-io> start: 0xc0000, len 0x20000, cap 0x20000, wptr 0xc0000, zcond:1, [type: 2]
+qemu-io> start: 0xe0000, len 0x20000, cap 0x20000, wptr 0xe0000, zcond:1, [type: 2]
+qemu-io>
+case 5: zone errors are reported with distinct errnos
+(1) write not at the write pointer of zones[0]
+(2) write past the capacity of zones[0]
+(3) open zone limit: zones[0] explicitly open, write zones[1]
+(4) active zone limit: zones[0] closed, zones[1] open, open zones[2]
+qemu-io> qemu-io: Offset 0x1000 of regular writes must be equal to the zone write pointer 0x0
+qemu-io: write failed: Illegal seek
+qemu-io> qemu-io: write exceeds zone capacity with end_offset: 0x808, end_zone: 0x800
+qemu-io: write failed: Numerical result out of range
+qemu-io> qemu-io> qemu-io: no more open zones available
+qemu-io: write failed: Too many references: cannot splice
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io: no more active zones available
+qemu-io: write failed: Value too large for defined data type
+qemu-io> qemu-io: zone open failed: Value too large for defined data type
+qemu-io> start: 0x0, len 0x800, cap 0x800, wptr 0x8, zcond:4, [type: 2]
+start: 0x800, len 0x800, cap 0x800, wptr 0x808, zcond:2, [type: 2]
+start: 0x1000, len 0x800, cap 0x800, wptr 0x1000, zcond:1, [type: 2]
+qemu-io>
+case 6: zone resource accounting (max_open_zones=1, max_active_zones=2)
+(1) an empty zone is not opened beyond the active zone limit
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> qemu-io: no more active zones available
+qemu-io: write failed: Value too large for defined data type
+qemu-io> start: 0x0, len 0x800, cap 0x800, wptr 0x8, zcond:4, [type: 2]
+start: 0x800, len 0x800, cap 0x800, wptr 0x808, zcond:4, [type: 2]
+start: 0x1000, len 0x800, cap 0x800, wptr 0x1000, zcond:1, [type: 2]
+qemu-io> (2) an explicit open of an empty zone respects the open zone limit
+qemu-io> qemu-io> qemu-io> qemu-io: zone open failed: Too many references: cannot splice
+qemu-io> start: 0x0, len 0x800, cap 0x800, wptr 0x0, zcond:3, [type: 2]
+start: 0x800, len 0x800, cap 0x800, wptr 0x800, zcond:1, [type: 2]
+qemu-io> (3) at the active zone limit: open a closed zone, then an empty one
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> qemu-io: no more active zones available
+qemu-io: write failed: Value too large for defined data type
+qemu-io> start: 0x0, len 0x800, cap 0x800, wptr 0x10, zcond:2, [type: 2]
+start: 0x800, len 0x800, cap 0x800, wptr 0x808, zcond:4, [type: 2]
+start: 0x1000, len 0x800, cap 0x800, wptr 0x1000, zcond:1, [type: 2]
+qemu-io> (4) finish an empty zone, with zones[0] explicitly, then implicitly open
+qemu-io> qemu-io> qemu-io> qemu-io: zone finish failed: Too many references: cannot splice
+qemu-io> qemu-io> qemu-io> qemu-io> start: 0x0, len 0x800, cap 0x800, wptr 0x8, zcond:4, [type: 2]
+start: 0x800, len 0x800, cap 0x800, wptr 0x1000, zcond:14, [type: 2]
+qemu-io> (5) a write past the capacity of zones[1] leaves zones[0] open
+qemu-io> qemu-io> qemu-io> qemu-io: write exceeds zone capacity with end_offset: 0x1008, end_zone: 0x1000
+qemu-io: write failed: Numerical result out of range
+qemu-io> start: 0x0, len 0x800, cap 0x800, wptr 0x8, zcond:2, [type: 2]
+start: 0x800, len 0x800, cap 0x800, wptr 0x800, zcond:1, [type: 2]
+qemu-io>
+case 7: zones consist of whole clusters, in a version 3 image
+(1) a zone smaller than a cluster is refused
+Formatting 'zbc2.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib zone.mode=host-managed zone.size=16384 zone.capacity=16384 size=1048576 lazy_refcounts=off refcount_bits=16
+qemu-img: warning: Zoned extension header zone_size 16384B is not a multiple of the cluster size 65536B
+qemu-img: zbc2.qcow2: Invalid zoned device options
+(2) a version 2 image is refused
+Formatting 'zbc2.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib zone.mode=host-managed zone.size=65536 zone.capacity=65536 size=1048576 compat=0.10 lazy_refcounts=off refcount_bits=16
+qemu-img: zbc2.qcow2: Zoned images are only supported with compatibility level 1.1 and above (use version=v3 or greater)
+(3) resetting zones[1] leaves the data of zones[3] alone
+qemu-io> qemu-io> qemu-io> qemu-io> qemu-io> start: 0x20, len 0x20, cap 0x20, wptr 0x20, zcond:1, [type: 2]
+qemu-io> qemu-io> qemu-io>
+case 8: a closed zone that a write fills is no longer active
+(1) writing zones[2] closes zones[0], as only two zones can be open
+(2) filling zones[0] leaves zones[1] and zones[2] active: zones[3] opens
+qemu-io> qemu-io> qemu-io> qemu-io> start: 0x0, len 0x800, cap 0x800, wptr 0x8, zcond:4, [type: 2]
+start: 0x800, len 0x800, cap 0x800, wptr 0x808, zcond:2, [type: 2]
+start: 0x1000, len 0x800, cap 0x800, wptr 0x1008, zcond:2, [type: 2]
+qemu-io> qemu-io> qemu-io> start: 0x0, len 0x800, cap 0x800, wptr 0x800, zcond:14, [type: 2]
+start: 0x800, len 0x800, cap 0x800, wptr 0x808, zcond:4, [type: 2]
+start: 0x1000, len 0x800, cap 0x800, wptr 0x1008, zcond:2, [type: 2]
+start: 0x1800, len 0x800, cap 0x800, wptr 0x1800, zcond:3, [type: 2]
+qemu-io> *** done
-- 
2.56.0


