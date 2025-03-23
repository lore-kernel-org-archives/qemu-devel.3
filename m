Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E48C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twR6U-0007d4-E1; Sun, 23 Mar 2025 15:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twR6E-0007Wd-AW
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:35:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twR6A-00006a-8v
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:35:09 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227b650504fso6150605ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742758504; x=1743363304; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6uFHprcikhpymWB55yCpTb6bdCmVjwgeavCcPBcr96U=;
 b=SH7Cw+2F3+gVjO4v44wTkdlYK3qiKZnL0N8Yp2Oe3c6839qr59qZinytax7EhUnWCm
 5aLdVVbw1woQO2Nc+liRIxx0DDNL2kaerFmeRRdPlUa0+F1PJcVUeL9fUhYexOYw7076
 2nczVG9+4QRntncMk+6r521v3vMzckL8qGt23XN/sgbDnK6Q9zvJ1Lm38BPYjKh4Z4G6
 GDHkCT+K2QtXR0ZXcc3eXC8EoSj9TqkTM1SUmuJ/O/z9EsfiwfsIiSK+aEVCsxEy88So
 PFHLLogfem9MGh9KlYqONcwIJA0Mi2fjWq1Il6hgkKdOTYBbvRfScC7/v574yOxmHpU2
 baHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742758504; x=1743363304;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6uFHprcikhpymWB55yCpTb6bdCmVjwgeavCcPBcr96U=;
 b=LWZaf+czq5D16EQyoXZDzhUbA26xqIszcREYyqvcLyQCnz03VyC3C7BaWVUwYzgL+e
 IQ4Epdow/5Bh7e3YMBVp4Sa2ml2bsdggQzinGpd1NBhXojrTHlht3mnVq49EF9eKtdof
 PwRwwc4h6YfgLPbTTQ5eIkPMHf2sYRXOFE07ZkN5HlepLHO8gML36dMKJUJzzwdRGcTT
 urb24V6omvdrQOx2hq8QyaLYrBA/kLbf2NnldmftWZhFvrxaQEG/ouYwO9Rc2PnuB1Bo
 aU+WnnCIm0ipnBG/808esXQj9C9fPxR9bKUCen64GaUI4uQQeRgxOwX1iOmRsI+gVXUb
 3Ykw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+gI5TvK1rh8Skh3d8YR9Y74Tvf5cOQWIrp8d0jAwbyAP25G38PqjW0WL8nQX5r+/a4kXAMkqhejOv@nongnu.org
X-Gm-Message-State: AOJu0YwvZX1bPEiwMP6kPVf+PJ4u1KnCaZTajtUiMTsEfmKItf49H2er
 IKJ6nC9uYU7l5B8D0Xg5SYDGZJ5JZT/LnxrvXYxgQy30lf1AcoiF2fZBd87Rkus=
X-Gm-Gg: ASbGncsliTuQS7dP+8VXSB1PEz5E8vTSvneOo0oMK0Kw5wdiO8bxYEKw2CUDP2h6Z+I
 Yh3xXhQri7gCei81vS6F40uCiKKsv9Wp/9KqGSTKCbhooLC9M1YtLFGj3tF9U4J9hD+nCXe4jlo
 2jKQs2bpX5/qbM26YJD6qpD7B6oV/DbjlPEKp0XiZ2hX9sujiUiFuGUqflASpIz275wYqregd1j
 YoImLfpk/f2J1X8NZCmmOlc9+pITGQSt63BbHKtzM6+f2iBfQ6NaDuW7GC5LB4fT2w3p5xIBfmI
 w4NFMZgHxtvXuadvNAVvNAXXNsjt1Q+23+jCHKIykJc8scpt8NXMl2CJ/ssF42aYsc3CSZfnNal
 9T60XO4+F
X-Google-Smtp-Source: AGHT+IFgRup02ALEGV9Up4pGVIChVj4UQbwmHiBRpSmtL1xVI22i/KImHDNBG1uslaG2Cps0De1PoQ==
X-Received: by 2002:a05:6a21:3a90:b0:1f0:e3df:fe1 with SMTP id
 adf61e73a8af0-1fe42f09148mr16939001637.4.1742758504266; 
 Sun, 23 Mar 2025 12:35:04 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a27de717sm5639598a12.12.2025.03.23.12.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:35:03 -0700 (PDT)
Message-ID: <4586fe00-2be3-4d99-b681-5463058f3922@linaro.org>
Date: Sun, 23 Mar 2025 12:35:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/30] accel/kvm: move KVM_HAVE_MCE_INJECTION define to
 kvm-all.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-19-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-19-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> This define is used only in accel/kvm/kvm-all.c, so we push directly the
> definition there. Add more visibility to kvm_arch_on_sigbus_vcpu() to
> allow removing this define from any header.
> 
> The architectures defining KVM_HAVE_MCE_INJECTION are i386, x86_64 and
> aarch64.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/system/kvm.h | 2 --
>   target/arm/cpu.h     | 4 ----
>   target/i386/cpu.h    | 2 --
>   accel/kvm/kvm-all.c  | 5 +++++
>   4 files changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

