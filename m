Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30506CCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95As-00038q-5c; Wed, 15 Oct 2025 13:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95Aq-00037A-IW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:20:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95Ad-0006O9-Ie
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:20:25 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so6687605e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760548811; x=1761153611; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XLOhl34H9ArtZN+RfPEupyYfgwofD8LgLKnH22GXGKw=;
 b=ju4EeR5gJfJazqUMCCikEhH/YLgHCA72XU7ed6kuldh9Gm/gI3N3+JDINFdW1bLNpz
 WSgARI+k3ogUKFivnuiO/wR39SGgYgWpiOJRaNtrT9c9WwmBTn3rMiWNIcpumb+sQKFT
 JFa2ReiStnA1pTXTUnJhoc2zDbceEIKN25XS59Gkx22j+pQ8rdx7SPMcZ+YfaXq2YZXX
 BBoQeB+FuntcRCOlHo4VHScQ9xcn5QdHFT9q6wJET6pq1XOyPPr8+FoSxwar7JpdDaox
 Is/s1hKhJuR+Nsr6B0Q9d2Zsc/ZfR/pW43Dc7b+uIXKppUqM9ZnI21NSJkZNykEz231+
 dp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760548811; x=1761153611;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XLOhl34H9ArtZN+RfPEupyYfgwofD8LgLKnH22GXGKw=;
 b=bhanfogN/fSSQlzY74tN4mKyETtqu4K/zzXTu+2+3vKaBhuGHCchVWV7BvG9o98ZS6
 rlt8HFAVELmybLAJhy65VDdR9dbnWrJIz4RMs4DVnNoEjA/tU54UK24rNji3xVGyWyk1
 SxhvSdwQiWUe5IvPEeAw0qp7R8fMGbgCQpdncUeAXTVNsHy+uZhlB6InnLfARlBAbTyq
 Uj9y1V9NzQbHpyK/ut9ls+nrJnxbrlUhKtPBqutg1pYBakbKPOspW6wcpCDf8Zj9fLgL
 TKNFUEz/nQdx4hS5Z70DU4fJJrkwi5l5ESQ0GetTYqPfB0XPH8LAU1H8PJP6uUmKe7uj
 F5SA==
X-Gm-Message-State: AOJu0YxQkatQXzfUMaouTnhrSVv5wogo1wZx7oDc6dzhTcAxzDPNTUGP
 BiZogZwW5MtwjIT8N5HOTl5TTy2oaRvR7fRePtu+wu4zbFeUC0z36d3QiJumNz5cEt/+UDpvBlg
 RRpoJChRe6g==
X-Gm-Gg: ASbGnct+XyZkHTdw5d85YgmvAFO7In8Evk81JDO0L+vOANc9aJwpUwCvr/dP5JAa//b
 cfcv4jO5SHfHEZEnw6g23wmGfoskTTk63eOwugs4q6fofCFsfUDySfTEulLPm/AeWvJCHUUwfNd
 7R30RgPqV5sg2T0Mrch12VZLlq4L03YPKgTxuTuQz33PtdDpZw0GeMb6kYAa4Xpq0JCTnUyMytr
 xma6grhDpZUv0rY+exrNFmD6Lkz/RmvOP94eXSjrv94+7EC4dof35WTbBNlQjaPhriv/J+P/G3o
 j/t6vgE4TUDEV4OfHdLkqO9cLehMC1T/2KfeBpEz/i68rJjj+do7QO0xoL8XKldueraO22o04a1
 m3V/bggNM5mF6EHBsh1yf7RixmYDR9rE67bgKLR+9CSU/if0fXgQl21TBUCm+WeBNbrmqFEocUJ
 hwzBNmw89u7y/QflBI5pUmc7o=
X-Google-Smtp-Source: AGHT+IG7tEavSbN74oQFxffeN78IKx3iUB/n/wGwv8YSCMtz9qa6L3UnQjoi5wGgpV8Z5CfRsEI04g==
X-Received: by 2002:a05:600c:4e89:b0:46f:a8fd:c0dc with SMTP id
 5b1f17b1804b1-471099212bbmr9870225e9.3.1760548811077; 
 Wed, 15 Oct 2025 10:20:11 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fb482b9absm362840485e9.2.2025.10.15.10.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 10:20:10 -0700 (PDT)
Message-ID: <5f29d664-34b1-4012-b634-a99461540bd1@linaro.org>
Date: Wed, 15 Oct 2025 19:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/rx: Un-inline various helpers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251009200012.33650-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251009200012.33650-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 9/10/25 22:00, Philippe Mathieu-Daudé wrote:
> Rely on the linker to optimize at linking time.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20251009151607.26278-1-philmd@linaro.org>
> ---
>   target/rx/translate.c | 48 +++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)

Patch queued, thanks.

