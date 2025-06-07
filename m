Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976E8C61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 13:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNtc6-0005kn-Eh; Sat, 07 Jun 2025 09:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtc5-0005kd-At
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:29:33 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uNtc3-0003CF-MO
 for qemu-devel@nongnu.org; Sat, 07 Jun 2025 09:29:33 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a53359dea5so826223f8f.0
 for <qemu-devel@nongnu.org>; Sat, 07 Jun 2025 06:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749302969; x=1749907769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dDvMD0BFzSxxACeHiZC9kUfNrKa0YLxUtg1V0FTVBeo=;
 b=z2QuHXorpc/eAu64pJUtzewpMvhQoGOFt1wXcq3LkBYKQZdz1+LLkAZF7g+7s12fxr
 OilpsjOFprMdQ6vO2Nkl88SfD9dASoYEpdYspMiLzQp+pqbYQo6GrekwjitzfPL4jr25
 XI+eq+mM1k/S2bUNYCigAnnL9Bl2A2D3K7mIrol+cryXCZveM9/CNtHOuSCxc3aejRdG
 n35B5em1UVgBnkvD90OlWn2y7wxunF8fLYLaNvalHGgCHgIkqdrCgASbVPMytAVo3FLS
 OMLQFCWHjq763StzrHM2iiqa2PnXkVPoGJpgNX0wbo82Q6y21qeffX+SLVBVhxmlNziC
 lX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749302969; x=1749907769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dDvMD0BFzSxxACeHiZC9kUfNrKa0YLxUtg1V0FTVBeo=;
 b=FKqg1zS1xgG3DPN54boVeEBymBv2k+5PiEM5DCWheo2F5/QM4wzWMTmsD5NNN7PLLy
 SDmQSPjUqTxxymlCH4VsqDOSqeiQrDiwWwZey5dbA5ASLef9qgf9NknS9olXgVM9QTta
 0if84Qf3jkBxD+d/+XksFa23HpL0RE4dINJ6h4+1DzKJsO1RaPSg6/eJhqzt/ZGJp02T
 oqTdHOlq+Jfs4eOYhkLiew4J168R/nPRg4g3bllU+cetfHU0o8VnBnJFaXB4h7GJGYUX
 0/xrdLqkMcut6wubwwAHYUp9ri6V0qE3XgpFgYiGAuP1aiNQhCYxE4ybtLrcxiNc3Jer
 8IEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv+ls/3GOLIk+n4LAJz5H1k88Fbm6DkLGdrKvv9CNcpGIvqpuGu5XhnyeujqoXRSOfP/2g8B/f9YIb@nongnu.org
X-Gm-Message-State: AOJu0YyWcls45ifG2T5TTsytuF6UJ+lUMf+BSJaL9MSc7pcMAlwYuZo8
 bkKGZEiFAE5Ac8u1BZ17kUwdD5LdssFn85jUXBRkaLCfu3wDLb9lddyXeoZB+fL96Lg=
X-Gm-Gg: ASbGncuyH2hTkKJ0rkBykRONLtVlpCJn5qow5BZS511HWkmuxfo8m9mt1M0RJFm6TwZ
 TSE979R7o7eZTi+9eC8QwY6O8xub2TaMDDgu5j1Tbem2LzZsd4Wp8Rgb2DRWRmUA/CV6j1yI/Su
 ZNX2YsIyhZ1+4/JDtyiAEmTGWPWXlk9MjcHRYpJvBzHCfb0JsnmlwyT8N/n9VAzh4Kz/kfgEjud
 P3oubZ7k9vJ8HXRMciauyPqAKFHgDBYkdIMcY7iJouN8D69WSZ2Eu2puj4pa75n08ohQX38+1wU
 2JhNE1LfmQ4sAGM8UbYRoVscO9f9ytMhe6gNHTe71b9eic6N/96RlGrxU2oII+y1l/GQxZLlZsd
 Tn3HR67U3sYIrqV0/aL8OX1PfAcb4uVwwwTH/NsM=
X-Google-Smtp-Source: AGHT+IF+Y/cBlFrowSPWb8m9HuSYtUTC2yV/JVwDEeO+FGCw2kbC+f7SgDcXpqwAlSFyH/7PQXnCVA==
X-Received: by 2002:a05:6000:250f:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3a5319b5ca5mr5911800f8f.58.1749302969402; 
 Sat, 07 Jun 2025 06:29:29 -0700 (PDT)
Received: from [10.10.12.33] (cust-west-lon-46-193-226-34.cust.wifirst.net.
 [46.193.226.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d3esm57063695e9.6.2025.06.07.06.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Jun 2025 06:29:28 -0700 (PDT)
Message-ID: <2694d74c-9d10-4662-b1b2-88c9a172eb68@linaro.org>
Date: Sat, 7 Jun 2025 14:29:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/19] accel/hvf: Fix TYPE_HVF_ACCEL instance size
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250606164418.98655-1-philmd@linaro.org>
 <20250606164418.98655-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250606164418.98655-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

On 6/6/25 17:44, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/hvf_int.h  | 1 +
>   accel/hvf/hvf-accel-ops.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/include/system/hvf_int.h b/include/system/hvf_int.h
> index 8c8b84012d9..d774e58df91 100644
> --- a/include/system/hvf_int.h
> +++ b/include/system/hvf_int.h
> @@ -44,6 +44,7 @@ typedef struct hvf_vcpu_caps {
>   
>   struct HVFState {
>       AccelState parent;
> +
>       hvf_slot slots[32];
>       int num_slots;
>   
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index 3dd9de26dbb..808ecea3816 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -366,6 +366,7 @@ static void hvf_accel_class_init(ObjectClass *oc, const void *data)
>   static const TypeInfo hvf_accel_type = {
>       .name = TYPE_HVF_ACCEL,
>       .parent = TYPE_ACCEL,
> +    .instance_size = sizeof(HVFState),
>       .class_init = hvf_accel_class_init,
>   };
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

