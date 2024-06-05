Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C4FC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEpD7-0008TP-UZ; Wed, 05 Jun 2024 07:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEpD5-0008Qi-Dp
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:53:43 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEpCw-00026t-VO
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:53:36 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52b950aa47bso3051170e87.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717588413; x=1718193213; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mV3bLROtNfBe8tsV7MXb1zd0HdKdOrlY7oOG+BXcoIM=;
 b=mPjbnDfxVKCptxxADINI5vzosobX8Ov4RjocGqskXlmwB+xYSEOESitWCYDPiwcc6o
 wQ4emE2C1EaAqJiyI9uXAAho4TBAIYygDFm6N/WAaIP02l5UqJdLimDo338BUx7W86uu
 qC66L6CXxHULbj9EZfeZhjFmbqL7zLzjdkoLR2x/EqXqQk7+QgdBgnLSTjRVHjt5kCmW
 15fCLi2Z0pWbXmKi00E+ibEKt6a9ixkCmtR1OFlUIp4Gs3tLRpLNn96RzU3TrQg7x34e
 by4ZZLLwwS6ITDfD9ujdvz1nNdJYGxJoAlRa+OxwKPj41hOUfcp4yXSBVg14tn5Jaoge
 3YgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717588413; x=1718193213;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mV3bLROtNfBe8tsV7MXb1zd0HdKdOrlY7oOG+BXcoIM=;
 b=lJYqsv3FBd0C4cuOg36OU659GE6MnXjXWgsra4qRHdwmOHV2vcNvtIunKuRkwDY57P
 5Mx9pSDNRdqVs4e/HPNUtrfw8nzLNrCjq4hDwwpZc/gVCTNYA6mN++S/K0m71Qge05UP
 no0eP/2TQR13Uny7DER4YXYk7slkmH4UPTf+Hheq/xYjiBO1735wgQeR51ZKrnAZgMkn
 gF5ztiDMuaIO8bMiXGIoOkMAnK/U2qeq8Pfh5/zmnpxyH6D2PCzEE5Y+VOgc/iWqCeam
 r69PM+X/7fkt8AOWI161dnWVnMm8pAuNbzoPvBpgbbqidK7uScywFDbK2tqC/cfVIyOd
 4rqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDpQndg07WeEGk+1Nod1FkxIqDitZB+7IJAWqlIlFVsEUgQSSTF++/xcM/IJ6GP4ZYRVKEuzP0Ohy/VkOTl3mxFyQAIZ0=
X-Gm-Message-State: AOJu0Yz+Oov78IMBoII+hflMg6sMNPc4hUC8cWQbjgiqlPsYLFUMVKV0
 UCsqA5e8ZNCcs++v0MWDZHR6/1F7DXPMVLqwIJFPLX3IBnmSVmYMVYrB6gsDXx4=
X-Google-Smtp-Source: AGHT+IFBsNuDB5/oLerxZ/ZXkEzJQQrWWgEZDzyvQOfwsi23fMZ1/OdBg49Fnm6uyxrsW8/g35Fcmw==
X-Received: by 2002:a05:6512:1108:b0:51d:8d56:6b15 with SMTP id
 2adb3069b0e04-52bab4cbb27mr1694903e87.1.1717588412705; 
 Wed, 05 Jun 2024 04:53:32 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.183.84])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68f668e1bfsm508060966b.176.2024.06.05.04.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 04:53:32 -0700 (PDT)
Message-ID: <b4335eb7-0143-4a37-8fbf-3cf5ff528411@linaro.org>
Date: Wed, 5 Jun 2024 13:53:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] util: Add lasx cpuinfo for loongarch64
To: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20240605093213.2191929-1-maobibo@loongson.cn>
 <20240605093213.2191929-2-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240605093213.2191929-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

On 5/6/24 11:32, Bibo Mao wrote:
> Lasx is 256bit vector FPU capability, lsx is 128bit vector VFP. lsx
> is added already, lasx is added here.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   host/include/loongarch64/host/cpuinfo.h | 1 +
>   util/cpuinfo-loongarch.c                | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/host/include/loongarch64/host/cpuinfo.h b/host/include/loongarch64/host/cpuinfo.h
> index fab664a10b..d7bf27501d 100644
> --- a/host/include/loongarch64/host/cpuinfo.h
> +++ b/host/include/loongarch64/host/cpuinfo.h
> @@ -8,6 +8,7 @@
>   
>   #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
>   #define CPUINFO_LSX             (1u << 1)
> +#define CPUINFO_LASX            (1u << 2)
>   
>   /* Initialized with a constructor. */
>   extern unsigned cpuinfo;
> diff --git a/util/cpuinfo-loongarch.c b/util/cpuinfo-loongarch.c
> index 08b6d7460c..bb1f7f698b 100644
> --- a/util/cpuinfo-loongarch.c
> +++ b/util/cpuinfo-loongarch.c
> @@ -29,6 +29,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
>   
>       info = CPUINFO_ALWAYS;
>       info |= (hwcap & HWCAP_LOONGARCH_LSX ? CPUINFO_LSX : 0);
> +    info |= (hwcap & HWCAP_LOONGARCH_LASX ? CPUINFO_LASX : 0);
>   
>       cpuinfo = info;
>       return info;

This is 
https://lore.kernel.org/qemu-devel/20240527211912.14060-6-richard.henderson@linaro.org/


