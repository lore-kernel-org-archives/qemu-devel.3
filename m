Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CF8D185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdoTj-00016u-5d; Thu, 08 Jan 2026 06:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdoTh-0000sY-Ll
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:46:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdoTf-00089d-B4
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:46:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47755de027eso18396175e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767872814; x=1768477614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2JDbdK45mIUPKJGeNRn9DMQnT4QZOmUblyKbsYsXToc=;
 b=DxeX7Po9t7xxLdESSo2tCbcit9PfSBR4PzmwSOaBU7c4sgDWztKjmdvUdHuOcWVjHg
 uwomwtXb7isycyvMtADRIq84EbnW/tZodysINHf6Oo9wcDVlV5p5cZotFN0jJb4whNkN
 e5LOqYHmhH611E7LGh4UYuHU5hlPYcXFoqG07XYTDweHGIG80kQXKXapiHjaNV77RH7r
 3A47AvIs+X9brAedSiVLlp8F2ec87HmZQlxFx7tgAk6CEI90PmF4FEuuUrSuAWMt0fNI
 KamxoG6ke2j374+MBgqD+xQRIDVso40j9oRqmJnQbzhzH3qEzeaPX/pdc7lKXcToD0Qu
 UckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767872814; x=1768477614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2JDbdK45mIUPKJGeNRn9DMQnT4QZOmUblyKbsYsXToc=;
 b=rGvBLXma8uYGRr9L/ZHz5IUkBRrmNja11au2ekCxbFnkY42auheU1qtNVO9Znrbiad
 LP2yyNYAopst9xTZB3RAixm+NVJamUj41Po6BkGxE9sHRyQx2SnthJWAD2dxroal7i8p
 g7JJ7JrFSBtzHKPUaBMsou3HcmZM5z9L2yBzvC1w38TIoTm7dPPFRF67o/RuTwt1kIfU
 ikIQsBAgtFdfTxK4bcdeTjFZzhA+e4RlORd7O2nNwhpdObAbSFfA7fOmkRZCTzYECMj2
 21CcVJfWtABWfwoFileiJ35NWNEkZIrh9VW54MxQuzVAtXg+ZTM0x5BzmJ1mPEEftvGM
 Qpfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7LZx4Vb5sHNrNlyE+4sVsKe8IjR4JI/V8x/XEUG4Z9fn6ai7y94kTRxl3rGr/jmMhfLm8Y4lTzyh1@nongnu.org
X-Gm-Message-State: AOJu0YyoUeLyS/3FzXw5Ci+ypwSICiNWhIYKIZmn/rBxhghiFq2ah8JI
 qWMm41fxF8F0G53r+3XB741rIoAHM6rBIwbIl9uUZnzQDXq5hIBnJONhVODJA4L8a6E=
X-Gm-Gg: AY/fxX7RejjQ6RNo6f6HK8gLIO3xUoHm75Rb1thnTY2nIxBbXG112TUjVJ0u+L7xF6Z
 coD0SE4hsYCAHkJhBWzzsd5W6m5oEMywtNldaIktK8M+m83c4iOCsjkqrYPF72EfH6iiLvsqlSt
 c8FKDgu9JdOLV6bCDyVV5n38mKOBDSnZQwpn631R+/BkdtigvPfQkr3EagipenS2uVsbHcBUxTq
 OSXQVpjaFkf7cLbblvALEg3Y0w/pkx289InH5V1zJe922u7r96YfP8N03+Ycnhfm/s4CbgodrNe
 nwckBTOp0Pe/NmpAM6QAj2Sh8N50Vg6Epk5dv9HlxiYOgvsZWHKks8cslAsx0lscvg5/YRbc8U0
 sijAhFkQ0e6ETBca4yE9g8AfLe0G/l0NilaZDu8Nekh5GC60BiqRmYrIxmlLndCB0bd9a7yMa1p
 GDgEtXZcywii5vEWNXEycBZnZPaKhhZcKGb+uH+AZuos6X6e6B4OkY7g==
X-Google-Smtp-Source: AGHT+IFcwd6Ks4T1mgDxI5bOPAoQXyNJAcpa0sBWa7Rexf6uBHD3Y/Rt/vvzvi58WiMP+D8N+JEcjA==
X-Received: by 2002:a05:600c:3b90:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-47d84b3864cmr74983985e9.27.1767872813509; 
 Thu, 08 Jan 2026 03:46:53 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7053f5sm144596785e9.14.2026.01.08.03.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:46:52 -0800 (PST)
Message-ID: <0fef147f-8268-47ae-b037-ce7d7063489a@linaro.org>
Date: Thu, 8 Jan 2026 12:46:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] target/s390x: Introduce CHSC_MAX_REQ_LEN definition
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-14-philmd@linaro.org>
 <5302604f-0fe5-4dfb-8baa-f072e279504a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5302604f-0fe5-4dfb-8baa-f072e279504a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 8/1/26 08:53, Thomas Huth wrote:
> On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
>> Since commit 166f1bb7968 ("s390x/ioinst: Rework memory access
>> in CHSC instruction") the access is no more tied to the page
>> size. Define CHSC_MAX_REQ_LEN to better express the relation
>> with the length of the Channel Subsystem Call request.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/ioinst.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
>> index 2320dd4c122..d07773d14a3 100644
>> --- a/target/s390x/ioinst.c
>> +++ b/target/s390x/ioinst.c
>> @@ -398,6 +398,7 @@ typedef struct ChscResp {
>>       char data[];
>>   } QEMU_PACKED ChscResp;
>> +#define CHSC_MAX_REQ_LEN  0x1000
>>   #define CHSC_MIN_RESP_LEN 0x0008
>>   #define CHSC_SCPD 0x0002
>> @@ -660,7 +661,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t 
>> ipb, uintptr_t ra)
>>       uint16_t len;
>>       uint16_t command;
>>       CPUS390XState *env = &cpu->env;
>> -    uint8_t buf[TARGET_PAGE_SIZE];
>> +    uint8_t buf[CHSC_MAX_REQ_LEN];
>>       trace_ioinst("chsc");
>>       reg = (ipb >> 20) & 0x00f;
>> @@ -690,7 +691,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t 
>> ipb, uintptr_t ra)
>>           s390_program_interrupt(env, PGM_OPERAND, ra);
>>           return;
>>       }
>> -    memset((char *)req + len, 0, TARGET_PAGE_SIZE - len);
>> +    memset((char *)req + len, 0, CHSC_MAX_REQ_LEN - len);
>>       res = (void *)((char *)req + len);
>>       command = be16_to_cpu(req->command);
>>       trace_ioinst_chsc_cmd(command, len);
> 
> Sorry, I don't quite get it, there are still dozends of others 
> TARGET_PAGE_SIZE usages in target/s390x/, what's the advantage of 
> removing that one here?

The other ones are also used by user emulation so need more care. This
series addresses all system-only files. I neglected to mention that in
the cover :(

But if you think this is better to review all target/s390x/ conversion
in one go, I can wait until I finish the rest.

