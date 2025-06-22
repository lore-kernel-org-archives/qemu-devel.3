Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6593C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTB5G-0007Md-6z; Sat, 21 Jun 2025 23:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB5D-0007M5-Mn
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:09:27 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTB5C-0003Me-6c
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:09:27 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-313910f392dso2174794a91.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750561764; x=1751166564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1eq4oU86uJFvQB4nYaTaEVffGaCje6liHX1UijhBSYg=;
 b=aO4s+Y4C5m5EhC06L0DTZfyRsIwSWIWaxa81jWsXGXELoIfXQhUhSv5qmTDU5gvI3O
 F8nwZPK9xL0mSJbj0B9Sn9BxVNN5DEse9k1HvsaKtmOEB1iya3B4s7gw4kk9MvVcrMQW
 fZ6LdLRT76V8EUtwtrCH5sodrjEzEOVdp66FMMGRQeew159GhZ+46puQGZoNtKgSnOpc
 AS/tIvkWrQcSOjY1J+pCY10PBRmGVGU9tp36tRUwZVWZxDT1oVLO3FUA1Z29UmPIREzQ
 ZQKrfnIPjXwinyEkNKV33blfDlfv2nF2JpPbYX52DevMAVVTOE+g6GBWKmhg+UpFxVnb
 ZWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750561764; x=1751166564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1eq4oU86uJFvQB4nYaTaEVffGaCje6liHX1UijhBSYg=;
 b=bcwbzeK+Sa7Pwzuv6MCT30NmN3iMIHOiFQRmksnwd/4hVQHjCCCfPxtuhspsvNkY6u
 TMomUx+mF1PdDF8BZkdLo0fCafb3/RoVYzOObwNRJvK8RRCZarNQcE9G2VDWmJClUF5T
 wdCvC6OqdOy3MXy6NZrzpwQCsFhQSdihjMHwiIFLzdZf8LQ6fjfmpp9iZcWOKhxwQGap
 7TWzbor0i+E6II5PhNx0lWEallHWU6ERntGg52Fqeb94Zd0tqBeCgM86l9UxK7CmuLET
 t/HfuDhuZYxem4ucOuXos0YTIT3UiuZMYYUDQJX8N2gKD/06CfKlRmRMxhZ1rGZuNKk5
 faXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtsFDasjF2ZRX7bIYerMHlzhOKPlcHAI6irqe+yaFgy+Di8i4tdjCYFBLVGcIG4Uz7Tw/+OL+L3am2@nongnu.org
X-Gm-Message-State: AOJu0YyOfRld+7vgYiXtutfemj+ssDXiOMvVH164XpOHyDMA/eSkv16J
 twEACkM834+d2eQ9o8BVI6qJD9dis5XVslG98KXeYGpuycYDHY38tMnuEZZvYeZ1QXM=
X-Gm-Gg: ASbGncuPYUgAeJOall+qqgszEBIClmeHFjXM3DekZJ+sjMXy+ZbrIa9sTyttNkj0YOh
 Z1clHfeBxtWXOj9Fd5KbiGc0rWVgZxQtEj0I/tfIo0hbKoTjs1eG5FdGSNT6ZbY3ST+Zg42pckp
 fRIhbhUKXaob/0hECvD7ohHUkmrKg2kLO1asKw8iBBOUWeEaQsDV/T0pwdhvfpKUOik98EZksEV
 AOY+NszlzUQN0VEh8JAkeRYs+PzLq4U/+AjdKXSiUJ8mI1QMXNKXxiYRfndNFkIPP9W/+3I+Mf9
 eybH7qdu+dLbawFeySqzrG8aapxLcJNbBw9eYW9tKSKqSTbZDx8OUBmURS/jeyzjNukGBeB2GvG
 va2wPzbAmzVvVdiGnR+eoNxjjqNj0
X-Google-Smtp-Source: AGHT+IERzwY00pNzuh8OCy4iRda1whzcs8ZK01NKSMZL5nZhGeOs4hyPjEhxyKgmR+YJfbSF40m4NA==
X-Received: by 2002:a17:90a:f94f:b0:312:e9d:4002 with SMTP id
 98e67ed59e1d1-3159d8dab59mr13543333a91.28.1750561763844; 
 Sat, 21 Jun 2025 20:09:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a226f64sm7525590a91.4.2025.06.21.20.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:09:23 -0700 (PDT)
Message-ID: <f8a3262a-3e8c-4d7e-9471-5d4b83aa8e80@linaro.org>
Date: Sat, 21 Jun 2025 20:09:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 25/42] accel/split: Empty ops_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-26-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 5a36e22f205..375821f1064 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -124,11 +124,6 @@ static void *split_cpu_thread_routine(void *arg)
>       return NULL;
>   }
>   
> -static void split_ops_init(AccelClass *ac)
> -{
> -    g_assert_not_reached();
> -}
> -
>   static bool split_cpu_common_realize(CPUState *cpu, Error **errp)
>   {
>       AccelState *as = current_accel();
> @@ -306,7 +301,6 @@ static void split_accel_ops_class_init(ObjectClass *oc, const void *data)
>   {
>       AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>   
> -    ops->ops_init = split_ops_init;
>       ops->cpu_common_realize = split_cpu_common_realize;
>       ops->cpu_common_unrealize = split_cpu_common_unrealize;
>       ops->cpu_reset_hold = split_cpu_reset_hold;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

