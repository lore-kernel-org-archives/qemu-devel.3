Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652F7C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 15:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJmK-0005tU-La; Tue, 06 May 2025 11:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCJmH-0005pV-HK
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:00:14 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCJmF-0006yc-0z
 for qemu-devel@nongnu.org; Tue, 06 May 2025 11:00:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22e3b069f23so11001085ad.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746543608; x=1747148408; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pBIxnhAQsEILjZefujtHOHBQ1rBZl+8TQ64oVxp+eHs=;
 b=HSnOdwOD5pWOzSUqzUC0Ra0i9Sji4fsNAWTuFTq3w9rD2skQ7ooy2piXxv2ap+LDdb
 spqbUoX8f9zE9bgFitM5rq52yuffRbFOGThLRmdWoC7CHauVAnIhRTqACru7Jjm/LF5B
 XZL3KzbNd+LQTIPV0eHN9IEig93OvGd1aFcvZevRqf9ulfGhIzNui4DI3EWr9nmJncCS
 6wNWLdWAjR2tyjnUuCreTIqG6zG1H8XcF84eP2tApMA5L/NjM86bi1nAuc3GUqcqf4Uf
 pP5raVvgO7eosEJ4v7d6hDPN7tlMhY20BYV8KMJEgCX1De0GsNXb9XbUIHzZHteM8nKb
 ab+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746543608; x=1747148408;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pBIxnhAQsEILjZefujtHOHBQ1rBZl+8TQ64oVxp+eHs=;
 b=BrulJHOT/lk5w09DrHGEXlD7OCLp77fYxctOTjSup7U61hLflbU5XaIbfzKJ4MtUhV
 8HbhOCoMhMWprUkrsRPoha4oIhDOUZV5WLGr92bZRO3cpfDb2DJEXgvUAQheLssbU30K
 Gsn2PIN/qGwacUo97k10pAd4PEO9houZTlZYY6XYOeB28j3CidN2JzAjmWXIHH8y5Yh7
 xdHYB53K91yDW5xaTYlCEG310LzAYxGAZPz2K5dAC979h8CUN93blKY9exf7VIZjbfJM
 95FC+wFtp20+iAvsTl6TjTq3tohc1nkR8c/rS3YaEd6MaleyYCJCsw/KJnN8XwXVWG2x
 xy0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVInUKN1CEPM3VYK5pLioijluArfLBUcP2GrcAY8JIFA2uZq3NtoNFsrwpJbN9aWh3uSzusI+l7WgK@nongnu.org
X-Gm-Message-State: AOJu0YxxK6SWw08mZ2T44dGxG12Ol8Oe1XvT8c7+RD5FG9jwWTVJ/GqU
 H0XLL6QNzs+C2TS/mTyENQ2/St+YQdJL74SO+yuBq9DfkPa73W75wi5JdsPDaaY=
X-Gm-Gg: ASbGncvoou20WMg/kBNUyK/xvYbt279hbQ3hmHlxa9wuGkGlW9J+3OIyL71WTBeNI4R
 1rjj40oX2erjKWhOXSPrQ6wAE+9Hke3lKdZq5ZsV/+nCx2aGpAQRy1RlJeXUXmVcFCaEOHONxs6
 5FrTKqpfFWplDOjF4mHpBD7yM/l/33aQUQl6rHlfc8YK3XSlSkPme1HmX2HoKDNoSRgWMBRyDIQ
 p4yZF8OrGkYE6xQzBfNPqHoSVd6MxRVuteSxeFUCeFTV6317aExxOGAyFQeeIceGi+QunsQGVKZ
 p1cYWabYhXzelN06uunJ5pH2+puEpgQiqjCUmgKBua5hLvqD0O9f+A==
X-Google-Smtp-Source: AGHT+IEUkHaF5E35Hnl3eCa2z4u5PqiWQSJv1iD2htSYzp8JYAWHWyYj0T8+ZrWuNwJs09Jp54Pkog==
X-Received: by 2002:a17:903:124b:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-22e328a2987mr37432485ad.8.1746543608403; 
 Tue, 06 May 2025 08:00:08 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522f966sm74381525ad.233.2025.05.06.08.00.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 08:00:08 -0700 (PDT)
Message-ID: <83592019-4f14-4fdc-80de-83474b2804e9@linaro.org>
Date: Tue, 6 May 2025 08:00:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 26/39] system/hvf: Avoid including 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250403235821.9909-1-philmd@linaro.org>
 <20250403235821.9909-27-philmd@linaro.org>
 <704012d9-cd54-489d-966b-99922774f2e8@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <704012d9-cd54-489d-966b-99922774f2e8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 5/6/25 7:14 AM, Philippe Mathieu-Daudé wrote:
> ping?
> 
> On 4/4/25 01:58, Philippe Mathieu-Daudé wrote:
>> "system/hvf.h" doesn't need to include a full "cpu.h",
>> only "exec/vaddr.h" and "qemu/queue.h" are required.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>    include/system/hvf.h     | 3 ++-
>>    include/system/hvf_int.h | 2 ++
>>    2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


