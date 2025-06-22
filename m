Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6B8C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9Vr-00040a-AB; Sat, 21 Jun 2025 21:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9Vn-0003zz-Ou
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:28:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9Vm-0008Mm-9o
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:28:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-749068b9b63so1409548b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750555725; x=1751160525; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/3bf1fxGvYCZB7E8RRQo9DMD1azAsIDcjPnJWEy5Yhw=;
 b=B3lQ7ApArL4/LEFj1uj0dEttjxTac7R38r/l7fYJnmwdhFPfC6Gz/+Px1Vsy8m8inG
 sNpXnlVHDzQdlfBugGiVsXa493Hj3X+vQ8j4fRng16mSdRnmyV1QcEZaW4KnIaTuUcN4
 cMcJRRxdjtquGCPT7iqnfpbCU7XMJe78AEOTA+bV+k+vA8ypkVOhXGYwha/36hgFOjGz
 QQ97r/Hw8IF/gaGHm1/H/7qW8r9dbyZhRjehClLCjRu04HK0MNhGIxdT0V9xq+DhXEMj
 zorhy2GiOOarEg31xSM3Enk/Dcnd0/UZy3gq8rF58RViut0oMMhccp4grtnY91nbUZEk
 OyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750555725; x=1751160525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3bf1fxGvYCZB7E8RRQo9DMD1azAsIDcjPnJWEy5Yhw=;
 b=HlGpFLKUcLr+hGfqDgU0ecOCZzbBUB2A9VljDaNXqju79ZyfC/Z+4RNCcMFje+hmFV
 gJHUleLGRVgewvIMNNjnKUsfw1uA/nbfEjXlULsa7K77a6NUAM6ZqIHw9F/YAFHPzY6I
 7l2GwT8r1tmDT4RhWGA7ExKsnK4AG1u3ir/xL6IwwhyQmQSO6tk/2MPb/NJufb+WbNvq
 oKVk0kHu5hS1SUmMi1kF3hklrFC7W4l7n3DW4xHreNmjwZtPv/8lsJrHs/wnXrgoQzq7
 3TN4I/UTC/gwcSAa9Rg6j1yziExQIHSd8q8vJC7ZUxo9t7BzJIM3i0MbkhjGtW8ScXOE
 Je6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWs6Qxc8P8jFLADwmPTbNP4UL15Uz6sZUEhtTw1/2K7ziTW7XKyaDNjDUBYmxejpGC7wHLJYYVudBZ4@nongnu.org
X-Gm-Message-State: AOJu0YwbkJGA5o5RgV5pA5e2HaDFjM3SfMUrtWkG5jbiFf1ay0LEsu6n
 Vd010BtFaywykFuGm2mwxyBKmlDMoezzQrNQGN9dcsObvRHAFInLvhhhK5eNjq/WtZpLY5vg0QB
 Ob4K4l3I=
X-Gm-Gg: ASbGncswWPS0Xp59ov/oUd+FFWqhRTG00MC5MmUAzXueRort0pIvqoMREQRM0lW9BVE
 6Qayb1yyT/gfLeZJDMASSb21tX5YCvF9xY7SyW9QWdl8DXwsLtzyz5jml6K0hxtRuxuFiHPL7O8
 Hdm71teeZomWaKTD0u82ZdW77Fj9mW4mre6MzxgRNH7SqUPeFqtRGfcEliyKHVyYfc3+3YpCC+K
 ugtNJmPh3gQcNwJ8exV1gLIus/1Vki77dqSzPkNNi4cn17J3BIhpnYRShnbYFVsX+JFLG1kq70v
 EZIf8yKhWRSVDCQwQi4kORdgXI8Maf6fb8CqbOkxmxjolLtClCiN9UV+uKGs81QxII5Hiq9Hugq
 Vg3QLmgk2DdYPYqaAXO+aI5V9S/D7
X-Google-Smtp-Source: AGHT+IGxx8icI9nVURG4QpXw23Gw4hE/70NewlPX+EYQ6akNbqesg1PYfQilDP44U3LoQhyEQpjk1A==
X-Received: by 2002:a05:6a00:2d9d:b0:748:ff39:a0f7 with SMTP id
 d2e1a72fcca58-7490d5d0a0cmr11241850b3a.9.1750555724824; 
 Sat, 21 Jun 2025 18:28:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a623e8csm5064155b3a.83.2025.06.21.18.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:28:44 -0700 (PDT)
Message-ID: <b3741a6a-7751-413f-b6dc-ed0aa9627e67@linaro.org>
Date: Sat, 21 Jun 2025 18:28:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 17/48] accel/tcg: Implement get_[vcpu]_stats()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-18-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-all.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 28206ca5e76..f5920b5796e 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -239,11 +239,17 @@ static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
>       }
>   }
>   
> +static void tcg_get_stats(AccelState *as, GString *buf)
> +{
> +    tcg_dump_flush_info(buf);
> +}
> +
>   static void tcg_accel_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "tcg";
>       ac->init_machine = tcg_init_machine;
> +    ac->get_stats = tcg_get_stats;
>       ac->allowed = &tcg_allowed;
>       ac->supports_guest_debug = tcg_supports_guest_debug;
>       ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

