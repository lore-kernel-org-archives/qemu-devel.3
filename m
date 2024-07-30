Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4662C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYnvx-0000m7-O4; Tue, 30 Jul 2024 10:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sYnvw-0000hl-B0; Tue, 30 Jul 2024 10:34:36 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sYnvs-0004RT-46; Tue, 30 Jul 2024 10:34:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H7Mea8AhJANtTLIOkwdIE/zKAkIOn2Va3ejkl13aTxc=; b=WTfX3nIaWuigIeEzOKQvfPTCfI
 0j13ZlbzSiMouQEoJBgvgnJh9HGH6bh28cEUW+svhQWTAs/bKm+WYuTm3HUqvLyDZNwSM/53qqS/c
 ElB7tjFtSYJ8/VtI+z/9gYputjuSFCbkKB9XlK+tXhErKYjLg4izGYaW/S3cSZ4IVZPc8PEVoWHer
 U+YqnBc2Nuf+6pwaFHziTk8OW8FbZPU7J5tsSS1KiZqBSCsqqPh+7ZlA4bqGmX+wojFp5s6LDXuit
 m1mVZOBmrYXd165Zv/8YhUv8uEg4v1Xa7dl2sAbGfoiCErjZMJKBZhLVfNMbuD2hijsVixGh6UoP9
 9fc1c/vQ==;
Received: from ip40.wifi.igalia.com ([192.168.12.40] helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sYne3-005cfB-HP; Tue, 30 Jul 2024 16:16:07 +0200
Received: from berto by zeus.local with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1sYne3-000FiW-0u;
 Tue, 30 Jul 2024 16:16:07 +0200
From: Alberto Garcia <berto@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Madeeha Javed <javed@igalia.com>
Subject: [PATCH v4] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
Date: Tue, 30 Jul 2024 16:15:52 +0200
Message-Id: <20240730141552.60404-1-berto@igalia.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
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

This tool converts a disk image to qcow2, writing the result directly
to stdout. This can be used for example to send the generated file
over the network.

This is equivalent to using qemu-img to convert a file to qcow2 and
then writing the result to stdout, with the difference that this tool
does not need to create this temporary qcow2 file and therefore does
not need any additional disk space.

Implementing this directly in qemu-img is not really an option because
it expects the output file to be seekable and it is also meant to be a
generic tool that supports all combinations of file formats and image
options. Instead, this tool can only produce qcow2 files with the
basic options, without compression, encryption or other features.

The input file is read twice. The first pass is used to determine
which clusters contain non-zero data and that information is used to
create the qcow2 header, refcount table and blocks, and L1 and L2
tables. After all that metadata is created then the second pass is
used to write the guest data.

By default qcow2-to-stdout.py expects the input to be a raw file, but
if qemu-storage-daemon is available then it can also be used to read
images in other formats. Alternatively the user can also run qemu-nbd
or qemu-storage-daemon manually instead.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Madeeha Javed <javed@igalia.com>
---
 scripts/qcow2-to-stdout.py | 449 +++++++++++++++++++++++++++++++++++++
 1 file changed, 449 insertions(+)
 create mode 100755 scripts/qcow2-to-stdout.py

v4:
- Rewrite clusters_with_data() to simplify the code and to prevent the
  same cluster from being returned more than once.
- Add support for data_file and data_file_raw [Eric]
- When allocating the l2_bitmap use the actual number of L1 entries
  instead of the theoretical maximum. This reduces the memory
  requirements significantly with larger cluster sizes.
- Add align_up() function
- Remove support for v2 images [Eric]
- Fix typo in commit message [Eric]
- Minor style fixes

v3: https://lists.gnu.org/archive/html/qemu-block/2024-07/msg00597.html
- Remove stale 'import atexit' [Nir]
- Replace all instances of int(x / y) with x // y [Nir]
- Rename bitmap_test() to bitmap_is_set() [Nir]
- Use os.path.join() to construct path names [Nir]
- Rename create_qcow2_file() to write_qcow2_content() [Nir]
- Create a main() function [Nir]
- Use os.pread() with the absolute offset instead of seek() [Nir]
- Detect holes in the input file and skip reading them [Nir]

v2: https://lists.gnu.org/archive/html/qemu-block/2024-07/msg00018.html
- Define the QCOW2_V3_HDR_LENGTH and QCOW2_FEATURE_NAME_TABLE constants [Manos]
- Define the QEMU_STORAGE_DAEMON constant
- Use isfile() instead of exists() for the input file
- Refuse to write to stdout if it's a tty [Manos]
- Move the bulk of the code to a function called from __main__ [Manos]
- Remove the qcow2_ prefix from qcow2_cluster_size and qcow2_refcount_bits
- Formatting fixes suggested by the Python black formatter [Manos]
- On error pass the string directly to sys.exit()
- Capture the output of qemu-storage-daemon [Manos]
- Use a contextmanager to run qemu-storage-daemon [Manos]
- Update patch description to mention why this cannot be implemeted directly in qemu-img [Manos]

v1: https://lists.gnu.org/archive/html/qemu-block/2024-06/msg00073.html

diff --git a/scripts/qcow2-to-stdout.py b/scripts/qcow2-to-stdout.py
new file mode 100755
index 0000000000..06b7c13ccb
--- /dev/null
+++ b/scripts/qcow2-to-stdout.py
@@ -0,0 +1,449 @@
+#!/usr/bin/env python3
+
+# This tool reads a disk image in any format and converts it to qcow2,
+# writing the result directly to stdout.
+#
+# Copyright (C) 2024 Igalia, S.L.
+#
+# Authors: Alberto Garcia <berto@igalia.com>
+#          Madeeha Javed <javed@igalia.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# qcow2 files produced by this script are always arranged like this:
+#
+# - qcow2 header
+# - refcount table
+# - refcount blocks
+# - L1 table
+# - L2 tables
+# - Data clusters
+#
+# A note about variable names: in qcow2 there is one refcount table
+# and one (active) L1 table, although each can occupy several
+# clusters. For the sake of simplicity the code sometimes talks about
+# refcount tables and L1 tables when referring to those clusters.
+
+import argparse
+import errno
+import math
+import os
+import signal
+import struct
+import subprocess
+import sys
+import tempfile
+import time
+from contextlib import contextmanager
+
+QCOW2_DEFAULT_CLUSTER_SIZE = 65536
+QCOW2_DEFAULT_REFCOUNT_BITS = 16
+QCOW2_FEATURE_NAME_TABLE = 0x6803F857
+QCOW2_DATA_FILE_NAME_STRING = 0x44415441
+QCOW2_V3_HEADER_LENGTH = 112  # Header length in QEMU 9.0. Must be a multiple of 8
+QCOW2_INCOMPAT_DATA_FILE_BIT = 2
+QCOW2_AUTOCLEAR_DATA_FILE_RAW_BIT = 1
+QCOW_OFLAG_COPIED = 1 << 63
+QEMU_STORAGE_DAEMON = "qemu-storage-daemon"
+
+
+def bitmap_set(bitmap, idx):
+    bitmap[idx // 8] |= 1 << (idx % 8)
+
+
+def bitmap_is_set(bitmap, idx):
+    return (bitmap[idx // 8] & (1 << (idx % 8))) != 0
+
+
+def bitmap_iterator(bitmap, length):
+    for idx in range(length):
+        if bitmap_is_set(bitmap, idx):
+            yield idx
+
+
+def align_up(num, d):
+    return d * math.ceil(num / d)
+
+
+# Holes in the input file contain only zeroes so we can skip them and
+# save time. This function returns the indexes of the clusters that
+# are known to contain data. Those are the ones that we need to read.
+def clusters_with_data(fd, cluster_size):
+    data_to = 0
+    while True:
+        try:
+            data_from = os.lseek(fd, data_to, os.SEEK_DATA)
+            data_to = align_up(os.lseek(fd, data_from, os.SEEK_HOLE), cluster_size)
+            for idx in range(data_from // cluster_size, data_to // cluster_size):
+                yield idx
+        except OSError as err:
+            if err.errno == errno.ENXIO:  # End of file reached
+                break
+            raise err
+
+
+# write_qcow2_content() expects a raw input file. If we have a different
+# format we can use qemu-storage-daemon to make it appear as raw.
+@contextmanager
+def get_input_as_raw_file(input_file, input_format):
+    if input_format == "raw":
+        yield input_file
+        return
+    try:
+        temp_dir = tempfile.mkdtemp()
+        pid_file = os.path.join(temp_dir, "pid")
+        raw_file = os.path.join(temp_dir, "raw")
+        open(raw_file, "wb").close()
+        ret = subprocess.run(
+            [
+                QEMU_STORAGE_DAEMON,
+                "--daemonize",
+                "--pidfile", pid_file,
+                "--blockdev", f"driver=file,node-name=file0,driver=file,filename={input_file},read-only=on",
+                "--blockdev", f"driver={input_format},node-name=disk0,file=file0,read-only=on",
+                "--export", f"type=fuse,id=export0,node-name=disk0,mountpoint={raw_file},writable=off",
+            ],
+            capture_output=True,
+        )
+        if ret.returncode != 0:
+            sys.exit("[Error] Could not start the qemu-storage-daemon:\n" +
+                     ret.stderr.decode().rstrip('\n'))
+        yield raw_file
+    finally:
+        # Kill the storage daemon on exit
+        # and remove all temporary files
+        if os.path.exists(pid_file):
+            with open(pid_file, "r") as f:
+                pid = int(f.readline())
+            os.kill(pid, signal.SIGTERM)
+            while os.path.exists(pid_file):
+                time.sleep(0.1)
+        os.unlink(raw_file)
+        os.rmdir(temp_dir)
+
+
+def write_features(cluster, offset, data_file_name):
+    if data_file_name is not None:
+        encoded_name = data_file_name.encode("utf-8")
+        padded_name_len = align_up(len(encoded_name), 8)
+        struct.pack_into(f">II{padded_name_len}s", cluster, offset,
+                         QCOW2_DATA_FILE_NAME_STRING,
+                         len(encoded_name),
+                         encoded_name)
+        offset += 8 + padded_name_len
+
+    qcow2_features = [
+        # Incompatible
+        (0, 0, "dirty bit"),
+        (0, 1, "corrupt bit"),
+        (0, 2, "external data file"),
+        (0, 3, "compression type"),
+        (0, 4, "extended L2 entries"),
+        # Compatible
+        (1, 0, "lazy refcounts"),
+        # Autoclear
+        (2, 0, "bitmaps"),
+        (2, 1, "raw external data"),
+    ]
+    struct.pack_into(">I", cluster, offset, QCOW2_FEATURE_NAME_TABLE)
+    struct.pack_into(">I", cluster, offset + 4, len(qcow2_features) * 48)
+    offset += 8
+    for feature_type, feature_bit, feature_name in qcow2_features:
+        struct.pack_into(">BB46s", cluster, offset,
+                         feature_type, feature_bit, feature_name.encode("ascii"))
+        offset += 48
+
+
+def write_qcow2_content(input_file, cluster_size, refcount_bits, data_file_name, data_file_raw):
+    # Some basic values
+    l1_entries_per_table = cluster_size // 8
+    l2_entries_per_table = cluster_size // 8
+    refcounts_per_table  = cluster_size // 8
+    refcounts_per_block  = cluster_size * 8 // refcount_bits
+
+    # Virtual disk size, number of data clusters and L1 entries
+    disk_size = align_up(os.path.getsize(input_file), 512)
+    total_data_clusters = math.ceil(disk_size / cluster_size)
+    l1_entries = math.ceil(total_data_clusters / l2_entries_per_table)
+    allocated_l1_tables = math.ceil(l1_entries / l1_entries_per_table)
+
+    # Max L1 table size is 32 MB (QCOW_MAX_L1_SIZE in block/qcow2.h)
+    if (l1_entries * 8) > (32 * 1024 * 1024):
+        sys.exit("[Error] The image size is too large. Try using a larger cluster size.")
+
+    # Two bitmaps indicating which L1 and L2 entries are set
+    l1_bitmap = bytearray(allocated_l1_tables * l1_entries_per_table // 8)
+    l2_bitmap = bytearray(l1_entries * l2_entries_per_table // 8)
+    allocated_l2_tables = 0
+    allocated_data_clusters = 0
+
+    if data_file_raw:
+        # If data_file_raw is set then all clusters are allocated and
+        # we don't need to read the input file at all.
+        allocated_l2_tables = l1_entries
+        for idx in range(l1_entries):
+            bitmap_set(l1_bitmap, idx)
+        for idx in range(total_data_clusters):
+            bitmap_set(l2_bitmap, idx)
+    else:
+        # Open the input file for reading
+        fd = os.open(input_file, os.O_RDONLY)
+        zero_cluster = bytes(cluster_size)
+        # Read all the clusters that contain data
+        for idx in clusters_with_data(fd, cluster_size):
+            cluster = os.pread(fd, cluster_size, cluster_size * idx)
+            # If the last cluster is smaller than cluster_size pad it with zeroes
+            if len(cluster) < cluster_size:
+                cluster += bytes(cluster_size - len(cluster))
+            # If a cluster has non-zero data then it must be allocated
+            # in the output file and its L2 entry must be set
+            if cluster != zero_cluster:
+                bitmap_set(l2_bitmap, idx)
+                allocated_data_clusters += 1
+                # Allocated data clusters also need their corresponding L1 entry and L2 table
+                l1_idx = math.floor(idx / l2_entries_per_table)
+                if not bitmap_is_set(l1_bitmap, l1_idx):
+                    bitmap_set(l1_bitmap, l1_idx)
+                    allocated_l2_tables += 1
+
+    # Total amount of allocated clusters excluding the refcount blocks and table
+    total_allocated_clusters = 1 + allocated_l1_tables + allocated_l2_tables
+    if data_file_name is None:
+        total_allocated_clusters += allocated_data_clusters
+
+    # Clusters allocated for the refcount blocks and table
+    allocated_refcount_blocks = math.ceil(total_allocated_clusters  / refcounts_per_block)
+    allocated_refcount_tables = math.ceil(allocated_refcount_blocks / refcounts_per_table)
+
+    # Now we have a problem because allocated_refcount_blocks and allocated_refcount_tables...
+    # (a) increase total_allocated_clusters, and
+    # (b) need to be recalculated when total_allocated_clusters is increased
+    # So we need to repeat the calculation as long as the numbers change
+    while True:
+        new_total_allocated_clusters = total_allocated_clusters + allocated_refcount_tables + allocated_refcount_blocks
+        new_allocated_refcount_blocks = math.ceil(new_total_allocated_clusters / refcounts_per_block)
+        if new_allocated_refcount_blocks > allocated_refcount_blocks:
+            allocated_refcount_blocks = new_allocated_refcount_blocks
+            allocated_refcount_tables = math.ceil(allocated_refcount_blocks / refcounts_per_table)
+        else:
+            break
+
+    # Now that we have the final numbers we can update total_allocated_clusters
+    total_allocated_clusters += allocated_refcount_tables + allocated_refcount_blocks
+
+    # At this point we have the exact number of clusters that the output
+    # image is going to use so we can calculate all the offsets.
+    current_cluster_idx = 1
+
+    refcount_table_offset = current_cluster_idx * cluster_size
+    current_cluster_idx += allocated_refcount_tables
+
+    refcount_block_offset = current_cluster_idx * cluster_size
+    current_cluster_idx += allocated_refcount_blocks
+
+    l1_table_offset = current_cluster_idx * cluster_size
+    current_cluster_idx += allocated_l1_tables
+
+    l2_table_offset = current_cluster_idx * cluster_size
+    current_cluster_idx += allocated_l2_tables
+
+    data_clusters_offset = current_cluster_idx * cluster_size
+
+    # Calculate some values used in the qcow2 header
+    if allocated_l1_tables == 0:
+        l1_table_offset = 0
+
+    hdr_cluster_bits = int(math.log2(cluster_size))
+    hdr_refcount_bits = int(math.log2(refcount_bits))
+    hdr_length = QCOW2_V3_HEADER_LENGTH
+    hdr_incompat_features = 0
+    if data_file_name is not None:
+        hdr_incompat_features |= 1 << QCOW2_INCOMPAT_DATA_FILE_BIT
+    hdr_autoclear_features = 0
+    if data_file_raw:
+        hdr_autoclear_features |= 1 << QCOW2_AUTOCLEAR_DATA_FILE_RAW_BIT
+
+    ### Write qcow2 header
+    cluster = bytearray(cluster_size)
+    struct.pack_into(">4sIQIIQIIQQIIQQQQII", cluster, 0,
+        b"QFI\xfb",            # QCOW magic string
+        3,                     # version
+        0,                     # backing file offset
+        0,                     # backing file sizes
+        hdr_cluster_bits,
+        disk_size,
+        0,                     # encryption method
+        l1_entries,
+        l1_table_offset,
+        refcount_table_offset,
+        allocated_refcount_tables,
+        0,                     # number of snapshots
+        0,                     # snapshot table offset
+        hdr_incompat_features,
+        0,                     # compatible features
+        hdr_autoclear_features,
+        hdr_refcount_bits,
+        hdr_length,
+    )
+
+    write_features(cluster, hdr_length, data_file_name)
+
+    sys.stdout.buffer.write(cluster)
+
+    ### Write refcount table
+    cur_offset = refcount_block_offset
+    remaining_refcount_table_entries = allocated_refcount_blocks # Each entry is a pointer to a refcount block
+    while remaining_refcount_table_entries > 0:
+        cluster = bytearray(cluster_size)
+        to_write = min(remaining_refcount_table_entries, refcounts_per_table)
+        remaining_refcount_table_entries -= to_write
+        for idx in range(to_write):
+            struct.pack_into(">Q", cluster, idx * 8, cur_offset)
+            cur_offset += cluster_size
+        sys.stdout.buffer.write(cluster)
+
+    ### Write refcount blocks
+    remaining_refcount_block_entries = total_allocated_clusters # One entry for each allocated cluster
+    for tbl in range(allocated_refcount_blocks):
+        cluster = bytearray(cluster_size)
+        to_write = min(remaining_refcount_block_entries, refcounts_per_block)
+        remaining_refcount_block_entries -= to_write
+        # All refcount entries contain the number 1. The only difference
+        # is their bit width, defined when the image is created.
+        for idx in range(to_write):
+            if refcount_bits == 64:
+                struct.pack_into(">Q", cluster, idx * 8, 1)
+            elif refcount_bits == 32:
+                struct.pack_into(">L", cluster, idx * 4, 1)
+            elif refcount_bits == 16:
+                struct.pack_into(">H", cluster, idx * 2, 1)
+            elif refcount_bits == 8:
+                cluster[idx] = 1
+            elif refcount_bits == 4:
+                cluster[idx // 2] |= 1 << ((idx % 2) * 4)
+            elif refcount_bits == 2:
+                cluster[idx // 4] |= 1 << ((idx % 4) * 2)
+            elif refcount_bits == 1:
+                cluster[idx // 8] |= 1 << (idx % 8)
+        sys.stdout.buffer.write(cluster)
+
+    ### Write L1 table
+    cur_offset = l2_table_offset
+    for tbl in range(allocated_l1_tables):
+        cluster = bytearray(cluster_size)
+        for idx in range(l1_entries_per_table):
+            l1_idx = tbl * l1_entries_per_table + idx
+            if bitmap_is_set(l1_bitmap, l1_idx):
+                struct.pack_into(">Q", cluster, idx * 8, cur_offset | QCOW_OFLAG_COPIED)
+                cur_offset += cluster_size
+        sys.stdout.buffer.write(cluster)
+
+    ### Write L2 tables
+    cur_offset = data_clusters_offset
+    for tbl in range(l1_entries):
+        # Skip the empty L2 tables. We can identify them because
+        # there is no L1 entry pointing at them.
+        if bitmap_is_set(l1_bitmap, tbl):
+            cluster = bytearray(cluster_size)
+            for idx in range(l2_entries_per_table):
+                l2_idx = tbl * l2_entries_per_table + idx
+                if bitmap_is_set(l2_bitmap, l2_idx):
+                    if data_file_name is None:
+                        struct.pack_into(">Q", cluster, idx * 8, cur_offset | QCOW_OFLAG_COPIED)
+                        cur_offset += cluster_size
+                    else:
+                        struct.pack_into(">Q", cluster, idx * 8, (l2_idx * cluster_size) | QCOW_OFLAG_COPIED)
+            sys.stdout.buffer.write(cluster)
+
+    ### Write data clusters
+    if data_file_name is None:
+        for idx in bitmap_iterator(l2_bitmap, total_data_clusters):
+            cluster = os.pread(fd, cluster_size, cluster_size * idx)
+            # If the last cluster is smaller than cluster_size pad it with zeroes
+            if len(cluster) < cluster_size:
+                cluster += bytes(cluster_size - len(cluster))
+            sys.stdout.buffer.write(cluster)
+
+    if not data_file_raw:
+        os.close(fd)
+
+
+def main():
+    # Command-line arguments
+    parser = argparse.ArgumentParser(
+        description="This program converts a QEMU disk image to qcow2 "
+        "and writes it to the standard output"
+    )
+    parser.add_argument("input_file", help="name of the input file")
+    parser.add_argument(
+        "-f",
+        dest="input_format",
+        metavar="input_format",
+        help="format of the input file (default: raw)",
+        default="raw",
+    )
+    parser.add_argument(
+        "-c",
+        dest="cluster_size",
+        metavar="cluster_size",
+        help=f"qcow2 cluster size (default: {QCOW2_DEFAULT_CLUSTER_SIZE})",
+        default=QCOW2_DEFAULT_CLUSTER_SIZE,
+        type=int,
+        choices=[1 << x for x in range(9, 22)],
+    )
+    parser.add_argument(
+        "-r",
+        dest="refcount_bits",
+        metavar="refcount_bits",
+        help=f"width of the reference count entries (default: {QCOW2_DEFAULT_REFCOUNT_BITS})",
+        default=QCOW2_DEFAULT_REFCOUNT_BITS,
+        type=int,
+        choices=[1 << x for x in range(7)],
+    )
+    parser.add_argument(
+        "-d",
+        dest="data_file",
+        help="create an image with input_file as an external data file",
+        action="store_true",
+    )
+    parser.add_argument(
+        "-R",
+        dest="data_file_raw",
+        help="enable data_file_raw on the generated image (implies -d)",
+        action="store_true",
+    )
+    args = parser.parse_args()
+
+    if args.data_file_raw:
+        args.data_file = True
+
+    if not os.path.isfile(args.input_file):
+        sys.exit(f"[Error] {args.input_file} does not exist or is not a regular file.")
+
+    if args.data_file and args.input_format != "raw":
+        sys.exit("[Error] External data files can only be used with raw input images")
+
+    # A 512 byte header is too small for the data file name extension
+    if args.data_file and args.cluster_size == 512:
+        sys.exit("[Error] External data files require a larger cluster size")
+
+    if sys.stdout.isatty():
+        sys.exit("[Error] Refusing to write to a tty. Try redirecting stdout.")
+
+    if args.data_file:
+        data_file_name = args.input_file
+    else:
+        data_file_name = None
+
+    with get_input_as_raw_file(args.input_file, args.input_format) as raw_file:
+        write_qcow2_content(
+            raw_file,
+            args.cluster_size,
+            args.refcount_bits,
+            data_file_name,
+            args.data_file_raw,
+        )
+
+
+if __name__ == "__main__":
+    main()
-- 
2.39.2


