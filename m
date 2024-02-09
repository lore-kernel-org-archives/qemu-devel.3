Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0C2C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 22:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYw2-0000CC-9B; Fri, 09 Feb 2024 17:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYw0-0000Bc-C9; Fri, 09 Feb 2024 17:01:24 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYvy-0006Tv-OU; Fri, 09 Feb 2024 17:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9R2AErB0PAL9SVW2BLGJLgigb9DCeSm2WcQNZ2pUduA=; b=l5Ea9V3KGYac3Ar57FGthzpQfG
 Ct22wimDe0DkZAAftB1pwYqAYXWsKbs5W0Hp5i0KmzcOe2fgOd0eP2vKy1f6ReYz2aY1l/RjaiOnY
 SIzgqkYNplUHY4UKb+8E020IdBW6y1Krm5XaZCRYhUyLJY0hmssZvGpRbFkSGuhZjKLdJPY+g2qB/
 7t2TsmzyYNxAsW6htc1WvT2XXal4JRWWz5bCWBe36mjumLfInwxx/h+zUPWOJEll4SE+tLNiRsiYv
 BawN/6wLjdfW3nIWUfPLguPIOlVvq4XA60avjWBYUe99y7+St6IBbJIXbwRIV/l/oX3t0WhL6jo6X
 74rX8V0mb4svv0yLhOkZTmJ4MdrENOTtfKefCE0vDpIbHmDurjUDgv3dJZ2WUISrWcFDnGqRkHQ/Q
 Ac9RflETigavE6fzqbSYwL1Bu8z0PuL3uyQkWi+8LnGOm1kXt3mv3MJbqVj1IR/WMg+2uiY3gHIDX
 CoPW00Us0A7HQEkDet16EEThZ4toZSjvMV4DS5tIiuE1OhsI/M2x+wszivQM2NU6vhD9vVtqJxJcV
 ajMvXWdt102GLlc2ZrbnIYxz/QL4B/TwmwC0Ei2MS51vKFT9b3RFdmvS97ruu9u+63gpKSXlug4ss
 weVzr/KONiHgibZWXG9q2QJqGSmoWgrSoq7j3JX1k=;
Received: from [2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rYYvE-0002ed-7V; Fri, 09 Feb 2024 22:00:40 +0000
Message-ID: <63c7c694-ab39-40f0-bda7-96edc70ca87c@ilande.co.uk>
Date: Fri, 9 Feb 2024 22:01:13 +0000
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
 <20240208181245.96617-12-philmd@linaro.org>
 <CAFEAcA8XF4i7qNWRAO2PjiNxecLY8qfGzYK-ZDE8fvy7mpf-4Q@mail.gmail.com>
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
In-Reply-To: <CAFEAcA8XF4i7qNWRAO2PjiNxecLY8qfGzYK-ZDE8fvy7mpf-4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:1032:5a09:fd17:2b9e
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 11/11] hw/sparc64/cpu: Initialize GPIO before realizing
 CPU devices
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

On 09/02/2024 11:34, Peter Maydell wrote:

> On Thu, 8 Feb 2024 at 18:14, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Inline cpu_create() in order to call
>> qdev_init_gpio_in_named_with_opaque()
>> before the CPU is realized.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/sparc64/sparc64.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/sparc64/sparc64.c b/hw/sparc64/sparc64.c
>> index 72f0849f50..3091cde586 100644
>> --- a/hw/sparc64/sparc64.c
>> +++ b/hw/sparc64/sparc64.c
>> @@ -24,6 +24,7 @@
>>
>>
>>   #include "qemu/osdep.h"
>> +#include "qapi/error.h"
>>   #include "cpu.h"
>>   #include "hw/boards.h"
>>   #include "hw/sparc/sparc64.h"
>> @@ -271,9 +272,10 @@ SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr)
>>       uint32_t  stick_frequency = 100 * 1000000;
>>       uint32_t hstick_frequency = 100 * 1000000;
>>
>> -    cpu = SPARC_CPU(cpu_create(cpu_type));
>> +    cpu = SPARC_CPU(object_new(cpu_type));
>>       qdev_init_gpio_in_named(DEVICE(cpu), sparc64_cpu_set_ivec_irq,
>>                               "ivec-irq", IVEC_MAX);
>> +    qdev_realize(DEVICE(cpu), NULL, &error_fatal);
>>       env = &cpu->env;
>>
>>       env->tick = cpu_timer_create("tick", cpu, tick_irq,
>> --
>> 2.41.0
> 
> For the purposes of letting us enforce the "init GPIOs
> before realize, not after" rule,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> but it looks like this code is adding a GPIO to a
> device from code that's not actually part of the
> implementation of the device. Ideally most of the code in
> this file should be rolled into the CPU itself in target/sparc.

I suspect the reason the code is arranged like this is because IVECs aren't part of 
the core SPARC 64-bit architecture specification, although they happen to be 
implemented by the CPUs used by QEMU. Perhaps this would be better be handled on a 
CPU model basis, but I agree this shouldn't be a blocker for this patch.


ATB,

Mark.


