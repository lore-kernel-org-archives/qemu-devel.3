Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C7D58067
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXO7-0007Rd-Dm; Mon, 25 Nov 2024 06:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFXO4-0007Ql-5g
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:36:16 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tFXO2-00047L-DT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:36:15 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53dded7be84so1662764e87.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 03:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732534572; x=1733139372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OMOfnYWg6EbT/cfCspXM5gy4/HmZtBJD6xZVHRWc1Y8=;
 b=R+Fu1Chs/O0eGTFl2l2tEqzFpNJLwat4gEYGfwFUVgADxNmzgF3Ivog8TIufpvTcGe
 FpO/0Ajf7j37aP+TZ7mJmdaRyO64cXw09ijRgVg+zLUvJIN2cubLlDBqh8RkPdOnd4XD
 18Fn1uDrWPX+azwJXSnwKRnnuwsIb498atPmb57uDjLDC4nfedEfNcb66GMmVzlb+OwG
 BWzjc9Uc+pkf6j+dGV67zN/Mt52T1gLTjFknfL/MpIVkXgh28Bd5cLAEIUSOl7c6IQyF
 aJwpxlq2cdoGqLSQ/1dwVoKysqkn32I74qlocp7ntdHY2e4SECsXyiQgoK/d760/SkYx
 P0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732534572; x=1733139372;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OMOfnYWg6EbT/cfCspXM5gy4/HmZtBJD6xZVHRWc1Y8=;
 b=SzuRfzJKzA6/TZltjOQB77usawWdX4asuBUb4+hd3JLlZibylHm1o76yTWZuNu5e+C
 gmIe7xTGJVO6C+yPHd4VVV+ea7k5gR2+1gSmvPno32zX8lq8PuQZqDwMHHd4PXi8qjr1
 /LWz8bar8MbhcbOGOIPN5usptON3NMJJzXrUK0lbmSjEqnfTMB9jcoV39tCNjfsukjRl
 n4ofNOoQGRaT4yKk1yNZAr0pN+1Mj0O9tPgEMGiKr4mJ3idaF5djquPRI4YKGu3MEJRM
 Y46mhbJZZv5HwndBPwVM/3+GejjkUZ4xKHVny7MxCY72IOTDjiLa/8zjV1EGbUEZjpsY
 +lZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd1vUU68Mn35A849DuEVqzBRt/m9X32RV2HnNGCzMuf19DVtrwqEyjzfG1FbhkzAWnDxFv7sbLxGKw@nongnu.org
X-Gm-Message-State: AOJu0YzHxDjcXvSdlaT8/l8CBrdN34XgNTj4A1YYWKjPkswK0c/ekEaX
 ZWpfp7IKAunooVpvPMjDreRljytPjr2/967xDCdCfgC8gorMI+BbeEoKejwam+I=
X-Gm-Gg: ASbGncvMOCEP0jlOMrA6mWRzG4V7QXtKcA9ame/u9pYkr/T82gtR28LjfUREpUS9C5y
 lYoW+lBVxhQzsy4JJk3grXrchPCV1lXXWNl2M66Alws+r6QO4NjIBbgFv2gTNeQ9AG0TiF7xSHX
 8HsfgCVb/2nEjuXCefmoL6SWjpu/GtOi+c3/DaLQeDUCQ87lpnxKjgc6H75czEyvojIpCOKvB9p
 /gBp2IUVACCMvtdnGL6j4eV6OzqGybNOvV1yYb1HVl7GMrIMaGB6onhClvKnbiOSg==
X-Google-Smtp-Source: AGHT+IFG62L3mMQ7lxw+2sWhWpA5kZN6lgLdlt9GnwvYWM1VR1/9Y6Cg/re2yhgqAYrQ/wu0s0nzsw==
X-Received: by 2002:ac2:4e08:0:b0:53d:e5c0:b9b6 with SMTP id
 2adb3069b0e04-53de5c0bd2fmr935325e87.44.1732534572359; 
 Mon, 25 Nov 2024 03:36:12 -0800 (PST)
Received: from [192.168.69.146] ([176.176.170.239])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e1188sm195824415e9.1.2024.11.25.03.36.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Nov 2024 03:36:11 -0800 (PST)
Message-ID: <30a70eef-01ac-46a2-8e34-458c579dcf27@linaro.org>
Date: Mon, 25 Nov 2024 12:36:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 37/43] target/hexagon: Make HVX vector args.
 restrict *
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org
References: <20241121014947.18666-1-anjo@rev.ng>
 <20241121014947.18666-38-anjo@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241121014947.18666-38-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 21/11/24 02:49, Anton Johansson wrote:
> If pointer arguments to HVX helper functions are not marked restrict *,
> then LLVM will assume that input vectors may alias and emit runtime
> checks.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/mmvec/macros.h | 36 +++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
> index 1ceb9453ee..dfaefc6b26 100644
> --- a/target/hexagon/mmvec/macros.h
> +++ b/target/hexagon/mmvec/macros.h
> @@ -23,26 +23,26 @@
>   #include "mmvec/system_ext_mmvec.h"
>   
>   #ifndef QEMU_GENERATE
> -#define VdV      (*(MMVector *)(VdV_void))
> -#define VsV      (*(MMVector *)(VsV_void))
> -#define VuV      (*(MMVector *)(VuV_void))
> -#define VvV      (*(MMVector *)(VvV_void))
> -#define VwV      (*(MMVector *)(VwV_void))
> -#define VxV      (*(MMVector *)(VxV_void))
> -#define VyV      (*(MMVector *)(VyV_void))
> +#define VdV      (*(MMVector * restrict)(VdV_void))
> +#define VsV      (*(MMVector * restrict)(VsV_void))
> +#define VuV      (*(MMVector * restrict)(VuV_void))
> +#define VvV      (*(MMVector * restrict)(VvV_void))
> +#define VwV      (*(MMVector * restrict)(VwV_void))
> +#define VxV      (*(MMVector * restrict)(VxV_void))
> +#define VyV      (*(MMVector * restrict)(VyV_void))
>   
> -#define VddV     (*(MMVectorPair *)(VddV_void))
> -#define VuuV     (*(MMVectorPair *)(VuuV_void))
> -#define VvvV     (*(MMVectorPair *)(VvvV_void))
> -#define VxxV     (*(MMVectorPair *)(VxxV_void))
> +#define VddV     (*(MMVectorPair * restrict)(VddV_void))
> +#define VuuV     (*(MMVectorPair * restrict)(VuuV_void))
> +#define VvvV     (*(MMVectorPair * restrict)(VvvV_void))
> +#define VxxV     (*(MMVectorPair * restrict)(VxxV_void))
>   
> -#define QeV      (*(MMQReg *)(QeV_void))
> -#define QdV      (*(MMQReg *)(QdV_void))
> -#define QsV      (*(MMQReg *)(QsV_void))
> -#define QtV      (*(MMQReg *)(QtV_void))
> -#define QuV      (*(MMQReg *)(QuV_void))
> -#define QvV      (*(MMQReg *)(QvV_void))
> -#define QxV      (*(MMQReg *)(QxV_void))
> +#define QeV      (*(MMQReg * restrict)(QeV_void))
> +#define QdV      (*(MMQReg * restrict)(QdV_void))
> +#define QsV      (*(MMQReg * restrict)(QsV_void))
> +#define QtV      (*(MMQReg * restrict)(QtV_void))
> +#define QuV      (*(MMQReg * restrict)(QuV_void))
> +#define QvV      (*(MMQReg * restrict)(QvV_void))
> +#define QxV      (*(MMQReg * restrict)(QxV_void))
>   #endif

Maybe we need to fix scripts/checkpatch.pl along?

ERROR: "foo * bar" should be "foo *bar"
#31: FILE: target/hexagon/mmvec/macros.h:26:
+#define VdV      (*(MMVector * restrict)(VdV_void))

ERROR: "foo * bar" should be "foo *bar"
#32: FILE: target/hexagon/mmvec/macros.h:27:
+#define VsV      (*(MMVector * restrict)(VsV_void))

ERROR: "foo * bar" should be "foo *bar"
#33: FILE: target/hexagon/mmvec/macros.h:28:
+#define VuV      (*(MMVector * restrict)(VuV_void))

[...]


