Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D78E9128F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0ek-0007p6-Rb; Thu, 05 Feb 2026 09:48:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0ed-0007nI-9i
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vo0eU-0004Dp-AA
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770302893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZXs+WoWrXoKyYAfe0wHw7NnWaGpDsHsTViHDgmOuWA=;
 b=dNzfxIkJQv3pKuJmK9jW9E8DTvy8rsTIxshGpHb2EeF9BCfoQutH3Bo86EWb7Ussy63o7o
 aSKPl78J1kLqWtQJw01nHPucUOjKMdxuFHPVuZmkjwIVrgsHrce6m0NInuqF87/j78Ef+c
 K25Qnvlpx9070Naqg+XwaWExE3S/keU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-p6WdA3FTNJeivgtKJbKNfQ-1; Thu, 05 Feb 2026 09:48:11 -0500
X-MC-Unique: p6WdA3FTNJeivgtKJbKNfQ-1
X-Mimecast-MFC-AGG-ID: p6WdA3FTNJeivgtKJbKNfQ_1770302891
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso1922983f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 06:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770302890; x=1770907690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZXs+WoWrXoKyYAfe0wHw7NnWaGpDsHsTViHDgmOuWA=;
 b=s/5z0ut/ueDjtX5U3ee4lHrakIY9tKYvvKKQT5xViyTz4CBgxFUVQESLZ9BuSeM9PN
 qm1Mvht7Dm3zNVqyH1+kQo2cgJRQB6N/7MjgbI/e2m017eqvpgfa1r7CYoigqqflUv2Q
 9AWKhwbdT0Vv2W0RpIvVORoSyb5BVAf++pYdP5JwXkJ+YVfyRRCf2Nb6GWaOHn2nTVP7
 24Undzm0eVY2apbz5O/g770WUoxFmXtbO+KcFz6UOns1abeslspTP79gdjZ3n3ELXDRD
 Uw9SU3YUScjwEMUAfBtOHdu+DWNj+jqlfTy0jVA4Ycj6wEyTug0TJfWdk/FbshnVkYBj
 oVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770302890; x=1770907690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wZXs+WoWrXoKyYAfe0wHw7NnWaGpDsHsTViHDgmOuWA=;
 b=SsL/etRk6CO/DzRP9CyHyz4G6eGORLqSuaGhVorn+zde12u7pfQw058O9nqWkQMTHH
 fbEAdQF+eCYFcxjx8e8Q27znvGPC9c1meGbxG15w03SkRTNZAUv2pKh9+PR8rqcVbPhM
 2KNGOigEGT3VaWG8VdYXGiuxgwTtAdJjJjlCHdKIjoeBOR2wYpzQN5wsrZJl/zgI0Icp
 Bv/AfRU/4Q66BrbNPi07Lx6bG5A0wCPd0/ZIOgBEK5c85U61QpeEHihyqwRN2dBD4eUQ
 sMmLjddXUMO2h4737T3Ii+wHJEsYZfuWxPpDUY3ENNnjMV7LYizoG+r1JRlV3KbTcfSp
 eJLA==
X-Gm-Message-State: AOJu0YzIX6QfVmQAa8BUjxYNIZ2AriAQC+aj8fYVJ219vrXsnTrKAqt+
 qbzuVs+PkwrwelUp+kOhW4tzbT3+ttsxnpfbIGLU1sQ5QQPc+oNDVrih/JOoum5aGVQD1BJdKPY
 7uqXhMYcRmY+Fk+5fmFFf5a0COEqjHYr+karQopkp+4XQZRNCWqcNgmL2JLJrK/VZ
X-Gm-Gg: AZuq6aKjgnLvhsa3WTzF5VUlXLpaqaXDk0j3CiYB4pgFSJd6xlGhcbgOnH1WKJJjezY
 n48jcVHOjz/NXb7rwwVEskNoDqMKtj++1wblirB2cAb7SmWdutuQZzS7G9cyluexaren005KhAd
 BYMReAMbSKQb7DDbbXNum2dnS52DHS6z7PYLMcxbhFpX4s1xU19nD8U8Q87gmeoHGJjP7Z6xucX
 V4U3dr941IdbpnhU5Q7gN3UhX1V+eOp15G7FdjVv8UXdA1cufj5C0SVfdrXE509uvC7pCsqHE+k
 8w8UKZzZ+gfen3InMPaD5uO9FWzM5xO2fzU9FkId1MPS67o8vwgmRsQiWtMxd0eJ/awAmh1ZSLZ
 jRc1yqDrHkgo3Ay7E7Kd9f2+S0eMtLDsMupxBBvW/Hhyn41WutA+q3SXyAXk/lBRKuW5R
X-Received: by 2002:a05:6000:2c05:b0:435:9635:2943 with SMTP id
 ffacd0b85a97d-436213e0249mr5524834f8f.17.1770302888540; 
 Thu, 05 Feb 2026 06:48:08 -0800 (PST)
X-Received: by 2002:a05:6000:2c05:b0:435:9635:2943 with SMTP id
 ffacd0b85a97d-436213e0249mr5524718f8f.17.1770302887501; 
 Thu, 05 Feb 2026 06:48:07 -0800 (PST)
Received: from localhost
 (p200300cfd737d06375fda007e5d3c5c8.dip0.t-ipconnect.de.
 [2003:cf:d737:d063:75fd:a007:e5d3:c5c8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436180647aasm13181356f8f.41.2026.02.05.06.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 06:48:06 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 5/5] iotests: Add qcow2-live-data-file test
Date: Thu,  5 Feb 2026 15:47:35 +0100
Message-ID: <20260205144737.31131-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205144737.31131-1-hreitz@redhat.com>
References: <20260205144737.31131-1-hreitz@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 tests/qemu-iotests/tests/qcow2-live-data-file |  274 ++
 .../tests/qcow2-live-data-file.out            | 2904 +++++++++++++++++
 2 files changed, 3178 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/qcow2-live-data-file
 create mode 100644 tests/qemu-iotests/tests/qcow2-live-data-file.out

diff --git a/tests/qemu-iotests/tests/qcow2-live-data-file b/tests/qemu-iotests/tests/qcow2-live-data-file
new file mode 100755
index 0000000000..cdff1ada3d
--- /dev/null
+++ b/tests/qemu-iotests/tests/qcow2-live-data-file
@@ -0,0 +1,274 @@
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
+    log(f'[blockdev-create: {base_options['driver']}]')
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
+                expected_conflicting_perms += ['write']
+
+            if guest_disk_type == GuestDiskType.SCSI_CD and \
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
index 0000000000..0adb307756
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
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
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
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
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
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
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
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by block device 'sda' (uses node 'protocol' as 'root' child).
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
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
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
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
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
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
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
+blockdev-create failed: Permission conflict on node 'protocol': permissions 'write' are both required by node '#blockXXX' (uses node 'protocol' as 'data-file' child) and unshared by node 'raw' (uses node 'protocol' as 'file' child).
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
2.52.0


