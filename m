Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4881DE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 07:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV3pl-0006Av-Es; Tue, 07 Jan 2025 02:17:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3pj-0006A1-Sf
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:17:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tV3pi-00075T-Ea
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 02:16:59 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43618283dedso150578855e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 23:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736234217; x=1736839017; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uIkRPuwSLntdo1USXPYb7tas0BJeSKX1N+bxtkADDh4=;
 b=HoXer60YqNpTyOoWzy1fRmjqH2m3I2J6Fv0ygJFFUzUz4Yv4UZ0Km01GIQN+NQTMGF
 9SjXgAJfbduYFwvtRZ/1xHHykhw72J3lIWxVFep1F0AKq+L3TUvIxy5AkNdLTNCp36Gw
 9BWCmNu37rx+bcULQJESK7YWYeoBPivAYSIi7y4IqiAmTudElAl4FiARZx+EvBpYcB5P
 357T15hWAJ0xAx/2s2UNX0tHxVGcL7xqsEXt1j5kVKSrcG83D1N1+yAp2qiSjANU4zXX
 +vxGRYl7lV3ReKDCBaUYkSW40b1vL5mIcverP+TaL2Vm0kagzAwd1qpNwOOvvfnFWKmm
 z5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736234217; x=1736839017;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIkRPuwSLntdo1USXPYb7tas0BJeSKX1N+bxtkADDh4=;
 b=G4/0c939WNvNtJsyBxKbnRHWsXlH5aCoNzZi790cThYXgK0yh4NG9RxyX75vQ91UK3
 NWn8/JdNRo2wTJhSiI6KQm0aU7KMP/3KArQ5iBezdX7kD1oKzDlkMSlsxUhsx6WUE2jH
 78m03BAhyZLKWrVOauL7W0iuGVtXJQkdrLbuY+6zTsc4hAKVfog18WL9xERlLrWx7BEU
 DV3a3gGAcAi7WJaWTzWu6o0QxYMUlyNKNcL2q1oOxeRFj7aUbqfEcTeEh+5o9BzIlzkn
 uE4oQS57RxYtE7rxTjERLivuE87FIsr9s1ycFaHQvT3IpHyZaYe63I5V1fZX4M5+ef1W
 8cFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQKkIQTDANwvAl/fNXSwdDpRWVmIwcbW99L6ZAxhPQEIyNtKaLXZxrcCLMGQCTsQjqsFFlikAL8iHQ@nongnu.org
X-Gm-Message-State: AOJu0YyaxJXn/Y/j42UZDJCLYbC2W0wFgquqrq7kfnzIAYBsNHzZjAtX
 QHwfb4vuBZZGsMq6jdmZ+Cvlm+AlPE4fvlXS8bM05O7TwaSVQCee5hJSPLykF6wrgNFYL8fyLLx
 Cvk8=
X-Gm-Gg: ASbGncszMswg19k7r/gXP9LSqgqs97qsz2duUVY3NhmjGN45Ta3PA7Q3iH1ZNJNDsLa
 USoRefTwmPUhR0zGd4x6uxbDEoKeIHZEgW1jcf8tRTC8+/uL5cjEWGdH2cg0qYsr0mvPZ7RBbms
 VWqt/pWmlsfRyzkdX+vWRQsW9QWss4CzICpP6/G6kiDVxjUsUaM7OBVoRe6zeeBFI1oGIIBXDLa
 uo1Et/2h4upNMxAwKGA9GpAH6A/5GjOAptCknUgPjVKcbcvlzRE7bshzOqJpOui+sOYuinrGjXH
 /1kCTo+xhAZfV6MT6t+GdYqo
X-Google-Smtp-Source: AGHT+IGtYp7CAPCiXjSxeNkAo/zHF0XjSfd01Q7lFZaUsHJzbPmn6tlZQKH9cZR4vCf2/SZ8Q5Pa2g==
X-Received: by 2002:a05:600c:4f03:b0:435:1a2:2633 with SMTP id
 5b1f17b1804b1-43668645cf5mr565158665e9.15.1736234216738; 
 Mon, 06 Jan 2025 23:16:56 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b214sm629423835e9.28.2025.01.06.23.16.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 23:16:55 -0800 (PST)
Message-ID: <a6b74f6b-558f-4369-a9fa-8436a6e5e8ff@linaro.org>
Date: Tue, 7 Jan 2025 08:16:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/73] target/arm: Use tcg_op_supported
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
 <20250102180654.1420056-10-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102180654.1420056-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 2/1/25 19:05, Richard Henderson wrote:
> Do not reference TCG_TARGET_HAS_* directly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 10 ++++++----
>   target/arm/tcg/translate-sve.c |  2 +-
>   target/arm/tcg/translate.c     |  2 +-
>   3 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


