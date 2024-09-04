Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7CFCA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 11:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slo3p-0002ZO-Jk; Wed, 04 Sep 2024 07:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slo3e-0001uk-E8
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:20:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slo3c-0000Fz-0T
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 07:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=NTVJCIijo7BWTcZV3LqWQgRatoEsB1f2SVlshq4WQ9c=; b=PY6bsgFf5SeX/AZMxlk+xEdoN/
 sNo7uPc+whOE2zfOVP3bx+Qm/9blNQnDbilavFrTGlJU5upZQfm6zDRlgg7EXZBuj6G+vxhsCtQG1
 ++ucwyqBcXRPfUF5NHsGjJP+ShUFjs3tZ2PNPl1tBptfFHHsnGlxcJ57N5YVBR9R+S8MgtFBeD37V
 FSCcNZnUs9aYvnLQ77UQrTRsssQxImKx3irN9myha+qhl+undGIgEmhjV5RSReGIzwa0Y3HUAA4f/
 Vk1uq+FckskNk518P4fhLcfPrDVJTjHKEU2hqBufGI250Pp1JftXdVo4/URJvJX6GhSlqSKBJkxxx
 z+0Oq4sav95rVKh6PtCbDcArwdKauqsUKAJPTk+Dy7Ck/VV2BfO7OUZmMXQV5umbxCPXEnBL+d7LL
 sHEo5pQOEnYmnU1gS2NqwnW540+fKh+Rq215jgQmXCrkVu4nRLph7lklAnrzQp7VVifLc4oLxWpBz
 ZFI+vTwdDRGc3MsS9Xgi8VcB8ROjFTN+cwseyENrJxKVezzCCjwLkThGT2lU2wyvB0QbDA5FRgMRd
 jTT2GSjI3r4BmGDIjp8u/wj+CPnmFUnr7xAEENFWjXy0d5rRYRdWRvpFW+At0VrPTvSaM134drFlm
 VusYAhk7T+3io+hSPXhIaz7z0ZG/VD/rWKN/4iBBg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slo3O-0002n2-85; Wed, 04 Sep 2024 12:20:06 +0100
Message-ID: <6317769b-2d90-4c72-a3fb-1de88f6dda6c@ilande.co.uk>
Date: Wed, 4 Sep 2024 12:19:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 chauser@pullman.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20240904102301.175706-1-mark.cave-ayland@ilande.co.uk>
 <e828e000-664e-48af-ae33-6e323e28d167@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <e828e000-664e-48af-ae33-6e323e28d167@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3] escc: convert Sun mouse to use QemuInputHandler
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 04/09/2024 11:53, Philippe Mathieu-Daudé wrote:

> On 4/9/24 12:23, Mark Cave-Ayland wrote:
>> Update the Sun mouse implementation to use QemuInputHandler instead of the
>> legacy qemu_add_mouse_event_handler() function.
>>
>> Note that this conversion adds extra sunmouse_* members to ESCCChannelState
>> but they are not added to the migration stream (similar to the Sun keyboard
>> members). If this were desired in future, the Sun devices should be split
>> into separate devices and added to the migration stream there instead.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2518
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> On v3 there is also an implicit:
> Tested-by: Carl Hauser <chauser@pullman.com>

That's true, although I'm hesitant to add such a tag without a nod from the tester. 
Carl, are you happy for me to add your Tested-by tag upon merge?

>> ---
>>   hw/char/escc.c         | 88 +++++++++++++++++++++++++++++++-----------
>>   include/hw/char/escc.h |  3 ++
>>   2 files changed, 69 insertions(+), 22 deletions(-)
>>
>> v3:
>> - Subtract the deltas in sunmouse_sync() instead of resetting them to zero
>>    which provides better tracking if the mouse movement exceeds the 8-bit
>>    delta limit of the MSC protocol
>>
>> - Add R-B tag from Richard
>>
>> v2:
>> - Only allow left, middle and right button events (use bit 7 which is always
>>    set in the first byte to indicate a valid event)
>>
>> - Remove zero entries from the bmap table as static entries should be
>>    zero anyway
>>
>>
>> diff --git a/hw/char/escc.c b/hw/char/escc.c
>> index d450d70eda..245a7b19d3 100644
>> --- a/hw/char/escc.c
>> +++ b/hw/char/escc.c
>> @@ -287,6 +287,7 @@ static void escc_reset_chn(ESCCChannelState *s)
>>       s->rxint = s->txint = 0;
>>       s->rxint_under_svc = s->txint_under_svc = 0;
>>       s->e0_mode = s->led_mode = s->caps_lock_mode = s->num_lock_mode = 0;
>> +    s->sunmouse_dx = s->sunmouse_dy = s->sunmouse_buttons = 0;
>>       clear_queue(s);
>>   }
>> @@ -952,53 +953,96 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
>>       }
>>   }
>> -static void sunmouse_event(void *opaque,
>> -                               int dx, int dy, int dz, int buttons_state)
>> +static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
>> +                                  InputEvent *evt)
>>   {
>> -    ESCCChannelState *s = opaque;
>> -    int ch;
>> +    ESCCChannelState *s = (ESCCChannelState *)dev;
>> +    InputMoveEvent *move;
>> +    InputBtnEvent *btn;
>> +    static const int bmap[INPUT_BUTTON__MAX] = {
>> +        [INPUT_BUTTON_LEFT]   = 0x4,
>> +        [INPUT_BUTTON_MIDDLE] = 0x2,
>> +        [INPUT_BUTTON_RIGHT]  = 0x1,
>> +    };
>> +
>> +    switch (evt->type) {
>> +    case INPUT_EVENT_KIND_REL:
>> +        move = evt->u.rel.data;
>> +        if (move->axis == INPUT_AXIS_X) {
>> +            s->sunmouse_dx += move->value;
>> +        } else if (move->axis == INPUT_AXIS_Y) {
>> +            s->sunmouse_dy -= move->value;
>> +        }
>> +        break;
>> -    trace_escc_sunmouse_event(dx, dy, buttons_state);
>> -    ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
>> +    case INPUT_EVENT_KIND_BTN:
>> +        btn = evt->u.btn.data;
>> +        if (bmap[btn->button]) {
>> +            if (btn->down) {
>> +                s->sunmouse_buttons |= bmap[btn->button];
>> +            } else {
>> +                s->sunmouse_buttons &= ~bmap[btn->button];
>> +            }
>> +            /* Indicate we have a supported button event */
>> +            s->sunmouse_buttons |= 0x80;
>> +        }
>> +        break;
>> -    if (buttons_state & MOUSE_EVENT_LBUTTON) {
>> -        ch ^= 0x4;
>> -    }
>> -    if (buttons_state & MOUSE_EVENT_MBUTTON) {
>> -        ch ^= 0x2;
>> +    default:
>> +        /* keep gcc happy */
>> +        break;
>>       }
>> -    if (buttons_state & MOUSE_EVENT_RBUTTON) {
>> -        ch ^= 0x1;
>> +}
>> +
>> +static void sunmouse_sync(DeviceState *dev)
>> +{
>> +    ESCCChannelState *s = (ESCCChannelState *)dev;
>> +    int ch;
>> +
>> +    if (s->sunmouse_dx == 0 && s->sunmouse_dy == 0 &&
>> +        (s->sunmouse_buttons & 0x80) == 0) {
>> +            /* Nothing to do after button event filter */
>> +            return;
>>       }
>> +    /* Clear our button event flag */
>> +    s->sunmouse_buttons &= ~0x80;
>> +    trace_escc_sunmouse_event(s->sunmouse_dx, s->sunmouse_dy,
>> +                              s->sunmouse_buttons);
>> +    ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
>> +    ch ^= s->sunmouse_buttons;
>>       put_queue(s, ch);
>> -    ch = dx;
>> -
>> +    ch = s->sunmouse_dx;
>>       if (ch > 127) {
>>           ch = 127;
>>       } else if (ch < -127) {
>>           ch = -127;
>>       }
>> -
>>       put_queue(s, ch & 0xff);
>> +    s->sunmouse_dx -= ch;
>> -    ch = -dy;
>> -
>> +    ch = s->sunmouse_dy;
>>       if (ch > 127) {
>>           ch = 127;
>>       } else if (ch < -127) {
>>           ch = -127;
>>       }
>> -
>>       put_queue(s, ch & 0xff);
>> +    s->sunmouse_dy -= ch;
>>       /* MSC protocol specifies two extra motion bytes */
>> -
>>       put_queue(s, 0);
>>       put_queue(s, 0);
>>   }
>> +static const QemuInputHandler sunmouse_handler = {
>> +    .name  = "QEMU Sun Mouse",
>> +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>> +    .event = sunmouse_handle_event,
>> +    .sync  = sunmouse_sync,
>> +};
>> +
>>   static void escc_init1(Object *obj)
>>   {
>>       ESCCState *s = ESCC(obj);
>> @@ -1036,8 +1080,8 @@ static void escc_realize(DeviceState *dev, Error **errp)
>>       }
>>       if (s->chn[0].type == escc_mouse) {
>> -        qemu_add_mouse_event_handler(sunmouse_event, &s->chn[0], 0,
>> -                                     "QEMU Sun Mouse");
>> +        s->chn[0].hs = qemu_input_handler_register((DeviceState *)(&s->chn[0]),
>> +                                                   &sunmouse_handler);
>>       }
>>       if (s->chn[1].type == escc_kbd) {
>>           s->chn[1].hs = qemu_input_handler_register((DeviceState *)(&s->chn[1]),
>> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
>> index 5669a5b811..8c4c6a7730 100644
>> --- a/include/hw/char/escc.h
>> +++ b/include/hw/char/escc.h
>> @@ -46,6 +46,9 @@ typedef struct ESCCChannelState {
>>       uint8_t rx, tx;
>>       QemuInputHandlerState *hs;
>>       char *sunkbd_layout;
>> +    int sunmouse_dx;
>> +    int sunmouse_dy;
>> +    int sunmouse_buttons;
>>   } ESCCChannelState;
>>   struct ESCCState {


ATB,

Mark.



