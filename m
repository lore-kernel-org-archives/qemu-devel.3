Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F806C5B543
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNtdc-0006Wz-Rd; Sat, 07 Jun 2025 09:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtda-0006VE-NE
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:31:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtdX-0003UW-56
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:31:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so24154855e9.3
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 06:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749303061; x=1749907861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ss1rXeZCw6J+Rnk2lopvESKmSnR9SivStQKM5kOCypE=;
 b=NleiDfqUjgG/Rwpazf3E8BKdRz1GK90RWUFcoJZhZtQ0D4/irw7mi2wyhsUxJbN+Pw
 LJI1m2HR7oo1QbBPr7056gLVDHU/WWuR/q4/V31hB6bgpBdHsJ/QFIXDbQE4AU6xdJpH
 giBeTD0SzRhLvP4lZi8rLSB5w712LNtukUOSM/shNKPzWusRbrGSazQlOJZm1jPAV41u
 cjrzuypdc6rNL3VTGMgO5Bl4I0t933NNsMZoToxv/0fu5OJor3FZizsXrPSMt9r8LuEL
 r5Et5HXPJrNkHZjsYsN/Oke3r8S/WzbZ5iFbmq6sS8cEUOknWBnnLc3UFd5w8JRPe8pG
 3Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749303061; x=1749907861;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ss1rXeZCw6J+Rnk2lopvESKmSnR9SivStQKM5kOCypE=;
 b=P1Kg3m1wkLfyoz5ktcWQl4mIOTtiP0ukDn/0bJCBu+vy0YPqevvTQSmutW+WMo9h1F
 Hv6WEO17pIWP29Yfq3XVqwUmUORHx8cn9lpgnqCThizCgOs2GAaAwNlEkTqQ456jRMnA
 F8bhzrmZxFY1NtN7o78tdfCqS+Td8cEYcGh1ju4PXhkCBrndLktRO9qTHWdIYK6c4fNp
 cPtD1NRMUnk22TieHKUULWuTTyXQaXn+HGjZx4j/ixf5aY+5EBI7ns878KEx4Ko3fGkk
 dMx2D832/unAVOayTZNlzN1LKJRhtYvWJnt7knYYxaN5kiL5sdpBi1ixsLZXPz4zePLJ
 Myxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0h6d/NZZNnNhKjuI2TISRJoCqoYcFd3LGLozrq7ftMUpX8kHsWnpbAcJ/e2IvMf10Da/UdUEhROkq@nongnu.org
X-Gm-Message-State: AOJu0YyVGgHlvo91sagCLNSdvbQBHeM3MbmeKSuiHkQ2hVuR8dGfVuEz
 O6PhH9bBVRSW+fC+E6A48Q9Rr/dBROfns00QmohyGcvx3RPCrdQ4Hao239ohmozu/z4=
X-Gm-Gg: ASbGncsaEfTUfDxrwbQz8eaktl5rXn5L0YgpsBON9KYE7+6eDN1fJrrNWb85DVEGBGi
 pDnj1mDQkZ7f/XtW1Hcn8e06DzZ/JfC+Hh0KfjhNR7a25dso30R9Xm80mlMxiawei0hn3Wf458f
 +qYikMtCstixPjU7AOEFYx/DmtNozavyF2TXFOk6Fq4BgWx24Sxq8arsSWmGZpVgkgMKMF5bXlZ
 f8CS7x8AIzvz7hBOUS8ZWPIeYts4DHDy/106KB3qorVhjuZb7RF7KH5iD2hQJrbdxbeq1pKr3me
 CZavrJ4H0Kx34bfBbRn6qoigNs7FJ1a1GPrZWNWlcuAyloy3rxtOQrM9FCBIJOHgLxuSjhWrxyI
 SPMuPKaqcQdkmPLAYLqjcfvkk0b+u+VdW09UsfRhwhsw0lLPFv7v9gM/xYicD
X-Google-Smtp-Source: AGHT+IEKULc7MocvsSnH+tSuxIgjCs4zYKgHPFoOCB1KJZQ7Cvlbx6FEFF8tV4ZsmEG5S/WJIWH4Mg==
X-Received: by 2002:a05:600c:8b70:b0:442:d9f2:c6ef with SMTP id
 5b1f17b1804b1-452013fd8ddmr74127065e9.2.1749303061458; 
 Sat, 07 Jun 2025 06:31:01 -0700 (PDT)
Received: from [10.10.12.33] (cust-west-lon-46-193-226-34.cust.wifirst.net.
 [46.193.226.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452ec06d9aesm50822385e9.15.2025.06.07.06.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 06:31:00 -0700 (PDT)
Message-ID: <e536ce2b-6695-4e1f-9389-597d007f6c62@linaro.org>
Date: Sat, 7 Jun 2025 14:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/19] accel/kvm: Prefer local AccelState over global
 MachineState::accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250606164418.98655-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/kvm/kvm-all.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 5b28b15ccec..551a462926d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2582,15 +2582,13 @@ static int kvm_init(MachineState *ms, AccelState *as)
>           { /* end of list */ }
>       }, *nc = num_cpus;
>       int soft_vcpus_limit, hard_vcpus_limit;
> -    KVMState *s;
> +    KVMState *s = KVM_STATE(as);
>       const KVMCapabilityInfo *missing_cap;
>       int ret;
>       int type;
>   
>       qemu_mutex_init(&kml_slots_lock);
>   
> -    s = KVM_STATE(ms->accelerator);
> -
>       /*
>        * On systems where the kernel can support different base page
>        * sizes, host page size may be different from TARGET_PAGE_SIZE,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

