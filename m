Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5014FC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 11:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5NPA-0000Z8-6Q; Thu, 17 Apr 2025 07:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lma@suse.de>) id 1u5NP3-0000Xo-KY
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:27:33 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lma@suse.de>) id 1u5NP1-0001MN-Ey
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 07:27:33 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DDFB210EF;
 Thu, 17 Apr 2025 11:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744889246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7/bERUS4SNR3lEwxdvbVcVGq7EGLXbYsrobVjHcbBmc=;
 b=BzhfJURWyYFL8aChP4b/qQTbwzmmFaYTZz1h/SfKJGkMQWO6LNkPuTJem8Gfpj9dAktb6O
 c1QsQrjJ3Cm23o5DtLArOmNeob+WsYCXafH0j2g/cki782Jss7E6XCUl3qB5MmJ0KaXXTp
 xgxF3Zb5xd3HQZy9LO5aDGaTi0bI1L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744889246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7/bERUS4SNR3lEwxdvbVcVGq7EGLXbYsrobVjHcbBmc=;
 b=8//JY3uhWT2HmYmz+bD1gv+Z03j7iXQ/dtHo5Ef0xRym5uvAApDJEcbyG+0sdI+KbI9r6g
 G3aQSs75wnOiD/Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BzhfJURW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8//JY3uh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744889246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7/bERUS4SNR3lEwxdvbVcVGq7EGLXbYsrobVjHcbBmc=;
 b=BzhfJURWyYFL8aChP4b/qQTbwzmmFaYTZz1h/SfKJGkMQWO6LNkPuTJem8Gfpj9dAktb6O
 c1QsQrjJ3Cm23o5DtLArOmNeob+WsYCXafH0j2g/cki782Jss7E6XCUl3qB5MmJ0KaXXTp
 xgxF3Zb5xd3HQZy9LO5aDGaTi0bI1L4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744889246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7/bERUS4SNR3lEwxdvbVcVGq7EGLXbYsrobVjHcbBmc=;
 b=8//JY3uhWT2HmYmz+bD1gv+Z03j7iXQ/dtHo5Ef0xRym5uvAApDJEcbyG+0sdI+KbI9r6g
 G3aQSs75wnOiD/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4700C1388F;
 Thu, 17 Apr 2025 11:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7rE+EZ7lAGg4HAAAD6G6ig
 (envelope-from <lma@suse.de>); Thu, 17 Apr 2025 11:27:26 +0000
MIME-Version: 1.0
Date: Thu, 17 Apr 2025 19:27:26 +0800
From: lma <lma@suse.de>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, stefanha@redhat.com
Subject: A question about how to calculate the "Maximum transfer length" in
 case of its absence in the Block Limits VPD device response from the hardware
User-Agent: Roundcube Webmail
Message-ID: <20db3af2ece22f598b54a47ec350b466@suse.de>
X-Sender: lma@suse.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4DDFB210EF
X-Spamd-Result: default: False [-4.49 / 50.00]; BAYES_HAM(-2.99)[99.95%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; XM_UA_NO_VERSION(0.01)[];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=lma@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi all,

In case of SCSI passthrough, If the Block Limits VPD device response is 
absent from hardware, QEMU handles it.

There are several variables involved in this process as follows:
* The bl.max_transfer
* The bl.max_iov that is associated with IOV_MAX.
* The bl.max_hw_iov that is associated with the max_segments sysfs 
setting for the relevant block device on the host.
* The bl.max_hw_transfer that is associated with the BLKSECTGET ioctl, 
in other words related to the current max_sectors_kb sysfs setting of 
the relevant block device on the host.

Then take the smallest value and return it as the result of "Maximum 
transfer length" after relevant calculation, See:
static uint64_t calculate_max_transfer(SCSIDevice *s)
{
     uint64_t max_transfer = blk_get_max_hw_transfer(s->conf.blk);
     uint32_t max_iov = blk_get_max_hw_iov(s->conf.blk);

     assert(max_transfer);
     max_transfer = MIN_NON_ZERO(max_transfer,
                                 max_iov * qemu_real_host_page_size());

     return max_transfer / s->blocksize;
}


However, due to the limitation of IOV_MAX, no matter how powerful the 
host scsi hardware is, the "Maximum transfer length" that qemu emulates 
in bl vpd page is capped at 8192 sectors in case of 4kb page size and 
512 bytes logical block size.
For example：
host:~ # sg_vpd -p bl /dev/sda
Block limits VPD page (SBC)
   ......
   Maximum transfer length: 0 blocks [not reported]
   ......


host:~ # cat /sys/class/block/sda/queue/max_sectors_kb
16384

host:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
32767

host:~ # cat /sys/class/block/sda/queue/max_segments
4096


Expected:
guest:~ # sg_vpd -p bl /dev/sda
Block limits VPD page (SBC)
   ......
   Maximum transfer length: 0x8000
   ......

guest:~ # cat /sys/class/block/sda/queue/max_sectors_kb
16384

guest:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
32767


Actual:
guest:~ # sg_vpd -p bl /dev/sda
Block limits VPD page (SBC)
   ......
   Maximum transfer length: 0x2000
   ......

guest:~ # cat /sys/class/block/sda/queue/max_sectors_kb
4096

guest:~ # cat /sys/class/block/sda/queue/max_hw_sectors_kb
32767


It seems the current design logic is not able to fully utilize the 
performance of the scsi hardware. I have two questions:
1. I'm curious that is it reasonable to drop the logic about IOV_MAX 
limitation, directly use the return value of BLKSECTGET as the maximum 
transfer length when QEMU emulates the block limit page of scsi vpd?
    If we doing so, we will have maximum transfer length in the guest 
that is consistent with the capabilities of the host hardware。

2. Besides, Assume I set a value(eg: 8192 in kb) to max_sectors_kb in 
guest which doesn't exceed the capabilities of the host hardware(eg: 
16384 in kb) but exceeds the limit(eg: 4096 in kb) caused by IOV_MAX,
    Any risks in readv()/writev() of raw-posix?

Lin

