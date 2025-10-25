Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF50CCF9E3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 16:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCh25-0000QW-Qu; Sat, 25 Oct 2025 12:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCh1w-0000P6-M3
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:22:12 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCh1l-0004e0-2c
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 12:22:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4711f3c386eso23446405e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761409308; x=1762014108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mw4cMjA17A1nQyKx51THzlcOf6ZZUkMSmCSkwoespsc=;
 b=o4eDexZzn60n7+YXeO12hP/BstMd4nFA2o16Y6GrmDyQfZh3GBTMsLLBzJLfy/10Io
 VcCfoZFaByVSqs1A8ed6EzEUpNnpgobRJNrEJsD5oDw/G6L/xgKJqs+Y0yEGd7aFp8GA
 pSdnF5YEIJYvo/nNFQcUYCKm7VlbpAFw2nNBfkiKamGe57IKCrIljmgQKZVwRhc8Wveb
 ktCk2MiHAKC2q9ItkNzXNtbiqzwDFYI/t620pf7UyEnM72PbgSw/HwQQDjUPlE561scc
 bhhl+ldRJUq6B806l/kL4q/1qyQH94GQr9c01hA/yD2/E1Vjt3M43DmG5fQ0j4+P8+1P
 tp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761409308; x=1762014108;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mw4cMjA17A1nQyKx51THzlcOf6ZZUkMSmCSkwoespsc=;
 b=RhzYGXPBixff3hFZpKgyfxMBgqEMghUGu9HOdVyrCc1AETPTLGJks322tRzXkknCCy
 N7HjzwS66CE4S/mD3Hd5JkR9aqcS2E66+l6y01KNllGY+ntWXRJ7BpQPp3owOfDhmGjM
 aMtKateOfxSI9ojaqTY3YPUDEir/O6PlMM8v6yUlL+qz8zptM/VEWT772/WG+e6YZXNN
 3/gnzcJwAc7UJ16zG/JJuNmDD7sAy2SrWuJlye7tHa+5nrWHxi2kh9SBzAaZxC/tzN3u
 IgXocC/mj7/dD2if3d4L4ldwPeapv2qXg85OI6nbJQ16h9Ee37uxudXPaHc5YyO4+rWE
 703w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb2+JHmOgUj/yujzWkpocAg6QRGd/IkwDRHzi8s3PdMrYpva5nntydJufXpASvZdS2Lvge9DxqaATr@nongnu.org
X-Gm-Message-State: AOJu0Yzdd8vi/Aq6ynfukGI/pocm+vvhbOsQNiABg4NOUq8ewCET1+ci
 vPyKqb8+BTlRgkFwax2GS6HbCbW5cYB4xebUim2y0br5GuLUx8WNBjIk1ODCLVo1dBc=
X-Gm-Gg: ASbGncv2x1Ql2a0ZY7l2DfYZgvaxptgILBtZAAJHnMNBAdBXtijuzzqMG/2+oF20oX/
 M1GmIIT3aJDcOVqj54H9xeQdmy2whuwXPLuTGVp19JBg+UoNKMPfgeZyQ10gki3IlPYdAeeGXF2
 UONrRHxUD6CdpSsPCLHUyNWZoveXVV3m2A6m8/gphQ29YzcG8975lEr83wY4EEhXZU/y6zCkPDt
 DgtjuYUtp51318k3bOXTn+tdUeSGkhL9hJ8IFBHkoEEO0UgCqfXCVY5Mik6akP4S2eSACt6fMFT
 6zOcBCYKJ2R3TaprM2nliIEYiBMfbCITlOoDfeyw28t4zK70EGOU78itebjhz1bQ2TrNQoKa3iK
 voLJt9/6l2ajEyMgS6xtEEv6ws5UHkFX4TFcd4qCj7kU1gc+GW++SCknSFkcrHlIWFo0whxIUzP
 K12krg0pTfZ9iPoP7rUlIhdMg9xdYgy7N1iM5gKOpKKJY=
X-Google-Smtp-Source: AGHT+IFWhUv0DrvfkKb8vJVxuxhxWd2u5I6ompJ9I0MXtfBEoklRkHX474nb+2tWgnnIU1E2J+jT1g==
X-Received: by 2002:a05:600c:3513:b0:46f:b42e:e38c with SMTP id
 5b1f17b1804b1-47117925e9fmr240963945e9.39.1761409308435; 
 Sat, 25 Oct 2025 09:21:48 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d5985sm4344243f8f.25.2025.10.25.09.21.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 09:21:47 -0700 (PDT)
Message-ID: <17c7b7d6-282b-4e21-b922-e26aa3fa03ee@linaro.org>
Date: Sat, 25 Oct 2025 18:21:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] hw/hppa: Fix interrupt of LASI parallel port
To: deller@kernel.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Fam Zheng <fam@euphon.net>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251025161901.32710-1-deller@kernel.org>
 <20251025161901.32710-8-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251025161901.32710-8-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 25/10/25 18:18, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Fix wrong assignment where the LASI parallel port was using the IRQ line of the
> LASI LAN card.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/hppa/machine.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


