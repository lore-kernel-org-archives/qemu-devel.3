Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582BDC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:04:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDyR-0004tV-At; Wed, 30 Jul 2025 17:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDh1-0002vi-Ug
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:46:41 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDh0-0000tR-CT
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:46:31 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso239292b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753908388; x=1754513188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vmxPo0A8bpk2rMpqYh06maGbBOAmxC6y6Nx0uRuVuUc=;
 b=zxaUPMHktBiSzysWr+WUCGYrJi7j51j1jNpob7lVhxRogvcMHR/o7dPiUcJ7mfOHSh
 L/Dau3ZMVxcwaKL1NfZl3WH45M5l567M47WE9/XFzhGsdSosl0+twdCVutIuloKKbFNM
 lCHsn18RS+kzfweSq3H9cSssJuxz2FplaJb7fsYgcxSk7ZXwMiQSWVLRc2Xh0m7cecoQ
 ePmwh0oxodtG+74hAXKLWposaSf/BnoUFWCHJ7b27qAg3oZAGT1UHhD/wqG5K6mqpWuT
 hl7TKskvhZ2p8bTGBgqmwJ/mTN7HpklZ9YSb2B4AfY1dV8oVIQ9+qxEKI8bfAbioLpKI
 XnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753908388; x=1754513188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vmxPo0A8bpk2rMpqYh06maGbBOAmxC6y6Nx0uRuVuUc=;
 b=Lp/PCE00nhrTq0rwBmWft4AWrvhDy9dUUU49jCj+Y6iF8GAz0eH7tMDFIT2n5R/J31
 NzpZpC2PYptg+qz6156rgyPg43yJwAoYh4u1+0eM8RcbCn7V7zYTd6k1NAtmDb1gCfhp
 fI3xeH9YnX8Au5d2Zd5S9gP+YO67TitwdJVJTv2dwrIn2DVS9AM6g7cgbtmPy6FvS3jQ
 KTzpmB1d7PYRTBxMXAik6hpejvVH3clCkGBy4zxr6cFUAajkRgZR9oi11sYzzc8WyDRt
 qiuR06yS1WTq5U/wqJkdrYpeGlVNhkqqD9/xN8CVu6otGITyaRk1IVV65Qmfppk/k5uo
 luaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoG38MWZUdPktCTz9iYaKedBp7BslgFKyrhvJwnbUx0r8WBWPrIONNiSIo314559+X1mM1Ht36pfVj@nongnu.org
X-Gm-Message-State: AOJu0YzoqR2ghyQIrDJAqn0/42B2pr9odG7lZ3kI3Vywyhq8yOzeRpkI
 f0LyvcO0DHdUNpsmHnyzbfkxoXa5nrLK9B0POzJUwCqGoeK99M26OZriDK2QrZ6GEEw=
X-Gm-Gg: ASbGncskZ0q79lmdek5xLvsodaueb6eB3ZPXjUB7d12iRDXpmiSacM03cnjhodw+41r
 LFbpa1h61COgrnGJemYWfy0akUy8stPPypfZ1A9KGVhFwnKNUGDRwi+bdO84HQMUUZRyuXYi1jp
 sHTI9F6b+ZYuYgBNjOQMMx6+IOXT2KFSbpl6Jrga81GlkUI43cRcFi5SmYyIOeqmBeb0ggYcq7w
 5h1JTXoej0gIoZKah3Fk0I/iuOs/jwfjGfejL84KpJRWJR0JKj6pJ1ssfWOAhZsKz+VRJ5A8Rdx
 1bfj0LJ4uvHpSI08+QnuuT29/JCCiDajpn+Qo/TNeREMqB7KnMD5SXZupO+rU2pBFLrupRNuttg
 J6VxQ6/mQ3jAxpQrrsrYRehOqjjXQMZdqzT4=
X-Google-Smtp-Source: AGHT+IF7CMFgC+ApnYdNjeIbhixHt7kca5nAs1AV/UKqeTi2OLL3bRAvZL9AGp0LUhEvNQUU/hPnCg==
X-Received: by 2002:a17:903:1a26:b0:240:887c:7b95 with SMTP id
 d9443c01a7336-24096ac57c9mr77548845ad.5.1753908388560; 
 Wed, 30 Jul 2025 13:46:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899aa1asm91845ad.122.2025.07.30.13.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:46:28 -0700 (PDT)
Message-ID: <b5b2a7cf-d083-4a50-89fd-32e356288708@linaro.org>
Date: Wed, 30 Jul 2025 13:46:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/82] target/arm: Do not migrate env->exception
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-19-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> These are not architectural state, only placeholders
> between identifying the exception and delivering it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/machine.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


