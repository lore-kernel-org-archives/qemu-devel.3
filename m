Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8E9C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT8aO-0002uz-5p; Sat, 21 Jun 2025 20:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8aL-0002uX-CB
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:29:25 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT8aJ-00044y-Er
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 20:29:25 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2350b1b9129so21957365ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750552161; x=1751156961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6cWYkdPfJ24ZEJ77Qa9kPyD3q6m7Fo+pVUIL8GxyhW8=;
 b=grvUKrUt75gUK9CKOgcuXHGj2B3Lt3OfUyip7PttchuBk+Kff27j74/fwHFzpwuSw5
 HDrJBCdmxPuDVExSdWkgxpi3Sx8vB8OGl7bSVh6RhzvzNqqeGP6tPFAONScdakQrDBkb
 r1Jls13A4eGMo5G8bLvLL0ylOBajHNeDeTYc2h3OCpbR4eu/OLrZjjli0yRxr8a8emS3
 AR17xP/jUxwE36R7od8bivd3TwKnhBrrIwDmg+/iK/jmH2qE3eMoCtEcEHnrdtdxTTjV
 xNdofJd0f8C2v99Q8WMpHY/oB6s/fqKpJvoa4/3TDxnESDYZHcC9gPoTsI6XE1eo+RQP
 mQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750552161; x=1751156961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cWYkdPfJ24ZEJ77Qa9kPyD3q6m7Fo+pVUIL8GxyhW8=;
 b=U8a3um+OVK+4z4YbK1+VUTpTDuwt1awAAWh7PdsVFc5wWQRbWYArvCec/xoqGDLq2Z
 nS+pX+MSR9bn1TEX2/UIGeFn6S6o1phvq/CgS4VdcLMvdr6lFLvO+YY/xwfBn79wyC7X
 /rmTDVPhuLi02pVE3hYnOVemd+gva91m4AOJnmk1WgVrAKXJGUsRTWVPUr7k38LwlUTW
 K7bF2sOReUIkNfg3mzxP8OUkmyh4vE9HrOM5lRK5GX0toDoLSuspV6uXOK0i5dVTFfwn
 w/kk88O6jc6VcUvag+G0Jxgw91Xr0uR8bJln0DUmkgMfyi14IzO1L7gbAP8DfC1TYHdS
 zyuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3ueSXFeltBreaZ+EPLAinbuf6TclX8uUus4RzzXQUo6PivFofDveK7ttEDu33qzj4PkRHkc14fMwd@nongnu.org
X-Gm-Message-State: AOJu0YwA5S8FAt3ztUhdFL/pmzzbGSN/q78qGBjYR5xqe+xU9v5KtoJR
 BebykaNObKUviiHnpR9lMg3aUthd9KMDwAIrlslP9iyi2GdV5Yq3webN3dMePKmvBeM=
X-Gm-Gg: ASbGncsjKZ55YsmKtlfeHxWWSES+LKHhag9H5f4XhpIar32UVz6miufkjlko9EC04Wc
 YqxFWjQKvqqgTlIhwOqJ3V9Lb+JycY8rZ49DnKdbb3xa6UHZR9pZ3iDcXK2m04wnIt4WW53pyxD
 HZWY1l6IOdE6uaaMcztOXfGfvC0wNJktT0tNPrF/yuKSp2rphJSx7ZhamDUdANQVVsUF6TuSHyw
 1BzEPsyifwLe50yV27Bf5nhhiYWUmIwldn0+Bm7quqYV6TcBXXZeQQZm9CP+st45oChZkbTBffi
 EYLo0V7AWFuJ9EFQLaIbaYDJf5XJq/RHkNq5vqNuPgsWnpN5NcN2mIpryhER5sdGLEux2o4uEqP
 ysRO3zN/GA9QkirhBtbETRegvEr+E
X-Google-Smtp-Source: AGHT+IEQaQTX+zKwqEdHUQNTOsmRvqFXt0DVol4H/7ZQUh7ZhXB1E233zgxNQberd58FoHmwc2tCSA==
X-Received: by 2002:a17:903:1c1:b0:225:adf8:8634 with SMTP id
 d9443c01a7336-237d9a78bdfmr127945215ad.51.1750552161460; 
 Sat, 21 Jun 2025 17:29:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d839379bsm50183115ad.51.2025.06.21.17.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 17:29:21 -0700 (PDT)
Message-ID: <1816cfba-771b-4504-9b54-ac104b734f6b@linaro.org>
Date: Sat, 21 Jun 2025 17:29:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/26] target/arm/hvf: Trace host processor features
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-19-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620130709.31073-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 6/20/25 06:07, Philippe Mathieu-Daudé wrote:
> Tracing an Apple M1 (Icestorm core, ARMv8.4-A):
> 
>    hvf_processor_feature_register EL0: 1
>    hvf_processor_feature_register EL1: 1
>    hvf_processor_feature_register EL2: 0
>    hvf_processor_feature_register FP: 1
>    hvf_processor_feature_register AdvSIMD: 1
>    hvf_processor_feature_register GIC: 0
>    hvf_processor_feature_register SVE: 0
>    hvf_processor_feature_register MTE: 0
>    hvf_processor_feature_register SME: 0
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I'm not sure why you want this? When you asked if you could emulate aarch32, I suggested 
you have gdb stop after the host probe and examine the values. I'm not sure why you'd want 
to keep this logging around forever.

Anyway, from EL0/EL1, the answer is no, the M1 only supports aarch64.

r~


