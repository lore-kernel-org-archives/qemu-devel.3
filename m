Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0A8C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 21:20:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhEDl-0002dt-LY; Wed, 30 Jul 2025 17:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEBZ-0005zK-J0
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:18:05 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhEBY-0000HK-3X
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 17:18:05 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b3f7404710aso216365a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753910282; x=1754515082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1qvaZaR2aXMejWTIkJwK08jTvId0LRFvbFnoCtri/c=;
 b=H51otNlkIPW9u3y89uHwrfOW3WCpQEWJMsZK/A+vH1JYkuwHhYg6VcNesKLNc/tEPn
 ri0r7CloMSznBSgarWjRVCzlDQHrd/AyL4+HesDcGu9dE5/Fndp+LvyN673qmn/c8m2B
 giqQGcoOsayqJaKLqUcgs9C1YNUkePqJ6Ymo0OlnvA7dnzryFOtiPGfggDhtE3/QZU7D
 1SfeQupS/tDBGtD6OQtnrZByVAywlH0FJEzdB9sgarfjCr4L4qmyd4cleX+ebJM43cHO
 wJKTBExGxHyDyyuA7xVQy99oZRpxQwqmsFk1lR+sMY1GxY4XenNqbxppRN9F4Q3V1x57
 SWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753910282; x=1754515082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1qvaZaR2aXMejWTIkJwK08jTvId0LRFvbFnoCtri/c=;
 b=ni8XwWgx8Mil8fp+2ogXMHxHAUU1Mv3Ch/9V8gXvyFYKOxX8rR1EFMMkQFP+IprvBq
 QHIqCRFsQywSizYCyvtj4C6H/0+22x7WROA+iI2hfQ32bpxE/zAgE+e1pmNhq7zmg0N2
 z6iDTLrIgRs06HLCUI/O2zGwUc3k76OIdXYSdWsIcHbOJdmokGxKIDVqZsSKe8ep2iN1
 7AWAXOmdq+HIhbWvVIn+KMZ/Lh9AC19Z0deNmZSWj0yR57nzaLyGF706GA2oKlKZ0s+A
 oD84v5aoVMPDaH1yFAn7VxtvBlEvr0vuwO+RxkzxWuZWNK+AHbYycHQ+GLgUIpI43pBl
 DJZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnoCnPx14DQ7AA8GXjYU6wnPvhgX8FUkcKxG3CAIXLXz9FF9pg73V2Zm2yb+8Og6SFLB7gfdUuMIsw@nongnu.org
X-Gm-Message-State: AOJu0YwTu0g7HEF1Xq2rZtdPJq31XQtRdBLlBT2tFPzFz2bQ3TeXwzVI
 3Avo1xesgix+XYAQ7MlGfxxFljZ6sUfJvGuEko7Hjm1XCOaIrKwPDKxNsp0xkHMWI8NdiAcKuB1
 TUoTX
X-Gm-Gg: ASbGncu5xgmVCtQLYJratALn78OsVKJmxaVqBIoD65noYQ+IjPLdYmLSfCRWW39TxU3
 mBfBA5H/q7qWiM/wWLFB8Sdn5Vj/7t5y+FVU+PUReifuhkVrXVxnSEgu++Ytbai/pKHbBjmhdxg
 ri0JglcOXyZTgO49dvA9TfZxQCPi6e+ipalqsD1gzLqteXqfWDeAWWoaP0Gx0/rfD8oe0qPqyUq
 srcDJRJCApVjDb6OfqBW/VV6nRi0Ed4VmEa5AdNsxZuvB9kUVUFA0YONAEV1iTNR6vJPBzfBtKZ
 CCxbyelhx2uaAs3bcPBXBzV+sW02U3Hk/Qzx0h291GPDIBEv4LBRPJkimLQtP6pWhCZehGwlHDP
 Tgfn9XdBYG2JJbPl4cdauS6Jd0WL9P4cCEy0=
X-Google-Smtp-Source: AGHT+IExUBetOsAy9McHC5FFZqXZAR65FysnLX6ULHdFdtiECE3p3ZblaVaOd9cHDSliO10jqyGfhg==
X-Received: by 2002:a17:902:cf42:b0:240:90d:468d with SMTP id
 d9443c01a7336-24096a4770amr70995405ad.9.1753910282483; 
 Wed, 30 Jul 2025 14:18:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e8aa9055sm442125ad.150.2025.07.30.14.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 14:18:02 -0700 (PDT)
Message-ID: <4c1575d7-0b2f-4996-b67f-2eca0a4bf9ba@linaro.org>
Date: Wed, 30 Jul 2025 14:18:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/82] target/arm: Remove unused env argument from
 regime_is_user
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-37-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-37-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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
>   target/arm/internals.h |  2 +-
>   target/arm/helper.c    |  2 +-
>   target/arm/ptw.c       | 16 ++++++++--------
>   3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


