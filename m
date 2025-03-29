Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8429C36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 07:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyQyX-0003dh-Gn; Sat, 29 Mar 2025 03:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tyQyW-0003dD-Ib
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 03:51:28 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tyQyT-0004Bt-CX
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 03:51:28 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so4693104a91.0
 for <qemu-devel@nongnu.org>; Sat, 29 Mar 2025 00:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1743234683; x=1743839483;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qcF8OmGivMT1Fh1TuMbmPEQzijbAh+4wxNOe4QmmO0Y=;
 b=qW8/wAZ4mwqk+ND6/drqZhnznuRIa4i1SCFq0KUT8CJ/rVNADa6RRSa+AKFZvZtM0+
 SKIiDxarbM7+Wm8nqQ/wGcQItYBSUVRjBhBtKm/DDTDYYXS42Tn/BicvH3LFuhdOnDx4
 MMgiAiQfpI8KZijcyuq6UBJQ0TARInmFqgAL0RZ5f0/9/C7M8QnxwMscbF0WyF/LP3qA
 UX1nXjRn+5GpvQiKF78JBLyhtBegGwQg8basYyhLgbGPkHnl59lvngdKKlNTnLfMdeRo
 nLnsaAKpQX+1um2D+2+jF/lVaaVdXjrT/mHFpagtXZtd9foPPDotha9o3RaRAtKaW4lM
 ku3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743234683; x=1743839483;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qcF8OmGivMT1Fh1TuMbmPEQzijbAh+4wxNOe4QmmO0Y=;
 b=v/XYN2MuEpC6s1GKx1ES6ly42PwYZpoIqXu9H05ngghc+Zh7+t+aqTwmGv1Rg4349t
 5RKoDFTdPOIVl+YCYKztUpxSewu9fogdVgLpseJ5kjBtFWxwO+eMR2/CSE8J/lPA9P8U
 6tvSrbDdv9xVhCfVSW5H+m8hiJ9fpIFckyUzT0BT4E2LaZFCwOp8wErzGai3sME1vu8W
 wY51sbU1qVD4rGgmN/XL2BdsaGN2piyCzpVQLSynaW5x2eRgzSNQTqfI6rbWe0ElXtsU
 qxkDXei3fnmDUziRVg2aHyMios7weq6T69ACkCq7CxMVkHwD6+NbbPW6nUvqMD7UFMIH
 qkAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnfg79qEArEwrpHhx7Boe0RLjhc4rfZWwwVD5BSArZDlX0oI/JAlvJ1Jj3QfeVimC4GAQpWF4Md6EQ@nongnu.org
X-Gm-Message-State: AOJu0YydknoLtx0nhVgnG0KlRIsjV2ThwBmjWA4Zm2rGC/DekyCalaAK
 LZL63k7kScBVqaoXCG1hkoJTxs3OQdHalO0v6JK25Awb28S8f0eixt8LFTk2k88=
X-Gm-Gg: ASbGnctHyLXvXTigyFND2aXET/MT1WTVFmzKV+TVAastz/ixaZmX00Ig68RicS2lQL/
 cm1FMNmQ+e6E0GHRqHpjKSuec3NzyzEf6s7G0N59ZAf9iyQl+IlJEiyyWueuQA3rHzK/BR9dLIF
 2qGqAkVd7BRWNXnrDZfDbSMdXeuwQTi1RW1WnPRwuF9BkxDNfDCXHvznRWkxLMprEHOecpe0TGg
 f7hfpiBtjkBYivmBF7qud4LdIJiKc57Q1ktBS+1Sv68Y2VBR+2VroWd8/28GOnT0YzHEEQYLnB1
 yC1UiyeUSHo8jKWniHVbaIWinU77ITRQn8V7DQPERSSiXKf0HNyDRy00dIqrImkpz0/E
X-Google-Smtp-Source: AGHT+IETu2LVoe0FLEe6PzNMHojLQ+yXSu0SS7vq+2nk/QQ2Mo9lQk4Pcc+Hw+nn7zTVyOEI69oFmQ==
X-Received: by 2002:a17:90b:51c5:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-30531e89edbmr3830613a91.0.1743234683123; 
 Sat, 29 Mar 2025 00:51:23 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-305175ca98asm3454180a91.45.2025.03.29.00.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Mar 2025 00:51:22 -0700 (PDT)
Message-ID: <4fbe53ce-047e-4efc-a0a6-f59342e1f3ea@daynix.com>
Date: Sat, 29 Mar 2025 16:51:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] include/exec: fix assert in size_memop
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250324102142.67022-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/03/24 19:21, Alex Bennée wrote:
> We can handle larger sized memops now, expand the range of the assert.
> 
> Fixes: 4b473e0c60 (tcg: Expand MO_SIZE to 3 bits)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - instead of 128 use 1 << MO_SIZE for future proofing
> ---
>   include/exec/memop.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/memop.h b/include/exec/memop.h
> index 407a47d82c..6afe50a7d0 100644
> --- a/include/exec/memop.h
> +++ b/include/exec/memop.h
> @@ -162,8 +162,8 @@ static inline unsigned memop_size(MemOp op)
>   static inline MemOp size_memop(unsigned size)
>   {
>   #ifdef CONFIG_DEBUG_TCG
> -    /* Power of 2 up to 8.  */
> -    assert((size & (size - 1)) == 0 && size >= 1 && size <= 8);
> +    /* Power of 2 up to 128.  */

It may be better to avoid writing the literal number (128) in the 
comment too.

Perhaps it is easier to simply remove the comment instead of updating it 
to explain the assertion without the literal number.
(size & (size - 1)) == 0 looks cryptic, but it can be replaced with 
is_power_of_2(), which is more obvious and will not need an explanation.

Regards,
Akihiko Odaki

> +    assert((size & (size - 1)) == 0 && size >= 1 && size <= (1 << MO_SIZE));
>   #endif
>       return (MemOp)ctz32(size);
>   }


