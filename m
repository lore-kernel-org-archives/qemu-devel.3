Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9110D1CA08
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85qe-0007z3-RB; Mon, 04 Nov 2024 17:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t85qd-0007yp-FE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:46:59 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t85qb-0006TI-F9
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=b9c/M7uP/2tSB3/e3APFPBj4w1JHgGll1rYEuMcrRt0=; b=b1RxlkEs2KCIfFtoWPiggwJ97y
 +sTe/hGCjMbxuCn95JvVca6WDiWoAoXYZhP3a80PBjpHwTpRYzrTALze/ikY0tzjfAnVi0RY/dAtl
 MsM3neyoOW4yLimqt5qNbnW1BxEEhBQEDFL3lhAzmWHeguK1cXNcuArxFpnYc3Rp98zKozZ/2ZrRK
 P8vRT7UL0QNQQids3EF7Emf9cohSS7HBCwLLaqbF8CaJWS2CEos4dnEM6oTmmYYK3A5rsRyxQ7YCR
 sNUBA0ZeJEM58ch9bbGI2c+889XMfOEMVdBaUUEQG5KWG6Mv+fQSpkBKXyuPd2mM2ExnjuPrnv6Sa
 QgPA8aPA1xZA7k1SY5cF3tCjqj4HAV00a6kKdu5U6OsgiGceLB8TkrdPGlshwG4PnidFGLneAyGU1
 EBHGVt9n6DsoLHNavNvZzepyVpLyx+aU9H6PcVpu6HUWX9st9YhIZpWkTsX/OwkXPVWpyfHRZ9F32
 9yLB/hSaQG/2BMVpk+LWsJsszjosn8OYRw04wBtkpzc53QhF44AAWn6653W/S4QaxAIRrqn1toOPH
 DQ4NcXoFe7IiLAj4wRJAdIAlXYqvLa1PGEXZ/J21XUxPLuEVHfvsU9fWR1DTkRSZzaL8v0OM7C5ih
 gMR+w8hC97gE9c+rx/kTCIraSl60FssfQKcfWwpoE=;
Received: from [2a00:23c4:8bb8:f600:b478:1422:fb0f:30d5]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t85q8-00041e-76; Mon, 04 Nov 2024 22:46:32 +0000
Message-ID: <7708dea9-32b3-4ced-9fdd-de0c1a5aca85@ilande.co.uk>
Date: Mon, 4 Nov 2024 22:46:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, huth@tuxfamily.org, qemu-devel@nongnu.org
References: <20241101201106.1432336-1-mark.cave-ayland@ilande.co.uk>
 <20241101201106.1432336-2-mark.cave-ayland@ilande.co.uk>
 <ZyicQT4eKlN07AHz@redhat.com>
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
In-Reply-To: <ZyicQT4eKlN07AHz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:b478:1422:fb0f:30d5
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 1/2] next-kbd: convert to use
 qemu_input_handler_register()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/11/2024 10:04, Daniel P. Berrangé wrote:

> On Fri, Nov 01, 2024 at 08:11:05PM +0000, Mark Cave-Ayland wrote:
>> Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handler()
>> function to use qemu_input_handler_register().
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/m68k/next-kbd.c | 166 ++++++++++++++++++++++++++++++---------------
>>   1 file changed, 111 insertions(+), 55 deletions(-)
>>
>> diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
>> index bc67810f31..283e98e9eb 100644
>> --- a/hw/m68k/next-kbd.c
>> +++ b/hw/m68k/next-kbd.c
> 
> 
>> -static const unsigned char next_keycodes[128] = {
>> -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
>> -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
>> -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
>> -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
>> -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
>> -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
>> -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
>> -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
> 
> The original code used '0' (or equivalently 0x00) to
> indicate an unmapped scancode.
> 
>> +#define NEXTKBD_NO_KEY 0xff
> 
> Now you're using 0xff for missing mappings, but....
> 
>> +
>> +static const int qcode_to_nextkbd_keycode[] = {
>> +    /* Make sure future additions are automatically set to NEXTKBD_NO_KEY */
>> +    [0 ... Q_KEY_CODE__MAX]    = NEXTKBD_NO_KEY,
>> +
>> +    [Q_KEY_CODE_ESC]           = 0x49,
>> +    [Q_KEY_CODE_1]             = 0x4a,
>> +    [Q_KEY_CODE_2]             = 0x4b,
>> +    [Q_KEY_CODE_3]             = 0x4c,
>> +    [Q_KEY_CODE_4]             = 0x4d,
>> +    [Q_KEY_CODE_5]             = 0x50,
>> +    [Q_KEY_CODE_6]             = 0x4f,
>> +    [Q_KEY_CODE_7]             = 0x4e,
>> +    [Q_KEY_CODE_8]             = 0x1e,
>> +    [Q_KEY_CODE_9]             = 0x1f,
>> +    [Q_KEY_CODE_0]             = 0x20,
>> +    [Q_KEY_CODE_MINUS]         = 0x1d,
>> +    [Q_KEY_CODE_EQUAL]         = 0x1c,
>> +    [Q_KEY_CODE_BACKSPACE]     = 0x1b,
>> +    [Q_KEY_CODE_TAB]           = 0x00,
> 
> ...you've left 0x00 here and....

Ooops yes that line can be removed.

>> +    [Q_KEY_CODE_Q]             = 0x42,
>> +    [Q_KEY_CODE_W]             = 0x43,
>> +    [Q_KEY_CODE_E]             = 0x44,
>> +    [Q_KEY_CODE_R]             = 0x45,
>> +    [Q_KEY_CODE_T]             = 0x48,
>> +    [Q_KEY_CODE_Y]             = 0x47,
>> +    [Q_KEY_CODE_U]             = 0x46,
>> +    [Q_KEY_CODE_I]             = 0x06,
>> +    [Q_KEY_CODE_O]             = 0x07,
>> +    [Q_KEY_CODE_P]             = 0x08,
>> +    [Q_KEY_CODE_RET]           = 0x2a,
>> +    [Q_KEY_CODE_A]             = 0x39,
>> +    [Q_KEY_CODE_S]             = 0x3a,
>> +
>> +    [Q_KEY_CODE_D]             = 0x3b,
>> +    [Q_KEY_CODE_F]             = 0x3c,
>> +    [Q_KEY_CODE_G]             = 0x3d,
>> +    [Q_KEY_CODE_H]             = 0x40,
>> +    [Q_KEY_CODE_J]             = 0x3f,
>> +    [Q_KEY_CODE_K]             = 0x3e,
>> +    [Q_KEY_CODE_L]             = 0x2d,
>> +    [Q_KEY_CODE_SEMICOLON]     = 0x2c,
>> +    [Q_KEY_CODE_APOSTROPHE]    = 0x2b,
>> +    [Q_KEY_CODE_GRAVE_ACCENT]  = 0x26,
>> +    [Q_KEY_CODE_SHIFT]         = 0x00,

This should be kept.

>> +    [Q_KEY_CODE_BACKSLASH]     = 0x00,
> 
> ...here, and ...

Indeed, that line can also be removed.

>> +    [Q_KEY_CODE_Z]             = 0x31,
>> +    [Q_KEY_CODE_X]             = 0x32,
>> +    [Q_KEY_CODE_C]             = 0x33,
>> +    [Q_KEY_CODE_V]             = 0x34,
>> +
>> +    [Q_KEY_CODE_B]             = 0x35,
>> +    [Q_KEY_CODE_N]             = 0x37,
>> +    [Q_KEY_CODE_M]             = 0x36,
>> +    [Q_KEY_CODE_COMMA]         = 0x2e,
>> +    [Q_KEY_CODE_DOT]           = 0x2f,
>> +    [Q_KEY_CODE_SLASH]         = 0x30,
>> +    [Q_KEY_CODE_SHIFT_R]       = 0x00,
> 
> ...here, which is surely not a correct conversion

And this one should also be kept.

The reason the two shift keys need to be kept as zero is so that they pass the "if 
(keycode == NEXTKBD_NO_KEY) { return; }" check in nextkbd_event().

>> +
>> +    [Q_KEY_CODE_SPC]           = 0x38,
>>   };
> 
> 
> Those missing mappings definitely have values too.
> 
> I can see the 'shift' and 'tab' keys on the real Next
> keyboard I have in front of me right now :-)

That's proof enough for me ;)

> Finding a reliable reference for the NeXT scancodes is very hard
> in my googling so far. The best I've come across so far is
> 
> https://github.com/spenczar/usb-next/blob/main/keymap.h
> 
> who has defined a mapping to USB HID codes, which seems to
> broadly match what's above here, plus has many of the gaps
> fixed.
> 
> Do you know of any other decent references for scancodes ?
> 
> I'm going to see about adding NeXT scancodes to the giant
> database of keycodes at:
> 
>    https://gitlab.com/keycodemap/keycodemapdb
> 
> then we can auto-generate this table as we do for most of
> the other QEMU keyboard drivers.

That would be great! Is this also possible for the ADB keyboard device, since that is 
where I looked for inspiration when looking at next-kbd?


ATB,

Mark.


