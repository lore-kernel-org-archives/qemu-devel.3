Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CC5CF34C9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTVy-0001M4-Tj; Thu, 03 Oct 2024 17:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTVx-0001Li-8j
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:37:37 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swTVv-00080G-Kj
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:37:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20b93887decso12406065ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991453; x=1728596253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Sm7mDZsm1OFiv6VBeNsOMERVZXd/wpVK3PLm1tOY51Q=;
 b=AZJMuftUweZASX6QAjLveooirxxE20mAadmn1iYiDxivwZ/wJ4i2uX7HcxKWMlhCm1
 bIa7UQHrw/TwUekPAflvIGYTaZrLELlM+S/kXdaSt8ZPPIk2hKefzOWk9/O7eDTpE3xw
 FIsB/Xp/vhjqM1kiqQQDNZpgsW4Jwui63ZIDL+1pQhaP7zIHnZaHE9O+6LqX2HxfEpB8
 xM8AynNcH8cI44c6MXCnauJrdK6bXs6+Pg9Cjc3MQR6iw631U25+CGzGGmzPO1aMwaqg
 dwy6DjfZYsrZHgXGpKhE/lPNAdP5YQq2Wmdk1rAKfD1osHD5vwF/GXaClNkzsoR/VU3r
 WXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991453; x=1728596253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sm7mDZsm1OFiv6VBeNsOMERVZXd/wpVK3PLm1tOY51Q=;
 b=s2d1UjyL8LqBYDLFlmUp2+GxhOGizqCzjfugpPlCxXwUjwPnVUFkQswRESPprnhp5h
 5GdWQSuN7NdQde+fur7aHEgkRI+ORplCABIgmFAq048AIeU3263TKoW7Ihp0cqFaJAwn
 Jnf7e5nkuswZu02Iy83giLlR4tCy1LbOaGq2e+aB6Ez/KEPf6ApJ5X1pWwLHLCk8WXLF
 yD5QcT7PH/IzZ7DB80XT8cW+H+jdvP3eUGdfQmy0O+HLEkAkfFFrsfGHYrTdylAkJOrD
 y1ASvwatPXsxWWdwalSax4EyZJMMgiR92Xm/vuUkDGLgqR3LsCuQouyVyXTLCnF+SXUF
 dLDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX93anr41jVoH0qFdNyAGx6rEqha53GNP04ygSZZDzq9U/2UoCw2ruuDDeyIJ8TAdq1DvpTOzvQr9yY@nongnu.org
X-Gm-Message-State: AOJu0YwlPdjTz3INStpL0X5vUxtTLhtnV97HR85/7e7EvpzJ/W2W1qxb
 HRqBJ2fakKBsh+ixsUMr2UEJjLjPL5+R3kBuWnh6JK+eKfDWTNsN7b6gEDJS0YkdCfXwzJoPak/
 C
X-Google-Smtp-Source: AGHT+IELmhuKjSXjfJihVNI0XIqFZUXfqWoHJZAI1SkKibmAXUurxRkyvz3SxFeVlMW5EK5C2UWTqg==
X-Received: by 2002:a17:903:268e:b0:20b:9b38:fbd6 with SMTP id
 d9443c01a7336-20bff194b37mr6304735ad.40.1727991452786; 
 Thu, 03 Oct 2024 14:37:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beeca6fb0sm13311895ad.75.2024.10.03.14.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:37:32 -0700 (PDT)
Message-ID: <3146a8f5-7439-4566-ab24-eb0771dd0954@linaro.org>
Date: Thu, 3 Oct 2024 14:37:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] qemu/bswap: Introduce ld/st_endian_p() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-2-philmd@linaro.org>
 <4c8e6941-e73d-4504-b289-987ddf49582d@linaro.org>
 <39042725-ed09-4ab4-9cd2-52d4899c2e3b@linaro.org>
 <f2b0908d-6e8f-4625-a297-5ad189da790b@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f2b0908d-6e8f-4625-a297-5ad189da790b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 10/3/24 14:34, Philippe Mathieu-Daudé wrote:
> On 3/10/24 23:28, Richard Henderson wrote:
>> On 10/3/24 13:50, Philippe Mathieu-Daudé wrote:
>>> On 30/9/24 09:34, Philippe Mathieu-Daudé wrote:
>>>> Introduce the ld/st_endian_p() API, which takes an extra
>>>
>>> Alternatively we could use ld/st_te_p() since we already
>>> have ld/st_he_p() for host endianness.
>>
>> That's what ld/st_p are -- target-specific, in exec/cpu-all.h.
> 
> They are indeed *target-specific*, so we can not use them in
> target-agnostic code.
> 
> By explicitly passing the endianness, ld/st_endian_p() API is
> target-agnostic.

Then I miss whatever you meant here re st_te_p().
Care to elaborate?


r~

