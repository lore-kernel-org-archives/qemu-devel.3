Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46988CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 15:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ma6-00034H-8d; Fri, 17 Oct 2025 11:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9ma4-00032J-6z
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:41:24 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9mZw-0002VR-Lg
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 11:41:23 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so1976878b3a.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760715669; x=1761320469; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d6N2+HdYpj33mli65GRZf5zXM/OGDD8jTDNnWqIMLU8=;
 b=C+jKYGBx3qJ/49VCK+vz8ftqYTCNPER1PmXxNJDpXdsmFc1dux4SnMsHCWlwN4eJy2
 JDIaDETqeVp/IgSAdH9aiUxApNz1uq8FkNm6t/+L1zsm8/sDIyM/O3/Tx62izTom9mV8
 sSTJLs3oGFEgS7EUc8kvjWoxh3oq7Lub0WGEGZHS3kXimT4z5DPeBXVD/4xiujcgX3Xa
 NnqpJLijI56yxGLV9y1XYr0NbT7viX1Qs0dao6UP7y8O4NvuL21pHcfcE4yBHJBdsfc3
 jdB8Rjc4RvQNPMm5H/q8OxHmRZ3c0rSVgSsn6RSxMJhb19bcSOIye2pXeGx4lfs3viaG
 chCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760715669; x=1761320469;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d6N2+HdYpj33mli65GRZf5zXM/OGDD8jTDNnWqIMLU8=;
 b=HEnoOttsu8PjdZIE5wgTV+lvSAXpEEkSKl4m0QHOGInV9K436ccxpj6iw41ItD718C
 jQJ4qqvnaU4gu517oy5yviKqvW/cCn+ob7kF8B6K/UzmcxC08c0lWg0g09H5v+Dy4Z0p
 fT3i+47Qr9Cvtm4sS/OVX43cfqZNv/8ESvGhLAjTGPe47wTfkam4cU1WcLdI+8WKk5iq
 ij50znz7nKIGMbxQqoLakJ1BNLUO91Iwnv0jghXxYDPUdd6UbtwTAvz9TtYvx1BAWz1a
 ImgIVmnVrx/C5JFkj6bFcYl3mwIt8XivzpLy3hoqrweSZjo+/JA+WXbqD5t01JDz+meD
 tUnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT+VwKvaldxkOgZQeD4oFpQw8wln5tVK3Rf312vqFU7uUBq7EjKag+vtrqB0Yd8TNhQ/QzMOtkTVSl@nongnu.org
X-Gm-Message-State: AOJu0Yy6dPa+sEMojw0wvFZcpubyLrW6JTSkIsueEbGY1ZUhrceQN6G3
 Xq1sVHySXOROamYL/nJSUWSmqj3RL8/VmPrs98b4Fqo2QaHhuMx6FIsOxPsSpTrhtPo=
X-Gm-Gg: ASbGncvjo0aNSiXWS9rnuHsjwqx6njzxqrbwNVfr68bplRQISuGtjoeWCxnQQosEbFj
 uu77eWxb4g+TgnX0sbtX4toF1D95Y/znlmGjuEW5DJClVIAMlyQvuNiVBUILiXMAbGIDTTgNA8R
 gAsAPTvZDa8awDaVVAKRYVt0ojec13LlW0+DxWNYS3zWpyF+ldMNuR0yA9DPx5+xjMlaY2qkjgT
 DvoyrU8DZ/4NXYxN3o/Rgox0CbUI3iiHQfrISYJJ10ljUoHZ5/fRzsmdBArx3SZuDKmDBckqFWE
 xXOO6r1EfdrvNCoCislQji64Z6Lp4hBORmOuWLL0YEmzZjkhw6FriCfGw020C96JG4uwpYT5wch
 1ynwpKI8kWIWIj9YUpSQiOrwC5WWqaUiJg1paLsN3NcSGL3njMx1qFWHHXPvAQQ8MSRYPV4ljaK
 n/TVED25DLN6Ja30A1COhv9aE3
X-Google-Smtp-Source: AGHT+IEkB18sBzZw4c84BBQQGbj4/1AL887GBqwox8T5oDtVDdsA2sOt1xrTpOVvImq+vTyPM9xLjA==
X-Received: by 2002:a17:902:c942:b0:264:a34c:c6d with SMTP id
 d9443c01a7336-290ca121a65mr56915565ad.37.1760715669024; 
 Fri, 17 Oct 2025 08:41:09 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a756sm67663655ad.14.2025.10.17.08.41.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Oct 2025 08:41:08 -0700 (PDT)
Message-ID: <cbba8eb4-8628-4df6-87fe-b18a0e9f9520@linaro.org>
Date: Fri, 17 Oct 2025 08:41:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/tcg/aarch64: Add test case for SME2 gdbstub
 registers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
References: <20251017153027.969016-1-peter.maydell@linaro.org>
 <20251017153027.969016-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251017153027.969016-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 10/17/25 08:30, Peter Maydell wrote:
> Test the SME2 register exposure over gdbstub, in the same way
> we already do for SME.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   tests/tcg/aarch64/Makefile.target      |  9 ++++++-
>   tests/tcg/aarch64/gdbstub/test-sme2.py | 36 ++++++++++++++++++++++++++
>   2 files changed, 44 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/aarch64/gdbstub/test-sme2.py

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

