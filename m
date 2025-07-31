Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBBFC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOgR-0003yN-Sj; Thu, 31 Jul 2025 04:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOgG-0003vI-W6
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:30:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOgE-0008Gi-N3
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:30:28 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so7001925e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753950624; x=1754555424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pd7UgNESfPtmW7raPCFpcrGuphL9U0VjTNjtnnNmoJE=;
 b=EaK54W9qgg0esVxyMaGAiVhC9X9W0d5RnkxvPuSRP2Xfh5RaPTg4ZSjhXbRk1Oisir
 bEKqWbNhaPnJP5E8K+AUK2DCGexfe9HcffK+Pmnq061Smkxnqic5wAUELUY2FgnueP4o
 5RCWUb6r8/poklWfo/ptM2PMrH5Mr6IeJEUvu2flSUN01ehjEFqR4gWQq6hpxKt9xCrm
 lrzCOA9wnufrARfd5uvSJsp7JUi8ezR2SmA90cZQC7mNVwUzUda5z2v60i8yvs3phuoN
 kndpEdSPOauoNkVIOcqYQDzoEbKJnMLvC3fD3LrTdG/oQ75RmNITn1ROGxq92XhPXuoP
 06Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753950624; x=1754555424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pd7UgNESfPtmW7raPCFpcrGuphL9U0VjTNjtnnNmoJE=;
 b=DEJUiBpYIogep/YjBwuTm1QcUubxz8t0Y6zTAyqnyV5HQA4hwxdIl5ZZwhTwiLG6Bi
 1WbYtcLiDsWgYSKrzZygQNKdLJULN9XxDIyToqxlh0LF/Vf/GIC00+xPwd/rn6MPogAQ
 9auZ1sGH0x34tsklU3JOCE9GZcJfKdxtckBFOgYkUrLqsepvk04l+SOBiQhvnw+nZ+u8
 l9bhy+/UWUsPXLjPVPZ0wZB5Z/Xaibh38+wYbpxQe8i38nA5YkaxuNwqAp32HON6h9hP
 IvFab0/Yp/leQ3qNshQJ6RRBNAbTY2hwtgVV6AF/aGzlBzjnQRV154j2iXdrGJ9Z/vy8
 Nw+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDJJoD/RFgq4yOnGB/2qHw/YcJBnOsiV6ahc1fyhEq7yfWafM3YibrXFDTpNioHZon1G+r+6UdDMD0@nongnu.org
X-Gm-Message-State: AOJu0Yy1syrk0zwuo/8Hvwc8UnCcQEaK29DKBaYN5G1WwWuJ2E1iK2H5
 yfSYPILpZ14bx8NwB0H5uOrS4Mxo44h6nEzTg98iueyK3CDH6ENhYGSTTgbGs3ehEJ4=
X-Gm-Gg: ASbGncuFuD7hXCWVKmHIJOyHwbOQjFYtImphlo0aeA/v4BNrEO7vJJAUHfKJY93LCUf
 9VuvEKaVqN342d+B00XLL+tVxK5W5HBZpK00Q1saZOgSoL7/bWevFbY4nzP5NW4PgSZ5uk3l7+1
 Ha8exsMMPVuL6vgUeiDfE+xkYOmUIRV+SEvuNPf+TTD6ImeY+q47+vhmCi/pYZZbGw6/An5u4aD
 Jc+Hp3SGn+I6U0VmCVNYuufbaTC0lSA8/eLuaqSMB800WiDAqR5+b+g/UIw+iqp9NbarFBmP27x
 pMPjYmQFaV9f2bEMsPH/y2LfxNcYVdJUI4i5qnbR6jsA+yy+Ikv3d/UweQ8p5keajGkN1S6VVoF
 G6etnHCEwBTmqiT8zZMM+WHqHovEGt63wompNwmkGNIFHvC9mkvQQ9O1f1mzpjBaXrOuVCGotCI
 Vi
X-Google-Smtp-Source: AGHT+IHlM9yk90IuF5pxI3aaSJsksDr9W0Xpobn3XaVeFo4Z/0bWrAb6uuJPbzsl8MB6ZTHLWROdoQ==
X-Received: by 2002:a05:600c:674a:b0:456:15a1:9ae0 with SMTP id
 5b1f17b1804b1-458a223b223mr11642805e9.13.1753950624454; 
 Thu, 31 Jul 2025 01:30:24 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c48105csm1574069f8f.64.2025.07.31.01.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 01:30:23 -0700 (PDT)
Message-ID: <ccee61c9-ee41-4183-a87b-2a9641d92dc0@linaro.org>
Date: Thu, 31 Jul 2025 10:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/9] whpx: common: use whpx_cpu_instance_init on x86 only
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <20250731052753.93255-4-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250731052753.93255-4-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Mohamed,

On 31/7/25 07:27, Mohamed Mediouni wrote:
> We aren't using it on arm64.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
> index 0b23deb7c4..43d0200afd 100644
> --- a/accel/whpx/whpx-common.c
> +++ b/accel/whpx/whpx-common.c
> @@ -486,9 +486,10 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
>   
>   static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
>   {
> +#ifdef __x86_64__
>       AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
> -
>       acc->cpu_instance_init = whpx_cpu_instance_init;
> +#endif
>   }

I'd rather keep whpx-*common* without any #ifdef'ry: add hooks
when architecture-specific code need to be handled, and add empty
arch stub when nothing to be done there (preferably with a comment
in the stub).

