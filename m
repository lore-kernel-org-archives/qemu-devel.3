Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D384DC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 13:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU4nT-0005xs-OQ; Wed, 17 Jul 2024 09:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU4nO-0005o8-PJ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:34:14 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU4nN-0006EC-1B
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 09:34:14 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso48057545e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 06:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721223251; x=1721828051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AD2SS6ooVpxSZUiP4hpAIz0CKU1+jlNQrxb8VVVDooM=;
 b=HFGfAzv4eKrFO0axOORGYxOzOvOcDMUnZs5/K9GuEDrAaIIgSQAhuCoGEWoey2sP7O
 LOQk2q1Wr3J+W7QZEhEdvXCWNPvqEBVpbnsRZm2uq6IghXxr17SPcXeflG5xz6J+01Bw
 pCU+tkFL2ukg32C7x8hDVo3h5ZFhmNkd4Aof2/tzWiDwu8ueVMwfCytAzyMIvwtFFEyK
 qtcHtvuFelikq4+n3T0S3VCHShxCmAm39zpYgLTKL1DF+UyYyQQWb8hcCeew5HFKxKu8
 ZXOjWSKEkBHVOLD4rR098QcE298ozO+fnQRPSSWKqCzzQsvDQXr54OrUbhxrTXxc0NTB
 NP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721223251; x=1721828051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AD2SS6ooVpxSZUiP4hpAIz0CKU1+jlNQrxb8VVVDooM=;
 b=wcGpx1iWWKf1kWvs1QeKitPEsQpvJaqlP5gyXdKb3T8EHpjGbYwMD1EwcP6KCBp2PN
 eI+O3vhEdhqVBJO3BQihbUPPaorkgHNAvf5bPwecoFe+iDvI5QZBQ95VF0EHe8q4sTIb
 jp57pmOUy5YEayvfHt1cwFiXKXJKYwAiSgqFH9A85OCz1KHXcR9ml7McO91ANcSCU50W
 ZUi9pwWBQJ1nDstRa+Rd2cJoMqvQN+AdUb5OWPFiWbI4OV4Ai6+KKRjZcehw27Ys/0PM
 JwTSyfP0HshdXBZSPp1ZnfOVzpemNAwmmiM/t+28gdA7DmkftbezhwKb1YjVwLfZElbV
 Wk6w==
X-Gm-Message-State: AOJu0Yyz53/nwBYyN51Oe+nxucy2+KKr6OsqThVVLmonnM1G8zNW5Amo
 ldDML3tculPH26yhWbExgjrdK0+M7wb8kfyy+uPrSgqT0FS4wD6j3b1SX4jFD5s=
X-Google-Smtp-Source: AGHT+IGWqibKjsHS7epSYSdSi/RACr7tnfu9dfgokQTwN3GMW/GUWZVhbcVpeF4Vc6HIXTBsBUaKcQ==
X-Received: by 2002:a05:600c:474c:b0:426:59aa:e2fe with SMTP id
 5b1f17b1804b1-427c2cc9686mr13096475e9.19.1721223250668; 
 Wed, 17 Jul 2024 06:34:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a0fa55afsm200595695e9.16.2024.07.17.06.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 06:34:09 -0700 (PDT)
Message-ID: <d34473a1-5a79-472b-897f-99098edd49c4@linaro.org>
Date: Wed, 17 Jul 2024 15:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2 v4 09/10] hw/char/pl011: Add transmit FIFO to
 PL011State
To: quintela@redhat.com, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Gavin Shan <gshan@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org
References: <20231109192814.95977-1-philmd@linaro.org>
 <20231109192814.95977-10-philmd@linaro.org>
 <45ef60fe-dcb6-461d-97e1-d19e5174075d@linaro.org>
 <87o7fthf6x.fsf@secure.mitica>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87o7fthf6x.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/11/23 16:48, Juan Quintela wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
>> On 11/9/23 11:28, Philippe Mathieu-Daudé wrote:
>>> @@ -436,6 +438,24 @@ static const VMStateDescription vmstate_pl011_clock = {
>>>        }
>>>    };
>>>    +static bool pl011_xmit_fifo_state_needed(void *opaque)
>>> +{
>>> +    PL011State* s = opaque;
>>> +
>>> +    return !fifo8_is_empty(&s->xmit_fifo);
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_pl011_xmit_fifo = {
>>> +    .name = "pl011/xmit_fifo",
>>> +    .version_id = 1,
>>> +    .minimum_version_id = 1,
>>> +    .needed = pl011_xmit_fifo_state_needed,
>>> +    .fields = (VMStateField[]) {
>>> +        VMSTATE_FIFO8(xmit_fifo, PL011State),
>>> +        VMSTATE_END_OF_LIST()
>>> +    }
>>> +};
>>> +
>>>    static int pl011_post_load(void *opaque, int version_id)
>>>    {
>>>        PL011State* s = opaque;
>>> @@ -487,7 +507,11 @@ static const VMStateDescription vmstate_pl011 = {
>>>        .subsections = (const VMStateDescription * []) {
>>>            &vmstate_pl011_clock,
>>>            NULL
>>> -    }
>>> +    },
>>> +    .subsections = (const VMStateDescription * []) {
>>> +        &vmstate_pl011_xmit_fifo,
>>> +        NULL
>>> +    },
>>>    };
>>
>> It just occurred to me that you may need a vmstate_pl011 pre_load() to
>> empty the FIFO, which will then be filled if and only if the saved
>> vmstate_pl011_xmit_fifo subsection is present.
>>
>> Juan, have I got this correct about how migration would or should handle a missing subsection?
> 
> I hav'nt looked about how the device is created. But if it is created
> with the fifo empty you don't need the pre_load().

This is indeed the case. Thank you Juan!


