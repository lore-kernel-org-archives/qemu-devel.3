Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9863FC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWz1E-0001wP-B5; Wed, 02 Jul 2025 11:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz1A-0001u7-2a
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:05:00 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWz16-0008Gx-Lx
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:04:59 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2ebb72384dbso1904968fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751468692; x=1752073492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XsI0jXZ4ILb5VamJSwGUqa0HyuisamQfPMvj+g4Re0U=;
 b=yPXMRnDZPLxsrmWz14MCvvPkmaUzfjoDTUBrS2xuA5rBVPuOFDiNOERa/MojU17A1f
 EYywb4pifqXYCiLdM59cXHwM672MzroWDl28F5SBxU4jxWg9dbeg46d+0BcNWMdeSSto
 2qRnO2Cmm2yAwtZklN2bdKOiPTQ/PZDiR+s2zAWC/5gg1gAf2nBXSVP6um3DL3zV+Uox
 XqYQnk9w/XWsKhF+RTGqnsjruHyDZNmIlSn8Igvf8eQ9xA99jnzjbOJtKKE1aiqKb/uT
 EQVdcZ/EYa4WMC/T9oH5dhbQTwawCF+HoKjVCBZSDAFaYYqgZ/uaJiG3ch1zBux7GVsD
 jHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751468692; x=1752073492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsI0jXZ4ILb5VamJSwGUqa0HyuisamQfPMvj+g4Re0U=;
 b=aO629VR2xzNzBRjPzAeIYcaXjlNhtB+UiWIOaucQB2jyTFEujBSNegeHFS5aBrtLdm
 sQBIGT6YLzBO3Kdv6k5vAXAAIoS6Ssr3db+7Z2/2dLfFmJRG6MfnQVMUUSEsZpchDC2S
 H1bYR8fi+BnMSKmCwrazmePgDVv1XhoWX/cgpGYMgHaD/PTEy//+j4RXV+JPR4EY27TT
 GrLn4HfUlmXA3uJaF7gEmu/jZAa7sFFCrYFHMevSCc8mNEBOrayaq+C5De62g0dO55iD
 5SjXS6cr9MEsbFSp6Xn395GUoviQKhAL88GEj6toDSxBn0Cop4wMT7Gyf/tTQ9Gsfomw
 qa2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaZp0SV8fR9PFWaVd+hPwG3RWyeaV9boErJqoKoZ43EEhg9bqpZbPTaIOYMJEJaIQDb23fu0Ttn9ph@nongnu.org
X-Gm-Message-State: AOJu0YwYWcYlEO2cTVXADykuseeFFRyAmerIOxQXJGuRmSHZe1VKvnhE
 rpxzlEjbOSit/Ah/+PW+6SgTLCzB/ugfKZAzdtEi26vAKATYDPgs5D+8DGd9i4gmaY8=
X-Gm-Gg: ASbGncv9NyFCIZNj1IBch7dmxhWeFoR2E6dy70iYGR8H5QHGhw10CrQ6Sv5dLZMthlk
 jQR5WUbn9Wbq0j17l74mTsnNQRc8PiOOdaRsOpqwipJTIgXT31Yi6m4xsz/StHC2k7Ny8NOiK4L
 zOcstUbVgf48dNcI+BcmUPtXmMRxGQTXsA25NL32s8DzSjyLD5MDk8UdK+aw9Vr8RUkFN4V5Hav
 2f1WYq/08UrjTAuvP9INTZfOJvVDqBhBt1MHDLuQxt8+wk7bGsYucxy+9IGrtE2MO10J9LPcaeB
 BavS3+1HzNMfQXIGkkUpUZzcI2gbPU5SDOWARAO0P0fjkdAhPtRa/3JUY79bcmYQ9vXJqEIGR88
 D
X-Google-Smtp-Source: AGHT+IFZTsOCcvn0MXVClR6WOQ01ta+8VhI6Ew2yhvmfVR7+qiGzOr0DyPbEb5IPU6HT4gkepmetAA==
X-Received: by 2002:a05:6870:46a5:b0:2f3:9384:cf7 with SMTP id
 586e51a60fabf-2f5a8c96bcamr2168566fac.20.1751468692391; 
 Wed, 02 Jul 2025 08:04:52 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7f6asm3964672fac.36.2025.07.02.08.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:04:52 -0700 (PDT)
Message-ID: <06b83a6f-5380-480a-878d-2ecf5f503401@linaro.org>
Date: Wed, 2 Jul 2025 09:04:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/68] accel/hvf: Report missing
 com.apple.security.hypervisor entitlement
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>, Shatyuka <shatyuka@qq.com>
References: <20250701144017.43487-1-philmd@linaro.org>
 <20250701144017.43487-29-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250701144017.43487-29-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

On 7/1/25 08:39, Philippe Mathieu-Daudé wrote:
> We need the QEMU binary signed to be able to use HVF.
> Improve the following:
> 
>    $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
>    qemu-system-aarch64-unsigned: -accel hvf: Error: ret = HV_DENIED (0xfae94007, at ../../accel/hvf/hvf-accel-ops.c:339)
>    Abort trap: 6
> 
> to:
> 
>    $ ./qemu-system-aarch64-unsigned -M virt -accel hvf
>    qemu-system-aarch64-unsigned: -accel hvf: Could not access HVF. Is the executable signed with com.apple.security.hypervisor entitlement?
> 
> Suggested-by: Shatyuka <shatyuka@qq.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2800
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/hvf/hvf-accel-ops.c | 5 +++++
>   1 file changed, 5 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~


