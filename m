Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B34CD5BA6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 10:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm9nO-0007fS-U6; Thu, 05 Sep 2024 06:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sm9nK-0007aA-4a
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:32:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sm9nI-0008Jn-BK
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 06:32:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3780c8d689aso341513f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725532370; x=1726137170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F6EGgNhkf2SvpOkiCN+f8Mfsh5nGUdrGGf3OpXtqt2A=;
 b=cd3wy2E8eS+Qt8wPKOUEFIt9/V5O7LLPmL9szkA0kBSvRN+jtARIkJ37WQLHZhbyEU
 pvS8W5QN3Rdk2MwztUO/FlGqqk6DMi0bYPBHfyrgAByGO0Gj6bL4SHV+aH5y7NrnKcIv
 fnxCdxROiXuDK+SIyGuxZuIb5jI0IyJXwkOZu5lhC9vFjnM4uE1HgyQgKeJqJPxHBTmp
 MpnWz5KJ3i0SxprrNxzuoGqsM4SoRHXbn4a7MCt6VYRUicds6V4pYyFd13z6TuYna/uI
 lIZswzprfCJTD/PB7a4/jYW/8i/QYadUC8+uozie+gVYTojsriv+nZMuZTqBrz+ws3/H
 +/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725532370; x=1726137170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F6EGgNhkf2SvpOkiCN+f8Mfsh5nGUdrGGf3OpXtqt2A=;
 b=jXXiafOhVZHZfXzbihs8U8pVEnQWYuuLg69VA0lBTJD8rdwFfqDYWwFrmh1C1RsMZ8
 P4KocXlVfKf384QuFKRUdnhbFw65siHJnNGwNpneVtLWWoBl1LoIoRotZJYELNBTaWP8
 qCrj/l1XUg6BUzoWSeO87cjcIhg28Rnk37O2IkqVH6Gmr+aKWIsdXqpDmxKMv7rbyl2l
 d9ODG6Ro8/ANwXuZeMhb8Tgo7JpC0BcQLckoMpA5pBKBaQkpTGp7sBtuFIuWh4vygpJN
 fk6O1UjYlT40oq27IfyQ9IxoAdBrG4g5R82CXLh5kafJ4Wyu9RZebawe+Tn0hE9qZiTF
 Z74g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOdIGs+2+vo0gjOcnuEuTCv40OwcFn08HqDnbr8uDD1BuatNz1mYHL584APGyYBqHosfvRTSuVeiGs@nongnu.org
X-Gm-Message-State: AOJu0Yx7I1gv16iFUOuP17gwwJWe/9yGR67bPAwAb8DpfPULLqEJ9VVN
 iJEmvWNhnAXUgdgYR1Tx3Ch3PgS3J0gRgTLNYlx5QQvtYN2b26u4SsJRmihOMos=
X-Google-Smtp-Source: AGHT+IHuzamxZsbFiatvvrer5EG8JC34WiJYZFfdhQfEgfnRN7h1SavfSr0FrzfHewo/5WPCyax9bg==
X-Received: by 2002:adf:fa51:0:b0:374:c1a9:b97b with SMTP id
 ffacd0b85a97d-376dcc8b8e5mr4696895f8f.8.1725532369959; 
 Thu, 05 Sep 2024 03:32:49 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e33b41sm228930315e9.40.2024.09.05.03.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 03:32:49 -0700 (PDT)
Message-ID: <297a595b-bbfa-47f8-a958-04d0140579af@linaro.org>
Date: Thu, 5 Sep 2024 12:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/loongarch: Add a new cpu_type la664
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn
References: <20240729013939.1807982-1-gaosong@loongson.cn>
 <20240729013939.1807982-2-gaosong@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240729013939.1807982-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On 29/7/24 03:39, Song Gao wrote:
> Add a new LoongArch cpu type la664. The la664 has many new features,
> such as new atomic instructions, hardware page table walk, etc.
> We will implement them later.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 48 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 36 insertions(+), 12 deletions(-)


> +static void loongarch_la664_initfn(Object *obj)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    CPULoongArchState *env = &cpu->env;
> +    int i;
> +
> +    for (i = 0; i < 21; i++) {

In order to remove the '21' magic value, can we use:

       for (unsigned i = 0; i < ARRAY_SIZE(env->cpucfg); i++) {

> +        env->cpucfg[i] = 0x0;
> +    }
> +
> +    cpu->dtb_compatible = "loongarch,Loongson-3A6000";
> +    env->cpucfg[0] = 0x14d000; /* PRID */
> +
> +    loongarch_common_initfn(env, obj);
> +}
> +
> +static void loongarch_la464_initfn(Object *obj)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +    CPULoongArchState *env = &cpu->env;
> +    int i;
> +
> +    for (i = 0; i < 21; i++) {

Ditto.

> +        env->cpucfg[i] = 0x0;
> +    }
> +
> +    cpu->dtb_compatible = "loongarch,Loongson-3A5000";
> +    env->cpucfg[0] = 0x14c010;  /* PRID */
> +
> +    loongarch_common_initfn(env, obj);
> +}


