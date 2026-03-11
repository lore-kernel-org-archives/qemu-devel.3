Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6481125850
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M6N-00057A-SI; Wed, 11 Mar 2026 12:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5T-0004PS-F1
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1w0M5N-00060Q-2f
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Vn6qsaydGKrU8xcrdJbka8xvFYPDq3wcj2yCu2g43M=;
 b=SugsxAmncJzTiqiqPkFWTYS/1vZFg3L1EeU+0NKRl0L46uF+IA+02cjQA77pb6jbfAUMHd
 sI25XyVBqvP7bqhILyB8BCL/zFuHG4JIlngwgkwJ6ZCB9e+92GvS0Cjaspe8eNzBDwSuIr
 BcuD/VzAbZIh16dwz3IgrauC7blrYhQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-K_yvbzjnM9u_bFT09IgLjA-1; Wed, 11 Mar 2026 12:06:54 -0400
X-MC-Unique: K_yvbzjnM9u_bFT09IgLjA-1
X-Mimecast-MFC-AGG-ID: K_yvbzjnM9u_bFT09IgLjA_1773245213
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853b0af42aso306845e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245213; x=1773850013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Vn6qsaydGKrU8xcrdJbka8xvFYPDq3wcj2yCu2g43M=;
 b=L5ELlJwq0akgr6km5BZQ2ev+MBDp/d8MgtTKhHoN6IiP+3jTPpWnUQfD+Z6zztsye1
 rXZC1oChP+m/FGM3WqBtCPY3c73Ju/EHHaOe2kEWyYoOQRJ27BE674Gn8Ko1MDH7NYPI
 8FllfrG+LcLuOdcxUFZiV7CuKD0HAbLef1nNl2ZvaHmRIie0oaeX1ci1sjemVdMG5v31
 ijZ3tLjvqEFsZGAdtCGAyPqPIXQg75x4SYqppsm/6pWRKP5mAKVzy3aLkQUr/N1kKK/d
 gy5bea02QFApc0BtSQw7ApxpX/BE8GFMFXhqehHFE4jS87hsOjDe9SCW89+B1pXmGSh8
 7O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245213; x=1773850013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Vn6qsaydGKrU8xcrdJbka8xvFYPDq3wcj2yCu2g43M=;
 b=R1K6yar1nL7wdvYRrNyeeFWnBqvh0hr3St0PrITnUTW0p0T718rRsie+OCtKHSPaOl
 A1dbHOhhKsc0CE+nT+2QBiTGZZluX78hxnYRlTpO4W02FEcst7NquPnD8cpMQTRjAdwT
 NwU4vqJ0lPkaIibtN98XByqhFVbsvWuxvYHmAr+jAhzvVr3IBIJ933P3Oy2NC5zt2wSE
 4ifZtdhiLRs2ClnT7TPcTOKjTcFPlsYTSeQkXwqsC9VAaRE2DdeJrRwl+tD1iV0/G8ZD
 VTAJNjNU9F1y1Dg8EWLlp8bVhvnXAroLH6lt0Lgag4vSZh3eUs7vcBODXWk0myf/VhPq
 g9+Q==
X-Gm-Message-State: AOJu0YzOSb9OFyLhox/eEarzG2qVMKKQisyCHqvraepji9WBTC0OI9HP
 AZZveNYrX2mlKbpQNs/cjs69fBV2hr0UFtF74PFIGfgyF1RGU16xHkKvBDhgBPFzYYkZgpo4nKK
 yRXoytW3KTdODM9d52NYNlz7DxqQyxHk6wrovpX5ET698FDyH4Act8R6j
X-Gm-Gg: ATEYQzwyZuKD5/wpfeWjo72edoGuhy61bwJ+HtnGBG3YS+eSvcpcwP4PkBQGZSSAo76
 dT70+LOmBUtapGHwW3sx/JAMpCYhbdA9zqOcySTiNJd6SCZ+WaPdngXf7FcGBtD1JU+T4nPfkRD
 B1gKpfIR/Gaakew05NTDiUao55v9yxN3aydLPyqN2JxFGh2zlUKDaBuK3O8TWUA7IxL/Axmsdfb
 KnXWwvc/vAJ2JoQaINgJUH7PtW7jMy9JLEZMRhyNqPVc4prXtDICMG5qi+mVhR6rlGpAqkliOR7
 Tqa+EXbuJOzJLhN4POg9K6UjfQ2uod4lYdybnxekxuENmIVyJZG2eASGB5fssAmn4FUYwJkGwqv
 MmvG/1lRJW9wbbcNMqSmx9kdA34awsohtdZLae0llivVRTXBI3VNUlAn+OUWSxy7cXeFN+xNTu/
 T7XHpE
X-Received: by 2002:a05:600c:3b18:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4854b0b3546mr55006495e9.10.1773245211134; 
 Wed, 11 Mar 2026 09:06:51 -0700 (PDT)
X-Received: by 2002:a05:600c:3b18:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-4854b0b3546mr55005235e9.10.1773245209869; 
 Wed, 11 Mar 2026 09:06:49 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0216f12b1cbc4c9e6fd.dip0.t-ipconnect.de.
 [2003:cf:d737:d021:6f12:b1cb:c4c9:e6fd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0dc8d7sm19862695e9.25.2026.03.11.09.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:06:48 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 6/6] iotests: Add qcow2-live-data-file test
Date: Wed, 11 Mar 2026 17:06:28 +0100
Message-ID: <20260311160628.344838-7-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311160628.344838-1-hreitz@redhat.com>
References: <20260311160628.344838-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

While a raw image is attached to a VM, create a pure-metadata qcow2
image with that raw image as its data file, and then replace the raw
image by the qcow2 image.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/qemu-iotests/tests/qcow2-live-data-file |  280 ++
 .../tests/qcow2-live-data-file.out            | 2904 +++++++++++++++++
 2 files changed, 3184 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/qcow2-live-data-file
 create mode 100644 tests/qemu-iotests/tests/qcow2-live-data-file.out

diff --git a/tests/qemu-iotests/tests/qcow2-live-data-file b/tests/qemu-iotests/tests/qcow2-live-data-file
new file mode 100755
index 0000000000..49eee048ac
--- /dev/null
+++ b/tests/qemu-iotests/tests/qcow2-live-data-file
@@ -0,0 +1,280 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Given a raw image file already attached to a VM, create a qcow2 file with
+# that image as its external (raw) data file, and replace the raw image by
+# the qcow2 image.
+#
+# Copyright (C) 2026 Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Creator/Owner: Hanna Czenczek <hreitz@redhat.com>
+
+from enum import Enum, auto
+import re
+import iotests
+from iotests import log, qemu_img, qemu_img_log, qemu_io_log
+
+iotests.script_initialize(
+    supported_fmts=['qcow2'],
+    unsupported_imgopts=['compat'],
+)
+
+DISK_SIZE = 64 * 1024 * 1024
+
+class CreateException(Exception):
+    pass
+
+class GuestDiskType(Enum):
+    VIRTIO_BLK = auto()
+    SCSI_HD = auto()
+    SCSI_CD = auto()
+
+def do_test(
+    vm: iotests.VM,
+    with_raw_node: bool,
+    guest_disk_type: GuestDiskType,
+    preallocation: str,
+    qcow2_size: int,
+    raw_img_path: str,
+    qcow2_img_path: str,
+) -> None:
+    log('=== do_test() ===')
+    log(f' - with_raw_node={with_raw_node}')
+    log(f' - guest_disk_type={guest_disk_type}')
+    log(f' - preallocation={preallocation}')
+    log(f' - qcow2_size={qcow2_size}')
+
+    log('')
+    log('--- Setting up raw image ---')
+    qemu_img('create', '-f', 'raw', raw_img_path, str(DISK_SIZE))
+
+    log('')
+    log('--- Launching VM ---')
+
+    vm.add_blockdev(vm.qmp_to_opts({
+        'driver': 'file',
+        'node-name': 'protocol',
+        'filename': raw_img_path,
+    }))
+
+    if with_raw_node:
+        vm.add_blockdev(vm.qmp_to_opts({
+            'driver': 'raw',
+            'node-name': 'raw',
+            'file': 'protocol',
+        }))
+        raw_node = 'raw'
+    else:
+        raw_node = 'protocol'
+
+    dev_id = 'sda'
+    qom_path = f'/machine/peripheral/{dev_id}'
+    if guest_disk_type == GuestDiskType.VIRTIO_BLK:
+        vm.add_device(f'virtio-blk,id={dev_id},drive={raw_node}')
+        dev_id = f'{qom_path}/virtio-backend'
+    elif guest_disk_type == GuestDiskType.SCSI_HD:
+        vm.add_device('virtio-scsi')
+        vm.add_device(f'scsi-hd,id={dev_id},drive={raw_node}')
+    elif guest_disk_type == GuestDiskType.SCSI_CD:
+        vm.add_device('virtio-scsi')
+        vm.add_device(f'scsi-cd,id={dev_id},drive={raw_node}')
+
+    vm.launch()
+
+    log('')
+    log('--- Creating qcow2 image ---')
+
+    create_and_open(vm, {
+        'driver': 'file',
+        'filename': qcow2_img_path,
+    }, {
+        'size': 0,
+    }, {
+        'node-name': 'qcow2-protocol',
+    })
+
+    create_and_open(vm, {
+        'driver': 'qcow2',
+        'file': 'qcow2-protocol',
+        'data-file': 'protocol',
+    }, {
+        'data-file-raw': True,
+        'size': qcow2_size,
+        'preallocation': preallocation,
+    }, {
+        'node-name': 'qcow2',
+    })
+
+    cmd = 'aio_write -P 42 0 4M'
+    log(f'[HMP qemu-io: {cmd}]')
+    log(vm.qmp(
+        'human-monitor-command',
+        command_line=f'qemu-io -d {dev_id} "{cmd}"',
+    ))
+
+    if with_raw_node:
+        log('[blockdev-reopen]')
+        log(vm.qmp('blockdev-reopen', {
+            'options': [{
+                'driver': 'raw',
+                'node-name': 'raw',
+                'file': 'qcow2',
+            }],
+        }))
+    else:
+        log('[qom-set]')
+        log(vm.qmp('qom-set', {
+            'path': qom_path,
+            'property': 'drive',
+            'value': 'qcow2',
+        }))
+
+    cmd = 'aio_flush'
+    log(f'[HMP qemu-io: {cmd}]')
+    log(vm.qmp(
+        'human-monitor-command',
+        command_line=f'qemu-io -d {dev_id} {cmd}',
+    ))
+
+    vm.shutdown()
+
+    qlog = vm.get_log()
+    if qlog is not None:
+        log('[qemu log]')
+        qlog = iotests.filter_qemu_io(iotests.filter_qtest(qlog))
+        log(qlog)
+
+    log('[qemu-img check]')
+    qemu_img_log('check', '-f', 'qcow2', qcow2_img_path)
+
+    cmd = 'read -P 42 0 4M'
+    log(f'[qemu-io: {cmd}]')
+    qemu_io_log(qcow2_img_path, '-c', cmd)
+
+def create_and_open(
+    vm: iotests.VM,
+    base_options: dict[str, object],
+    create_options: dict[str, object],
+    open_options: dict[str, object],
+) -> None:
+    driver = base_options['driver']
+    log(f'[blockdev-create: {driver}]')
+    log(vm.qmp('blockdev-create', {
+        'job-id': 'create',
+        'options': base_options | create_options,
+    }))
+
+    while True:
+        event = vm.event_wait(
+            name='JOB_STATUS_CHANGE',
+            match={'data': {'id': 'create'}},
+        )
+        assert event is not None
+        status = event['data']['status']
+        log(f' -> {status}')
+        if status == 'aborting':
+            jobs = vm.qmp('query-jobs')['return']
+            job_info = next(job for job in jobs if job['id'] == 'create')
+            error = re.sub(r'#block\d+', '#blockXXX', job_info['error'])
+            log(f'blockdev-create failed: {error}')
+            raise CreateException(error)
+        if status == 'concluded':
+            break
+
+    log('[job-dismiss]')
+    log(vm.qmp('job-dismiss', id='create'))
+    log('[blockdev-add]')
+    log(vm.qmp('blockdev-add', base_options | open_options))
+
+def verify_exception(
+    exception: CreateException,
+    conflicting_permissions: list[str],
+    with_raw_node: bool,
+    guest_disk_type: GuestDiskType,
+) -> None:
+    if with_raw_node:
+        user = "node 'raw'"
+        user_child = 'file'
+    elif guest_disk_type == GuestDiskType.VIRTIO_BLK:
+        user = "block device '/machine/peripheral/sda/virtio-backend'"
+        user_child = 'root'
+    else:
+        user = "block device 'sda'"
+        user_child = 'root'
+
+    refstr = (
+        "Permission conflict on node 'protocol': permissions "
+        f"'{', '.join(conflicting_permissions)}' are both required by node "
+        "'#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared "
+        f"by {user} (uses node 'protocol' as '{user_child}' child)."
+    )
+
+    if str(exception) != refstr:
+        log("Exception differs from reference:")
+        log(f'Is:       {exception}')
+        log(f'Expected: {refstr}')
+        assert str(exception) == refstr
+
+def run_test(
+    with_raw_node: bool,
+    guest_disk_type: GuestDiskType,
+    preallocation: str,
+    qcow2_size: int,
+) -> None:
+    with iotests.FilePath('raw.img') as raw_img_path, \
+         iotests.FilePath('metadata.qcow2') as qcow2_img_path, \
+         iotests.VM() as vm:
+        try:
+            do_test(
+                vm,
+                with_raw_node,
+                guest_disk_type,
+                preallocation,
+                qcow2_size,
+                raw_img_path,
+                qcow2_img_path,
+            )
+        except CreateException as e:
+            expected_conflicting_perms = []
+
+            if preallocation in ('falloc', 'full'):
+                # Data preallocation must fail because it must write to the
+                # data file, requiring the WRITE permission.
+                # For a data file, the WRITE permission implies the RESIZE
+                # permission.  CD does not allow resizing, so it will conflict
+                # on both WRITE and RESIZE.
+                if guest_disk_type == GuestDiskType.SCSI_CD:
+                    expected_conflicting_perms += ['write', 'resize']
+                else:
+                    expected_conflicting_perms += ['write']
+            elif guest_disk_type == GuestDiskType.SCSI_CD and \
+                    qcow2_size > DISK_SIZE:
+                # CD does not allow resizing, but creating a bigger qcow2 image
+                # would require growing the raw image, necessitating the RESIZE
+                # permission.  (Creating a smaller qcow2 however will not
+                # shrink it.)
+                expected_conflicting_perms += ['resize']
+
+            if not expected_conflicting_perms:
+                raise e
+
+            verify_exception(e, expected_conflicting_perms,
+                             with_raw_node, guest_disk_type)
+            log('(Handled expected exception)')
+            log('')
+
+
+def run_all_test_combinations():
+    for with_raw_node in (False, True):
+        for guest_disk_type in GuestDiskType:
+            for preallocation in ('off', 'metadata', 'falloc', 'full'):
+                # Sprinkle in -512 and +512 to verify that non-cluster-aligned
+                # sizes work, too
+                for qcow2_size in (DISK_SIZE, DISK_SIZE // 2 - 512,
+                                   DISK_SIZE * 2 + 512):
+                    run_test(with_raw_node, guest_disk_type, preallocation,
+                             qcow2_size)
+
+run_all_test_combinations()
diff --git a/tests/qemu-iotests/tests/qcow2-live-data-file.out b/tests/qemu-iotests/tests/qcow2-live-data-file.out
new file mode 100644
index 0000000000..9cdad853fa
--- /dev/null
+++ b/tests/qemu-iotests/tests/qcow2-live-data-file.out
@@ -0,0 +1,2904 @@
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=off
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=off
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=off
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+2049/2049 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=metadata
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=metadata
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=metadata
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+2049/2049 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=falloc
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device '/machine/peripheral/sda/virtio-backend' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=falloc
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device '/machine/peripheral/sda/virtio-backend' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=falloc
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device '/machine/peripheral/sda/virtio-backend' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=full
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device '/machine/peripheral/sda/virtio-backend' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=full
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device '/machine/peripheral/sda/virtio-backend' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=full
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device '/machine/peripheral/sda/virtio-backend' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=off
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=off
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=off
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+2049/2049 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=metadata
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=metadata
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=metadata
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+2049/2049 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=falloc
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=falloc
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=falloc
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=full
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=full
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=full
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=off
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=off
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=off
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=metadata
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=metadata
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[qom-set]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=metadata
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=falloc
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=falloc
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=falloc
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=full
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=full
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=False
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=full
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=off
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=off
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=off
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+2049/2049 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=metadata
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=metadata
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=metadata
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+2049/2049 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=falloc
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=falloc
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=falloc
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=full
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=full
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.VIRTIO_BLK
+ - preallocation=full
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=off
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=off
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=off
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+2049/2049 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=metadata
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=metadata
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=metadata
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+2049/2049 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=falloc
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=falloc
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=falloc
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=full
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=full
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_HD
+ - preallocation=full
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=off
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=off
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=off
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=metadata
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+1024/1024 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=metadata
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[HMP qemu-io: aio_write -P 42 0 4M]
+{"return": ""}
+[blockdev-reopen]
+{"return": {}}
+[HMP qemu-io: aio_flush]
+{"return": ""}
+[qemu log]
+wrote 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+[qemu-img check]
+No errors were found on the image.
+512/512 = 100.00% allocated, 0.00% fragmented, 0.00% compressed clusters
+Image end offset: 327680
+
+[qemu-io: read -P 42 0 4M]
+read 4194304/4194304 bytes at offset 0
+4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=metadata
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=falloc
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=falloc
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=falloc
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=full
+ - qcow2_size=67108864
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=full
+ - qcow2_size=33553920
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
+=== do_test() ===
+ - with_raw_node=True
+ - guest_disk_type=GuestDiskType.SCSI_CD
+ - preallocation=full
+ - qcow2_size=134218240
+
+--- Setting up raw image ---
+
+--- Launching VM ---
+
+--- Creating qcow2 image ---
+[blockdev-create: file]
+{"return": {}}
+ -> created
+ -> running
+ -> waiting
+ -> pending
+ -> concluded
+[job-dismiss]
+{"return": {}}
+[blockdev-add]
+{"return": {}}
+[blockdev-create: qcow2]
+{"return": {}}
+ -> null
+ -> created
+ -> running
+ -> aborting
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write, resize' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
+(Handled expected exception)
+
-- 
2.53.0


