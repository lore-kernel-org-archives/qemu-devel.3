Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D5FC282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 17:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to41s-0001nS-4p; Fri, 28 Feb 2025 12:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to41p-0001mA-KL
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:20:01 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to41o-0001kC-4R
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 12:20:01 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223378e2b0dso37151295ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 09:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740763198; x=1741367998; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZqORKnWbtzueHGGbT3XFQ/xR5jC3CLSAIiDEe+l0q+0=;
 b=ps+qj7BOBk+e3wfJf2sQmIpH6gf73L2tB6Ge9AYSo4W6z4oanmRqTsEHidEwP/0h+G
 9jmOo00WjBV7IS7xvnMq0BgZIZH7pLNscoJ8z0ZJohymduSFDUB8JicnUenA+7ZvDaFU
 w6goD98ibIqzE+S7vhW+iHLlKWJjiuvX8AAQrk5YacwygDOpzV64083RhgeFO5ABYdhn
 1Uf/8tO/A+x6FTpRfYzC/m8mB0GNTi9CnyURpJoYerrr4i422VdfAQlRWvlm7Vk1aph9
 6EHflC7XV+CnNPvSQIZSTdkKF/9mvLUpwu3THDXMGV4LqDVwaVHwD20iQNxmujPFCIGq
 TLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740763198; x=1741367998;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZqORKnWbtzueHGGbT3XFQ/xR5jC3CLSAIiDEe+l0q+0=;
 b=BV+Le1WePgmjon3QE+HMmQnflAS/mcnyVoI/TqlrJe8ZG+c+89oB+XWwMPOYjV8q8E
 ScB3wCFnhwQ8WmwnBky1QY24U0nTqKbX724+T4D4VYK0z5XOIMWbDSqECaiG/0/Z0bWH
 h2IToBi/NYnHFqkjNHnSUwzrXVWG+XHgTQPJrZbKtyoLon8+OK1Jfvxly1h268n7e93C
 cPNmnrZVuATRHvxWziETxCSQOt8+RUlRXR2hRO6EyLvWyPSQgVvygp1w4hlv2sQWKwpb
 VnNRIAdqKyoImJ+Nhf2/uEEqXQRlUi9EEhCaNCBhXtLsEeM7NCw7da8fs0WXU/NLIHRc
 m2ug==
X-Gm-Message-State: AOJu0YyR3njfRpHofDpKfLzroH3LCCTzzizbWyEQzFdtrDVzzIhMcP4x
 YfsyLI742fp97dMT4sJeZmb6PlEZmoWUeQl9+hlv6FC/80phIwsLeVX9YBWIUczmAsCn2DfIOpV
 a
X-Gm-Gg: ASbGncvzKZa/eqtxL8kwzNy+5QhFG1HfRatOdIWUPLqvdvHa/5gGXkdBn57xm5C1ff0
 UzpHINxOwqoTlf5wvS/JmWYVUhw2qjNiLKla3eCDiiwaoPESGr/GHpOndmvWYg0hAo0Xy009J30
 0VwO2vHeHtvRoi+V4mwvL2mvOTvzVbCbrO9QaXPJ41ou+e+X4VK03GgWweeYWj6GpafFCzzlKM7
 bBCISC5LslIr5S+Z6BzefR98gb8ehusSJeezSeTP4CaiPrf+S+4z/bprN8NJnTxb3K07N7Y9mh4
 +iN91Jn3NZK/BD/U7t7aQ95E1pdMFpQDHwaE0zIY4M5qMGUVPu7f9P0i9SCeS34v0PM2fwyngve
 4cYk91vM=
X-Google-Smtp-Source: AGHT+IFtr3wOiADT0HdZF4p38NeBMmhAT98ti+I19MSLw5p8YsSwA8jzrJldrRqtNtMgrB572KIS5g==
X-Received: by 2002:a17:903:2ca:b0:223:619e:71e9 with SMTP id
 d9443c01a7336-22368f6dc5emr71836155ad.11.1740763196779; 
 Fri, 28 Feb 2025 09:19:56 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22350515135sm35996885ad.223.2025.02.28.09.19.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 09:19:56 -0800 (PST)
Message-ID: <fcbb2ecc-4611-4ef3-b86f-d77965730daa@linaro.org>
Date: Fri, 28 Feb 2025 09:19:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] target/riscv: introduce RISCVCPUDef
To: qemu-devel@nongnu.org
References: <20250228102747.867770-1-pbonzini@redhat.com>
 <20250228102747.867770-4-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228102747.867770-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/28/25 02:27, Paolo Bonzini wrote:
> -        .class_data = GUINT_TO_POINTER(misa_mxl_max)        \
> +        .class_data = (void*) &((const RISCVCPUDef) {       \
> +             .misa_mxl_max = (misa_mxl_max_),               \
> +        }),                                                 \

Drop the extra () and unnecessary cast.

     .class_data = &(const RISCVCPUDef) {
         ...
     },


With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

