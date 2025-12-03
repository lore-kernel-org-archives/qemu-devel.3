Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186CFD12688
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 00:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQapn-0004me-DZ; Tue, 02 Dec 2025 19:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQapk-0004mB-V8
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 19:35:06 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vQapj-0007aq-6F
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 19:35:04 -0500
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-44fff8c46bbso1794114b6e.1
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 16:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764722101; x=1765326901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2DyuuXrUg8kV3lzgriRI7OZ7LfRAI/c5VOVeGP5B4gw=;
 b=yHU0FR72PE2aquEQL16V6Ehj+uH62GAOi4sooJj7NYEOrvjsYlbHsjiE1Pu76tjmHY
 4mWx2v3YYEUbO41618Lz+GCmKCXAf8u4c5xmA6k4QxdvwGDJt9cFkEvQUr5IeLKL173o
 5O95IBKH4a/dPm2gk9KDjANNmHZHA6X+FuZ7Q6sIi0IsysR/Zi/hOv1m9L31wwnb9MfC
 Dvre6R+aFbIsJKPFYjR7R6gbalZ/oTa1mf41PfCUfwwkbE8G57KgbVE6YQd2Lsu9GKVy
 2Dz4BAuDq56BTXH1z5dbrmWY2xFzwOvzE4L21WQ8dhoF10uX/z86dWsJ3UzSun+ia9Lw
 T/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764722101; x=1765326901;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2DyuuXrUg8kV3lzgriRI7OZ7LfRAI/c5VOVeGP5B4gw=;
 b=ZqvfB9LYqhsH2iHMIbGQFzoI7dhN/KpKM7922aQX8SX43Ucd3UzpyY8oedVH35D9XW
 mc9QRF6oZOKahiG0eV6csLIrnbVQlHBlJYggjiHYerO3DS660/GZsTmc1XDvXabKDV6l
 YAiweHdF7g9c1LVG2A+t7vSQQfcS2eP9i3BfkP2uC3cCWI+VQFtqkf6r97aUrsrMyFdv
 COoeQ8T0SxXmdPuN3zv/Nfp5TIRHF6Mae2Sxgx4grhX4CgnHa8uVJtw78RDWIk+ZV9Yu
 7afHkZfKctt91KHp8kPdMWtLD8GI3aNryeBqgwqv7eAlfQdTnNhX29Ajm56+stqVcLgW
 6Nqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJZ4L2Pa7VUznvdefuKQ1wrmBnAC2YatPxT/btUK+QicsmKoS8FaK5y6r/L5aKG7bTnW0cihFKOctg@nongnu.org
X-Gm-Message-State: AOJu0YwI4ymBSZAPNt991x0O5V4B3HqTlb6CjIlfnHzx4Z8i9E5Bh3dO
 Kq1ARkigEUj4eVj0voSBZ9Xeg6veGVspnx0ffI5ROFNj1plla9fePo1WJ2Mvhghg5hU=
X-Gm-Gg: ASbGnctblDzEx1H7Jxf6DS5FOW3S37yShUvAJ9JY0cda6DHoXoE5FsgXa92ikT+yOnL
 sg6pYeo0yMtQWxQm1yM6RiPLKDZ3GCZmkNOqhZvHXPx17VugkNkHZlhdhCuNlNOtPRuUoovu2nO
 Pfdwh5WquU4KXBXEmjHlOVC0utCAunE9ZKj651zNMhm4ZbWUPyuE7e5Gh7nb+ns7SHKVIVVpj9/
 dXnN73wJdkh5XVKVJvAReTpcJyzEpDtLw/MuOKweK/H3geQRyxn6AHbE7q4kmhZ6IJpZxXQShW7
 X4V3LbgdyTMPHP20AWC8jXZsMtrDkvV057ericqTYAumoygUaICcmKKsrD3pAzWtVuCZXN0QI/Z
 bGMjINpjR+OyY8yRLoq0HOaLb8G+CqKVSBRNe5XQI942zIuSU+sGoDwS0+wEtBBzaQwVFQkFpUa
 TVgZlpHub0fGZtaAAlKvUZrrXxfQ==
X-Google-Smtp-Source: AGHT+IFxI7oCM6s7rj4ywOe8kclj9k2TB5h+YnyaNwVokjowIiV6XQHaUyTPjmwKVZ2RniASMv/JgA==
X-Received: by 2002:a05:6808:1807:b0:450:b3a:539e with SMTP id
 5614622812f47-4536e43882cmr176178b6e.28.1764722101481; 
 Tue, 02 Dec 2025 16:35:01 -0800 (PST)
Received: from [10.27.3.244] ([187.210.107.189])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170cefc2sm6472396b6e.18.2025.12.02.16.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 16:35:01 -0800 (PST)
Message-ID: <87170e51-931b-415f-b79e-949fae0f3216@linaro.org>
Date: Tue, 2 Dec 2025 16:34:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.2? 1/2] tcg/tci: Disable -Wundef FFI_GO_CLOSURES
 warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20251202184653.33998-1-philmd@linaro.org>
 <20251202184653.33998-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251202184653.33998-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

On 12/2/25 10:46, Philippe Mathieu-Daudé wrote:
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
> Since this libffi change was committed more than 10 years ago (see
> https://github.com/libffi/libffi/commit/e951d64c0852), just define
> the missing definition on QEMU to silence the warning.

See also c23e9a1c from 2023, which fixed that to use an ifdef.

I suppose the inclusion or exclusion of the go interface is neither here nor there, so 
long as it compiles.

r~

