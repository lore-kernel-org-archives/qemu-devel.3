Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0DDC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q7n-0005cJ-GA; Fri, 10 May 2024 09:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s5Q7j-0005YQ-0f; Fri, 10 May 2024 09:17:19 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s5Q7a-0002DU-O0; Fri, 10 May 2024 09:17:18 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 76891473ED;
 Fri, 10 May 2024 15:16:57 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com,
 wencongyang2@huawei.com
Subject: [PATCH v3 4/5] iotests: add test for bitmap mirror
Date: Fri, 10 May 2024 15:16:46 +0200
Message-Id: <20240510131647.1256467-5-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240510131647.1256467-1-f.ebner@proxmox.com>
References: <20240510131647.1256467-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Fabian Grünbichler <f.gruenbichler@proxmox.com>

heavily based on/practically forked off iotest 257 for bitmap backups,
but:

- no writes to filter node 'mirror-top' between completion and
finalization, as those seem to deadlock?
- extra set of reference/test mirrors to verify that writes in parallel
with active mirror work

Intentionally keeping copyright and ownership of original test case to
honor provenance.

The test was originally adapted by Fabian from 257, but has seen
rather big changes, because the interface for mirror with bitmap was
changed, i.e. no @bitmap-mode parameter anymore and bitmap is used as
the working bitmap, and the test was changed to use backing images and
@sync-mode=write-blocking.

Signed-off-by: Fabian Grünbichler <f.gruenbichler@proxmox.com>
Signed-off-by: Thomas Lamprecht <t.lamprecht@proxmox.com>
[FE: rebase for 9.1
     adapt to changes to mirror bitmap interface
     rename test from '384' to 'mirror-bitmap'
     use backing files, copy-mode=write-blocking, larger cluster size]
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v3:
* avoid script potentially waiting on non-existent job when
  blockdev-mirror QMP command fails by asserting that there is no
  error when none is expected.
* fix pylint issues
* rename test from sync-bitmap-mirror to mirror-bitmap
* use backing files (rather than stand-alone diff images) in
  combination with copy-mode=write-blocking and larger cluster size
  for target images, to have a more realistic use-case and show that
  COW prevents ending up with cluster with partial data upon unaligned
  writes

 tests/qemu-iotests/tests/mirror-bitmap     |  597 ++++
 tests/qemu-iotests/tests/mirror-bitmap.out | 3191 ++++++++++++++++++++
 2 files changed, 3788 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/mirror-bitmap
 create mode 100644 tests/qemu-iotests/tests/mirror-bitmap.out

diff --git a/tests/qemu-iotests/tests/mirror-bitmap b/tests/qemu-iotests/tests/mirror-bitmap
new file mode 100755
index 0000000000..37bbe0f241
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-bitmap
@@ -0,0 +1,597 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Test bitmap-sync mirrors (incremental, differential, and partials)
+#
+# Copyright (c) 2019 John Snow for Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# owner=jsnow@redhat.com
+
+import os
+
+import iotests
+from iotests import log, qemu_img
+
+SIZE = 64 * 1024 * 1024
+GRANULARITY = 64 * 1024
+IMAGE_CLUSTER_SIZE = 128 * 1024
+
+
+class Pattern:
+    def __init__(self, byte, offset, size=GRANULARITY):
+        self.byte = byte
+        self.offset = offset
+        self.size = size
+
+    def bits(self, granularity):
+        lower = self.offset // granularity
+        upper = (self.offset + self.size - 1) // granularity
+        return set(range(lower, upper + 1))
+
+
+class PatternGroup:
+    """Grouping of Pattern objects. Initialize with an iterable of Patterns."""
+    def __init__(self, patterns):
+        self.patterns = patterns
+
+    def bits(self, granularity):
+        """Calculate the unique bits dirtied by this pattern grouping"""
+        res = set()
+        for pattern in self.patterns:
+            res |= pattern.bits(granularity)
+        return res
+
+
+GROUPS = [
+    PatternGroup([
+        # Batch 0: 4 clusters
+        Pattern('0x49', 0x0000000),
+        Pattern('0x6c', 0x0100000),   # 1M
+        Pattern('0x6f', 0x2000000),   # 32M
+        Pattern('0x76', 0x3ff0000)]), # 64M - 64K
+    PatternGroup([
+        # Batch 1: 6 clusters (3 new)
+        Pattern('0x65', 0x0000000),   # Full overwrite
+        Pattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
+        Pattern('0x72', 0x2008000),   # Partial-right (32M+32K)
+        Pattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
+    PatternGroup([
+        # Batch 2: 7 clusters (3 new)
+        Pattern('0x74', 0x0010000),   # Adjacent-right
+        Pattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
+        Pattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
+        Pattern('0x67', 0x3fe0000,
+                2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
+    PatternGroup([
+        # Batch 3: 8 clusters (5 new)
+        # Carefully chosen such that nothing re-dirties the one cluster
+        # that copies out successfully before failure in Group #1.
+        Pattern('0xaa', 0x0010000,
+                3*GRANULARITY),       # Overwrite and 2x Adjacent-right
+        Pattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
+        Pattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
+        Pattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the right
+]
+
+
+class EmulatedBitmap:
+    def __init__(self, granularity=GRANULARITY):
+        self._bits = set()
+        self.granularity = granularity
+
+    def dirty_bits(self, bits):
+        self._bits |= set(bits)
+
+    def dirty_group(self, n):
+        self.dirty_bits(GROUPS[n].bits(self.granularity))
+
+    def clear(self):
+        self._bits = set()
+
+    def clear_bits(self, bits):
+        self._bits -= set(bits)
+
+    def clear_bit(self, bit):
+        self.clear_bits({bit})
+
+    def clear_group(self, n):
+        self.clear_bits(GROUPS[n].bits(self.granularity))
+
+    @property
+    def first_bit(self):
+        return sorted(self.bits)[0]
+
+    @property
+    def bits(self):
+        return self._bits
+
+    @property
+    def count(self):
+        return len(self.bits)
+
+    def compare(self, qmp_bitmap):
+        """
+        Print a nice human-readable message checking that a bitmap as reported
+        by the QMP interface has as many bits set as we expect it to.
+        """
+
+        name = qmp_bitmap.get('name', '(anonymous)')
+        log("= Checking Bitmap {:s} =".format(name))
+
+        want = self.count
+        have = qmp_bitmap['count'] // qmp_bitmap['granularity']
+
+        log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
+            want, have, "OK!" if want == have else "ERROR!"))
+        log('')
+
+
+class Drive:
+    """Represents, vaguely, a drive attached to a VM.
+    Includes format, graph, and device information."""
+
+    def __init__(self, path, vm=None):
+        self.path = path
+        self.vm = vm
+        self.fmt = None
+        self.size = None
+        self.node = None
+        self.file_node = None
+
+    def img_create(self, fmt, size):
+        self.fmt = fmt
+        self.size = size
+        iotests.qemu_img_create('-f', self.fmt, self.path, str(self.size))
+
+    def create_target(self, name, fmt, size, backing_file):
+        basename = os.path.basename(self.path)
+        file_node_name = "file_{}".format(basename)
+        vm = self.vm
+
+        log(vm.cmd('blockdev-create', job_id='bdc-file-job',
+                   options={
+                       'driver': 'file',
+                       'filename': self.path,
+                       'size': 0,
+                   }))
+        vm.run_job('bdc-file-job')
+        log(vm.cmd('blockdev-add', driver='file',
+                   node_name=file_node_name, filename=self.path))
+
+        bdc_fmt_opts = {
+            'driver': fmt,
+            'file': file_node_name,
+            'size': size,
+            'cluster-size': IMAGE_CLUSTER_SIZE,
+        }
+
+        if backing_file is not None:
+            bdc_fmt_opts['backing-file'] = backing_file
+
+        log(vm.cmd('blockdev-create', job_id='bdc-fmt-job',
+                   options=bdc_fmt_opts))
+        vm.run_job('bdc-fmt-job')
+        log(vm.cmd('blockdev-add', driver=fmt,
+                   node_name=name,
+                   file=file_node_name))
+        self.fmt = fmt
+        self.size = size
+        self.node = name
+        self.file_node = file_node_name
+
+    def detach_target(self):
+        vm = self.vm
+        log('--- Detaching {} ---'.format(self.node))
+        log(vm.cmd('blockdev-del', node_name=self.node))
+        log(vm.cmd('blockdev-del', node_name=self.file_node))
+        log('')
+
+
+def blockdev_mirror(vm, device, target, sync, **kwargs):
+    # Strip any arguments explicitly nulled by the caller:
+    kwargs = {key: val for key, val in kwargs.items() if val is not None}
+    result = vm.qmp_log('blockdev-mirror',
+                        device=device,
+                        target=target,
+                        sync=sync,
+                        copy_mode='write-blocking',
+                        filter_node_name='mirror-top',
+                        **kwargs)
+    return result
+
+def blockdev_mirror_mktarget(drive, target_id, filepath, target_backing, sync,
+                             **kwargs):
+    target_drive = Drive(filepath, vm=drive.vm)
+    target_drive.create_target(target_id, drive.fmt, drive.size,
+                               target_backing)
+    result = blockdev_mirror(drive.vm, drive.node, target_id, sync, **kwargs)
+    assert result.get("error") is None
+    return target_drive
+
+def reference_mirror(drive, n, filepath):
+    log("--- Reference mirror #{:d} ---\n".format(n))
+    target_id = "ref_target_{:d}".format(n)
+    job_id = "ref_mirror_{:d}".format(n)
+    target_drive = blockdev_mirror_mktarget(drive, target_id, filepath, None,
+                                            "full", job_id=job_id)
+    drive.vm.run_job(job_id, auto_dismiss=True)
+    log('')
+    target_drive.detach_target()
+    return target_drive
+
+def bitmap_sync_pre(drive, bitmap_sync, bitmap):
+    vm = drive.vm
+    log("--- Prepare bitmap for sync mode '{}' ---\n".format(bitmap_sync))
+    if bitmap_sync in ('never', 'on-success'):
+        vm.qmp_log("block-dirty-bitmap-add", node=drive.node,
+                   name="mirror-bitmap", granularity=GRANULARITY)
+        vm.qmp_log("block-dirty-bitmap-merge", node=drive.node,
+                   target="mirror-bitmap", bitmaps=[bitmap])
+        log('')
+        return "mirror-bitmap"
+    elif bitmap_sync == 'always':
+        log("passing current bitmap '{}'\n".format(bitmap))
+        return bitmap
+    else:
+        raise ValueError("unkown bitmap sync mode '{}'".format(bitmap_sync))
+
+def bitmap_sync_post(drive, bitmap_sync, bitmap, success):
+    vm = drive.vm
+    log("--- Post-process bitmap for sync mode '{}' ---\n".format(bitmap_sync))
+    if bitmap_sync == 'never':
+        vm.qmp_log("block-dirty-bitmap-remove", node=drive.node,
+                   name="mirror-bitmap")
+        log('')
+        return
+    elif bitmap_sync == 'on-success':
+        if success:
+            vm.qmp_log("block-dirty-bitmap-clear", node=drive.node,
+                       name=bitmap)
+            vm.qmp_log("block-dirty-bitmap-merge", node=drive.node,
+                       target=bitmap, bitmaps=["mirror-bitmap"])
+        vm.qmp_log("block-dirty-bitmap-remove", node=drive.node,
+                   name="mirror-bitmap")
+        log('')
+        return
+    elif bitmap_sync == 'always':
+        log('nothing to do\n')
+        return
+    else:
+        raise ValueError("unkown bitmap sync mode '{}'".format(bitmap_sync))
+
+def mirror(drive, n, filepath, target_backing, sync, **kwargs):
+    log("--- Test mirror #{:d} ---\n".format(n))
+    target_id = "mirror_target_{:d}".format(n)
+    job_id = "mirror_{:d}".format(n)
+    kwargs.setdefault('auto-finalize', False)
+    target_drive = blockdev_mirror_mktarget(drive, target_id, filepath,
+                                            target_backing, sync,
+                                            job_id=job_id, **kwargs)
+    return (job_id, target_drive)
+
+def perform_writes(drive, n, filter_node_name=None):
+    log("--- Write #{:d} ---\n".format(n))
+    for pattern in GROUPS[n].patterns:
+        cmd = "write -P{:s} 0x{:07x} 0x{:x}".format(
+            pattern.byte,
+            pattern.offset,
+            pattern.size)
+        log(cmd)
+        log(drive.vm.hmp_qemu_io(filter_node_name or drive.node, cmd))
+    bitmaps = drive.vm.query_bitmaps()
+    log({'bitmaps': bitmaps}, indent=2)
+    log('')
+    return bitmaps
+
+
+def compare_images(image, reference, baseimg=None, expected_match=True):
+    """
+    Print a nice human-readable message comparing these images.
+    """
+    expected_ret = 0 if expected_match else 1
+    if baseimg:
+        qemu_img("rebase", "-u", "-b", baseimg, '-F', iotests.imgfmt, image)
+
+    sub = qemu_img("compare", image, reference, check=False)
+
+    log('qemu_img compare "{:s}" "{:s}" ==> {:s}, {:s}'.format(
+        image, reference,
+        "Identical" if sub.returncode == 0 else "Mismatch",
+        "OK!" if sub.returncode == expected_ret else "ERROR!"),
+        filters=[iotests.filter_testfiles])
+
+def test_bitmap_sync(bsync_mode, failure=None):
+    """
+    Test bitmap mirror routines.
+
+    :param bsync_mode: Is the Bitmap Sync mode, and can be any of:
+        - on-success: This is the "incremental" style mode. Bitmaps are
+                      synchronized to what was copied out only on success.
+                      (Partial images must be discarded.)
+        - never:      This is the "differential" style mode.
+                      Bitmaps are never synchronized.
+        - always:     This is a "best effort" style mode.
+                      Bitmaps are always synchronized, regardless of failure.
+                      (Partial images must be kept.)
+
+    :param failure: Is the (optional) failure mode, and can be any of:
+        - None:         No failure. Test the normative path. Default.
+        - simulated:    Cancel the job right before it completes.
+                        This also tests writes "during" the job.
+        - intermediate: This tests a job that fails mid-process and produces
+                        an incomplete mirror. Testing limitations prevent
+                        testing competing writes.
+    """
+    with iotests.FilePath('img', 'bsync1', 'bsync2', 'bsync3',
+                          'fmirror0', 'fmirror1', 'fmirror2', 'fmirror3') as \
+                          (img_path, bsync1, bsync2, bsync3,
+                           fmirror0, fmirror1, fmirror2, fmirror3), \
+         iotests.VM() as vm:
+
+        mode = "Bitmap Sync {:s}".format(bsync_mode)
+        preposition = "with" if failure else "without"
+        cond = "{:s} {:s}".format(preposition,
+                                  "{:s} failure".format(failure) if failure
+                                  else "failure")
+        log("\n=== {:s} {:s} ===\n".format(mode, cond))
+
+        log('--- Preparing image & VM ---\n')
+        drive0 = Drive(img_path, vm=vm)
+        drive0.img_create(iotests.imgfmt, SIZE)
+        vm.add_device("virtio-scsi,id=scsi0")
+        vm.launch()
+
+        file_config = {
+            'driver': 'file',
+            'filename': drive0.path
+        }
+
+        if failure == 'intermediate':
+            file_config = {
+                'driver': 'blkdebug',
+                'image': file_config,
+                'set-state': [{
+                    'event': 'flush_to_disk',
+                    'state': 1,
+                    'new_state': 2
+                }, {
+                    'event': 'read_aio',
+                    'state': 2,
+                    'new_state': 3
+                }, {
+                    'event': 'read_aio',
+                    'state': 3,
+                    'new_state': 4
+                }],
+                'inject-error': [{
+                    'event': 'read_aio',
+                    'errno': 5,
+                    'state': 3,
+                    'immediately': False,
+                    'once': True
+                }, {
+                    'event': 'read_aio',
+                    'errno': 5,
+                    'state': 4,
+                    'immediately': False,
+                    'once': True
+                }]
+            }
+
+        drive0.node = 'drive0'
+        vm.qmp_log('blockdev-add',
+                   filters=[iotests.filter_qmp_testfiles],
+                   node_name=drive0.node,
+                   driver=drive0.fmt,
+                   file=file_config)
+        log('')
+
+        # 0 - Writes and Reference mirror
+        perform_writes(drive0, 0)
+        fmirror0_target = reference_mirror(drive0, 0, fmirror0)
+        log('--- Add Bitmap ---\n')
+        vm.qmp_log("block-dirty-bitmap-add", node=drive0.node,
+                   name="bitmap0", granularity=GRANULARITY)
+        log('')
+        ebitmap = EmulatedBitmap()
+
+        # 1 - Writes and Reference mirror
+        bitmaps = perform_writes(drive0, 1)
+        ebitmap.dirty_group(1)
+        bitmap = vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=bitmaps)
+        ebitmap.compare(bitmap)
+        reference_mirror(drive0, 1, fmirror1)
+
+        # 1 - Test mirror (w/ Optional induced failure)
+        if failure == 'intermediate':
+            # Activate blkdebug induced failure for second-to-next read
+            log(vm.hmp_qemu_io(drive0.node, 'flush'))
+            log('')
+        mirror_bitmap = bitmap_sync_pre(drive0, bsync_mode, "bitmap0")
+        # First reference mirror is used as the inital base image
+        (job, bsync1_target) = mirror(drive0, 1, bsync1, fmirror0_target.path,
+                                      'full', bitmap=mirror_bitmap)
+
+        vm.run_job(job, auto_dismiss=True, auto_finalize=False,
+                   cancel=failure == 'simulated')
+        bsync1_target.detach_target()
+        bitmap_sync_post(drive0, bsync_mode, "bitmap0", not failure)
+
+        bitmaps = vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=2)
+        log('')
+
+        if bsync_mode == 'always':
+            if failure == 'intermediate':
+                # We manage to copy one sector (one bit) before the error.
+                ebitmap.clear_bit(ebitmap.first_bit)
+            else:
+                # successful mirror / cancelled complete mirror
+                ebitmap.clear()
+
+        if bsync_mode == 'on-success' and not failure:
+            ebitmap.clear()
+
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=bitmaps))
+
+        # 2 - Reference mirror
+        reference_mirror(drive0, 2, fmirror2)
+
+        # 2 - Bitmap mirror with writes before completion
+        mirror_bitmap = bitmap_sync_pre(drive0, bsync_mode, "bitmap0")
+        (job, bsync2_target) = mirror(drive0, 2, bsync2, bsync1_target.path,
+                                      "full", bitmap=mirror_bitmap)
+
+        bitmaps = perform_writes(drive0, 2, filter_node_name='mirror-top')
+        ebitmap.dirty_group(2)
+
+        # Can't compare against bitmap0 if used as the mirror bitmap, because
+        # mirror could already clear it.
+        if mirror_bitmap != "bitmap0":
+            ebitmap.compare(vm.get_bitmap(drive0.node, "bitmap0",
+                                          bitmaps=bitmaps))
+
+        # don't use run_job as that logs too much even with use_log=False
+        events = [('JOB_STATUS_CHANGE', {'data': {'id': job}})]
+        while True:
+            ev = iotests.filter_qmp_event(vm.events_wait(events, timeout=10))
+            status = ev['data']['status']
+            if status == 'ready':
+                vm.qmp('job-complete', id=job)
+            elif status == 'standby':
+                vm.qmp('job-resume', id=job)
+            elif status == 'pending':
+                vm.qmp('job-finalize', id=job)
+            elif status == 'null':
+                break
+
+        bsync2_target.detach_target()
+        bitmap_sync_post(drive0, bsync_mode, "bitmap0", True)
+
+        if bsync_mode != 'never':
+            ebitmap.clear()
+
+        bitmaps = vm.query_bitmaps()
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=bitmaps))
+
+        # 3 - Writes and Reference mirror
+        bitmaps = perform_writes(drive0, 3)
+        ebitmap.dirty_group(3)
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=bitmaps))
+        reference_mirror(drive0, 3, fmirror3)
+
+        # 3 - Bitmap mirror (In failure modes, this is a recovery.)
+        mirror_bitmap = bitmap_sync_pre(drive0, bsync_mode, "bitmap0")
+        (job, bsync3_target) = mirror(drive0, 3, bsync3, bsync2_target.path,
+                                      "full", bitmap=mirror_bitmap)
+
+        vm.run_job(job, auto_dismiss=True, auto_finalize=False)
+        bsync3_target.detach_target()
+        bitmap_sync_post(drive0, bsync_mode, "bitmap0", True)
+        bitmaps = vm.query_bitmaps()
+
+        log({'bitmaps': bitmaps}, indent=2)
+        log('')
+        if bsync_mode != 'never':
+            ebitmap.clear()
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=bitmaps))
+
+        log('--- Cleanup ---\n')
+        vm.qmp_log("block-dirty-bitmap-remove",
+                   node=drive0.node, name="bitmap0")
+        bitmaps = vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=2)
+        vm.shutdown()
+        log('')
+
+        log('--- Verification ---\n')
+        compare_images(bsync1, fmirror1, baseimg=fmirror0,
+                       expected_match=failure != 'intermediate')
+        if not failure or bsync_mode == 'always':
+            # Always keep the last mirror on success or when using 'always'
+            base = bsync1
+        else:
+            base = fmirror1
+
+        compare_images(bsync2, fmirror2, baseimg=base, expected_match=0)
+        compare_images(bsync3, fmirror3, baseimg=bsync2)
+        compare_images(img_path, fmirror3)
+        log('')
+
+def test_mirror_api():
+    """
+    Test malformed and prohibited invocations of the mirror API.
+    """
+    with iotests.FilePath('img', 'bsync1') as \
+         (img_path, mirror_path), \
+         iotests.VM() as vm:
+
+        log("\n=== API failure tests ===\n")
+        log('--- Preparing image & VM ---\n')
+        drive0 = Drive(img_path, vm=vm)
+        drive0.img_create(iotests.imgfmt, SIZE)
+        vm.add_device("virtio-scsi,id=scsi0")
+        vm.launch()
+
+        file_config = {
+            'driver': 'file',
+            'filename': drive0.path
+        }
+
+        drive0.node = 'drive0'
+        vm.qmp_log('blockdev-add',
+                   filters=[iotests.filter_qmp_testfiles],
+                   node_name=drive0.node,
+                   driver=drive0.fmt,
+                   file=file_config)
+        log('')
+
+        target0 = Drive(mirror_path, vm=vm)
+        target0.create_target("mirror_target", drive0.fmt, drive0.size, None)
+        log('')
+
+        vm.qmp_log("block-dirty-bitmap-add", node=drive0.node,
+                   name="bitmap0", granularity=GRANULARITY)
+        log('')
+
+        log('-- Testing invalid QMP commands --\n')
+
+        error_cases = {
+            'full' : ['bitmap404'],
+            'top' : ['bitmap404', 'bitmap0'],
+            'none' : ['bitmap404', 'bitmap0'],
+        }
+
+        # Dicts, as always, are not stably-ordered prior to 3.7, so use tuples:
+        for sync_mode in ('full', 'top', 'none'):
+            log("-- Sync mode {:s} tests --\n".format(sync_mode))
+            for bitmap in error_cases[sync_mode]:
+                blockdev_mirror(drive0.vm, drive0.node, "mirror_target",
+                                sync_mode, job_id='api_job',
+                                bitmap=bitmap)
+                log('')
+
+
+def main():
+    for bsync_mode in ("never", "on-success", "always"):
+        for failure in ("simulated", "intermediate", None):
+            test_bitmap_sync(bsync_mode, failure)
+
+    test_mirror_api()
+
+if __name__ == '__main__':
+    iotests.script_main(main, supported_fmts=['qcow2'],
+                        supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/mirror-bitmap.out b/tests/qemu-iotests/tests/mirror-bitmap.out
new file mode 100644
index 0000000000..5c8acc1d69
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-bitmap.out
@@ -0,0 +1,3191 @@
+
+=== Bitmap Sync never with simulated failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-cancel", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "mirror-bitmap",
+        "persistent": false,
+        "recording": false
+      },
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 10 dirty sectors; have 10. OK!
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+= Checking Bitmap bitmap0 =
+expecting 10 dirty sectors; have 10. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 15 dirty sectors; have 15. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 15 dirty sectors; have 15. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== Bitmap Sync never with intermediate failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}, {"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+{"return": ""}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "error": "Input/output error", "len": 393216, "offset": 65536, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "mirror-bitmap",
+        "persistent": false,
+        "recording": false
+      },
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 10 dirty sectors; have 10. OK!
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+= Checking Bitmap bitmap0 =
+expecting 10 dirty sectors; have 10. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 15 dirty sectors; have 15. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 15 dirty sectors; have 15. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== Bitmap Sync never without failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "mirror-bitmap",
+        "persistent": false,
+        "recording": false
+      },
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 10 dirty sectors; have 10. OK!
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+= Checking Bitmap bitmap0 =
+expecting 10 dirty sectors; have 10. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 15 dirty sectors; have 15. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'never' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 15 dirty sectors; have 15. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== Bitmap Sync on-success with simulated failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-cancel", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "mirror-bitmap",
+        "persistent": false,
+        "recording": false
+      },
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 10 dirty sectors; have 10. OK!
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-clear", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["mirror-bitmap"], "node": "drive0", "target": "bitmap0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-clear", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["mirror-bitmap"], "node": "drive0", "target": "bitmap0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== Bitmap Sync on-success with intermediate failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}, {"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+{"return": ""}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "error": "Input/output error", "len": 393216, "offset": 65536, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "mirror-bitmap",
+        "persistent": false,
+        "recording": false
+      },
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 10 dirty sectors; have 10. OK!
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-clear", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["mirror-bitmap"], "node": "drive0", "target": "bitmap0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-clear", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["mirror-bitmap"], "node": "drive0", "target": "bitmap0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== Bitmap Sync on-success without failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-clear", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["mirror-bitmap"], "node": "drive0", "target": "bitmap0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "mirror-bitmap",
+        "persistent": false,
+        "recording": false
+      },
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 7 dirty sectors; have 7. OK!
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-clear", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["mirror-bitmap"], "node": "drive0", "target": "bitmap0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["bitmap0"], "node": "drive0", "target": "mirror-bitmap"}}
+{"return": {}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "mirror-bitmap", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'on-success' ---
+
+{"execute": "block-dirty-bitmap-clear", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-merge", "arguments": {"bitmaps": ["mirror-bitmap"], "node": "drive0", "target": "bitmap0"}}
+{"return": {}}
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "mirror-bitmap", "node": "drive0"}}
+{"return": {}}
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== Bitmap Sync always with simulated failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-cancel", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": false
+      }
+    ]
+  }
+}
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== Bitmap Sync always with intermediate failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}, {"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+{"return": ""}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "error": "Input/output error", "len": 393216, "offset": 65536, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 327680,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 5 dirty sectors; have 5. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": false
+      }
+    ]
+  }
+}
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== Bitmap Sync always without failure ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_0 ---
+{}
+{}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_1 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_1", "sync": "full", "target": "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_1 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_2 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_2", "sync": "full", "target": "mirror_target_2"}}
+{"return": {}}
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": true,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": false
+      }
+    ]
+  }
+}
+
+--- Detaching mirror_target_2 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "target": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Detaching ref_target_3 ---
+{}
+{}
+
+--- Prepare bitmap for sync mode 'always' ---
+
+passing current bitmap 'bitmap0'
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "mirror_3", "sync": "full", "target": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+--- Detaching mirror_target_3 ---
+{}
+{}
+
+--- Post-process bitmap for sync mode 'always' ---
+
+nothing to do
+
+{
+  "bitmaps": {
+    "drive0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true
+      }
+    ]
+  }
+}
+
+= Checking Bitmap bitmap0 =
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" ==> Mismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" ==> Identical, OK!
+
+
+=== API failure tests ===
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+-- Testing invalid QMP commands --
+
+-- Sync mode full tests --
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' not found"}}
+
+-- Sync mode top tests --
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'top' not supported with bitmap."}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'top' not supported with bitmap."}}
+
+-- Sync mode none tests --
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not supported with bitmap."}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "copy-mode": "write-blocking", "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'none' not supported with bitmap."}}
+
-- 
2.39.2



