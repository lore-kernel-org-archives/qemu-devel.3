Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF446CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcv1-0008AA-AF; Tue, 13 Oct 2026 09:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xGcus-00089O-RN
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xGcur-00085J-1W
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791899499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C/A92yDbJKT4h8nFEYPH9mqlImj0lEdj9JVsXkPR7YQ=;
 b=JMogC4dfz4UlKT2CRk3ISConWQKb5A+GTAuzTnW2omYxqi4f/UQ66OGmsVHdy8vTqyD66X
 CKSKT13SU3YTRka6xaB7nE4SDwa2PqYHzASvIkxVczi7vyh7vKhs1KGcgUQU0ZyJPpsmKD
 p7+PnEbaXF7n3l2p55z6T9jXArFN3rs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-xph0_3CIPiqGaij9SqeMiA-1; Tue,
 13 Oct 2026 13:51:36 +0000
X-MC-Unique: xph0_3CIPiqGaij9SqeMiA-1
X-Mimecast-MFC-AGG-ID: xph0_3CIPiqGaij9SqeMiA_1791899495
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09DC4195FDFC; Tue, 13 Oct 2026 13:51:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.105])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F1381956086; Tue, 13 Oct 2026 13:51:33 +0000 (UTC)
Date: Tue, 13 Oct 2026 15:51:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Wangyong <wang.yongD@h3c.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: Subject: [Bug] VPD Page 0xb0 Block Limits incorrectly emulated
 in scsi-generic causing guest mkfs.xfs failure
Message-ID: <as43UAp0h7Ym782S@redhat.com>
References: <dbba8bb9a29241c5aaae75b7c4479528@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbba8bb9a29241c5aaae75b7c4479528@h3c.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am 13.10.2026 um 10:32 hat Wangyong geschrieben:
> Hi,
> 
> I'm reporting a bug where VPD Page 0xb0 (Block Limits) is incorrectly
> emulated in QEMU's scsi-generic driver, causing guest VMs to fail
> operations like mkfs.xfs.
> 
> Summary:
> When using QEMU stale-11.0 with scsi-block passthrough, the Optimal
> Transfer Length (and related fields) in VPD Page 0xb0 are incorrectly
> capped to a much smaller value than what the host device reports. This
> is caused by commit 3cb29058 which modified blk_get_max_transfer() to
> no longer check bs->bl.max_hw_transfer, and the scsi-generic code at
> line 194-198 uses this function to compute VPD fields(Optimal Transfer
> Length).

My git repository doesn't contain a commit 3cb29058. Please specify
where you got your copy of the QEMU code from.

> Environment:
> Host: Linux with multipath + LUN
> Guest: Linux VM with QEMU 11.0 scsi-block passthrough
> Host kernel: 6.6.0
> 
> Reproduction Steps:
> Set up a multipath environment with a LUN (physical disk with stripe geometry)
> Pass the LUN through to a QEMU VM using scsi-block:
> -device virtio-scsi-pci,id=scsi0,bus=pci.0,addr=0xa \
> -drive file=/dev/disk/by-id/dm-name-36000d310057df8000000000000000969,format=raw,if=none,id=drive-scsi0-0-0-0,cache=none,aio=native \
> -device scsi-block,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0\
> 
> Inside the VM, run mkfs.xfs /dev/sda
> 
> Expected Behavior:
> mkfs.xfs should succeed
> VPD Page 0xb0 should report Optimal transfer length matching the host's RAID stripe size
> 
> Actual Behavior:
> 1. mkfs.xfs fails inside VM
> SB stripe unit sanity check failed
> Metadata corruption detected at 0x...
> xfx_sb block 0x0/0x1000
> libxfs_bwrite: write verifier failed
> SB stripe unit sanity check failed
> AG 0x0 unlinked bucket sanity check failed
> mkfs.xfs: writing AG headers failed, err=117
> 
> Note: No error in dmesg because XFS failed during in-memory superblock construction, never issuing actual I/O.
> 
> mkfs.xfs -f -d su=0.sw=0 /dev/sda
> 2. VPD comparison between host and guest
> Host (sg_vpd -p 0xb0 /dev/disk/by-id/dm-name-36000d310057df8000000000000000969)
> Block limits VPD page (SBC)
>   Write same non-zero (WSNZ): 0
>   Maximum compare and write length: 0x1
>   Optimal transfer length granularity: 0x1000
>   Maximum transfer length: 0 blocks [not reported]
>   Optimal transfer length: 0x1000
>   Maximum prefetch length: 0 blocks [not reported]
>   Maximum unmap LBA count: 0x200000
>   Maximum unmap block descriptor count: 0x1
>   Optimal unmap granularity: 0x1000
>   Unmap granularity alignment valid: true
>   Unmap granularity alignment: 0x0
>   Maximum write same length: 0 blocks [not reported]
>   Maximum atomic transfer length: 0 blocks [not reported]
>   Atomic alignment: 0 blocks [unaligned atomic writes permitted]
>   Atomic transfer length granularity: 0 blocks [no granularity requirement]
>   Maximum atomic transfer length with atomic boundary: 0 blocks [not reported]
>   Maximum atomic boundary size: 0 blocks [can only write atomic 1 block]
> [root@cvknode151 ~]# ll /dev/disk/by-id/dm-name-36000d310057df8000000000000000969
> lrwxrwxrwx 1 root root 10 Oct 13 15:55 /dev/disk/by-id/dm-name-36000d310057df8000000000000000969 -> ../../dm-1
> [root@cvknode151 ~]# cat /sys/block/dm-1/queue/max_segments
> 64
> Guest (sg_vpd -p 0xb0 /dev/sda):
> Block limits VPD page (SBC):
>   Write same non-zero (WSNZ): 0
>   Maximum compare and write length: 1 blocks
>   Optimal transfer length granularity: 4096 blocks
>   Maximum transfer length: 512 blocks
>   Optimal transfer length: 512 blocks     ← INCORRECT
>   Maximum prefetch transfer length: 0 blocks [ignored]
>   Maximum unmap LBA count: 2097152
>   Maximum unmap block descriptor count: 1
>   Optimal unmap granularity: 4096 blocks
>   Unmap granularity alignment valid: true
>   Unmap granularity alignment: 0
>   Maximum write same length: 0 blocks [not reported]
>   Maximum atomic transfer length: 0 blocks [not reported]
>   Atomic alignment: 0 [unaligned atomic writes permitted]
>   Atomic transfer length granularity: 0 [no granularity requirement
>   Maximum atomic transfer length with atomic boundary: 0 blocks [not reported]
>   Maximum atomic boundary size: 0 blocks [can only write atomic 1 block]
> 
> Restore "opt xfer len" to before modification, mkfs.xfs can pass the test
> 
> @@ -169,15 +169,15 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
>          if (page == 0xb0) {
> +            uint32_t max_transfer_opt = blk_get_max_transfer(s->conf.blk) / s->blocksize;
> 
>              assert(max_transfer);
>              max_transfer = MIN_NON_ZERO(max_transfer, max_iov * qemu_real_host_page_size)
>                  / s->blocksize;
>              stl_be_p(&r->buf[8], max_transfer);
>              /* Also take care of the opt xfer len. */
>              stl_be_p(&r->buf[12],
> -                    MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
> +                    MIN_NON_ZERO(max_transfer_opt, ldl_be_p(&r->buf[12])));
>          } else if (s->needs_vpd_bl_emulation && page == 0x00 && r->buflen >= 4) {
>              /*
>               * Now we're capable of supplying the VPD Block Limits

Code that roughly looked like this existed in QEMU 7.0 and earlier. You
said you're using QEMU 11.0, so it shouldn't exist in your code.

Kevin


