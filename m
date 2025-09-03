Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627CACA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 12:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utme8-0008OP-2D; Wed, 03 Sep 2025 08:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmdR-0007jI-K2
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:30:49 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1utmdK-00027f-Cm
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 08:30:42 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b02c719a117so520299866b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756902635; x=1757507435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h2mo8VOF4ouaA+/wqy9v95o2lrqnfyb8NhcCck/feyk=;
 b=tJhMhrcmePl81DiuxjYjD7NJnYZbXcaWGsxIXP26SoTMI1C+kpTFR9aygp6PtSOaAi
 FIo5AWa7WML+xSPq92X8GMiy7J3oFtX4LKefxHjUjpDbZJiz8a2rDwgiG5k3uBSFmfvv
 hBNDzk/0Yt9awmLcUTv3rar4dm6SoZ+by6jaeb1q1TtD5+Uz+xEYi29qRwNKqBSeoc3F
 /u1FsLH1RAOz1+hET2IZNs/ahPmMOrRCTyZ5ih0pE/0lhWtLRQBB899D7YgyxFSTrVr/
 aZ3XUi5bN3b4AYfhQj+YCaTbaDNSZSLtQdeUwb4zBW1f4B021B6AovaiVi5VePFCGvUh
 LtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756902635; x=1757507435;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h2mo8VOF4ouaA+/wqy9v95o2lrqnfyb8NhcCck/feyk=;
 b=b7Oyb6Ya/Vr6da7ZXLABH3LcbgjwwbTVHqUPG6eFyDAlf+0ZArqNAgU+o8+pj1/2ZU
 bDhzUXC/H2O1sUZ/EeSkT9QSCLQQNKWG+xggdmoBK2BaqlO/qA+CWLppS121B89zACPT
 pUUBkN+HhhCfAg6ZEp7T4yt7RkWf13tIYHefraVLKNZX2UpbkIoANNeGF4paN9gGJs14
 dYFIUcOKRnxZpUDdyMn+QZbtzMfLgXCZGrUA+3UvyqvqtFbx5HTTCWkxWwRD/UrFN3Id
 Cnbay9lUblITmKXlAoxB3VaZEtTAflj/cj4xsbevaKStrBCxf1Xb5hU2g8NC+fjPsTG5
 Q1QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkLaCHFl5uuhvDGGrtWciU/m1EZfQLiWIOtAcRmmqbg2qAlzORTPm7SzPqK1Ezys889fGpAFmwSmeV@nongnu.org
X-Gm-Message-State: AOJu0Yz72HaPONlC8hy+Hu9XxVauPs1v6fndJT4z43CV9ZqCXdOT5u2d
 x9U5e5GnIfTog2qr0zVyXNh08Am26AgRy6F6eggx0P3gvyfdWXSZfICYXm3jagO+8W8=
X-Gm-Gg: ASbGncvoye1V6CCqN+vKYvVkAtYn1sqGJnohtVEA4u+z6HzzsXv1IXZLEC/73Ktaagm
 DzFmvIw73WDzVyxcK+55Su3tpL5HpriUpeb6SWlKoBtoVj+7FwE06NNifsB/IfTIOELI1rJpwmh
 v7GuX1BjFtHwJSQtEuhm22MLvlCxGzYV0wpGdc3TH4vzHXWd/sufkrRu1OQe52JRCDmyzmimFBL
 hy8QGBLF6aeGNQyoaoXSmsDpBYn8lQa6pvo92Pj55N1dTnuIkw3W1OrpQU7NuiOdPhDh2uj3w07
 mpj9HvOXUHi0uSPLkk6lmllT3TnMDFjGTN4iyGcmNH5nX4KYIIX8UKMAn9d0icl6//GsDDAz+/q
 pvEMwfaUhDEr6MKV1NXkNQCkgDNBe8dVg0fz3jUC23mtB0dNqz7D1TUOVlIoLYo6S/BrTIzv4oK
 05wYS2FQ==
X-Google-Smtp-Source: AGHT+IEtQL9cQQzPZZadlegPWyVe21Br3vzGGtsi5gkwO83hd0lzx8JcNJw3zMXBWKJa0o6z5nCCXQ==
X-Received: by 2002:a17:907:1b22:b0:aff:16eb:8b09 with SMTP id
 a640c23a62f3a-b01d8a2639dmr1318213566b.5.1756902634943; 
 Wed, 03 Sep 2025 05:30:34 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b040d44c9adsm993141866b.9.2025.09.03.05.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 05:30:34 -0700 (PDT)
Message-ID: <98dcc142-6394-4167-b93b-c9476c210696@linaro.org>
Date: Wed, 3 Sep 2025 14:30:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] target/arm/hvf: Check hv_vcpu_set_vtimer_mask()
 returned value
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250903100702.16726-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
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

On 9/3/25 12:06, Philippe Mathieu-Daudé wrote:
> hv_vcpu_set_vtimer_mask() returns a hv_return_t enum type
> (defined in <Hypervisor/hv_error.h>). Assert we succeeded,
> as we are not ready to handle any error path.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 65ac0bd71aa..1b59cc0eb04 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1906,7 +1906,8 @@ static void hvf_sync_vtimer(CPUState *cpu)
>   
>       if (!irq_state) {
>           /* Timer no longer asserting, we can unmask it */
> -        hv_vcpu_set_vtimer_mask(cpu->accel->fd, false);
> +        r = hv_vcpu_set_vtimer_mask(cpu->accel->fd, false);
> +        assert_hvf_ok(r);
>           cpu->accel->vtimer_masked = false;
>       }
>   }

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

