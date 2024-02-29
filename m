Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD05C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 23:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfpPJ-00056g-3T; Thu, 29 Feb 2024 18:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rfpPB-000567-Kc
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:01:39 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rfpP8-0006QO-Ti
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 18:01:33 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B54D14E601B;
 Fri,  1 Mar 2024 00:01:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id xdO5vs9119Vy; Fri,  1 Mar 2024 00:01:24 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B8C144E6004; Fri,  1 Mar 2024 00:01:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B72B87456FE;
 Fri,  1 Mar 2024 00:01:24 +0100 (CET)
Date: Fri, 1 Mar 2024 00:01:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Sven Schnelle <svens@stackframe.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 deller@gmx.de
Subject: Re: [PATCH] hw/scsi/lsi53c895a: add timer to scripts processing
In-Reply-To: <875xy7xbuz.fsf@t14.stackframe.org>
Message-ID: <f5fe5ee1-fd43-7cf8-73bc-d0eef4b5eb98@eik.bme.hu>
References: <20240229193031.1677365-1-svens@stackframe.org>
 <3cec3ef8-557f-c481-c64c-9b8288b16a31@eik.bme.hu>
 <875xy7xbuz.fsf@t14.stackframe.org>
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

On Thu, 29 Feb 2024, Sven Schnelle wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>
>> On Thu, 29 Feb 2024, Sven Schnelle wrote:
>>> Some OS's like HP-UX 10.20 are spinn
>>
>> I guess the above line is left here by accident.
>
> Yes.
>
>>> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
>>> under certain circumstances. As the SCSI controller and CPU are not
>>> running at the same time this loop will never finish. After some
>>> time, the check loop interrupts with a unexpected device disconnect.
>>> This works, but is slow because the kernel resets the scsi controller.
>>> Instead of signaling UDC, start a timer and exit the loop. Until the
>>> timer fires, the CPU can process instructions until the timer fires.
>>> The limit of instructions is also reduced because scripts running
>>> on the SCSI processor are usually very short. This keeps the time
>>> until the loop-exit short.
>>>
>>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> ---
>>> hw/scsi/lsi53c895a.c | 33 +++++++++++++++++++++++++--------
>>> 1 file changed, 25 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
>>> index d607a5f9fb..0b6f1dc72f 100644
>>> --- a/hw/scsi/lsi53c895a.c
>>> +++ b/hw/scsi/lsi53c895a.c
>>> @@ -188,7 +188,7 @@ static const char *names[] = {
>>> #define LSI_TAG_VALID     (1 << 16)
>>>
>>> /* Maximum instructions to process. */
>>> -#define LSI_MAX_INSN    10000
>>> +#define LSI_MAX_INSN    100
>>>
>>> typedef struct lsi_request {
>>>     SCSIRequest *req;
>>> @@ -205,6 +205,7 @@ enum {
>>>     LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
>>>     LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
>>>     LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
>>> +    LSI_WAIT_SCRIPTS, /* SCRIPTS stopped because of instruction count limit */
>>> };
>>>
>>> enum {
>>> @@ -224,6 +225,7 @@ struct LSIState {
>>>     MemoryRegion ram_io;
>>>     MemoryRegion io_io;
>>>     AddressSpace pci_io_as;
>>> +    QEMUTimer *scripts_timer;
>>>
>>>     int carry; /* ??? Should this be an a visible register somewhere?  */
>>>     int status;
>>> @@ -415,6 +417,7 @@ static void lsi_soft_reset(LSIState *s)
>>>     s->sbr = 0;
>>>     assert(QTAILQ_EMPTY(&s->queue));
>>>     assert(!s->current);
>>> +    timer_del(s->scripts_timer);
>>
>> Maybe the rimer needs to be deleted in lsi_scsi_exit() too but I'm not
>> sure.
>
> I added it, thanks.
>
>>> }
>>>
>>> static int lsi_dma_40bit(LSIState *s)
>>> @@ -1127,6 +1130,12 @@ static void lsi_wait_reselect(LSIState *s)
>>>     }
>>> }
>>>
>>> +static void lsi_scripts_timer_start(LSIState *s)
>>> +{
>>> +    trace_lsi_scripts_timer_start();
>>> +    timer_mod(s->scripts_timer, qemu_clock_get_us(QEMU_CLOCK_VIRTUAL) + 500);
>>> +}
>>> +
>>> static void lsi_execute_script(LSIState *s)
>>> {
>>>     PCIDevice *pci_dev = PCI_DEVICE(s);
>>> @@ -1152,13 +1161,8 @@ again:
>>>      * which should be enough for all valid use cases).
>>>      */
>>
>> Does tha above comment need updating to say what the code does now?
>
> Yes, i changed it to describe the new method:
>
>    /*
>     * Some windows drivers make the device spin waiting for a memory location
>     * to change. If we have executed more than LSI_MAX_INSN instructions then
>     * assume this is the case and start a timer. Until the timer fires, the
>     * host CPU has a chance to run and change the memory location.

Is that the host or guest CPU? I thought the guest vcpu needs to get a 
chance to do something about this but maybe I did not get the problem at 
all.

Regards,
BALATON Zoltan

>     *
>     * Another issue (CVE-2023-0330) can occur if the script is programmed to
>     * trigger itself again and again. Avoid this problem by stopping after
>     * being called multiple times in a reentrant way (8 is an arbitrary value
>     * which should be enough for all valid use cases).
>     */
>
>> Regards,
>> BALATON Zoltan
>>
>>>     if (++insn_processed > LSI_MAX_INSN || reentrancy_level > 8) {
>>> -        if (!(s->sien0 & LSI_SIST0_UDC)) {
>>> -            qemu_log_mask(LOG_GUEST_ERROR,
>>> -                          "lsi_scsi: inf. loop with UDC masked");
>>> -        }
>>> -        lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
>>> -        lsi_disconnect(s);
>>> -        trace_lsi_execute_script_stop();
>>> +        s->waiting = LSI_WAIT_SCRIPTS;
>>> +        lsi_scripts_timer_start(s);
>>>         reentrancy_level--;
>>>         return;
>>>     }
>>> @@ -2197,6 +2201,9 @@ static int lsi_post_load(void *opaque, int version_id)
>>>         return -EINVAL;
>>>     }
>>>
>>> +    if (s->waiting == LSI_WAIT_SCRIPTS) {
>>> +        lsi_scripts_timer_start(s);
>>> +    }
>>>     return 0;
>>> }
>>>
>>> @@ -2294,6 +2301,15 @@ static const struct SCSIBusInfo lsi_scsi_info = {
>>>     .cancel = lsi_request_cancelled
>>> };
>>>
>>> +static void scripts_timer_cb(void *opaque)
>>> +{
>>> +    LSIState *s = opaque;
>>> +
>>> +    trace_lsi_scripts_timer_triggered();
>>> +    s->waiting = LSI_NOWAIT;
>>> +    lsi_execute_script(s);
>>> +}
>>> +
>>> static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
>>> {
>>>     LSIState *s = LSI53C895A(dev);
>>> @@ -2313,6 +2329,7 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
>>>                           "lsi-ram", 0x2000);
>>>     memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
>>>                           "lsi-io", 256);
>>> +    s->scripts_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, scripts_timer_cb, s);
>>>
>>>     /*
>>>      * Since we use the address-space API to interact with ram_io, disable the
>>>
>
>

