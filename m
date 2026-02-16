Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AA0E8383C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7Jq-0006ms-PZ; Mon, 16 Feb 2026 17:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vs7Jp-0006jc-Rr
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:43:53 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vs7Jo-0005Lp-89
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:43:53 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-823075fed75so2051475b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771281830; x=1771886630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W5FRkTCIzQJ1yMDVOXCWUpEHbA07lq33qSJf7nqj0N4=;
 b=wdByGwyueXr1Q4f+U8riDjS+LIxw/vA6cvehU8A9bjdDnqVZcjX9GywIHj4qGbEjkZ
 j9CyRu31KZvVZU/jhtiVgqM8o+2yVKrd0rctZwthNz+ie3/Qyo1sPWLIxGMWq4BSzJc6
 pFx58Ff4BZOhvEeEzYeF4ED9stXT7XLaZimYIR3Mg9KZ0rDs0lkLjTsm3lSWpGuR+Ysc
 QJMHULK/u8Q1AuEmw3nCQNes/FVAm9GZ35KNdgx25mHyOfMSKJJDZiR+toXccDhlmeV+
 YpvkC3KtqYDncKl63EeWcFQD4Yl6l5kPuQ1AwrLq2R93mnn9xttgpRS0eZdHWVcLMDFU
 yQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771281830; x=1771886630;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W5FRkTCIzQJ1yMDVOXCWUpEHbA07lq33qSJf7nqj0N4=;
 b=eflQj1Qlu6RKsYDQYDEjEI7x7t3EGZ7b4j01J6eC2xWduV8f25FF7ENk2rVHjHR6l0
 aRol4mNF0RsuUapUn7Es2JzvJ0P8P64Hku38YAR2ZPjfddz3Y9qGmwrZtc7YC9xEJ4P+
 ZEKhLZ3RTGFOSxyWYwKOPHZ/Lr/GqB3U0Ge2/1Aiso7u35+O7JJigGghL3nJ98oxAtIV
 W2/pvoEVh6EMBu/g6+qP6ot/U8i9qOfkmx7RPQ7jEvnurzC7VbjR03Osf5WOHPQn80Pz
 J6QEJ0yMcp9e2FV1okaNc8Ls9guUL8Znx4SJ79wJBU1f+0W3fnyMKSy3LLi0QqIDNPoc
 Sjsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFZp4eumvC9ObaR9j9tuZm0Omp8xHVP494EOXe5Iso7Q/9EP1F/q0YiRg8CNa3g9zwHpiWzEe+iRyH@nongnu.org
X-Gm-Message-State: AOJu0Yz1Lm0h1MDAa3F9rFqA4CA0XNYXGVoWCr5TnzwvAa1Uocoj1YiO
 mPaIfwJ/jv4JRs8h3/6M0FM5r8AeTfVb5sDoKEabtjW5CflLrc7psEq8/GbWsCf+YRw=
X-Gm-Gg: AZuq6aKDH8eF+xYlFoK7qpIdqU9+bWI+PM8BI5d6kg9ee3IqFRRmsp703UpvPtvpxoX
 /Z2pv/3atb1rNDmuEFU+FO/ZfwwHm4WxNNi+S6wyTBKEpNFiBet/3xakqS7OsJLK0/IYGN/5VCs
 GeelgQlnmqgCGWCriHTZBO3upcINJvr7zqyw7MpYKqGLYY0XAOuwixW07XoN9ytJ08uFGCWFKVT
 EWr/tNYcv75pjKkKrpAFXol0ZN+P9nX/eY5AHX94+V1j6WTcLAjcrgM4j8YzGzpSEo9i6tHoGSj
 lHMgjLSBLXHrEFf+KJWhLHn8KB81/zaXONK85ViW04Fr3u+F7UnID/9sv1VzTcqJSTq2tCBGK5U
 PPrVQCE+sTh2UpfZBwTH/jd6CnyPcxKSfpqbJYd7jBfZY9zKbMgalRLanVGrKmT/QllAucMo0BI
 xI72BONZPBa/k9qwdIFgWZL+nm1f7r/LMeCjrjX5MkqU8nM8/RWE5uanUMWNqDMfsBuUOeDouU+
 cVtB8yKwqvbPJ/NqHPG7SNCBlO6KL/0NGb77KcEMV5p6SvwkHhp4bg=
X-Received: by 2002:a05:6a00:bc10:b0:81f:832a:174 with SMTP id
 d2e1a72fcca58-824d5e1c726mr8131350b3a.16.1771281829858; 
 Mon, 16 Feb 2026 14:43:49 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1e87:e093:79fa:89a7?
 (bg30dhzpjwwrss5hh6ty.ip6.superloop.au.
 [2401:d002:dc0f:2100:1e87:e093:79fa:89a7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b69f2asm11488073b3a.37.2026.02.16.14.43.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Feb 2026 14:43:49 -0800 (PST)
Message-ID: <d45659aa-5f04-4515-8163-15d81e8fb223@linaro.org>
Date: Tue, 17 Feb 2026 08:43:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gdbstub: Make generated compound literal array size
 explicit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
References: <20260216214332.47639-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216214332.47639-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/17/26 07:43, Philippe Mathieu-Daudé wrote:
> GDBFeature::num_regs holds the number of registers, but when using
> the compound literal construction, if the last array entry is not
> set, the array will be shorter. Prevent array overrun by making the
> array length explicit,
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   scripts/feature_to_c.py | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
> index 807af0e685c..3aa62fb895f 100644
> --- a/scripts/feature_to_c.py
> +++ b/scripts/feature_to_c.py
> @@ -90,13 +90,16 @@ def writeliteral(indent, bytes):
>       writeliteral(8, read)
>       sys.stdout.write(',\n')
>       writeliteral(8, bytes(feature_name, 'utf-8'))
> -    sys.stdout.write(',\n        (const char * const []) {\n')
> +    sys.stdout.write(',\n')
> +    sys.stdout.write(f'        (const char * const [{num_regs}]) {{\n')
>   
>       for index, regname in enumerate(regnames):
>           sys.stdout.write(f'            [{regnums[index] - base_reg}] =\n')
>           writeliteral(16, bytes(regname, 'utf-8'))
>           sys.stdout.write(',\n')
>   
> -    sys.stdout.write(f'        }},\n        {num_regs},\n    }},\n')
> +    sys.stdout.write( '        },\n')
> +    sys.stdout.write(f'        {num_regs},\n')
> +    sys.stdout.write( '    },\n')
>   
>   sys.stdout.write('    { NULL }\n};\n')


