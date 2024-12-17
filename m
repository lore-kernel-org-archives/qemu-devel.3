Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A32E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZMz-0004KX-Eq; Tue, 17 Dec 2024 10:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZMx-0004HH-9L
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:20:19 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZMv-00048A-HO
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:20:19 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43635796b48so22032075e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734448815; x=1735053615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3XBk8Jjn5DR2szWJNgkjKw+0Pf3QK5WLRr6yAt6muaw=;
 b=vAFy2EYMTTYQxWYenrEoDlVNv1bRcy8N9+azomCniTooiZuaWrGyZNWQ5QsOritzLu
 AoAx0E+Ti9DKLZm47ElRmoEp2Dq32pZ4LX3W1cf28xzhqhRhTfVQp3rJ7rtw5wUxsNHs
 PLDGnEyVoEGTx+CCjxGsWhjDvd+pOsKMt1FzdKVV6MsEAZ+5/ceJa+qEKMiV7GKLwdZu
 DofP965u5M2R23UF6ZirWIriMGVy86JKIYqvVIBWNEw3Aj1xvDkXO6d7rWiXn53R/ajh
 KwOopyqElXB/HTPEOg3HUbn98q3o/zyIIA1CCPg5KiaWWA7kq3k3ugFAkm1qayoW2QgF
 JIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734448815; x=1735053615;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3XBk8Jjn5DR2szWJNgkjKw+0Pf3QK5WLRr6yAt6muaw=;
 b=ufQpPcvwJYPxPtgXmObcrmJjTF+uYc7KlV9z0nkjS6AeB8c6hH1QvjDzfKQYUJWNAk
 zW4//cG+zdumnSXwWurFvRFj8UfvAMfrVuUAvtuxRApLlxt3c9WfcN/8LaopUQSFDxr8
 +qzxwlrclirtxB3MJxo1CL2Dz+1riodQ5pnv740OP20vIJksLNUMowNNUDWwhCOxkkbZ
 XmMi6d0n30Ixt7ZEHGjc7HzCcvkCXbNBjjMHJOry0Mgj+W8Z/BHlIhn0BCSI0rcbl4Z8
 7DhSdCwh8zXI7f/PHGtd3TinO2JisclzcTGezSpos60E1Fe73vAPCkqFi05+F/gEuEJf
 VYvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4ZM4JV5HFasjAsrVLpHUgb/wZKW4+c04rzu50OMRzWmLXWCpfz3ALyPowUpfO32PzoHZiTrQ/SqET@nongnu.org
X-Gm-Message-State: AOJu0YzV0jypVUF/AsMLU3N6wMJJq9bZIgtEszfk5YTBQ9IJrxp9vt16
 NYRoEI7EnrPxjpPW7VDDabS4SXsYAdlfDVBC+LhKBEcYJouS92qFJl5nqXg7rg4=
X-Gm-Gg: ASbGncsqzMoYAPXnBujSqAhdpL3rnDtgSecjxOB9C+INVybNr9WJswtgY+RGFlNrYSd
 LKiaerxRoPgyV8lIUZIeVJCSLrRl8Z1mM4J/LmBhMRutBsROp28YquL93QBL75W4IpKFaIOHOec
 TxIz4v5eOPJhMB5A1Eoi6lqIvwpmIZnuu4aidjQ83l+RvLpjOlgK8sijkQtNyf71bbOsit+9BnB
 +AcFQdZVtNDWexDNIhv4PJcRQYcdjLx2cPwIAJNFUghAiz/F2wae3Ehvht3+KEh5z6qqcgz
X-Google-Smtp-Source: AGHT+IEVeqsXuNFGqhhhRpdo+vYacFvNZidciwLuAAkJJnA+nopy+oDMdfNqlV+x/GjuVVn+4XAlqg==
X-Received: by 2002:a05:600c:3516:b0:436:1b77:b5aa with SMTP id
 5b1f17b1804b1-4364815c7d6mr36013015e9.8.1734448815574; 
 Tue, 17 Dec 2024 07:20:15 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364a376846sm22946685e9.0.2024.12.17.07.20.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 07:20:14 -0800 (PST)
Message-ID: <e8b9c9d8-c838-4418-8af0-b1e009b41e3c@linaro.org>
Date: Tue, 17 Dec 2024 16:20:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] hw/arm: Include missing 'exec/tswap.h' header
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
 <20241211230357.97036-5-philmd@linaro.org>
 <0cd4b1da-eebe-425c-9a6b-b712e0a877e0@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0cd4b1da-eebe-425c-9a6b-b712e0a877e0@linaro.org>
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

On 12/12/24 00:53, Richard Henderson wrote:
> On 12/11/24 17:03, Philippe Mathieu-Daudé wrote:
>> Some files indirectly get "exec/tswap.h" declarations via
>> "exec/cpu-all.h". Include it directly to be able to remove
>> the former from the latter, otherwise we get:
>>
>>    hw/arm/boot.c:175:19: error: call to undeclared function 'tswap32'; 
>> ISO C99 and later do not support implicit function declarations [- 
>> Wimplicit-function-declaration]
>>      175 |         code[i] = tswap32(insn);
>>          |                   ^
>>    hw/arm/npcm7xx.c:326:26: error: call to undeclared function 
>> 'tswap32'; ISO C99 and later do not support implicit function 
>> declarations [-Wimplicit-function-declaration]
>>      326 |         board_setup[i] = tswap32(board_setup[i]);
>>          |                          ^
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/boot.c    | 1 +
>>   hw/arm/npcm7xx.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
> 
> These could all be cpu_to_le32, since TARGET_BIG_ENDIAN is always false 
> for qemu-system-arm.

I agree, but last time I did that Peter insisted for tswap():
https://lore.kernel.org/qemu-devel/CAFEAcA8Exn0VMzM1h048q4Nm7toxkpaOv4B-ZE4FEXKgHoqy7A@mail.gmail.com/

Peter, was my wording in that previous series not clear (in that case
I can try to clarify) or was it OK but you reject the possibility of
using cpu_to_le32() to remove tswap() calls?

(Here my goal is to have a single binary, so I start removing target-
specific endianness).

Thanks,

Phil.

