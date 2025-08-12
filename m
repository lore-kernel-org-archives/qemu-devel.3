Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F63ECA0EDC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 22:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulxZg-0004Dj-KL; Tue, 12 Aug 2025 18:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxZc-0004Bl-8t
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:34:28 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ulxZU-0007yK-Oi
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 18:34:27 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2407235722bso59896515ad.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755038056; x=1755642856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PWC+aCiajLIkUsSi2Sg2yhdD17cXc5LvpLT7GpRd2fc=;
 b=rjtd1D0l9etpsPLOk88zlhzq1XDzmpofOk43vetB/QETvO1KcbwgYsKqL8UKTB3fkD
 KG+lRruaEps56DIUQvQJPNQwKZqYeOdhg58oD5XauH5jCONCf5REMgDB7fUFKs3mYZaX
 EdhuBf5+j20tQlAVkaONYCi+qLqR2499T0W/Yjc3cmnRKtMgSFi57Ph2Z9GwYQj1ORmh
 T9nMy5oEQmUHqXbOQEdYZrtKk02bwiNNgOduEWynsbMq4AXGkYksvYYHMcJRie4GYEAW
 JQEdnB0PPPLBsV4peA9jiTw5ukzB9zds807OaiBnb4R2qdCWsaKCZ2rsSf/wNnl9jit6
 66kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755038056; x=1755642856;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PWC+aCiajLIkUsSi2Sg2yhdD17cXc5LvpLT7GpRd2fc=;
 b=L0AfEpNC6g1x/c84M0YGqZcK6rG9+GbP82isRZHNzcI8sY+KvD+qgwDnnbKoEXQNJQ
 uow3MwVqAm5C8xfBRTbYTTu4CY+PyXhtsBq7av+ZOKx5AojOjISULU7V8uJRXM5xQnAP
 k6rEsczln2wRgxsQZZdgzWhbjhs4rjsw23Nfx4OhuwMvZPEDzRWaCfcwHjAPShBaEb4z
 p5bFDfUsrV09BLTzeHO43t9L3xkxiRzzhaFyxqWelr71JKXyaQN/dWEoQ8LvCDf7/3As
 QHs5H/rhhJ4K6Ms38STphQBSeS3SeA/+3D9QdW+fPHjy4T5niZFznVFU5spVD79NagO5
 gGgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtCtWFmr/cXxcH1t8fhCX6Kn0ymH6sv0B5sV1lHbWEqJKbwcdXw3yzKlJv2H8XW3CFiYCji0BgecvF@nongnu.org
X-Gm-Message-State: AOJu0YzS8Y3++AGSdxf6xDtr3lt/6OeTa+LsL/Z7P+UMxx2Wz4ssWae3
 GdVyfm14Pq9rRiYCUsL/9m/S6LUeyxiSAmBccSsxMsdtl0sq7dG4shSsSv4MDtWZfdo=
X-Gm-Gg: ASbGnctt3c79QUaZo5vz4+DRrz1RP/9pyTlnD2UHG/LVQhYVjyrSu3d3/kLhJAwQBfx
 6lLEymJTTgo8qsidBpOYhTpTkbyQYZRCKHvwoz7Guhy6zS+OVHNLGYM1cQMp8GhxnRAvPowIVi3
 DzWba8k4euJHwcnjyKqJgCjwIRWTIe8+8sri3nktsrf4h9mBLEnujJh7Toncj3jzxw57YWwe2UZ
 5kC5vnlZ+0zkPCWDi+iil0q8tLoIhtfxeDaeZc9detRMqDsO261Seh9i/s/tMar2/S7BYw+GnGH
 c72jCXE3xvQNEDP8XVnDGEERRpBGWZhuz/x/McNeCPoEojHh3qVmJ63KioXEIkAkLJ7vzNonbVS
 nnOvBiQiGtqNQ5dwQghJUblBEy8Bwba1cECPdVxRh
X-Google-Smtp-Source: AGHT+IEaAZYsQzG3av03Qd8vvWCVm5F/8hOBLKzlErUcTWShAJkEjzJh4eN1hJKsn5EtEnyyqcrraw==
X-Received: by 2002:a17:903:234d:b0:240:14f9:cf13 with SMTP id
 d9443c01a7336-2430d23d29dmr11754095ad.51.1755038056083; 
 Tue, 12 Aug 2025 15:34:16 -0700 (PDT)
Received: from [192.168.4.112] ([168.140.255.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899a8cdsm308788855ad.121.2025.08.12.15.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 15:34:15 -0700 (PDT)
Message-ID: <2f3cd701-6051-46e0-b7e2-e807b29afa28@linaro.org>
Date: Wed, 13 Aug 2025 08:34:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 10/10] target/arm/hvf: Allow EL2/EL3 emulation on
 Silicon M1 / M2
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250812172823.86329-1-philmd@linaro.org>
 <20250812173234.86970-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250812173234.86970-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/13/25 03:32, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Another API PoC.
> ---
>   target/arm/hvf/hvf.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

I imagine this waits until accel/split is present?  If so,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 84c0c0275d6..df63584f456 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -17,6 +17,7 @@
>   #include "system/hvf.h"
>   #include "system/hvf_int.h"
>   #include "system/hw_accel.h"
> +#include "system/tcg.h"
>   #include "hvf_arm.h"
>   #include "cpregs.h"
>   #include "cpu-sysregs.h"
> @@ -585,11 +586,14 @@ bool host_cpu_feature_supported(enum arm_features feature)
>       case ARM_FEATURE_GENERIC_TIMER:
>           return true;
>       case ARM_FEATURE_EL2:
> +        if (tcg_enabled()) {
> +            return true;
> +        }
>           ret = hv_vm_config_get_el2_supported(&supported);
>           assert_hvf_ok(ret);
>           return supported;
>       case ARM_FEATURE_EL3:
> -        return false;
> +        return tcg_enabled();
>       default:
>           g_assert_not_reached();
>       }


