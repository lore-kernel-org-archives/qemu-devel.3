Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017EBCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 10:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2AK-0004B1-HK; Mon, 01 Sep 2025 06:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2AH-0004A5-Ob
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:53:33 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2AF-0000Vo-CI
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 06:53:33 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3cf48bde952so2686585f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756724008; x=1757328808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QWs1+isj0sACY35fxeiPiOI5GkRT3otFreoWoWwwz0g=;
 b=almreH8mZwub+9atRINhRHoIh3eH9K6cTijuAxWVh9vJg4SL8Hh1IwABy8UFkqZv65
 uL3YS8cLBjjuixZ6LFZ1bzjL9x06TEPwhC9oRyJSJZvxHCZBUo6yq5X2j8d8ZnpphmqL
 VhRLOT/BgnoPfx4sC/p2zsX9xTYnkQMi5mo8ckDrwVDyJeoFa+9hg47W49moXd3d35NH
 kFRAa01igIliuXpJ9excHmIZnQUsiZpV3plyDaeteio5Xghx6OC2r/szjqETQ11rCAC+
 SMJd8GnWXUzDGt9oIghbVbQZAd5+4WjQwaa5ov9zGyTcYdoGUMqc30r28gy1LNrLqrtk
 BgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756724008; x=1757328808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QWs1+isj0sACY35fxeiPiOI5GkRT3otFreoWoWwwz0g=;
 b=ScMrvWApMrw19bhY6jYeQOuufuLh5rxB6oeCXpq28CHy3lWFviKXI8TURNYwUzdJ0w
 NINH+qqdZYablkG61LZLRlF5LuioWjLKzZ6a3jCcle4VNA/xlLr8EgLdqiFsK4D4O24h
 5Wuu10Omqsyi54/gPrHLtXlowUsWbCkTepNjrmvRd6uRxlmDo7Na8oWid7hnOgSEFPuH
 busQad+sbLr8HMVU9qOlMPh2GECzLBuD30FwcyvS01WD/Sf033mKVJ6VyVlgUU6uEIwR
 URlUUkJYwfp2FvSzNYRhbppkYxOW4mya0bqlzIzptjWt+j2T5fBuBnvWRdtw27Fwof1j
 Ee3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2uydZsy3AvjAVT0hAiu92WjeBwEkyoDF0BHDqbuiBBJHvt1wMawyKmSpWpZne0FaPBMdIE9Ep5HPR@nongnu.org
X-Gm-Message-State: AOJu0YwFhEbFetLf+TyAP8OkHmIm8hWprgcZOGl9dt+SLYSrK/Me+APv
 ha7SxxWowELwvNYl/Hh5R5WWj1klzQc4GHtuLxy1pXN+lqnjQv+YVstnNVEtZHOvYR8=
X-Gm-Gg: ASbGnctXtExQHI882Em6EwrSZy8kem2A2AJHVI3V+zn5HdiVjnbJzyLgdP3L7svv8Mf
 z7GOz/njZZS2D2g3QabU/vZ+XuHcX/PtoWI9r8BWbyOqOm0nGZy+wpw2vx8qD7KiCon87RUEX9X
 5/XspEN/mFlcCUpVRYXJPz79TVnSfut5yBQj05I9OUi6ibzz+IhR2VcFjwkI2otUh4hrHWDE8sm
 VqdWcieSnvEn2nVx2TZGGoAUH9jDkHcqPJu0SYyyEmXIjw7rqdbKnYz/lFqwFeS9J4C+wSSzune
 32EslXx+l1K2qmjwBlDVz9ymbewSNRY74I1T1Ff482Zov9gxGkBzInV5E84yCnmbDmrGzMnnVif
 8IJoIYzAKxXU4e2UJVLBmpheZnMp0UAmtFSLEG2vLyXc29Xix8qyE1cCT2oafz3fb5egJtegQ8l
 3k
X-Google-Smtp-Source: AGHT+IFKRg3R1b0T+7BLHTt6nJq3uPkK+61Orbti3+GNciryq6nkh/9Z93evdusaZsjt4fbMu6diuw==
X-Received: by 2002:a05:6000:1787:b0:3d6:92ed:caf6 with SMTP id
 ffacd0b85a97d-3d692edce49mr2257174f8f.21.1756724008257; 
 Mon, 01 Sep 2025 03:53:28 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d520eada16sm6050775f8f.41.2025.09.01.03.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 03:53:27 -0700 (PDT)
Message-ID: <7f6fc4f0-9c83-4106-a408-dc213467c96c@linaro.org>
Date: Mon, 1 Sep 2025 12:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/14] hw/misc: Add RISC-V CMGCR device implementation
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>
References: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
 <20250717093833.402237-9-djordje.todorovic@htecgroup.com>
 <a9874cc7-e18e-4b6c-aaac-2c6ce56c1bf7@linaro.org>
 <1cf4f7e5-c9d2-49fd-98db-fd8d05fd241f@linaro.org>
 <4b7973d5-c126-44c8-970d-27059a806512@htecgroup.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4b7973d5-c126-44c8-970d-27059a806512@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 1/9/25 10:24, Djordje Todorovic wrote:
> 
> On 8. 8. 25. 18:07, Philippe Mathieu-Daudé wrote:
>> CAUTION: This email originated from outside of the organization. Do
>> not click links or open attachments unless you recognize the sender
>> and know the content is safe.
>>
>>
>> On 8/8/25 18:00, Philippe Mathieu-Daudé wrote:
>>> On 17/7/25 11:38, Djordje Todorovic wrote:
>>>> Add RISC-V implementation of the Coherent Manager Global Control
>>>> Register (CMGCR) device. It is based on the existing MIPS CMGCR
>>>> implementation but adapted for RISC-V systems.
>>>>
>>>> The CMGCR device provides global system control for multi-core
>>>> configurations in RISC-V systems.
>>>>
>>>> This is needed for the MIPS BOSTON AIA board.
>>>>
>>>> Signed-off-by: Chao-ying Fu <cfu@mips.com>
>>>> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
>>>> ---
>>>>    hw/misc/Kconfig               |  10 ++
>>>>    hw/misc/meson.build           |   2 +
>>>>    hw/misc/riscv_cmgcr.c         | 234
>>>> ++++++++++++++++++++++++++++++++++
>>>>    include/hw/misc/riscv_cmgcr.h |  49 +++++++
>>>>    4 files changed, 295 insertions(+)
>>>>    create mode 100644 hw/misc/riscv_cmgcr.c
>>>>    create mode 100644 include/hw/misc/riscv_cmgcr.h
>>>
>>>
>>>> +static void riscv_gcr_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    RISCVGCRState *s = RISCV_GCR(dev);
>>>
>>> Please report an error for invalid num_vps values (0 or >MAX).
>>
>> Per the next patch:
>>
>>    #define VPS_MAX 64
>>
>> Is it possible to have a config with 7, 24 or 35 vps?
>>
> 64 is maximum, and we can have fewer than 64 vps.
> So, yes, it is possible to have that configuration.

Please provide a test with 7 and 35 VPs then.

Thanks!

