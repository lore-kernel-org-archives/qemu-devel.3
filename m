Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D38103FFAC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 22:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw69I-0005So-1j; Fri, 27 Feb 2026 17:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw69C-0005Rz-Bk
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:17:23 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw699-0007OQ-Uv
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 17:17:21 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso20774275e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 14:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772230638; x=1772835438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dkFgE16pj0Jxn+bB+3mypHOk6ju2xpXTgx4Zm4nccbE=;
 b=sXt5JQrNmnHwaV/ofVcoFXq1Xmqx4UMCWZeCkTNqkSCVfCDpaPofAhGtfzgkCUpSQe
 bI6OY6z+5QBUiCRoQ2YbSnyBLhyZlYVkpix/RKnqvlXgtrdsEHF6X9Hs48cYUau3t5+L
 xMEmhrSAe/g6upQcIZOc/UO1YIJUErFtAyEXlqbkwkpywl/ynY3SuijInkcZHzMTVGqv
 Br8V23CFT7L4Uvv3n289FMHsG5MB7VupvPQ6YbnhtKBxnzs49xvWcVpQm7B2GqAiXuai
 fwuq6WecW18Ok2PlV+eCyyqsfpLlXqTwxZe2FC+9P0nuF9iTb4ZXEVx5bWfqwgBJdkaP
 XBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772230638; x=1772835438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dkFgE16pj0Jxn+bB+3mypHOk6ju2xpXTgx4Zm4nccbE=;
 b=rFuyQ/UTzQRHzeV34zm6pAMkOpqUsrxz3Y0R/H1PrZ6553BTjTJTQ0H4D85o+u3Vsr
 yab7CFvBkl1vPMMV3MFPBzySexX8Q/+2tnPOuzjsZOnkHi56tED4XCk2uk2sdeZ3NBKx
 t9enSyCBkyXCYc71SaGJsmetuMarnfgCPG/cj4DwLC58oC5BuklSebOcwkUMTWq48rJu
 ULNEayUw73YogigEh6nyyIV+hl2esMI4FG5hrvw2DAHhgXx0XY6Dq7JsL+qbrbmZh3U2
 lomdOq0+ZDUODK+Kln93x1K8FGHy2VeNR/iCSNlSqDbj/eAXUKQqRMp6aE0E5pYk6KAZ
 +Jeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYkqFHncF9AQR+wFNFmQmji3JrOnp9DNlags0xZPc0NrO74kPFzfvouAqLSu40h6RCYUy+peqSBgn0@nongnu.org
X-Gm-Message-State: AOJu0YzAQ0sgwAN0lL6dfSs2sLzyl+KjEl5h21FBIjoFmdGBYp+Ck18j
 EUActFMHNlgmqBAuZbbRdDrtRKA/pTTbDMz5mJ9jSDEX4GswaQPbrB+8nbxVOdWnSh987w7dfxK
 /oXX76DQ=
X-Gm-Gg: ATEYQzwuvsu3Y8tBp390CRlc93ap86LmVCJ2F8UA1Vtd+09CKmOietcc1ueisptkqjg
 mNSdQz/6al5eszNKRKrquH5JvYJG4L7Ix3ZbrqDrP2X9PwbfrQBpS/IlrT1MNEo1f+04od+Hw5N
 kGda4F3XlH/uHlnDfJ1WL2vRroJOcXUmFAbwD/Tn4/xl+MmAaTSU2EL3m9u5+OhOlSoS2lTjZeF
 JJ3ug52CPGo0n43zCYfi9+ifQN6WuqgoJW8p1Yb0owjoUxLOVsQs3WIB9e18OTHHGyCZVkJbH5C
 YKtR1RqPtTAW4tnJpmYb4eWH4xPZm12LfNFX7FGQK5eg35+LuFLeYKhJZK2noB/6y5FTjPPAIGG
 k2/DNtdDUX1hyllQ+FARThumjpwCKiyjwSX2kDuk/F2uymluh5ijLCOOGDrNIyAdy2Ab6WmwUD1
 phX4DmP0dURhzdUblqT7kC54Ta3yKSx0wskysuQol6duD+9/hFwoMlZy7enCgT7ozRgQ==
X-Received: by 2002:a05:600c:b86:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-483c9c18e4bmr77313785e9.35.1772230637937; 
 Fri, 27 Feb 2026 14:17:17 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b89c99sm130939255e9.15.2026.02.27.14.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 14:17:17 -0800 (PST)
Message-ID: <0f2abdd3-9ff1-4c61-b02d-f31c4ae5e651@linaro.org>
Date: Fri, 27 Feb 2026 23:17:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 32/37] target/hexagon: Add a TLB count property
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, matheus.bernardino@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 Brian Cain <bcain@quicinc.com>
References: <20260227203627.932864-1-brian.cain@oss.qualcomm.com>
 <20260227203627.932864-33-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260227203627.932864-33-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/2/26 21:36, Brian Cain wrote:
> From: Brian Cain <bcain@quicinc.com>
> 
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/cpu.h | 2 ++
>   target/hexagon/cpu.c | 5 +++++
>   2 files changed, 7 insertions(+)


> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index 968df1b76aa..a8904b651ac 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -23,6 +23,7 @@
>   #include "qapi/error.h"
>   #include "hw/core/qdev-properties.h"
>   #include "fpu/softfloat-helpers.h"
> +#include "hw/hexagon/hexagon_tlb.h"

This file is added in patch #34 of this series.

>   #include "tcg/tcg.h"
>   #include "exec/gdbstub.h"
>   #include "accel/tcg/cpu-ops.h"
> @@ -50,6 +51,10 @@ static ObjectClass *hexagon_cpu_class_by_name(const char *cpu_model)
>   }
>   
>   static const Property hexagon_cpu_properties[] = {
> +#if !defined(CONFIG_USER_ONLY)
> +    DEFINE_PROP_LINK("tlb", HexagonCPU, tlb, TYPE_HEXAGON_TLB,
> +                     HexagonTLBState *),
> +#endif
>       DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
>       DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
>                            qdev_prop_uint32, target_ulong),


