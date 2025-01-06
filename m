Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE8EE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 17:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUqu8-00076X-50; Mon, 06 Jan 2025 12:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUqu6-00076M-Fy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:28:38 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tUqu5-0004H6-0e
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 12:28:38 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21644aca3a0so29263565ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 09:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736184515; x=1736789315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/N7P41fqn60sJoiyXjPs73j+4L1sMCOkBwsY3WxADUA=;
 b=vZEaP/4w1yXic5YeJPl5hyZF9+lkZJupWEtj1x1MzgDbqnVIF75bKFn9nvi6fiTd+5
 WMQdx6g4cU+FvvpdmQ+dLnpF15C5ot3EJmUu6NxpuuOu+KjwMj0g0mPAYFxFUfuB9I85
 6sy3EuwFSNgpNSMAKLCjr9yoUoz4z8Ry/8A6nRp1irfchzugL2gMyMeO+6PwUp3/bHvt
 Z9/ZJYBzjATPRo/GIXs/dX38uxDKP2fsNi0gB3T3HU5sQAiXvTzoZPT1+kc5lcrcAHSw
 zxdT4rNR2c5oKRJRwr1+YF7hgp9e3RoO63M/N9CjuWgGz038IMflis8fBrnCpedP4bz+
 exxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736184515; x=1736789315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/N7P41fqn60sJoiyXjPs73j+4L1sMCOkBwsY3WxADUA=;
 b=fNxf40LYhke2EaXAaA3en4fe/gWfWNBY94oxxU1mQY35DVpuwu9c6WqZeNyX9P3YTy
 DlX3Pvjh+rVnkR2oxtFOyXA0rY3HcOBBFZncmfydUQeJv+40jJfIsM75oo6k+E0lES5m
 bpKhGJVm7JZL6MYjrX8V62Jml0XTGOFXojq5Rq0rBeXuK5+kvTlbn7Jh9e7x83BqO1OI
 cDwc1E0U6pdenMzZyGdMaMnZwAdABfaj7frUTFXW2hKSUmfxSt1nX2+Ulj8BcYvlTgfi
 syXxIi1LULDIqm11InEaO08QjPx6WoX53XGKu946MN16Yhoh8koRNwU28ORFnrEtkoJA
 hGkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwmY7st9TEMhWlbaXpo7BHXD6e4Mzk68E6bLGXG67zJoE97QyJJK8PEfiFCkR8/cZmGphwUKvyxEYL@nongnu.org
X-Gm-Message-State: AOJu0Yw1BBkZ1OaQr7j+1zXGyY3uOzn5G9V7Mrrp9kR6uu507jZ5hzPR
 AKj22hP5+0jt3H8XIrc44va+tqPQN7vOzTX906R0cPVS1l8Jw26ti2hHEt8wck4=
X-Gm-Gg: ASbGncvMAKLhBaGSuX1eR9eiIIXOxHWdy8lTGCDtcWE48xPPE1bqacq+H2cDSJMAiaj
 mGsSEaNgfvxc7EYKKhWnZ3irwCpFvaAEZi08Mtn2+/RaAb4YWFLNkcPYND14dfgKnmpMvt43bRI
 Luao+9EBz1vieifLOK5W7aAlcRu20IL02h0KNIxh4gzFWyMwNY1bGurRo43xv+51U+i7Z68QCwX
 OuGEfjZsHSdcSZpISj5h7O+oGVfYYSt9HV7D61Q7G8m7gvPdWoPYsiHfZCTQk4k6bopZ33hjtFO
 EpqMJ0MWB8uSqYfONVP6HhHP7qYYAMo=
X-Google-Smtp-Source: AGHT+IEsomIUy2Q7NHi0kv5yDUNmlPOt15lf/oqiATWKPM6HhDt8IfJbfJfzfE/WPZDGsGcRg4eoPQ==
X-Received: by 2002:a05:6a00:410d:b0:725:f376:f4ff with SMTP id
 d2e1a72fcca58-72abde0b086mr86405420b3a.13.1736184514973; 
 Mon, 06 Jan 2025 09:28:34 -0800 (PST)
Received: from [192.168.132.227] (76-14-228-138.or.wavecable.com.
 [76.14.228.138]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbbf6sm31705873b3a.111.2025.01.06.09.28.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 09:28:34 -0800 (PST)
Message-ID: <10f93bcb-bef9-43cb-a87e-aafacb9317fe@linaro.org>
Date: Mon, 6 Jan 2025 09:28:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] semihosting: Reduce target specific code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>, Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20250103171037.11265-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250103171037.11265-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/3/25 09:10, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (5):
>    semihosting/syscalls: Include missing 'exec/cpu-defs.h' header
>    semihosting/uaccess: Include missing 'exec/cpu-all.h' header
>    semihosting/arm-compat: Include missing 'cpu.h' header
>    semihosting/console: Avoid including 'cpu.h'
>    semihosting/meson: Build config.o and console.o once

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

