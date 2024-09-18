Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D93D5CCD1B7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvWk-0005wp-TN; Wed, 18 Sep 2024 10:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sqvWd-0005vl-3W
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:19:25 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sqvWa-0004xo-Nn
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:19:22 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8ce5db8668so104703466b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726669158; x=1727273958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aM8gjwf3Lk/C8mpbX+e1LkgG/VFJdpCI80PWonoL+Uc=;
 b=RVWlJeQloamduk+rul5d/sNAHdqMYJHCIwzvjtzlrWO81FfBja1Vrsuo7ssotkgznt
 /O++bAEr2MZaZ3xwLAQcwg5ZJw66UURQ46RoYjjp5qdIpDqRMpBYM/MvXUJkrTUhz+oT
 okmiEL2xxv1o3OwhVFhLVBWulQF6ZOMxszeGYT9Nxo36d/hyifDm7x59FBPSzOS/NxBd
 7M9iO5KrbIgoInPb8iRFPpJeFUGy83PdnX6vA2UomZQn+EoAvv1ABNjnfMCnten6s46s
 Z0n82vDjYsolgFrDTUpd6cub0OsFGL4pWo6Ldnn52jIxF6g1vR4h7W18pul5Wx/E8zeE
 zelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726669158; x=1727273958;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aM8gjwf3Lk/C8mpbX+e1LkgG/VFJdpCI80PWonoL+Uc=;
 b=LhfeHHPK+DcX8jHejic9uPnz3oVsez3LJfYCvBvEYeK2atEF7lO29sjgBVcnFV/Lds
 NTuzoLp23YM88td3AVPoTJhA96sRt0cUna6+yE5rW8pWE7lDADip8TO/EgVGoHEvxz4r
 rcRXm3icc9mt/ToGplN2S7TzWx/l/aZFCtVpOCPxvGCy4wh1vWajPHwCarsJvyknAxkU
 zscrB0OnCLD3FxaM19gM2EY5z4DWC6ktElqM61zHzSxu95itl5SLBUypHF+QcfG1DRpa
 pvW/Wuv9w7HPY4Ovouw5f2s6+X0oTNrEZHANp2iKyBRRWkrg6PhbY9fTAD5vfWJP05ZW
 d6Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVmJFTk89dJba1XSlE1vSblnNIlVmKgG9gFwtGPUR2JL4dgJH2dndNWYjBvqAelZDhShErbxlkFmPT@nongnu.org
X-Gm-Message-State: AOJu0Yx9+xGWbdncHNIZ5f3R4rLZPSfUoMRo4rIf9JpR0kP5ogCEU7J8
 lrglGJrCwBJv2czFghuaXZDzVzfU/U24odDERmMUhLEGLQXT2bL97m/m9Lv+efw=
X-Google-Smtp-Source: AGHT+IFnJVlJzxndldxEnz9qlmu/DP48j1zZacHkuPV9APlfE0bI5xtYyeZvpjl/ZEP3/VtnjcBDbg==
X-Received: by 2002:a17:906:bc11:b0:a86:68a1:6a08 with SMTP id
 a640c23a62f3a-a902948e84amr2284129266b.29.1726669158060; 
 Wed, 18 Sep 2024 07:19:18 -0700 (PDT)
Received: from [10.133.7.245] ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90610f3ae2sm592987866b.76.2024.09.18.07.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 07:19:17 -0700 (PDT)
Message-ID: <c8902f79-0094-4821-99ab-ec0eba5e870d@linaro.org>
Date: Wed, 18 Sep 2024 16:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/fp: Make mul and div tests have a longer timeout
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240917141641.2836265-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240917141641.2836265-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62b.google.com
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

On 9/17/24 16:16, Peter Maydell wrote:
> At the moment we run all fp-test tests except for the muladd ones
> with the default meson test timeout of 30s. This is plenty for
> most of the test cases, but for multiplication and division we
> can sometimes hit the timeout if the CI runner is going slow.
> 
> Add support to meson.build for a way to override the timeout on
> a per test basis, and use it to set the timeout to 60s for
> fp-test-rem, fp-test-div and fp-test-mul. We can use this new
> generic mechanism also to set the timeout for mulAdd rather
> than hardcoding it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> On my local system these tests finish in less than 5 seconds
> each, but on the cross-i686-system CI job they can take 5 or 6
> times as long. Example:
> https://gitlab.com/qemu-project/qemu/-/jobs/7844908223
> ---
>   tests/fp/meson.build | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

