Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFDC9C0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq9q-0004TY-Cd; Fri, 17 Jan 2025 12:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYq9o-0004SW-WE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:29:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYq9m-0007Iz-Dl
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:29:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21661be2c2dso47187125ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737134957; x=1737739757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1Nxjp30m81UPhMyRlrDqGvk7psw64M8eUM4q6xRqYY=;
 b=JFp/NQO6iNjMQpv0hxz4hjt5m0ZurL/qPbEAEY6z4BwXvaA/X22bYQLJRGULzXaKSo
 Mb9tXswfA2WZUTFmdFNy08sTcnhzxTMxBdAfxQH+S0JQJyalxjiHcTq+SDuTPWNMpvPR
 m8FZ7txrOk2hKZ9BHyt6bzo9OJT0uWIkf8AaQ1DVrYJxuS6DX5IlemA7gsiSo2F3NuCz
 VKmy3lTSwOXVfEFc9AgXuw27CjHS/dNveQ7FxTaG7cpbXlz9z6DVZOsTLcuI7oxXP/HB
 pkR6CbiVhDjDUL5eszD4c/ZA9V/SBnlts8oFTuaT/TX7VGZTTTZIrJF8yLL1e2R2uQxf
 L1Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134957; x=1737739757;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1Nxjp30m81UPhMyRlrDqGvk7psw64M8eUM4q6xRqYY=;
 b=T5A9oPns56SQ7ZtHRDDMjaLLBJz3mF1nG9vJGk/qVXSPFrNtU9gns6E6NK46OgNH2/
 Jpn+SMJMPH1vz2pvwH8XZH7UZNeDWdbLJcxtMyx2CITiZEi0261YzLLHRgqkka58Q1/A
 aJh9CY90cKgPoOb8Nxqy0WzN5sXZsV6KuY/dtWKHrwZcNfgpMMQTVqn1BYIFp70cnZzA
 DMAh6y9q3tR/NEUl4c1XdqDPW7jqAWO43T2FlEdqFAc/sjGhO+rFT+N4d7peHRK3Duv2
 RJ8z1xHfTccM0g6RWi7AcocYlo6Ub2ttf7tzrsIseU+OqrXJ66ayDAyoakXpUHRt2CI1
 SWzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpi2CD/3gW4CR4c13mcRNJ34Ty/pd4d3ib4WgD4GPDGjyhhp3+ybz+rKKf2MJQWxKUQryNGOD7URR1@nongnu.org
X-Gm-Message-State: AOJu0Yxj+BcS8aACU+K9TT7rGPl+15bruBUkCNwxmu9VyiMwatFVKoGK
 tzpn94KhUpVS3a5r0H8v2PgMXzYvrtoKST/V4MNE5R+LfiKBXq4I+XRr0XJscM0=
X-Gm-Gg: ASbGncsnNXn6mk0TaUGG/hD/q/1PgRqN8hYuEtzffJOayYssIxfoN3UermMF36XTyZk
 +0fK38pJeXPDAz+DUFAOYzIZ78/MT+JJGSmgGxBc6KuwMiNQkw6BREIN4sK0VjBmO1yYioIAhm2
 zM1Nau25KUos8pAYq10WkvcnyefCsC+LwqoDNMJ8yuL8wL9ssluXCLHpCMBTaBwxA+z/l6KzHQW
 1Hm59071ajDV89cqAOxskTkGxfqF0I0TemOWemC2KrygTQKmKuoHBjclvdYeLjKQbmUZiNZ1OHI
 VrPfoiDXjBRHHlrBddL5YVc=
X-Google-Smtp-Source: AGHT+IGFxofdNNvXzgbkKFmd/ScrBbDFgbamJFxDAw2kNylutaqncB9VFPwVSNOlT+odjscLtHrwqg==
X-Received: by 2002:a05:6a20:9150:b0:1e7:6f82:321f with SMTP id
 adf61e73a8af0-1eb21498449mr5395505637.17.1737134957046; 
 Fri, 17 Jan 2025 09:29:17 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab815c32sm2236346b3a.59.2025.01.17.09.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 09:29:16 -0800 (PST)
Message-ID: <5e96c221-0aad-4e5f-80c1-9992a8106d46@linaro.org>
Date: Fri, 17 Jan 2025 09:29:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] qemu/compiler: Absorb 'clang-tsa.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250117170201.91182-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250117170201.91182-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 1/17/25 09:02, Philippe Mathieu-Daudé wrote:
> We already have "qemu/compiler.h" for compiler-specific arrangements,
> automatically included by "qemu/osdep.h" for each source file. No
> need to explicitly include a header for a Clang particularity.
> 
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   bsd-user/qemu.h                  |   1 -
>   include/block/block_int-common.h |   1 -
>   include/block/graph-lock.h       |   2 -
>   include/exec/page-protection.h   |   2 -
>   include/qemu/clang-tsa.h         | 114 -------------------------------
>   include/qemu/compiler.h          |  87 +++++++++++++++++++++++
>   include/qemu/thread.h            |   1 -
>   block/create.c                   |   1 -
>   tests/unit/test-bdrv-drain.c     |   1 -
>   tests/unit/test-block-iothread.c |   1 -
>   util/qemu-thread-posix.c         |   1 -
>   11 files changed, 87 insertions(+), 125 deletions(-)
>   delete mode 100644 include/qemu/clang-tsa.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

