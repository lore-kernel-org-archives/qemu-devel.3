Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5F0E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3qP-0000Wm-66; Sun, 28 Dec 2025 22:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3qN-0000W4-D0
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:22:51 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3qM-0005om-0n
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:22:51 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso13871334b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978568; x=1767583368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JeT/r5rtH44Eaa4GhM7hvqq2Xp21v1Tv/gS3wMNvnRY=;
 b=UI6oz0S0Y5uS9rHTl/bg/f4EjKA610nMVWB86awYys67xG3BzXZ5cPun0riLgcpjeA
 rGXLzBu8VHbDp2FPxSf04/TDQH65g8qTtpFnK0dbCWFgGgX8VEHGMBpS7qvMmVJdhmTf
 tykWu+nNmP/7U3WXXij+vFnkIsf+zsVOyzrNKj5TyCodusWUuSpFsGTtDQ3gcF6e01mb
 xwmXQoJjEaMPxpSds50/RzSioXw42ZXXcg4hUCOvXyaawddEqZRgVtSaz1av/Zucfcm6
 1SC/tvz4Z23ExBEDNTzpriEZQW+Z0Ou24/VAnlQYlY2v5GBOYKU/d4kyPOR6k6dxFrbx
 Dthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978568; x=1767583368;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JeT/r5rtH44Eaa4GhM7hvqq2Xp21v1Tv/gS3wMNvnRY=;
 b=CEIbxR/bDU9uw/OYKii7hJo2GPlX4mzF7CPTAAOxvpQs9g4FBEI0Gc4ooz7AkYJfo+
 xYwDVGCW6gE2xFACs3ltSwz9Obj10pD9r4C80E1Tl6hV4YYJDO6b1xtjpSp9IGvNFNyG
 hBQg6FP89sGN/WwhRdQWdA4tJh3PZ+m6M1GrbMZru2XiGHK87blTguG67gxz3VJDdoQD
 1AIZ1DWCiZSgG/5faccYkrch0c35eLpWxXtguynDmleGuoMlnbdJ7gLMMGgC+Xz9W6O7
 pCRNRCkyoDK18GOpeuZuJH5ccWXqKzhrz50I6AZYbQzQxZTyaS7FImViNR1PVptCCvB7
 H8Iw==
X-Gm-Message-State: AOJu0YxfyR/l2gE4RVtXdDKRSHouP9j++XwBj6M7eU3o4Ls90c1BlSjG
 FXD6ZEZ4DEc7EaJ3cibF8yAGPFuoaAZtimTGNj+ofDVp1AynhMyBljYG1QABmcDuviknHnSGeaK
 Nh2eHVtc=
X-Gm-Gg: AY/fxX4kKrtco1DCZGdAAr3NG3IkqClYWUEWEcpQDqhX1Zb4VboCmVNBUH++2tygQYy
 Zh+V2mgj+dd91eZT99AoiuIWcRmAS6++NnuWIKlXC7gsBIaELSQKgkgvxMAY2UOxfMNw1fTZMCt
 OIm0Zaj5EeLLMPQbRnoULyDN1IWPn2mWXAOAfSnlWCrgqPDNKHK9m4PtfBO/CrQa7+/LiqXLQ3I
 UaaU6yzUQEr75ZL+JZhXvE88e90Kb7x8yk7zOEZnYLV39+DmEkG0L8LJhZVZFRfJ2tvUk8oB+ht
 Tz/lCS2rEHr+/YeaZthQZ/+cKUjn2koBM3p3YHnAQ1kxJlazgI1nN546bgwjBErywKNJ/FQDahK
 TPhToP7t8kesNStNPlsF0my6u6bQq6jjj0eUp+KswhkStFn3BMGkM5NmzXHUR/3aEGXCZdUIldE
 O1Sy5u2/eRLxn1MZsADy4e3U2hyPS65HdCzhjskF8P0YD3TN+vrnVpTCORg/MCV5O3DUExWw==
X-Google-Smtp-Source: AGHT+IHfOGexL7p2u2WQx+OpsZuOVIeD0CzkBndzQnX+q2fVvNuHkDAxCu3h8pwtFqgGwDAuw+KeIQ==
X-Received: by 2002:a05:6a20:2591:b0:33f:df99:11d6 with SMTP id
 adf61e73a8af0-376a81e2724mr29232609637.10.1766978568478; 
 Sun, 28 Dec 2025 19:22:48 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e48e1d6sm25082022b3a.53.2025.12.28.19.22.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:22:48 -0800 (PST)
Message-ID: <d1f8a0f0-991e-4464-bf65-cb4c354e5517@linaro.org>
Date: Mon, 29 Dec 2025 14:22:44 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/virtio: Remove unused ldst_phys() helpers
To: qemu-devel@nongnu.org
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224151351.86733-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 12/25/25 02:13, Philippe Mathieu-Daudé wrote:
> None of the following virtio ldst_phys() inlined helpers are used:
> 
>   - virtio_lduw_phys()
>   - virtio_ldl_phys[_cached]()
>   - virtio_ldq_phys[_cached]()
>   - virtio_stw_phys()
>   - virtio_stl_phys[_cached]()
> 
> Just remove them.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 85 -------------------------------
>   1 file changed, 85 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

