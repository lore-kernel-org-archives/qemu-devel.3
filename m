Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E73BD69113
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 14:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGfEW-0003Zt-Fn; Thu, 28 Nov 2024 09:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGfES-0003Z9-4i
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:11:02 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGfEM-0004Iw-HD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 09:10:55 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ea6b011b27so960543b6e.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 06:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732803053; x=1733407853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptky6Rhm6bxaDAiNB7LggL4vOL/natgxKCtj1JtuPi0=;
 b=L8OAUZ+iJfpSFmtsNs/4yGhwlK0fPkupNmnOvSyOcv/tjCN3XlEFxhKy8kS857R4ib
 zGCiw8MZuEV3KgtqfuJTgmDK3FPyM0aY7vSAffIjpxAloRsM/S7pZKXASNxxfK6lAw7e
 zKyjiaZKa8UWBvORSBU0c+OfAbyL5mGn7/qcFw62fQ/mltbndwZJ2kELesXYhT//VCq1
 h/DEVfliZJhFzOifUH/ushffWU61CS29oIPI5C0OTY8z7LM2FPyKf/cOmMok8VhNg52g
 7HnnBXcIQ8Xu6WNsTJMWuExSdaJNSGbFyMLM5siXEj2XIMO9yIuQeUNEHqMS5TexMoFj
 jNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732803053; x=1733407853;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ptky6Rhm6bxaDAiNB7LggL4vOL/natgxKCtj1JtuPi0=;
 b=pyWrWzHZ3m9ZFIFuU0qlWRVQVbE81DmHIBu8wGPxiajEpQn2ioJ1M8xHCcZS92Cygd
 wwl1Z2PGU1lLbiSM3qJ+J2bHEXLRFxY6YWmJfhrYt+g+WH9yTX/DSZdwf8EF1ZFTH3Rv
 qs6e51xadInO07QdBwTccrmHs+/+q3ol/LeitNhYKVUC/oqSwmAv6cGUnRKayae1vz1U
 tJZK1gxsYLlTbwhQdTmg1/i1BndkyNUL1xYeTwkD2ERmasOiIIJMQyvJ7ma7S4Ubi7W/
 QWeWsix7ITAVPa4+bdWb2yPGpK4WilYf/bRcupAxUAValraD965jKLyWBmLgyF9OL0LU
 xZBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnQHJSI1yHEMbRkSr0EIUxxH2X0HqajvfXEwns/oXSweE47ndsJ77Q9JQNhwgaMpg0qRZ850hKHdF8@nongnu.org
X-Gm-Message-State: AOJu0YzA77oXck2TUVC9eduErq5Hqgul56wrI9UfO+D5oqdB2k65aLAV
 Fk2GlVDKxemmXbxvnFnBmm2hdENlsB4v75481iNChlSDOQPbKbmsgdVDITPc+pwdce6lvK1jVd8
 nbNU=
X-Gm-Gg: ASbGncvJ0jFYbwWFQU0iCCcW+CMvmQL+aUonMFz3Tb2Cvw0w9JnPew98W1dUVVfH/Xg
 u91GL35sQnZ7IciKyQmC8IhXKqiZbhoEtTrvL89AZgCmk9NQX1CXWKxKZ1yWcS15E2aH7W03j8q
 JvoG2q/2RknjVRw6VYzGBCJZuTxLeVdKU1Bm8jXOVSkMGlDF0HppTkTYgRdomcVDL6Mlda0scTZ
 pPxI1sDcJJV2iRoi20Wlc/HvCIBl8WLQiJ22FDQ/AcHZ9OYcx9La+JhMYfi5S3YtXQ=
X-Google-Smtp-Source: AGHT+IHciyaEQ3VeEGVfmfRLaIQWpUHWWle0eigfFPvma/WNDJ+4fn4h9+kbOtLXp8WJ94bYeHpZeQ==
X-Received: by 2002:a05:6808:1314:b0:3e5:f7c1:757b with SMTP id
 5614622812f47-3ea814ee598mr1741466b6e.9.1732803053159; 
 Thu, 28 Nov 2024 06:10:53 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86211436sm266305b6e.34.2024.11.28.06.10.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 06:10:52 -0800 (PST)
Message-ID: <521528f1-74d4-4987-a4c1-cd354c60161f@linaro.org>
Date: Thu, 28 Nov 2024 08:10:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 13/25] target/hppa: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-14-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the HPPA target,
> so we can remove the ifdef from pickNaNMulAdd().
> 
> As this is the last target to be converted to explicitly setting
> the rule, we can remove the fallback code in pickNaNMulAdd()
> entirely.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/hppa/fpu_helper.c       |  2 ++
>   fpu/softfloat-specialize.c.inc | 13 +------------
>   2 files changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

