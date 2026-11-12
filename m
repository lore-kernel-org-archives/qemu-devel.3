Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14258606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXGL-00055N-Jr; Thu, 12 Nov 2026 11:02:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xRXGJ-00054z-85; Thu, 12 Nov 2026 11:02:55 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xRXGH-0008VP-8j; Thu, 12 Nov 2026 11:02:54 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1BB6B466F7;
 Thu, 12 Nov 2026 17:02:41 +0100 (CET)
Message-ID: <81fde20a-d822-493d-825b-a99cc970ab71@proxmox.com>
Date: Thu, 12 Nov 2026 17:02:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] scsi-disk: fix UNMAP and WRITE SAME racing with
 inactivation
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-stable@nongnu.org
References: <20261026174220.674460-1-den@openvz.org>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20261026174220.674460-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794499360216
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Denis,

Am 26.10.26 um 7:09 PM schrieb Denis V. Lunev:
> scsi-disk splits UNMAP into one discard per descriptor and a non-zero
> WRITE SAME into 512 KiB writes, submitting each step from the
> completion callback of the previous one. A drain in between only waits
> for the step in flight; the next one is queued by
> blk_wait_while_drained() and resumed by drain_end. When the drain is
> the one in bdrv_inactivate_all() (end of live migration,
> blockdev-set-active), the resumed request hits an inactive node:
> 
>   bdrv_co_write_req_prepare: Assertion
>   `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
> 
> We hit this in production on a guest UNMAP with 38 descriptors.
thank you for tackling the issue! Unfortunately, I was still able to run
into a crash with your series applied on top of v11.2.0-rc0:

> Thread 12 "qemu-system-x86" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7e5ff390f6c0 (LWP 382537)]
> __GI_abort () at ./stdlib/abort.c:95
> warning: 95	./stdlib/abort.c: No such file or directory
> (gdb) bt
> #0  __GI_abort () at ./stdlib/abort.c:95
> #1  0x00007e5ff7ef7420 in __assert_fail_base (fmt=<optimized out>, assertion=<optimized out>, file=<optimized out>, line=2000, 
>     function=<optimized out>) at ./assert/assert.c:118
> #2  0x000064d2985a7d47 in bdrv_co_write_req_prepare (child=0x64d2b3419550, offset=0, bytes=512, req=0x7e5e468ebdd8, flags=0)
>     at ../block/io.c:2000
> #3  0x000064d2985a786b in bdrv_co_pdiscard (child=0x64d2b3419550, offset=0, bytes=512) at ../block/io.c:3217
> #4  0x000064d29858ee94 in blk_co_do_pdiscard (blk=0x64d2b3419050, offset=0, bytes=512, flags=BDRV_REQ_NO_QUEUE)
>     at ../block/block-backend.c:1821
> #5  0x000064d29858eded in blk_co_pdiscard (blk=0x64d2b3419050, offset=0, bytes=512, flags=BDRV_REQ_NO_QUEUE)
>     at ../block/block-backend.c:1849
> #6  0x000064d29817105b in scsi_unmap_co (iocb=0x7e5fe0001c90) at ../hw/scsi/scsi-disk.c:1873
> #7  0x000064d2981712aa in scsi_disk_co_aio_entry (opaque=0x7e5fe0001c90) at ../hw/scsi/scsi-disk.c:1797
> #8  0x000064d298785586 in coroutine_trampoline (i0=-1308221744, i1=25810) at ../util/coroutine-ucontext.c:175
> #9  0x00007e5ff7f27810 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #10 0x00007ffd671cda00 in ?? ()
> #11 0x0000000000000000 in ?? ()

I issued an UNMAP with 4095 descriptors, all discarding the first
sector, via sg_raw in the guest and then sent 'blockdev-set-active' to
deactivate via QMP.

The device is

>   -device 'scsi-hd,bus=virtioscsi1.0,channel=0,scsi-id=0,lun=1,drive=drive-scsi1,id=scsi1,device_id=drive-scsi1,write-cache=on'
and the blockdev

> {
>   "detect-zeroes": "unmap",
>   "discard": "unmap",
>   "driver": "throttle",
>   "file": {
>     "cache": {
>       "direct": true,
>       "no-flush": false
>     },
>     "detect-zeroes": "unmap",
>     "discard": "unmap",
>     "driver": "qcow2",
>     "file": {
>       "aio": "io_uring",
>       "cache": {
>         "direct": true,
>         "no-flush": false
>       },
>       "detect-zeroes": "unmap",
>       "discard": "unmap",
>       "driver": "file",
>       "filename": "/mnt/pve/nfs/images/100/vm-100-disk-1.qcow2",
>       "node-name": "ef0f65238260b2e5517e288d10debc8",
>       "read-only": false
>     },
>     "node-name": "ff0f65238260b2e5517e288d10debc8",
>     "read-only": false
>   },
>   "node-name": "drive-scsi1",
>   "read-only": false,
>   "throttle-group": "throttle-drive-scsi1"
> }

Best Regards,
Fiona


