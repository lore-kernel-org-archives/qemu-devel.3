Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73254E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 15:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHWC-0007Km-Cv; Mon, 30 Dec 2024 10:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHWA-0007K7-Gn
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:17:18 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHW8-0000i8-MW
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 10:17:18 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso5089102f8f.3
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 07:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735571835; x=1736176635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TgEaK9IIv9JgU+XsTIrVRbeP3BFI31d39ksXkKneY5k=;
 b=KsbKgby3ExoDzt6QX006PqHVEOc1l0SZR7DH23L6SA+4u9lT/M3VjTQQcBKmtevRbj
 loeB9bBQLx6HlzBNxmecmLuG2otPzI/+YXA0CYa5EbRcBxOFZWauPhFhlwo615CUZMfk
 v+Wn8JwalRdnBLb3aEQZXTwbJ/31cPLF6UHOZiZnuSwvOX65509GYPlBRHZgIFxHW746
 PgjuSdSCcMCjHi2cBtKhYDZOrUfxgSXJ9qYF7pRVz/jMLD+0IzPTLBFUF9/En9N606KL
 TxR7MAVUpEcB1znldaym0uIjp1bqEHens9MG+7puxzbQPGxoqolT3w5BBpGpgabvvTJ0
 zHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735571835; x=1736176635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TgEaK9IIv9JgU+XsTIrVRbeP3BFI31d39ksXkKneY5k=;
 b=kCYThZpjTZo+rKtohOnjjI/DLP5D3CZObcIzIff2V5l12CdMsmdx4z42+9LEFq6GjP
 9i6FGj8gwM+M+OGxL1kr68nCkPbmOTCbYG34fG8LVIBcP2BoCiJQE4Ulzs931r5bX5RM
 oWnbMcZP55jN11yA25iCgJEEE9+US5bCcGfnWJc9T3BNEufVfka/EWz/xhbvuQSDsV5h
 g4IGkfQtndV1xJhSc18lVigBSfikhcZgQNt8hI5Krb7lM/5vUNlWfpPeaiiYhHseJxWB
 48muSMXKzFfe8n0zI8bjNVsslnT/FGYJLxzDRIywYCE4C8TumJpt/l1xlTQqHjZuwK3m
 9hfA==
X-Gm-Message-State: AOJu0Yw4PcwRBqKFFqpuWeVVyjJuJ+/+DQoTor+mWeHcc/GxRZh9w+TE
 QJNk/UL82izYRoawZ400jRl5FxEx3AKQR4w553VJ9qVAff8WCxFrTRtfYyWYRaQ=
X-Gm-Gg: ASbGnctgeI/RCqx87aipfsCXhbHO1RbJq7mpGFxsls7d0raiwUtFxO2fLbW0ecurGh7
 jV6HBvYcRiS6mTWrG8gqF+S/J+lWEs9fIYFedTyhS9bmNjWOnf0X/FeQYQDHhkV0m13u/VqRJbv
 1yYUNKteNAX39275rdJPZxY+E9dpuMeABoRRmXe+nKcW3xGXZgFw8Nml20i9TadmXK3hO/w+DwQ
 8T6ede+tcC//BHAaYyOKm5od//H0N5T39XNZUAjAKsYSjvihLhF06HzGsRyCIpDKRaurBJc6GdM
 7Apqg9X2WN6VHycU0cnmxS+0
X-Google-Smtp-Source: AGHT+IHyV7U8iMyEh1uJzuCBhfDtgFD7zDM23Hhl/a1J+Qp7Qu4pUQsLRD3WA/h0LsBWKljj9iswrQ==
X-Received: by 2002:a05:6000:4029:b0:386:41bd:53a3 with SMTP id
 ffacd0b85a97d-38a224083afmr29857472f8f.50.1735571834838; 
 Mon, 30 Dec 2024 07:17:14 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea4a7sm356850475e9.3.2024.12.30.07.17.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 07:17:14 -0800 (PST)
Message-ID: <626e4b64-bf09-4dec-b353-b9239ee6d7d3@linaro.org>
Date: Mon, 30 Dec 2024 16:17:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] tests/qtest: Update tests using PL011 UART
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
 <20240719181041.49545-10-philmd@linaro.org>
 <CAFEAcA9QA3Kn3h_bwMSoht7KZa8DOpMXFDUWon1kc+iHy59-EQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9QA3Kn3h_bwMSoht7KZa8DOpMXFDUWon1kc+iHy59-EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 29/7/24 17:47, Peter Maydell wrote:
> On Fri, 19 Jul 2024 at 19:11, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> We weren't enabling the PL011 TX UART before using it
>> on the raspi and virt machines. Update the ASM code
>> prefixing:
>>
>>    *UART_CTRL = UART_ENABLE | TX_ENABLE;
>>
>> to:
>>
>>    while (true) {
>>        *UART_DATA = 'T';
>>    }
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/boot-serial-test.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
>> index 3b92fa5d50..5cb309ccf0 100644
>> --- a/tests/qtest/boot-serial-test.c
>> +++ b/tests/qtest/boot-serial-test.c
>> @@ -70,18 +70,23 @@ static const uint8_t kernel_plml605[] = {
>>   };
>>
>>   static const uint8_t bios_raspi2[] = {
>> -    0x08, 0x30, 0x9f, 0xe5,                 /* ldr   r3,[pc,#8]    Get base */
>> +    0x10, 0x30, 0x9f, 0xe5,                 /* ldr     r3,[pc,#8]    Get base */
> 
> The instruction bytes have changed but the disassembly comment has not...
> 
>> +    0x10, 0x20, 0x9f, 0xe5,                 /* ldr     r2,[pc,#8]    Get CR */
>> +    0xb0, 0x23, 0xc3, 0xe1,                 /* strh    r2,[r3, #48]  Set CR */
>>       0x54, 0x20, 0xa0, 0xe3,                 /* mov     r2,#'T' */
>> -    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3] */
>> -    0xfb, 0xff, 0xff, 0xea,                 /* b       loop */
>> +    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3]       loop: */
> 
> This placement of the "loop:" label is odd -- usually the label
> goes before the instruction that a branch to the label will
> start executing at.
> 
>> +    0xfd, 0xff, 0xff, 0xea,                 /* b       loop */
> 
> Here also the bytes changed but not the disassembly. Since
> 'b' is a relative branch, why does the offset change?

It felt simpler while single-stepping to just fill the TXDATA register
with the byte to send, and not reset the other registers with unchanged
values. Anyway you are right, I'll split the changes for clarity.

> 
>>       0x00, 0x10, 0x20, 0x3f,                 /* 0x3f201000 = UART0 base addr */
>> +    0x01, 0x01, 0x00, 0x00,                 /* 0x101      = CR UARTEN|TXE */
>>   };
>>
>>   static const uint8_t kernel_aarch64[] = {
>> -    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
>>       0x02, 0x20, 0xa1, 0xd2,                 /* mov     x2, #0x9000000 */
>> +    0x21, 0x20, 0x80, 0x52,                 /* mov     w1, #0x101 */
>> +    0x41, 0x60, 0x00, 0x79,                 /* strh    w1, [x2, #48] */
>> +    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
>>       0x41, 0x00, 0x00, 0x39,                 /* strb    w1, [x2] */
>> -    0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
>> +    0xff, 0xff, 0xff, 0x17,                 /* b       -4 (loop) */
> 
> Another unexplained offset change here.
> 
>>   };
>>
>>   static const uint8_t kernel_nrf51[] = {
>> --
>> 2.41.0
> 
> thanks
> -- PMM


