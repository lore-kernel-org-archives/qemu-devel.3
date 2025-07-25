Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AD5C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOzE-00061C-S9; Fri, 25 Jul 2025 16:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufOtu-0007Xe-3X
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:18 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufOtr-0001DC-70
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:20:17 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b39011e5f8eso2427424a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474814; x=1754079614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AyWSNk9VhJtrq59zL3a9YYwEAVv47A5L+XLtB3a7gKc=;
 b=UOlQJcmZF+xp1ZAYmSadZgkLV0jhIxyAKgTNY84U/SDhVIYi+rUeonSKyT0WdEvIo1
 N0mAPdvGS8rEdRKnUUU7xIpsl/H6Rxpbp5zDU9kG3I57JmBkyTjyGx7yFOohW9tLLuIo
 t7pw45GchdnfonCuNJJqYpF5eLDKtd498x4/pMNwvG0vd9txNOWkSu3PubXDYNxDLK1m
 xS+mlztnLFoxWE4ajtwMl2mky2/PWMWF2EJRoxg0S7J9Nn4TyysuJZohQg4lEs1evUc9
 ecuUkynXmZz60b5+qbzm1xC8MeRll1fdvo+EmAqZde8lpy8j1nno/9mwFk1KYNb4ynHz
 Sb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474814; x=1754079614;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AyWSNk9VhJtrq59zL3a9YYwEAVv47A5L+XLtB3a7gKc=;
 b=tR7XHlwZjMHxV+nCDSU5ESyJqbBZyGJ39rmd66QBx+QuMzmDk21yZg92odJVZe190i
 1bEbGDfMiTEEEDa3CZ2C3dHzGBYX/AYXAS68NQcxijOZ8RKVDyQBChbBLZfuCoZ/NXWL
 8ZeI9+xez6vAvBT2QlddUr+n4X2PSd8gdFzwNMhqoHl07pLlIIN8XEjgZhQ0VqTcDEaD
 pm6liuoS+q6/PWmFJa2olxspqny756WdgihC5r+vXHvDFUhu74uEvkDnB+dgylLvbMy1
 1Tw0WvT1P5M721iaeEnbOpbNMaohpCfpBDGVKjfk/8SZyv9g7vuiC7CU7qHV9ko5vDof
 STsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBmhzvnm0NTp4LmvKBqhu8ByWaNDI2+AUoJF666hMhB0jiiHc3D4fT/n4UMgVP9Oba/2maLKxRn3Rd@nongnu.org
X-Gm-Message-State: AOJu0Yz/3XRfUml89LxpoQpVegkscCBNH9Egqz9dmqhy5pksKEpWGU/H
 9zyuZc9kz8b6ls75+bRFFi4/DEH6Ix8A2U7lCOkp9uZ8jXiLxjjIkk+NM14JfTalYjA=
X-Gm-Gg: ASbGncvpLo9Wqc7x7r1YjRrsciIkofQz5fEX/y158AYnZSPhV/eW9sxuZowGMwfnRYy
 3Q/Xn+CA2cLZh4xvjKOVAwQKOlHjOW+Asav5F7E1r1Nr1zZPtvL9UGW3LvDTUlBQsZ+Iyvp8783
 6u9YtASEHpUyAja4WzLaL00zlZBr2DYS2xdRutH3xBME6w0h91LByX/tc6TN0SOQZ8rj0rqzh9U
 5lMhWRXDTP8HK2Bt4sGXZLfVP/+v9SiaQzVQbqUVyVeK0NZ9GdQjBUTuuwS0Ay5epLOo0QuWWGZ
 BHoBZ0Eo1wD5sGBht9zsOgSM9J2tZsEjCTN91CRCOAH15f0laepv13Akv0BD0FmrXcjFi2f9Ix+
 WQg31v9EZQJ5FPUY/uHtltAzbfDWXftI50P6JIs9pLFwm0XovKUrx5xbkbvnmU0iLRFTMOkxRwz
 VU3g==
X-Google-Smtp-Source: AGHT+IHj7DCESW2EGDTSJJT1JfeUz7o+qNlJTlKO76v9q7LxZHZrgU/hRULMCMvA6krUBc2fwmV6Ug==
X-Received: by 2002:a17:90b:2750:b0:311:ff02:3fcc with SMTP id
 98e67ed59e1d1-31e778a0660mr5024375a91.14.1753474813645; 
 Fri, 25 Jul 2025 13:20:13 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e83563b06sm334896a91.32.2025.07.25.13.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 13:20:12 -0700 (PDT)
Message-ID: <aa815125-d007-4866-a928-a0d1d08cb486@linaro.org>
Date: Fri, 25 Jul 2025 10:20:10 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.1 2/3] linux-user/aarch64: Support TPIDR2_MAGIC
 signal frame record
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250725175510.3864231-1-peter.maydell@linaro.org>
 <20250725175510.3864231-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250725175510.3864231-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

On 7/25/25 07:55, Peter Maydell wrote:
> FEAT_SME adds the TPIDR2 userspace-accessible system register, which
> is used as part of the procedure calling standard's lazy saving
> scheme for the ZA registers:
>   https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst#66the-za-lazy-saving- 
> scheme
> 
> The Linux kernel has a signal frame record for saving
> and restoring this value when calling signal handlers, but
> we forgot to implement this. The result is that code which
> tries to unwind an exception out of a signal handler will
> not work correctly.
> 
> Add support for the missing record.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 78011586b90d1 ("target/arm: Enable SME for user-only")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   linux-user/aarch64/signal.c | 42 +++++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

