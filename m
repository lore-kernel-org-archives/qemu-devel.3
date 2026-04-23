Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA4FFDEE4D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG2aJ-0000I1-AF; Thu, 23 Apr 2026 18:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2aD-0000FX-EE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:31:41 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG2a9-0003bV-1d
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:31:38 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so4576665a91.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 15:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776983491; x=1777588291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1o4FaqTB+7I8DZJNbE1PGjJjNsRMBM5Fc9kr2Z5+AXI=;
 b=D8eQ/U4AVYwf0Pz/rfCWE0vW45eIBvYlNH2HtM5lSkWhYQm/3o64dJ7ieJMb5B1iuv
 VqBnB4HLPooCytbX8yetlRGbbrsJqzB3VAunPcSfYeN6y+b5rPBPKT6OOtgolrrB7Su9
 m2ZzqgPIxBAn6wMZmfOBt2GPO3MU7eSQndoKesNZkqv42uh/E8L/MEr8/pC6oEZMIkwP
 sNQNvAqKcYaHBWN4a2W9cSLuT/+c7tR0EcofQKSh6rsdOdr/HxmjdvkWjWIf6jfPMFxr
 B9U6/jW096hySUbwdDQI28D/A02tZL1yPr6KZuwEaDnNdX4ywAmsJu2rWfBGGi5PHmlq
 lc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776983491; x=1777588291;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1o4FaqTB+7I8DZJNbE1PGjJjNsRMBM5Fc9kr2Z5+AXI=;
 b=j6JElT1OqY4gt7dJV3lH3ONjoYW7m72tQipapiu7yq0YgtIJ8uwmdrb4UEc9RB94mH
 f7dfLrk44lrhZ0N6WXg9dpWm8VGHA89e89ZwF/xYpmrZlo6MXSQqyW3d6Cmr0gbwbPz4
 g8L7pWURWFxzOkFx//39CluTsXNs1pkAij0F3LeSZmxTv7YF/aMR0rj5VuBtEWIagGAS
 nmATFrkZS696R4wCQ27QXd/wu+G6j7hYwHG2EQXNY2Y82OpxD3nZ0gK0kNP6hVYEvKbG
 OJFQUvHf58wVHaPoTd9ZvUgNufMSI070O0DqhcHxO6OrY4bLUFRBU9x2B62oUSsblPa/
 X6RQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8kAwFUAEjiE0ByHPKynpUazgI4u0vUO6jPQxEdy6+CNdLVxONkNgClgdo8fBMoChYDNXyug9wQh2er@nongnu.org
X-Gm-Message-State: AOJu0YyKixUPlYuzLyqZN4BSEE8sU8ku+1QUPCCZJvhbfF3+4HRUwCu1
 R0i1Sh3mfcfOa4glKcVvf4MDQGy1W9k0x7VBlfHcrUgel/2qKo5Sr29ArQnUtkpMHFg=
X-Gm-Gg: AeBDietCXmBHMfkvXYyCAqEr4venshD7Sf6Ps/U967dcHy708VzG7OYNte4ZkMfWnze
 OGhJedbyrUBwKig0/n+twu0dH+mK3w8HmWqA4M5MNnlEmFP56Zb4pm5YdUP74NuJLdR5Ba0CrDZ
 AFJsJ899iFBZ3zq/D0fkouUF2Yl2BNn2E84DjD4PiHetaIUwZndeSj/1sdnZplfbI0LI0ZSMICe
 IRoXL1pDdtE7bg1DEJMwrNs+5BvKSgU7RJyqofYQSdpNniK4+yu6+LHH3+EhNOP/2HWE5BrK5oz
 /tKBgXfVXjCJWUyI8s1z8itxMcG0vnoudaqiKs3R8FShIParbe6nZKgRMvKGdZBitv3ycx3j3Sv
 XTZFkm9KvOSm/ijWcGlIGIJWgJb0Lze/T1pwfIqAsvsjkO+cRexCU3bFBMphMOYZfaaRLSAlYwu
 AjMppBXCy3P8hxoIpLf0PsVfn5rSWhziHqwhrmOjsXGagkVI6VkA==
X-Received: by 2002:a17:90b:3d01:b0:35a:cf:64a6 with SMTP id
 98e67ed59e1d1-361404af0a4mr31518063a91.23.1776983491390; 
 Thu, 23 Apr 2026 15:31:31 -0700 (PDT)
Received: from [192.168.1.134] ([110.239.0.232])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976fa40b2sm15278886a12.13.2026.04.23.15.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Apr 2026 15:31:30 -0700 (PDT)
Message-ID: <866760dc-1b4b-4c22-a838-7e2ab033b68a@linaro.org>
Date: Fri, 24 Apr 2026 08:31:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] system/cpu: Reset vCPU %exception_index before
 resuming it
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Mads Ynddal
 <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>
References: <20260423170229.64655-1-philmd@linaro.org>
 <20260423170229.64655-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260423170229.64655-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 4/24/26 03:02, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/cpus.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/system/cpus.c b/system/cpus.c
> index bded87feb1c..b4c7f94332d 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -621,6 +621,7 @@ void cpu_pause(CPUState *cpu)
>   
>   void cpu_resume(CPUState *cpu)
>   {
> +    cpu->exception_index = -1;
>       cpu->stop = false;
>       cpu->stopped = false;
>       qemu_cpu_kick(cpu);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

