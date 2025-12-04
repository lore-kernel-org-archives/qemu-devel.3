Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DB4D24449
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 17:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRCqY-0002kK-Uj; Thu, 04 Dec 2025 12:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vRCqX-0002jt-FX
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:10:25 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vRCqW-0004Zr-3u
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 12:10:25 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so7822475e9.2
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 09:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764868222; x=1765473022; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lrqJ+EIWHNmzugBhniJ6bKF8SnPZuGUPv5c4ZJP5nKk=;
 b=t0+/UAgYceeuOL++IzHQDrhbY8KjeE5jBrkRPw7lEu+RtenBDBFmJxeIL4FNzYoUdi
 zRcMMiR/xvENd3DKQKBAi2q0lSltrQohyTC60/cTFUHWUMkhFhIBLk7tyHSBYwsAGseg
 u1m4VLDAgoH0NeiaZcvLVeoFfF9p07IUz1111JR3YNtw2d+P/J7u5LpYnJaeijELkPDP
 zNWYrFqtKvubC16Eu9yIsbUtHmO3W7t0dr2EneAetEG8TNH4J7HMvP3SJo6mcx7cYi1X
 SbnYDzj3/5OVGGeVf+3b3TdeS5Ak1Y9J13IYFqN6GYeTPfZyGqpoZIvUXtmu6L8G/okv
 JBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764868222; x=1765473022;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lrqJ+EIWHNmzugBhniJ6bKF8SnPZuGUPv5c4ZJP5nKk=;
 b=bsgjHwcROi2MF3IZkhGTGIedgmPRdZg5Vjc0uYlV+T9CXnEQ4ZWI5OrXRZNkffNzvg
 OV7GRu8pzFBqN1OZrbWUMmEd3JRH9VsKfy6as+ujaf35kF2EOajmsF/eTakBzQsgrOo1
 fLTYvHrLU2hjnUkmXMRKAEijmnYGxh1A0d3jAA5JitEbBYcQpZ4sMg1ehp73EtSOUY6O
 xG7hlo+4lQ5kHlaFZiQ5xR9I2XGX3gWS2/JxNQX4Yv3mfrDD73MSvUyfICgDJrhRD9fl
 Rpx9Wb6jrdjpwxex8kqj6WRdY5v5qED7PYsfMzrxgTXlF8Sdu4GB3CFuRGXqfErn925t
 dEKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpf1MYiHaFM2fF0d4xgkUaH5YbTgQcuSYRWkDU75gyuqqwAECxVFdszdQQK1jpsCjUzUjyuGvF1+wN@nongnu.org
X-Gm-Message-State: AOJu0YyA9tvRemeGXBf7mOzbRxvhAe8FT5dkljz4zoIY97ex7/At3B5X
 Hxq692K9xReXJlEpREjq3BCN0MSlPUXOMoBhTW7xfdgbyseRqkj0/APJsQCn6oZF6u0=
X-Gm-Gg: ASbGnct+E8Al8BpzjcK5cGjRzVzr1tfuOqORtK5XniFQOt4GODyfWeBxMbTblJ56jWY
 9Kv4QdCcwrVEG9T/ZP0pi14Hmbd3vYm5eFF7BghQSnnCQDI1g87MLwgPhw6Uth4WIQxCgGJuqzO
 Z6lUESjCQX1W3eRs8ge9EFWP40l8/WTCjTLh0dQNrBxstc01JabKvfNpUfxQz+7OU5HCC166AsC
 +X0b4HZH3Lj8lA0hHvTtn3E7AwvRXWH+k+59czdxliAJ/b6+2AhrlydKbyLADIjNgi1cDb2jgVB
 I1r1p/l3iEtKevGZ1Kdq7Jd6UmiYHekI2PCcb7KjDz0HSvYjlP1D3toE+JXXHvzWxsfUPJ8vfVr
 0UnhLvm8UT4tRwl3NwDOEENcB4Ne1jOOqWlMeoVT7dQpS6SB0zSoPigPewsl1SP+iAoF/KOdtxo
 ANvUzb6uYIt/iylzwRXnjLVtO5glH8KJroe7bzo1ozTXSkU68Unjw6pQ==
X-Google-Smtp-Source: AGHT+IHc4OsHmI+o7Tz3HaO6+iyC0gT1XhBcDYrEz9OCS56uEsWE/T/ZuM/2+s362E51rlzaEpoUmw==
X-Received: by 2002:a05:600c:1d23:b0:46e:4586:57e4 with SMTP id
 5b1f17b1804b1-4792af34a51mr86690425e9.24.1764868222083; 
 Thu, 04 Dec 2025 09:10:22 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331092sm4213202f8f.30.2025.12.04.09.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 09:10:21 -0800 (PST)
Message-ID: <79d812c8-0e09-451b-84ed-376249a7eff7@linaro.org>
Date: Thu, 4 Dec 2025 18:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc/kvm : Use macro names instead of hardcoded
 constants as return values
Content-Language: en-US
To: Gautam Menghani <gautam@linux.ibm.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, rathc@linux.ibm.com, pbonzini@redhat.com,
 sjitindarsingh@gmail.com
Cc: qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20251202124654.11481-1-gautam@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251202124654.11481-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 2/12/25 13:46, Gautam Menghani wrote:
> In the parse_* functions used to parse the return values of
> KVM_PPC_GET_CPU_CHAR ioctl, the return values are hardcoded as numbers.
> Use the macro names for better readability. No functional change
> intended.
> 
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>   target/ppc/kvm.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Nice cleanup, thanks!

