Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906FDC8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 07:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWriu-00060e-Qs; Wed, 02 Jul 2025 03:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrir-0005zt-H3
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:17:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWrim-0004Ba-3W
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 03:17:37 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so54212455e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 00:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751440648; x=1752045448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+mYTbfn+CDu82xWppkTWr4AlzQy3c+TrZHAZXnDBh+Q=;
 b=Z8MIyw19IRXiIhLaJN8em/vw1dP5vcVXXpGNZl6cUyKoqL3/TROqLdfxboOap3XtzD
 nlyS92J3omZXl3TB3SLJQbeeLGl6LSO3A6dV4tU2xnfpvTSLmEls3N7sChDP1pmu7IB9
 tpiu5f1e5ogFUA84KmoAGQr18cr8Vbrs60xVAhYNFc2hFki0pcpyQaXWPxfHaebczlbW
 0PB2DlvjFH8L2TA0wzIP1fc/PeXlbb7CB8It/VkwXAMfbibaWhczTXvD5VkLY/sWOy/S
 gOV3T0ocGLL1p6m/6HcUAfPm9kGDpK17XY/glEmFEdJ3febPRA257WWEgb4rNxZdXMaI
 gj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751440648; x=1752045448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+mYTbfn+CDu82xWppkTWr4AlzQy3c+TrZHAZXnDBh+Q=;
 b=JVutW2C6FmUOrprkohyvmO+zbemA6rKhysSjxEUSOA5AuWsKwNSHtgsse6l+UuQhqV
 iZ3KO4CsXaGdN28dlthmnvAza1AfL4ngvo+TABeRLBfXCrZsYAmOypzWTEMrga3ilemh
 2a4l1o8cQfePeEC5DbjZRIPkrTPzQJxehkRTtKn4uL+qisJwBldIdCM2li6nQDg0K0Pz
 Q+DqsSvDmHDnDxTcSWujdvJA9K8OuciauivzAfME77PsVJOs8a6ZqjfV6feXU1fblLRD
 p2a7hic7XNrRFHcKcs/qIpMhiuQHoy1h1XVc0jR+3MYhX2NUO+/a9pOhqmZKm+D5BkWC
 WDug==
X-Gm-Message-State: AOJu0Ywrr6r4b71AvNvjyj6ZFkB9sO+kS0BKUp75mTJmb59taA2RsIGA
 EERY4trBFkc+Jh5Jer3xMpmuta63BFFj8GoGxz0B3dDZWtStkQ1SfMgusi5KgJeicvRhf0+MP2n
 QDXGn
X-Gm-Gg: ASbGncuntuZocGaJejO2KM74V6wner4zwA3cVDpdDTPCh8mxfyflY8aZ3MfusslI7qi
 0dApLSEULA+V7JWO9av44oWKqjJbocucG6uo3GQUkZyTfFtUaM93SwLpgtN7dDOlMKPGKC9K+JL
 I8GjnIkxxf8fWmDvMPiWPB5OqhVMMBAjOzVQWJdX+KVDi1SA1eOV14iRL0W/3+UBovnehdbphyr
 oxe5D0sR5Iia/yJ29U0fev7Eb53dBeJ5n+eQnjEnuUWnXBQ9NMQ1SdJxH3AB82u+ipiZRhd7Mbq
 YLhqFz3J4k8wOCg1a9eduC559xEQX8+kFefemLoV+lJn9jwhWsvytXRhlrwdUMVAVDeyEPyf8W3
 lwcJDdCsEm3Nq0Fx8Ni/TWtph/2we9g==
X-Google-Smtp-Source: AGHT+IHzlLfxniq4XX72IM2MrdX4hE0Z9INHIuIGd41cfA7yt48Bx9dLsKjimCcK3PNVwCEbSlvG8w==
X-Received: by 2002:a05:600c:4f4d:b0:44b:eb56:1d45 with SMTP id
 5b1f17b1804b1-454a4ad0a59mr9264015e9.15.1751440648158; 
 Wed, 02 Jul 2025 00:17:28 -0700 (PDT)
Received: from [192.168.69.166] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390bf8sm192666895e9.4.2025.07.02.00.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 00:17:27 -0700 (PDT)
Message-ID: <d0b25f1f-2774-4494-94e5-a6a58f995657@linaro.org>
Date: Wed, 2 Jul 2025 09:17:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/68] accel: Remove unused MachineState argument of
 AccelClass::setup_post()
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-16-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250701144017.43487-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 1/7/25 16:39, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/accel.h | 2 +-
>   accel/accel-system.c | 2 +-
>   accel/xen/xen-all.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index f327a71282c..a6a95ff0bcd 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -45,7 +45,7 @@ typedef struct AccelClass {
>       void (*cpu_common_unrealize)(CPUState *cpu);
>   
>       /* system related hooks */
> -    void (*setup_post)(MachineState *ms, AccelState *accel);
> +    void (*setup_post)(AccelState *as);
>       bool (*has_memory)(AccelState *accel, AddressSpace *as,
>                          hwaddr start_addr, hwaddr size);
>   
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index 913b7155d77..af713cc9024 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -58,7 +58,7 @@ void accel_setup_post(MachineState *ms)
>       AccelState *accel = ms->accelerator;
>       AccelClass *acc = ACCEL_GET_CLASS(accel);
>       if (acc->setup_post) {
> -        acc->setup_post(ms, accel);
> +        acc->setup_post(accel);
>       }
>   }
>   
> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
> index 1117f52bef0..ba752bbe5de 100644
> --- a/accel/xen/xen-all.c
> +++ b/accel/xen/xen-all.c
> @@ -63,7 +63,7 @@ static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
>       xen_igd_gfx_pt_set(value, errp);
>   }
>   
> -static void xen_setup_post(MachineState *ms, AccelState *accel)
> +static void xen_setup_post(AccelState *as)
>   {

This method only accesses xen_domid/xen_domid_restrict, which are both
related to the 'accelerator', not the machine. Besides, xen_domid aims
to be in Xen AccelState and xen_domid_restrict a xen_domid_restrict
QOM property.

Regards,

Phil.

