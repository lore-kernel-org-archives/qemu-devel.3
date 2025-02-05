Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0DFC02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjdQ-0003BB-Ip; Wed, 05 Feb 2025 12:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfjdP-0003B2-Et
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:56:23 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfjdN-0004Gf-T5
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:56:23 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso440735e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738778179; x=1739382979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SezWguPGLH2gSBjLm56i4oC4VEJNlKhmOJ4S84wkkYU=;
 b=aT6twkw7NruSyr9RxNvAZlB6tLd2LhriIz0OYMTYd7kqYy6bJMrSO/rzsK2dRxr9xl
 jcq5OlCbaIfDBXocz87QiJQ84DgyV/HPAnIkEhCQI4nTwCjHvRs9P9rBu4PScol1RW3d
 FispVcyIXQjdzb5GiUx6KY1KjxF9ULeEU4fAFwLCjs1h7A6kPKANw4X2ywZ9Jocum1Qn
 uSYriQiJRFBspFVLqjhbGgl5m+FPWClQwGNLfEZMNXba4MavTPYGueTKGH/96p7/Xo0Q
 Rk+uzQ3XiAe8fSqS2d64FmF7v18IQ5td8TRHUsN/kH7H6sJ8ZyRt2R2EcmfbHnYVDGZH
 S+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738778179; x=1739382979;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SezWguPGLH2gSBjLm56i4oC4VEJNlKhmOJ4S84wkkYU=;
 b=jo9txw9TKzlm+PswgDT5Qad8HeGQNBCgpHauxdB+lEmcivarDxZKIj3A/FsQcl7Ai5
 LvQ1eVz4di6K7BKDjcoi4Bevp1vSirEQBsIFu3VeSsf9N/JN5XxyZag4UBQ5KhFFAvDb
 twHCjpSTPT/A0BQlQpfNlr6vmg95ijiUXEjR35MVObDcrt0CouRaEcvFIwl6O0nqvvJP
 3K/sVdviUWG9ceFa7eZzZT9CfnnMF9huuRfFhHD/V3ZiwOXm9uzuGYBKULKNAhxq2maN
 l1WmN1PQ86/xpqL4HHPiW/Dpjk87iYlLBynA7Dyw9qrRoPmkng+anl3m1e68Ltb8E+6s
 jQRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyrqZWg/da9SPN2FrU3cjwR+Yxy83M7ZLbRfnTmlpDPLnqcjU8Qkcg/mQDeQQWIM7JIWHAttOIy5Ct@nongnu.org
X-Gm-Message-State: AOJu0YwmioX11KoN7TKpXo5JmvXbnq0FJ0+CqSlL8XilAvgWn/lL2wQp
 11FQ/5RpG8E1zkgO+jTbT1+6gXzVv15/THpPy6/FozdwncrSR32DHFJn0Qv9mgo=
X-Gm-Gg: ASbGncthbKZ2/J91Gm3WMWcbDjh9b3ezEj7U8EaMiSbqeXFu/Cpn1EnS3E7ktEpmLDl
 HpuoNDQV8BtgsIdtM7Dfh3e/VMTHaegBUVlKLRLoqAg7htw9CT++eOC1DOe06wdhgf/+u/D3YHT
 QAVFiPDd61j4MMvQX0sed/uXvP2AdrYXyNHLh0NH3hzisgkgMDShJquG05u7l6pYMx+JHRIO/Ju
 dfyonLyXznVU9mWVcGrCdhrsAZKbPV1BwDBo884hu29VZ44pMWe93brm6UQcefd4JGm55a6UrFl
 vw2povI+q4EmGGApCrfcpKfiGwAC+A3mytJsUVlh1xzBr6M4kaxK+Tu/5Z0=
X-Google-Smtp-Source: AGHT+IHyaAmW6pOmMnweaAuPdmGLQ0Sgq+YR2iG7QeDWvK0YRYRhPfQGOIZZdtevGjJeARiBlSopbA==
X-Received: by 2002:a05:6000:1445:b0:38d:b1a5:3f51 with SMTP id
 ffacd0b85a97d-38db48c8baamr3052563f8f.22.1738778178870; 
 Wed, 05 Feb 2025 09:56:18 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b57ccsm19515318f8f.79.2025.02.05.09.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 09:56:18 -0800 (PST)
Message-ID: <2fe7fa85-6025-4a51-9ad6-03cbcb5f4131@linaro.org>
Date: Wed, 5 Feb 2025 18:56:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] meson: Disallow 64-bit on 32-bit Xen emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 thuth@redhat.com, "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
 <20250204215359.1238808-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250204215359.1238808-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 4/2/25 22:53, Richard Henderson wrote:
> Require a 64-bit host binary to spawn a 64-bit guest.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 5a40a2a629..0ca83135e2 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -304,9 +304,14 @@ else
>   endif
>   accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>   
> -if cpu in ['x86', 'x86_64']
> +if cpu == 'x86'
> +  xen_targets = ['i386-softmmu']
> +elif cpu == 'x86_64'
>     xen_targets = ['i386-softmmu', 'x86_64-softmmu']
> -elif cpu in ['arm', 'aarch64']
> +elif cpu == 'arm'
> +  # i386 emulator provides xenpv machine type for multiple architectures
> +  xen_targets = ['i386-softmmu']
> +elif cpu == 'aarch64'
>     # i386 emulator provides xenpv machine type for multiple architectures
>     xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
>   else

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


