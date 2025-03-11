Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3E3C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1truqd-00045V-AU; Tue, 11 Mar 2025 04:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1truqZ-00044h-B7
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:20:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1truqW-0001lc-Os
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:20:19 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so11259105e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 01:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741681214; x=1742286014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dKpI07T4/YTgz2s/hDdMabe9A+22Lp9DW33+N6JzTKs=;
 b=Vno5EbYbk/BbgrK7StOKb915xDghwJWl2wjxBspAUMNcPCh5uBvm+RvlNR6TlIQQ6U
 jrAUmMn+WrlQ3LRoVF2cnQlBxauxUpINLtojzuLmuH6b4pwR/mQkaZqXR8ZFLaSi7ZrP
 t4QGICPQginIt7a6S1BZsfZBdbwa6DKM7RXTCQeVrzfcUq46fgHutNAftUQNZHrITnPx
 3SdArS86cKJw8mbH3x9GJUxtrAbBkSCo+0OamNhgNzmKs7JL7g77DJed8IRQt/uHhvh5
 vot/CT9jgXI8jJTOtgdd7BTuh39GS/jJXMXeHS7whp6yfge7pZMJH4AS5hfqojjJW9EQ
 1Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741681214; x=1742286014;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dKpI07T4/YTgz2s/hDdMabe9A+22Lp9DW33+N6JzTKs=;
 b=oow7aPK5e9OudpleRs4GUzq8EpsaZOMwwedzTzLiDYb8AxyjBuGgf5HYqGbUelg/4t
 XQXF7AVFl2CUhFFVh5HqZLsdmTbEhuhu1lSYcanB/Z9FI+ElWKYtNKHcBlnzpNdRQCPX
 a4Ftn0q5Q0glYGRYSZf0uaVEmetYysvWrpfdam6PsguO1+hYc070+PXFHm8JJAJ691z3
 9KWL6L+sVamtWkdyggQdNtyHdRuM9turR9XLtHPdyilipUnxeuMQEtEtdoOcoT3frxFW
 ZXDa0nNeO+CzAuYt/DRAOIpUGc4XT9V1td2oa/zS97SIkBOCZv00a3ruxLNVBRYivBk5
 qArw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3KuaT2oluUZs12eNam8abujhj28tNWTDzC6k3bow93tDninFb82QTeagFLcNkxxB+VUg6NqFdiZGj@nongnu.org
X-Gm-Message-State: AOJu0Yx9l7UYufulij0uhMBG1Gw5w7Y4ulqYENoZk9JWJUoqoeJUgcGC
 VuflyI0KbymxKvNTuNPJFxMDGOWuVrBcGXQHYP2IP3jvPb410D84sNS0yhkDqRfrrfyAPTS8AD9
 3Dew=
X-Gm-Gg: ASbGncv92tGokFBrDUsgCuZgqWQvLtilDPxTbm83v0Ie/jm8qDm4M/fkZhni+Sq+sR3
 dmfpthlBC/DGfKWmHeoIs1JeeLpjXnZl04kiD9gNNZ1Mx4jrzVrCo0oxPO8wVWCnwhdJfALlpP/
 Nf/RqQLoLk92Gdq/lEP11EfxOtMYRI27lpPqpXsEjj+IPhqt6Jf0QOSk62PatX2gSFfSYuQQRbq
 u1Qj5RtpsjiYZmNn32e8ZdzRJq7lpw6+z/l0Sj1VOAAc3aFNUgDkJ5X/qMyT2mdwKH9R5isDi9o
 WOMm0R8mbiJT6N4WM39tHmfn6VaKCQPI4EDmJj3Lkaq07HGN0+z60eZTB4T3glRyACCbebPEQNS
 LcbbH6cz9tagd
X-Google-Smtp-Source: AGHT+IEGhNoS0lbVD7RBoeqQo8m5k67NpFC5Qvm5Q111LwcfOkqva4K/rEt1W8I48/HCzGBPpQjTJQ==
X-Received: by 2002:a05:600c:1c22:b0:439:8634:9909 with SMTP id
 5b1f17b1804b1-43d01d50313mr30915695e9.14.1741681214471; 
 Tue, 11 Mar 2025 01:20:14 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce3d5a0e2sm119808045e9.12.2025.03.11.01.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 01:20:13 -0700 (PDT)
Message-ID: <47b847a2-0547-49cb-9291-20c25c3f4376@linaro.org>
Date: Tue, 11 Mar 2025 09:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] hw/net/smc91c111: Sanitize packet length on tx
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Jason Wang <jasowang@redhat.com>
References: <20250228174802.1945417-1-peter.maydell@linaro.org>
 <20250228174802.1945417-3-peter.maydell@linaro.org>
 <f4262519-017d-4ed7-8c17-5d4d72a219a6@linaro.org>
 <CAFEAcA9vw-Qgt4MBd=g-RTC1joHsHYBmtASHpL=SBnBjoW0nWA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9vw-Qgt4MBd=g-RTC1joHsHYBmtASHpL=SBnBjoW0nWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/3/25 12:06, Peter Maydell wrote:
> On Sun, 9 Mar 2025 at 19:01, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>> On 28/2/25 18:48, Peter Maydell wrote:
>>> --- a/hw/net/smc91c111.c
>>> +++ b/hw/net/smc91c111.c
>>> @@ -22,6 +22,13 @@
>>>
>>>    /* Number of 2k memory pages available.  */
>>>    #define NUM_PACKETS 4
>>> +/*
>>> + * Maximum size of a data frame, including the leading status word
>>> + * and byte count fields and the trailing CRC, last data byte
>>> + * and control byte (per figure 8-1 in the Microchip Technology
>>
>> If control byte is included, ...
>>
>>> + * LAN91C111 datasheet).
>>> + */
>>> +#define MAX_PACKET_SIZE 2048
>>>
>>>    #define TYPE_SMC91C111 "smc91c111"
>>>    OBJECT_DECLARE_SIMPLE_TYPE(smc91c111_state, SMC91C111)
>>> @@ -240,6 +247,16 @@ static void smc91c111_release_packet(smc91c111_state *s, int packet)
>>>        smc91c111_flush_queued_packets(s);
>>>    }
>>>
>>> +static void smc91c111_complete_tx_packet(smc91c111_state *s, int packetnum)
>>> +{
>>> +    if (s->ctr & CTR_AUTO_RELEASE) {
>>> +        /* Race?  */
>>> +        smc91c111_release_packet(s, packetnum);
>>> +    } else if (s->tx_fifo_done_len < NUM_PACKETS) {
>>> +        s->tx_fifo_done[s->tx_fifo_done_len++] = packetnum;
>>> +    }
>>> +}
>>> +
>>>    /* Flush the TX FIFO.  */
>>>    static void smc91c111_do_tx(smc91c111_state *s)
>>>    {
>>> @@ -263,6 +280,17 @@ static void smc91c111_do_tx(smc91c111_state *s)
>>>            *(p++) = 0x40;
>>>            len = *(p++);
>>>            len |= ((int)*(p++)) << 8;
>>> +        if (len >= MAX_PACKET_SIZE) {
>>
>> isn't MAX_PACKET_SIZE valid? I'm not sure at all but I'd expect:
>>
>>              if (len > MAX_PACKET_SIZE) {
> 
> Yes, thanks, good catch. The max value in the byte count
> field is 2048. We subtract 6, and then look at p[len + 1],
> which will be p[2048 - 6 + 1] = p[2043], where the value of
> p is data+4 (because we incremented it 4 times as we dealt
> with the status and byte count fields).
> So p[2043] is data[2047], which is the last in-bounds byte,
> and a byte-count field of 2048 is not an overrun.

OK, so using '>':
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> (Also, I just noticed that the data sheet says that for tx
> frames the transmit byte count least significant bit will be
> assumed 0 by the controller regardless of the value written
> in memory. So we ought to zero out the LSB of 'len' after we
> read it from the packet. That's not an overflow, though
> (since we already subtracted 6 from len), just a bug...
> Plus it looks like we don't handle the case of "odd-length
> frame and CRC field present" right, since we don't do anything
> about the last-data-byte being behind the CRC field. I think
> that given the unimportance of this device model I'll settle
> for just fixing the overruns and leave these other nominal
> bugs alone.)

While agreeing it is not worth fixing ASAP, a patch adding a pair
of comments with your findings could save time to future contributors
and not make your analysis in vain :)

Regards,

Phil.

