Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA842E92714
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 15:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZWRH-00032H-5Y; Sat, 27 Dec 2025 10:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWQz-0002v0-F8
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:42:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZWQw-0004wT-9y
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 10:42:24 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so49486595e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766850141; x=1767454941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XFZtsx8EUcb/JCrQCtg6lvaPnTWDTtVoj6XfYpU8ZPQ=;
 b=jKfIkc96lcvoYMUAMnLp2C8CQ4i+g3/R3P54ZoCoTk/4YsuEIFpofqTrOnDpkQs5kl
 pSWN1MjMip9NgFuiMgGKZCwV4l5ocb5jNhaudaYCakLbr2yZ1q/e8XfIOw04LYF+r64z
 efnbIYOzuEgYdTcGjLeAXzYstkSeApfJh4slibeqtcZuRLsIIGoxOULAACKEEXS76sAO
 9ajfZFzVtvwa+r5fb3YMTiyOygY6A3ImETvrjrULrhi2UcTRLGGPnaFRSmY67+ThFipg
 CeEArjUCk1eJOs9OGGLcvFiEO0cWAMh2IZE91qqmqLRDoDKu3Y0zE+fS8M7UI0dExk0Q
 jKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766850141; x=1767454941;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XFZtsx8EUcb/JCrQCtg6lvaPnTWDTtVoj6XfYpU8ZPQ=;
 b=KLStgnlMG0CKtJMSnI29oSc7X/6et1Kma3vcx9oxFfVD0lSz7m8f1l0jbQxtdx/SBe
 kgQC8RsakD8yrbjzP5puArp7X8dLWRPDqaeWr9UCTFyhVnihhy8C7KQQzwGmBDDY1kgJ
 7Hev3ul2IaElcOLF1xlOO8SDNMzfrWgP6Iqs6LnHRYfDor0Li+X99UB6rpfhlgvws6Ks
 bVwVF5tyLC6K5StiD/U2Z9u52bwZ5v9FSALM9/mXYXZAE75b8Tsm6u3lv/DR3tyeiU57
 Z9C0Ph3M8QnifFvHOX7Is72t6SSB1PytZoaEhVV9GXX7sJ/hzRFcX+FuFovIM3a2/znJ
 BGXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKvG/wAs+ajGChGd+XU8hK3xKRknAhei+VGzdTnKnkx4O9H1BPv6GURRmFZBYqhySnSllPRU+eoDRT@nongnu.org
X-Gm-Message-State: AOJu0YxDFe02iaOdiOI5UMUBno/j9deRinbVmEx+snAaH/NfGdhttDbq
 flpuR8aapjjkDwM1GzbjXPue0+HQsBpmLn1DTHu4q6p7u2Mxo2/looSNFxXEnyDTCdaCzMzPcgZ
 XAOGp
X-Gm-Gg: AY/fxX7btRd7qpaKVvdjhmiJShie7048IzIMp8aATjP3ii44B9ZNtLTQLVejiBbB1jX
 XZuJsewoHX5/v97OJ15nuAyN7RAoJpmJL8CwmhM9YMlS2dHORZBd/NA0Uth8qrHNVw6Rx4+zdRi
 DqlbAUIiLEFn+YJdrNZqyWjHkibJUwXj/eWr1UVGy5YtpQFDWjkrVXCZKgcGFYKayCUFOWwtSj2
 /s3+5qxN4htDU6cROzT0aVIbC1h7Q/Ydn5HwsLxWvvuWgN5pWM294tdpsPyvt/zKAEUQby7oMsc
 pNT9avD1xgbPEYjjV8HXLIrnM24kwYB5vsMoSqhR2YPmGKH9OHxbIylK1aWy8LV0dkh4VseVpgp
 bVWwXXhfW4WvPZ7a+Deg7jhjM1sOu9dqGxerYpLcxK6VUNSLjfjRwv6DB8lPLh2m4VXjYDgJAch
 Cc5OK4imDhx3XXt0BOpNCV3KTWKFCxjzJUQXVtRPp5+yozCll3aPsC1GK1iDXTIw==
X-Google-Smtp-Source: AGHT+IFbqHK8oqoGwdEEKEly102S8WTMxRiQsJ2/SXqi5/9vBxe1C0PUAHq6a/64W8cd7TnGxfGl+Q==
X-Received: by 2002:a05:600c:1c29:b0:46e:37a7:48d1 with SMTP id
 5b1f17b1804b1-47d1959d4bamr331519245e9.34.1766850140686; 
 Sat, 27 Dec 2025 07:42:20 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d4f09sm457162175e9.12.2025.12.27.07.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Dec 2025 07:42:20 -0800 (PST)
Message-ID: <22723a85-0008-45c6-b301-260d3efb7f1a@linaro.org>
Date: Sat, 27 Dec 2025 16:42:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 013/153] include: move hw/nmi.h to hw/core/
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227091622.20725-14-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251227091622.20725-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/12/25 10:14, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/hw/{ => core}/nmi.h | 0
>   hw/core/nmi.c               | 2 +-
>   hw/hppa/machine.c           | 2 +-
>   hw/i386/x86.c               | 2 +-
>   hw/intc/m68k_irqc.c         | 2 +-
>   hw/ipmi/ipmi.c              | 2 +-
>   hw/m68k/q800-glue.c         | 2 +-
>   hw/misc/macio/gpio.c        | 2 +-
>   hw/ppc/pnv.c                | 2 +-
>   hw/ppc/spapr.c              | 2 +-
>   hw/s390x/s390-virtio-ccw.c  | 2 +-
>   hw/watchdog/watchdog.c      | 2 +-
>   system/cpus.c               | 2 +-
>   13 files changed, 12 insertions(+), 12 deletions(-)
>   rename include/hw/{ => core}/nmi.h (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


