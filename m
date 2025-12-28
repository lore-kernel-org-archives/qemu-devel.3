Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F62BE784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 22:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZzR3-0001xu-R2; Sun, 28 Dec 2025 17:40:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzR2-0001xf-KJ
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:40:24 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vZzR1-0001A3-8o
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 17:40:24 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6420c0cf4abso6804660d50.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 14:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766961622; x=1767566422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PBAgjRaWEoUliLXzC1Iq1h7O31J00I8Xs+ft1cr3LLk=;
 b=ezHQgpK5bLtwyw2EEVMK908Z+/fsy36ECFN0zmwEm+dzQo500cBK8zCZSePN+EwOOl
 /eTNruNo6M3xI+uElFdAcPDtrB2ub58ZcVMbQOcnvJNNGOfbL8UOPs6qsFn2OtKfImaV
 4eA9qBAXos+sLXoGEXQXFQs1yEBkqknGnSU7YzRoSrAwEp2Glc6j2Decww/3jrOLxK3q
 4KQeWLtCu9cy2edP8HqrkArbaCynWx5GT87S/HBpdDjv3J4D+OmdHrJvfzK+13S/5UfC
 vJrqVvMCfVDlGindrU6YRBDILInbpEbJqPi54O7UEwhw73Va89dPkYnEkM2V6mXAR/au
 PqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961622; x=1767566422;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PBAgjRaWEoUliLXzC1Iq1h7O31J00I8Xs+ft1cr3LLk=;
 b=n1cc2lOz5XXiOJOGxyg8x6aqfxjok+i3ByJJHSifygTA35DUWCrVievJ/Im6xGno/S
 zJEFSCvvBlFHxO7ARiMQNTdQUXuvQ+K+FCJxYcNvSDbIu4eMe+/hxrxcthG3IXTI/L7G
 mBQtSTU1ipD/lf0c7QaSrPNvER4E6tRK0JEgegqvLTY2tKaxS01y9RpiK19bc+CQUBzi
 uIrVFeJtznz0veiRc+PX6nT7AgxA9MzTGKbhYOkOJR5YUbmoK3GcwGTbzXp2bvFHc1wT
 5C5GHjAaNp6S9bqESAd7SSeAGpW9GNBFAhoTeRpJ6+YA1yvAB2YxONK6pOZGhxdSY56c
 eyjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI4kaU3XZAv4Q96qj0ghS1yFvQtEPEC48xLb3YHmo00+G/xia5EmfT5oWIKCnjPardFHbnzCZEDvNh@nongnu.org
X-Gm-Message-State: AOJu0Yy5TUPlBIYt03uRyZmtmUTHzVJ6BqlguAnYVXpWrJ/FHZjB/R+L
 FB9v/cmYCZGG/cIG97IAKMlYp/y4BC/YCAIp+3RjlRDJRmoJTjAt7rmmlHuLvos9g/Q=
X-Gm-Gg: AY/fxX44BPK2FHdzO2FZA/tqIp3CiRddYqZSJ1eIw/dpg2wkNGtBOS7fchhSH3LpLvy
 JIq/LiREUTPQRJa5Lj34Bgub2n9C3okB7MOxov0FdSUFbZI91EuDttdwaXsSDQHLo3s4cROwVEP
 6G3ii0qhgFKD54+6n0pOFsnjIrvqmx6dP8GrWCqFVag5J73stONJZJl0q/ivIEM01eJHz0pARBf
 7QcapEbW1u4yOgOhp1gXAi6GwJ3x2v+LXwfWtAGXkRul0S5LYqlCoaqDrhTSoiBFXOGl2JGrd1K
 SMqUaJfQZLIMAyWuhGBbQUM1K6jMPAw1zGZcUqQaPq1yXxb8THPsZlfiLyZONio4uxXOTZrwwkS
 Zrg1YnZJ6FEWqvhdAt62lpFOD/UnvYrYvEag5ITQW+eVyJDWX//mgQrq0HRHQ/ul+Q4BmEPV6WE
 IIWEJlPupDPgZvZgktDX/aEW4QrAbKVc+dB/xhPKDyNEPxmMxWjpVv
X-Google-Smtp-Source: AGHT+IHEIeoS7TXdLc4LOiEdXdKdJadg+puvSkgIJdc8FVa4y+0R0vjLtF/WMUvwSUiMIWVsuZpKWQ==
X-Received: by 2002:a53:cf44:0:b0:646:5127:9cef with SMTP id
 956f58d0204a3-6466a8ed47emr18282495d50.88.1766961622045; 
 Sun, 28 Dec 2025 14:40:22 -0800 (PST)
Received: from [10.212.166.227] ([172.59.192.106])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-6466a94067asm14030187d50.22.2025.12.28.14.40.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 14:40:21 -0800 (PST)
Message-ID: <1534810d-7fc6-4c3d-9dca-b4d0eda75d41@linaro.org>
Date: Mon, 29 Dec 2025 09:40:12 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/avr: Mark AVR-specific peripherals as little-endian
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251218213053.61665-1-philmd@linaro.org>
 <20251218213053.61665-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251218213053.61665-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/19/25 08:30, Philippe Mathieu-Daudé wrote:
> These devices are only used by the AVR target, which is only
> built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
> using DEVICE_LITTLE_ENDIAN.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/avr_usart.c    | 2 +-
>   hw/misc/avr_power.c    | 2 +-
>   hw/timer/avr_timer16.c | 6 +++---
>   target/avr/helper.c    | 4 ++--
>   4 files changed, 7 insertions(+), 7 deletions(-)

AVR is all single byte accesses -- it doesn't matter about endianness.  :-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

