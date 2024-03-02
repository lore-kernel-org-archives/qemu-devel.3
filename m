Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266FFC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 22:58:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgYJH-0001zN-T8; Sat, 02 Mar 2024 17:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rgYJF-0001yw-OO
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:58:25 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rgYJD-0002bX-1j
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 17:58:25 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6E5A84E6013;
 Sat,  2 Mar 2024 23:58:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GJzOzbOAUA5T; Sat,  2 Mar 2024 23:58:17 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8064D4E6012; Sat,  2 Mar 2024 23:58:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F2DC7456B4;
 Sat,  2 Mar 2024 23:58:17 +0100 (CET)
Date: Sat, 2 Mar 2024 23:58:17 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Sven Schnelle <svens@stackframe.org>
Subject: lsi53c895a assert with AmigaOS
Message-ID: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

Hello,

AmigaOS4 also has a driver for this card so I've tried to test it but it 
trips an assert. Does anybody have an idea why and how it could be fixed? 
Sven's recent patches don't seem to have an effect on this, it still 
happens shortly after it tries to access the SCSI device with those 
patches applied. (Unfortunately AmigaOS is not freely available so it's a 
bit hard to reproduce but I can do tests if needed.) I got the following 
traces:

lsi_reg_write Write reg SIEN0 0x40 = 0x84
lsi_reg_write Write reg SIEN1 0x41 = 0x04
lsi_reg_write Write reg DIEN 0x39 = 0xff
lsi_reg_write Write reg DSP0 0x2c = 0x00
lsi_reg_write Write reg DSP1 0x2d = 0x80
lsi_reg_write Write reg DSP2 0x2e = 0x19
lsi_reg_write Write reg DSP3 0x2f = 0x00
lsi_execute_script SCRIPTS dsp=0x198000 opcode 0x7c07fe00 arg 0x0
lsi_execute_script_io_opcode Read-Modify-Write reg 0x7 AND data8=0xfe sfbr=0x01
lsi_reg_read Read reg GPREG 0x7 = 0x7f
lsi_reg_write Write reg GPREG 0x7 = 0x7e
lsi_execute_script SCRIPTS dsp=0x198008 opcode 0x60000200 arg 0x0
lsi_execute_script_io_clear Clear TM
lsi_execute_script SCRIPTS dsp=0x198010 opcode 0x40000000 arg 0x198208
lsi_execute_script_io_alreadyreselected Already reselected, jumping to alternative address
lsi_execute_script SCRIPTS dsp=0x198208 opcode 0x800a0000 arg 0x1982e0
lsi_execute_script_tc_compp Compare phase MSGIN == DOUT
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198210 opcode 0x810a0000 arg 0x198280
lsi_execute_script_tc_compp Compare phase MSGIN == DIN
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198218 opcode 0x830a0000 arg 0x198340
lsi_execute_script_tc_compp Compare phase MSGIN == STATUS
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198220 opcode 0x820a0000 arg 0x1981f8
lsi_execute_script_tc_compp Compare phase MSGIN == CMD
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198228 opcode 0x860a0000 arg 0x198060
lsi_execute_script_tc_compp Compare phase MSGIN == MSGOUT
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198230 opcode 0x870a0000 arg 0x1980c0
lsi_execute_script_tc_compp Compare phase MSGIN == MSGIN
lsi_execute_script_tc_jump Jump to 0x1980c0
lsi_execute_script SCRIPTS dsp=0x1980c0 opcode 0xf000001 arg 0x199040
lsi_do_msgin Message in len=1 2
lsi_execute_script SCRIPTS dsp=0x1980c8 opcode 0x800c0000 arg 0x198398
lsi_execute_script_tc_compd Compare data 0x0 & 0xff == 0x0
lsi_execute_script_tc_jump Jump to 0x198398
lsi_execute_script SCRIPTS dsp=0x198398 opcode 0x7c027f00 arg 0x0
lsi_execute_script_io_opcode Read-Modify-Write reg 0x2 AND data8=0x7f sfbr=0x00
lsi_reg_read Read reg SCNTL2 0x2 = 0x00
lsi_reg_write Write reg SCNTL2 0x2 = 0x00
lsi_execute_script SCRIPTS dsp=0x1983a0 opcode 0x60000048 arg 0x0
lsi_execute_script_io_clear Clear ATN ACK
lsi_execute_script SCRIPTS dsp=0x1983a8 opcode 0x48000000 arg 0x0
lsi_execute_script_io_disconnect Wait Disconnect
lsi_execute_script SCRIPTS dsp=0x1983b0 opcode 0x7a070100 arg 0x0
lsi_execute_script_io_opcode Read-Modify-Write reg 0x7 OR data8=0x01 sfbr=0x00
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
lsi_reg_write Write reg SIEN0 0x40 = 0x84
lsi_reg_write Write reg SIEN1 0x41 = 0x04
lsi_reg_write Write reg DIEN 0x39 = 0xff
lsi_reg_write Write reg DSP0 0x2c = 0x00
lsi_reg_write Write reg DSP1 0x2d = 0x80
lsi_reg_write Write reg DSP2 0x2e = 0x19
lsi_reg_write Write reg DSP3 0x2f = 0x00
lsi_execute_script SCRIPTS dsp=0x198000 opcode 0x7c07fe00 arg 0x0
lsi_execute_script_io_opcode Read-Modify-Write reg 0x7 AND data8=0xfe sfbr=0x00
lsi_reg_read Read reg GPREG 0x7 = 0x7f
lsi_reg_write Write reg GPREG 0x7 = 0x7e
lsi_execute_script SCRIPTS dsp=0x198008 opcode 0x60000200 arg 0x0
lsi_execute_script_io_clear Clear TM
lsi_execute_script SCRIPTS dsp=0x198010 opcode 0x40000000 arg 0x198208
lsi_execute_script_io_selected Selected target 0
lsi_execute_script SCRIPTS dsp=0x198018 opcode 0x80080000 arg 0x1981f8
lsi_execute_script_tc_jump Jump to 0x1981f8
lsi_execute_script SCRIPTS dsp=0x1981f8 opcode 0xa000006 arg 0x199000
lsi_execute_script_blockmove_badphase Wrong phase got MSGOUT expected CMD
lsi_script_scsi_interrupt SCSI Interrupt 0x000x80 prev 0x000x00
lsi_update_irq Update IRQ level 1 dstat 0x00 sist 0x000x80
lsi_execute_script_stop SCRIPTS execution stopped
lsi_reg_read Read reg ISTAT 0x14 = 0x02
lsi_reg_read Read reg SIST1 0x43 = 0x00
lsi_update_irq Update IRQ level 0 dstat 0x00 sist 0x000x00
lsi_reg_read Read reg SIST0 0x42 = 0x80
lsi_reg_read Read reg DSTAT 0xc = 0x80
lsi_reg_read Read reg DBC0 0x24 = 0x06
lsi_reg_read Read reg DBC1 0x25 = 0x00
lsi_reg_read Read reg DBC2 0x26 = 0x00
lsi_reg_write Write reg DSP0 0x2c = 0x08
lsi_reg_write Write reg DSP1 0x2d = 0x82
lsi_reg_write Write reg DSP2 0x2e = 0x19
lsi_reg_write Write reg DSP3 0x2f = 0x00
lsi_execute_script SCRIPTS dsp=0x198208 opcode 0x800a0000 arg 0x1982e0
lsi_execute_script_tc_compp Compare phase MSGOUT == DOUT
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198210 opcode 0x810a0000 arg 0x198280
lsi_execute_script_tc_compp Compare phase MSGOUT == DIN
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198218 opcode 0x830a0000 arg 0x198340
lsi_execute_script_tc_compp Compare phase MSGOUT == STATUS
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198220 opcode 0x820a0000 arg 0x1981f8
lsi_execute_script_tc_compp Compare phase MSGOUT == CMD
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198228 opcode 0x860a0000 arg 0x198060
lsi_execute_script_tc_compp Compare phase MSGOUT == MSGOUT
lsi_execute_script_tc_jump Jump to 0x198060
lsi_execute_script SCRIPTS dsp=0x198060 opcode 0x9e030000 arg 0x1000000
lsi_execute_script_tc_compp Compare phase MSGOUT != MSGOUT
lsi_execute_script_tc_cc_failed Control condition failed
lsi_execute_script SCRIPTS dsp=0x198068 opcode 0xe000001 arg 0x199020
lsi_do_msgout MSG out len=1
lsi_do_msgout: msg = c0
lsi_do_msgout_select Select LUN 0
lsi_execute_script SCRIPTS dsp=0x198070 opcode 0x820b0000 arg 0x1981f8
lsi_execute_script_tc_compp Compare phase CMD == CMD
lsi_execute_script_tc_jump Jump to 0x1981f8
lsi_execute_script SCRIPTS dsp=0x1981f8 opcode 0xa000006 arg 0x199000
lsi_do_command Send command len=6
qemu-system-ppc: ../hw/scsi/lsi53c895a.c:863: lsi_do_command: Assertion `s->current == NULL' failed.

Any idea what could it be and what could be done about it?

Regards,
BALATON Zoltan

