Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BE6C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 17:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7Fc-0006FM-AY; Wed, 15 Jan 2025 12:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY7Fa-0006E6-V2
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:32:18 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tY7FY-0001RY-BO
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 12:32:18 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43626213fffso7278095e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736962334; x=1737567134; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Ft5U8VVuaEsimzlFboErHIb6kBB7IDbWnNaumaMfhc=;
 b=rii7OQfmTqLo+7YZT+mIFHJsPv5tGF/aM2wkEV1JEBqpueHa0rtNoooRnWRCvbrHvi
 7ma/SrAWyX9f4tkAzExopKDM3mp/lz6vYPTZJnFGQ+Y9frvNl90wjmzPa/taV1I+dZ1w
 3q/aZrwNyBM2r/ywhuJkmApW10jZh7TcNSLATHWXLtSvAQpdL25IePKY9iBo6EwIpBaK
 8VL4ig5AKMMRjhkXNCj9aE7y20EmDskPLvorzjq2lynv7pZEko2EogF9Va1v7eoSJ2xG
 7Il4BJyONIIyBqLk+kNw5X+NyqnchEWhxl20HuTdAMJR2EBGJ6LBcUuVWFIhv7x1sGm9
 yHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736962334; x=1737567134;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Ft5U8VVuaEsimzlFboErHIb6kBB7IDbWnNaumaMfhc=;
 b=LiZ0nHUTIDRM3mrve052gRVlNjSFnCy7htCnWLYipd+Fioak7HXblQCd1rxRPa/v1s
 hScUNFv5ZXI0NgehUMAoHFgYP/KgdobGL+d7cugin5qpYfyrGccCOFrVps993GF3Febi
 zDEPe/uwn45L08t2uzbi42RMjywspw96vMa59OenKc2XpPu0MHTyKO1cTxYdC0RIsLth
 KMmYwt061IfWqKYPZFn41WM2NEbo2o/nuwc6PwruLKJ4BDXi/JvIjctYhmFYT1a/gfRj
 iGF5DvBRcTpbJo5lJJkZkXhgn0QrE1HhH0xf10l+R9Pb4Pmm9gVIphYbTR5+4cZvNaK8
 Yk9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpxNG+a6UHdKrpT08qwZrxl1Y/b6fmLJyjxkkqcr5kll3iPIay6z7X+2VahY3vun0Kjcd/ZyWzD8c6@nongnu.org
X-Gm-Message-State: AOJu0YzIBsRbVA9oBdsdUWfXr1r9M12sXqdFQg/7zsoF7hzjIyYFJcn6
 cD0AFweF+gKKwtk9wdcmM/kmdDAawHm+AG/3Lh8wa9ZzH9seBIQley+4lieZvl4=
X-Gm-Gg: ASbGncsougNLG0lpLEW94Z9cbsgYWgHta0OzhDlAIWqTtAlCCJixNuAAzWK0qv9nfPo
 /l5Emqsne7vD6PQzkT4iJZExpC2dm9S5YlvuCqJo2oDsn883FUWq8/ZB9OzeEB23dvfsWofBe0A
 cvqKi/CxKMCi1JdFZ0watuP9mQpf7gK+ApJ4Jr8PNcQclwf42LyldD+/By4R3MMpVXuJf8pFVHG
 F1N1fQUZXBaZS3YeweVFPRBhCj7LaAE3QJNycB1/dFtGLeLTxQpvikHUFdf7cMbtQ7HWu4gRefj
 11p04QUGhwcu//gsrmqal38Owq0=
X-Google-Smtp-Source: AGHT+IGyfz0PUK36UlgkTC/oMAMkZV5v6f0PI4OZGXuex4jlV5xCSgMPQ7sAHoqxsmQ8umkwSNBx1A==
X-Received: by 2002:a05:6000:154f:b0:386:32ca:7b5e with SMTP id
 ffacd0b85a97d-38a8b0e5092mr21285131f8f.16.1736962334461; 
 Wed, 15 Jan 2025 09:32:14 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e3838a3sm18290886f8f.33.2025.01.15.09.32.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 09:32:13 -0800 (PST)
Message-ID: <8e61492c-e293-4bea-a0e0-e41d815d8b47@linaro.org>
Date: Wed, 15 Jan 2025 18:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] hw/sd/sd: Allow for inverting polarities of
 presence and write-protect GPIOs
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>, Peter Maydell
 <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-8-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250111183711.2338-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 11/1/25 19:37, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/sd/sd.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)

See question on v1:
https://lore.kernel.org/qemu-devel/e202623e-eac7-4ed3-87fb-002491ddf745@linaro.org/

