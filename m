Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2C0C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 11:30:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgk2Y-0006MX-Rw; Sun, 03 Mar 2024 06:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rgk2X-0006MG-G1
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 06:29:57 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rgk2V-0003bt-9B
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 06:29:57 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1DE214E60D1;
 Sun,  3 Mar 2024 12:29:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id uT_2xsI-H0Dc; Sun,  3 Mar 2024 12:29:49 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2FCDC4E6099; Sun,  3 Mar 2024 12:29:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2D9977456B4;
 Sun,  3 Mar 2024 12:29:49 +0100 (CET)
Date: Sun, 3 Mar 2024 12:29:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Sven Schnelle <svens@stackframe.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>
Subject: Re: lsi53c895a assert with AmigaOS
In-Reply-To: <8d8bfc79-3e48-0d38-67a2-53631bad7f84@eik.bme.hu>
Message-ID: <3af37ed3-7d75-ec22-91c4-dc44aa2ecae5@eik.bme.hu>
References: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu>
 <8734t8w836.fsf@t14.stackframe.org>
 <8d8bfc79-3e48-0d38-67a2-53631bad7f84@eik.bme.hu>
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
>>> AmigaOS4 also has a driver for this card so I've tried to test it but
>>> it trips an assert. Does anybody have an idea why and how it could be
>>> fixed? Sven's recent patches don't seem to have an effect on this, it
>>> still happens shortly after it tries to access the SCSI device with
>>> those patches applied. (Unfortunately AmigaOS is not freely available
>>> so it's a bit hard to reproduce but I can do tests if needed.) I got
>>> the following traces:
>>> [..]
>>> lsi_do_command Send command len=6
>>> qemu-system-ppc: ../hw/scsi/lsi53c895a.c:863: lsi_do_command: Assertion 
>>> `s->current == NULL' failed.
>>> 
>>> Any idea what could it be and what could be done about it?
>> 
>> I think the Host is resetting the SCSI controller while it still has
>> some request pending. I made a hack to work around that bug, but so
>> far i haven't spent the time to verify whether it's correct or whether
>> there are additional changes required. Here it is:
>
> This does avoid the assert and now it boots but then can't read the scsi 
> device. (I've tried with a scsi-cd with an iso image and it thinks it's an 
> audio CD and cannot read data from it). Maybe something else is needed but 
> this seems to go one step further. However I don't see "lsi_reset Reset" 
> traces other than once when the driver starts so not sure it's really related 
> to reset. Could it be that the driver expects it to be able to send commands 
> while another one is still processing so the pending one would need to be put 
> back in the queue instead of cancelling ir? But I don't know how to do that 
> so cannot try unless you can give me a patch.

I've tried this change:

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index f8598a17f5..6f547c0d33 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -860,7 +860,9 @@ static void lsi_do_command(LSIState *s)
          return;
      }

-    assert(s->current == NULL);
+    if (s->current) {
+        lsi_queue_command(s);
+    }
      s->current = g_new0(lsi_request, 1);
      s->current->tag = s->select_tag;
      s->current->req = scsi_req_new(dev, s->current->tag, s->current_lun, buf,

but then I get:

lsi_do_msgout MSG out len=1
lsi_do_msgout_select Select LUN 0
lsi_execute_script SCRIPTS dsp=0x198070 opcode 0x820b0000 arg 0x1981f8
lsi_execute_script_tc_compp Compare phase CMD == CMD
lsi_execute_script_tc_jump Jump to 0x1981f8
lsi_execute_script SCRIPTS dsp=0x1981f8 opcode 0xa000006 arg 0x199000
lsi_do_command Send command len=6
lsi_queue_command Queueing tag=0x0
qemu-system-ppc: ../hw/scsi/lsi53c895a.c:677: lsi_queue_command: Assertion 
`s->current->dma_len == 0' failed.

So maybe there's some transfer in progress that would need to be finished 
or what to do in this case?

Regards,
BALATON Zoltan

