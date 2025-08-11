Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA57C87FDB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 10:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulQ0G-0000xX-1Q; Mon, 11 Aug 2025 06:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulQ0E-0000x5-49
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:43:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulQ08-00052D-Lj
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 06:43:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-458b2d9dba5so26312565e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754909015; x=1755513815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jfrrc7H7hZ2+obci5h5j3ABYnou1j9TfJEJZPevGjx4=;
 b=GSm2y4z260I87IEw1QtmcGHFd6t9dQKYAHQ2L/1c8ElKPa/0qUe/siDc+9flKNTdFG
 lGvJpNp5OvtJTfkeoEJezjJeU3BZuje+mD/2TZE3nui5mYfCHbWgtO/LlD2yJf7c8XS6
 bWgA7d7/sPm2aV1gcoNht2lagrAgW4xs4GP9xp4XKr12WC6Uhp3k/Y9q80HIMNAwe4mn
 vZFAd4zzkOnD+5pKmxCMM/OHAHkTo0V5g147nkxED4ryDhtv+g62z/YLNxkqp5+FfLzz
 e8P5kaYEFNrbexrLxE/x9P89bHFwdZsudN10vozRvn2mZljo5UZeEIr7BVjxzuVHJK+G
 5ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754909015; x=1755513815;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfrrc7H7hZ2+obci5h5j3ABYnou1j9TfJEJZPevGjx4=;
 b=No7RQpgSheIvzUsAcNePCPr61fdpzLrQucjkZ6oLaMZA3dlECBlRPwXWNQYXVX1Y+1
 pMcfhWBHtGXgLyYqWQ88q9XZR9w7VYiXJD/QEkleb1SC2KmBhGGFonxYtBoIfODxHXPc
 TcVpYKOW4f+5JVt2XhQ9lhiK2SqJTKo/lpu5absg9hSVtLmdjAcBdIvalTmF/UhysYN9
 yduycjmHQYCCW+rtoYAtqdDBLcLmK3ScwOUQd6a1YjnyiL5CFkzXLjt5k+pOffQPr7wn
 JtMMwy0r9RPs9LDOxxHg6Y1aupnKpUXpAeITPUOrH9/5M0QcAh7543QxZgX9i5xAbTJH
 KTUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTcApAH1PqIG2HInzok29Fvbsp3O1xqlA2HoRp5KyuGqmbxwkmZZAvCVg/Y62D0MUJ1/sg8rgfsDc9@nongnu.org
X-Gm-Message-State: AOJu0YwGfQcxuApxxLiXYVxqXFAEr0KLusehqGjmfQXxnvRDNdycpjkv
 df9jJHNwMyDBC1vkXsVwHa5OactXWlaKAZJOYLU2H744e4dChg0MSyTywEUtULteBic=
X-Gm-Gg: ASbGncviNhGV4wa/rYQfn/VlwTVIQ9XTeimB9ux1t/inK+oE6nU7dP98igNFCSnoVg0
 +IofxyEBqM5SltWYI8C44mT2rOZojJaCieDP98oicxH0LWSIAIYSQR3DnU0aEcS4hTsouHXsxK/
 EUwjXRi6wTe2V3eWpuybtmsRA/70MsflQ08uJJEICLs5JeGTcUi3/x5B6M8x7nn+9pKQwD21bgR
 HG4IK4J5g97haKzxaCQO2Fw0IL5VB7KFXd1GY74pqVjsO8t+MgPSPuErR0+nVqsefZ7suxFj+2q
 i3DYGR3UTW4P71TSDx0K/+FTj2lBC3ezwmKWhj048DbY5nR6DCCRv+LXkgn7b62e6tQgX57V85c
 7vArcU9ojj6xQ9NkQqL/qDEfez1SU0DSXTaF5Jm8+bDQ2Mc2FXCijdBrN4vh0NUeFTg==
X-Google-Smtp-Source: AGHT+IH+Vp4QK0Mzumzj5M1Rq3qZbOzWZ1NlBJtPKIZWmtscc8S3zsmngHT9y8ZpcbRCYwWTLAVntA==
X-Received: by 2002:a05:600c:3b8a:b0:456:8eb:a36a with SMTP id
 5b1f17b1804b1-459f4eb5717mr106659475e9.13.1754909014639; 
 Mon, 11 Aug 2025 03:43:34 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458be70c5f7sm374843235e9.26.2025.08.11.03.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Aug 2025 03:43:33 -0700 (PDT)
Message-ID: <64fd72ef-8405-4406-8a12-607f060033af@linaro.org>
Date: Mon, 11 Aug 2025 12:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/11] hw/arm/smmuv3: Introduce secure registers and commands
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Tao Tang <tangtao1634@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
 <20250806151134.365755-2-tangtao1634@phytium.com.cn>
 <5a955f10-88bc-4590-9887-ec0f95af3e17@linaro.org>
Content-Language: en-US
In-Reply-To: <5a955f10-88bc-4590-9887-ec0f95af3e17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 11/8/25 12:22, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> On 6/8/25 17:11, Tao Tang wrote:
>> The Arm SMMUv3 architecture defines a set of registers and commands for
>> managing secure transactions and context.
>>
>> This patch introduces the definitions for these secure registers and
>> commands within the SMMUv3 device model internal header.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3-internal.h | 57 ++++++++++++++++++++++++++++++++++++++++
>>   include/hw/arm/smmuv3.h  | 23 ++++++++++++++++
>>   2 files changed, 80 insertions(+)
> 
> 
>> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>> index d183a62766..72ad042514 100644
>> --- a/include/hw/arm/smmuv3.h
>> +++ b/include/hw/arm/smmuv3.h
>> @@ -63,6 +63,29 @@ struct SMMUv3State {
>>       qemu_irq     irq[4];
>>       QemuMutex mutex;
>>       char *stage;
>> +
>> +    /* Secure state */
>> +    uint32_t secure_idr[5];
>> +    uint32_t secure_cr[3];
>> +    uint32_t secure_cr0ack;
>> +    uint32_t secure_init;
>> +    uint32_t secure_gbpa;
>> +    uint32_t secure_irq_ctrl;
>> +    uint32_t secure_gerror;
>> +    uint32_t secure_gerrorn;
>> +    uint64_t secure_gerror_irq_cfg0;
>> +    uint32_t secure_gerror_irq_cfg1;
>> +    uint32_t secure_gerror_irq_cfg2;
>> +    uint64_t secure_strtab_base;
>> +    uint32_t secure_strtab_base_cfg;
>> +    uint8_t  secure_sid_split;
>> +    uint32_t secure_features;
>> +
>> +    uint64_t secure_eventq_irq_cfg0;
>> +    uint32_t secure_eventq_irq_cfg1;
>> +    uint32_t secure_eventq_irq_cfg2;
>> +
>> +    SMMUQueue secure_eventq, secure_cmdq;
> 
> Note, we could also add these fields as
> 
>        struct {
>            uint32_t idr[5];
>            ...
> 
>        } secure;
> 
> With some IDEs it allows to only expand which set you are
> interested in when debugging.
> 
> I then since it is mostly the same banked set, I wonder why we
> don't extract the state and bank it:
> 
>        struct {
>            uint32_t idr[5];
>            ...
> 
>        } state[REG_NUM_BANKS];
> 
> I haven't looked at the rest, but this might simplify the
> implementation.
> 
> Then maybe we can use the ARMASIdx enum as index.

After looking at the rest of the series, ARMASIdx seems appropriate.

I'd use:

         struct {
             uint32_t idr[6];
             ...

         } bank[2]; /* ARMASIdx_NS and ARMASIdx_S */

