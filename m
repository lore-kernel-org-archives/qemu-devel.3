Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927FEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawqU-000838-H2; Mon, 05 Aug 2024 08:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sawqS-0007zg-7n
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:29:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sawqP-0003ST-TD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722860984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EbNxwy4nq45DR3stOn3/4fMrHkvOsl4ieEtBuD0h3k8=;
 b=RPz9IjPFQrJBNAfkcfXPndCgqjAEjOMPQGAXZOT9PiB6D2sGSMHmW5Eia2LmWEdbyAlR0D
 80GgVnrJQgPjkauE+AC7/Urh1PHAKZQr+uVuJ/L57PglF7pRfj7VS0JZfas45AiROGIYv6
 WNq/ot/kYWYl0qtdYSJsbNsP8Sq38CI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-iCedijLLNWOP0NW9Prgwfg-1; Mon,
 05 Aug 2024 08:29:41 -0400
X-MC-Unique: iCedijLLNWOP0NW9Prgwfg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3542195609E; Mon,  5 Aug 2024 12:29:39 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.224])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DB511955F40; Mon,  5 Aug 2024 12:29:36 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:29:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 den@virtuozzo.com
Subject: Re: [PATCH v3 3/3] scripts: add filev2p.py script for mapping
 virtual file offsets mapping
Message-ID: <ZrDFri3ydbPwuPKM@redhat.com>
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-4-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716144123.651476-4-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
> The script is basically a wrapper around "filefrag" utility.  This might
> be used to map virtual offsets within the file to the underlying block
> device offsets.  In addition, a chunk size might be specified, in which
> case a list of such mappings will be obtained:
> 
> $ scripts/filev2p.py -s 100M /sparsefile 1768M
> 1853882368..1895825407 (file)  ->  16332619776..16374562815 (/dev/sda4)  ->  84492156928..84534099967 (/dev/sda)
> 1895825408..1958739967 (file)  ->  17213591552..17276506111 (/dev/sda4)  ->  85373128704..85436043263 (/dev/sda)
> 
> This could come in handy when we need to map a certain piece of data
> within a file inside VM to the same data within the image on the host
> (e.g. physical offset on VM's /dev/sda would be the virtual offset
> within QCOW2 image).
> 
> Note: as of now the script only works with the files located on plain
> partitions, i.e. it doesn't work with partitions built on top of LVM.
> Partitions on LVM would require another level of mapping.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  scripts/filev2p.py | 311 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 311 insertions(+)
>  create mode 100755 scripts/filev2p.py
> 
> diff --git a/scripts/filev2p.py b/scripts/filev2p.py
> new file mode 100755
> index 0000000000..3bd7d18b5e
> --- /dev/null
> +++ b/scripts/filev2p.py
> @@ -0,0 +1,311 @@
> +#!/usr/bin/env python3
> +#
> +# Map file virtual offset to the offset on the underlying block device.
> +# Works by parsing 'filefrag' output.
> +#
> +# Copyright (c) 2024 Virtuozzo International GmbH.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +
> +import argparse
> +import os
> +import subprocess
> +import re
> +import sys
> +
> +from bisect import bisect_right
> +from collections import namedtuple
> +from dataclasses import dataclass
> +from shutil import which
> +from stat import S_ISBLK
> +
> +
> +Partition = namedtuple('Partition', ['partpath', 'diskpath', 'part_offt'])
> +
> +
> +@dataclass
> +class Extent:
> +    '''Class representing an individual file extent.
> +
> +    This is basically a piece of data within the file which is located
> +    consecutively (i.e. not sparsely) on the underlying block device.
> +    '''

Python docstrings should always be triple double quotes """...""" as per
PEP 257.

Some functions below even use a single single quote because they are on
a single line. They should still use the same convention.

> +
> +    log_start:  int
> +    log_end:    int
> +    phys_start: int
> +    phys_end:   int
> +    length:     int
> +    partition:  Partition
> +
> +    @property
> +    def disk_start(self):
> +        'Number of the first byte of this extent on the whole disk (/dev/sda)'
> +        return self.partition.part_offt + self.phys_start
> +
> +    @property
> +    def disk_end(self):
> +        'Number of the last byte of this extent on the whole disk (/dev/sda)'
> +        return self.partition.part_offt + self.phys_end
> +
> +    def __str__(self):
> +        ischunk = self.log_end > self.log_start
> +        maybe_end = lambda s: f'..{s}' if ischunk else ''
> +        return '%s%s (file)  ->  %s%s (%s)  ->  %s%s (%s)' % (
> +            self.log_start, maybe_end(self.log_end),
> +            self.phys_start, maybe_end(self.phys_end), self.partition.partpath,
> +            self.disk_start, maybe_end(self.disk_end), self.partition.diskpath
> +        )
> +
> +    @classmethod
> +    def ext_slice(cls, bigger_ext, start, end):
> +        '''Constructor for the Extent class from a bigger extent.
> +
> +        Return Extent instance which is a slice of @bigger_ext contained
> +        within the range [start, end].
> +        '''
> +
> +        assert start >= bigger_ext.log_start
> +        assert end <= bigger_ext.log_end
> +
> +        if start == bigger_ext.log_start and end == bigger_ext.log_end:
> +            return bigger_ext
> +
> +        phys_start = bigger_ext.phys_start + (start - bigger_ext.log_start)
> +        phys_end = bigger_ext.phys_end - (bigger_ext.log_end - end)
> +        length = end - start + 1
> +
> +        return cls(start, end, phys_start, phys_end, length,
> +                   bigger_ext.partition)
> +
> +
> +def run_cmd(cmd: str) -> str:
> +    '''Wrapper around subprocess.run.
> +
> +    Returns stdout in case of success, emits en error and exits in case
> +    of failure.
> +    '''
> +
> +    proc = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
> +                          check=False, shell=True)
> +    if proc.stderr is not None:
> +        stderr = f'\n{proc.stderr.decode().strip()}'
> +    else:
> +        stderr = ''
> +
> +    if proc.returncode:
> +        sys.exit(f'Error: Command "{cmd}" returned {proc.returncode}:{stderr}')
> +
> +    return proc.stdout.decode().strip()
> +
> +
> +def parse_size(offset: str) -> int:
> +    'Convert human readable size to bytes'
> +
> +    suffixes = {
> +        **dict.fromkeys(['k', 'K', 'Kb', 'KB', 'KiB'], 2 ** 10),
> +        **dict.fromkeys(['m', 'M', 'Mb', 'MB', 'MiB'], 2 ** 20),
> +        **dict.fromkeys(['g', 'G', 'Gb', 'GB', 'GiB'], 2 ** 30),
> +        **dict.fromkeys(     ['T', 'Tb', 'TB', 'TiB'], 2 ** 40),
> +        **dict.fromkeys([''],                          1)
> +    }
> +
> +    sizematch = re.match(r'^([0-9]+)\s*([a-zA-Z]*)$', offset)
> +    if not bool(sizematch):
> +        sys.exit(f'Error: Couldn\'t parse size "{offset}". Pass offset '
> +                  'either in bytes or in format 1K, 2M, 3G')
> +
> +    num, suff = sizematch.groups()
> +    num = int(num)
> +
> +    mult = suffixes.get(suff)
> +    if mult is None:
> +        sys.exit(f'Error: Couldn\'t parse size "{offset}": '
> +                 f'unknown suffix {suff}')
> +
> +    return num * mult
> +
> +
> +def fpath2part(filename: str) -> str:
> +    'Get partition on which @filename is located (i.e. /dev/sda1).'
> +
> +    partpath = run_cmd(f'df --output=source {filename} | tail -n+2')

Anything passed to a shell (like {filename}) certainly must have proper
quoting applied to avoid shell injections?

> +    if not os.path.exists(partpath) or not S_ISBLK(os.stat(partpath).st_mode):
> +        sys.exit(f'Error: file {filename} is located on {partpath} which '
> +                 'isn\'t a block device')
> +    return partpath
> +
> +
> +def part2dev(partpath: str, filename: str) -> str:
> +    'Get block device on which @partpath is located (i.e. /dev/sda).'
> +    dev = run_cmd(f'lsblk -no PKNAME {partpath}')

Missing quoting here, too.

> +    diskpath = f'/dev/{dev}'
> +    if not os.path.exists(diskpath) or not S_ISBLK(os.stat(diskpath).st_mode):
> +        sys.exit(f'Error: file {filename} is located on {diskpath} which '
> +                 'isn\'t a block device')
> +    return diskpath
> +
> +
> +def part2disktype(partpath: str) -> str:
> +    'Parse /proc/devices and get block device type for @partpath'
> +
> +    major = os.major(os.stat(partpath).st_rdev)
> +    assert major
> +    with open('/proc/devices', encoding='utf-8') as devf:
> +        for line in reversed(list(devf)):
> +            # Our major cannot be absent among block devs
> +            if line.startswith('Block'):
> +                break
> +            devmajor, devtype = line.strip().split()
> +            if int(devmajor) == major:
> +                return devtype
> +
> +    sys.exit('Error: We haven\'t found major {major} in /proc/devices, '
> +             'and that can\'t be')
> +
> +
> +def get_part_offset(part: str, disk: str) -> int:
> +    'Get offset in bytes of the partition @part on the block device @disk.'
> +
> +    lines = run_cmd(f'fdisk -l {disk} | egrep "^(Units|{part})"').splitlines()

And here.

We should probably also match a space after {part} to avoid selecting
other partitions that have {part} as a prefix (like partition 10 when we
want partition 1). I think we would actually always get the wanted one
first, but it would be cleaner to not even have the others in the
output.

> +
> +    unitmatch = re.match('^.* = ([0-9]+) bytes$', lines[0])
> +    if not bool(unitmatch):
> +        sys.exit(f'Error: Couldn\'t parse "fdisk -l" output:\n{lines[0]}')
> +    secsize = int(unitmatch.group(1))
> +
> +    part_offt = int(lines[1].split()[1])
> +    return part_offt * secsize
> +
> +
> +def parse_frag_line(line: str, partition: Partition) -> Extent:
> +    'Construct Extent instance from a "filefrag" output line.'
> +
> +    nums = [int(n) for n in re.findall(r'[0-9]+', line)]
> +
> +    log_start  = nums[1]
> +    log_end    = nums[2]
> +    phys_start = nums[3]
> +    phys_end   = nums[4]
> +    length     = nums[5]
> +
> +    assert log_start < log_end
> +    assert phys_start < phys_end
> +    assert (log_end - log_start + 1) == (phys_end - phys_start + 1) == length
> +
> +    return Extent(log_start, log_end, phys_start, phys_end, length, partition)
> +
> +
> +def preliminary_checks(args: argparse.Namespace) -> None:
> +    'A bunch of checks to emit an error and exit at the earlier stage.'
> +
> +    if which('filefrag') is None:
> +        sys.exit('Error: Program "filefrag" doesn\'t exist')
> +
> +    if not os.path.exists(args.filename):
> +        sys.exit(f'Error: File {args.filename} doesn\'t exist')
> +
> +    args.filesize = os.path.getsize(args.filename)
> +    if args.offset >= args.filesize:
> +        sys.exit(f'Error: Specified offset {args.offset} exceeds '
> +                 f'file size {args.filesize}')
> +    if args.size and (args.offset + args.size > args.filesize):
> +        sys.exit(f'Error: Chunk of size {args.size} at offset '
> +                 f'{args.offset} exceeds file size {args.filesize}')
> +
> +    args.partpath = fpath2part(args.filename)
> +    args.disktype = part2disktype(args.partpath)
> +    if args.disktype not in ('sd', 'virtblk'):
> +        sys.exit(f'Error: Cannot analyze files on {args.disktype} disks')
> +    args.diskpath = part2dev(args.partpath, args.filename)
> +    args.part_offt = get_part_offset(args.partpath, args.diskpath)
> +
> +
> +def get_extent_maps(args: argparse.Namespace) -> list[Extent]:
> +    'Run "filefrag", parse its output and return a list of Extent instances.'
> +
> +    lines = run_cmd(f'filefrag -b1 -v {args.filename}').splitlines()

And the final missing quoting.

> +
> +    ffinfo_re = re.compile('.* is ([0-9]+) .*of ([0-9]+) bytes')
> +    ff_size, ff_block = re.match(ffinfo_re, lines[1]).groups()
> +
> +    # Paranoia checks
> +    if int(ff_size) != args.filesize:
> +        sys.exit('Error: filefrag and os.path.getsize() report different '
> +                 f'sizes: {ff_size} and {args.filesize}')
> +    if int(ff_block) != 1:
> +        sys.exit(f'Error: "filefrag -b1" invoked, but block size is {ff_block}')
> +
> +    partition = Partition(args.partpath, args.diskpath, args.part_offt)
> +
> +    # Fill extents list from the output
> +    extents = []
> +    for line in lines:
> +        if not re.match(r'^\s*[0-9]+:', line):
> +            continue
> +        extents += [parse_frag_line(line, partition)]
> +
> +    chunk_start = args.offset
> +    chunk_end = args.offset + args.size - 1
> +    ext_offsets = [ext.log_start for ext in extents]
> +    start_ind = bisect_right(ext_offsets, chunk_start) - 1
> +    end_ind = bisect_right(ext_offsets, chunk_end) - 1
> +
> +    res_extents = extents[start_ind : end_ind + 1]
> +    for i, ext in enumerate(res_extents):
> +        start = max(chunk_start, ext.log_start)
> +        end = min(chunk_end, ext.log_end)
> +        res_extents[i] = Extent.ext_slice(ext, start, end)
> +
> +    return res_extents
> +
> +
> +def parse_args() -> argparse.Namespace:
> +    'Define program arguments and parse user input.'
> +
> +    parser = argparse.ArgumentParser(description='''
> +Map file offset to physical offset on the block device
> +
> +With --size provided get a list of mappings for the chunk''',
> +    formatter_class=argparse.RawTextHelpFormatter)
> +
> +    parser.add_argument('filename', type=str, help='filename to process')
> +    parser.add_argument('offset', type=str,
> +                        help='logical offset inside the file')
> +    parser.add_argument('-s', '--size', required=False, type=str,
> +                        help='size of the file chunk to get offsets for')
> +    args = parser.parse_args()
> +
> +    args.offset = parse_size(args.offset)
> +    if args.size:
> +        args.size = parse_size(args.size)
> +    else:
> +        # When no chunk size is provided (only offset), it's equivalent to
> +        # chunk size == 1
> +        args.size = 1
> +
> +    return args
> +
> +
> +def main() -> int:
> +    args = parse_args()
> +    preliminary_checks(args)
> +    extents = get_extent_maps(args)
> +    for ext in extents:
> +        print(ext)
> +
> +
> +if __name__ == '__main__':
> +    sys.exit(main())

Kevin


