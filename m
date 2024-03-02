Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6863C5478C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 23:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgYm6-00019k-5Q; Sat, 02 Mar 2024 18:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rgYm4-00019J-6D
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 18:28:12 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rgYm2-0002X4-06
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 18:28:11 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 92D7A4E6013;
 Sun,  3 Mar 2024 00:28:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Dez4TPTldS8c; Sun,  3 Mar 2024 00:28:03 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9B4D44E6012; Sun,  3 Mar 2024 00:28:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 976D97456FE;
 Sun,  3 Mar 2024 00:28:03 +0100 (CET)
Date: Sun, 3 Mar 2024 00:28:03 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Sven Schnelle <svens@stackframe.org>
cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>
Subject: Re: lsi53c895a assert with AmigaOS
In-Reply-To: <8734t8w836.fsf@t14.stackframe.org>
Message-ID: <8d8bfc79-3e48-0d38-67a2-53631bad7f84@eik.bme.hu>
References: <20a8b781-fd08-4e2c-9916-8483b1e4a6c2@eik.bme.hu>
 <8734t8w836.fsf@t14.stackframe.org>
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
>> AmigaOS4 also has a driver for this card so I've tried to test it but
>> it trips an assert. Does anybody have an idea why and how it could be
>> fixed? Sven's recent patches don't seem to have an effect on this, it
>> still happens shortly after it tries to access the SCSI device with
>> those patches applied. (Unfortunately AmigaOS is not freely available
>> so it's a bit hard to reproduce but I can do tests if needed.) I got
>> the following traces:
>> [..]
>> lsi_do_command Send command len=6
>> qemu-system-ppc: ../hw/scsi/lsi53c895a.c:863: lsi_do_command: Assertion `s->current == NULL' failed.
>>
>> Any idea what could it be and what could be done about it?
>
> I think the Host is resetting the SCSI controller while it still has
> some request pending. I made a hack to work around that bug, but so
> far i haven't spent the time to verify whether it's correct or whether
> there are additional changes required. Here it is:

This does avoid the assert and now it boots but then can't read the scsi 
device. (I've tried with a scsi-cd with an iso image and it thinks it's an 
audio CD and cannot read data from it). Maybe something else is needed but 
this seems to go one step further. However I don't see "lsi_reset Reset" 
traces other than once when the driver starts so not sure it's really 
related to reset. Could it be that the driver expects it to be able to 
send commands while another one is still processing so the pending one 
would need to be put back in the queue instead of cancelling ir? But I 
don't know how to do that so cannot try unless you can give me a patch.

Regards,
BALATON Zoltan

> From 6a807653679fde5e3e09a7f27576c673f335fef6 Mon Sep 17 00:00:00 2001
> From: Sven Schnelle <svens@stackframe.org>
> Date: Sat, 3 Feb 2024 19:46:07 +0100
> Subject: [PATCH] lsi53c895a: free pending requests on reset
>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
> hw/scsi/lsi53c895a.c | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index d607a5f9fb..c6bd801a7e 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -346,6 +346,8 @@ static lsi_request *get_pending_req(LSIState *s)
>
> static void lsi_soft_reset(LSIState *s)
> {
> +    lsi_request *p, *p_next;
> +
>     trace_lsi_reset();
>     s->carry = 0;
>
> @@ -413,8 +415,14 @@ static void lsi_soft_reset(LSIState *s)
>     s->sbc = 0;
>     s->csbc = 0;
>     s->sbr = 0;
> -    assert(QTAILQ_EMPTY(&s->queue));
> -    assert(!s->current);
> +
> +    QTAILQ_FOREACH_SAFE(p, &s->queue, next, p_next) {
> +        scsi_req_cancel(p->req);
> +    }
> +
> +    if (s->current)
> +        scsi_req_cancel(s->current->req);
> +    s->current = NULL;
> }
>
> static int lsi_dma_40bit(LSIState *s)
> @@ -860,7 +868,9 @@ static void lsi_do_command(LSIState *s)
>         return;
>     }
>
> -    assert(s->current == NULL);
> +    if (s->current)
> +        scsi_req_cancel(s->current->req);
> +
>     s->current = g_new0(lsi_request, 1);
>     s->current->tag = s->select_tag;
>     s->current->req = scsi_req_new(dev, s->current->tag, s->current_lun, buf,
>

