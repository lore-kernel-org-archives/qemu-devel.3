Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7996C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 20:53:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNHap-0006qe-Bg; Thu, 05 Jun 2025 16:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNHan-0006pr-99
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 16:53:41 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uNHal-0000t0-PT
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 16:53:41 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-b2c4476d381so1428669a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 13:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749156818; x=1749761618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d6QSxoH8YMxAkEY7u40LwJLutDJ6kfkoNyWKMUjKwFo=;
 b=pBUwsVShQI9i3xz/0AKGFnJ7Bt3J3S0k7Vd9iSP/C/uuVpqte94zw3C5uxta5gsoxm
 WL/FNyLMoWJE5H5+NC+Le8+8tE1YmYxskj7DxJaX0ClAefSFTEMSN0bbR3egW40vRDeT
 vtpR6ePZx42Qvr+mrtU96yT0aMB5LI1S6jg0aQLhNmlY3p+ox7cBhxXhzzBJucvVYYTi
 fB7WQq3RIdxRqc51OZwKBDPIREBxpcPNZtRd0arQDd1hkwtRzgqLCVCGvEyRSl9sDUY/
 puuWbbbpA+Wy0uQkZ8pCrI5PirqYsgGpGHVV5UlIYQZV/jSglw0kXBIN3xDIOjtcVpdr
 k68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749156818; x=1749761618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d6QSxoH8YMxAkEY7u40LwJLutDJ6kfkoNyWKMUjKwFo=;
 b=SzHVBGcLFOsDBEj9vn2nxwFuYlaxdukP66b6lH1hmMqG4TgbjUx1TtOWjD3wY/Ii7N
 S+9Kij98+CwqHGkjSLFNexdTE4qc1OkQgllKO3qi/8lwjTRFB1bohKhB4fJmUODKmy6f
 hmFSWN8Y2VnWbLtUmXe2q9PM20cBy5OPm94Gs+n2Fc9EbCLMllN+MGLoXCOfqzRH7Rtn
 q0RBMWS+vw+ayRcLfqYw8xar6neKKQK/bZe3OtFwQt3HtqfN19Wy1XUK6Irlne6na6U8
 vGRKpGqfOl0ikoY7DhLkZ8sqxgyIjuM0BPHWQIn/xDSzc0wGht/i3cl/ZpG7bXHXGW0N
 cClg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoEfCxaZHtJFc4FxomKFxGTX83z0aZbIewe6iu7JTv0TkGlobBZhY+SX56KutIcjb6HmKYrhRS8uv2@nongnu.org
X-Gm-Message-State: AOJu0YyhVBGVhuajOOq42nE34B2p01v3NZrantzLjIDa9wXQLMuRK6ei
 /LRMLCDGnlcNhx0R9rtDwbfKts459lhd8yb/ItfaNMhzYGaZmx94ax4ySOBjO+UDmg4=
X-Gm-Gg: ASbGncvYWnSOe2vAit/O3t2QYCqVrZZZ0XAPCLceh8YRZqqS44YivkkpAtWOgw/tEqq
 utf7T4VS9wdnujdAHkeI3xCACr3wU4cKkblhOIO80OzHHW2LLd18ki1Jif466HHi84KNrjuPNxO
 VNTbp6FVusA6aVtl5QruEPw/x4m3qMBXxUN8UlTmEJ8WhM5cBXmchsZkw1mbqph56JitkO8WbZv
 rGgyN7k37ssYoOmAYGcC/B7GyNNQ2ILPL+MxX1yCyQwp5g9xGjk4g6WuZGFCNIKark9nmEmyLwQ
 skIjD1sIPMKVg4HpgKBdkGr4cChrOD/fS89zck2vPEjBbg4Mvx4SokTvg5j4NSvfuR5Kjdv9KAW
 KSnYVWuS7yg==
X-Google-Smtp-Source: AGHT+IGVaA4gp4aKZ6kEJJfdsAaVA5S3M8rqrkmKh+sGXb3B1KT5V1GVZRAHx7l/ny7qo4+Emf4Nvg==
X-Received: by 2002:a17:90a:2ce6:b0:30e:e9f1:8447 with SMTP id
 98e67ed59e1d1-3134ce5bb54mr33645a91.4.1749156818423; 
 Thu, 05 Jun 2025 13:53:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3134b043d5bsm96118a91.6.2025.06.05.13.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 13:53:38 -0700 (PDT)
Message-ID: <fcbf5124-8b33-41d3-952f-ea35225abd10@linaro.org>
Date: Thu, 5 Jun 2025 13:53:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] system: Forbid alloca()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250605193540.59874-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250605193540.59874-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

On 6/5/25 12:35 PM, Philippe Mathieu-Daudé wrote:
> Eradicate alloca() uses on system code, then enable
> -Walloca to prevent new ones to creep back in.
> 
> Philippe Mathieu-Daudé (4):
>    hw/gpio/pca9552: Avoid using g_newa()
>    backends/tpmL Avoid using g_alloca()
>    tests/unit/test-char: Avoid using g_alloca()
>    buildsys: Prohibit alloca() use on system code
> 
>   meson.build                 | 4 ++++
>   backends/tpm/tpm_emulator.c | 4 ++--
>   hw/gpio/pca9552.c           | 2 +-
>   tests/unit/test-char.c      | 3 +--
>   4 files changed, 8 insertions(+), 5 deletions(-)
> 

Good idea!

For the series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


