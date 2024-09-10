Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CB0EDE9B4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7b1-0005RF-E2; Tue, 10 Sep 2024 16:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7az-0005Je-IY; Tue, 10 Sep 2024 16:36:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7ay-00063M-2Z; Tue, 10 Sep 2024 16:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=rHPU5Vq9nPBdOoY3mU4h8fd7v4tO5muhpotBhNjuw7A=; b=nL9p1iV39Zut2mIlc4pC4qDfth
 S/RmnijoevgCyJmg0RZNyzco5rtDkRRHnyO287Co1fo6rVs5yGJGD+5Td8j1xbCuiciQbqdANiany
 +KoxQmdKh4uzcDmsL8o02yXxCs2BUFz5oyrHrNO2AXWqsaWu22tusus+d0VNb3tJxveZL4uUScw0N
 PQLytZdkcD7i8UKJpi7SP7dso9av6dFpOSfbgBbeY8ITx5ZTHnvO2LstMSOlSgW81vgIpwraAbkcY
 mnwjcmLa1+ylFFgS6PtXUXFS/llGDfBXzdm3Mv/ASthMdn4qLw86DW/Hx4kLssyq4FOiVWgZV4aks
 htPpNEb4EuX28ZnB3OQa0Zv2eB37xrezFgUDUY+FB822gFis6wox+Yt9AjApvJvAkrkVgah95ORyb
 /hweI8xUS/wVjsJqf8jptbadQZcB5IYRWIkaIvLtiSDAA5oiBob1QACKmjsjmwr7iO/GRf/aUCIcz
 ukYvkWCTBOeo/2ksaktoUQfqHyJkB5P783EI0Jo6UBh9CLrm+72aaHPjb3qmltBer0FhZ8C+2Rd+b
 LXnZeVIMYg52rQeqQhQ1BUPqpV2GyoMBLdrHj1ePhaMxqBtjZRKOvc6XHEIcLQm9UGReWw3iyIoPK
 9npcEksrxaV1hyZFSQS17CBX6AbSq/n8yyAC739Y0=;
Received: from [2a00:23c4:8bb8:1400:b001:a616:651c:c1d5]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1so7ar-0000rp-Em; Tue, 10 Sep 2024 21:36:13 +0100
Message-ID: <5a28f05c-c90c-419e-9d23-8c3a3e6fcf72@ilande.co.uk>
Date: Tue, 10 Sep 2024 21:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, hsp.cat7@gmail.com
References: <20240907173700.348818-1-mark.cave-ayland@ilande.co.uk>
 <970cfa94-c8e8-4fa5-96a7-45b964e4bef3@linaro.org>
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
In-Reply-To: <970cfa94-c8e8-4fa5-96a7-45b964e4bef3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:b001:a616:651c:c1d5
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] adb-mouse: convert to use QemuInputHandler
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

On 10/09/2024 15:48, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 7/9/24 19:37, Mark Cave-Ayland wrote:
>> Update the ADB mouse implementation to use QemuInputHandler instead of the
>> legacy qemu_add_mouse_event_handler() function.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/input/adb-mouse.c | 56 ++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 46 insertions(+), 10 deletions(-)
>>
>> v2:
>> - Rebase onto master
>>
>> - Replace (DeviceState *)s with dev in adb_mouse_realize() as suggested by
>>    Phil
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +static const QemuInputHandler adb_mouse_handler = {
>> +    .name  = "QEMU ADB Mouse",
>> +    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>> +    .event = adb_mouse_handle_event,
>> +};
> 
> Do you mind if you amend your comment from v1 for clarity?
> I could squash the following and take in my next PR:
> 
> diff --git a/hw/input/adb-mouse.c b/hw/input/adb-mouse.c
> index c0e0282fee..15e6e91804 100644
> --- a/hw/input/adb-mouse.c
> +++ b/hw/input/adb-mouse.c
> @@ -97,6 +97,11 @@ static const QemuInputHandler adb_mouse_handler = {
>       .name  = "QEMU ADB Mouse",
>       .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
>       .event = adb_mouse_handle_event,
> +    /*
> +     * We do not need the .sync handler because unlike e.g. PS/2 where async
> +     * mouse events are sent over the serial port, an ADB mouse is constantly
> +     * polled by the host via the adb_mouse_poll() callback.
> +     */
>   };
> 
> Regards,
> 
> Phil.

Sure! If you think it is useful to an external set of eyes, then feel free to add it in.


ATB,

Mark.


