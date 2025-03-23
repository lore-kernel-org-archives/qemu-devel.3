Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3FCC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twRL8-0005Kd-3Y; Sun, 23 Mar 2025 15:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRL3-0005Im-Mv
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:50:30 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRL2-0001o6-An
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:50:29 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-227b828de00so4625585ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742759423; x=1743364223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p4xRAN0m6ZdO4gtnL2+ABu6HfCfeJ4P1/qPsWE+BDIw=;
 b=DMourGWoFxUM6frQhMSgfLzBBXV5p2G2QQNoYZJlvDhnbHL1TeCP+wrFLgMfYA8pnq
 bVD1dfS8Z82Kiywm1AFo68noOKJ+0OOo8LTBsTEU+k5HWy3vSA2tcAQbvfj+Bo93aqpr
 ikB/YJrD1GxkhrkVNcyup4mOMUG/vELBuf5IalBxdq6RJBfo+XjBhukluxr/hxWP85Bc
 8S4zWTLHkw1qTs4VIfVqJAV6UIhA6Puwerqx670ZnfyuSqXeRx5AfFe9XIC3sjyARI4A
 LEV6rSrEFfvntrrLNmkzhPJWLJuyzMuByYyMiZW60LEGsR5Mq9WubHhXhi6BcOfYmAgR
 XKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742759423; x=1743364223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4xRAN0m6ZdO4gtnL2+ABu6HfCfeJ4P1/qPsWE+BDIw=;
 b=gD06A/4Xzw3ZaUlH8x8MVDGIZ8/o1DME9KEQ7jaVCUOtTBl4Xld50ZnYfdvRG8uVf2
 MFes0doBUEHXJilNduRBMH4kir5NJy6UjqNkpUKOYgEn1Vr3fMAoJBXQu60sLeQiVbbN
 BcYKyFoHlq0xtQmTIJXiQcAKSMeusnZb8anZS2JTHZQnVSVfaAJt9PHsoFZLox296ak4
 qfmE1Z7UX8scENolf9ce3aX3s7D3rNocSZaMuJ9UR4c4XanK7snulTa7Aasb5Gz0PZp2
 tM7WmcKYD168UumjS94ZDDrOQwt+LNYx+sEcVTsSZ8Mz0FvMzFVc9Ay7AyDaXzzowUe1
 CtSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoqzkJYu1c9L4bd8LRaOuK41pmkagLrkwgHJHznrVA+T4xSzAagK1+LWjI2WeZhH+tgoRU8NWgaY68@nongnu.org
X-Gm-Message-State: AOJu0Yz9xtW4lsK8bOMWp6qpFxH226lccq2kwyF4cQKWVs4nMgXKNo7f
 1r3opwXNvFKKWYT9Rk1dIOJ73xHm9Tch+TfL+DZhRbT2euU54lC+XCL0I8nL9B0=
X-Gm-Gg: ASbGncuo4b1LkSKx/C4bEFAroDLQKdWuigUtDkks74+cMyvONNgwtWrmSNSVGIoJOhJ
 2xAK4jydVKVtFaaeHFyyHa0pPLuxIn3cfPGqQfNjydIX5OmIL5OzolI6dFGWLE1k5rEMKJpzYpk
 gkFi49EoeO6F7RRItLeXEZFsBU6nqg2WBWq4ZH/QEdxqvCzW1GYx3svvB3YgIFaUzxpCgPiXL/9
 XrMNo8+IxErAa2fEPThg97Sb4gR5ylw9aTbbDq3YvS57blCfjWrpvpw/rWVDY0H/n1DBO6JBwiy
 W3OItrLfbtoo5RT/dncEplHzx/ojaZe6iyyODw2PormeWvMViUVdbZ3/gV9oj6YCq1RscDOroCd
 F3DC1E8hhK6fIgOsu7WM=
X-Google-Smtp-Source: AGHT+IEoiDtt6a1ykboyilBoUshUC/k+wEAxCTAGIoHLpjWxBrvqlCRFeDRuXaIruzZ+uU3zM2Vntg==
X-Received: by 2002:a17:902:dad0:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-22780d80033mr180962705ad.21.1742759423505; 
 Sun, 23 Mar 2025 12:50:23 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da32fsm54954315ad.182.2025.03.23.12.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:50:23 -0700 (PDT)
Message-ID: <2a7a2a78-02cc-4954-85cf-b72f37678f36@linaro.org>
Date: Sun, 23 Mar 2025 12:50:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 28/30] hw/arm/xlnx-zynqmp: prepare compilation unit to
 be common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-29-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-29-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/20/25 15:30, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/xlnx-zynqmp.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index d6022ff2d3d..ec2b3a41eda 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -22,9 +22,7 @@
>   #include "hw/intc/arm_gic_common.h"
>   #include "hw/misc/unimp.h"
>   #include "hw/boards.h"
> -#include "system/kvm.h"
>   #include "system/system.h"
> -#include "kvm_arm.h"
>   #include "target/arm/cpu-qom.h"
>   #include "target/arm/gtimer.h"
>   

Is a better description that these headers are unused?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

