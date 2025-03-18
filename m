Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DC7C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 22:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tufh8-0006lu-Ah; Tue, 18 Mar 2025 18:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufh6-0006jF-Rh
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:45:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tufh0-0002gk-BB
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:45:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-225fbdfc17dso57240585ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742337945; x=1742942745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OYj2m8wY9HvQL8f9sPwRIBivPUDXh/Fmsum2H+ZPr40=;
 b=Xde6ho+mRzYA2jPvsvUNW2vWgUfHUFbw6ynjyb7hSGMAycv4v/nobkwzzKILiA9uSD
 wwpbjTz9X8ViRxoWvk0bwmqqlqHJsVKrAx1YFtby4muExNrAmRoflC7ZHWC6hxz3DOYd
 77Ewsrq8lAp72En1MtVSfG2x/aKsMOBMoKumG4gcCowwMVCjrpe+lLAVtTqcoompmIAV
 m20Ui4fOAAncFyiSnEg/5Qp4Egefp2tvPtp6tOfzSH93LHeDTHnEpILIP5g6SsahOAAt
 yhem5drfUL/9yAbArj4dPDHAAtwqU6Tay2wPx9DJvVfJ2Ppx897fj5LCn4g3qbrpofLl
 9OnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742337945; x=1742942745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OYj2m8wY9HvQL8f9sPwRIBivPUDXh/Fmsum2H+ZPr40=;
 b=fqpRdmOtWJGLQzriNtVOcLhJXxlLWnPIkr6fCBxBHNsGXzqMzRjM/J7N0ki+XVKgGe
 swVey/4OjT+wMDIm6w1UPC3uhf3/YZYXm9SWUjvLpWdpVehGu2oAxHh55hprmK4fgT+j
 fYjsbBR7hPRGnZu4xCYOkOXigV8icSuHXz1v4qbSKioQCIeUyQ77Wzduc9CfcG+tdlCb
 /mCw9dzmh59L6eoLXpaYjVx8Ub3lGLxbTqdNHEWBHEcvdAOteYqKA6w3tvJWlkWJQPwF
 guKY+8Uvbud5Ui7KTwTrO06quUUcNzQLQmZ0lmf88NvRTflcid8vPoZTSSX3GYVdH6fz
 JFCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHyGt7rUKjq6QJ70p1PW+hK453Iun0Lsnpu+lIEqZ5uv2IoCCHzMmScCQG5JP+BkqhXdqzFpQyDQSN@nongnu.org
X-Gm-Message-State: AOJu0YzYIdMOzRBc+z3+TL57R9oxO39/wgQhLYZlJtF9baso3Dj0HubA
 b8LPS7tDmfy8G6HgVIrJseX+imcuJDjozYH6kGk25G+UeCaHF1hxkjiCUt2N0w8=
X-Gm-Gg: ASbGnctG8/oEwcmjmxWnMSdcLA0oL+ootiPkstgMffIAao64euScHwG5fq0sGIvWfZM
 Sb8WIGhDIfL+OKJCYKiLiqHEZaC7qkovIvBXfLjb/na88ah2hx/bqX0D9uD8SESlCSEFgGZewt3
 b/hwxDzi6OXKjubYMccSaN7keneWxIlSrYAIhbEfudHKU2zlKIDAsgJhvLDxUrOEjmfWUavW62G
 83oWwFbc+yVpROVMwtHWhZKWRWlqN6SXyum14k3dp3RY6npFBzsvOfJUwXmh0ZRqQGcQhrgT7+0
 ydQZQkRt4LYTs9dCTOXueh+RR/A54ZHXw1sHkp8KzY1gcChnrw5co4Ci8R3M53opQKkYMGiwGof
 jCfFDW6QB
X-Google-Smtp-Source: AGHT+IH99wFLHvDNK9DJaCFMZ+buTxPrONpqtpx2Dm9CE5AsWM3wvi5vYKeaIugwzTzbLBTrpVb69Q==
X-Received: by 2002:a05:6a21:a44:b0:1f5:873b:3d32 with SMTP id
 adf61e73a8af0-1fbed503e74mr557864637.39.1742337944753; 
 Tue, 18 Mar 2025 15:45:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea947afsm9656324a12.71.2025.03.18.15.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:45:44 -0700 (PDT)
Message-ID: <2b438e13-b377-4b4e-a4ff-0b219d7f3964@linaro.org>
Date: Tue, 18 Mar 2025 15:45:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] target/arm/cpu: define same set of registers for
 aarch32 and aarch64
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-11-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250318045125.759259-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/17/25 21:51, Pierrick Bouvier wrote:
> To eliminate TARGET_AARCH64, we need to make various definitions common
> between 32 and 64 bit Arm targets.
> Added registers are used only by aarch64 code, and the only impact is on
> the size of CPUARMState, and added zarray
> (ARMVectorReg zarray[ARM_MAX_VQ * 16]) member (+64KB)
> 
> It could be eventually possible to allocate this array only for aarch64
> emulation, but I'm not sure it's worth the hassle to save a few KB per
> vcpu. Running qemu-system takes already several hundreds of MB of
> (resident) memory, and qemu-user takes dozens of MB of (resident) memory
> anyway.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/cpu.h | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I think this could easily squash with ARM_MAX_VQ, since the
rationale is better spelled out here.


r~

