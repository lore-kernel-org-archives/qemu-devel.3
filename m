Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6347C36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16A0-0000l7-HY; Sat, 05 Apr 2025 12:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u169u-0000hZ-Df
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u169s-0005Gq-KN
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:14:13 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so2367104b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869651; x=1744474451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WUvLIuT68NO5JZeX3ooW0QFo16CIijJ53LzeeHsOfaI=;
 b=bw+s/m05k0T/EEtqGJEbcjHMmKii+t5uc1hs6BemfliRFrkHmxpDDXwiIbPRV/qL6R
 sRfwjS7gCFfyogfl7zcHITMgT+WJHQE/WARnLz5kh5gXyJLP81rQqreeKAouZhv9WZY1
 x//lS0oYH09Yg4HPmpjdTxGcGD1v2QyZtiTPNcfDIpCUDYHq0cHS4gFT+9Cdw/Zjg2xG
 74iyMbatwbcsV8jzuRKrVr/oQHSuXfEBJ6F1gNPnFZUcWGdHqDjx3AWNe5F7ym/KDv1G
 3ClFAIrgRmXhlnL+bpl50Yx9lGGzRxAVm8WnAOb2r2YcVLtuPAVv2YW93DnXtfOux84Z
 wTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869651; x=1744474451;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WUvLIuT68NO5JZeX3ooW0QFo16CIijJ53LzeeHsOfaI=;
 b=tfNBb+3f8a5qNUOKwo2F3eMqBKxlRjTa19jwVKLb34tEWVGaytNCm+r5NoL6K2DbWb
 HskAjE/bdUZWJvsHTZrIXC7G+i+Uka/Okq3pnD8Yk/FO2NwQL7BZIE4H1xT/9zsu+xgu
 Rnsx196qTbQeOlIwAeta6Xaqzz8Gu9uroAuvyPLnH/XEAXT6vaZ6Q8u5nbUTr00ytWmW
 k5mAzXprhoxrx1CAa734roZZOsMNqrHDwIQal0PXMFZee9QznKvJ5AWw9q2OK8Zk8CQZ
 CP20nmRfhPp2MD44FmZQhAxxrlGwWxGqCYC2FpgK7IDYr6fpvlxWqVXVJxs1GXYZAYDC
 y9Aw==
X-Gm-Message-State: AOJu0YwS7J6ebfCxKyT8z1BRgyeYhiioYeOJAO8iioCnOu6Hxrq8hOQE
 BrYqo5hbAsxE5mtoYGm1dBRg8espf1dNpt9LsnMN2Hr32+9ikVlDSmtD4ivJ4oeYeBfG+lzHUki
 D
X-Gm-Gg: ASbGncuDEqMyxzkFOLtXxFJ5L0koHd+ps6wZqPZqp+uSRIvYaf85tvAvTWcbJJjwQmF
 FlMewDF/Tg1R8yONgjrDDyG0PAa1um6xq+IKaUbUcSxzLtAQ3LKbXPxJPoQIVw/GoFNRaQiK4oQ
 AeG9OBmyJ4Bh2DOfehLBQAgmugaCOb16ixOyDNwu5eWZ0UkPlaEV3Yu1w/KhTOGRpK9MGhGuz/Y
 wyE/99bqL1OYTGklSpptFqTNDB2RW8Rk47Quobh3ON7CR9Cw1nqDGBrECWlB4KYLxoTzEVmy5kd
 kZ+2w66XwWpmsHkKNs7E64a/nxhP5kolsegGj/sBPI61xQ7F3mOQea0tC2yGskUl
X-Google-Smtp-Source: AGHT+IGn3KtX1V4nKSTIjFV8DmzpuCo8/1ACJT/vvmU6drjS7+iF4HGOJFh1h8xzXBOh3Zk6CWdqiw==
X-Received: by 2002:a05:6a21:9201:b0:1f3:36f7:c0d2 with SMTP id
 adf61e73a8af0-20104769bb7mr11258401637.41.1743869651286; 
 Sat, 05 Apr 2025 09:14:11 -0700 (PDT)
Received: from [192.168.122.15] ([173.164.107.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97d1b87sm5605096b3a.16.2025.04.05.09.14.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:14:10 -0700 (PDT)
Message-ID: <71f65b7b-0850-4ffe-8efe-1aa15e75ab9e@linaro.org>
Date: Sat, 5 Apr 2025 09:14:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 3/9] target/arm: Remove use of TARGET_AARCH64 in
 arm_cpu_initfn()
To: qemu-devel@nongnu.org
References: <20250404223521.38781-1-philmd@linaro.org>
 <20250404223521.38781-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250404223521.38781-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/4/25 15:35, Philippe Mathieu-Daudé wrote:
>   static void arm_cpu_initfn(Object *obj)
>   {
>       ARMCPU *cpu = ARM_CPU(obj);
> @@ -1482,16 +1489,16 @@ static void arm_cpu_initfn(Object *obj)
>       QLIST_INIT(&cpu->el_change_hooks);
>   
>   #ifdef CONFIG_USER_ONLY
> -# ifdef TARGET_AARCH64
> -    /*
> -     * The linux kernel defaults to 512-bit for SVE, and 256-bit for SME.
> -     * These values were chosen to fit within the default signal frame.
> -     * See documentation for /proc/sys/abi/{sve,sme}_default_vector_length,
> -     * and our corresponding cpu property.
> -     */
> -    cpu->sve_default_vq = 4;
> -    cpu->sme_default_vq = 2;
> -# endif
> +    if (arm_cpu_is_64bit(cpu)) {

     arm_feature(&cpu->env, ARM_FEATURE_AARCH64)

is a better test, but env->features is initialized by the child instance_init.
We could move this to arm_cpu_post_init, so that features is initialized.

Alternately, we could just make this unconditional, since these fields are always present 
but only read from aarch64 code.


r~

