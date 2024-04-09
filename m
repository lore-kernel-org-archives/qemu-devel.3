Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3822DC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 12:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruAJ5-00029X-I6; Tue, 09 Apr 2024 08:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruAIy-00027Q-AL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 08:10:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruAIq-0008V3-9S
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 08:10:23 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41649860cecso17153285e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712664613; x=1713269413; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kgOnhYWhAteTH3NIEX7CxxxDND4+WUrherR9XVyjJn4=;
 b=xvj82heu2epidxmdaUV5EixYfhNld/whh+AFXeUMGWcBeFSX7JYIK/HBJl2VanCsbp
 EBZdZlAPZqbYr9dZVwOPE5bcqu18HLvZcm6heMal0MDxB5c4nqAh1CdVWTGaVlSsHuO2
 FqarfmQyLv0eg0W1B/SQztvD5289Mff4SvT0Qru9dkzdYfULGcEh/w9NvK3/M1gUlzw0
 NJ+nqdtMphhXl1/R6JZJ0HMfXi44Ig82ZuxoKYkdd3BabxFjQHSYGatX64xYWeJB88qk
 r3eC3CzLxnfnYaqY73qS4z/VafS7E3cRu9lPBkPvPJWkv0aUmYTKs3bLfGUPahIlIb1U
 OaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712664613; x=1713269413;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kgOnhYWhAteTH3NIEX7CxxxDND4+WUrherR9XVyjJn4=;
 b=FAG5N67SgyYRiH8IGTYiqU6XBMZmo+g6m+f7F00Yz+Tf2JlaWZeJsVzSsDeS/oNjUo
 7bCGNDqgV5mvCPUHim5Dnw2kMXEWzfkmGFtSukhqOoPFT/d5Mi6cf9f0vj4IX8JzUjyy
 O+E+i2Y/c6OoJf1RvHeQ6T4AMPyXgbITHRFpsgUKkDKLmJJv3ycBCMg/Eo84Mwe8ubZp
 7tDMsvKAhl/5jXmBAVMngJTeQK4eINJZutbuokUed3gYHjnpdQXl4/N2QffhcDP16HTv
 SpmqYsOstHvpzqScVKVYID3Xf97/eZXc3Ls0JqgQT36Xs/cHw0ayAMZnSbg0Dnp2CSp4
 L+4w==
X-Gm-Message-State: AOJu0Yz5EKHAOnGB8LMU1manIp9fIHeuBKk0KY2X1hdv4NuYjJyHSSYq
 yBnK4dNQCzzURbzYvoGUdMPjCZ3Z7wWEG+/Bjq/oOXOIjh/UNskasZgyVHBoB2k=
X-Google-Smtp-Source: AGHT+IEauiM2wB86KLepO0/K807x9tP5+qDRzN35AaIDzfX4wZxQbpGW1rDh/DL2lfN1ehXocTeYaQ==
X-Received: by 2002:a05:6000:e49:b0:343:41ef:ab30 with SMTP id
 dy9-20020a0560000e4900b0034341efab30mr8962398wrb.47.1712664612805; 
 Tue, 09 Apr 2024 05:10:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 f13-20020adfdb4d000000b00341c6b53358sm11302306wrj.66.2024.04.09.05.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 05:10:11 -0700 (PDT)
Message-ID: <224d9add-a2f3-41de-a50c-f2c14d991ef3@linaro.org>
Date: Tue, 9 Apr 2024 14:10:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 2/2] hw/net/lan9118: Fix overflow in TX FIFO
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 Chuhong Yuan <hslester96@gmail.com>
References: <20240408105149.59258-1-philmd@linaro.org>
 <20240408105149.59258-3-philmd@linaro.org>
 <CAFEAcA8vvURMn2FaDP9tXtP5eCMs6-XFOCR9ypo=WBH+6g5prw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8vvURMn2FaDP9tXtP5eCMs6-XFOCR9ypo=WBH+6g5prw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 8/4/24 16:24, Peter Maydell wrote:
> On Mon, 8 Apr 2024 at 11:52, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> When the TX FIFO is full, raise the TX Status FIFO Overflow (TXSO)
>> flag, "Generated when the TX Status FIFO overflows" [*].
> 
> This doesn't sound right. The TX Status FIFO and the
> TX Data FIFO are separate FIFOs, and the TX FIFO has its own
> overflow bit, TDFO. And I think the overflow here is of
> a third FIFO, the MIL's transmit FIFO...
> 
>> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
>> index 7be0430ac5..7a1367b0bb 100644
>> --- a/hw/net/lan9118.c
>> +++ b/hw/net/lan9118.c
>> @@ -795,8 +795,11 @@ static void tx_fifo_push(lan9118_state *s, uint32_t val)
>>               /* Documentation is somewhat unclear on the ordering of bytes
>>                  in FIFO words.  Empirical results show it to be little-endian.
>>                  */
>> -            /* TODO: FIFO overflow checking.  */
>>               while (n--) {
>> +                if (s->txp->len == PKT_SIZE) {
>> +                    s->int_sts |= TXSO_INT;
>> +                    break;
>> +                }
> 
> While I was looking at this bug, I realised that we have serious
> confusion about whether any of the variables we use to track FIFO
> size and FIFO usage are word counts or byte counts.
> 
> Looking at table 5-3 in the data sheet, the size of these
> FIFOs is actually software-configurable in the HW_CFG register,
> but we don't implement that and (attempt to) only provide
> the default configuration setting of TX_FIF_SZ == 5. That
> should mean:
>   TX data FIFO size == 4608 bytes == 1152 words
>   RX data FIFO size == 10560 bytes == 2640 words
>   TX status FIFO size == 512 bytes == 128 words
>   RX status FIFO size == 704 bytes == 176 words
> 
> But we don't consistently use either word or byte units for the
> variables we use to track FIFO size and FIFO usage. For instance:
>   * we initialise s->tx_fifo_size to 4608, which is a byte count
>   * we initialise s->rx_status_fifo_size to 704, which is a byte count...
>   * ...and then three lines later override that to 176, which is a word
>     count!
>   * we generally simply increment the various fifo_used fields
>     when we push a word into the FIFOs, implying word counts
>   * we mostly do calculations assuming word counts
>   * calculations of the RX_FIFO_INF and TX_FIFO_INF fields
>     (which report the used space in words and the free space
>     in bytes) are confused about units too
>   * the tx_status_fifo[] array is 512 words long and the bounds
>     checks assume 512 is a word count, but it is a byte count
>   * the rx_status_fifo[] array is 896 words long, but the worst
>     case RX status FIFO size is 896 bytes, even if we allowed
>     runtime adjustable FIFO sizes
>   * the rx_fifo[] array, on the other hand, is 3360 words long,
>     which really is the max possible size in words
> 
> Anyway, I think that txp->data[] is effectively modelling
> the "2K Byte transmit FIFO" within the MIL, not the TX FIFO.
> (We don't need to model the TX FIFO itself, because we don't
> do asynchronous sending of data packets: as soon as we've
> accumulated a complete packet into the MIL TX FIFO, we
> send it out. In real hardware the guest can put multiple
> packets into the TX data FIFO, which is why it makes sense to be
> able to configure a TX data FIFO size larger than the largest
> possible packet and larger than the MIL TX FIFO.)
> 
> So the limit that we are enforcing here is similar to the one
> described in the "Calculating Worst-Case TX FIFO (MIL) usage",
> except that we don't actually use data space for the gaps
> caused by unaligned buffers. So this can only overflow if the
> packet is greater than what the data sheet says is the
> maximum size of 1514 bytes. The datasheet unfortunately doesn't
> describe the behaviour if this maximum is exceeded, and our
> current code doesn't try to check it (it's in the "command B"
> words, which are all supposed to match in the case of a
> fragmented packet, and which we also don't check).
> 
> The most plausible behaviour to take I think is to raise
> TXE when we would overflow the s->txp_data[] buffer; there are
> various conditions described for when TXE is raised that seem
> like this would fit in reasonably with them.
> (There is a status bit TDFO for "TX Data FIFO Overrun", which
> I think is probably only for overruns of the TX data FIFO,
> not the MIL's TX FIFO.)
> 
> Since the datasheet doesn't say if the packet should be
> dropped or truncated if it's invalid like this, I guess
> we can do whatever's easiest.
> 
>>                   s->txp->data[s->txp->len] = val & 0xff;
>>                   s->txp->len++;
>>                   val >>= 8;
> 
> Conclusion:
>   * we should raise TXE, not TXSO
>   * add a comment about what exactly is going on here
>   * we should try to clean up the confusion between words and
>     bytes, as a separate patch that isn't -stable/-9.0
>     material...

Thanks a lot for this very detailed analysis! v2 on the way.

