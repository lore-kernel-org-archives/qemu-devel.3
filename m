Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9E9C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 22:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW1Rz-0008Rs-5k; Mon, 22 Jul 2024 18:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sW1Rs-0008Qi-4N; Mon, 22 Jul 2024 18:24:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sW1Rp-00039x-9y; Mon, 22 Jul 2024 18:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=spjUBKFS6QaWhZsVpAytuVz/tRWNcLBDro2q2YDUItc=; b=GuxpFaHMS1Er3WCNJ4P3s6Yptm
 1Apf11XJwHppfMj6Wz/25Adcf0MkBEdIAsR02/VoXz0J5y2UcAIrrCsV8QbKrGRATHt3iUlbcFHT/
 fCZ8HKclqAOdJYfF16VL6oNo00SsaUTj8FhLYu/lU09GkySop3XvylZH3DgbxOShx2Zxo8waNlVjz
 GlIYsasMrjL+XXQZOzUv1/wp+qFKIgrnQda4gkGI9/dsDzrIDI87YAcuRP5I4YJuqlvzSohfebF9S
 6Z5ISADcHSuKLR6yGtPBE8b6ZWJ879h67/Ec+wrYDa3vWgPrWQieUtNBTzBgwJTLkf1TkSgW2SJCE
 Pty5gDcyrwRuxL4obVN1B01bhSTSfzBWLQnJNXqXf8+eCDnMsgBA9qJuyOKqW0PQ7mKSemnSQjYeY
 iNuDHz4X/HmO1mYY7aKskFQNS+LW7q5wm2zgfslK5Z5w7dDGCOZ8/s5EXJqlxwDfqXD7VyIa7qDUf
 P69O4UsTAjWm9hCWh4QqGsqaGCJ8Ow8ayo55XiQHWJziAcvzH/Iq6/zthXAXvb4lwVm3wya95jizn
 aNYWn5bSiuVDXMob9IUufyuiObhTDQGO8LwDPKJa5gxzLa8oC5tA4l3WWHfQWwI0XYzevmd9gcnz6
 JesO7n2haOmHERrgun4AZjm4H94wBt4I9cPioucgo=;
Received: from [2a00:23c4:8bb4:4000:c7ab:2566:bad6:7dfd]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sW1QD-0003kj-Gq; Mon, 22 Jul 2024 23:22:25 +0100
Message-ID: <d5ada7c0-eac8-483c-901d-172fd16a2c4b@ilande.co.uk>
Date: Mon, 22 Jul 2024 23:23:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-7-philmd@linaro.org>
 <7e222b69-49e6-4d0c-9b44-45c42e18cfb2@ilande.co.uk>
 <8fcc1b96-3b8e-4d5e-9154-3abf9b6f730b@linaro.org>
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
In-Reply-To: <8fcc1b96-3b8e-4d5e-9154-3abf9b6f730b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:c7ab:2566:bad6:7dfd
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 6/7] util/fifo8: Expose fifo8_pop_buf()
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

On 22/07/2024 22:39, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> On 22/7/24 23:26, Mark Cave-Ayland wrote:
>> On 22/07/2024 17:07, Philippe Mathieu-Daudé wrote:
>>
>>> Extract fifo8_pop_buf() from hw/scsi/esp.c and expose
>>> it as part of the <qemu/fifo8.h> API. This function takes
>>> care of non-contiguous (wrapped) FIFO buffer (which is an
>>> implementation detail).
>>
>> I wonder if it is also worth updating the comment for fifo8_pop_bufptr() indicating 
>> that it returns a pointer to the internal buffer without checking for overflow,
> 
> We document:
> 
>   * The function may return fewer bytes than requested when the data wraps
>   * around in the ring buffer; in this case only a contiguous part of the data
>   * is returned.
> 
> but I'll try to reword a bit.
> 
>> and that in general fifo8_pop_buf() is recommended instead?
> 
> Yes, this was my first motivation but then I forgot to write it :)
> 
> BTW I now see fifo8_pop/peek_bufptr() as dangerous API and am thinking
> of deprecating them (after release). AFAICT the difference is a pair of
> memcpy(), when I expect to not be that important performance wise.

Funny - I had exactly the same thought ;)

>> Otherwise:
>>
>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Thanks!
> 
> BTW I'll respin this series including the fifo8_peek_buf() patch that
> I forgot and is the one I need in PL011. Preview:
> 
> +uint32_t fifo8_peek_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
> +{
> +    uint32_t tail_count, head_count = 0;
> +
> +    if (destlen == 0) {
> +        return 0;
> +    }
> +
> +    destlen = MIN(destlen, fifo->num);
> +    tail_count = MIN(fifo->capacity - fifo->head, destlen);
> +
> +    if (dest) {
> +        memcpy(dest, &fifo->data[fifo->head], tail_count);
> +    }
> +
> +    /* Add FIFO wraparound if needed */
> +    destlen -= tail_count;
> +    head_count = MIN(destlen, fifo->head);
> +    if (head_count && dest) {
> +        memcpy(&dest[tail_count], &fifo->data[0], head_count);
> +    }
> +
> +    return tail_count + head_count;
> +}

Looks good at first glance, although it's getting late here now. If you're looking at 
making a few more changes before a respin, is it worth considering to add a new file 
with qtests for the updated Fifo8 implementation?


ATB,

Mark.


