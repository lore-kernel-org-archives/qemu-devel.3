Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FCACC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 21:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX51K-00033O-LR; Wed, 02 Jul 2025 17:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX51I-00032d-V5
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:29:32 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uX51D-0006ca-1J
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 17:29:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-747e41d5469so5481036b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751491760; x=1752096560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1JBN4VEHHJ5qhrPCRoUcNoq+v/jCXyf0QfQS+wS4gxU=;
 b=j84k5N6f2Jqp0I2zB3PUphMGbukcEWQ/5JUONDQNRy+yHYbfEfOmKQy9S6cf2/jQ2I
 zaoZ5i38EuwjKfD/A7apNw9S1SX2WWK5dglzoOzEW3Kd7gkDPnGGL++kFZLSYaTZhjwd
 ERV7oD1j5AywnhnWokg/xNd2lS8px5e8p+g+W2r4bV91Bc+mDaGAN5sqjH7sqWiKBuB8
 gmj2irXxvFM/njkrPOCSNVI+dQvWlOkJMXHONYbFvx5ei3mCcwxgHkQyZhHvjOptoq7K
 NILIKYmcrPTGwoWcMAQUV+QVffE1d/pb83zeCW2UfINhCZthf6olh4jKA53KeP5uD+Ze
 jplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751491760; x=1752096560;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JBN4VEHHJ5qhrPCRoUcNoq+v/jCXyf0QfQS+wS4gxU=;
 b=D0nso76bdv2QDd0ZnYwmpSCwKExgfJUfXo7zW/yIN6YmWlV6TpOGO6DvTpAg0EbM5Y
 ZdpMXvUrMsG9s24P0ysChkeuARhEqTpn87sgXL4xVQk1e3r5vR30GLdkkeRJ3vmdQ2Q4
 AjTeX1o94NiaFq5oyYvkrb6diLxp4WiX5vJxGXOP/zLCV7edXflVkCFaARU2f3yyrhaO
 eMQW2biVweMvKgryX5nB4B7RM/OyAd3F3OIYQXwkVM94ftc8pSJ4AQLuaGtS34G0aTay
 JcUeaYEFRmxzvmNoEKM34qv0DT4PfId5zIDhhZWrVL5VGYs0z2OIGFiAhyKsG7qakUUu
 4+/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVSzlthLwmcG0xFvd2QhETicQzg+TRh/UF1pJlqdqNfb+ATygYSx6T+D3kNTtofBHf304/ti1m1VLI@nongnu.org
X-Gm-Message-State: AOJu0YyHePM9jEzg8KrS2WMpwjlxVpVKXptT0of20OmfQVORQ2A+/329
 u0GQPO9iS1u6kKx5EYc+EzTcXfl6VtQoqynanDOSHoNP/mnfI3TsthLpQA45iPMl7uA=
X-Gm-Gg: ASbGncuHkSlmD61jGwVXewklKQILH9l8bihejlu+JaezxdwD/KdySg1heU7WKERnP59
 3iK1qKC5v2O7HStimzP1fhVJZhy9U64ELC+ZmQQRADC3w98oiGEYV0xGpKsMXkK7HUnDyPbVE9I
 Vvpzz5zdlEO85A7VgomBy3kDubS4Mo7lGT1i/tcB2QRI7EJ4hKbUbJPuzbFDh/ZuCOvTxEPoUKc
 BT2TkeDOBmtH3HNYJbbbKXGxklfldYs4VJZfhBTZ01AbD0Rmv+Iw8YKXf4V10HEod/aKy5MiORF
 49ufDG7NiFeQKgtJCBp5zNb0vmXDGjk1zBUeerDqGIyCoAAD8Ry6Rb07WjwTuXGUNUydk97SWJf
 O8lmCbJ5fZQ==
X-Google-Smtp-Source: AGHT+IGRuBACXsDA843dAiaUWQFNi7ADzA2La0R7WmOEy5AendhMfLNglWDzA26LIY1kDqUHVWxHxg==
X-Received: by 2002:a05:6a20:c79a:b0:220:ab9a:953b with SMTP id
 adf61e73a8af0-222d7ee75d9mr7746925637.29.1751491760494; 
 Wed, 02 Jul 2025 14:29:20 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34f7a42d37sm10941044a12.8.2025.07.02.14.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 14:29:20 -0700 (PDT)
Message-ID: <137f258f-c481-4a5d-a7e6-0e290e081091@linaro.org>
Date: Wed, 2 Jul 2025 14:29:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 58/65] accel: Always register
 AccelOpsClass::get_elapsed_ticks() handler
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-59-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250702185332.43650-59-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 7/2/25 11:53 AM, Philippe Mathieu-Daudé wrote:
> In order to dispatch over AccelOpsClass::get_elapsed_ticks(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::get_elapsed_ticks() mandatory.
> Register the default cpus_kick_thread() for each accelerator.

Missing a replace when copied from previous description.

>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/accel-ops.h        | 1 +
>   accel/hvf/hvf-accel-ops.c         | 2 ++
>   accel/kvm/kvm-accel-ops.c         | 3 +++
>   accel/qtest/qtest.c               | 2 ++
>   accel/tcg/tcg-accel-ops.c         | 3 +++
>   accel/xen/xen-all.c               | 2 ++
>   system/cpus.c                     | 6 ++----
>   target/i386/nvmm/nvmm-accel-ops.c | 3 +++
>   target/i386/whpx/whpx-accel-ops.c | 3 +++
>   9 files changed, 21 insertions(+), 4 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


