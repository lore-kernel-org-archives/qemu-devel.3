Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD3FCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 23:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umhJ8-0006m3-IK; Thu, 14 Aug 2025 19:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umhJ6-0006lv-QS
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 19:24:29 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umhJ5-0008F6-8l
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 19:24:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76e2e629fc4so1635124b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 16:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755213865; x=1755818665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dwuUP7BR7tB7zQMpJ1v/PGsO1gy18oreySvWaA5hmWE=;
 b=Gqsvf5E1Nqyd8BeO0oI7hgRY2Zyumh93PZeaLtybXMI+cgT/bIgxrhOaj17aC/Uxdx
 HicmYvvD0Lxbw9A20jQtAroCRxVu40MxzEzfpY4I/mDoXCGaRgleG8ozCVOo48z0khNn
 8//9OviWI+MFtSUqIXCjHMAbijexhQgg4LiJKrdYTNzBbnutLI+8WteiaJxpTQPWx8mI
 oHWr7ahLQ+419zNuWM4Av2yAcdtGoockbMwWorkQnHmESdBPoCx5Vj4rzCiQQA7d1nM9
 ez9N3G/VvPyHQQZDNR9rAlbkZp4FlqvY1psGZM9Kck0jM/USwCbhu0WMxMBt/CgcgPWX
 qKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755213865; x=1755818665;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dwuUP7BR7tB7zQMpJ1v/PGsO1gy18oreySvWaA5hmWE=;
 b=lvuqgOJ4mzYS8jWED0NcXO7nY7CbH0YGRMYdJHutyC/Bm3Gi+RdhEaEE2VW5AfdWjb
 qqFhhvLo03cbHq0fNkH+dT+ozA3yd4igND5PaQNWhL8R8NdQVhlDpDaTGb0BRTUsEn8j
 HmZ43j6C5ED0PRnIpc7bvNJ9gSVZEqcpT1LFXkBcVL6ki/UT5BzLXmRt4wyLIjDrvUKw
 mz+5XexLhJotSQ+Mqu6gJuFmdSWE26yAEapHtB9jPxQv1+HqaoFKp85r4m9sVF6Dk6m+
 R/X51uBK1bYEhpsilZcrBoVfll9+dO65Wenq1GBSXZrH83gj/Zq6eM/YFmlAgCUEmHSW
 Kqbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/FMF4Nuawmgcirz07phwAosTzK6I+RHDS1tctJSO/pOoH4+KOJfBjyr/d6vKPs095UZasHKwFEo2Q@nongnu.org
X-Gm-Message-State: AOJu0Yw6xn7hMG36y6uPGHW54NhwnNpQvL5an3n2YRcHR4JumKcAc5S5
 /qFyEuc1dQJR16wESdGwyg1xNtQmLz8F4Kl57U9/vPtU8xQLyVL9/GdMp9qpC6d/OPu0xIx0qPo
 oMC00H18=
X-Gm-Gg: ASbGncs1wfJ3rj/khhd0qDyOnZA5znZqSHU++EQD8I57stXYNTs11HhS+6fwWbc9dWz
 6XW6UgB/0jsYUdGk0GNyXZoGB3zbCJLRULG0gv/U/vZrxbGaK0LJdZkVAdNWZM1TN4Mnuw2jj70
 8S1rjVo6ccrC7oMKmuwNtmkJPE+3uyksKa7QAaZLtVxGvRQm624dU2d83JdTJzZ4ZGtNVD1csL1
 BSjo4UEkYxLge5MNZaGZpVk/ZQaDViZm/iP2CXgAkRi44sIv0ApqGbqZh0h8Mq7EWnmhLOpdhx3
 FaYcUvgFen4IfLn+nr9FF6YbdpbH0yf3W3cSp8Cb4mUpt0M1JmIQNUg4lxQvoSn7V+3GB7QaJBh
 ozUyLILMvJIzHRCg/jfpp4zdkQmOXUP+3Gz7KI3s=
X-Google-Smtp-Source: AGHT+IHcC+x8pgTxn1h2fi710SQkdBTJNmn4rAzZ5V8kpOJnZw4pYwmjn7xHAIJ7VTtIKS7nFeTPHg==
X-Received: by 2002:a05:6a00:1788:b0:76b:ef0e:4912 with SMTP id
 d2e1a72fcca58-76e2fbaf520mr7263271b3a.20.1755213864701; 
 Thu, 14 Aug 2025 16:24:24 -0700 (PDT)
Received: from [192.168.4.112] ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76c020a4a1dsm28156001b3a.13.2025.08.14.16.24.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 16:24:24 -0700 (PDT)
Message-ID: <989bffd2-6dbe-4df6-a2d4-60db871bb99a@linaro.org>
Date: Fri, 15 Aug 2025 09:24:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa: prevent overflow in BTLB entry size
 calculation
To: gerben@altlinux.org, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
References: <5ab2be93-2551-4c82-886d-3cdf47360322@linaro.org>
 <20250814104511.12823-1-gerben@altlinux.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250814104511.12823-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 8/14/25 20:43, gerben@altlinux.org wrote:
> 1) I’m not entirely sure why using long long is considered “always wrong,”
> especially since just a few lines above there’s a similar usage here:

Because "long" has host-specific length, we eschew it completely in favor of types with 
definite length like "int32_t" or "int64_t".  Because we prefer int64_t, there is zero 
benefit to using "long long".

Just because there are other mis-uses of "long" or "long long" doesn't mean we should 
introduce more.

> 2) If len can approach INT32_MAX, why wouldn’t the calculation len * TARGET_PAGE_SIZE cause an overflow?

Because we're computing a 32-bit value for pa1.1, a 32-bit guest.  If the guest asks for a 
nonsense computation, it should get it.


r~

