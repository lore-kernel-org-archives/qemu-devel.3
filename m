Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0863C5DF93
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPzC-0004y3-PP; Fri, 21 Aug 2026 10:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxPzA-0004xv-CU
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:12:44 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wxPz8-0001F7-LK
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 10:12:44 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cf50c6f235so12950485ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787321561; x=1787926361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3r/6ghtBHucv2vu8ksKwmZ9j1U6J5MWtWjQ8RAimL1g=;
 b=eaMGz3ybum4K3Hh/lOYRi01vuXQvBvKBPf7rZu7Ui4kBiv+3wGz7j4ZgVS/zes4/Bb
 BAHu834X4MXjkaTeZrLZoV77kv7xbcLtXIRGYSAHUCPjEbPSLm+kS5UbU6TSJFG/TUHn
 zKc2+8g9wI/kzYQsrJqXkndWd1dS1XzXkRDhmEclN8t+l4QWWSuRJLT4eaYBI8kGiduc
 YC+o2f+wJAvdy8zktQErH5BVIVliXxJxs5NKTPuYdt9lWHN2aCZzRWMlumGl5HK+8uia
 GfMIPB2OfkYLOCPHCxGCbijMJ8aW2VPI5Ba/0isJ8WD4NLUopY5B1CosC15oerRgAWfP
 VYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787321561; x=1787926361;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3r/6ghtBHucv2vu8ksKwmZ9j1U6J5MWtWjQ8RAimL1g=;
 b=a8zlASjw+U3zX8QIYcuf+kFJWnKEc0mRi3+HTw82eTf1rP4W6/SmVsl9U5qKe1gP/m
 BoI4dsytzp2zLPKjh+qoFdaXSJYR69m3yMMIgf3Rg/4iFCzp1jfTwxFSgbRQWbxfq4d4
 1s/l0FpMS5l5oiiz5dX4JoAZ5R8nE7uq5eZggGpZfn1RHeplKAlRXNcgWEqRJYneHVxQ
 KPIc8otVAPeDgXgPd+XRipM00hC/Yfv7P4s72B41R5aUdFAWr6xID12DJZpOqGOHJimb
 gedhXnZdtgJd1utbhoRGi1ULdW7Nlo2BZmLJBIVmIa0H0TjwWx5NzmBdSkpPYLaXLz23
 jv1w==
X-Gm-Message-State: AFuF++k0+Hsq0/fogi4TMQTwfFD+Q7qzhdXV5sIshfrdaarUxkyTm0Sf
 EzLR605FgUjiLdas2iE+dMa6R3r0atgiy9WRUVe7iZtYNZ/Kr7xh8URi5E4YD1ZeXjsAn0kQC44
 l7i5i
X-Gm-Gg: AR+sD129jSspjwD0Adv/TF7CJP2KJ2i5/rRj2ddyIXIWq+nenrlETboc5HAl55ZoCG6
 EyzvL79ZjM8ho1n6l10SP2rlhytKO23QIvGGuU1pUejhM+8RJvgTtjLIPSudyGfaidGa6Y+thYB
 WcOETtbtu5k0Yap7IJIDzIqFS5tTTvlyMIEM3jA9jiBLPbKDIgUEmVue+h8mDXyfm6zP0W7VH8B
 nOPMdI3kwUV66Limy3qCrq8FLBoTnSaG33RXEArR3dA7zVfEF0fAgCxb1hR+pQvdZLP245bMpKb
 Hrz0wCpND2LtTP9b3MiBPFvCeCBr/5V1/8b2Jkxoq4lMxVxGTJma4OYJBDFx9RSxtJMQsv7hzCS
 bYnHkbIGBfXEDW+3IcEYOiELWyHBUlT3ysNxeVfYIdsMh+FmQmCx/AM1zNmo6E+sismmSDjpSPc
 JygPN9DbdyQ6rnerIRXqeKdzsGLutF5gJIsCEiMtO3OTcLzXqInTLG3hJvWacVgt19Y53J6LrMe
 RQh
X-Received: by 2002:a17:903:2b03:b0:2c7:f4bd:91b5 with SMTP id
 d9443c01a7336-2d64a9b349bmr136063865ad.0.1787321560945; 
 Fri, 21 Aug 2026 07:12:40 -0700 (PDT)
Received: from [172.20.6.168] ([108.174.179.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d62ec88ebfsm19409935ad.84.2026.08.21.07.12.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2026 07:12:40 -0700 (PDT)
Message-ID: <0b9848e7-8a9b-40ff-9707-73c511b095de@linaro.org>
Date: Fri, 21 Aug 2026 07:12:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't provide TLBTR for pre-v6 CPUs
To: qemu-devel@nongnu.org
References: <20260821120036.4161792-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260821120036.4161792-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 8/21/26 05:00, Peter Maydell wrote:
> The TLBTR register (encoding cp15, 0, c0, c0, 3) is listed in the v7A
> Arm ARM appendix O as being present in v4 and v5 (section O.7.1,
> diagram "Organization of CP15 registers in an ARMv4 or ARMv5 VMSA
> implementation").  However, it isn't listed in the v5 Arm ARM, and
> checking individual TRMs for the arm926, arm1026, sa1100, sa1110 and
> ti925 shows that none of them implement it, so it seems much more
> likely that TLBTR was new for v6.  It's also confirmed not to be
> present on a real arm926.
> 
> Gate the register on ARM_FEATURE_V6 being present; this means that on
> pre-v6 cores the encoding will fall back to reporting the MIDR (due
> to the CP_ANY wildcarding), matching the hardware behaviour.
> 
> We can also remove the "make id_tlbtr_reginfo r/w for strongarm and
> omap" code, because those CPUs are pre-v6 so won't be using that
> reginfo struct now.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/4207
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

