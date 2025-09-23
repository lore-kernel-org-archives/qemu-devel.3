Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3B2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yjw-0005OM-FT; Tue, 23 Sep 2025 04:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yjt-0005Ky-C8
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:51:09 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0yjo-0006Zq-7S
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:51:09 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45f2c9799a3so39518675e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758617459; x=1759222259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PwMw4Ohz4+Mg6xUqra7umlihCilljwsntZEbiQu9KM4=;
 b=mqqOMp/P49errsjzW4teb4z7UUQ90CYk5c/sF7PDuMODcSXZinyFlXq/OE2nEk1hwD
 lJu4LfXgnnl+lN53PlZA/nCta5zumC1g2i96Y3CyhIhkn0PnGjlYLZHQ2lt1TkACX7Mv
 MmqX93xVqJ9QTq/pI7Hil3FTU6WW/Oqc+aBPJQTiVap6yz3kEADqRkvR4IoJMsTGZjzc
 zDCNEBqGaQ3S2C74DSRIrPdB0pKFUZv5yrW+9anfIWzxOxFhkWFCGffd2PeYFDprPcAy
 XkC1rXek77EmO47XnFC0QtRxVPTgA1yI0XMuhD6EOrc+BRpEO0m8RqAaC4nZEiRAsvDb
 eJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758617459; x=1759222259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PwMw4Ohz4+Mg6xUqra7umlihCilljwsntZEbiQu9KM4=;
 b=McG2LxyVfQWirRsjlr5boqSwFbW21dqUwJiXoTgvhJQqT96Ch6NUDp6MMuPwGyqIr2
 N9W++7fPffy64D4tSUgk59BdaQhkoAI0jlfa4+laK7viDVwS65SOHSV6/tYyIU5zWTpd
 cyDcCCR5FLJ4hpg+qG9brXC+qcM+Gr2I3aioq/Zk/i7r4lkr15UhXm9iQozTYby75xPI
 zxQg1beqqbdo5nkBjNmPbDUFs5Z4DOUhqsD07vsr93wwXMETsfinIF6SZ7UwwujDUNro
 ShgOMDYTEcfohNtaSF9xZROl6TTaWp1NtU7cl+Yuy5RACKBndS55TZEzcSSOSc8hOjtK
 ExUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs+E8uqJ53xRzC0DucqnzAE5o0aXaB/yeUxb9jXpeXAUbnld7pqSQQJakQKOJERJMinPJNFGR/Cr9U@nongnu.org
X-Gm-Message-State: AOJu0Yw+PWZEfE4sJdfCaBXMYBDNdSuWerN4a0aCWOufl2zKgr+VgQHQ
 ECC7hw7FqSoKpbNEYNzjOf16rv7kYr/LIaqEqjY4WFifCQeLt5cylPZ42culiW0TywzYYzqiZ9G
 NND1oFQ2zLw==
X-Gm-Gg: ASbGncvDP+EA6LzGOnpraquCPydgCkIsqKNgP8C2EIyAXuJZL90+x4IjenEl6QIgZEZ
 6gxr2YGBhDk8T/auSPtNtjmyL9VQ81vo3S21eD5OqmjBVfmGsDyJoN+WEHhZZuCvdVbi3rksPGP
 vi0Buli1iHUOwFkdZrEYRbbg2MGzofFi0d8mT0mqL7FqLwBmr5P6orEGLrBJS7vJOjeCICnuasU
 H0LIBfp7PSA8q+G7OIAiBx0obt8q1Yr1W0vvhvdJ8VS7jIAZI9fkZwr+txQGp1xZNqWKl9bycoD
 yHAcZl/al8hZsUB+igmMHjWoJv75oUTB1IBY0W59V8tKY8rryn3TDblVKY4b8ak9y0ipTYqh1T9
 S5SeRWPbgplgAY0VMTbpldZtNmTGDIiKCeABgOrokc0mNNKsgkpH5OsoujXCROuJwIw==
X-Google-Smtp-Source: AGHT+IG4LwJj+R+ihQZxGOzlkXUMhlUaL4Xr2NimoK0WWjuB2nVxOyI7Ygpyo/7OWpqb7K2c8NhREg==
X-Received: by 2002:a05:600c:1d20:b0:46d:9d28:fb78 with SMTP id
 5b1f17b1804b1-46e1d9953cemr21575445e9.8.1758617459113; 
 Tue, 23 Sep 2025 01:50:59 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46dea20f833sm63358875e9.10.2025.09.23.01.50.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 01:50:58 -0700 (PDT)
Message-ID: <9567e59a-e7e1-4106-936c-88ad7f5c202d@linaro.org>
Date: Tue, 23 Sep 2025 10:50:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] linux-user: Use tb_flush_exclusive to start
 second thread
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 23/9/25 04:39, Richard Henderson wrote:
> When we start the second thread, we discard all translations
> so that we can re-do them with CF_PARALLEL.  Since there is
> as yet only one cpu, and we are processing a syscall, there
> are no live translation blocks and we have exclusivity.

Maybe factor out a helper expressing that? (can be done on top,
of course).

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c    | 4 ++--
>   linux-user/syscall.c | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 002e1e668e..bd2bbaf1f4 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -1010,7 +1010,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
>           CPUState *cpu = thread_cpu;
>           if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
>               tcg_cflags_set(cpu, CF_PARALLEL);
> -            tb_flush(cpu);
> +            tb_flush__exclusive();
>           }
>       }
>   
> @@ -1450,7 +1450,7 @@ abi_ulong target_shmat(CPUArchState *cpu_env, int shmid,
>        */
>       if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
>           tcg_cflags_set(cpu, CF_PARALLEL);
> -        tb_flush(cpu);
> +        tb_flush__exclusive();
>       }
>   
>       if (qemu_loglevel_mask(CPU_LOG_PAGE)) {
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 91360a072c..d9c394856f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6633,7 +6633,7 @@ static int do_fork(CPUArchState *env, unsigned int flags, abi_ulong newsp,
>            */
>           if (!tcg_cflags_has(cpu, CF_PARALLEL)) {
>               tcg_cflags_set(cpu, CF_PARALLEL);
> -            tb_flush(cpu);
> +            tb_flush__exclusive();
>           }
>   
>           /* we create a new CPU instance. */

