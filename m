Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C79CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKDWy-0003kU-6k; Tue, 05 May 2026 07:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKDWw-0003gp-14; Tue, 05 May 2026 07:01:34 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1wKDWt-0005QI-Fg; Tue, 05 May 2026 07:01:33 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 59CA9408C4;
 Tue, 05 May 2026 13:01:28 +0200 (CEST)
Message-ID: <e86b82e4-a85d-46d2-bb8f-4e0f59e49a44@proxmox.com>
Date: Tue, 5 May 2026 13:01:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 08/28] fuse: Set direct_io and parallel_direct_writes
From: Fiona Ebner <f.ebner@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-9-kwolf@redhat.com>
 <72090fa4-2f4e-483d-9ceb-c19b8119a25d@proxmox.com>
 <17fe584f-6c64-4ccf-8253-c813665e0070@proxmox.com>
Content-Language: en-US
In-Reply-To: <17fe584f-6c64-4ccf-8253-c813665e0070@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1777978780989
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

Am 05.05.26 um 11:03 AM schrieb Fiona Ebner:
> Am 30.04.26 um 4:20 PM schrieb Fiona Ebner:
>> Dear Maintainers,
>>
>> Am 10.03.26 um 6:33 PM schrieb Kevin Wolf:
>>> From: Hanna Czenczek <hreitz@redhat.com>
>>>
>>> In fuse_open(), set these flags:
>>> - direct_io: We probably actually don't want to have the host page cache
>>>   be used for our exports.  QEMU block exports are supposed to represent
>>>   the image as-is (and thus potentially changing).
>>>   This causes a change in iotest 308's reference output.
>>>
>>> - parallel_direct_writes: We can (now) cope with parallel writes, so we
>>>   should set this flag.  For some reason, it doesn't seem to make an
>>>   actual performance difference with libfuse, but it does make a
>>>   difference without it, so let's set it.
>>>   (See "fuse: Copy write buffer content before polling" for further
>>>   discussion.)
>>>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>> Message-ID: <20260309150856.26800-9-hreitz@redhat.com>
>>> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/export/fuse.c        | 2 ++
>>>  tests/qemu-iotests/308.out | 2 +-
>>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/export/fuse.c b/block/export/fuse.c
>>> index 0422cf4b8af..d0e3c6bf61f 100644
>>> --- a/block/export/fuse.c
>>> +++ b/block/export/fuse.c
>>> @@ -582,6 +582,8 @@ static void fuse_setattr(fuse_req_t req, fuse_ino_t inode, struct stat *statbuf,
>>>  static void fuse_open(fuse_req_t req, fuse_ino_t inode,
>>>                        struct fuse_file_info *fi)
>>>  {
>>> +    fi->direct_io = true;
>>
>> unfortunately, turning on direct IO here breaks a use case with swtpm.
>> Reproducer below [0], which fails with an error message
>>   /usr/bin/swtpm exit with status 256:
>> after this commit.
>>
>> Dropping the FOPEN_DIRECT_IO flag in current master makes the reproducer
>> work again.
>>
>> Should there be a BlockExportOptionsFuse property to control the direct
>> IO flag and have it be opt-in to avoid this breakage (and potentially
>> others)?
>>
>> Best Regards,
>> Fiona
>>
>> [0]:
>>
>>> #!/bin/bash
>>> rm /tmp/disk.qcow2
>>> rm /tmp/export.fuse
>>> ./qemu-img create -f qcow2 /tmp/disk.qcow2 4M
>>> touch /tmp/export.fuse
>>> (
>>> ./storage-daemon/qemu-storage-daemon \
>>>     --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
>>>     --export fuse,id=exp0,mountpoint=/tmp/export.fuse,node-name=node0,writable=true \
>>>     --chardev socket,id=qmp,path=/run/qsd.qmp,server=on,wait=off \
>>>     --monitor chardev=qmp,mode=control
>>> ) &
>>> sleep 1 # too lazy to do proper synchronization for the reproducer here
>>> swtpm_setup --tpmstate file:///tmp/export.fuse --createek
>>> echo '{"execute": "qmp_capabilities"}{"execute": "quit"}' | socat - /run/qsd.qmp
> 
> Self-contained version modeling the relevant part of swtpm_setup:
> 
>> #!/bin/bash
>>
>> cat - > /tmp/mmap.c <<EOF
>> #include <assert.h>
>> #include <fcntl.h>
>> #include <stddef.h>
>> #include <sys/stat.h>
>> #include <sys/mman.h>
>>
>> int main(int argc, char **argv)
>> {
>>     struct stat st;
>>     int fd;
>>     void *ptr;
>>
>>     assert(argc == 2);
>>     fd = open(argv[1], O_RDWR|O_CREAT, 0x640);
>>     assert(fd > 0);
>>     fstat(fd, &st);
>>     ptr = mmap(NULL, st.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>>     assert(ptr != MAP_FAILED);
>>     return 0;
>> }
>> EOF
>> gcc /tmp/mmap.c -o /tmp/mmap
>>
>> rm /tmp/disk.qcow2
>> rm /tmp/export.fuse
>> ./qemu-img create -f qcow2 /tmp/disk.qcow2 4M
>> touch /tmp/export.fuse
>>
>> (
>> ./storage-daemon/qemu-storage-daemon \
>>     --blockdev qcow2,node-name=node0,file.driver=file,file.filename=/tmp/disk.qcow2 \
>>     --export fuse,id=exp0,mountpoint=/tmp/export.fuse,node-name=node0,writable=true \
>>     --chardev socket,id=qmp,path=/run/qsd.qmp,server=on,wait=off \
>>     --monitor chardev=qmp,mode=control
>> ) &
>>
>> sleep 1 # too lazy to do proper synchronization for the reproducer here
>> /tmp/mmap /tmp/export.fuse
>> echo '{"execute": "qmp_capabilities"}{"execute": "quit"}' | socat - /run/qsd.qmp

The kernel docs [0] mention:

"In direct-io mode the page cache is completely bypassed for reads and
writes. No read-ahead takes place. Shared mmap is disabled by default.
To allow shared mmap, the FUSE_DIRECT_IO_ALLOW_MMAP flag may be enabled
in the FUSE_INIT reply."

I quickly tested with setting FUSE_DIRECT_IO_ALLOW_MMAP in
fuse_co_init() (it's part of the flags2 ones, so also requires
FUSE_INIT_EXT to be set in the flags) and this makes the swtpm use case
work again :)

So, should that flag be set by default (if supported by the kernel) for
backwards compatibility? Or what should we do about the issue?

Best Regards,
Fiona

[0]: https://www.kernel.org/doc/html/next/filesystems/fuse/fuse-io.html


