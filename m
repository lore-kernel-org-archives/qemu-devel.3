Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1192DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNV1-00084c-4j; Tue, 19 May 2026 12:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPNUy-000843-6d
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:40:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPNUw-0005oA-Hv
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:40:51 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2bd266f6fc0so18585205ad.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779208849; x=1779813649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z9EOHuMQ1fN0/5l8TzQ/RHCs46XJPcImQQNyGnMI3NU=;
 b=G234hMBlZgCC62r6t/39HJP75WjiGjiiZZ5saw6dVb2SHYjHwZjlDJFgw3k7SKFyqw
 Y5HojS9YTYXGC8CJKD9zCHBKv4r6emMpstpCOAGW1/6yfeYTdsfU4j7OjiaJl6Hunx9B
 U5lpqvCa3Hzlp3DBpE7dD7leFc3PbFfBglzPdSyrhGJg27RbK0r1bm9c3b/9LEvxyV97
 TD0u5iichg2SM4dKljBMaQCcDCTGk/CP+7w9eh+tnxtFui+Bj+R+yP35HGdWHiENALk2
 U/4eURqYuhFD26BsUo/7ZsdHwNVoiqOnLe4kZIDVRlKGigRafwtsyULKHUAS3PVbcZZa
 9ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779208849; x=1779813649;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z9EOHuMQ1fN0/5l8TzQ/RHCs46XJPcImQQNyGnMI3NU=;
 b=tOLqPt+dOl+1dZ8He0iYFoYJgTFb/aphUuWyjzQUWBcZyof7GM+9oXsAa7ftq3oMHw
 pwBIvczY0YAb1EPGZocDGfx4e1cyu4HKuC2OZOBGbmY7gZaQHqVFO55U+MExaAQ9XYL+
 Et1VyZx/17h1X033TSk7H0deRIduj9ETzbSvciz+w11FBJu62jvlzK4xzRMqbH4SL0Nm
 c1E4oesviYveqnIFF+5Weud+g/u07OL1Ef8wTJGDdduiewq/5U3iZL8gtytkvTWHl3sw
 bLoXYQ4Yy2aEv501L07+f34L9ne4dCTGJNXNogD0O9TsPcMdXM/0zyvoVQoR3lDaDvmk
 0/2A==
X-Gm-Message-State: AOJu0YxUlX8NDHE2HUZjt5EqIDHpW2l7xpNS+CfuHdJyqzN/sKoXAkBo
 DAMd3YEGqGNaydiBzCrIOSN4ccUdRzVALeP7fnZnM2ThGNW3EPAM5yrguGtlrlgNYgc=
X-Gm-Gg: Acq92OFF1fkSqfbsA+eWNWb9I51gxb0EOFlx/LT35yxTy6fAEyHSr/bKUPtEexBD2fp
 8Wk86auzXf+lOI+1qe0UjTI8B6fbWmXKsn5rHIjCpoE9dfySU+pxr0hCJsT+q88hKovjqd5+yoq
 dmmBEHmfvs6fBJbbAY/yhA+QyU5ZTzZtfj2+eFFdgmH8fu4fl4Oqa0mo57EAkPUGYyUZoE8kiSw
 OJHU1+sBorUdaT8Bc8UCtENeYDO9hpDFjoGw0l/6xz9XGy7lma9mDoVfnJUHq1IrCnfnZ+BOpoa
 R4bK1oq6CbF3zFCG4ESXeO7ort2y3qaWQFs2nhklW1heB2OpOhwgL7vfd+1T1UFLYhlwI3oDuA6
 C4RRL2eo3YoSDoDXvNq2bJiHFCrk6SjEK4B1YJM5jeaIoc7UPzkmjXvC/EmaMcQgclx8KuKDQ8q
 nk5WV9AOuwBbk4P+a7eH+b+7MUE6rFYVPAe7FL
X-Received: by 2002:a17:903:240c:b0:2bd:2439:25e9 with SMTP id
 d9443c01a7336-2bd7e9e263emr209751515ad.40.1779208848631; 
 Tue, 19 May 2026 09:40:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05f27csm187143305ad.25.2026.05.19.09.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 09:40:48 -0700 (PDT)
Message-ID: <922e46d5-f9f0-4839-a4d9-79d16450fe4b@linaro.org>
Date: Tue, 19 May 2026 09:40:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/63] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260517003002.321430-1-richard.henderson@linaro.org>
 <20260517003002.321430-4-richard.henderson@linaro.org>
 <CAFEAcA9SG47Nn=dijm8AHMFQzq7EG+=LyLkRL7UtYJsNBjfZKg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9SG47Nn=dijm8AHMFQzq7EG+=LyLkRL7UtYJsNBjfZKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 5/19/26 09:23, Peter Maydell wrote:
> Because we use either FPST_A64 or FPST_A64_F16 here, this doesn't
> handle the FPCR.AH = 1 case right. The pseudocode FPAbsMax squashes
> AH to 0, so it always has the behaviour of the "normal Arm" operations
> for things like what the default NaN value is and which NaN to
> propagate when both arguments are NaNs. FPST_A64 and FPST_A64_F16
> for QEMU both change behaviour when FPCR.AH is set.
> 
> I can't see an existing fp_status word that we have that has the
> desired "ignore AH even when AH is set" handling; a simple fix is:
> 
> diff --git a/target/arm/tcg/vec_helper64.c b/target/arm/tcg/vec_helper64.c
> index 2f481ac489..fc2566bddd 100644
> --- a/target/arm/tcg/vec_helper64.c
> +++ b/target/arm/tcg/vec_helper64.c
> @@ -8,6 +8,7 @@
> 
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> +#include "internals.h"
>   #include "helper.h"
>   #include "helper-a64.h"
>   #include "helper-sme.h"
> @@ -152,6 +153,7 @@ TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status
> *s)                     \
>       float_status local = *s;                                            \
>       set_flush_to_zero(0, &local);                                       \
>       set_flush_inputs_to_zero(0, &local);                                \
> +    arm_set_default_fp_behaviours(&local);                              \
>       TYPE r = TYPE##_minmax(a, b, &local, MIN | float_minmax_ismag);     \
>       if (!TYPE##_is_any_nan(r)) {                                        \
>           r = TYPE##_abs(r);                                              \

Thanks.  I believe that leaves nothing of value in the local = *s copy, since minmax does 
no rounding.  It would be clearer to have local = {} and drop the set_flush_* lines.


r~

