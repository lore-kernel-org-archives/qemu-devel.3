Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCCEC87FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbET-0002ic-CX; Thu, 31 Jul 2025 17:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb4B-0004GZ-P6
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:44:01 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhb4A-0001pq-99
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:43:59 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bc61152d8so1482712b3a.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998236; x=1754603036; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TANO5MpnRas1ZWufjV9TyCHPKGCPVe2NJazKetVKn5g=;
 b=S3xmmvq2gQumuz1wj+Qex8vQbghfFBWU8uU51obZpTO6xnc4RaTfR1hgRjlENcYfn/
 4AvuAPUAqz7KUZKVccnE3dAyOiWMoFSmNQ43XPFM/fg0VPDE6r1Dqb6Lp2ZU1T2l0x8C
 osGu3182n7Bx3ryEwMG7ZdYTU01XXCLdOMpoRVnBq5vznxWL8xqAwuBCvIS5U4Bq05Mz
 lMo+PgJQPMlRmrqTtveEBa0d+O/2YZsleSXgr2TkrEwaI1wQsMj40nkeoQJ/x9zYXUB0
 JEr6Rl1sMn7nCb9d0JkHtIr653XoR2SuZsA5P6XL/K8A4jqAKYY7hOMHT+FYf1EcnMQl
 oqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998236; x=1754603036;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TANO5MpnRas1ZWufjV9TyCHPKGCPVe2NJazKetVKn5g=;
 b=fNWDTCf+BDifLpCVtMf4hOWYiTDehNcUv/56fXArYdk9OxE/bz8ozAxafAhfQ/KExE
 MIuK9MsNh7HVGp16D1isZ5pMY2oifS1sjG30R6uyMT153Cb22LrJM0oytDJvJBnKCysm
 DvqcNB8/Opi2EPYkex8XXemHu2xuicVrm60zuvdXXw53Pje3pqtVUYff0as1rpswP8uq
 fBEL4dPXaIAHSmlJfJKsTDmx+/mDILqsfWimpK8XomlOGKkiTx9PSzi54PFTLmxRJMLY
 k1RQJk8+Vb6mf/7xDzQRMop2PmvCmd3UprLsNA5EveFshQZuYBuDHMhlb4nBucK792jU
 B9NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwKsZOaitto3M7zqhayfJJGsjA59RZQVRlJU0C/kqPm5ywsxSzRG7c+9JGCAJtaKHkdwO/mkQ40LKe@nongnu.org
X-Gm-Message-State: AOJu0YzMc1/VkHLndKTDuOi4CGK0JGpb+oUjgxiK20i6spkYmM2ZVqQy
 iwn9ZbEuc636sgcHrbuoaoHUxFBaq7oFMHyhAMXQsoLsW1maR7vuckyi6tDJerw9/jU=
X-Gm-Gg: ASbGnctsWiax4nH9XaGppYh4AQOVNt4AkzM77Q2opFZlMBEF9on61xg9ODxKGEPNNiL
 G71W3OB1izGX5o6snxx43skGcPjSQB92wNS/3y5uFcFGneFFX+SK07rjNX6bCiEyB8AgfF12uDR
 3sDai2pW1cNHpeDwJhDzy9NcfjNr5/8MIwiWiAqvG/KuG5YxIKRKw4b5TqvkSr3+Ad+KWwFzL/c
 pbZLkggJxHWKG6ElNMTC2g4aaI5pW3HCT6j8kI+jdcPV8r/x9mV3z8FSBvkrs0BBhlkLydfD4dt
 TkL1Vtq/PTqDD0Ced3GpRXjwcME+eZnZd0euTx1Bgd9qG5f1xiqKZ37iHo9rtlQLmHsfM8zY1xQ
 zoAVV+TMh7RdSS589Q+bxdDMNFxbWEeUZRAxEiRzpFEYHTg==
X-Google-Smtp-Source: AGHT+IHho04uN8v5dEP5CJO5VJx6+0STH/qNuTd4MmFS3k0Zd+Wmfm1is8iMcCfyDSjipNmbLY65Sg==
X-Received: by 2002:a17:902:eb8a:b0:23f:c945:6081 with SMTP id
 d9443c01a7336-24096b03a25mr121718665ad.31.1753998236627; 
 Thu, 31 Jul 2025 14:43:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e89768a7sm26571375ad.83.2025.07.31.14.43.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:43:56 -0700 (PDT)
Message-ID: <83d398c9-d129-49df-a254-826f113ebce0@linaro.org>
Date: Thu, 31 Jul 2025 14:43:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 61/82] target/arm: Implement GCSSS1
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-62-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-62-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            |  1 +
>   target/arm/cpregs-gcs.c        |  3 +++
>   target/arm/tcg/translate-a64.c | 32 ++++++++++++++++++++++++++++++++
>   3 files changed, 36 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


