Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9E0C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyGE2-0005NN-46; Fri, 28 Mar 2025 16:22:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGDy-0005Md-0M
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:22:42 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tyGDw-0002Ic-9u
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:22:41 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so18385545e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743193358; x=1743798158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1TnxPi0dQ/ZDTWUWWKj0FrguvPjfOZPpXfOZ53G2lYY=;
 b=IPKxDv2UqLAPfLqyqm+LNIr4CsynHu6Y6Vced1Ym069rysEtjCbxT57lNKrIFXZWOf
 vDGEsEmG0bPhohDRptjGFjQS2F5CNSxeDACHeukhOvf86n4A9AMB3sNVVoo46QiujHhT
 +rabhoJPsbU2zD5Kt4WSggzwUKU7C5/6jZyCMiTV6Jl03YF9JJc7LGkB0XZywaTaieRg
 1rTaIoIqjMV8hzkZ2V+Zu8pjrQHhE01BVhUsUNAFJiZfUiyGyhOI+PSz8LCOY9tKGJhI
 LW5hlGKSootTQ4/GBZKT0BzpYi43WPuUYP8jceByVdi6Db+gTApuJl+4iqqFN/+fYAND
 62KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743193358; x=1743798158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1TnxPi0dQ/ZDTWUWWKj0FrguvPjfOZPpXfOZ53G2lYY=;
 b=HNL/p3bNRN/IO0Eo31cxWBsshFRNJMXbCHob403eW8USVYgn7zC3zHbu46GDg1fl7Z
 xBINma1nD/S7EKQ2/MtrHPfamssJliaNzSUFt96MJw4Di0Uv8EE1ISfiX7F4pMtd0+Fa
 2yUmX4aXpBzile596Hl2Q0+LajP3LB+yVvlMvDX2NtjwmMWhdmfrvimayK8tuHiU5g6t
 sT/vVV31g1VJQInN8AdSuMMgoEKGu0SYq2MeVl2LL90pfvvEpXYV/VMqiRPVJY71dU+3
 BvbCm04ImnS5nq+0YXk9iZFAwrp01/ZmPoc4+WGWoGX/LaGDMHc2mPyzYBZjHxKdOrN9
 TKbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCcAHunaqOfsEisK94CVXN5txAa+hk9W0gvZIWwIKIT4HooqQ3IrYtrDGIJchQmVR5Nad/GhX0qRpE@nongnu.org
X-Gm-Message-State: AOJu0YyqZSrL9XcEHP4DF9rIUr3Pq14Izd3swEx9yx2cfupyImG0qjlR
 VqUejez6iNL1d24RFCr5g0E9dVmJDVgXaRUUUMXGjwl5AmlgxKcTMnvbqGhpM78=
X-Gm-Gg: ASbGnct0sokMQFw50P+sbhfh/JVE73d/QHX0Blybsi4ciZw65BHHKwIhtvSYMvmzm3g
 xSURQOsSYfUx8TJZTBGC0I9kJeEFLg2vwykqxfzIXJvAJxLMeOlPWerXJv1fMGzRaS8LCIPrZ1f
 unN4ZoqvjNr2EKsDhDaVoxM4Z+iUMVbs0QEKxs2L99Te/HgLOOEWw2rG2tYrwno18G6b8JQcvRU
 NVybwRic92QQCz8sfrrerEAq+XqGOh/k0lsnrueSkl1+fyyPPjljl5VjKlfkGCLnKlBwycmmV3l
 4F+SPKRNk4OxG1HuVeq9mKD9J94cx7lgZaD2RFUkjfsPt9ceRnC2QoZUMeDTaMdf+h+/Omv4l/e
 qBYxaVM8hXtpL
X-Google-Smtp-Source: AGHT+IFvzqsCvtv3x8BHHWmUEduXHzwMr9ImzzT2Zi3qiriqWHnEMtyIVSvAL6U0aghRdOSRLkyfjQ==
X-Received: by 2002:a05:6000:2d84:b0:399:71d4:a9 with SMTP id
 ffacd0b85a97d-39c1211d344mr265920f8f.52.1743193358340; 
 Fri, 28 Mar 2025 13:22:38 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b662c05sm3547480f8f.23.2025.03.28.13.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Mar 2025 13:22:37 -0700 (PDT)
Message-ID: <6bdec69d-1ee2-4315-81cb-16e4e54724a7@linaro.org>
Date: Fri, 28 Mar 2025 21:22:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] accel/tcg: Split out tlb-bounds.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250328200459.483089-1-richard.henderson@linaro.org>
 <20250328200459.483089-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250328200459.483089-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/3/25 21:04, Richard Henderson wrote:
> The CPU_TLB_DYN_{MIN,MAX}_BITS definitions are not required
> outside of cputlb.c and translate-all.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tb-internal.h   | 27 ---------------------------
>   accel/tcg/tlb-bounds.h    | 32 ++++++++++++++++++++++++++++++++
>   accel/tcg/cputlb.c        |  1 +
>   accel/tcg/translate-all.c |  1 +
>   4 files changed, 34 insertions(+), 27 deletions(-)
>   create mode 100644 accel/tcg/tlb-bounds.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


