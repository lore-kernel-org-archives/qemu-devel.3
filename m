Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47324C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 03:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u89dR-0000tz-98; Thu, 24 Apr 2025 23:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lma@suse.de>) id 1u89dP-0000sY-G3
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 23:21:51 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lma@suse.de>) id 1u89dN-000800-5W
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 23:21:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B1EE1F38C;
 Fri, 25 Apr 2025 03:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745551304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/k8rxBUj1J7MZ92HswYDCrB06hE67fzx7ZAc8Ch/HM=;
 b=St9uAG+vzY4flIerKFkavo2KZvODal2ihPIZJmVMEc1hxlmrwmROfI7+Ws2Q1a334fMtPc
 6an/rcwc+wLdYqB58tDgVr91wOAAmsC4T3rYgt+W2NCwWU753zxPJO8MrzZv4Gv7uQfbcs
 F+2uXjV0G/D+C4hH/spYUBkgq8OrzoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745551304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/k8rxBUj1J7MZ92HswYDCrB06hE67fzx7ZAc8Ch/HM=;
 b=9BWkqxj6pH+v7wdDx2PSc8KYNLHe9urpdJY+xgFTWtAWf5wHFc+/AUYawCMjH+MtosidSy
 rHaun8U6fLdN08BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745551304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/k8rxBUj1J7MZ92HswYDCrB06hE67fzx7ZAc8Ch/HM=;
 b=St9uAG+vzY4flIerKFkavo2KZvODal2ihPIZJmVMEc1hxlmrwmROfI7+Ws2Q1a334fMtPc
 6an/rcwc+wLdYqB58tDgVr91wOAAmsC4T3rYgt+W2NCwWU753zxPJO8MrzZv4Gv7uQfbcs
 F+2uXjV0G/D+C4hH/spYUBkgq8OrzoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745551304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/k8rxBUj1J7MZ92HswYDCrB06hE67fzx7ZAc8Ch/HM=;
 b=9BWkqxj6pH+v7wdDx2PSc8KYNLHe9urpdJY+xgFTWtAWf5wHFc+/AUYawCMjH+MtosidSy
 rHaun8U6fLdN08BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EF7913A79;
 Fri, 25 Apr 2025 03:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qiawGsj/Cmg0NgAAD6G6ig
 (envelope-from <lma@suse.de>); Fri, 25 Apr 2025 03:21:44 +0000
MIME-Version: 1.0
Date: Fri, 25 Apr 2025 11:21:44 +0800
From: lma <lma@suse.de>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: A question about how to calculate the "Maximum transfer length"
 in case of its absence in the Block Limits VPD device response from the
 hardware
In-Reply-To: <20250424145151.GA399725@fedora>
References: <20db3af2ece22f598b54a47ec350b466@suse.de>
 <20250418153456.GA128796@fedora> <81accb5693785748c476bf34eb18a0ba@suse.de>
 <20250423132405.GA333580@fedora> <32c2072d6fc017786f4d6ef0dd681ae7@suse.de>
 <20250424145151.GA399725@fedora>
User-Agent: Roundcube Webmail
Message-ID: <a5a0c5a701e40adbd763578af95e3ac5@suse.de>
X-Sender: lma@suse.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=lma@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

在 2025-04-24 22:51，Stefan Hajnoczi 写道：
> On Wed, Apr 23, 2025 at 10:07:48PM +0800, lma wrote:
>> 在 2025-04-23 21:24，Stefan Hajnoczi 写道：
>> > On Wed, Apr 23, 2025 at 05:47:44PM +0800, lma wrote:
>> > > 在 2025-04-18 23:34，Stefan Hajnoczi 写道：
>> > > > On Thu, Apr 17, 2025 at 07:27:26PM +0800, lma wrote:
>> > > > > Hi all,
>> > > > >
>> > > > > In case of SCSI passthrough, If the Block Limits VPD device response
>> > > > > is
>> > > > > absent from hardware, QEMU handles it.
>> > > > >
>> > > > > There are several variables involved in this process as follows:
>> > > > > * The bl.max_transfer
>> > > > > * The bl.max_iov that is associated with IOV_MAX.
>> > > > > * The bl.max_hw_iov that is associated with the max_segments sysfs
>> > > > > setting
>> > > > > for the relevant block device on the host.
>> > > > > * The bl.max_hw_transfer that is associated with the BLKSECTGET
>> > > > > ioctl, in
>> > > > > other words related to the current max_sectors_kb sysfs setting of the
>> > > > > relevant block device on the host.
>> > > > >
>> > > > > Then take the smallest value and return it as the result of "Maximum
>> > > > > transfer length" after relevant calculation, See:
>> > > > > static uint64_t calculate_max_transfer(SCSIDevice *s)
>> > > > > {
>> > > > >     uint64_t max_transfer = blk_get_max_hw_transfer(s->conf.blk);
>> > > > >     uint32_t max_iov = blk_get_max_hw_iov(s->conf.blk);
>> > > > >
>> > > > >     assert(max_transfer);
>> > > > >     max_transfer = MIN_NON_ZERO(max_transfer,
>> > > > >                                 max_iov * qemu_real_host_page_size());
>> > > > >
>> > > > >     return max_transfer / s->blocksize;
>> > > > > }
>> > > > >
>> > > > >
>> > > > > However, due to the limitation of IOV_MAX, no matter how powerful
>> > > > > the host
>> > > > > scsi hardware is, the "Maximum transfer length" that qemu emulates
>> > > > > in bl vpd
>> > > > > page is capped at 8192 sectors in case of 4kb page size and 512 bytes
>> > > > > logical block size.
>> > > > > For example：
>> > > > > host:~ # sg_vpd -p bl /dev/sda
>> > > > > Block limits VPD page (SBC)
>> > > > >   ......
>> > > > >   Maximum transfer length: 0 blocks [not reported]
>> > > > >   ......
>> > > > >
>> > > > >
>> > > > > host:~ # cat /sys/class/block/sda/queue/max_sectors_kb
>> > > > > 16384
>> > > > >
>> > > > > host:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
>> > > > > 32767
>> > > > >
>> > > > > host:~ # cat /sys/class/block/sda/queue/max_segments
>> > > > > 4096
>> > > > >
>> > > > >
>> > > > > Expected:
>> > > > > guest:~ # sg_vpd -p bl /dev/sda
>> > > > > Block limits VPD page (SBC)
>> > > > >   ......
>> > > > >   Maximum transfer length: 0x8000
>> > > > >   ......
>> > > > >
>> > > > > guest:~ # cat /sys/class/block/sda/queue/max_sectors_kb
>> > > > > 16384
>> > > > >
>> > > > > guest:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
>> > > > > 32767
>> > > > >
>> > > > >
>> > > > > Actual:
>> > > > > guest:~ # sg_vpd -p bl /dev/sda
>> > > > > Block limits VPD page (SBC)
>> > > > >   ......
>> > > > >   Maximum transfer length: 0x2000
>> > > > >   ......
>> > > > >
>> > > > > guest:~ # cat /sys/class/block/sda/queue/max_sectors_kb
>> > > > > 4096
>> > > > >
>> > > > > guest:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
>> > > > > 32767
>> > > > >
>> > > > >
>> > > > > It seems the current design logic is not able to fully utilize the
>> > > > > performance of the scsi hardware. I have two questions:
>> > > > > 1. I'm curious that is it reasonable to drop the logic about IOV_MAX
>> > > > > limitation, directly use the return value of BLKSECTGET as the maximum
>> > > > > transfer length when QEMU emulates the block limit page of scsi vpd?
>> > > > >    If we doing so, we will have maximum transfer length in the guest
>> > > > > that is
>> > > > > consistent with the capabilities of the host hardware。
>> > > > >
>> > > > > 2. Besides, Assume I set a value(eg: 8192 in kb) to max_sectors_kb
>> > > > > in guest
>> > > > > which doesn't exceed the capabilities of the host hardware(eg: 16384
>> > > > > in kb)
>> > > > > but exceeds the limit(eg: 4096 in kb) caused by IOV_MAX,
>> > > > >    Any risks in readv()/writev() of raw-posix?
>> > > >
>> > > > Not a definitive answer, but just something to encourage discussion:
>> > > >
>> > > > In theory IOV_MAX should not be factored into the Block Limits VPD page
>> > > > Maximum Transfer Length field because there is already a HBA limit on
>> > > > the maximum number of segments. For example, virtio-scsi has a seg_max
>> > > > Configuration Space field that guest drivers honor independently of
>> > > > Maximum Transfer Length.
>> > > >
>> > > > However, I can imagine why MAX_IOV needs to be factored in:
>> > > >
>> > > > 1. The maximum number of segments might be hardcoded in guest drivers
>> > > >    for some SCSI HBAs and QEMU has no way of exposing MAX_IOV to the
>> > > >    guest in that case.
>> > > >
>> > > > 2. Guest physical RAM addresses translate to host virtual memory. That
>> > > >    means 1 segment as seen by the guest might actually require multiple
>> > > >    physical DMA segments on the host. A conservative calculation that
>> > > >    assumes the worst-case 1 iovec per 4 KB memory page prevents the
>> > > >    host maximum segments limit (note this is not the Maximum Transfer
>> > > >    Length limit!) from being exceeded.
>> > > >
>> > > > So there seem to be at least two problems here. If you relax the
>> > > > calculation there will be corner cases that break because the guest can
>> > > > send too many segments.
>> > > >
>> > > > Stefan
>> > >
>> > > The maximum allowed value for
>> > > /sys/class/block/<GUEST_DEV>/queue/max_sectors_kb in guest os depends
>> > > on the smaller of below two items in guest os:
>> > > the "maximum transfer length of block limits VPD page"
>> > > and
>> > > the "/sys/class/block/<GUEST_DEV>/queue/max_hw_sectors_kb".
>> > >
>> > >
>> > > The "seg_max Configuration Space field" in hw/scsi/virtio-scsi.c:
>> > > static const Property virtio_scsi_properties[] = {
>> > >     ...
>> > >     DEFINE_PROP_UINT32("max_sectors", VirtIOSCSI,
>> > > parent_obj.conf.max_sectors,
>> > >                                                   0xFFFF),
>> > >     ...
>> > > };
>> > >
>> > > This field determines the value of max_hw_sectors_kb in sysfs in guest
>> > > os, Eg: In case of Logical block size 512 bytes, 0xFFFF sectors means:
>> > > max_hw_sectors_kb = 0xFFFF/2 = 32767, I believe many users will keep
>> > > this default value when using virtio-scsi, rather than customizing it.
>> > >
>> > > But by the current design and affected by IOV_MAX, the upper limit of
>> > > /sys/class/block/<GUEST_DEV>/queue/max_sectors_kb is 4096 for SCSI
>> > > passthrough scenario in case of 4kb page size and 512 bytes logical
>> > > block size. Therefore, the gap between the upper limit of
>> > > max_sectors_kb
>> > > and the max_hw_sectors_kb is very large.
>> > >
>> > > I think this design logic is a bit strange.
>> >
>> > Unless you can think of a different correct way to report block limits
>> > for scsi-generic devices, then I think we're stuck with the sub-optimal
>> > conservative value.
>> >
>> > By the way, scsi-disk.c's scsi-block and scsi-hd devices are less
>> > restrictive because the host is able to split requests. Splitting is not
>> > possible for SCSI passthrough requests since they could be
>> > vendor-specific requests and the host does not have enough information
>> > to split them.
>> >
>> > Can you use -device scsi-block instead of -device scsi-generic? That
>> > would solve this problem.
>> 
>> Well, unfortunately, that's exactly where I ran into the problem with
>> the restriction‌ on maximum transfer length with the scsi-block, I've
>> never used the scsi-generic.
>> Eg:
>> ......
>> -device
>> '{"driver":"virtio-scsi-pci","id":"scsi0","bus":"pci.7","addr":"0x0"}' 
>> \
>> -blockdev '{"driver":"host_device","filename":"/dev/sda","node-name":\
>> "libvirt-2-storage","read-only":false}' \
>> -device
>> '{"driver":"scsi-block","bus":"scsi0.0","channel":0,"scsi-id":0,"lun":0,\
>> "drive":"libvirt-2-storage","id":"scsi0-0-0-0"}' \
>> ......
> 
> Ah, scsi-blk uses scsi_generic_req_ops for INQUIRY commands.
> 
> It comes down to whether scsi-block handles all commands that transfer
> logical blocks (READ/WRITE/etc) without issuing the SG_IO ioctl, then
> it's safe to increase the Optimal and Maximum Transfer Length fields to
> the same value as scsi-disk.
> 
> It's possible that a vendor-specific command transfers logical blocks
> and honors Maximum Transfer Length, so then it would not be safe to 
> make
> this change. But I'm not sure...

Okay, Let's see if there's more discussion or comments involved.

Thanks for your input and time!
Lin

