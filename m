Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8669C30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzoo-0000VC-9f; Tue, 25 Jun 2024 02:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=+2S4=N3=kaod.org=clg@ozlabs.org>)
 id 1sLzon-0000Ut-3S; Tue, 25 Jun 2024 02:38:17 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=+2S4=N3=kaod.org=clg@ozlabs.org>)
 id 1sLzok-0002Hi-BF; Tue, 25 Jun 2024 02:38:16 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W7ZsB1r46z4wcS;
 Tue, 25 Jun 2024 16:38:06 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W7Zs63b1wz4wbr;
 Tue, 25 Jun 2024 16:38:02 +1000 (AEST)
Message-ID: <7974a26d-4ad4-445f-a3b3-71c08984ad16@kaod.org>
Date: Tue, 25 Jun 2024 08:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] aspeed/soc: Fix possible divide by zero
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 cmd <clement.mathieudrif.etu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240625015028.1382059-1-jamin_lin@aspeedtech.com>
 <20240625015028.1382059-2-jamin_lin@aspeedtech.com>
 <24dbb79e-cdcc-4415-befa-e6351c8f29b4@gmail.com>
 <69656db3-24a7-447d-b2b2-49a938744be4@kaod.org>
 <d698609b-4760-4932-999b-4d4754021421@gmail.com>
 <SI2PR06MB50415148B5224AB52D485D02FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <SI2PR06MB50415148B5224AB52D485D02FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=+2S4=N3=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/25/24 8:15 AM, Jamin Lin wrote:
> Hi cmd, Cedric and Peter,
> 
>> -----Original Message-----
>> From: cmd <clement.mathieudrif.etu@gmail.com>
>> Sent: Tuesday, June 25, 2024 2:07 PM
>> To: Cédric Le Goater <clg@kaod.org>; Jamin Lin <jamin_lin@aspeedtech.com>;
>> Peter Maydell <peter.maydell@linaro.org>; Steven Lee
>> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Andrew
>> Jeffery <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; open
>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH v2 1/2] aspeed/soc: Fix possible divide by zero
>>
>>
>> On 25/06/2024 08:03, Cédric Le Goater wrote:
>>> On 6/25/24 8:00 AM, cmd wrote:
>>>> Hi
>>>>
>>>> On 25/06/2024 03:50, Jamin Lin via wrote:
>>>>> Coverity reports a possible DIVIDE_BY_ZERO issue regarding the
>>>>> "ram_size" object property. This can not happen because RAM has
>>>>> predefined valid sizes per SoC. Nevertheless, add a test to close
>>>>> the issue.
>>>>>
>>>>> Fixes: Coverity CID 1547113
>>>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>>>> Reviewed-by: Cédric Le Goater <clg@redhat.com> [ clg: Rewrote commit
>>>>> log ]
>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>> ---
>>>>>    hw/arm/aspeed_ast27x0.c | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c index
>>>>> b6876b4862..d14a46df6f 100644
>>>>> --- a/hw/arm/aspeed_ast27x0.c
>>>>> +++ b/hw/arm/aspeed_ast27x0.c
>>>>> @@ -211,6 +211,12 @@ static void aspeed_ram_capacity_write(void
>>>>> *opaque, hwaddr addr, uint64_t data,
>>>>>        ram_size = object_property_get_uint(OBJECT(&s->sdmc),
>>>>> "ram-size",
>>>>>                                            &error_a
>> bort);
>>>>> +    if (!ram_size) {
>>>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>>>> +                      "%s: ram_size is zero",  __func__);
>>>>> +        return;
>>>>> +    }
>>>>> +
>>>> If we are sure that the error cannot happen, shouldn't we assert
>>>> instead?
>>>
>>> Yes. That is what Peter suggested. This needs to be changed.
>>>
> Thanks for review and suggestion.
> How about this change?
> 
> assert(ram_size > 0);

yes.

I will send another patch fixing a long standing issue in the SDMC
model not checking the ram_size value in the realize handler. It
relies on the "ram-size" property being set.

Thanks,

C.


> If you agree, I will send v3 patch.
> Thanks-Jamin
> 
>>>
>>> Thanks,
>>>
>>> C.
>>>
>> Ok fine, I didn't see the message, sorry!
>>
>> Thanks
>>
>>   >cmd
>>
>>>
>>>
>>>>>        /*
>>>>>         * Emulate ddr capacity hardware behavior.
>>>>>         * If writes the data to the address which is beyond the ram
>>>>> size,
>>>


