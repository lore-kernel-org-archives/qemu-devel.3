Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311A6C87FC9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 05:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugznA-00004v-UZ; Wed, 30 Jul 2025 01:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzn0-0007rB-4s
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:55:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzmx-00067N-Bb
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:55:45 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-74924255af4so5393499b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 22:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753854941; x=1754459741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F/4WlfthxePCCbVWUgcxuSHl2txbqOw6IWz4XgIo3AY=;
 b=uDimxyf1JicSa5O8wxntPmJzu9xWqpJeIqEHbpjf3Y3NO0hEmihDsGtjpkAlML0wHH
 yzrIe7c+78KMYeLEu4A3YUX8MkrXSLslGadG7k0yetzbadiACVBuYdQLnhMWhqril1f7
 210KPd4hAGLIk0Bi5C4yp7TOq/5SfM4hCtIYWXmDfsYuB9rnFW46ZFGRAtJ/j1mdoFGw
 aOjpZ9XQTQuGnL3ygRdkVx7jnW1HEM42ebBz23xPVpVdIgqn76EI/O+EkJKva5ws/+mn
 uFjO4TpbajQojHjdeSBaPg0ZHNVei++IEuj1u+ygrB+gtMZRKTouJL/hgX7bgPdoMYHZ
 SCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753854941; x=1754459741;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F/4WlfthxePCCbVWUgcxuSHl2txbqOw6IWz4XgIo3AY=;
 b=J6xvjuaidG4eP/L4kxJcrwIq6CQUOK3ZoDlJog5jlJ3hjPoLoPef7APbkfdkcETstc
 WxGdwyCuvQxYWhPf2L/ldXLycDsanvPBo9qkZGJk0fF7oPYFErNb8XIxPWgKE0pjswk9
 mJWIrVpAvxaYsgp9kPALIByupOcnhUJJYIM2PEtkuTobmmSWHBRxp9/LT6jM8YAi+KEo
 rqEJzygBn9iAc1G9VFGC7oxBh/81iwh6n0PNYxzHiAHhwbTKBlqj36vd8+qI73cLvRyP
 gm96A6PZOVrD89MDAzKAH59Pe090d84nlNRdiC88QkxD9SMkykFqMBbCUPfuQFYVvOpY
 UeXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuwmBjWHoCgXAEGb2F20RBOlkzJTbMgqzdjnLmFSvhBjaiMgShKhpXhYdyLl5+bzOUcuy3M6ffJB/8@nongnu.org
X-Gm-Message-State: AOJu0Yw84b5i3Ntea66vbcaMEJ7Q/L8Pp55RoSDvzLEk8YDyaW1YbESy
 bqiTPCSrGpBzXrISMvWNB3rc40H73/hZYVhIJZ7jlT4qi3Qlhlhw6x1u4oMKHCxjVbc=
X-Gm-Gg: ASbGncu3tVNJRzTqqNrNFbqlQN6v5YeRbVvnyUA//+2CDccih04pG+4qBzfNRdhiWKW
 TFCX52aR6TgKmKwTLwMhwUopQM7oemcjSCe9CsGurjNbbQe9YTMH7+T/vOi4P95Gpqvlmw0iFdH
 kVfcC8oSxDEssC4ZvVZZpjvgcyd6wuHEh1YCgVFoeu8U6oFX6q2huhp8LtnSU16FpC+QzxYzYyn
 6jNT/lRkNiMMBwxXx6Tj95i0tpmA55c7VzCM12+MmquxiE9J2d5pOC0da4L2zPBjfLWm6gi5P8u
 JArBFk3bY8I1yjiBRoyIYumv/MBucbylotwJkRwBt2+GrHp+2LNuGeYWp5KmMr7WTh3APVAJxgH
 Jvq9O0CRSRxKa0oyOt39vsMoDFlbmCntIhmE9Vfaaaoc6wcUccquO+uLvoyd4+MAXZsx2tjwmjP
 IbIA==
X-Google-Smtp-Source: AGHT+IEVrB8Q58DZ2z55SfAZCCJG8ZqVrAPGK+s7cnBhT8i15YEawpcXlcyvc6qh+Hbr+6/AVGz3WA==
X-Received: by 2002:a05:6a21:998b:b0:21a:da01:e0cf with SMTP id
 adf61e73a8af0-23dc0e32c0dmr3894879637.22.1753854941657; 
 Tue, 29 Jul 2025 22:55:41 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f6c8940sm8278671a12.59.2025.07.29.22.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 22:55:41 -0700 (PDT)
Message-ID: <183474fe-9a52-42c9-8e3f-e28da316b96c@linaro.org>
Date: Tue, 29 Jul 2025 19:55:38 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] target/loongarch: Add common function
 loongarch_check_pte()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-9-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730030202.3425934-9-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 7/29/25 17:01, Bibo Mao wrote:
> Common function loongarch_check_pte() is to check tlb entry, return
> the physical address and access priviledge if found. Also it can be
> used with page table entry, which is used in page table walker.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/cpu-mmu.h        | 10 +++++
>   target/loongarch/cpu_helper.c     | 61 ++++++++++++++++++++++++++++
>   target/loongarch/tcg/tlb_helper.c | 66 ++++++-------------------------
>   3 files changed, 83 insertions(+), 54 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

