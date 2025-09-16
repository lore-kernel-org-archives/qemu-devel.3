Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6190CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 12:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyUeW-0002Zg-5J; Tue, 16 Sep 2025 08:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uyUeP-0002YP-9S
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uyUeE-0007qn-Mk
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 08:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758025135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8agAw4R/c1//1OybqqcSPSYSS/XQxmMpepIm72DGTCY=;
 b=R2MZVTtJaUBegBjcRmB9RjFj07K63bCPykq4TYrKKzEzUPweikMEdtMpw8ti413+CABefG
 nJjfNiOasOwouYVF/ESRKcK23jqQAw/AcCBrt1/6/b2wMiEdvROc8dGlb2bm8bX/MwCg25
 FZoV4PQI78dskYHdsRLlHEZEFgeKdd8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-may4DTHTNdeVRVpKLmQZCA-1; Tue,
 16 Sep 2025 08:18:52 -0400
X-MC-Unique: may4DTHTNdeVRVpKLmQZCA-1
X-Mimecast-MFC-AGG-ID: may4DTHTNdeVRVpKLmQZCA_1758025131
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1E401800366; Tue, 16 Sep 2025 12:18:50 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.124])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ECFA1800452; Tue, 16 Sep 2025 12:18:46 +0000 (UTC)
Date: Tue, 16 Sep 2025 14:18:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, bernd@bsbernd.com,
 fam@euphon.net, hreitz@redhat.com
Subject: Re: [PATCH 0/4] export/fuse: Add FUSE-over-io_uring for Storage
 Exports
Message-ID: <aMlVoaC6wPjPgPII@redhat.com>
References: <20250830025025.3610-1-hibriansong@gmail.com>
 <CAKWCU7VusNOUskuxc3RMTd+aLY6bSX+de-LiUhe9xpdmbzkn-Q@mail.gmail.com>
 <20250903094907.GA106431@fedora>
 <55baf3e9-a14b-4ece-ab08-71e951f6998b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55baf3e9-a14b-4ece-ab08-71e951f6998b@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 03.09.2025 um 20:11 hat Brian Song geschrieben:
> 
> 
> On 9/3/25 5:49 AM, Stefan Hajnoczi wrote:
> > On Sat, Aug 30, 2025 at 08:00:00AM -0400, Brian Song wrote:
> > > We used fio to test a 1 GB file under both traditional FUSE and
> > > FUSE-over-io_uring modes. The experiments were conducted with the
> > > following iodepth and numjobs configurations: 1-1, 64-1, 1-4, and 64-4,
> > > with 70% read and 30% write, resulting in a total of eight test cases,
> > > measuring both latency and throughput.
> > > 
> > > Test results:
> > > 
> > > https://gist.github.com/hibriansong/a4849903387b297516603e83b53bbde4
> > 
> > Hanna: You benchmarked the FUSE export coroutine implementation a little
> > while ago. What do you think about these results with
> > FUSE-over-io_uring?
> > 
> > What stands out to me is that iodepth=1 numjobs=4 already saturates the
> > system, so increasing iodepth to 64 does not improve the results much.
> > 
> > Brian: What is the qemu-storage-daemon command-line for the benchmark
> > and what are the details of /mnt/tmp/ (e.g. a preallocated 10 GB file
> > with an XFS file system mounted from the FUSE image)?
> 
> QMP script:
> https://gist.github.com/hibriansong/399f9564a385cfb94db58669e63611f8
> 
> Or:
> ### NORMAL
> ./qemu/build/storage-daemon/qemu-storage-daemon \
>   --object iothread,id=iothread1 \
>   --object iothread,id=iothread2 \
>   --object iothread,id=iothread3 \
>   --object iothread,id=iothread4 \
>   --blockdev node-name=prot-node,driver=file,filename=ubuntu.qcow2 \

This uses the default AIO and most importantly cache mode, which means
that the host kernel page cache is used. This makes it hard to tell how
much it accessed just RAM on the host and how much really went to the
disk, so the results are difficult to interpret correctly.

For benchmarks, it's generally best to use cache.direct=on and I think
I'd also prefer aio=native (or aio=io_uring).

>   --blockdev node-name=fmt-node,driver=qcow2,file=prot-node \
>   --export type=fuse,id=exp0,node-name=fmt-node,mountpoint=mount-point,writable=on,iothread.0=iothread1,iothread.1=iothread2,iothread.2=iothread3,iothread.3=iothread4
> 
> ### URING
> echo Y > /sys/module/fuse/parameters/enable_uring
> 
> ./qemu/build/storage-daemon/qemu-storage-daemon \
>   --object iothread,id=iothread1 \
>   --object iothread,id=iothread2 \
>   --object iothread,id=iothread3 \
>   --object iothread,id=iothread4 \
>   --blockdev node-name=prot-node,driver=file,filename=ubuntu.qcow2 \
>   --blockdev node-name=fmt-node,driver=qcow2,file=prot-node \
>   --export type=fuse,id=exp0,node-name=fmt-node,mountpoint=mount-point,writable=on,io-uring=on,iothread.0=iothread1,iothread.1=iothread2,iothread.2=iothread3,iothread.3=iothread4
> 
> ubuntu.qcow2 has been prealloacted and enlarge the space to 100GB by
> 
> $ qemu-img resize ubuntu.qcow2 100G

I think this doesn't preallocate the newly added space, you should add
--preallocation=falloc at least.

> $ virt-customize \
>    --run-command '/bin/bash /bin/growpart /dev/sda 1' \
>    --run-command 'resize2fs /dev/sda1' -a ubuntu.qcow2
> 
> The image file, formatted with an Ext4 filesystem, was mounted on /mnt/tmp
> on my PC equipped with a Kingston PCIe 4.0 NVMe SSD
> 
> $ sudo kpartx -av mount-point
> $ sudo mount /dev/mapper/loop31p1 /mnt/tmp/
> 
> 
> Unmount the partition after done using it.
> 
> $ sudo umount /mnt/tmp
> # sudo kpartx -dv mount-point

What I would personally use to benchmark performance is just a clean
preallocated raw image without a guest on it. I wouldn't even partition
it or necessarily put a filesystem on it, but just run the benchmark
directly on the FUSE export's mountpoint.

The other thing I'd consider for benchmarking is the null-co block
driver so that the FUSE overhead really dominates and isn't dwarved by a
slow disk. (A null block device is where you can't have a filesystem
even if you wanted.)

Kevin

> > > On 8/29/25 10:50 PM, Brian Song wrote:
> > > > Hi all,
> > > > 
> > > > This is a GSoC project. More details are available here:
> > > > https://wiki.qemu.org/Google_Summer_of_Code_2025#FUSE-over-io_uring_exports
> > > > 
> > > > This patch series includes:
> > > > - Add a round-robin mechanism to distribute the kernel-required Ring
> > > > Queues to FUSE Queues
> > > > - Support multiple in-flight requests (multiple ring entries)
> > > > - Add tests for FUSE-over-io_uring
> > > > 
> > > > More detail in the v2 cover letter:
> > > > https://lists.nongnu.org/archive/html/qemu-block/2025-08/msg00140.html
> > > > 
> > > > And in the v1 cover letter:
> > > > https://lists.nongnu.org/archive/html/qemu-block/2025-07/msg00280.html
> > > > 
> > > > 
> > > > Brian Song (4):
> > > >     export/fuse: add opt to enable FUSE-over-io_uring
> > > >     export/fuse: process FUSE-over-io_uring requests
> > > >     export/fuse: Safe termination for FUSE-uring
> > > >     iotests: add tests for FUSE-over-io_uring
> > > > 
> > > >    block/export/fuse.c                  | 838 +++++++++++++++++++++------
> > > >    docs/tools/qemu-storage-daemon.rst   |  11 +-
> > > >    qapi/block-export.json               |   5 +-
> > > >    storage-daemon/qemu-storage-daemon.c |   1 +
> > > >    tests/qemu-iotests/check             |   2 +
> > > >    tests/qemu-iotests/common.rc         |  45 +-
> > > >    util/fdmon-io_uring.c                |   5 +-
> > > >    7 files changed, 717 insertions(+), 190 deletions(-)
> > > > 
> > > 
> 


