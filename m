Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DEDCD3430
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 13:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slTV1-0007Nd-Bo; Tue, 03 Sep 2024 09:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slTUy-0007MW-S7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:23:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slTUw-0003n5-UI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 09:23:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42bb72a5e0bso47019675e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725369785; x=1725974585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pg8rcKyfzksPWHkF9xfw83m8xnGdbzC5DTDw0vHAnr0=;
 b=m9nph2tnglo+pHeeTfmnXCUvs5JzM6IkJbC7p/9rHPgRV2trFUkqrTu/lUkLkNfwUe
 SUpfXCEOJwh4Fnxzn+aoYp2vwyYGcQPXlxR3uFg03t7A6EBJU9X4M7Rs90yku4dbEc9x
 pEDCM6pms5nUAYdLFGhGcdBHpZ4UMLy5Rjd+xJrEbLquFJHg8wXEwSJ99FcM9KB5KhTa
 rGzJqlgxQAvHWVqoKTaV00w54gOwWvGj2duZ5lNVBXnZYkOTWIuQ+/Sv8KZ/PIUp4xtG
 9FOok40oM8IuaXk1ijTvqSJXxoMPxlK77TMwGHiJ0f2o176yliB2RC0njIwkS0LTEuJT
 NCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725369785; x=1725974585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pg8rcKyfzksPWHkF9xfw83m8xnGdbzC5DTDw0vHAnr0=;
 b=NPmzYLfBjaqkx/+q0vxMCBDgh/+2eqoDIuF9n4bqgGVBWTiX08HenjZzCqKZHkY+Lb
 Z3ePYcdeIVRFMLg1MxRcPJXPufQF/PmMONZDMFouishW3yxjOD8JirqDrl+UdmzFx+Sz
 xHFGGlipweDEnJFcQ/qiqEhj6xVa5cVUQPv/zw4BcInYbjYHHZybxchjrbPU6AH/jOB4
 3i5ogNDnqp9MhrQbqzvkqZoDqz2WDgRn7d6ePe3NOjMuKFy34cqRPDLgHZ1SxAZDaRN1
 NJAUwqmpNeBhOu0aUP3Cm4363NnvxPigMv9h0cdDsay2bZ2QksIsvr9EwAstJqs7ZLxn
 tAsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZOy6N2c4fsbU24Y5Sw8i+vBwnlSmrES0GXA+VBn5uMplmbP+ylO+r4StFqN5zWSX1hjbpzwqmIoJ3@nongnu.org
X-Gm-Message-State: AOJu0Yy+/MIH71xU9wG6VmabG+3CgGAvcnnK/iSEN9rYP7BSDGkHapX0
 7MfcMrnZSLdas2XpRaKWOh/rRiXKILMCQJJ6exMtjb2c92ZFbSVJ0c49g/fQou8=
X-Google-Smtp-Source: AGHT+IGKQc+yXbpf89E6xzb+n6mkjAr3+CWmzkUeJLmz100cO4mg1zCQhCR/Z9aIq+CvBN9nDXJJMA==
X-Received: by 2002:a05:600c:1c18:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-42bb01bfd73mr116331575e9.19.1725369784951; 
 Tue, 03 Sep 2024 06:23:04 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42c88c624f7sm29604705e9.39.2024.09.03.06.23.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:23:04 -0700 (PDT)
Message-ID: <77b34e53-46bf-4bf2-b730-4ea0e7ce39a4@linaro.org>
Date: Tue, 3 Sep 2024 15:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm/i386: declare kvm_filter_msr() static
To: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org
References: <20240903065007.31522-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903065007.31522-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 3/9/24 08:50, Ani Sinha wrote:
> kvm_filer_msr() is only used from i386 kvm module. Make it static so that its
> easy for developers to understand that its not used anywhere else.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   target/i386/kvm/kvm.c      | 4 +++-
>   target/i386/kvm/kvm_i386.h | 3 ---
>   2 files changed, 3 insertions(+), 4 deletions(-)

> diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
> index 34fc60774b..26d7c57512 100644
> --- a/target/i386/kvm/kvm_i386.h
> +++ b/target/i386/kvm/kvm_i386.h
> @@ -74,9 +74,6 @@ typedef struct kvm_msr_handlers {
>       QEMUWRMSRHandler *wrmsr;
>   } KVMMSRHandlers;

Isn't it also valid for QEMURDMSRHandler,  QEMUWRMSRHandler and
KVMMSRHandlers definitions?

>   
> -bool kvm_filter_msr(KVMState *s, uint32_t msr, QEMURDMSRHandler *rdmsr,
> -                    QEMUWRMSRHandler *wrmsr);
> -
>   #endif /* CONFIG_KVM */



