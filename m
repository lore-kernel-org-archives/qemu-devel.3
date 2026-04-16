Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BD1F8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVyN-00025p-BP; Thu, 16 Apr 2026 19:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVyL-00025G-8h
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:18:09 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVyI-0006Rw-N3
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:18:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82f33d28c1dso53333b3a.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776381485; x=1776986285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xOvuWlfr91UKP8ZA+tGsKjHiDHp15zJ4UWQTZcws5Do=;
 b=Nj5slFOFgcr1xfD7f1+IkyJLXxoQmrT3myvwl306sSQ4L3EtIqNG3biI68MmpaJUoU
 mVraytzfUyTOC37tk+yLUf0CKSnIyrx5vH2h+IHasC09N0IkHF0O2Uda56gosMYvTsTy
 Lz9pKBbVDeutp7UdNVZKovDs1tTqi56SJ0N1fIhkhOBrwmcR87fKywh6j+vgAjmqfR7z
 9oag6WtRX4FWrMtY4D9gxoHlB9gEDXP+FeyergGrj5TB5xYgxh+ClxV45WZP0PRVnwcT
 Q9X/7gQ5Vpj+JDjrt2mgnCGWqd5BfnV8hZ+AK2/qEzTMlqVoWT6Rz3jx6vSMKbHbpkku
 D5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776381485; x=1776986285;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xOvuWlfr91UKP8ZA+tGsKjHiDHp15zJ4UWQTZcws5Do=;
 b=owFbrWL4clkQ/iz1YJy8g97za+uE3iayN/2oLe449luo5zQNSYYIGqLnkXRzHrOj+v
 8/54Oov2iVxVTYR0dkVHyD5fGwlwh0NbOfcO+CF3ajmVOPJfecmy+olEQeNWus1oQaXD
 ea1heRFiGY6T6glCmTsvcw7OYmszfiNrALyolfw2Lph1xfO9sZMfwb6PagHBxDeq4liH
 ox6yQHiqNZMY5TBb4PmvdBMSm6QpZvXAxdNn71Vte5bEHJiElRCZmC00lJ1BWoo27QX1
 GzKSsgdyLe+YnV9vtvpRKZWIJ/9LQN/JACDR2CXzkFr4wVilsdbTHO43LpFKf15E09tc
 YeQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QXQIuXEJsTRtGGpw9VK9i0q4w6e/IJEabDJGAnOig1gX3mN8r8NXSlBv15Vvzla9WVulhHm6hLp1i@nongnu.org
X-Gm-Message-State: AOJu0YyNBltFOwf0jqeAk6aYaEe58grloqeEQYfxAGgumg7CrVsLzdDx
 lzb8xb3S1TOy9hsHI2lTb4OqVDHCkIOxWi+7ee5hMD9Fz7XKmrZd9meR13Zv3yB04Hc=
X-Gm-Gg: AeBDiesM0gGgrnFmAPnHgzreS3eol3e/8S6vuRBmIS78MvlOQ5Yp1Bqmn9m5TJmn22B
 NRZs3W99wOlVB29uStNeJwXkjpBhg9SbKYmp+p5uDDWnzbRWo64ObrH7O0i1zquytO4qV5qtDu5
 EnFkcgcMPViIHgCV8hcYjclnUZmiik7NjwzU+zKkAClswU/ySZqV4vXvlECQHRiZXZJ3phVMdEa
 LkVbNgVDhcOW2snCuyU7+F30EDEL4I9KVXPOHAkV6JXDlZ9eCxoM6SPC5GRxXrtnKuqm2u1viRZ
 SgnqngV8AHA+ScPnH2z6ckBquXzrlNUhylWDYeBqh6LYmClJn8E53+jpDxQr1wRIbIGGoi6DJ+s
 TSz25k3zHSaAFZx+lBTpY2rcEC4D2EY9qxc1cZNcjyfCjMffiEXrPy1BEGubKn8RhjLMJIgzLhN
 P+wfwFeqpw8KYENkFBklk2Qm0+qwq9Igy2mfhAUaIxPsjd6C/XKupZS3Eu4HLp5ERgIRkJAeJxX
 /uw1NP3HogItG+077YZl5EkjdnP7b3+BawTq7dJscd4tNW9OIuuhKPeiSqlk3NyNA==
X-Received: by 2002:a05:6a00:3cd1:b0:82f:6b3a:8281 with SMTP id
 d2e1a72fcca58-82f8c84dfa1mr260467b3a.7.1776381484695; 
 Thu, 16 Apr 2026 16:18:04 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 (bg30dj02y68bx09myf73.ip6.superloop.au.
 [2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8cbbe9fbsm101783b3a.54.2026.04.16.16.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 16:18:03 -0700 (PDT)
Message-ID: <477648db-9ef6-4128-a9f9-f021e9c0a18e@linaro.org>
Date: Fri, 17 Apr 2026 09:17:57 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] tests/functional/aarch64: Add basic test of TCG
 aarch64=off
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
References: <20260416165353.589569-1-peter.maydell@linaro.org>
 <20260416165353.589569-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416165353.589569-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/17/26 02:53, Peter Maydell wrote:
> Add a basic test of the TCG 'aarch64=off' functionality; this is the
> same as our existing arm/test_virt test, but it runs the AArch32
> guest kernel on qemu-system-aarch64 with -cpu max,aarch64=off.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/meson.build          |  1 +
>   .../aarch64/test_virt_aarch64_off.py          | 37 +++++++++++++++++++
>   2 files changed, 38 insertions(+)
>   create mode 100755 tests/functional/aarch64/test_virt_aarch64_off.py

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

