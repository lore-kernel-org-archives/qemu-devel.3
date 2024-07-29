Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E4EC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcra-000372-Fm; Mon, 29 Jul 2024 22:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sYcrY-00035g-R6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:45:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sYcrU-0003PZ-QM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722307515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wTnNITLF+ay57NHcSL5inlZrZSqr0dmvQUxBDeoYcEE=;
 b=bVhDKbSne/tVpUPkNRkf1lVHzV43ybHLrdoWn+u8x7+l16kXX4iHFrfCX2eUzyPr7sw/Sn
 PrhaZGqrmqP0TLrV4KF5mtvuSRiVtjulp8KHt0nz7NYGl7FK5Dfa6AlukrTI6XkeSw2sSC
 zk7KRwvyC3tAK/SguD2nHjq4aiOSUwo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-Sfn1QeOsPoKiSzQmzPFmiQ-1; Mon,
 29 Jul 2024 16:20:33 -0400
X-MC-Unique: Sfn1QeOsPoKiSzQmzPFmiQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4E491944A86; Mon, 29 Jul 2024 20:20:25 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E1183000194; Mon, 29 Jul 2024 20:20:20 +0000 (UTC)
Date: Mon, 29 Jul 2024 15:20:18 -0500
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Czenczek <hreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>, 
 Madeeha Javed <javed@igalia.com>
Subject: Re: [PATCH v3] scripts/qcow2-to-stdout.py: Add script to write qcow2
 images to stdout
Message-ID: <pz7gy26uyetg2d7vzudxtoiwqppd4iddo7ctno7lrbumghxzvf@nny3z2qshvsc>
References: <20240729150226.71250-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729150226.71250-1-berto@igalia.com>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 29, 2024 at 05:02:26PM GMT, Alberto Garcia wrote:
> This tool converts a disk image to qcow2, writing the result directly
> to stdout. This can be used for example to send the generated file
> over the network.

Overall seems like a useful idea to me.

> 
> This is equivalent to using qemu-img to convert a file to qcow2 and
> then writing the result to stdout, with the difference that this tool
> does not need to create this temporary qcow2 file and therefore does
> not need any additional disk space.
> 
> Implementing this directly in qemu-img is not really an option because
> it expects the output file to be seekable and it is also meant to be a
> generic tool that supports all combinations of file formats and image
> options. Instead, this tool can only produce qcow2 files with the
> basic options, without compression, encryption or other features.
> 
> The input file is read twice. The first pass is used to determine
> which clusters contain non-zero data and that information is used to
> create the qcow2 header, refcount table and blocks, and L1 and L2
> tables. After all that metadata is created then the second pass is
> used to write the guest data.
> 
> By default qcow2-to-stdout.py expects the input to be a raw file, but
> if qemu-storage-daemon is available then it can also be used to read
> images in other formats. Alternatively the user can also run qemu-ndb

qemu-nbd

> or qemu-storage-daemon manually instead.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Madeeha Javed <javed@igalia.com>
> ---
>  scripts/qcow2-to-stdout.py | 400 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 400 insertions(+)
>  create mode 100755 scripts/qcow2-to-stdout.py
> 

> +++ b/scripts/qcow2-to-stdout.py
> @@ -0,0 +1,400 @@
> +#!/usr/bin/env python3
> +
> +# This tool reads a disk image in any format and converts it to qcow2,
> +# writing the result directly to stdout.
> +#
> +# Copyright (C) 2024 Igalia, S.L.
> +#
> +# Authors: Alberto Garcia <berto@igalia.com>
> +#          Madeeha Javed <javed@igalia.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# qcow2 files produced by this script are always arranged like this:
> +#
> +# - qcow2 header
> +# - refcount table
> +# - refcount blocks
> +# - L1 table
> +# - L2 tables
> +# - Data clusters

Is it easy to make your tool spit out a qcow2 image with external data
file (to write a quick qcow2 wrapper for an existing file to now be
used as external data)?  Or is that too much of a difference from the
intended use of this tool?

> +#
> +# A note about variable names: in qcow2 there is one refcount table
> +# and one (active) L1 table, although each can occupy several
> +# clusters. For the sake of simplicity the code sometimes talks about
> +# refcount tables and L1 tables when referring to those clusters.
> +
> +import argparse
> +import errno
> +import math
> +import os
> +import signal
> +import struct
> +import subprocess
> +import sys
> +import tempfile
> +import time
> +from contextlib import contextmanager
> +
> +QCOW2_DEFAULT_CLUSTER_SIZE = 65536
> +QCOW2_DEFAULT_REFCOUNT_BITS = 16
> +QCOW2_DEFAULT_VERSION = 3
> +QCOW2_FEATURE_NAME_TABLE = 0x6803F857
> +QCOW2_V3_HEADER_LENGTH = 112  # Header length in QEMU 9.0. Must be a multiple of 8
> +QCOW_OFLAG_COPIED = 1 << 63
> +QEMU_STORAGE_DAEMON = "qemu-storage-daemon"
> +
> +
> +def bitmap_set(bitmap, idx):
> +    bitmap[idx // 8] |= 1 << (idx % 8)
> +
> +
> +def bitmap_is_set(bitmap, idx):
> +    return (bitmap[idx // 8] & (1 << (idx % 8))) != 0
> +
> +
> +def bitmap_iterator(bitmap, length):
> +    for idx in range(length):
> +        if bitmap_is_set(bitmap, idx):
> +            yield idx
> +
> +
> +# Holes in the input file contain only zeroes so we can skip them and
> +# save time. This function returns the indexes of the clusters that
> +# are known to contain data. Those are the ones that we need to read.
> +def clusters_with_data(fd, cluster_size):
> +    data_off = 0
> +    while True:
> +        hole_off = os.lseek(fd, data_off, os.SEEK_HOLE)
> +        for idx in range(data_off // cluster_size, math.ceil(hole_off / cluster_size)):
> +            yield idx
> +        try:
> +            data_off = os.lseek(fd, hole_off, os.SEEK_DATA)

Depending on the size of cluster_size, this could return the same
offset more than once (for example, for 1M clusters but 64k
granularity on holes, consider what happens if lseek(0, SEEK_HOLE)
returns 64k, then lseek(64k, SEEK_DATA) returns 128k: you end up
yielding idx 0 twice).  You may need to be more careful than that.

> +        except OSError as err:
> +            if err.errno == errno.ENXIO: # End of file reached
> +                break
> +            raise err
> +
> +
> +# write_qcow2_content() expects a raw input file. If we have a different
> +# format we can use qemu-storage-daemon to make it appear as raw.
> +@contextmanager
> +def get_input_as_raw_file(input_file, input_format):
> +    if input_format == "raw":
> +        yield input_file
> +        return
> +    try:
> +        temp_dir = tempfile.mkdtemp()
> +        pid_file = os.path.join(temp_dir, "pid")
> +        raw_file = os.path.join(temp_dir, "raw")
> +        open(raw_file, "wb").close()
> +        ret = subprocess.run(
> +            [
> +                QEMU_STORAGE_DAEMON,
> +                "--daemonize",
> +                "--pidfile", pid_file,
> +                "--blockdev", f"driver=file,node-name=file0,driver=file,filename={input_file},read-only=on",
> +                "--blockdev", f"driver={input_format},node-name=disk0,file=file0,read-only=on",
> +                "--export", f"type=fuse,id=export0,node-name=disk0,mountpoint={raw_file},writable=off",
> +            ],
> +            capture_output=True,
> +        )

Does q-s-d exposing an image as raw still support lseek(SEEK_HOLE)
efficiently?

> +    parser.add_argument(
> +        "-v",
> +        dest="qcow2_version",
> +        metavar="qcow2_version",
> +        help=f"qcow2 version (default: {QCOW2_DEFAULT_VERSION})",
> +        default=QCOW2_DEFAULT_VERSION,
> +        type=int,
> +        choices=[2, 3],

Is it really worth trying to create v2 images?  These days, v3 images
are hands down better, and we should be encouraging people to upgrade
their tools to v3 all around, rather than making it easy to still
consume v2 images.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


