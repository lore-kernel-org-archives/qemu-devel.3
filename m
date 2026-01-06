Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37544CD0421
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 05:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vczXT-0004hG-0M; Tue, 06 Jan 2026 00:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vczXQ-0004gU-Ft
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:23:24 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vczXO-0005qT-VK
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 00:23:24 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso934011b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 21:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767677000; x=1768281800; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W4U7GKAOi+DBgNgFxG6tVG9Jdw7fSE/UlxtvmwWvK5g=;
 b=QwDcacedoht68mHcQyuXMn5RjHVIcXJS+g7jJsACFM+I/cZiBHz8GnjLUnqsHh5pD2
 quwb3sCQ6ijSdJEDVKfN2mF3S7xCxfNb/opprNO4xwegKD8dSVkYvmPhsuPYFXRrW78e
 vwWwBzy32JR6KQXrkIHW3ptaxRd4QPCWvm4ezcIIgsdAp+1X6i9NxGzmdTgGk5DkvHZB
 X8wxLlt8Yvl0m7UOaZGd/fS2xNrabRjuME/6KW8kIbdkb3GwVD91CUNEQJip35naGGTz
 xdcbWodo0U91kAsl6HNJEJTlLe/HRjiHZCEKl96nugkVC75P0d0tun9rczHMLF7MPjTX
 A6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767677000; x=1768281800;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W4U7GKAOi+DBgNgFxG6tVG9Jdw7fSE/UlxtvmwWvK5g=;
 b=pv417DfgcAEZzRymB+k+mKDjWiVpbN/ubBY1VHGFrjvC6gkqlWxn7Z6KOh7+DwjuHP
 FeyYX4yvrEag/oPGoSJswH1GCp+RjtaCz5Ok/cjsN+iUGc93ZI7LRlQcegZMWO7tmOun
 SuxiP+iZAxTN/L4j/oE+wx8xK+1gPNJKKlqeMc5HN4Tm+zn84qmRBWRc7XagUJ+ivVvH
 7fxUpjr2Kg9zUVmQ30TP1hezldnYVG+hbbljW/O+H7+AzLCW+BPfU2c5hrUPogABj9Tw
 tKu8cxNJP0hIqf6KnuuSaTVsKDyalU0mb8jhcdA3xfrqCPIf3WBPNnktkHOXEOn2OOtm
 5vaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPC9d+kyFBWOn6hwJ3gcusZBz8je5U/v886e+Cd4TN3W9FDZoHjU+7wYkrWrD2xbUCTiT9RIGmIpEt@nongnu.org
X-Gm-Message-State: AOJu0Yyte6Zw9zgxQ+AP5eOm5Uo+rzuRjSNZWpwlizzl9Vc9WMc+5eRN
 OLpzMCj/zZ+n0oM6hGJwj8ngE8oMTJMWhTRfuf9OLvJcr7yiHzHEzJfNtuEiz5OskCg=
X-Gm-Gg: AY/fxX7SReBC5GR/dbb12OIWLDKSGqOT5BHvNKNm/hQ+iW7OVRm1xNNV+zRWfNLNeoS
 nQNPeCdi+RvKp1pWW90uqYKXDkiXJzozsqipIuFkI3xhbYKVqfycTsz4w1Ql33BNGNEQlXZHkzz
 VZq6GGZj40lm86w1d7LegK+bGcp2w5rUWn7qXwsZ0uA5Lmhgbd0UMGMG1JsX3qtCqaIpCa+VZVD
 Pz+cHP2ENjBDRB1ax49Crgg2iVTO6QWmeMjjrM0dZC9FzNDrpTdsSIHgQOdIewRlKATFd2AYbcH
 EGI++qadh5G0eyFoS6pYYs+zZUHJzihMcikpEMiv9Sk9sTaouqSt424NmKZnx3jM66IT3m6B2KT
 9Gbhh6xzT1/L+3WoNyzAMt09gxSHwbj6lTjwAPWF13lqCEB0I54GGNluN9RgMNjGuK2scm9JZKp
 4V0unFpBfZNOB0wnJTnmipfLTmftoh6g==
X-Google-Smtp-Source: AGHT+IHnWIB5IIfaV32AyO9rAeD20DYGknObQ53/TXEKe9RJaxWf5+Jg6LwjDNHWWbKNhMlx7Jyvyw==
X-Received: by 2002:a05:6a00:e8c:b0:7b8:16af:3bbc with SMTP id
 d2e1a72fcca58-81881e0b984mr1551960b3a.31.1767677000465; 
 Mon, 05 Jan 2026 21:23:20 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819baa195e4sm793887b3a.3.2026.01.05.21.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 21:23:19 -0800 (PST)
Message-ID: <165e6b10-97f2-4b15-a38c-a7df17c75e11@linaro.org>
Date: Tue, 6 Jan 2026 16:23:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 12/12] tests/tcg: add test for MTE_STORE_ONLY
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
References: <20260105-feat-mte4-v3-0-86a0d99ef2e4@gmail.com>
 <20260105-feat-mte4-v3-12-86a0d99ef2e4@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260105-feat-mte4-v3-12-86a0d99ef2e4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 1/6/26 05:15, Gabriel Brookman wrote:
> --- a/tests/tcg/aarch64/mte.h
> +++ b/tests/tcg/aarch64/mte.h
> @@ -51,6 +51,18 @@ static void enable_mte(int tcf)
>       }
>   }
>   
> +static void enable_mte_store_only(int tcf)
> +{
> +    int r = prctl(PR_SET_TAGGED_ADDR_CTRL,
> +                  PR_TAGGED_ADDR_ENABLE | PR_MTE_STORE_ONLY | tcf |
> +                  (0xfffe << PR_MTE_TAG_SHIFT),
> +                  0, 0, 0);

Just rename the parameter for enable_mte() to 'flags'
and use 'PR_MTE_TCF_SYNC | PR_MTE_STORE_ONLY' in the new test.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

