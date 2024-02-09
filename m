Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98D2C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 22:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYZVK-0001t5-0J; Fri, 09 Feb 2024 17:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYZVJ-0001pQ-2p; Fri, 09 Feb 2024 17:37:53 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYZVH-00043O-F4; Fri, 09 Feb 2024 17:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tigSGu/wgTVgD4X4CW68jpuiSHBbbaXWRlSzbEV0Dmw=; b=mYcA5InUVPkhR0JWIuJpBkRBUD
 qgeWUxrKil7bH1WyTuoQEbqmP0DFSaVm+7qghJyJsLKLDxUQVAwdrd3u+8y+XuM3VtvEVKemTYA9Q
 MHtsfLpOLsglEQ3XGdupW5BL4Dq+hV0cLcac6U2zP8MAv9ub2vXJ/paCNyofcj+rbc8NBwVTROkT9
 gxj6JHQE8qqZkVd4BSwTvEAlg5wfW3mbi3K37Jdk5cBzonfcs3wEgKrJC2YXj7b6f4/YiA3YW2fV1
 xwOSauCP6AfjrRq3ItD4plzBZV2mhiEdmoDSHJAQv9yby1WlYiUh0E7exJeDZAHgIdwK3jblBOCqV
 EtjYRmvl+e2HyASmPxDsKBaMZANxvE1OIJkpTRFy5Vbm5TGq5aRNxan+T2ncYIRWyilP0zy4N3o5v
 pEY5+J+iea+jNcFZNUuMI8jcsb5QN2WD5gA0WVFhhYy48gqZKNrWzy5dJmY8qUDcZDHrwTj2YPL5w
 cjEEh8Khi2bqzK4RXYWvWEMajwRyYIJ8RsmtwMadnvUuAgmKvpJCQMP6Ea/QhX+SMpm50306xXSxb
 IqExXx/UKI5sGMWrkJ8ek1YL7Scez6qgBEXkPKyAQvgpIBnkP6zaMaq17JoTPv7iT+Sghvi387/TR
 g2BloyxB8mQmoGT4y+84Er7jeyoWcPiyjr0xE0YHo=;
Received: from [2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYZUW-0002vA-E6; Fri, 09 Feb 2024 22:37:08 +0000
Message-ID: <6a23053f-5b88-400b-8a33-7b9cfc0b3c3e@ilande.co.uk>
Date: Fri, 9 Feb 2024 22:37:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-9-philmd@linaro.org>
 <CAFEAcA8uO_TV=oezQ4+Ha4yjoP3oB5EVNehWkfnqfRudh_gwYA@mail.gmail.com>
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
In-Reply-To: <CAFEAcA8uO_TV=oezQ4+Ha4yjoP3oB5EVNehWkfnqfRudh_gwYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 08/11] hw/sparc/sun4m: Realize DMA controller before
 accessing it
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

On 09/02/2024 11:37, Peter Maydell wrote:

> On Thu, 8 Feb 2024 at 18:14, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> We should not wire IRQs on unrealized device.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/sparc/sun4m.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
>> index e782c8ec7a..d52e6a7213 100644
>> --- a/hw/sparc/sun4m.c
>> +++ b/hw/sparc/sun4m.c
>> @@ -312,13 +312,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>>       dma = qdev_new(TYPE_SPARC32_DMA);
>>       espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
>>                                      OBJECT(dma), "espdma"));
>> -    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
>>
>>       esp = SYSBUS_ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
>>
>>       ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
>>                                    OBJECT(dma), "ledma"));
>> -    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
>>
>>       lance = SYSBUS_PCNET(object_resolve_path_component(
>>                            OBJECT(ledma), "lance"));
>> @@ -332,6 +330,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
>>       }
>>
>>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
>> +
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
>> +
>> +    sysbus_connect_irq(SYS_BUS_DEVICE(ledma), 0, ledma_irq);
>> +
> 
> (This confused me briefly until I realised that this function
> is reaching into the dma device to find child objects to connect
> the IRQs to. Perhaps it would be nicer if the wrapping 'dma' object
> passed through those IRQs to avoid that.)

FWIW I can't say I'm a fan of passing through IRQs for container devices that contain 
one or more child devices, since you end up with an extra layer of wiring complexity 
that can change depending upon the child device IRQ wiring. I find it much easier to 
access the child devices directly, since then the wiring is always consistent across 
all users.


ATB,

Mark.


