Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFA8E6FE49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 20:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smfvu-00012j-3o; Fri, 06 Sep 2024 16:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smfvp-00011i-UV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 16:51:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smfvo-00035g-9I
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 16:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Ib9Cpcv0xIU3Cpi//6Dt9gwM68B0pNcJA/cQblXtmpA=; b=dxST5BW6N9/QxyusFM+/eKD9Qc
 ZN9ZHJT9z+zZuJudmPneo3ZWf9wdC55WPuAspA5Rxi6nbp278J4ATsUGgQ7iI+xc9vaGW2VhELCrZ
 bw58lRnzl5/U9ax6ANy9ccuMeYf3cQ4pG3FbPhxrxbgx3ZJ44m+Al6hRh8lGaf3dAsL3rX/R4M3DH
 t/GTQ1IdqEvWYieE3N/CoIeOnF4UMhhuiav9oyHS6I1FWjTJ6ogaKj4yCje58E3j/flMRzHrOHSmQ
 n2ZBraR1i6yS1L37Wh19Akopa/vkmSj26/hV/e2q7kCB/6oYS+YR6SSXpxbcOSaT0YGvhP0WAu5sJ
 dsCXMHVM8jukemg1mmDnLjxMKtSQRz3ZNiXgvgeOVrwo41pzIlv0wP70CqY4kosabyAvIfK+T1tcD
 n78aK5qYiuguOTNnXnec1eoBtlgnjyCvs0Vecc114j82mIZjDvBzTJ549spYDmhjm3S9ZPvZouK/7
 9i6DVQf/h+POO4qogzwJxxDrAsAiNLxXWXFfFyjerfMP6nQQqwpHTUiztdQX6APyBCpM2oblGYL2g
 i+LcSIMgWVQRGQDFJmfKq1vT4NkHX5iLC0v8qhTPKZA1cYidsg3Ti2nvX7HGlUuIkMeWzSNYy6zT3
 vObZywzX7/XhP/ipYFNqC59mfTy9xNlLYfOH9tX9s=;
Received: from [2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1smfvf-000BQE-Nj; Fri, 06 Sep 2024 21:51:43 +0100
Message-ID: <beb00701-7ad4-4575-87ec-ae641c4a07b1@ilande.co.uk>
Date: Fri, 6 Sep 2024 21:51:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair.Francis@wdc.com, tavip@google.com, qemu-devel@nongnu.org
References: <20240828122258.928947-1-mark.cave-ayland@ilande.co.uk>
 <c9fb3811-fb75-44fd-a177-7ed67d43d55a@linaro.org>
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
In-Reply-To: <c9fb3811-fb75-44fd-a177-7ed67d43d55a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:1400:c2c8:7829:48cd:7400
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 0/9] fifo8: add fifo8_peek(), fifo8_peek_buf() and tests
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

On 06/09/2024 14:14, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 28/8/24 14:22, Mark Cave-Ayland wrote:
> 
>> Mark Cave-Ayland (9):
>>    fifo8: rename fifo8_peekpop_buf() to fifo8_peekpop_bufptr()
>>    fifo8: introduce head variable for fifo8_peekpop_bufptr()
>>    fifo8: add skip parameter to fifo8_peekpop_bufptr()
>>    fifo8: replace fifo8_pop_bufptr() with fifo8_peekpop_bufptr() in
>>      fifo8_pop_buf()
>>    fifo8: rename fifo8_pop_buf() to fifo8_peekpop_buf()
>>    fifo8: honour do_pop argument in fifo8_peekpop_buf()
>>    fifo8: add fifo8_peek_buf() function
>>    fifo8: introduce fifo8_peek() function
>>    tests/unit: add test-fifo unit test
> 
> For this series:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I'm OK to queue it but took some notes while reviewing:
> https://lore.kernel.org/qemu-devel/20240906131217.78159-1-philmd@linaro.org/
> If you can have a look, I'll queue both together.

Thanks Phil!

I've just spotted a few minor issues with the series which I've just replied to: 
would you like me to send a v2, or is it easier just for you to correct them yourself?


ATB,

Mark.


