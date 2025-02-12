Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC294C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 07:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti7D6-0006Bw-H7; Wed, 12 Feb 2025 02:31:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti7D5-0006Bf-7s
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:31:03 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ti7D3-0004lA-GV
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 02:31:03 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dcb7122c1so4230903f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 23:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739345457; x=1739950257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xrSYQA17WwJmTwyR13qaRl4L5SKdPSj3lBbMVdbba7U=;
 b=A5Vj+hFlgbZsoqqzT9d8GG6S7LqmjqHpJlJUd+skH3MgReIObZZIfANnlGzeW2ZyFy
 eMwkcXn5WjHQA6aeH/l6D1aUT715n51HXx3qB/TqO91HMny53/4CJvIpd76F+h/yB+9P
 cFiIl/LrVe9K2P4Kjv0IpzDdt6fziDmGuM5davFWjLyEAk90mXMpymtABz7KPA5qrGvW
 EH2xmx1fvvZNDyZeNEFNjantvkeCjkW6yOna07TgijkQ8G3tKQW6O3quiOWHa3JcsFCo
 lEJ9u+xWJ4sQL6X2BCa88Zm4GAIrV7MI+FNENqs4XPn8AIVZoxrqWYs8g0Wg44fJYu4q
 U1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739345457; x=1739950257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xrSYQA17WwJmTwyR13qaRl4L5SKdPSj3lBbMVdbba7U=;
 b=JTPLM81Z0zJ8+DzfsbjL6lWAEHj1xSOHKkf/uvKXsTqpAxtKsfszf7GM0/L1APEzJZ
 10paHKHAXOY2HAZXF3P+Tn0a+OHGCEEuCNMX8kkT/rPVYuxZIR3Fw4XidVx4+om8k9oY
 21n0M82YSPNdzZgbNokSLkxbvOp1sB8nAlxg9XcMmnJ74itQWXhmTE6SxALXJn3ggT3a
 gQyni3Vo56WJ7vejqJBYxJDFjJDnbnTiMuJNjBc1UlKS2V/ArKXafLlEi1tZtus6KFJx
 hA/AAt8NnCzoWkle9Y4P2c+3L2CNj5ZeMk/43Kq05oEmqU1bSi5SLLTbaGCaoiKHT6Nk
 0+Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU+caToNp6G6D+5+aOq8FoGfX6t1USn6hSv+yrNcmFLg0qokCRQAB491+kjbNic8+E48FS9iw4Pd5y@nongnu.org
X-Gm-Message-State: AOJu0Yzo32G0QQNPgdi1rea98wN8dubHtOCPZx6kQt6R1sO2nH5oXisa
 KhU8TbjatjmW7AMSUoLjlFXMHY+lhT/mwrv+XQn+aEKH3sdV1ThkZRVBo6DT4zYBJOhwqEvf4kz
 Y6dU=
X-Gm-Gg: ASbGnctZFumVV6C9y/H6HBHrSVWdDTzoHrTcQmrrTf76YuCV/1ggeXbHsJJJs+CHH4e
 ayoa6vxFk49MmuXmuiRsPHL47F0+SRgaJnvpGl3tgPMVOyb+wN33+vTHybybLLLAa8IWbXC60DF
 xqrN+5QLCIut0K+LfaOCl1CkT0+Bs3vtK86b0O8Z3HaDRANQu2vCog+jg3MIJ0gT1Ky2RSdL0mK
 VKyFB+cs77iu85+/5CjQrPfQYitRv1kiGSqj5U1c6IjNA8hnHJ9ysBIxkTkKLcZrHv2HThbYH1W
 Fb5YsOsoDW2eGwrOeozb6PcHN8yqPVJyH1V20m0XmNVvkp0mQ9L7i8hLIPU=
X-Google-Smtp-Source: AGHT+IHYV4UzAQIkuU1dta10mxZyof/0ROAatmh+nOueRwl0q1PfdpEkYXj8ie2aLLgx6JUio48H1w==
X-Received: by 2002:a05:6000:1868:b0:38d:e0be:71a3 with SMTP id
 ffacd0b85a97d-38dea2fa9fdmr1303697f8f.54.1739345457325; 
 Tue, 11 Feb 2025 23:30:57 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43959d3ca9fsm11617735e9.0.2025.02.11.23.30.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 23:30:56 -0800 (PST)
Message-ID: <983623c4-404f-493f-a441-37dbe9409616@linaro.org>
Date: Wed, 12 Feb 2025 08:30:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] target/loongarch: fix vcpu reset command word issue
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Bibo Mao <Maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
References: <20250212015619.56244-1-lixianglai@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212015619.56244-1-lixianglai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 12/2/25 02:56, Xianglai Li wrote:
> When the KVM_REG_LOONGARCH_VCPU_RESET command word
> is sent to the kernel through the kvm_set_one_reg interface,
> the parameter source needs to be a legal address,
> otherwise the kernel will return an error and the command word
> will fail to be sent.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <Maobibo@loongson.cn>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Song Gao <gaosong@loongson.cn>
> Cc: Xianglai Li <lixianglai@loongson.cn>
> 
> CHANGE:
> V3<-V2:
>   Optimize log output when function calls fail and exit the process
> directly.
> 
> V2<-V1:
>    1.Sets the initial value of the variable and
>    adds a function return value judgment and prints a log
> 
>   target/loongarch/kvm/kvm.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index a3f55155b0..27df02fa3a 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -581,9 +581,16 @@ static int kvm_loongarch_get_lbt(CPUState *cs)
>   void kvm_arch_reset_vcpu(CPUState *cs)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> +    int ret = 0;
> +    uint64_t unused = 0;
>   
>       env->mp_state = KVM_MP_STATE_RUNNABLE;
> -    kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, 0);
> +    ret = kvm_set_one_reg(cs, KVM_REG_LOONGARCH_VCPU_RESET, &unused);
> +    if (ret) {
> +        error_report("Failed to set KVM_REG_LOONGARCH_VCPU_RESET: %s",
> +                     strerror(errno));
> +        exit(EXIT_FAILURE);
> +    }
>   }

Look good now, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


