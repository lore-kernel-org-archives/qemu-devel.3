Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11062C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 12:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rglDF-0002Xb-W3; Sun, 03 Mar 2024 07:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rglD8-0002TR-4M
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 07:44:59 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rglD5-0007BO-Ab
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 07:44:57 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EFC814E60D2;
 Sun,  3 Mar 2024 13:44:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 6g_rD5rwFajR; Sun,  3 Mar 2024 13:44:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BC2ED4E60D1; Sun,  3 Mar 2024 13:44:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BAF1E7456B4;
 Sun,  3 Mar 2024 13:44:48 +0100 (CET)
Date: Sun, 3 Mar 2024 13:44:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Sven Schnelle <svens@stackframe.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>
Subject: Re: lsi53c895a assert with AmigaOS
In-Reply-To: <87y1azv83i.fsf@t14.stackframe.org>
Message-ID: <f04af11b-b032-3247-1525-2aac132236d3@eik.bme.hu>
References: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu>
 <87y1azv83i.fsf@t14.stackframe.org>
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

On Sun, 3 Mar 2024, Sven Schnelle wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>
>> Hello,
>>
>> AmigaOS4 also has a driver for this card so I've tried to test it but
>> it trips an assert. Does anybody have an idea why and how it could be
>> fixed? Sven's recent patches don't seem to have an effect on this, it
>> still happens shortly after it tries to access the SCSI device with
>> those patches applied. (Unfortunately AmigaOS is not freely available
>> so it's a bit hard to reproduce but I can do tests if needed.) I got
>> the following traces:
>>
>> lsi_reg_write Write reg SIEN0 0x40 = 0x84
>> lsi_reg_write Write reg SIEN1 0x41 = 0x04
>> lsi_reg_write Write reg DIEN 0x39 = 0xff
>> lsi_reg_write Write reg DSP0 0x2c = 0x00
>> lsi_reg_write Write reg DSP1 0x2d = 0x80
>> lsi_reg_write Write reg DSP2 0x2e = 0x19
>> lsi_reg_write Write reg DSP3 0x2f = 0x00
>> lsi_execute_script SCRIPTS dsp=0x198000 opcode 0x7c07fe00 arg 0x0
>> lsi_execute_script_io_opcode Read-Modify-Write reg 0x7 AND data8=0xfe sfbr=0x01
>> lsi_reg_read Read reg GPREG 0x7 = 0x7f
>> lsi_reg_write Write reg GPREG 0x7 = 0x7e
>> lsi_execute_script SCRIPTS dsp=0x198008 opcode 0x60000200 arg 0x0
>> lsi_execute_script_io_clear Clear TM
>> lsi_execute_script SCRIPTS dsp=0x198010 opcode 0x40000000 arg 0x198208
>> lsi_execute_script_io_alreadyreselected Already reselected, jumping to
>> alternative address
> here ---^
>> lsi_do_msgout_select Select LUN 0
>> lsi_execute_script SCRIPTS dsp=0x198070 opcode 0x820b0000 arg 0x1981f8
>> lsi_execute_script_tc_compp Compare phase CMD == CMD
>> lsi_execute_script_tc_jump Jump to 0x1981f8
>> lsi_execute_script SCRIPTS dsp=0x1981f8 opcode 0xa000006 arg 0x199000
>> lsi_do_command Send command len=6
>> qemu-system-ppc: ../hw/scsi/lsi53c895a.c:863: lsi_do_command: Assertion `s->current == NULL' failed.
>>
>> Any idea what could it be and what could be done about it?
>
> Wild guess is that this is because of the 'Already reselected' line
> above. lsi_reselect() sets s->current, and later when lsi_do_command()
> is called it gets confused because s->current is already set. But i
> would need the whole logfile to see why this is going wrong, or even
> better AmigaOS (which is not free as you already mentioned)

Thanks for looking at this. I've uploaded the full log here: 
http://zero.eik.bme.hu/~balaton/qemu/aos-lsi-scsi.log.xz
but not sure you'd get more info from it as it seems to be working up to 
the error. This happens short after boot when the driver is started which 
seems to be going OK but when first accessing the device then it runs into 
the error. I don't know how this controller works so can't really tell 
what would be correct behaviour here.

Regards,
BALATON Zoltan

