Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240EAC3ABCB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 05:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF4uA-0001XG-OZ; Wed, 14 May 2025 01:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1uF4u8-0001Wt-Gr
 for qemu-devel@nongnu.org; Wed, 14 May 2025 01:43:44 -0400
Received: from mailout02.t-online.de ([194.25.134.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1uF4u6-0002zo-Fo
 for qemu-devel@nongnu.org; Wed, 14 May 2025 01:43:44 -0400
Received: from fwd75.aul.t-online.de (fwd75.aul.t-online.de [10.223.144.101])
 by mailout02.t-online.de (Postfix) with SMTP id 806801C35;
 Wed, 14 May 2025 07:43:39 +0200 (CEST)
Received: from [192.168.211.200] ([84.175.230.13]) by fwd75.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uF4u2-2yHn9N0; Wed, 14 May 2025 07:43:39 +0200
Message-ID: <2394d81d-14ab-4875-b675-c7408023678c@t-online.de>
Date: Wed, 14 May 2025 07:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/audio/asc: fix SIGSEGV in asc_realize()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <d456c188-0463-4dc2-9178-469f840eaebe@t-online.de>
 <20250511073846.8713-4-vr_qemu@t-online.de>
 <cdb6ef37-11cf-4997-ac88-72e780cf1323@ilande.co.uk>
 <5b633fd4-66da-42e4-b27b-6820801e6f85@t-online.de>
 <b6278f79-7db6-4af4-b329-66323bb35940@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <b6278f79-7db6-4af4-b329-66323bb35940@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1747201419-FE7FA517-635F7840/0/0 CLEAN NORMAL
X-TOI-MSGID: 4c3314c7-65d4-45b1-bb2d-57e163be7c45
Received-SPF: pass client-ip=194.25.134.17; envelope-from=vr_qemu@t-online.de;
 helo=mailout02.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 13.05.25 um 10:17 schrieb Mark Cave-Ayland:
> On 13/05/2025 07:14, Volker Rümelin wrote:
>
>> Am 11.05.25 um 13:52 schrieb Mark Cave-Ayland:
>>> On 11/05/2025 08:38, Volker Rümelin wrote:
>>>
>>>> AUD_open_out() may fail and return NULL. This may then lead to
>>>> a segmentation fault in memset() below. The memset() behaviour
>>>> is undefined if the pointer to the destination object is a null
>>>> pointer.
>>>>
>>>> Add the missing error handling code.
>>>>
>>>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>>>> ---
>>>>    hw/audio/asc.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
>>>> index 18382ccf6a..03dee0fcc7 100644
>>>> --- a/hw/audio/asc.c
>>>> +++ b/hw/audio/asc.c
>>>> @@ -12,6 +12,7 @@
>>>>      #include "qemu/osdep.h"
>>>>    #include "qemu/timer.h"
>>>> +#include "qapi/error.h"
>>>>    #include "hw/sysbus.h"
>>>>    #include "hw/irq.h"
>>>>    #include "audio/audio.h"
>>>> @@ -653,6 +654,12 @@ static void asc_realize(DeviceState *dev, Error
>>>> **errp)
>>>>          s->voice = AUD_open_out(&s->card, s->voice, "asc.out", s,
>>>> asc_out_cb,
>>>>                                &as);
>>>> +    if (!s->voice) {
>>>> +        asc_unrealize(dev);
>>>
>>> I don't think it is ever right for a device to unrealize itself. If
>>> the aim is to handle cleanup, then since s->mixbuf and s->silentbuf
>>> are yet to be allocated by this point then I think you can simply call
>>> error_setg() and return.
>>
>> Hi Mark,
>>
>> yes my aim was to handle cleanup. When calling asc_unrealize() I don't
>> have to think about which steps are necessary. In this case I would have
>> to call AUD_remove_card(&s->card). Therefore, I would like to keep my
>> patch version.
>
> Hi Volker,
>
> I can see why you want to call a single routine to handle tidy-up,
> however it is still expected that the various qdev device callbacks
> are only called internally by the qdev APIs. For example when
> debugging lifecycle issues you typically put breakpoints on
> init/realize/unrealize/finalize to figure out why something is not
> working as expected.
>
> A common example of this is reset in that a chip can be reset by qdev,
> but also by writing to a reset register via MMIO: in this case both
> the Resettable interface and the MMIO access simply call the same
> internal reset function.
>
> You could have a separate cleanup function and call it for the error
> case here, but since the qdev device callbacks are called in a strict
> order, you can guarantee that s->mixbuf and s->silentbuf will be unset
> at this point. So it's probably easiest just to call
> AUD_remove_card(&s->card) before the return and that guarantees that
> you won't interfere with any internal qdev management logic.

Ok, thanks for the explanation. I will send a version 2 patch series.

With best regards,
Volker


