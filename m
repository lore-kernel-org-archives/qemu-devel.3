Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1B1D2F7EF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 14:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRWP6-0007QD-DO; Fri, 05 Dec 2025 09:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRWOr-0007O7-49
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:03:11 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vRWOp-00085Z-HK
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 09:03:08 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so2363138b3a.1
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 06:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764943386; x=1765548186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+zr++WMAoq/zWzR0EF3sgGRqoz9KimgdUBqgyKJx1CA=;
 b=dNXql6ftfhQafWePLyiLYUNGVkivXaaVsUttLDukivKlwjFr/FsTG1HrCNWJpxtY4G
 nY6Vj/V9iRs8Hjd3zJ0hWs8VfJA7rPuDAr/157Z+LwgAXpYmXFSb+wvx4Onr4oFGK8WL
 xxk3On8Z6E6L7Us7bOulFGk8t1dYorJvTWU14z3m0vjeP6FEOwF5u4HPwVRJAUICJc56
 TRppELmWATvCAuSSnUQ1OolKvahAgLYUxuZcbLJ9DsKQqJ2fiXbZ1iQbabnpaOfd6NI6
 p6mB9fduR/S1qubKB4H1QxBGneqKZ1WQgBE/FThNpAfuU89He8iQTzIYer7Sf4WsigZJ
 BLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764943386; x=1765548186;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+zr++WMAoq/zWzR0EF3sgGRqoz9KimgdUBqgyKJx1CA=;
 b=nuXHZI0pW07+IyYz4urkhxoVLlSuNupPq/bxHtkSBMExrOXZdst4IZoK4kkcCxRxY+
 HY9q6WxxgImfdFHw88ARl3UHpjyCt2FcYCS0Csw/X4JvioIVYEuZzIwLNcfym4417XsE
 Cw05j3x9FX3u3wGDYkh70WVZF5DhNKxBNufaj8HNvJ8xnaZmiHPKLYjnQZ8iIxKLqN8c
 e/djOW6FYKOh/pNkUqr+pgpWDYEhFk5B4Agq0x1IMfRA1g75vSimCUDsybtG0Hduu4RR
 qOK6/Rs4btPPlsxhy0ximj3BAkRXeySB96CxseWwockmvgd3FzUk2zb38YSS2d5p//VO
 6PyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSUtH1nlyJNKvduk7DdEoDq4xhiXvrmNf6L3Jojy8ooPwwnROIIrCy4fnDHJZCFavlpZUWtBcvm6od@nongnu.org
X-Gm-Message-State: AOJu0YxXO9mAvEZalR/qVUyFq0zuLPW3mgxwLdB2/JjDTiJroQgd0CeI
 E5ZioGvQh2JkGQyjKYslTz2gV+ZPjPMUObaytL8D3ZtDSSc2wRWE7w0poAVKi9dJWzc=
X-Gm-Gg: ASbGncs31zmr3z7n+sjoSe4dUzu5vXhQ8/9k+P+ZwOUn6dEuSNV5TSRukTLktKAkry7
 ZwiMbUdAgbQOSyvJz8gJ32dIDDagjXoGJQQZySUzEnrfaatpmgxA5p4n5+17928S5JFdPRL8ave
 lgj0rJHI0MDYxZ5Vzn0zoOyo0rSNpplcAAzWJb7nCLsBKwQ4eejgbDqLYI0yfU5XlVx/AU96DOd
 EhGZd5sn2iRgdqohoQ/3WU5G42wDkNOEJdDZFLU+A4YmMCUAjWGO8D8goU9uQf+ySFXzweVTFDn
 TN1NBLVdW9krj6jU31L4sgJ180im3lEyi3RNneDJM3W9RZBKTw1CsQlBQWbh9jWTzyvoJfIhuEu
 1xYHFJ98lBo4zntft/KSHBfMxTrTEAx9UKsgl8OmvuM3Kn2iR+d/Efkx1fmir9HMg1dXiFUnL7z
 yUmlrk5d+3WlVafEmAJO1Cdo4a4CltmuBpypSDZ0XTM5TR8iCy6L1k2f4=
X-Google-Smtp-Source: AGHT+IGxuYwSovC/Jx5JdbvwATcbJxZPb4PezzyzGgsaZP7TpyjQxR2O8ft4u/M1mBTFxi38zAj1iQ==
X-Received: by 2002:a05:6a21:888b:b0:364:23fb:ce6d with SMTP id
 adf61e73a8af0-36423fbce8amr1463177637.4.1764943385508; 
 Fri, 05 Dec 2025 06:03:05 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-bf686b3bad4sm4883415a12.10.2025.12.05.06.03.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 06:03:04 -0800 (PST)
Message-ID: <2d7b3576-9ebd-4124-aa80-7ea18526189a@linaro.org>
Date: Fri, 5 Dec 2025 06:03:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/uftrace_symbols.py: unbreak
 --no-prefix-symbols
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?S=C3=B6nke_Holz?= <sholz8530@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20251205105614.13673-1-sholz8530@gmail.com>
 <77c23b93-249b-4e0f-b26b-130a3c66c248@linaro.org>
In-Reply-To: <77c23b93-249b-4e0f-b26b-130a3c66c248@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/5/25 6:02 AM, Pierrick Bouvier wrote:
> On 12/5/25 2:56 AM, Sönke Holz wrote:
>> Since 8a545a336d, `name` is unbound if --no-prefix-symbols is passed,
>> causing this script to break when that option is set.
>>
>> Signed-off-by: Sönke Holz <sholz8530@gmail.com>
>> ---
>>    contrib/plugins/uftrace_symbols.py | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/contrib/plugins/uftrace_symbols.py b/contrib/plugins/uftrace_symbols.py
>> index 45fb79c7a5..21704541a6 100755
>> --- a/contrib/plugins/uftrace_symbols.py
>> +++ b/contrib/plugins/uftrace_symbols.py
>> @@ -98,6 +98,8 @@ def generate_symbol_file(self, prefix_symbols):
>>                    size = f'{s.size:{addrx}}'
>>                    if prefix_symbols:
>>                        name = f'{binary_name}:{s.name}'
>> +                else:
>> +                    name = s.name
>>                    print(addr, size, 'T', name, file=sym_file)
>>    
>>        def generate_debug_file(self):
> 
> Thanks for catching it, I was indeed always using this option for testing.
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 

@alex.bennée, any chance it can be integrated for release, when you will 
pull Final fixes for 10.2?

Thanks,
Pierrick

