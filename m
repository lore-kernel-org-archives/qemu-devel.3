Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A91C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 21:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WEl-00031q-VA; Mon, 28 Apr 2025 17:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WEj-0002vZ-Qd
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:42:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WEh-00051M-OF
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 17:42:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2295d78b433so57343595ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745876517; x=1746481317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dfC/02DzUTp7/f4xELqpDgd8rLjQlb969w0HGHjO2gk=;
 b=mkNScgkIgW6Bw1+7w1Eghj246M8ul04lgXWq30ob4Z0JJ8K7DhLN3uWskqNrDo/OT/
 Dk5bO387a+TGrMiH02D5V+O+JepEuZy5Z8zyI4E3Q7A7TvM8UNIZltJ4Jx8SZve61A9t
 EpIa6uHHVyJhhWjzQk9lp65Zj6tcgr69U7N/lU0BACwScTHfEtKBEnPRUMpuF60yNQkl
 Nw5sU4csY8wTvlj/PuaVo8HFfYSDRLR7IlisbOZSqOV1m+jYU1Jp5iibQExVWytklUGX
 pFexlEDZtA6ID36JJzldi991hy9jwIvRzTwBfKbEwyawg/kOZ1jN9XcShWLiz2qIguoM
 ZrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876517; x=1746481317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dfC/02DzUTp7/f4xELqpDgd8rLjQlb969w0HGHjO2gk=;
 b=Y3KFKmywfB9etYVq27IzUyw6d1D4n8/rRfYev1eb7Vzl4eI8yTS+DDTaSKp7iBCAfH
 wpwLRYHcqf+dIa/93a+YyiS6r2NPKrJ136+fKAmFrBytexTJHIY9I9OnHPHN4jrnzkWD
 JM7W0Sn0Jn+j0NNXtfYEepbeB1sfU0dkGzuTkQnWFqpfkm4TUuhWJJMf/zXZ9L/5AqRD
 0esxoGuuQttOx2Lf35KB8CcVydA9VKVyvzOKkAnsOxxhlVK8qFp97m1SXjhYiBH/SWDd
 eaw0VWXTHlH3BflL0h7eLy0WbyUzKx+jaeX/5WbMHmPBf6Y8y7SyiKlgRym1toKctUiW
 /I0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcrSE1Gh+tsUBgKoVGG8BROH8dDuN+lUkKt387rjSk2Ig+4Uf/5o7NoI76xqeN9Jpoizy52gb8+ChX@nongnu.org
X-Gm-Message-State: AOJu0Yw14yhPSYVxYEUm01OqQ0tYza37Af/XhONj8n2cGXtjQZfpjJXy
 LAXpa13sn7Bc959ZqnYPQbNQkXqpSjVb0RDfW22dX1EtRWt2ng6akauw6Rr+jbU=
X-Gm-Gg: ASbGncvZkG+KH9x1VZSbzYF3FgkTtmvSH0JtSFXFI6mvJ4KZTx2qxAKuUmxKgjCHyMg
 GVgDegz/vu0K7W99rvKpOzrvHi9ESIqyP7EwYp6Xs9wArNX5YjkJFk5+lBNCMdWzt9u1z2wnrUR
 J73Y/wKvwDN+uG+gynW54FYxjtmEgBiHxmMHOQVYf1Smd5qhBQim7+31h8YMPlJbARgzJStt7jW
 y8VWRzmW72Wve9GKUf5b8Zz3TzBErkBopxWVvGgDKDvcIsuuXrBZZvGG64pGNu+kQifupxOweZ3
 tB4UP7n4CiTSRs/LLl2fhDOwB8BiyAPx+Ku5bY+MuBSDBaIq0UHHbA==
X-Google-Smtp-Source: AGHT+IEptZyKNickcA8FrvXxPL4Szmpz3p7715yLoq/59U3JEjnzvPJcdtT05Y5dkDtoOkQtHNtKOA==
X-Received: by 2002:a17:902:db11:b0:223:4b8d:32f1 with SMTP id
 d9443c01a7336-22dc69efb2fmr162830775ad.1.1745876517134; 
 Mon, 28 Apr 2025 14:41:57 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5216998sm88683375ad.229.2025.04.28.14.41.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 14:41:56 -0700 (PDT)
Message-ID: <7b178241-40a4-407e-a56d-ab8a8d29de98@linaro.org>
Date: Mon, 28 Apr 2025 14:41:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] accel/tcg: Compile cpu-exec.c twice
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cpu-exec.c  | 2 --
>   accel/tcg/meson.build | 2 +-
>   2 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


