Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCFAC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDue-0001q5-NR; Wed, 30 Jul 2025 17:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDXK-0005iP-OP
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:36:30 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDXI-0005yr-Kx
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:36:30 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-240763b322fso3514875ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907787; x=1754512587; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V2ihf+Pn23h6nm1LEzB3SznrgHq85lWb4DBYMxXQUUQ=;
 b=m7vzr1mX+MWgcAQUK+QdkqNpGewYNFjnwfwg/OzypbXaGc9bMltJNxa5sLhUySSYmL
 UIsvKiCO2ONYdx5tNQVvxoQygE4Q11/l0ee6FnY1InU9PmCGsZjWOr5uduxDVoCJKWqk
 NxlCJKJIqT4VIY6f3U6meouN8nc6ZO/r3VtbDSmHHI7uSWtqNumB7Moo98CePsL18h7p
 1Rl30DMU0fDxQ75/a4K95X2j3qS5lBECFZLstS78Bk0JkGFNN+/bxE8g9UIJ73Smw3W/
 x5jTtwQGtDjhZ3f7nUBYdxejpoIbmJFBXO7rXI2Ueje+kanFyoGGpSLRpLYcKx1maSMF
 cIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907787; x=1754512587;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V2ihf+Pn23h6nm1LEzB3SznrgHq85lWb4DBYMxXQUUQ=;
 b=BRzV6dfUKlnOxcgy9zsp7UbkoppiuF099r3JdTtBW1HiQHaLQ7A1TYV+7dtUAhMtd5
 6xIzE0qZbTWKU1fdjGhSNVEFzVSNkB3lMwURby+ZL+XaBw0H25hxtgoGGXmIbX6v/PDZ
 NntjYwHrVDamlID3AWmVZam2jV01osMjidXxnvoWMUbw6ooKtqzzoRX5zvxJQ76hX5Yt
 BbSYJjoAQLkida06VjFKp0mhJcFbwolFdVyfmM8RAP18WD8GclaHAMj/JCgPdJl87S8S
 nk9uaL91ZlQ93j25aakE+G5HxWyzz8jEvzfvcxi40+51EQIYJ4MDqrHpgaH8sRYZRcxs
 vhjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdtskVgCZzS/TPJM+/kBlJuxv6EtC3hbGSL4535ag7EOOKQXta7C7IhtDDS5jy1C2l34VOWmQaRVqz@nongnu.org
X-Gm-Message-State: AOJu0YyZjXRVvhxh+qsudT3JxHiSwHVMXin0TtYOG3jKEMSC4jnplyuz
 zf5lM6rTRo0+LVm7WU2O5KnOuFMYiY3RfvsjZWMprTpoRBNupRVHAU8Kcb3arrxZlvI=
X-Gm-Gg: ASbGncvV69VZO3BTjUYDYbPazV2LmR30w1FcBxP/WG5vCQcvQL+anVIdxJcHWuhVrYL
 rvq+48zADEgXiv9jmT+nzGW9GK4ATUjD4HafYnI1OTH9BFoNnGDpjrb8Eg3b/M1gLnUhXmjlpEy
 qLeCERYNP86oLV9SSOTzgAryP9iCRlMbeaQGcbBjXI1ayqZ6TDu9py+H/jVh9zgZLVgCvYsD18L
 LFCkT8ziW9J+1wqi+0MxqncKzJTmNkw2tSwLcWq4srAoiUabeJks3qEw9qFD9GqiFoe2X85kuCV
 sV830rM6RMNhAWME3HY7MQGB8sDINYk6hE5OfYtXF6fnvuQIoRw3a/FwnuLqjKL/eIE/b+hVPuG
 EwjRVWrLa4u3uIUbbP95GxKZcFha2rC/U22Ziyvi+JkzzMQ==
X-Google-Smtp-Source: AGHT+IF97KZ7DdYrQoN2Ei/X1yWRAzz7UwFc19iL1Riku4PB+aRPQcFwLtXKm0qJTMohjnKeb+M7BQ==
X-Received: by 2002:a17:902:ef11:b0:240:934f:27ac with SMTP id
 d9443c01a7336-24096b17b1dmr64209595ad.33.1753907787087; 
 Wed, 30 Jul 2025 13:36:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1ef6cb7sm108845ad.26.2025.07.30.13.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:36:26 -0700 (PDT)
Message-ID: <f8033191-2bcf-4513-9545-d1ad822ddfff@linaro.org>
Date: Wed, 30 Jul 2025 13:36:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/82] target/arm: Remove outdated comment for ZCR_EL12
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> The comment about not being included in the summary table
> has been out of date for quite a while.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 5 -----
>   1 file changed, 5 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


