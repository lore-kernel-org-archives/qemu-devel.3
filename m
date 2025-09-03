Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1D4CA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 18:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utrxQ-0001I3-2o; Wed, 03 Sep 2025 14:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1utrx9-0001DG-Ob; Wed, 03 Sep 2025 14:11:28 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hibriansong@gmail.com>)
 id 1utrx7-0001D4-1m; Wed, 03 Sep 2025 14:11:27 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4b490287648so3193931cf.2; 
 Wed, 03 Sep 2025 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756923083; x=1757527883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZKjqJwC/8q/gwz7/7GMiCg/8F+ePG2Qt/FcNhSVg4AQ=;
 b=kCmqjK21qwk0YQIfIujsL3jFEPkmGp2PBMFYC1d6z45NBFta63wOd5iavxkHP89X50
 R2QjeMYD14D5Hs+rcCCiLgIWtWUNgMu2fCsX4yIIK4rP7wECmtcLab57WUwJU45IBtdR
 LNla39j5fyVByzanEMmLxznYWQvO6289sr+U4O6EIz5XPTl23B0kHFur1z7S/i/IuOIm
 TVYg3PVm4qrRJp7LzAvKoC8BMPZOabvvHF5Mjv8r/y23d4V6FGa6d3DknLISKG8BOlYe
 4Jm7qKrT7+1+CeaxHGzR5Srm4TybKndIJR91bmEPD0n0COnGtHPeIhmk6ZKE5ZSjJEIb
 tTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756923083; x=1757527883;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKjqJwC/8q/gwz7/7GMiCg/8F+ePG2Qt/FcNhSVg4AQ=;
 b=mAIgEsNXVtb5OPsoqgyN4kYqsSy4TwmpeNteb+ySQGmR/zUIV3n7uuPkL4VfYx5mnC
 qf9zJeUggLB8unKlmnabTgT4S40BbfNLm1GOjJi0J9RmR9jB+iKXxFgF9WCZ9dv+Ox9Y
 zY54l6Ju7anZqAxqYuc75GD9JkpsM1H774WGigQIWTLS0HUNzGy/FXAQbbrQ5SePSy2C
 jQGJdjjfqD/GchMRmzkwF40kbjfnRD5Jl8RfoBUUGBeW0BAODid8MsPqgEXYJcU8ITui
 KQiLSOaTAxh0lS2Je0HGgn9MksQMkwdGtrLBWgPK5z9PDEuYocEKZ8geq4Sf6YOuv4j+
 E7HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmWXN690he2QfgeWry/SfZ2MHXwYvOQQGhDHHJh++vytlXnsy9Xy8ziLqNOOLSwkmuE2by3QUCrpeU@nongnu.org
X-Gm-Message-State: AOJu0YxnoHz/09zcARDzMkXljFW8DOV3f1ekjwdoUYPKDedshYH3+cZo
 i8JQs/GUYDXtsz06+FBjP8wJGVm4A2h5FshcfP4nGPQNQpG2ngsJMT6/
X-Gm-Gg: ASbGncv7F3z7z51zLQOya7yFhhnGFK2J6nPdoisRHb1G0kWfHEbos7pDfyDiqv1RkVh
 aMJkaRnYpfGNHTSbMVHLIfDroXTmvdP9cHkpl3fLLAUweioF0NfeuZ9qlsOvth4lCOJlWAvu8Cu
 47lvhFIt8UE/Aql09H0YZBXctxYQU5afwSkfJKWP1qsf3/mTAu89takiDJXDRyAN5HVxIXBt1G7
 PeNQ7hEUiBsDpUPvWRsJZOz/1Jc1748+CxVV1Gv4Z3FGKCOL+Nn3NH1LV7T8cpTR2b+enhc7DuC
 qXg+Lx1OfrMigOeCdsbKlSE1mfoRFWGv1GdAWLAYiGTkMOyu8ZZku939aqICKR8L3aeuFtQpvN9
 XqN5yjQ09eoyOAlX4J0E/
X-Google-Smtp-Source: AGHT+IHLaZmPygeN6v9n9c9BtiyIUF0iquuf2sbVrwZcC4ACGBQljJv6ltibauQ9mgDfcKZgCZzEfQ==
X-Received: by 2002:a05:622a:4008:b0:4b3:444d:d831 with SMTP id
 d75a77b69052e-4b3444ddad2mr106371391cf.77.1756923082875; 
 Wed, 03 Sep 2025 11:11:22 -0700 (PDT)
Received: from [10.5.0.2] ([86.48.15.239]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f62aa29sm15248871cf.11.2025.09.03.11.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 11:11:22 -0700 (PDT)
Message-ID: <55baf3e9-a14b-4ece-ab08-71e951f6998b@gmail.com>
Date: Wed, 3 Sep 2025 14:11:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] export/fuse: Add FUSE-over-io_uring for Storage
 Exports
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com,
 bernd@bsbernd.com, fam@euphon.net, hreitz@redhat.com, kwolf@redhat.com
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <CAKWCU7VusNOUskuxc3RMTd+aLY6bSX+de-LiUhe9xpdmbzkn-Q@mail.gmail.com>
 <20250903094907.GA106431@fedora>
From: Brian Song <hibriansong@gmail.com>
In-Reply-To: <20250903094907.GA106431@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=hibriansong@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 9/3/25 5:49 AM, Stefan Hajnoczi wrote:
> On Sat, Aug 30, 2025 at 08:00:00AM -0400, Brian Song wrote:
>> We used fio to test a 1 GB file under both traditional FUSE and
>> FUSE-over-io_uring modes. The experiments were conducted with the
>> following iodepth and numjobs configurations: 1-1, 64-1, 1-4, and 64-4,
>> with 70% read and 30% write, resulting in a total of eight test cases,
>> measuring both latency and throughput.
>>
>> Test results:
>>
>> https://gist.github.com/hibriansong/a4849903387b297516603e83b53bbde4
> 
> Hanna: You benchmarked the FUSE export coroutine implementation a little
> while ago. What do you think about these results with
> FUSE-over-io_uring?
> 
> What stands out to me is that iodepth=1 numjobs=4 already saturates the
> system, so increasing iodepth to 64 does not improve the results much.
> 
> Brian: What is the qemu-storage-daemon command-line for the benchmark
> and what are the details of /mnt/tmp/ (e.g. a preallocated 10 GB file
> with an XFS file system mounted from the FUSE image)?

QMP script:
https://gist.github.com/hibriansong/399f9564a385cfb94db58669e63611f8

Or:
### NORMAL
./qemu/build/storage-daemon/qemu-storage-daemon \
   --object iothread,id=iothread1 \
   --object iothread,id=iothread2 \
   --object iothread,id=iothread3 \
   --object iothread,id=iothread4 \
   --blockdev node-name=prot-node,driver=file,filename=ubuntu.qcow2 \
   --blockdev node-name=fmt-node,driver=qcow2,file=prot-node \
   --export 
type=fuse,id=exp0,node-name=fmt-node,mountpoint=mount-point,writable=on,iothread.0=iothread1,iothread.1=iothread2,iothread.2=iothread3,iothread.3=iothread4

### URING
echo Y > /sys/module/fuse/parameters/enable_uring

./qemu/build/storage-daemon/qemu-storage-daemon \
   --object iothread,id=iothread1 \
   --object iothread,id=iothread2 \
   --object iothread,id=iothread3 \
   --object iothread,id=iothread4 \
   --blockdev node-name=prot-node,driver=file,filename=ubuntu.qcow2 \
   --blockdev node-name=fmt-node,driver=qcow2,file=prot-node \
   --export 
type=fuse,id=exp0,node-name=fmt-node,mountpoint=mount-point,writable=on,io-uring=on,iothread.0=iothread1,iothread.1=iothread2,iothread.2=iothread3,iothread.3=iothread4

ubuntu.qcow2 has been prealloacted and enlarge the space to 100GB by

$ qemu-img resize ubuntu.qcow2 100G
$ virt-customize \
    --run-command '/bin/bash /bin/growpart /dev/sda 1' \
    --run-command 'resize2fs /dev/sda1' -a ubuntu.qcow2

The image file, formatted with an Ext4 filesystem, was mounted on 
/mnt/tmp on my PC equipped with a Kingston PCIe 4.0 NVMe SSD

$ sudo kpartx -av mount-point
$ sudo mount /dev/mapper/loop31p1 /mnt/tmp/


Unmount the partition after done using it.

$ sudo umount /mnt/tmp
# sudo kpartx -dv mount-point

> 
> Thanks,
> Stefan
> 
>>
>>
>>
>>
>> On 8/29/25 10:50 PM, Brian Song wrote:
>>> Hi all,
>>>
>>> This is a GSoC project. More details are available here:
>>> https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_exports
>>>
>>> This patch series includes:
>>> - Add a round-robin mechanism to distribute the kernel-required Ring
>>> Queues to FUSE Queues
>>> - Support multiple in-flight requests (multiple ring entries)
>>> - Add tests for FUSE-over-io_uring
>>>
>>> More detail in the v2 cover letter:
>>> https://lists.nongnu.org/archive/html/qemu-block/2025-08/msg00140.html
>>>
>>> And in the v1 cover letter:
>>> https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00280.html
>>>
>>>
>>> Brian Song (4):
>>>     export/fuse: add opt to enable FUSE-over-io_uring
>>>     export/fuse: process FUSE-over-io_uring requests
>>>     export/fuse: Safe termination for FUSE-uring
>>>     iotests: add tests for FUSE-over-io_uring
>>>
>>>    block/export/fuse.c                  | 838 +++++++++++++++++++++------
>>>    docs/tools/qemu-storage-daemon.rst   |  11 +-
>>>    qapi/block-export.json               |   5 +-
>>>    storage-daemon/qemu-storage-daemon.c |   1 +
>>>    tests/qemu-iotests/check             |   2 +
>>>    tests/qemu-iotests/common.rc         |  45 +-
>>>    util/fdmon-io_uring.c                |   5 +-
>>>    7 files changed, 717 insertions(+), 190 deletions(-)
>>>
>>


