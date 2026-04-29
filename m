Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F906FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9wn-0002Zv-NR; Wed, 29 Apr 2026 14:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9wl-0002ZI-RY
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:47:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wI9wj-0002rd-Dr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:47:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891f625344so1333415e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777488460; x=1778093260; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=22BwYy5fyUrUnbMMOyoWBwhH76+BD7nKY9w56wCGtX4=;
 b=eRcOvWZRDUkegyAw5dREMAbkAyx10EaPAzTO+I9cxs8jcri0tSPooNsc9KZIEuB+gs
 XjgeGETMhw9GzzB0cWZ1ELtXM42G7zr802S3xcZb1SgiTJZPkUEyAuuDqpEH/XoQ1Xss
 ILK113kSntLhe1E3R8UHU9mL3z5lXFDzkMNxG7uVpCYAHpHDRKX3Rf86xu+FWbyorZCg
 NzXE3fJfzkoBtByBMcWqI7ZJlBf0RERX9U02pt4m/LGIhzP5tD/Ff78ocKXFjRhHXy3q
 GIflqdzZliBG/xAIFBWH+GKV9dyHk8WVuDQHlDLaw4TM9iyTyb5MpzIOxBFy7NKa2Vcq
 cLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777488460; x=1778093260;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=22BwYy5fyUrUnbMMOyoWBwhH76+BD7nKY9w56wCGtX4=;
 b=bVtW8VTq/6hL/w4KPsAVZBDCxOeCxdDMZbAstBLyxA3z+IlGQiEa5BAbl503a07X02
 JpBeJS89j1m0F6i9L6Jcxek5ry1pdBDxZONVlRqLWsAF95IkWCYHh5Z+DixBUhgs1FRx
 iM359oMx3rSCxxvBcRGTi2Vyymc5XRVKyyqel1xj7qe1lroxkjOb4ePvaWuKq90u52Ed
 4akoQW4pvp+LXdzZzTPj0WpSUurURxr0OBc9ny3qGNwi3LOcF+Vug9rvSh3jLQGCuhEz
 FPoWQZDzQeLjATwh8vhUwGkJvQj6TOzIlCo1uHCd3fKJsajORV1TWsXjNkgG1H0q9qPk
 F4+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TzFsIKBYKII3fvs/lGEQqSgFYon7Nt22DH7ZtTiwTZzBtWRjKLf5/bo+E2ROivzAV5N6iV3lkNxmv@nongnu.org
X-Gm-Message-State: AOJu0YyNKHhL0fmPAKu+LLjOvzmbpTQMqgFvPVbbPJG/PINCHe0Vam0W
 Xp/37Q3AgIalRxUJ3HUKu9GsU4jfuTLeNmzVpvnoUQhYnNluYoC3IcDrb1x4g/bcx5Q=
X-Gm-Gg: AeBDiespESx+bXXzNr0qZxpu7nRHaNxHrop+sQwnmr1PFrDhGwFWszKLOMyJolwZWni
 t2tMINti09hrHuVVKGDIF2eCEpK8ICugzln+gvwql7XCZEH+RfwHqBN68aVtzOJwzM8WieeQ8cC
 Th+IoxbpEoJLAQXGuP30tzEdmp1YZFk249CM0DJvhuubWexx6ooQTU82+WxWwGJ4v7oQZc2jae3
 qirmEQiyZpxMmEpkTKucJumgYYhTE27zkr1WXdlHj/72EdtPAUMOeWxV+7BzYzrdf3ogjwOch4O
 nXabIl4DRmCZAJ7GEcRxydNQbye/adCB326kJzJ2qyxtW6LJuS0eT6FYnJK+GpwNLQpCD0I2L/U
 oHCfFX6wkf/3NuXCVxcO0nczLf25zQItH1Z7ztbdGk8DxLIifLaOSSjf4VckdEMXupEe0264b5t
 /6uc9j/bs5JkLe6ONi64l9at9eL5fN40t8tkBFeIy60WFks9wFanVrSjq46S9FS+VPHYHon5/m6
 RHuVpTxnxp65Cs=
X-Received: by 2002:a05:600c:34c4:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48a7bf99294mr59099855e9.6.1777488459697; 
 Wed, 29 Apr 2026 11:47:39 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b9493bsm8889355e9.0.2026.04.29.11.47.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 11:47:39 -0700 (PDT)
Message-ID: <59b2c362-7788-4e52-9582-e2905fb9c492@linaro.org>
Date: Wed, 29 Apr 2026 20:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 40/84] fpu: Return struct from bfloat16_unpack_canonical
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-41-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 108 +++++++++++++++++-------------------------------
>   1 file changed, 37 insertions(+), 71 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

