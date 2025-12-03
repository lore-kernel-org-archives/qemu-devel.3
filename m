Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4181BD15DBC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 17:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQqZn-0007Rn-43; Wed, 03 Dec 2025 12:23:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqZl-0007RN-2A
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:23:37 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQqZj-0004HE-In
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 12:23:36 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6420c08f886so8949827d50.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764782614; x=1765387414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mq77UHuKuXl+UX9OZA0/xLLl3F+qaAmBrqpIdVW/fig=;
 b=Mm3jO5b+Tu9xEEQ+O7rIMYmw/zwtFcVUGvbZDN6M3QitloiHTVZLlPXPWe3zDWp84Z
 ye35p3pj8LFaIe1nJ4PSdebjxv43xe/eKE6DUN0ONDCB7kagCbhYn8UygCTjeR1ZMani
 dtAa/TjNGhnN+HaTX8TTHrMEiCyJw/dXa6mePfgVOGslvYsjwseIS3Q+JN40zdqcgKS3
 3meY/WSAjdxUMRu9g10loVSxvJhHDF7myyt4suSyhqfi2+vqZBJO+oHoH2BTroPfK2j7
 fLrOgcmVC62Rg7IPQv4Kuda9+wnwZXMVpJtc8pWTG4dwFN4mUd8jR7lZHCd+XzS6NfqZ
 dUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764782614; x=1765387414;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mq77UHuKuXl+UX9OZA0/xLLl3F+qaAmBrqpIdVW/fig=;
 b=MgPig3FOWu6sVVYyFAN5IaxG5WmzJWDBmyGW6oQ7zVUbL1r6rvnNTk/XHQLR1hv9Uw
 lvRYiUJlFYhw5/1i8+l+c38+9tkmCXuPlCbud+4kBVTRDwOSe0FycCjbp46tv2C99vUN
 1QgPKrTsKQgpnikR7mB/DCB+Awq7qnvmCNppgk4GVtAKQ9Zjq5nd/DK0mTfeJoc1CPrr
 +K1gc7x2IDXrgY0bJ27mR2uAp6xFFwyg4lVvW6Cn4fnFudZMKEJqrxybV5d0em2h/IKY
 i6BL9/ajofGFp9uM6Ni+Q/O3qO3XV4YRoo11TbelYpwn6rRshOruI98I2vsOpYDjT+4U
 tabw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOeGXgxJTY2mnGoxUuNFecvTeSQ/qrFG9bHhwbURhw+KWQa6YlIW1EUNhNY/7lBqdYDQqKlLimz8K2@nongnu.org
X-Gm-Message-State: AOJu0YyAykW8xI4NOWVNMRuaS0piGNFZw67g3RKZlaFceuHfjFet/uMp
 NXeQrXuQa0+azXg6nPM89nhtgn5QTkxaffC/mRCWQtbbhYzKK6WrfXlYStEKOTwNUi8=
X-Gm-Gg: ASbGncvfMfHW5K0xZLhpmlsmdzdB/l9+1NuCfla+3OrTQUOn49BY5YFlyhbZFxgMX63
 nZ+3tSozhQ8VTS71YfQ1cdQiTaDtfEdJxqXYMwq+KsdLLETdDQY2NXBg4HbjulSXmcLjaxCLkGc
 /DVHJTlFLXTBsFrjPzqWd+dvV5z8o6txuWuCWv4cmPpDjWgmg1COK7yZkW3SYVSyFs0YJR/R04G
 6iv+MLYz5w6GbXFotOtMD0vz2LsTjriUO1xFit/EZt6elgxn8psVuSZDqjnJMa8JYCQLh01PhE4
 Vonl9/nYeW8Bu9l5z1w5C8te1vZn5CLdCW5huaaTmwTAZHptz73CNlAIloNqwACvv0nVU2DwT6w
 86GU3XCOtpRLnc51tIPT5z/AWNxqUuPsgvHerGx8IoEY3xpChyQTKpw0hHLgN8s8TIhsK76hvW1
 9JKajh0FNhsc1pzIeEcUhwpphMF7bkkf0eNHDZIKkaacJXFNiyFgQ++g==
X-Google-Smtp-Source: AGHT+IGtJ2YykB8gC+mDXodNNXNgZRgPRyrxyfiR1DHmUOfAjqWQ5iqbHdr7ClBbpi+OEw4hpATpyQ==
X-Received: by 2002:a53:ad4b:0:b0:63f:a457:6b21 with SMTP id
 956f58d0204a3-64436fe1846mr1861187d50.33.1764782614119; 
 Wed, 03 Dec 2025 09:23:34 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-78ad0d3f5f3sm75992057b3.8.2025.12.03.09.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 09:23:33 -0800 (PST)
Message-ID: <5375cd47-272e-48a4-b0c6-12d7bf11af0d@linaro.org>
Date: Wed, 3 Dec 2025 18:23:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] include/aarch64/host: Fix atomic16_fetch_{and,or}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251203161500.501084-1-richard.henderson@linaro.org>
 <20251203161500.501084-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251203161500.501084-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=philmd@linaro.org; helo=mail-yx1-xb136.google.com
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
> The tmp[lh] variables were defined as inputs to the
> asm rather than outputs, which meant that the compiler
> rightly diagnosed uninitialized inputs.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/aarch64/host/atomic128-cas.h.inc | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


