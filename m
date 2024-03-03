Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F542C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 19:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgr75-0006rI-6a; Sun, 03 Mar 2024 14:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rgr70-0006qz-9u
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 14:03:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rgr6x-0005zi-Sp
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 14:03:02 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6B4644E6013;
 Sun,  3 Mar 2024 20:02:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XT7nFKZdULop; Sun,  3 Mar 2024 20:02:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2D6744E6012; Sun,  3 Mar 2024 20:02:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2B6DE7456B4;
 Sun,  3 Mar 2024 20:02:51 +0100 (CET)
Date: Sun, 3 Mar 2024 20:02:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Sven Schnelle <svens@stackframe.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>
Subject: Re: lsi53c895a assert with AmigaOS
In-Reply-To: <f04af11b-b032-3247-1525-2aac132236d3@eik.bme.hu>
Message-ID: <5a33bcb0-caad-ac9a-0239-2983d3d2c838@eik.bme.hu>
References: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu>
 <87y1azv83i.fsf@t14.stackframe.org>
 <f04af11b-b032-3247-1525-2aac132236d3@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 3 Mar 2024, BALATON Zoltan wrote:
> On Sun, 3 Mar 2024, Sven Schnelle wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> 
>>> Hello,
>>> 
>>> AmigaOS4 also has a driver for this card so I've tried to test it but
>>> it trips an assert. Does anybody have an idea why and how it could be
>>> fixed? Sven's recent patches don't seem to have an effect on this, it
>>> still happens shortly after it tries to access the SCSI device with
>>> those patches applied. (Unfortunately AmigaOS is not freely available
>>> so it's a bit hard to reproduce but I can do tests if needed.) I got
>>> the following traces:
>>> 
>>> lsi_reg_write Write reg SIEN0 0x40 = 0x84
>>> lsi_reg_write Write reg SIEN1 0x41 = 0x04
>>> lsi_reg_write Write reg DIEN 0x39 = 0xff
>>> lsi_reg_write Write reg DSP0 0x2c = 0x00
>>> lsi_reg_write Write reg DSP1 0x2d = 0x80
>>> lsi_reg_write Write reg DSP2 0x2e = 0x19
>>> lsi_reg_write Write reg DSP3 0x2f = 0x00
>>> lsi_execute_script SCRIPTS dsp=0x198000 opcode 0x7c07fe00 arg 0x0
>>> lsi_execute_script_io_opcode Read-Modify-Write reg 0x7 AND data8=0xfe 
>>> sfbr=0x01
>>> lsi_reg_read Read reg GPREG 0x7 = 0x7f
>>> lsi_reg_write Write reg GPREG 0x7 = 0x7e
>>> lsi_execute_script SCRIPTS dsp=0x198008 opcode 0x60000200 arg 0x0
>>> lsi_execute_script_io_clear Clear TM
>>> lsi_execute_script SCRIPTS dsp=0x198010 opcode 0x40000000 arg 0x198208
>>> lsi_execute_script_io_alreadyreselected Already reselected, jumping to
>>> alternative address
>> here ---^
>>> lsi_do_msgout_select Select LUN 0
>>> lsi_execute_script SCRIPTS dsp=0x198070 opcode 0x820b0000 arg 0x1981f8
>>> lsi_execute_script_tc_compp Compare phase CMD == CMD
>>> lsi_execute_script_tc_jump Jump to 0x1981f8
>>> lsi_execute_script SCRIPTS dsp=0x1981f8 opcode 0xa000006 arg 0x199000
>>> lsi_do_command Send command len=6
>>> qemu-system-ppc: ../hw/scsi/lsi53c895a.c:863: lsi_do_command: Assertion 
>>> `s->current == NULL' failed.
>>> 
>>> Any idea what could it be and what could be done about it?
>> 
>> Wild guess is that this is because of the 'Already reselected' line
>> above. lsi_reselect() sets s->current, and later when lsi_do_command()
>> is called it gets confused because s->current is already set. But i
>> would need the whole logfile to see why this is going wrong, or even
>> better AmigaOS (which is not free as you already mentioned)
>
> Thanks for looking at this. I've uploaded the full log here: 
> http://zero.eik.bme.hu/~balaton/qemu/aos-lsi-scsi.log.xz
> but not sure you'd get more info from it as it seems to be working up to the 
> error. This happens short after boot when the driver is started which seems 
> to be going OK but when first accessing the device then it runs into the 
> error. I don't know how this controller works so can't really tell what would 
> be correct behaviour here.

AFAIU this log it tries to read a sector which completes on the drive side 
but I can't see where this read finishes and maybe the guest tries to send 
another command while it's still running? The read is here:

lsi_execute_script SCRIPTS dsp=0x1981f8 opcode 0xa00000a arg 0x199000
lsi_do_command Send command len=10
scsi_req_parsed target 0 lun 0 tag 0 command 40 dir 1 length 2048
scsi_req_parsed_lba target 0 lun 0 tag 0 command 40 lba 16
scsi_req_alloc target 0 lun 0 tag 0
scsi_disk_new_request Command: lun=0 tag=0x0 data= 0x28 0x00 0x00 0x00 0x00 0x10 0x00 0x00 0x01 0x00
scsi_disk_dma_command_READ Read (sector 16, count 1)
scsi_req_continue target 0 lun 0 tag 0
scsi_disk_read_data_count Read sector_count=4
lsi_add_msg_byte MSG IN 0x02
lsi_add_msg_byte MSG IN 0x04
lsi_queue_command Queueing tag=0x0
lsi_execute_script SCRIPTS dsp=0x198200 opcode 0x870b0000 arg 0x1980c0
lsi_execute_script_tc_compp Compare phase MSGIN == MSGIN
lsi_execute_script_tc_jump Jump to 0x1980c0
lsi_execute_script SCRIPTS dsp=0x1980c0 opcode 0xf000001 arg 0x199040
lsi_do_msgin Message in len=1 2
lsi_execute_script SCRIPTS dsp=0x1980c8 opcode 0x800c0000 arg 0x198398
lsi_execute_script_tc_compd Compare data 0x2 & 0xff == 0x0
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x1980d0 opcode 0x800c0004 arg 0x198398
lsi_execute_script_tc_compd Compare data 0x2 & 0xff == 0x4
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x1980d8 opcode 0x800c0002 arg 0x198398
lsi_execute_script_tc_compd Compare data 0x2 & 0xff == 0x2
lsi_execute_script_tc_jump Jump to 0x198398
lsi_execute_script SCRIPTS dsp=0x198398 opcode 0x7c027f00 arg 0x0
lsi_execute_script_io_opcode Read-Modify-Write reg 0x2 AND data8=0x7f sfbr=0x02
lsi_reg_read Read reg SCNTL2 0x2 = 0x00
lsi_reg_write Write reg SCNTL2 0x2 = 0x00
lsi_execute_script SCRIPTS dsp=0x1983a0 opcode 0x60000048 arg 0x0
lsi_execute_script_io_clear Clear ATN ACK
lsi_execute_script SCRIPTS dsp=0x1983a8 opcode 0x48000000 arg 0x0
lsi_execute_script_io_disconnect Wait Disconnect
lsi_execute_script SCRIPTS dsp=0x1983b0 opcode 0x7a070100 arg 0x0
lsi_execute_script_io_opcode Read-Modify-Write reg 0x7 OR data8=0x01 sfbr=0x02
lsi_reg_read Read reg GPREG 0x7 = 0x7f
lsi_reg_write Write reg GPREG 0x7 = 0x7f
lsi_execute_script SCRIPTS dsp=0x1983b8 opcode 0x98080000 arg 0x10
lsi_execute_script_tc_interrupt Interrupt 0x10
lsi_script_dma_interrupt DMA Interrupt 0x4 prev 0x0
lsi_update_irq Update IRQ level 1 dstat 0x04 sist 0x000x00
lsi_execute_script_stop SCRIPTS execution stopped
lsi_reg_read Read reg ISTAT 0x14 = 0x01
lsi_update_irq Update IRQ level 0 dstat 0x00 sist 0x000x00
lsi_reg_read Read reg DSTAT 0xc = 0x84
lsi_reg_read Read reg DSPS0 0x30 = 0x10
lsi_reg_read Read reg DSPS1 0x31 = 0x00
lsi_reg_read Read reg DSPS2 0x32 = 0x00
lsi_reg_read Read reg DSPS3 0x33 = 0x00
scsi_disk_read_complete Data ready tag=0x0 len=2048
scsi_req_data target 0 lun 0 tag 0 len 2048
lsi_queue_req Queueing IO tag=0x0

but I don't see if the guest got the results. How should this transfer end 
and why it does not seem to have reached the guest? After this the guest 
seems to send another command:

lsi_do_command Send command len=6
scsi_req_parsed target 0 lun 0 tag 0 command 0 dir 0 length 0
scsi_req_parsed_lba target 0 lun 0 tag 0 command 0 lba 0
scsi_req_alloc target 0 lun 0 tag 0
scsi_disk_new_request Command: lun=0 tag=0x0 data= 0x00 0x00 0x00 0x00 0x00 0x00
scsi_test_unit_ready target 0 lun 0 tag 0
scsi_req_dequeue target 0 lun 0 tag 0
lsi_command_complete Command complete status=0

which then completes;

lsi_execute_script SCRIPTS dsp=0x1983a0 opcode 0x60000048 arg 0x0
lsi_execute_script_io_clear Clear ATN ACK
lsi_execute_script SCRIPTS dsp=0x1983a8 opcode 0x48000000 arg 0x0
lsi_execute_script_io_disconnect Wait Disconnect
lsi_reselect Reselected target 0
lsi_add_msg_byte MSG IN 0x80

and when it tries to send another command it sees the reselected target:

lsi_execute_script SCRIPTS dsp=0x198008 opcode 0x60000200 arg 0x0
lsi_execute_script_io_clear Clear TM
lsi_execute_script SCRIPTS dsp=0x198010 opcode 0x40000000 arg 0x198208
lsi_execute_script_io_alreadyreselected Already reselected, jumping to alternative address

but this does not yet cause an error, it ends here:

lsi_execute_script SCRIPTS dsp=0x1983a0 opcode 0x60000048 arg 0x0
lsi_execute_script_io_clear Clear ATN ACK
lsi_execute_script SCRIPTS dsp=0x1983a8 opcode 0x48000000 arg 0x0
lsi_execute_script_io_disconnect Wait Disconnect

When the next command is sent it starts normally:

lsi_execute_script SCRIPTS dsp=0x198008 opcode 0x60000200 arg 0x0
lsi_execute_script_io_clear Clear TM
lsi_execute_script SCRIPTS dsp=0x198010 opcode 0x40000000 arg 0x198208
lsi_execute_script_io_selected Selected target 0

but when trying to send the command it gets the assertion. I think the 
first read above should somehow be finished which I don't see in this log 
so it may still be queued at this point. Does this make sense to anybody?

Regards,
BALATON Zoltan

