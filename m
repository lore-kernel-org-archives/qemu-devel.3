Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C91D15DB7
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqXd-0005oy-Lh; Wed, 03 Dec 2025 12:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqXc-0005oU-FT
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:21:24 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqXa-00036m-Rg
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:21:24 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477b1cc8fb4so53255e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764782480; x=1765387280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHqajnmIxGvXg9K0u2NS8NvNPE9iYsqzlsGnJyvTnGI=;
 b=F4NV/j96XSYA55/WIZAF9G0nZfdCpFC09SOnyCO/ZrPNecIt6zZkVifNKo3xQZWB3Q
 ZeqTd/Yfjm/qD1I4TnyQKUgBGJFwGc2e7GwfqCEfReZtWCtsX9ly7Xx5+8dxQBHUZOtS
 HGDTS/3M3o6TtJuHK/UTpdkaVzd/2RqdJZBoGvp8bJYRzdm2BKYU0prjuufV3igvoDRb
 SIeEJRIPuYdpRMrr18I8CxyyQnkvLOvy7tHzaZMOVcKqfAwNd/uqzNQK6WN7GAfAv1Jw
 k8MKA9Es1Ov3nMW3V0O/ckcujXPx1GY9OyNmIVv4tP5T8kfiCpvUM+quJwSIdIe4dicr
 yN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782480; x=1765387280;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GHqajnmIxGvXg9K0u2NS8NvNPE9iYsqzlsGnJyvTnGI=;
 b=L8WQloCiYn605IlW2VGUaLq/RGTdYkTFmUDTMwmqOESfG6wTddO67nVkkn0cInO7w7
 YWFvia6EQSlM01iUolP0HXEf3rZfZWpblNP8anilFW6LX/Zz9rZmdDbJq9rWU6i7hF3W
 fU1lkHmk5/zjBHa5ZeKwIUlD6z6LeaxqS+yDkx165komkm7UNZ1feqluCbTsduzEGTFi
 IIc0s7okPljpxsg0awtXvLBq6TNIMU6W6V8/8YUXQs09D/2c4oH02hXommoyl19K+84e
 KqGQgJN/vutAruqFfThS33KHcL/PwnTYygdz8tgnJufoYPO8XsOgPpfPgBIyfOvF6RHT
 KVuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb23CW2hsKe55dHcz4Qfyln25OdCZvyt0sgpLe+eI+hoIgCTK5zLg5eYsV3pzLQAl269UsvoYaNrNt@nongnu.org
X-Gm-Message-State: AOJu0Yzpc5SxQMC6wAsmxUBkXBNSGKv795fAy7BMx7IkncfpQQavyhKF
 2uROO3AFKsDuSc60JPVrvcmfC34tbFspNQeJ4uyqVMVw5scTMOEZ8KEOIa98v+cF1dE=
X-Gm-Gg: ASbGncsD+lMvvK8t2UTv7Jb6FlqwNf6IF1UWBTKY5OCtggbiz+j5tfzyK1s4BslKH18
 +7jCRmWgFkoLd2qdhrZJ7YOP5BK+qVbnEu6abXSteMvofjI5eO3VNNyan6V/xEFAZ0fKb6xDXkX
 8XkfQVy1xlj8upZGpfpfaCBcTEYtTIDyIenIE5n2qlgUOXyLkTVCqrjPR4aakpolrbV/E/eTwcP
 vCgVZVNhofoNUV1NQRB2fWD2Jv0C8Nnt6ImwB+SFot0d10V+9IZGdUKZgWe79vDHp1dsSn5/K2k
 n/T7v86MrSD6uEf2LqKhssfKAXio3nbS1IMEikQX6ECi41XxwnniCexBaSZknDKUa2s6fuVhrLY
 290256B138GWnOb2ANzrYDiEBOFBjLnhkQdPihF8uj4iyQM2W+oVeIrkR5eS9CKcKmTO1vgGFPD
 ettTcDO1E7AguNwgn3Urdp5ATOmRfJmHrm8iL2rqTZ/kFWzL2zLvvY97QlkFJkwuYE
X-Google-Smtp-Source: AGHT+IGNAYDZWP/+L7hzObh8qymRC2eQghv3moGycgME8uAUaPmXdVfQlq8qdyCLM/bVRGwi4w9NaA==
X-Received: by 2002:a05:6000:290e:b0:429:c4bb:fbbb with SMTP id
 ffacd0b85a97d-42f73173ba8mr3571023f8f.13.1764782479938; 
 Wed, 03 Dec 2025 09:21:19 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a6fesm41491085f8f.20.2025.12.03.09.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:21:19 -0800 (PST)
Message-ID: <e6e3c7fb-0d3b-44b4-8a34-e07359de82af@linaro.org>
Date: Wed, 3 Dec 2025 18:21:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] tcg/tci: Disable -Wundef FFI_GO_CLOSURES warning
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251203161500.501084-1-richard.henderson@linaro.org>
 <20251203161500.501084-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203161500.501084-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 3/12/25 17:14, Richard Henderson wrote:
> Since we build TCI with FFI (commit 22f15579fa1 "tcg: Build ffi data
> structures for helpers") we get on Darwin:
> 
>    In file included from ../../tcg/tci.c:22:
>    In file included from include/tcg/helper-info.h:13:
>    /Library/Developer/CommandLineTools/SDKs/MacOSX15.sdk/usr/include/ffi/ffi.h:483:5: warning: 'FFI_GO_CLOSURES' is not defined, evaluates to 0 [-Wundef]
>      483 | #if FFI_GO_CLOSURES
>          |     ^
>    1 warning generated.
> 
> This was fixed in upstream libffi in 2023, but not backported to MacOSX.
> Simply disable the warning locally.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/helper-info.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


