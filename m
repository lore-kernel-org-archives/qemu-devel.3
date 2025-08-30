Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B245CCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 22:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usTe9-0005oN-I5; Sat, 30 Aug 2025 18:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTe5-0005nM-0i
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 18:02:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTe3-0008Fj-Hq
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 18:02:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-772488c78bcso338403b3a.1
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756591317; x=1757196117; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hNqvXFQ3LJkmAJC3cZaiilNJgOnumTgENWlABLjMcDU=;
 b=U5I94qO0ArnvdPJ5Nv5dj6UAGZRP88/NZ73GfFIQ46BdN9ytNvoRmNkIXLzQsh+CgZ
 9irL/+uT6Ihun/FY9hn21d7Z+N8yfUj0E0aSJGhxjRNLAHAdBBC24SJKnjflZ70oN3Kz
 tlV9hf5pHsCsQcMFkjXk7WY5xB6cRAfjOFK2YKDxA1a3EE22C+KFECpdwM4HT+B8To7Q
 KVwIUDY97fCKG3+Ds0oVzl5nDJ8Ph0eqsgXBsvi1a0wfHqb/LrulAGnDCaqpMX0Eqs1b
 NSmqpAMH6ckQxDsQybOeb/zDDPJGTQmascGlcZk4mk4KqfVr+KIOO1Xr9V+oLMJv0OMi
 DbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756591317; x=1757196117;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hNqvXFQ3LJkmAJC3cZaiilNJgOnumTgENWlABLjMcDU=;
 b=NTXxLpsGd5jj4xWRceIk0ipqRf62dMeYS6d6XluklD/Jw+yRmEd/pHPLxxnmlcuDT2
 GM9N87N/EYjolbvXgpmlkHfMn3QOcI8IbjBVWmcHN2C2d5oRtjqjvys7CV3U5cwIIhih
 sbocrLko+93p4lhzwlESSmEAL+jtba44NzNdcAlttWMelRmNXB0/pxOncECTdE8XKIXn
 0uQQMthZznyx8Qb63xcJH8H0k+CLupGxnpE+jm1jS+h+A+8ken2hJyfphIziByDiN+/9
 5V/pKo468guDHT13fmhTcrtEZftjvkIlrSZQ4VkUJSA/cQBXIm1xcrR/7uQHGHga30ZA
 CoAg==
X-Gm-Message-State: AOJu0YycqfaRwbSyNYTwK3cpQ0V+FYAp0onV7JjdNMsGCkgzPaoFNjHR
 rBmhgxbs/xZZYIvLfAiy4NXuy/pyHV8eJ/ikz2he+CUQapndCNmz5cBmF5yUjTcbxPWe7I9y6/u
 V4o5Rvh8=
X-Gm-Gg: ASbGncts5A+z95zc8v5LcxmguRy6MFgsi/V3MFrvwkXg9r14AsNxgXHfsGH6xVhbuNd
 aRNMUmCnesiJwUPFX3JsGrVEBGU/klzYPJr/A5gLDKMHbZUjao1KpN15uetUc6pbyTkECpkv2cp
 tFIBqPHAwo0jFhh3oYi0hSxq8+Y7czABZCEvk8MYzeS8jv958diBO5L8aYOWmra+ewdXH7Mi9D2
 PEpPHgoYLkX4+ctFW0uN/lb/Fwgm8oElEvLiMOUXMsIzV+kbAfswoMpcjX6zNrWVAukbAxn+F00
 a6uRG330/+9yDhZ55cILlljUcQxKnLvqGJZFBCtgGnMYLC0wKlenHbUjGc2zcYIKe2EPdt1bYiy
 V8HUvK+9sBxEt7c6jpmmUDfZACNm74V96uIiPadsne8UXcWZbaZzRy8pl7ZQwdKsBfffdETszPR
 RwQb5y
X-Google-Smtp-Source: AGHT+IG7GQpacE1Dbf2GizJepz3SwW+207g6S2XOdPGbG4bQhX3mvEVNbWjZ20NCB524Kv/c2zU9uA==
X-Received: by 2002:a05:6a20:12cb:b0:240:15d2:aa7c with SMTP id
 adf61e73a8af0-243d6f04cfdmr4553756637.36.1756591316908; 
 Sat, 30 Aug 2025 15:01:56 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-48.dyn.ip.vocus.au.
 [122.150.204.48]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e546sm5513262a12.4.2025.08.30.15.01.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 15:01:56 -0700 (PDT)
Message-ID: <3385c184-d58f-4e69-8391-951b40ff43f3@linaro.org>
Date: Sun, 31 Aug 2025 08:01:50 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] util: expose qemu_thread_set_name
To: qemu-devel@nongnu.org
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-5-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829180354.2922145-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/30/25 04:03, Daniel P. Berrangé wrote:
> The ability to set the thread name needs to be used in a number
> of places, so expose the current impls as public methods.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   include/qemu/thread.h    |  1 +
>   util/qemu-thread-posix.c | 30 ++++++++++++++++++------------
>   util/qemu-thread-win32.c |  6 +++---
>   3 files changed, 22 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

