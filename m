Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D4DC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 14:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgmAI-0000Gc-CD; Wed, 21 Aug 2024 10:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sgmAG-0000Fp-JG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:18:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sgmAD-00038c-Kp
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 10:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=gjnVEMO/wBkblHaXstP9UZuItkqd/jedGDseBHtWJq8=; b=rQyJTK1dqSeby/O/Zy+NDe2MbV
 lJ58QNYGRgrjzAzEUnx0ASTOoOHeUVfcRkbhdiVvRvAQ9z2Ojca03fTvxbbSy7lKoVUwYPi1F4Krm
 SMJ3bo3eHllLy68GgO/8sBDoEzVd3u51uv1rYrkMVwqQAL9hO9SNJYM5NHmFl7xo7ECjhxm1ycaaS
 oij2TE+wFSOx7ueGXTVVyLRFO2fXfS0NkaV3BDHZEvgiGI8wUXh7dYCDLIwcsm3/ROU1Xet5iI+7p
 6GBWu+HHp3YMfI1MsdtaRJqcEqjIXmCqvEpsADQDeb39K93nuX+7nZqxaebohhKtJzfFnxwOl/WWB
 4CAlBBEj/QzXMprce7mMFGBo5o5djbmi7+iRPf9dsqNer1LJKwQz4y2ESJ/y3cMehj+fNKYFOakvI
 HqyNOfvcsbxDm7TVQNQNrPVqsNHa3IklMtO/X8i26jZ2oyC9kiFXIWgu+6saZJT0GIO9gRdyiBtVr
 ggqo30rVqiNwbS/Tao4DE8uduVsj0o8YIfaNNnIqLaiDGIgjQ5VS8ETl7esBLjzNcA6ILr+qj5Kun
 eYKdhDc1y/Lq0sAeyfS758AvNjKWwBwmQpMnbfoicnY9Hn61juz8VQlWx84yEb3RVJe77rBqiobDf
 LT2Zwu8JA9PT9RsghqdqXJ4bI+eZqEi5U2N16wHGE=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sgm9p-000120-8h; Wed, 21 Aug 2024 15:17:57 +0100
Message-ID: <c7116b2f-9afd-4aa1-b553-7574efedf7a4@ilande.co.uk>
Date: Wed, 21 Aug 2024 15:18:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Richard Henderson <richard.henderson@linaro.org>,
 Carl Hauser <chauser@pullman.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <cb338cdc-d09d-4513-ba16-5ff3f792bbfe@pullman.com>
 <d8bbf72d-29e5-465b-a8aa-508ed2960631@linaro.org>
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
In-Reply-To: <d8bbf72d-29e5-465b-a8aa-508ed2960631@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/char: suppress sunmouse events with no changes
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

On 20/08/2024 08:34, Richard Henderson wrote:

> On 8/20/24 09:18, Carl Hauser wrote:
>> @@ -959,6 +960,15 @@ static void sunmouse_event(void *opaque,
>>       int ch;
>>
>>       trace_escc_sunmouse_event(dx, dy, buttons_state);
>> +
>> +    /* Don't send duplicate events without motion */
>> +    if (dx == 0 &&
>> +        dy == 0 &&
>> +        (s->sunmouse_prev_state ^ buttons_state) == 0) {
> 
> Were you intending to mask vs MOUSE_EVENT_*BUTTON?
> Otherwise this is just plain equality.
> 
>> diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
>> index 5669a5b811..bc5ba4f564 100644
>> --- a/include/hw/char/escc.h
>> +++ b/include/hw/char/escc.h
>> @@ -46,6 +46,7 @@ typedef struct ESCCChannelState {
>>       uint8_t rx, tx;
>>       QemuInputHandlerState *hs;
>>       char *sunkbd_layout;
>> +    int sunmouse_prev_state;
> 
> This adds new state that must be migrated.
> 
> While the patch is relatively simple, I do wonder if this code could be improved by 
> converting away from the legacy mouse interface to qemu_input_handler_register. 
> Especially if that might help avoid needing to add migration state that isn't 
> "really" part of the device.
> 
> Mark?

Ooof I didn't even realise that qemu_add_mouse_event_handler() was legacy - is that 
documented anywhere at all?

At first glance (e.g. 
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/input/ps2.c?ref_type=heads#L789) 
it appears that movement and button events are handled separately which I think would 
solve the problem.

I can try and put something together quickly for Carl to test and improve if that 
helps, although I'm quite tied up with client work and life in general right now(!).


ATB,

Mark.


