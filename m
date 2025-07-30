Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB959C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhER6-0006Y0-P7; Wed, 30 Jul 2025 17:34:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEQz-0006TO-A1
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:34:03 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEQx-00049E-RH
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:34:01 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7698e914cd2so339490b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753911238; x=1754516038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mMHx34O4NsGw9UH79Et5gZ4bJQMTwO/qHQ9U7UMQRWk=;
 b=s7W74Dx2LK9PsMg+x2GbGNwJknxqEkNOeuSMVSlE6Z0uxzjuzLiajIKvSEATEVqgz0
 6sfUU8sqWtcidnIdMJ2gATWr9yTSTT4HkI8Wipss0HRct2OcOyMFjlxWIfbG3/p4/fEy
 EKqkAkZQOlcDf5tV6GXapxZywH3ecOMvxr6+LFoArNFdHJf/ZcirApWqTDbnpIwy7sHw
 /gxwSY0v7owdtdxLk5ujir451cRr2mT4ZybPOqTeEM85QxN0fXUZBA969eimP6dz4u8o
 dYanBdmHZw4LcVbniDnmqnQZqTx6dS+MSwhgNOl0iroWJLGf1ZAcKnRYRnm1+BI23M2O
 pmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753911238; x=1754516038;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mMHx34O4NsGw9UH79Et5gZ4bJQMTwO/qHQ9U7UMQRWk=;
 b=QEl7f+NuqrITyYEiTReyGSc5H+yQCDHDs2MpnqkyRud9QB8+3aSqgwJZ6IfWhU3QGb
 viiSAsC5S+is6i9Vvk8X/zSrEpykvnOB2NjvT9JdlYW4xb16QMXz7Ud8NaVKD7DSEjYf
 LXlGNjzSOsasHJkSKsh13PjM6qGZjZlrWy88rWOa42ZSS0wFJT7+nO0mTkMpKhoevJ1Y
 eKhAx8qTi8uFPEyNLeuNhon/0hUl7gBuMQKi0A4E4ugOXGr1bPnOXQzPeD26lT4kq0/g
 gM1sJbwR+v7RUZpcq53j9L1mGmP6by1gymkI+wAKbAboYIO8IFcF2uBgebpoFU+e636F
 TG9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjUDDFFdxU0IwvmaQkyT+bG8LsCzyN0l/HsZ1T6s166P4aIfR109ZYIYWaV5yxu/rISm+/5lregSTX@nongnu.org
X-Gm-Message-State: AOJu0YzRqyaZJkGKo9PXTWk2tKHXYqIipV9FcoR7QGKk6ZavbIzhNb2p
 owHh/TqcPY7E8AqZ7SENJE/nxbsi4Zx7eIZx+5pXqCytYUF7g2hvE5x35s3Cm5RKK5M=
X-Gm-Gg: ASbGncvRXpm0m+0J7es0roTKjW63sA1M/j4oYfo7sh0r7IpHSPeIG9RcK47mka45UhO
 g20R/HVkVsx794Nqww/V+3EquHULk5Q16THQvgu3iCh2ycgPhc0/SzC4zAZEsNBX5aMlWW3yPwp
 /hz4rI6ygW7W4emOmXmtsBMCRVkkN8Wk7Z8aKTW918eNTfGO5ZEhFvQr7u82nRtsWkjTDHwHwZY
 uNfXx5VI4rtEIOxoNTAPe86fN7Swcykk1oF6ZtfKGspzTClZq7vznoTDMh/Yrzg3xygWn8hU3kj
 0BuZXW2wwSyXD1u3k6adHZpjfNVjylAwOHDmCRUr4HkoPwC/i/qrm+2HuYjWVn5BppBfzyYy613
 vVZGeEp942qwMlJ9WSD/FE0W2A4wHhGVR6cTxDf47ItRhfg==
X-Google-Smtp-Source: AGHT+IG+q4m1W4ROGBqq6QPWhh6uQgEw59VufiFJrMfBCpHDx2Q3qKO8ju3Bg7B8wndk9w6MNttY0w==
X-Received: by 2002:a05:6a21:3299:b0:21a:b78b:e916 with SMTP id
 adf61e73a8af0-23dc0e99a32mr8229520637.27.1753911238263; 
 Wed, 30 Jul 2025 14:33:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422bb1133fsm10892a12.56.2025.07.30.14.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:33:57 -0700 (PDT)
Message-ID: <656b2c0d-bc87-41d4-bdef-38ce27d43e13@linaro.org>
Date: Wed, 30 Jul 2025 14:33:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/82] target/arm: Introduce regime_to_gcs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-42-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-42-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Add a lookup from any a64 mmu index to the gcs mmu index
> within the same translation regime.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/mmuidx-internal.h | 10 ++++++++++
>   target/arm/mmuidx.c          | 24 +++++++++++++-----------
>   2 files changed, 23 insertions(+), 11 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


