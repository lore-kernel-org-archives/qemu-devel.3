Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946121061B18
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 21:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7KWz-0007Ay-Am; Mon, 30 Mar 2026 17:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7KWq-0007Ac-0F
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:52:12 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7KWo-0000oc-5u
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 17:52:11 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so59747925e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774907527; x=1775512327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w0CHXWdnpA+pfVNLBYwJ8ceXz+QZlOVSZ6n6RMjhwtA=;
 b=uMvDGHaqJS2tdDYPC6ketLE9/B/xENXVzhrBL7BaTBeDBNnezbBocwIrfDbpVfve2D
 GbDYdusclDOQc0eQHL15CaVjDHHpr2ONIBD9Re51ecIXN/2/e45uJttzjK94d5tZFpOc
 7zHqC9+2E7aj8ZmmGfZeqmAnJXH2sx1e9LUNMQtDfwmH4Lyp5CXBYKWEQpBNsihQCqbJ
 YxLFx6YpPGgPW6ILhBdkFablorShwpdi6CMI4l0N7ospR6t2jMqFR16FoxkyS3MmXOru
 yWiTBApNJwWO3LKzM3hUe1Eesn/gVZiw2iwXnho32UD8xk8+JA7NaUi7zu9IhyWREZ9n
 nEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774907527; x=1775512327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w0CHXWdnpA+pfVNLBYwJ8ceXz+QZlOVSZ6n6RMjhwtA=;
 b=JnVq+wW0UOku5jvaB7he6P6DdOYq+gjUz8zpVC+v7Bmml2dN+s1iiicuulIqAtygeR
 QAycdq1foQP0zL0L088O5dwuVFaiHIKW0jEbM0PjAiHqIRtzj7G6nHN4UknzIeLssw8T
 jvatWEGspVAVA4HVSCsLfZnAP2MZgZlcS8vg3geq3ptYK20NmpNJMjSQ3R3exCiGYKDw
 FqXr5dBgHeYh1R6cORGywfg76xZCQXjjAh+7rTppbEB43ZMnOdYYBlLk8WlxucwoAaii
 0/xINvp3yAXMJw/SjG5Ew1kYclV1tFdrZfSC5vEFiQ5nfUr6UhfAteXlOlAm00hNAM1g
 euKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyiiAQa0egb9ZKesYXFAQmddi3vJwz7wu3VVPXtVH6LvjNa9l07IT0Y9u151wAHBCPWx7vd7Juh6MV@nongnu.org
X-Gm-Message-State: AOJu0YyFls962kS1e5ic9T6qHlk9rZwGydEJHe1/eTL4WGnPc0HxQV6c
 6GhxSfY0oBaa1uFKKiF4Ae4cwOr7TKCE+SsQxTwotWS9J55+jIN6QTft6S7H9eHRYcI=
X-Gm-Gg: ATEYQzxX3rjNWcDkMR+VVmJq1jA+brMRXh9SO8g1gcZNPHxvfMlJ+LO3c3SygCDyWqU
 gr6OOAyg6FofGvbk7Vt8ETgFVijx4xTXzf1/JlMHUllr662XJ6uJui05w1Mq8iw7y+l5nOC9ZpU
 Nx4iDQEblfHBwTNW1s7LJSx+zMqJ0CaQVgm6IiDARsC4Uw6SfE3fr5/1Ac4ozXzPrtTePgqjxi/
 V3Jx/VCN9Yp3zCENfP144KWOc+L/WEuUhzJgCipB7f97ksV8WfZL5qIxmnaQ2j9hFvyRUbjOkH2
 9cjmUbXf+rdUCkgiWcA8It4TmS/mgloRrUmuwpmVtMPh12ufBvxJ9lIEMIf9+DiqyKoqLVwNhd1
 Q3woQNfN9J/024UYCoGfTSqFUsf81iIHUBgBQYpxGomtamZ5oB3zoPyhMbmJ0qQcF3U2brEApCs
 ocIpJnoTp0nspmtgXN7EeePiHwQ48yicXsqVUilkEOtlHVd/MuKo4Xo4jxaf5y
X-Received: by 2002:a05:600c:a44:b0:487:59c:2bad with SMTP id
 5b1f17b1804b1-48727efcbffmr223444305e9.24.1774907527123; 
 Mon, 30 Mar 2026 14:52:07 -0700 (PDT)
Received: from [10.193.39.66] (246.148.216.82.rev.sfr.net. [82.216.148.246])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48727192012sm90577355e9.32.2026.03.30.14.52.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 14:52:05 -0700 (PDT)
Message-ID: <c7c58059-3970-4116-9a8c-07b805dd3b25@linaro.org>
Date: Mon, 30 Mar 2026 23:52:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] target/hppa: Fix TOC handler for 64-bit CPUs
Content-Language: en-US
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-10-deller@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330211859.19317-10-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 30/3/26 23:18, Helge Deller wrote:
> From: Helge Deller <deller@gmx.de>
> 
> When the TOC handler is triggered, e.g. by using the "NMI" command
> in the QEMU monitor, make sure to call the full 64-bit TOC handler
> address in SeaBIOS-hppa firmware.
> This fixes the TOC handler on 64-bit CPUs (and 64-bit SeaBIOS).
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   target/hppa/int_helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index d5a20cd549..fd4b99069e 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -203,7 +203,8 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>   
>       /* step 7 */
>       if (i == EXCP_TOC) {
> -        env->iaoq_f = hppa_form_gva(env, 0, FIRMWARE_START);
> +        env->iaoq_f = hppa_form_gva(env, 0,
> +                ((uint64_t) FIRMWARE_HIGH) << 32 | FIRMWARE_START);

Maybe we can define that directly and use? Such PDC_FIRMWARE_START?

Or have some hppa_pdc_addr() helper?

>           /* help SeaBIOS and provide iaoq_b and iasq_back in shadow regs */
>           env->gr[24] = env->cr_back[0];
>           env->gr[25] = env->cr_back[1];


