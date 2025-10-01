Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A672DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yZ3-0002qN-3f; Wed, 01 Oct 2025 11:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yYt-0002bM-RJ
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:16:12 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v3yYh-0002OX-LF
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:16:11 -0400
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-85a4ceb4c3dso786863885a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759331750; x=1759936550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5X2sHTae7EzauVPR3/adAtfYAFCNdeMFKBurJR2VdlA=;
 b=xrbQljAfJC3IL0dQOyookujx9JJWPSD8nbaTcyE42WIEJDJaIUvTs1MhcqdfKMgkXI
 hi9SMvqR1WS8Dk4o2GrREw460GIMb56UbwLp80mBo+riEWqogkGmdeq0oXU0jdEfIdSw
 FEUYiMb7wI+kdag5kv2A0IdND4z1XW3QH0ysZA/LWZf64+KbeXplcd4q8uC8rKoQGg37
 6uYjissC/4hDWQGAXTrFs82SmuHQ9eyB5ufeFbche18gijz0a61TeU+tvo/ynv1o6O6s
 4Y1Q248WK4n/SeHuqpiBUPryCRewv2ym+Mc60dg5Yu/q8l89oXjZ75CkJg3+1iD88CS2
 SCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759331750; x=1759936550;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5X2sHTae7EzauVPR3/adAtfYAFCNdeMFKBurJR2VdlA=;
 b=RpiC+m8O7rXpA2hPsZ5908G1hRyCMUqjxnK2fKjXGnQyHTrDqC7wjH9IbZTKflZKYo
 8oueSx6O/wWNJc7p0+H60se2m14T6fadESzufdzH/W42/4HuhDHKUyQHop2wEVgvp9mh
 EbWjUY7/OmKXz05xmaZRFy+A5l2VNhD+I2HplqPa36XiCsT5atcWqAK69JKe4o/+J4r4
 fzssf3DeE2TCklZsuz3UZ5PSIJOuWnv7Iz6yhHOTgcp78xkc5UUIkOumh1Q9e2/t7Q/t
 5WIu040+C7idTbw0tt7pMNzIbmDAlGun4ozXQDYAGLlHukG6BNMyWL6NJjoPTcO8SdQl
 bZPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvy4/Gvq2jdPrePRCIN/tFb4rzutylE2MCsVYTyuVIdMLQiIfD31ywC4vTAO54OFKWqYxqMYLqF0a+@nongnu.org
X-Gm-Message-State: AOJu0Ywg6sI/bCKAt3eYPZBb6nhDrHMWY7P2pLewftgG2VNJj3S+i341
 Tzj9VKzZ+ymuDtx/6nlJoq6DLRhX81bh1A3B/uZ9ZYdE709izf7ybo2s1awz9zERsLs=
X-Gm-Gg: ASbGnctwGnrE60INdS3m4yN9d9FuZtZ4Dtuev1oozkEA4SFFKsanlsLjeHa1xM4Lic1
 a1cmlNmnK4kqvoeCQcRgf/RGvN8gtLe/2GxEZe2Gz2chX0ZkqqqlFKJsiiFJFa3K/BadGbhyEw3
 go9Rd8/3sk3xq8vFJlUEHVDGcpORVLXsZNCiuK4N/oa0rEq32/cYgB85Y7qHTmw4r/f1kysUCZQ
 qh8bcIsW/ZxQl7vEBbh7zqxj5IXNkP+tH0mzJ1Vl7m9fHXdnKAj6RhHAAGDMdH8GUQt49nQEqR4
 EPG0RM/4vdEngpku2KGBw5C1iZzlkyJWIwsTgxodq8Vp3CnLHfQ/gsAfH5OGs0a9Qejr1fZKFn8
 s/AxSqx2oXwVNmAy+/wdgDxOveeCyRaZ6Gei+8Mwjxqp8NFvuC/dMxyMxTTZXfw80t9zwqey9/4
 ICrm3cAwH+VZ8WhXsipC18IbPGib2J9wQ=
X-Google-Smtp-Source: AGHT+IGUiIH+6+EHRabGOIIK0KZ/J/xKO6sad1dcN7erlsa6Hbn4/5Fs/ns7fX1xzUS0nOMzDAL1+Q==
X-Received: by 2002:a05:620a:2681:b0:86e:ce58:1d5a with SMTP id
 af79cd13be357-8737b489e8dmr404465285a.83.1759331749940; 
 Wed, 01 Oct 2025 08:15:49 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345?
 ([2607:fb91:1ec5:27b9:1bec:2e21:cc45:2345])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c306b5f64sm1241896585a.32.2025.10.01.08.15.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 08:15:49 -0700 (PDT)
Message-ID: <8279b314-cadf-420d-a5bd-b225b1bcff6b@linaro.org>
Date: Wed, 1 Oct 2025 08:15:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/25] system/physmem: Un-inline
 cpu_physical_memory_range_includes_clean()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-15-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251001082127.65741-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x730.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 01:21, Philippe Mathieu-Daudé wrote:
> Avoid maintaining large functions in header, rely on the
> linker to optimize at linking time.
> 
> cpu_physical_memory_all_dirty() doesn't involve any CPU,
> remove the 'cpu_' prefix.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 62 ++-------------------------------------
>   system/physmem.c          | 60 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 63 insertions(+), 59 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

