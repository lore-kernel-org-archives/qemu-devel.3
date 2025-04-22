Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1C1C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Hdz-0002eW-VD; Tue, 22 Apr 2025 13:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hdt-0002Xk-VY
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:42:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hdr-0000Bv-BP
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:42:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736dd9c4b40so131866b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745343761; x=1745948561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NPv6P4hx2abr9Re8JiOTHaGOat2sLpNrt01UEtdLYdM=;
 b=MDvTj44jsmkAx+x1n+7bxFGuVdlqr42qhlJq6tqYNJFEGjcsJnhyBPbkoAuhoOaG9R
 M9w36Gi2HDv98De3l40Kx1+XtKVmIefFdohsSJtswCTzhaHfu1kWdApe7rBJVNnz2KOv
 2BHEPqn+hueVMaZLjBaSGKpeS2VNMcuagmx5/ONpExKK9QLTqwr0Nawxktp3zbD7zIZV
 JoEDD1ZoDHkNjczjM7W/AsHQCyO6XPnBqfr83/g23w1xdU7bUwSYLdotLDydAAUD8gpC
 NXBXi4K9ZTdjB7h6Wu+zc+Yy6H0rO2mQ/pr1ZTjOywTlp+iuv7a5Sez1QDYE3+Wgq99Y
 AFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343761; x=1745948561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NPv6P4hx2abr9Re8JiOTHaGOat2sLpNrt01UEtdLYdM=;
 b=XFSo/tHHcHVFfPubbW0QDqcpzorMxmPp/GS4i0EGEJez0i54J4NzQWJRyQItwVQlEU
 VJD15sPP1XQoHDc1glHuqmF02jak3Y3SPwXlyITPxXn2W9p1p+HBHTBZeMKplCl9WZ+F
 N6xfFgQG5rk1ck5HMB2toQLff3IbYqKOXlr+jUMaDGZbGldAyY2Zf3499FHQTrZGG5Bb
 iCbCkyc54fn5JQLQp6PHdXPobaZRbnsMitmY0+Herx0b7OCjz1o1ojP4sUgpDmgAaJUU
 VgUkwD7DWI0UQAIRlPry7/QuWjuP5BbCoKl9vljnwXMj2ang5Omz8EmI1/TM+1pYM6F6
 v1qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD8JjkvqAUYNzddyMrfxkyIRl3UeF9JRmBhHejqLf7VfJYiM1vLU2totL/LYzN+dz4B7LlULp0Wd2t@nongnu.org
X-Gm-Message-State: AOJu0Yxpre7RHLq+mA+bm/QRQ7foaknkr9dToPSb2cFRMx32P8NVRMWg
 J+bE8f1SCdUFYJSkIobOIE6y7Tas6MAQaIfbCSJtVH3JdSvHXybBklRYB1s6uHE=
X-Gm-Gg: ASbGncsiN/nskb87ZvStj/YBKKLGlwUibyX6oWFLMfCxi9cOfmf4zRZRqUsMS81p8Rl
 hW6OZUVsEfmAwD78LzKdi3x6lBDB4u4EUnAGf/XIIuNFC+tXV9pMTh4NG1ow8wmz0EhlnCCnUkf
 9Vz6ZCYv2umLBUfsJw4osQks3kOhCQ9IDaCErFHb5HdsqwOw6qG/WH9ik9BBEsWAtz19u7P9HS8
 MHSFOao6toZT9Qya+o+cnXe//Dn3DaGDkiVBCeqNxRHR2m3a57/y+jERfh0ZLCxT6ZAjmrusxiY
 9IM7XsXYdm11z+I7UfPlXsuhpq+560CbdnHF9oHBQtGSSRbMjx9YBgEPw9iZAYLcyOKL+PnBumA
 xNYVedog=
X-Google-Smtp-Source: AGHT+IEpGWWig8+B+Y8d8KyGN6jiHVZc3sfZV0XCAPHIzWl6UMeWHZw3d06KcEarr/AkHe9fVZDHxg==
X-Received: by 2002:a05:6a20:12d6:b0:1f3:2fde:8a6c with SMTP id
 adf61e73a8af0-203cc5a76b1mr22932127637.4.1745343761351; 
 Tue, 22 Apr 2025 10:42:41 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13c93b9sm7674770a12.36.2025.04.22.10.42.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:42:41 -0700 (PDT)
Message-ID: <592db5c0-4ce8-4e22-8eef-b6f6e01b946f@linaro.org>
Date: Tue, 22 Apr 2025 10:42:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 09/19] hw/arm/aspeed: Build objects once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Now than Aspeed machines can be filtered when running a
> qemu-system-arm or qemu-system-aarch64 binary, we can
> remove the TARGET_AARCH64 #ifdef'ry and compile the
> aspeed.c file once, moving it from arm_ss[] source set
> to arm_common_ss[].
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/arm/aspeed.c    | 6 ------
>   hw/arm/meson.build | 4 ++--
>   2 files changed, 2 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

