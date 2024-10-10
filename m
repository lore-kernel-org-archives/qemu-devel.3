Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0F3CFC5EC
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 18:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syxaX-0003p3-M3; Thu, 10 Oct 2024 14:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxaV-0003og-LY
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 14:08:35 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1syxaS-0007fy-Qu
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 14:08:34 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c7edf2872so10678305ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728583710; x=1729188510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kLHzcvlVCjQ02B6oJ8jXqKHu+mhXnZaoAUIs7MZo2k0=;
 b=Dq7tKxhGx1jGikWtIw3eBxFXtU/YTtleXTN31J4CDlBbRlFc07I2B1OZRgu3Rlzvtt
 Njm9WsgWsvaraeymN2LkWo6wskuh+aVUnhEHIuhdJk9TELPM4dyAM5E2zNUmzdF+VobE
 JJDFppFo5l3P+ppskG8WxI4YL7fxlTf4vWotyNTQjycPR889ey5b8OcKUlxPGCOOMiCa
 H/Ettvb7VB8cluhzUanmnI81EVNcfXUQwvvVe8oCMWUyb58G57P46td6wamYFth+BsUW
 JL9/uq9fL643WbY6eemRHxvEP6b4bzWbcvnOFBYe+N4bdomtFzOUSAQPDq21E1BiOS2c
 lNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728583710; x=1729188510;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kLHzcvlVCjQ02B6oJ8jXqKHu+mhXnZaoAUIs7MZo2k0=;
 b=PJMdWir9ZCGiLoDP4JwXm4jgiUeByn8+daVXIcmFGlXUTIeNsXwJnZHxwnTUX0u7Y+
 DcpCh37shR+V80jd012cca9p1RJclayHmwLfvy+5pPDVMxC4lB8ieoIm/z3DJ5HjtMRz
 i0YY7HNN7Tx6rdzWwRCKOSK1Gqy2TFt7a83WUeg3y0PK5QzkwIpbJ6+eMQMcGSEi0m14
 na5xKA6ejtjU/rkoXLpIOCCNypGYvUsKARI+BGveSVoTCQlNUg2Xjz8AA8vFofHS5hQ7
 TmIItAtLdQ4hAuqLPR0RCRYavczMSDhJg3MWXsOgTBNYiCkt2kbPd7J7rnMPSRitKrOr
 leBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVe0raTB6SQj9z2015+KI48Bh09pQswLLfAn4zqaTGbdyfzRRFAhtceg8P1U4um8trNrbGPtKsDm1iD@nongnu.org
X-Gm-Message-State: AOJu0YywFIE7QZER8StLc6PssJQUDoPhX1bMo1VLjqNsq+dppDnlTlBG
 tRWGilXweHd5bkSKNXVhuCIvbUSfrtWgqhvliznQRCTzG1j/DBM5mVs0L4Xx8O/8bBui888ancV
 Y
X-Google-Smtp-Source: AGHT+IGYvQHODsOhLtCAuE0iah80rXnlAlMKZyx47KbuBkW6Ew7ycdMfC24lDV7RIt9GyNzKqOj9Mg==
X-Received: by 2002:a17:903:1c6:b0:202:4bd9:aea5 with SMTP id
 d9443c01a7336-20c804965efmr66898745ad.14.1728583710244; 
 Thu, 10 Oct 2024 11:08:30 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.89.169])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8c348d07sm11930185ad.276.2024.10.10.11.08.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 11:08:29 -0700 (PDT)
Message-ID: <bc818785-f761-41e2-bb05-c41f08d71241@linaro.org>
Date: Thu, 10 Oct 2024 15:08:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-8-philmd@linaro.org>
 <c592f4de-f6df-4363-8060-c1ac569e2947@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c592f4de-f6df-4363-8060-c1ac569e2947@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/10/24 18:35, Richard Henderson wrote:
> On 9/30/24 00:34, Philippe Mathieu-Daudé wrote:
>> Move code evaluation from preprocessor to compiler so
>> both if() ladders are processed. Mostly style change.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/xtensa/xtfpga.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
>> index 955e8867a3..228f00b045 100644
>> --- a/hw/xtensa/xtfpga.c
>> +++ b/hw/xtensa/xtfpga.c
>> @@ -415,8 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc 
>> *board, MachineState *machine)
>>               }
>>           }
>>           if (entry_point != env->pc) {
>> -            uint8_t boot[] = {
>> -#if TARGET_BIG_ENDIAN
>> +            uint8_t boot_be[] = {
>>                   0x60, 0x00, 0x08,       /* j    1f */
>>                   0x00,                   /* .literal_position */
>>                   0x00, 0x00, 0x00, 0x00, /* .literal entry_pc */

                                              ^^^^^^^^^^^^^^^^

>> @@ -425,7 +424,8 @@ static void xtfpga_init(const XtfpgaBoardDesc 
>> *board, MachineState *machine)
>>                   0x10, 0xff, 0xfe,       /* l32r a0, entry_pc */
>>                   0x12, 0xff, 0xfe,       /* l32r a2, entry_a2 */
>>                   0x0a, 0x00, 0x00,       /* jx   a0 */
>> -#else
>> +            };
>> +            uint8_t boot_le[] = {
> 
> Fix these to use static const?

We use memcpy() to up update $pc/$a2 in place.

> 
> 
> r~


