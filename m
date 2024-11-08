Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90A5D5C0C6
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PA8-0001DR-LD; Fri, 08 Nov 2024 08:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1t9PA6-0001DF-2i
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:36:30 -0500
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.de>) id 1t9PA3-0003Ct-S6
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:36:29 -0500
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 99030240104
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2024 14:36:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
 t=1731072985; bh=fy5E1ypIGTl8bKnX3x+/quMUDoGHBMo2QctO5SL1DyU=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=BmzIU2vz1mOEiofEeiU4mBmqbYtlaseNu2BtSj3go9MGM24pu2RsBGb9aH8SYKuB0
 x871bwLGerRHVHT6NiowNpbEwIyYNp6/ASpcxRbSIApdlHhXPvWBkrdmfzRy06zzN7
 Oz0Hrle6o4UXyoqlIfii6GPFlZxtHJjtRIA4gc+gKAd+OefQt63dlmBlhyD9DzExT6
 sKpfK8xy7xeR257A3ggU2e1OBw+DQ1YWzq7shTqpun+EY20Dz6p6bXknlFvseBr7G0
 ePWDE0zVNPjKHFX+wW5LaGU3hweXUWRpIxdwsZYyaa8bTqkrT7AoB8ThCnrStYQ7As
 fXsaHcnB3hccw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4XlKj42jW5z9rxD;
 Fri,  8 Nov 2024 14:36:24 +0100 (CET)
Message-ID: <245f3e08-4259-4026-a91e-e1dd39886b49@posteo.de>
Date: Fri,  8 Nov 2024 13:36:23 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] next-kbd: convert to use
 qemu_input_handler_register()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, peter.maydell@linaro.org,
 huth@tuxfamily.org, berrange@redhat.com, qemu-devel@nongnu.org
References: <20241106120928.242443-1-mark.cave-ayland@ilande.co.uk>
 <20241106120928.242443-2-mark.cave-ayland@ilande.co.uk>
 <4c127d3c-3610-e6b7-9358-3d88d28477a0@eik.bme.hu>
 <13995544-2d94-4b35-a7c2-f11e0599170f@linaro.org>
 <872fd077-b870-f910-88a5-a045787aa681@eik.bme.hu>
 <c3b996b4-d128-4830-94d4-5c9448ca003d@posteo.de>
 <5c992398-718d-9445-7122-053c8169bb5b@eik.bme.hu>
 <4780d984-e23b-8594-88b0-78fbaee5ad42@eik.bme.hu>
From: Thomas Huth <th.huth@posteo.de>
Content-Language: en-US
In-Reply-To: <4780d984-e23b-8594-88b0-78fbaee5ad42@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.de;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 08/11/2024 14.24, BALATON Zoltan wrote:
> On Fri, 8 Nov 2024, BALATON Zoltan wrote:
>> On Fri, 8 Nov 2024, Thomas Huth wrote:
>>> On 06/11/2024 21.32, BALATON Zoltan wrote:
>>>> On Wed, 6 Nov 2024, Philippe Mathieu-Daudé wrote:
>>>>> On 6/11/24 13:00, BALATON Zoltan wrote:
>>>>>> On Wed, 6 Nov 2024, Mark Cave-Ayland wrote:
>>>>>>> Convert the next-kbd device from the legacy UI 
>>>>>>> qemu_add_kbd_event_handler()
>>>>>>> function to use qemu_input_handler_register().
>>>>>>>
>>>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>>> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
>>>>>>> ---
>>>>>>> hw/m68k/next-kbd.c | 163 ++++++++++++++++++++++++++++++---------------
>>>>>>> 1 file changed, 108 insertions(+), 55 deletions(-)
>>>>>
>>>>>
>>>>>>> -static const unsigned char next_keycodes[128] = {
>>>>>>> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>>>>>>> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>>>>>>> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>>>>>>> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>>>>>>> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>>>>>>> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>>>>>>> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>>>>>>> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>>>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
>>>>>>> +#define NEXTKBD_NO_KEY 0xff
>>>>>>
>>>>>> Now you don't need this 0xff define any more because you can use 0 as 
>>>>>> no key value then the [0 ... Q_KEY_CODE__MAX] init below can also be 
>>>>>> dropped because static variables are 0 init automatically.
>>>>>
>>>>> Whether 0 or 0xff is best for NO_KEY, I don't know.
>>>>> However, definitions are useful when reviewing ...
>>>>>
>>>>>>
>>>>>> Regards,
>>>>>> BALATON Zoltan
>>>>>>
>>>>>>> +static const int qcode_to_nextkbd_keycode[] = {
>>>>>>> +    /* Make sure future additions are automatically set to 
>>>>>>> NEXTKBD_NO_KEY */
>>>>>>> +    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
>>>>>>> +
>>>>>>> +    [Q_KEY_CODE_ESC]           = 0x49,
>>>>>>> +    [Q_KEY_CODE_1]             = 0x4a,
>>>>>>> +    [Q_KEY_CODE_2]             = 0x4b,
>>>>>>> +    [Q_KEY_CODE_3]             = 0x4c,
>>>>>>> +    [Q_KEY_CODE_4]             = 0x4d,
>>>>> [...]
>>>>>
>>>>>>> +static void nextkbd_event(DeviceState *dev, QemuConsole *src, 
>>>>>>> InputEvent *evt)
>>>>>>> +{
>>>>>>> +    NextKBDState *s = NEXTKBD(dev);
>>>>>>> +    int qcode, keycode;
>>>>>>> +    bool key_down = evt->u.key.data->down;
>>>>>>> +
>>>>>>> +    qcode = qemu_input_key_value_to_qcode(evt->u.key.data->key);
>>>>>>> +    if (qcode >= ARRAY_SIZE(qcode_to_nextkbd_keycode)) {
>>>>>>> +        return;
>>>>>>> +    }
> 
> Never mind, there's already a check for that here so it should be OK. (Does 
> this still work with SHIFTs not having a value in the array? Maybe they 
> happen to be lower than the array size but maybe it's better to move this 
> check lower?)

Q_KEY_CODE_SHIFT is one of the first entries in the enumeration, so we 
should be fine for now. I also tested the patch and the shift keys are 
working as expected.

  Thomas


