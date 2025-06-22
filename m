Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963A7C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 03:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTBDD-00020h-6m; Sat, 21 Jun 2025 23:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBDB-00020R-S6
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:17:41 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTBDA-0004ku-9g
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 23:17:41 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b2fd091f826so2312233a12.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 20:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750562259; x=1751167059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CB/mBpvxSMiGeU/Qx63Pq95iJGW/ZdBvsDgDSbM8jT4=;
 b=NDSUBKUNa5MiZgZEkgU//NGf5/TPv/rahBE/KhvFG2fYKelFCOlXJe4lipwNTEDNP0
 TnmL9Hrj/S55oj7tirn3DsXTlJrVzl9jOuXNr6EcqawHYABb7PJzoDBp9uo+r8vVu9SV
 HJih8/ntxuXKFRFD/9gSyyXhBTdox8SLUQbbZ5FCEZEmE2vZF3bLUAOCKpXxJNBBvHls
 mTpJ3Ag7FJROG9MWtVy54MMOgmOkA4H8gRIdM07Y0fn2lGwUQT0mW885IP/W3LQfUNSB
 B8u+p1psVEULXZSfa4bQYyM85SBQKcblcn6gxGvv/IXJbp41GEMvRx/oVaZfiEJoJT5Z
 YTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750562259; x=1751167059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CB/mBpvxSMiGeU/Qx63Pq95iJGW/ZdBvsDgDSbM8jT4=;
 b=nYkh8g6cvCE5HSDC5k+qXXUHr2YS2MSafLGH3qR17Uq9U99x6USMhxjLG/7RHXS3yZ
 EtvE6E/DDxPBs1+k+7A+DgdV8NDTPAzX4sv6WzEuTuP0KrlgAl7akcZDPjBlvQ7Qqx+Z
 UZkAHHMVFIO3JLdq129B7WRHsmr6A+7nBi0T+e8vbz7CxjHnzTrqbdb1phuTafHfndDp
 hZx4qY00bzpHtcq2aLUbQoBkjRzA76BAo2x2S0BLjc10XktKpLTW2BJYcEZyC3i4HKv/
 2UQrMd5Xu/Gj2Kz2/91BZBkrZe638n/vRQ3ZiDXoXZREJVZZkL7RpQ6g5HT8qiV7s8K0
 1Aqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXocPL+ETlPki05wyJYx3iFFFKGqDkU60TORCTqj2PIK6zNzbbtlZjqin09k9CzmT/2Ai5ptji/bMLX@nongnu.org
X-Gm-Message-State: AOJu0YyMqx37Ra8MqTxmryzjgjo/ulX/8N1R/GkIdIKVnupn611gQWFO
 0eA5kPR6ATDLMwKQvbn8iD0PnIQj6hoy/GZYJx33ZVyExYpr/6JTj98UDFy8AI8W1ZQ=
X-Gm-Gg: ASbGncuwgLGfYaqTucVx/Jd6t40vpaxpTLsZyvDDrzyipK63qevoZ0Gpwg2zj1Ciukd
 JEyUTRj1u/7IGhl4VcHoSieSLAkRLFJNU8yViay618pOORoC7fjTScD8yaftruPjvCLZVDxJe+m
 PgLCH1SRPgmA35UGx5Npxz7/lwHsXH5typhxgRFMRte2eJQO1LQVG5+wEKQbhdHFM/0brlnj/0o
 lZiDI+tugl8tQRGGgtgQ5Ev9H+zLoAROU0Sq0Oa47+tLTnH0hiOOa13qGr7j5ijLcsHpceVBO2l
 1jJLR6KLtihPeEwYsHGUxvBM2jqFnAjb2UMko9FLe1fDFiqooUfaG+iuR+xhRFktgfflsZqP3+O
 IcTb8971ZyK6HQojNw9WDJ6EZmqcZ
X-Google-Smtp-Source: AGHT+IEfe/CGpFKXuBLyrE5VSq1BVddA4oLwtnYHpnFDnSGxZr2zpt82JIgUa+omGPhQmsLq8su5Fg==
X-Received: by 2002:a17:902:dad2:b0:233:fd7b:5e0d with SMTP id
 d9443c01a7336-237daf65655mr122626415ad.5.1750562258763; 
 Sat, 21 Jun 2025 20:17:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d86101ebsm52145435ad.113.2025.06.21.20.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 20:17:38 -0700 (PDT)
Message-ID: <059793f8-8281-4f84-99bb-8a75527d0f95@linaro.org>
Date: Sat, 21 Jun 2025 20:17:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 31/42] accel/split: Implement
 remove_breakpoint()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-32-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-32-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 0f3d48fc68d..40cd39aea5c 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -264,7 +264,18 @@ static int split_insert_breakpoint(CPUState *cpu, int type,
>   static int split_remove_breakpoint(CPUState *cpu, int type,
>                                      vaddr addr, vaddr len)
>   {
> -    g_assert_not_reached();
> +    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
> +    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
> +    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
> +    int err = 0;
> +
> +    if (hwc->ops->remove_breakpoint) {
> +        err |= hwc->ops->remove_breakpoint(cpu, type, addr, len);
> +    }
> +    if (swc->ops->remove_breakpoint) {
> +        err |= swc->ops->remove_breakpoint(cpu, type, addr, len);
> +    }
> +    return err;
>   }
>   
>   static void split_remove_all_breakpoints(CPUState *cpu)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

