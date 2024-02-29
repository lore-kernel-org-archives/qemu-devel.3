Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0CEC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 20:20:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfmsE-00053V-V1; Thu, 29 Feb 2024 15:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfmsA-000533-Qj
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 15:19:20 -0500
Received: from chameleon.pear.relay.mailchannels.net ([23.83.216.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rfms5-0004fg-73
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 15:19:18 -0500
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 1267743B03
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 20:19:09 +0000 (UTC)
Received: from outbound3.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 4E2C344098
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 20:19:08 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1709237948; a=rsa-sha256;
 cv=pass;
 b=6NiE9v7kfLdOIAEn9o1xJt0B6ENXDIxO/lp/Fia4PVAIUQiy4F7+aBlFpG2nKYmH4EFPxB
 9o2D1vgLj9eLj+kjsVreSs7G4G4pZdul9mR7+QajyF4nICVnFW4uvqWLw/B63VEK9mytZL
 ymw9OI55xkgWUaun2qL6hXzw6qaX5eLD4Y0AnEQjc3p1GLg0bP0BNh79cYFRtuyZZAZ1r7
 2eJ6dhV3LlY7M6IPmtX6Dt36B2EebYsyiGdbtzhBWQmyHPZZxEg8mRIROdfulsLw8DUkOX
 7md6NvmJdSBY48lzD1chQuZ+oPPXNtv9WIxb+Nwtx2EzWUn8rKXT4IZhlnlVNA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1709237948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=nxhxMWkAMsUyEfVqAHrMgO95AhuWglBje/IqNUb/lKg=;
 b=GYF6WhH9xCO8GJegeodYEo+R7n27aNyxJ2vQLNBGtccyqpTZi5kuH7HW5HBragbRVpR80V
 uZngYBOf3xOb68AALfw5YSRi2xTGyUDM39wu5MabXTtjvdUUARFn3EapCczRwmLPLgvG5M
 iD1QN34t0gHKlq6/U2DzrKFTP7rmXAySSx2MFnkDQhnaAnQtdW/BAefxYbdT5ovJ+gAe+N
 ZHH7x7RL2HrRovvzNn+MslP6H3YhVJYC1dSes1UEf5awnrebHTKtaWbG/wb+CDGOdsgQrY
 FyKex1m3TUl0Ioej3sz8YnkmGYVcVCtFGDXS/ALCRWbjMjY5j/LkVdAdBtQ0Gw==
ARC-Authentication-Results: i=2; rspamd-7f9dd9fb96-x898g;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Abaft-Grain: 6bba4c063cfacbd2_1709237948828_3344051393
X-MC-Loop-Signature: 1709237948828:1342227035
X-MC-Ingress-Time: 1709237948827
Received: from outbound3.eu.mailhop.org (outbound3.eu.mailhop.org
 [52.29.21.168]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.8.104 (trex/6.9.2); Thu, 29 Feb 2024 20:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1709237922; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=vri4M/C7J9mMQfRj7ywGK7cnB8/TbwLZ4miUSn/YRoOvjnWunrf9rxhl+kezXoLnS+HF+PjfIAqwH
 uBP6RXUpvGBRgZz9y1J8SGZeaToeI4nNNeI6e8Bi4H2rk9t9VDFPmy6qOATukx4XiIFkGLuf0XWhRS
 iGczbbhI0yMx8CY3w4OEM1q7u3h+cQpqDQrleLt+6EamTaLjUwNfFlxHwerDaYnH5oAjVfCVowTwEy
 UWJyZaRPvEzMf5DW3OVuIzUroCUqswX3jrZLZTX95DrlBRSu8cO+7ug0zRFv8c8IJYwVoxNkbCZiHi
 gbbTksNpqKY9YLMwrVe8b2poRQCztAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=nxhxMWkAMsUyEfVqAHrMgO95AhuWglBje/IqNUb/lKg=;
 b=Inu5C6XfxkMxyGyP+3rJqlr48RcZEQIGXVIlKKadPgXVgghKTI3qMEwmW0Bzg6fTIjxZJ7uy/us23
 Q+aN5RjwMVJp3p2KtAs2AwfxtEHkdvghYUe5XRKzX1aDQwcEf4FjfLrWWrTnma+mRVldVI2PVwL2Wh
 qsUrjXPkInd41UF9FIM5t7aZwMLvgFq/rQUTFxzk9pJuhdHBz0FB4Eb853hM2pwn9FvC2T73dtpLfU
 PFyR5ORyxZrnYxrDq8HlIm1tcmi1i+EbZSb86tMmxyp121DThwevnzF41cPPGmQQdMO3F8Ix977bcj
 /IOe0TygJ45Jrx/RLHJMVujX6ZWER1A==
ARC-Authentication-Results: i=1; outbound3.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=YWJfm7sM; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=nxhxMWkAMsUyEfVqAHrMgO95AhuWglBje/IqNUb/lKg=;
 b=gXiqpBxnTxzjCZwRaWxrR4AY1nD70NWhOPdvG4bxjzWS0isz1J8Ku2OC6JZkTD/7A1j360M2Xt1gD
 S+E7wN3IL7V0GKndxl7dDttjkye5Hivf2UC1OPrPYjxYvrQ5DdcVHqXCyN5gLnBqJdyHcoDbDNZ6PS
 BRC8p3zF71oj3+5Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=nxhxMWkAMsUyEfVqAHrMgO95AhuWglBje/IqNUb/lKg=;
 b=Er7KXmXN006vGeUNXmsm5NDp6WKKEvdtB3IpMAuk0dcddyTmYS2SuNonaF0JfpNQgyO3G2peizd0a
 aqjhiW/cnBg6Vw7wV4baqTDov+dukUl9Q3usGiiAuMWob+ON8pn8dFKorqWSfLk0szRmU9mP83FXpn
 dj/BV9dTxgipA5SKJareuuxBQRNLs5Npodeo/IY/Tet0cWs342AwGxaiKFFuynXDks4Eoe9xnYdcRv
 aiNnJKYqSMFGpq59D0Le3fJu3BS5xyCTj8QeWadiLLg2IBP+HnIx/C0uqjEAId18EWPKXWT7HdlZF1
 EyAs99yNUD8dHUoqzFaj/nQ0vAi6alw==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: b85f7ea2-d73f-11ee-afbe-eda7e384987e
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id b85f7ea2-d73f-11ee-afbe-eda7e384987e;
 Thu, 29 Feb 2024 20:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nxhxMWkAMsUyEfVqAHrMgO95AhuWglBje/IqNUb/lKg=; b=YWJfm7sMGuIxdPtFzBpPrPAOJD
 cfHQ2VO0dcAFxkasc8wB095B7AYJc9y7NXSPemnBfdiB6PT+kgYz4j7x3ebHzWPU0uvGdpDjzNzps
 oM5meVlnDNMmiEbryQcLWU9MNGahU+OKhPoknnBBW2boPyAGa5ORc3jBiPCCY8zKG67TrMskoBqpO
 5nF+wqhXOKcr4VWcKZsdeMlMastYJfodsDp1sBuI6mwaYgkaB+Bi11b1FsvSMGfPfqrW1uh0bh3Y+
 crghuYVHt5Nru4Q0QpE5ZKawiB1l1DkwWcM1Ydi7pGSoBbxAc8J3EEo2smAQnkPXFvkTajdVAx3H3
 mHS43cqA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rfmrs-000NzG-38;
 Thu, 29 Feb 2024 21:19:01 +0100
From: Sven Schnelle <svens@stackframe.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Fam Zheng <fam@euphon.net>,  Peter
 Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org,  deller@gmx.de
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add timer to scripts processing
In-Reply-To: <3cec3ef8-557f-c481-c64c-9b8288b16a31@eik.bme.hu> (BALATON
 Zoltan's message of "Thu, 29 Feb 2024 21:01:18 +0100 (CET)")
References: <20240229193031.1677365-1-svens@stackframe.org>
 <3cec3ef8-557f-c481-c64c-9b8288b16a31@eik.bme.hu>
Date: Thu, 29 Feb 2024 21:19:00 +0100
Message-ID: <875xy7xbuz.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.216.33; envelope-from=svens@stackframe.org;
 helo=chameleon.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Thu, 29 Feb 2024, Sven Schnelle wrote:
>> Some OS's like HP-UX 10.20 are spinn
>
> I guess the above line is left here by accident.

Yes.

>> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
>> under certain circumstances. As the SCSI controller and CPU are not
>> running at the same time this loop will never finish. After some
>> time, the check loop interrupts with a unexpected device disconnect.
>> This works, but is slow because the kernel resets the scsi controller.
>> Instead of signaling UDC, start a timer and exit the loop. Until the
>> timer fires, the CPU can process instructions until the timer fires.
>> The limit of instructions is also reduced because scripts running
>> on the SCSI processor are usually very short. This keeps the time
>> until the loop-exit short.
>>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>> ---
>> hw/scsi/lsi53c895a.c | 33 +++++++++++++++++++++++++--------
>> 1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
>> index d607a5f9fb..0b6f1dc72f 100644
>> --- a/hw/scsi/lsi53c895a.c
>> +++ b/hw/scsi/lsi53c895a.c
>> @@ -188,7 +188,7 @@ static const char *names[] = {
>> #define LSI_TAG_VALID     (1 << 16)
>>
>> /* Maximum instructions to process. */
>> -#define LSI_MAX_INSN    10000
>> +#define LSI_MAX_INSN    100
>>
>> typedef struct lsi_request {
>>     SCSIRequest *req;
>> @@ -205,6 +205,7 @@ enum {
>>     LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
>>     LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
>>     LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
>> +    LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
>> };
>>
>> enum {
>> @@ -224,6 +225,7 @@ struct LSIState {
>>     MemoryRegion ram_io;
>>     MemoryRegion io_io;
>>     AddressSpace pci_io_as;
>> +    QEMUTimer *scripts_timer;
>>
>>     int carry; /* ??? Should this be an a visible register somewhere?  */
>>     int status;
>> @@ -415,6 +417,7 @@ static void lsi_soft_reset(LSIState *s)
>>     s->sbr = 0;
>>     assert(QTAILQ_EMPTY(&s->queue));
>>     assert(!s->current);
>> +    timer_del(s->scripts_timer);
>
> Maybe the rimer needs to be deleted in lsi_scsi_exit() too but I'm not
> sure.

I added it, thanks.

>> }
>>
>> static int lsi_dma_40bit(LSIState *s)
>> @@ -1127,6 +1130,12 @@ static void lsi_wait_reselect(LSIState *s)
>>     }
>> }
>>
>> +static void lsi_scripts_timer_start(LSIState *s)
>> +{
>> +    trace_lsi_scripts_timer_start();
>> +    timer_mod(s->scripts_timer, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + 500);
>> +}
>> +
>> static void lsi_execute_script(LSIState *s)
>> {
>>     PCIDevice *pci_dev = PCI_DEVICE(s);
>> @@ -1152,13 +1161,8 @@ again:
>>      * which should be enough for all valid use cases).
>>      */
>
> Does tha above comment need updating to say what the code does now?

Yes, i changed it to describe the new method:

    /*
     * Some windows drivers make the device spin waiting for a memory location
     * to change. If we have executed more than LSI_MAX_INSN instructions then
     * assume this is the case and start a timer. Until the timer fires, the
     * host CPU has a chance to run and change the memory location.
     *
     * Another issue (CVE-2023-0330) can occur if the script is programmed to
     * trigger itself again and again. Avoid this problem by stopping after
     * being called multiple times in a reentrant way (8 is an arbitrary value
     * which should be enough for all valid use cases).
     */

> Regards,
> BALATON Zoltan
>
>>     if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {
>> -        if (!(s->sien0 & LSI_SIST0_UDC)) {
>> -            qemu_log_mask(LOG_GUEST_ERROR,
>> -                          "lsi_scsi: inf. loop with UDC masked");
>> -        }
>> -        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
>> -        lsi_disconnect(s);
>> -        trace_lsi_execute_script_stop();
>> +        s->waiting = LSI_WAIT_SCRIPTS;
>> +        lsi_scripts_timer_start(s);
>>         reentrancy_level--;
>>         return;
>>     }
>> @@ -2197,6 +2201,9 @@ static int lsi_post_load(void *opaque, int version_id)
>>         return -EINVAL;
>>     }
>>
>> +    if (s->waiting == LSI_WAIT_SCRIPTS) {
>> +        lsi_scripts_timer_start(s);
>> +    }
>>     return 0;
>> }
>>
>> @@ -2294,6 +2301,15 @@ static const struct SCSIBusInfo lsi_scsi_info = {
>>     .cancel = lsi_request_cancelled
>> };
>>
>> +static void scripts_timer_cb(void *opaque)
>> +{
>> +    LSIState *s = opaque;
>> +
>> +    trace_lsi_scripts_timer_triggered();
>> +    s->waiting = LSI_NOWAIT;
>> +    lsi_execute_script(s);
>> +}
>> +
>> static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
>> {
>>     LSIState *s = LSI53C895A(dev);
>> @@ -2313,6 +2329,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
>>                           "lsi-ram", 0x2000);
>>     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
>>                           "lsi-io", 256);
>> +    s->scripts_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, scripts_timer_cb, s);
>>
>>     /*
>>      * Since we use the address-space API to interact with ram_io, disable the
>>

