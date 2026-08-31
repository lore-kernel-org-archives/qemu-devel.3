Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB04AC624C6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x12RV-0004VR-Iv; Mon, 31 Aug 2026 09:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RS-0004Tn-QS
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x12RP-00042T-NV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 09:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788184371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5bBcsxgaPauphBAbkV3pf/dICs6jqAgw/5t5PALPAY=;
 b=CC5g1STol0qf2I2TJvcSkjRHbwLedEsORKKtZaFT3ByA7ok62y8CONoykBibMHMjZ4Y5yc
 5GoRZl5fwY+CJJMk5xIG/0UPFrmdihb0w+0CTezeGUtZ56t8GOOiQVixk1CLN3eSRZisHG
 +SIzHE5y5rnLIjoCYjC5eruIUx7WaQM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81--Y0zBVsCNTCWAnvE0SjpxQ-1; Mon, 31 Aug 2026 09:52:49 -0400
X-MC-Unique: -Y0zBVsCNTCWAnvE0SjpxQ-1
X-Mimecast-MFC-AGG-ID: -Y0zBVsCNTCWAnvE0SjpxQ_1788184368
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49a1b4ea633so32188965e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788184368; x=1788789168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e5bBcsxgaPauphBAbkV3pf/dICs6jqAgw/5t5PALPAY=;
 b=q6X0dvtlAUGqrkwBaR2BVWSKb7OA4VmrmVKT4lIVGjdmHhE/pEEeivlXBKitlXC/A0
 f3SlTqIQqhubPRGsKQ/h7gRDKNhgXKUqsdbYvv4MaOBin3BtwoAPaxTlkgcw5irHD/V1
 R+j4BN/S+JlOGHQSgla5g4wRAdvZIRY/xvF1pDvCL8Pn7Wyxmd5z6zpX3eHmSavngVfX
 Nnp/QjETElGFYWt7xlbPZBWEUA3RHq5lJfiophLaUAGtQFwvGY47KsmoRowAELLbGvGp
 GALg3P/mMrWlCVaj9wQZY6CuEyoBqf1h0EJO5xp2BUYH1W6PN/M9exqR6Kh+MPcL/UyE
 8Yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788184368; x=1788789168;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e5bBcsxgaPauphBAbkV3pf/dICs6jqAgw/5t5PALPAY=;
 b=BnKtlFfCU/mLCFF8ls0YRMxSje5RAhGBzwRaFTD1aXTWBa7OJBJM2Yk4moe/tlW3pR
 oI06/fBemhLUewGVjMNGEivTm7d56c8uLOwfpSrToWsnICVyVGo4L3VrP3cNFY3nQJCK
 mkl1bPwjjvoVN5UQnOoTvMFkPxgrsehwPc3SgztEDWD0LSsOFemRfO0Ecqz5gf0pD9Ny
 7BDXWSKUpPkxbmo2hj6xcu/b6IoBlyPIwG9Y1wg6aEr9jG9GJsBX4ml9RnTHkJ0PRGW4
 +gKWhAN2Pehq/F8V9gRlc53Z2Aa55xfcCkvGLV0EVmBUtWAuTpAyDAZUdJ2HD1TnuLyA
 3vTw==
X-Gm-Message-State: AFuF++nIJSnN6D+QaToWduLTdTQdF0XrTjCc/HPNOF41cynjOqR4Sa02
 vzeB+CUJYHiTLKSF8DTy3Bfu103cWCKHTNSRsNQGsIZl60hGCV2SDQ/MFmFpZnufSfO5it5KL8J
 /QcMkdwOVstMeNb/wg8xmb8f+4XLJkKunjFde+P6aI76szz8++ANS4NcJSF7yzIr+
X-Gm-Gg: AR+sD12tmUUtwWWw9nVpOMO6+ANiQ8tsT2QzK6Sawo62pLKVv+9lDMqkpsdCnELtpVq
 +h51shWdvFXk+NfG1p6bSA6+MAnb9rBUWPo+j7SaA+GUp+lxXEXW8ocm6w1wPSGtlYDVsyr+ASb
 aKMt4ThIiTc5s8uofqmVNQsiYNJtTF+1GRN+aFwMeeV5lNeh8X+fbkBk5inTvW97MW/ZUXyN8+U
 u8WUNw38x0a/5pc5Aa6wjL1TBqtZSyOMMIhalmU7NciU9J77YA4JGkTZ6BKvWpY4iStMRPna9xa
 k9AFRKTZDQtu8PTwz0wCfN3CmIO56+rBmHsz9U090V/iDluaunyLm8Tk4yrWd4OFoSfV5e1Xhwh
 fSD/kyh2trcoaEufDMej0mhtyZgkflZUylWyeGM1k6DSPk5fl+H1M1XCzCZc=
X-Received: by 2002:a05:600c:64c6:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-49cdc558470mr13855015e9.11.1788184367771; 
 Mon, 31 Aug 2026 06:52:47 -0700 (PDT)
X-Received: by 2002:a05:600c:64c6:b0:495:52a5:8829 with SMTP id
 5b1f17b1804b1-49cdc558470mr13853645e9.11.1788184367155; 
 Mon, 31 Aug 2026 06:52:47 -0700 (PDT)
Received: from localhost
 (p200300cfd72080187472d8ceb75e67b1.dip0.t-ipconnect.de.
 [2003:cf:d720:8018:7472:d8ce:b75e:67b1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ccae954f9sm220330825e9.13.2026.08.31.06.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:52:45 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 9/9] iotests: Add delay-alert test
Date: Mon, 31 Aug 2026 15:52:05 +0200
Message-ID: <20260831135206.126184-10-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831135206.126184-1-hreitz@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Test delay-alert-ms via HMP qemu-io (break, aio_read/write, resume) on a
null node (with blkdebug).

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/tests/delay-alert     | 136 +++++++++++++++++++++++
 tests/qemu-iotests/tests/delay-alert.out |  46 ++++++++
 2 files changed, 182 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/delay-alert
 create mode 100644 tests/qemu-iotests/tests/delay-alert.out

diff --git a/tests/qemu-iotests/tests/delay-alert b/tests/qemu-iotests/tests/delay-alert
new file mode 100755
index 00000000000..d98f537e802
--- /dev/null
+++ b/tests/qemu-iotests/tests/delay-alert
@@ -0,0 +1,136 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Test the I/O delay QMP event.
+#
+# Copyright (C) 2026 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Creator/Owner: Hanna Czenczek <hreitz@redhat.com>
+
+import asyncio
+import iotests
+from iotests import filter_qmp_event, log
+
+DELAY_ALERT_MS = 5000 # ms
+EPSILON_MS = 50 # ms -- small delta that can safely be added/subtracted
+NS_PER_MS = 1000 * 1000
+
+qtest_clock = 0 # ms
+
+iotests.script_initialize()
+
+def vm_qemu_io(qvm, virtio_blk_id, cmd):
+    log(f'[HMP] qemu-io to {virtio_blk_id}: {cmd}')
+    cmd = f'qemu-io -d {virtio_blk_id}/virtio-backend "{cmd}"'
+    log(qvm.qmp('human-monitor-command', command_line=cmd))
+
+def advance_clock_to(qvm, clock_ms):
+    # Retain the current absolute clock time so we can step *to* a specific
+    # time via `clock_step`. pylint does not like global much, but this is a
+    # test script, and not using global would just make this more complicated.
+    global qtest_clock # pylint: disable=global-statement
+
+    msecs = clock_ms - qtest_clock
+    log(f'[qtest] clock_step {msecs}ms to {clock_ms}ms')
+    qvm.qtest(f'clock_step {msecs * NS_PER_MS}')
+    qtest_clock += msecs
+
+def assert_no_event(qvm, event_name):
+    try:
+        evt = qvm.event_wait(event_name, timeout=0.1)
+        assert evt is None, f'Unexpected {event_name} event: {evt}'
+    except asyncio.TimeoutError:
+        pass
+    log(f'(No {event_name} event)')
+
+with iotests.VM() as vm:
+    # Cannot use null-co.latency-ns, as that uses realtime (not qtest time)
+    # Need to use raw to get the read_aio event working
+    vm.add_blockdev(vm.qmp_to_opts({
+        'driver': 'raw',
+        'node-name': 'test-node',
+        'file': {
+            'driver': 'blkdebug',
+            'image': {
+                'driver': 'null-co',
+            },
+        },
+    }))
+
+    vm.launch()
+
+    log(f'[QMP] device_add id=vblk delay-alert-ms={DELAY_ALERT_MS}')
+    log(vm.qmp('device_add', {
+        'driver': 'virtio-blk',
+        'id': 'vblk',
+        'drive': 'test-node',
+        'delay-alert-ms': DELAY_ALERT_MS,
+    }))
+
+    try:
+        # Test different operation types. Flushing and discarding would also be
+        # nice but `aio_flush` does not actually execute a flush, and there is
+        # no blkdebug event for discarding.
+
+        vm_qemu_io(vm, 'vblk', 'break read_aio read_0')
+        vm_qemu_io(vm, 'vblk', 'aio_read 0k 4k')
+        vm_qemu_io(vm, 'vblk', 'wait_break read_0')
+
+        vm_qemu_io(vm, 'vblk', 'break write_aio write_0')
+        vm_qemu_io(vm, 'vblk', 'aio_write 4k 4k')
+        vm_qemu_io(vm, 'vblk', 'wait_break write_0')
+
+        vm_qemu_io(vm, 'vblk', 'break read_aio read_1')
+        vm_qemu_io(vm, 'vblk', 'aio_read 8k 4k')
+        vm_qemu_io(vm, 'vblk', 'wait_break read_1')
+
+        vm_qemu_io(vm, 'vblk', 'break write_aio write_1')
+        vm_qemu_io(vm, 'vblk', 'aio_write 12k 4k')
+        vm_qemu_io(vm, 'vblk', 'wait_break write_1')
+
+        # Assert there is no event before the step
+        advance_clock_to(vm, DELAY_ALERT_MS - EPSILON_MS)
+        assert_no_event(vm, 'BLOCK_IO_DELAY')
+
+        # Even when a request finishes here
+        vm_qemu_io(vm, 'vblk', 'resume read_0')
+        assert_no_event(vm, 'BLOCK_IO_DELAY')
+
+        # Crossing the threshold alone does not cause an event to fire
+        advance_clock_to(vm, DELAY_ALERT_MS + EPSILON_MS)
+        assert_no_event(vm, 'BLOCK_IO_DELAY')
+
+        # Only when the request finishes past the threshold do we see one
+        vm_qemu_io(vm, 'vblk', 'resume write_0')
+        event = vm.event_wait('BLOCK_IO_DELAY')
+        assert event is not None
+        log(event, filters=[filter_qmp_event])
+        assert_no_event(vm, 'BLOCK_IO_DELAY')
+
+        # Check that we get the event immediately on completion
+        vm_qemu_io(vm, 'vblk', 'resume read_1')
+        event = vm.event_wait('BLOCK_IO_DELAY')
+        assert event is not None
+        log(event, filters=[filter_qmp_event])
+        assert_no_event(vm, 'BLOCK_IO_DELAY')
+
+        # And the same for the final request, but add another bit of delay
+        advance_clock_to(vm, DELAY_ALERT_MS + 2 * EPSILON_MS)
+        vm_qemu_io(vm, 'vblk', 'resume write_1')
+        event = vm.event_wait('BLOCK_IO_DELAY')
+        assert event is not None
+        log(event, filters=[filter_qmp_event])
+        assert_no_event(vm, 'BLOCK_IO_DELAY')
+    except Exception as exc:
+        # The VM will not be able to quit without these requests
+        # finished, which (without this block) would make the test
+        # hang instead of exit if something unexpected goes wrong
+        vm_qemu_io(vm, 'vblk', 'resume read_0')
+        vm_qemu_io(vm, 'vblk', 'resume write_0')
+        vm_qemu_io(vm, 'vblk', 'resume read_1')
+        vm_qemu_io(vm, 'vblk', 'resume write_1')
+        raise exc
+
+    vm.shutdown()
diff --git a/tests/qemu-iotests/tests/delay-alert.out b/tests/qemu-iotests/tests/delay-alert.out
new file mode 100644
index 00000000000..fe6cd71c6b1
--- /dev/null
+++ b/tests/qemu-iotests/tests/delay-alert.out
@@ -0,0 +1,46 @@
+[QMP] device_add id=vblk delay-alert-ms=5000
+{"return": {}}
+[HMP] qemu-io to vblk: break read_aio read_0
+{"return": ""}
+[HMP] qemu-io to vblk: aio_read 0k 4k
+{"return": ""}
+[HMP] qemu-io to vblk: wait_break read_0
+{"return": ""}
+[HMP] qemu-io to vblk: break write_aio write_0
+{"return": ""}
+[HMP] qemu-io to vblk: aio_write 4k 4k
+{"return": ""}
+[HMP] qemu-io to vblk: wait_break write_0
+{"return": ""}
+[HMP] qemu-io to vblk: break read_aio read_1
+{"return": ""}
+[HMP] qemu-io to vblk: aio_read 8k 4k
+{"return": ""}
+[HMP] qemu-io to vblk: wait_break read_1
+{"return": ""}
+[HMP] qemu-io to vblk: break write_aio write_1
+{"return": ""}
+[HMP] qemu-io to vblk: aio_write 12k 4k
+{"return": ""}
+[HMP] qemu-io to vblk: wait_break write_1
+{"return": ""}
+[qtest] clock_step 4950ms to 4950ms
+(No BLOCK_IO_DELAY event)
+[HMP] qemu-io to vblk: resume read_0
+{"return": ""}
+(No BLOCK_IO_DELAY event)
+[qtest] clock_step 100ms to 5050ms
+(No BLOCK_IO_DELAY event)
+[HMP] qemu-io to vblk: resume write_0
+{"return": ""}
+{"data": {"bytes": 4096, "duration": 5.05, "offset": 4096, "operation": "write", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+(No BLOCK_IO_DELAY event)
+[HMP] qemu-io to vblk: resume read_1
+{"return": ""}
+{"data": {"bytes": 4096, "duration": 5.05, "offset": 8192, "operation": "read", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+(No BLOCK_IO_DELAY event)
+[qtest] clock_step 50ms to 5100ms
+[HMP] qemu-io to vblk: resume write_1
+{"return": ""}
+{"data": {"bytes": 4096, "duration": 5.1, "offset": 12288, "operation": "write", "qom-path": "/machine/peripheral/vblk/virtio-backend"}, "event": "BLOCK_IO_DELAY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+(No BLOCK_IO_DELAY event)
-- 
2.55.0


