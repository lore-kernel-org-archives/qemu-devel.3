Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEEBC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 19:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Ow3-00029P-Eu; Fri, 25 Apr 2025 15:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ovh-00025q-Et
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:41:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u8Ove-0007TL-Ti
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 15:41:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22928d629faso30163755ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 12:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745610101; x=1746214901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5UcNvA7rjecFIpTEr4Xcb9gK0+4d1KB8hV650O02870=;
 b=J0uIioyIs+I9THLAzI6tRblKcedGs/VLC4vBv8XyaejgyfWs8RPvlbU8Zrm41AjkGB
 0QWGMhBg/dLQR92q2UT2dRG0PBd9xNczxbBAQUBqMUwC5gsS/ePRmNxBMfh6rb8f01/R
 Z7AXn0ZLBB3XFYgN4a0aHH81jfTCd+jdII6wcQs/7Ox1x6ds3zFsj2N7jjvUTin+O5PW
 u7unvNixftj3xb9Sr+lbjUnYXN2sjzvFdHbT7c3YoiivVoswHFp5GF2b8y70qr6ts/lE
 InzajnMlBc4TgRI79NXCsHOguhTADF+Z+f39uSFFeJsLAl4U0Q9LtOG+E/MxjmYCl0BZ
 EBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745610101; x=1746214901;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5UcNvA7rjecFIpTEr4Xcb9gK0+4d1KB8hV650O02870=;
 b=A+Tr8IuEBNecqTLgRaX/y/lEGtTsNLLIzkWUv2wBPBufHVmFtipu2pbuQKGfMA9K9h
 3Et9aZH2DXOmY6m+bPJV8HsGE/2kRGkQur2J57f4nfhdFHPNyKDdQqfR1irpaKjh5g0O
 yuVde3PrttesFBcauh+mTko5XAKn6GlRp9lCkT+O2mc2wNayyPjZ7vFs/Z5WS6qtdJV3
 G/CfqimBa1dXja+3u29/PFt72DOv+waFtnMJz5zmBg+jo7yPaPnk2oseefLhHDgsazFS
 ZX7hmN2nwGivryIdJE7X6bswZF0ASdnVXZxrJrL5CwYM9+IBURUKP8FSK7piG972wpYl
 /J6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoMWGPsjr/A/DBsC/toptPZUOgLB1AZFJtlBFeiazk1AwgYXuMb8UanXz6OZl/kuc/Tk2rjDpBKVHk@nongnu.org
X-Gm-Message-State: AOJu0YyZjsU9wx6fICoyr/FsNUq0g9B3GYVZt5DX6V5DVJ+SY8wccMb6
 ezc70lBCJB41qLkvwmQeKFE8CTzJlpo6mwErkNcVGnvRpnS5/DK4VA87QFhT4ek=
X-Gm-Gg: ASbGncuVGmnH9wHdOqPT66vfHCOh1hSYz+kiXDhhcF2CNOq12rbLEqerShqJyEBC+++
 vGUAOpVTaBnRRWUiDTyEIgev0WfGkTphxqll0h75a+9cShCjGfcwFE54vGPhr7mJJFZxg/oyTZz
 4osYglc7chix5EGzCQhmo0ZkAfoRKXb9Uc5AdYcr+aMtESWId+IDx0iW5LJ7yAmRk0FPeqdZyjN
 uTeYIJuJhVdmf/WVoxgTUWiCpsqJFN/k30MLU1RaE5/N/87HZosmLgjKkvwSwBGuUO5q7o3S5Pi
 j/iSkJqAiihS8hDcSEQPe4cj4/DowRD0A2Y4zKjecX5LNAd80JsuJg==
X-Google-Smtp-Source: AGHT+IFHOmQiAidEhbTT7zOLykeO2eyuJ+HwFHipa3tD5Qb3YEc2zFcYsSb8OsuG3HvGkIOzakPXFQ==
X-Received: by 2002:a17:903:320b:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-22dbf5f9367mr54673875ad.25.1745610101136; 
 Fri, 25 Apr 2025 12:41:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15f8597f67sm3277215a12.34.2025.04.25.12.41.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 12:41:40 -0700 (PDT)
Message-ID: <7d74322a-22f8-4a5f-b0d2-3cbc3b65c570@linaro.org>
Date: Fri, 25 Apr 2025 12:41:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] accel/tcg: Simplify CPU_TLB_DYN_MAX_BITS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-9-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424011918.599958-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 4/23/25 18:19, Richard Henderson wrote:
> Stop taking TARGET_VIRT_ADDR_SPACE_BITS into account.
> 
> Since we currently bound CPU_TLB_DYN_MAX_BITS to 22,
> the new bound with a 4k page size is 20, which isn't
> so different.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tlb-bounds.h | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


