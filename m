Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6D9CA0FED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWfW-0006IB-ML; Mon, 25 Aug 2025 08:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqWee-00067l-SV
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:50:36 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uqWeX-0005o7-PI
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:50:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3c8b0f1b699so958508f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756126219; x=1756731019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U7VbzoE/yBYPP9To0emRFgi00nwhCNQ9EeFP/Yz1fNg=;
 b=Ravr7aDh8ySYDCeT18xuHy2KysaJS3kN6U/Ozc/4FU4lzoC+lw3XBBu6iCWq9TDV+9
 bIClVL9GZOKjflj5OfRww612DzqdTPGh5LpQ1G4LyqW04l15XCsWwW1xQLauwKUVHdIg
 nBsGH7PHpOlpn6UPlRaWYwxJrATtguXKoOskdTgqmIvBa6DmelKToRl9IWWYPzk/wv/H
 sWHUGmMZsRFOl4xFLNUwSHeCthjzAXvsgcDZcXYqa3+/MLXLRKTBwzN/GKqaNGuXJPtV
 GKEeSUDZOy1ChPKgRs7hNWqCHjHIPLbO6GII91zU0u7IeyG2Xxbz0/tvyPTn2VWamZaH
 piXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756126219; x=1756731019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U7VbzoE/yBYPP9To0emRFgi00nwhCNQ9EeFP/Yz1fNg=;
 b=cgcMKcEskstN45he8EVzFhV41XVaFNToGC6Gm7xq7jflJjaLJh/UKP1Nu+8FydLoja
 uyKs/BAVnoIeEYAEX1PxjZ/simrPieKBB+lKanl64HQrQIKqTOe6529UEDQql4tuXJaa
 A1jDyOmVzQkPPcN6/z1BckyIQFxCfZjcYDRDogM94eOk24pARJW0EXMwAV4xjbBYaeiB
 uWkTTIG1zk5yLswDClkrOkCRN/bQdNrgAnzltPT0JdZnvUn6TPxWjcXmruG77iMWMVDq
 Cfl9qUmBtgmmNY/ZX8nDw0OJ39U6hGhF6ZI2yARqR9nQN7tdJMjg4ClTyIceJFEgnMIb
 9OwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq43BvGQ+oxlPEMa17T51v+5t6tHdfCrYLwV3Jk1kfbKszHYZhkiiiz81raOUOOk3z5w8+RDD22S80@nongnu.org
X-Gm-Message-State: AOJu0YxU+PeLTdwSkcnNnCVqMfexy4rhqq/EGROC2I6FrxDP2G7ZmZeL
 UsZLYeIfLqi0Y6tTuPo/NGksA9a6/qk8oMYPhLnbQZ5asG6tzj8FLh12FMCXydnGRrA=
X-Gm-Gg: ASbGncvbpZNj4zL9W4gcq3+vsWlh1cyYfjZ9DuY64SXaD6egyrs/6yVYOOrJXDH7BfS
 Kyif0PfYwmmJA6NFJBxoPKtaEfzPCe8OxRKtUXKqOE0kHo4hLBjc4BA00piTxS5yA0nuKlQ/uSO
 J2c417zWa7H8Sd9exIoIGJ8vJSB2ee5ZfYWBLP9Hw4pwXGyMzf200flZHzf0F3byNMSbCx2hNh8
 L7nptyHYFGVaAX0LPPlQ1InlkrD0FvIU/6tBTJm/PD3i7b0dj8rHE9yl79Y/h6AE6oQUKbWdD0i
 0Nk9SsWTusPoezNTe5OyX9+xzw9d2AK3gy2RLea+1w877PRdznCiqy05arLOHSR7qA2DT/pdIxg
 WJtXydsZEU3yKWm72M/hbHdkPL8ikMQmFThhk3hnqnxBqHVlhv68ZXCjnbvn/fTJgmg==
X-Google-Smtp-Source: AGHT+IHWlEvcGOwKv7+rjHnzkggBvJSP/6mxl7MB+q7Ncjl9dc5l7OuFbQYYX9Sm3VsWVg0BnQQ9Gg==
X-Received: by 2002:a05:6000:248a:b0:3c4:bc55:65e1 with SMTP id
 ffacd0b85a97d-3c5daefc4bcmr9617461f8f.24.1756126219584; 
 Mon, 25 Aug 2025 05:50:19 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c70e4b9f8dsm12284814f8f.9.2025.08.25.05.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 05:50:19 -0700 (PDT)
Message-ID: <0ee43d3b-1ceb-403e-81ce-f187cdfc7188@linaro.org>
Date: Mon, 25 Aug 2025 14:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/microblaze: Remove unused arg from
 check_divz()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, edgar.iglesias@amd.com
References: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
 <20250825112051.4155931-2-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250825112051.4155931-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 25/8/25 13:20, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Remove unused arg from check_divz(). No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/op_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


