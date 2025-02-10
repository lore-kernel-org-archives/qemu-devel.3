Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2468C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thRHP-0006kE-DO; Mon, 10 Feb 2025 05:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRHN-0006jv-Ni
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:44:42 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thRHL-0005wW-Sy
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:44:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43948021a45so4017345e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739184278; x=1739789078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0Dwoc7RY4bZRTzAOMQfPuoeH3Y30Ed9EhRFs8jdDH8=;
 b=m17JTpe4wFr7C3Ww+yEAl39/t23BAi4FQx0auEN/LspKN2yUTUBRdJhwgLm6Cwn6OI
 Nt41JmYqk07w0rdAlVCxBH9LEMrb/CqjXLPakLVMx2dREPueE6Kh3QJmoWZNDlZCjcTV
 F9ALf6d951HwgQ2ETrlEJgSHdOJLUO3FQCD62xRFT8LQ54iesVzjlo5KIk1lI4IZMofE
 44AP3dEiiinsLZpYipt2dgjyuL98B33WfPrwZOfTSVu3I6kM1m3GKBdKKM35JIfVxFfV
 h/HWbDmKEhCUGbxsLqTeNAAtOwoHp1l9UBzNqRQlLcg/qKHte4A7+t6cswDPi6eF78pp
 nG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739184278; x=1739789078;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0Dwoc7RY4bZRTzAOMQfPuoeH3Y30Ed9EhRFs8jdDH8=;
 b=cblEHBSzMxzIzgetEHhlF2y12UgnLlwb9sVpOFercO06UClDPnpJxZFMEpxIYFujy9
 V6kKtcOZasAFC7GbYZsN5RDI/dQLBqt9Jc3B+GztZ73ZnA09urOk4nKym4fYIe30mmFS
 YcL2oRjh3vrrULV7h155CdjlgUH2nkz9IO23Ocs3Ak/GTi2tjIeBwGEiWPjSd2kRj0Mm
 dWti1Q1o+04FPsX9diKN7cm4kNrpoZ9FQVJLTgvRLcCspph0fQOnjzdLEoSI/6R3O6bd
 2cEeLqX6JKDLKmcYpVvZ9eoJlhO+kSZ4TtE2rGUI8CxkZsdejNHamIG3C+cZknmn7zBx
 3EFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXOlGtXRzYr2ym4NTdV6u7oD/BEFYcECcO9Z0X3Pa0O1eXJdwKA8NQSW8WHp8jMQ2Gf9K2TzMvLkb0@nongnu.org
X-Gm-Message-State: AOJu0YyOEIcpprp789mdMI/IHy54y3l5Q7mQfHkmLDzan9OH68kVYm+M
 A/BMFI6jzxx+qVbNnTxzGr196k2nP6tanFw5Y2Nwsdr6/bav/QFP1uqMiuZcb1o=
X-Gm-Gg: ASbGncsF4TRddA6k6FJBIdvMO5SeKov3G48K/dGRFAPGtg4G4Y5/EY+Z0jTcNjMLwSx
 /LH+61N04/4dPcpE4ve1H/5T9FuPUndwxGYS9fCr6USMhUHmCzxtgQSX3JfaPj1vKQ8oZwgsJG6
 bEhvj4iTCh+J0rDmgjtHoxgw+MJkiXmHKV4RzSzInPpXY6FuuLWQznrq//y1d6fZ2G43zBFj2D1
 XU+fTwXOStDc9CH3P3UsNCRVcOasgWFhBz0WfMdOSRaaeBNe4mY91fcuOiC5MzqRr7ZB1MW0XaY
 9qFqq16iGuyntvHIH7Cjhl16XLptlSF7KKhFuuZ8PG1hAZb8l7z6hY3GiT2UZDBm
X-Google-Smtp-Source: AGHT+IGgYIZtrpUqudTiScu89irHgeNVVhWtI9BfF9U0fFAqperJpaK7L9yjPXCUK8NiD6BncxKT+w==
X-Received: by 2002:a05:6000:1547:b0:385:e35e:9da8 with SMTP id
 ffacd0b85a97d-38dc8dd3475mr9256407f8f.18.1739184278172; 
 Mon, 10 Feb 2025 02:44:38 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dcb22f737sm8995633f8f.24.2025.02.10.02.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:44:37 -0800 (PST)
Message-ID: <e5bcfc84-ad3e-4ee2-bf83-b3c4aea4e56e@linaro.org>
Date: Mon, 10 Feb 2025 11:44:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/net: cadence_gem: feat: add logic for the
 DISABLE_MASK bit in type2_compare_x_word_1
To: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>, alistair@alistair23.me,
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20241219061658.805-1-andrew.yuan@jaguarmicro.com>
 <CAFEAcA96ZLjOhBT9rhNhuk32ve0Qv4hUVuTTtgE=DBApbN98Pg@mail.gmail.com>
 <CAJy5ezovedShKH=HFbK9uRY44no2ijQocs29CHLt2jKoNL+Vpw@mail.gmail.com>
 <CAFEAcA8oaRVs8USMDGHvDW82AtRZGAhRCg189hhWtmRm2Y-YaQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8oaRVs8USMDGHvDW82AtRZGAhRCg189hhWtmRm2Y-YaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 4/2/25 15:37, Peter Maydell wrote:
> On Thu, 30 Jan 2025 at 22:31, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
>> On Mon, Jan 27, 2025 at 8:40 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On Thu, 19 Dec 2024 at 06:17, Andrew.Yuan <andrew.yuan@jaguarmicro.com> wrote:
>>>> -            rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
>>>> -            mask = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
>>>> -            compare = FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE);
>>>> +            disable_mask =
>>>> +                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
>>>> +            if (disable_mask) {
>>>> +                /*
>>>> +                 * If disable_mask is set,
>>>> +                 * mask_value is used as an additional 2 byte Compare Value.
>>>> +                 * To simple, set mask = 0xFFFFFFFF, if disable_mask is set.
>>>> +                 */
>>>> +                rx_cmp = ldl_le_p(rxbuf_ptr + offset);
>>>> +                mask = 0xFFFFFFFF;
>>>> +                compare = cr0;
>>>> +            } else {
>>>> +                rx_cmp = lduw_le_p(rxbuf_ptr + offset);
>>>
>>> Is the change in behaviour in the !disable_mask codepath here
>>> intentional? Previously we use one byte from rxbuf_ptr[offset],
>>> duplicated into both halves of rx_cmp; now we will load two
>>> different bytes from rxbuf_ptr[offset] and rxbuf_ptr[offset + 1].
>>>
>>> If this is intended, we should say so in the commit message.
>>>
>>
>> I agree that it should be mentioned (looks like a correct bugfix).
> 
> Thanks. I've expanded the commit message:
> 
>      hw/net/cadence_gem:  Fix the mask/compare/disable-mask logic
> 
>      Our current handling of the mask/compare logic in the Cadence
>      GEM ethernet device is wrong:
>       (1) we load the same byte twice from rx_buf when
>           creating the compare value
>       (2) we ignore the DISABLE_MASK flag
> 
>      The "Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev:
>      R1p12 - Doc Rev: 1.3 User Guide" states that if the DISABLE_MASK bit
>      in type2_compare_x_word_1 is set, the mask_value field in
>      type2_compare_x_word_0 is used as an additional 2 byte Compare Value.
> 
>      Correct these bugs:
>       * in the !disable_mask codepath, use lduw_le_p() so we
>         correctly load a 16-bit value for comparison
>       * in the disable_mask codepath, we load a full 4-byte value
>         from rx_buf for the comparison, set the compare value to
>         the whole of the cr0 register (i.e. the concatenation of
>         the mask and compare fields), and set mask to 0xffffffff
>         to force a 32-bit comparison
> 
> and also tweaked the comment a bit:
> 
> +                /*
> +                 * If disable_mask is set, mask_value is used as an
> +                 * additional 2 byte Compare Value; that is equivalent
> +                 * to using the whole cr0 register as the comparison value.
> +                 * Load 32 bits of data from rx_buf, and set mask to
> +                 * all-ones so we compare all 32 bits.
> +                 */
> 
> and applied this to target-arm.next.
> 
>> Other than that this patch looks good to me!
> 
> Can I call that a Reviewed-by (with the above changes)?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


