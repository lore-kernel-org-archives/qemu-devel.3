Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E645D132DE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:26:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7yxl-0007Cf-TB; Mon, 04 Nov 2024 10:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7yxd-0007BC-MC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:25:46 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7yxb-0002Ms-W3
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:25:45 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99f3a5a44cso615448666b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730733941; x=1731338741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yT+yOR60+TjWzvuax1qaxFFy+Bp2Rcc/ZkNW0+xeDCA=;
 b=kuNXDDqrcwMRVT2R5Y+hA1gdtsS1iF+QmV1zYpii+MuBLECZ3VJmIakQJjdz3+L3al
 FAEKvArY8nDGtmbVa3HeGQ/F+ToUPxP4cbRxjD+vXH1C7xFIkT4QJPMu57ooT+4Ay9la
 Jo6CbY/qa3Wjh85btnPPkiZRi4ekBahI5RG2rxupjVySKz5IQwmZRAarDZS0qfPFNsg1
 5cQJ/Wf7nec+LzXP2WSvdwMh+VLUWchPpoz8O0JHfG9qkwl4PGgPajosvouVc5cQ3hro
 HzrcMyH4Ld5VtjPyFJX3LupvjbZNppf3AcZ+n+sscgW/VVOoBAuo3uJFdy0z94YMgxiF
 qfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730733941; x=1731338741;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yT+yOR60+TjWzvuax1qaxFFy+Bp2Rcc/ZkNW0+xeDCA=;
 b=NlM2FaOoGlxBvdkGoYmhENJOm5057/07WaUDuvhBqTuA0vkcFOM0kcMLx8yS+S3mJm
 Zti8dU9sCRLAMwrtzAVzDlvLX32AStoUhlDNIB4Tr1jo2aMHyrlKfwoeXlg3mTZWESnq
 7fb7rYnz7+3cmnUGGYrAunnx+u3dFWQDBjCB3UPg2aE73hET41kFbAu1g/7nSbKYBzcM
 pBOuZ9tFamlXsv+ksTYT/Lj7+H8Njco1PwKO5jh2g8c/No06hdckogJkb1Jv0Ht+6irS
 X9I2NhK4g3yxOq1JyxePY4Unc6JUHzdbhEofSWKhTm6vgbRB91GZZfsjzNuQ2VAVTGUf
 xIHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfFeHkckrmY4HL6FPqQGQe5ULmniN33Ky31Fk5t1dH1ZSQNAumVkGLZ0VCEVCTIlSxx+x03zD8+VYP@nongnu.org
X-Gm-Message-State: AOJu0Yw7Ev9BSL9i8aC63Z4o9xCe3vLamEJ1cygjbAQ/ET8YVtNKfq2f
 vuqpf/Pe1cGtPzJRUPBns1qSgmClI/1W3lHJhBP79cBKDX32W1xFTHPraf2esYcPmI+upL+bfr7
 d
X-Google-Smtp-Source: AGHT+IE/bCwuOVJgcdeaNzL/kAvvVICi+2o9jfYLZzbWQ2Mm3r+Ch+3bHovNW8gIpcRKjMKs/4J81w==
X-Received: by 2002:a17:907:948c:b0:a9a:17b9:77a4 with SMTP id
 a640c23a62f3a-a9de5ed3c96mr3382365966b.20.1730733941279; 
 Mon, 04 Nov 2024 07:25:41 -0800 (PST)
Received: from [192.168.69.126] (juv34-h02-176-184-26-5.dsl.sta.abo.bbox.fr.
 [176.184.26.5]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e565dfa8bsm567730666b.103.2024.11.04.07.25.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 07:25:40 -0800 (PST)
Message-ID: <62320d09-007c-4435-b4cc-eebfd0668fd6@linaro.org>
Date: Mon, 4 Nov 2024 16:25:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/50] hw/char: sifive_uart: Print uart characters async
To: Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair23@gmail.com>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241031035319.731906-1-alistair.francis@wdc.com>
 <20241031035319.731906-16-alistair.francis@wdc.com>
 <4c589c02-323a-4989-be30-619627124002@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4c589c02-323a-4989-be30-619627124002@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 4/11/24 11:38, Thomas Huth wrote:
> On 31/10/2024 04.52, Alistair Francis wrote:
>> The current approach of using qemu_chr_fe_write() and ignoring the
>> return values results in dropped characters [1].
>>
>> Let's update the SiFive UART to use a async sifive_uart_xmit() function
>> to transmit the characters and apply back pressure to the guest with
>> the SIFIVE_UART_TXFIFO_FULL status.
>>
>> This should avoid dropped characters and more realisticly model the
>> hardware.
>>
>> 1: https://gitlab.com/qemu-project/qemu/-/issues/2114
>>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Tested-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-ID: <20240910045419.1252277-3-alistair.francis@wdc.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
> ...
>> @@ -106,12 +174,10 @@ sifive_uart_write(void *opaque, hwaddr addr,
>>   {
>>       SiFiveUARTState *s = opaque;
>>       uint32_t value = val64;
>> -    unsigned char ch = value;
>>       switch (addr) {
>>       case SIFIVE_UART_TXFIFO:
>> -        qemu_chr_fe_write(&s->chr, &ch, 1);
>> -        sifive_uart_update_irq(s);
>> +        sifive_uart_write_tx_fifo(s, (uint8_t *) &value, 1);
> 
> This broke the sifive_u machine on big endian hosts. "value" is a 64-bit 
> variable, so you cannot assume that you get the 8-bit character with 
> such a pointer magic here. I think we have to re-introduce the detour 
> via the 8-bit "ch" variable...

Sigh I got corrected for the same mistake but forgot it here:
https://lore.kernel.org/qemu-devel/49918fad-56fc-150e-bb9c-bd00dc67df05@linaro.org/

