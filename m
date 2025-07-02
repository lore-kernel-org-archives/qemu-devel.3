Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C161FC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyyq-000837-DZ; Wed, 02 Jul 2025 11:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyyi-00082c-70
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:02:28 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyyg-0007Ao-FI
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:02:27 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ea2fee5471so4380fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468543; x=1752073343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/n4TQiMEjGqEsYwUM8DUUfOf7dSgjKtoqZGYyQU6sTI=;
 b=o56WRz4nBy3L+wgw3tPOEjPhTM77LULRRNdWsjqbpOgFiZ8jGAHrOQnyU+mkKOSsvo
 vkRba4DaF3qlW9gk84JdBZ1ewgs9Ldfdfe7O7cZM64I5dVZWuTAkrtaKN7oRscT45wDN
 i3DrOChp4f7jIbCBm1zi3ZPEjogoIeQ0GCAYz6GgE+NRTRnHr+FqMmgrytSR7wt8vPuO
 983fQBd8WaOjwhSME0J+BYz2E0OU/dJ0zXSnLbkfgShjqPSJ3ms9ejNvybogU8pUwBN8
 Dl4GfFNFccUE80eHkPrdmKg/lJT/MfLxjmzost4dHSS2dMPvn9CDGhQjoBC0By8+LvsS
 T9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468543; x=1752073343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/n4TQiMEjGqEsYwUM8DUUfOf7dSgjKtoqZGYyQU6sTI=;
 b=A1WhV2QGItpLGoj1PM1a3RxaaoZ6fRwsNqsWG9Xv14t3FjvrAEDJrNHndsYJKDKG14
 SJY26KbWe/t6PwM5ygy54qYk+dU6k5b1Ht3uaZuohfaS7f/+QPCBwKp4FEECpj+268rg
 wiHxolj4UC55mF4plsXO6eYqBpRciqUS6OIisjtUGoIoOX5FocYZUbJcNtkHPe+fgt3Q
 H1iYbGzJ8tsaAWIo2t6PCEHrYhrsnRksTKOgm2vGrimgT++FPTea7ikzJWzfoa2CVDGq
 NNwTivXGpnU+EYYtwgtNOhQEztU/6yOryPhr/3RhOXI7Thal53Tu4+4OOb7p08Kb4s7O
 h+dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5f7AfAv902qWNwzCi2+DM2MBT2dhsAleq/jI39iI09jDYpLd/J8p4amhhH63eBIVQ9LgrGRA+40nG@nongnu.org
X-Gm-Message-State: AOJu0YwL65qC/zNbh/pcn8cDmXJSyll6UnPlkYHoZmv/B/y+lLaT6kRc
 B8T8nSpaT2U6dn8TY2/FxbmZy65rDpj3q+T4K00+ysfIHEQfsoXA+TfWS6aT8Ul7/4xTQV8Ir9f
 8QyiFiuQ=
X-Gm-Gg: ASbGncu1XNFLKuNbKPfFzTilrVhrFxqJ9EKQput5s5MGCK8FIBHZtf8idDVnkPKoPZO
 17lGpvi8TjiEs32vTA5jB77kn8ywfQiwJ+Mdh0sKusr77eJD/SNGWjZN1Rp1mtsV57+SVcLG0o7
 V9lLUqsQ0fJQOcklG++/J2qdDL7vuadcTJo/6ADtMg54EHXBd+F4BDg3tOWns6IZNGOSGI0Q6yr
 pfBld3tSnzD8IUvLIF6fH5Qbp6Th4lAqyV38TSEBEfLqjlz+Sepr26cPywo/uGOKxFAUW/Cud4I
 QcWSYfms7v3k2DNbpeFfAVSDLoi3JsrkNdhaDv0z3Y4fWt+brH9hQWaOwXy7c5X9LoUr5Fu7qFo
 s
X-Google-Smtp-Source: AGHT+IFxxqZkSXFqluuZYwXmuB9PbgOtQCQuFa8cKoWISGcZM+nawjaL+kRO6yjQq0bsod4d9abBfw==
X-Received: by 2002:a05:6870:860d:b0:2da:9db9:9ab4 with SMTP id
 586e51a60fabf-2f6471e573amr2245257fac.4.1751468543355; 
 Wed, 02 Jul 2025 08:02:23 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb0e338esm2533322a34.40.2025.07.02.08.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:02:23 -0700 (PDT)
Message-ID: <3d68b42e-0767-489a-b5b6-cd832244c1d4@linaro.org>
Date: Wed, 2 Jul 2025 09:02:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/68] hw/core/machine: Display CPU model name in 'info
 cpus' command
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-24-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> Display the CPU model in 'info cpus'. Example before:
> 
>   $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>   QEMU 10.0.0 monitor - type 'help' for more information
>   (qemu) info cpus
>   * CPU #0: thread_id=42924
>     CPU #1: thread_id=42924
>     CPU #2: thread_id=42924
>     CPU #3: thread_id=42924
>   (qemu) q
> 
> and after:
> 
>   $ qemu-system-aarch64 -M xlnx-versal-virt -S -monitor stdio
>   QEMU 10.0.50 monitor - type 'help' for more information
>   (qemu) info cpus
>   * CPU #0: thread_id=42916 (cortex-a72)
>     CPU #1: thread_id=42916 (cortex-a72)
>     CPU #2: thread_id=42916 (cortex-r5f)
>     CPU #3: thread_id=42916 (cortex-r5f)
>   (qemu)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   qapi/machine.json          | 3 +++
>   hw/core/machine-hmp-cmds.c | 3 ++-
>   hw/core/machine-qmp-cmds.c | 1 +
>   3 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

