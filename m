Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47923CFD347
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 18:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNbRS-0005pX-EY; Mon, 24 Nov 2025 13:37:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNbR8-0005Ts-R2
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 13:37:18 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNbR7-0007W1-4s
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 13:37:18 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-29808a9a96aso53788715ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 10:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764009436; x=1764614236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6quMaPOwz3B3ZFUOwtQchFCrYhLZ7Q78n7buu0OahNc=;
 b=aK8Q577dGyU6CC3s/c/H2xr/sToXEJs58kATc55qcCh+e2GePFvo87sfAWAYiFyhYp
 nOYa/H8Ace89L4ijXz8V25nfOl+7IKGxmKsJVJY4wxxuVqJqNv/x0hW48NqYe9yNPbN1
 5MPwSkfx+e4ABIHutjFokAKNGGqyeO09iJ/e/8fNRpF39QGPj3muyni86Zap0Hqcd6a7
 Qwv9qVa1rQdcBIwCtErBOrLwD8amCFc86DoI+O15R6Za1QfElQHKQNZA5/gkNjXcVh3u
 xM1oBtydOcrL+mvjRpmmBrAzkqiGijmqACuq4RTOEFlOlQytAqWbnZp3fy2rDlxrZvep
 8t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764009436; x=1764614236;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6quMaPOwz3B3ZFUOwtQchFCrYhLZ7Q78n7buu0OahNc=;
 b=XsUjrl1QIn75l+HNYjit7C3a/Y3avH2l6pAD/IptJii6DGONNYIPG4QpXES7PprKQt
 Psw27MXYzDXtqMzE3Ce93zaeNqY8Cui0Ks5H58Gs6KcuWPPmtCL5Dc29FFn9ijWR/zVD
 Xv0a42m64IFF+CqWT9F87oT+lgppAweRXZuh383qTLqpSqqgBlcuWOD523+uajVOQLB3
 L/G9n6t05DPgKJpyBOV8eJLHoo5XR8gJOvHc8SYLOz1cJIRb9PRho+X2LjhRUOkOkBIi
 zXWxPl1x4p+nP4rs8cJVDK8w4WgJQjsfSEPazCgHW80sA3xwTZ3Cm6k+zV9Os2zF52Qk
 Kjtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLqfiv1Xjl7DekyengX8iE4rvgwDqDF4VsYeesPyYdg48bawV6ErwMp6CylGBbknRCT0iUDSHDuRkP@nongnu.org
X-Gm-Message-State: AOJu0Yw6LSi8OKiMBfsRHEvD75iD95c6/hErzvX35ZXR6XcsotU3m5dZ
 9Z2VBBIlsKBJJeDg/GMPVhsO1nbqQBzs2mLiIP5IPSNFHzRCs/glPPwbjswuZ62E6Lcy/MocuA1
 XSQ1Q
X-Gm-Gg: ASbGncspOUT84MnJF7hAfo5T/YSZIkRZhzjcSPNYJ6jGzKOQ5fz+2z73at3MqGXuOav
 dG0rI40XyvPlV1BoXyBbyk5zf1Ti1t3kOwZ2GDFvnSkc+JSqfF57IEKxnRlQtCjBUYa8KoiOhMv
 cGgdpZfE4EbNPBv7AujDFc9nG+ZNXwYvILEQGO/t4Y/4TeMEMXQPisMhTFkx8/lcJ2qU301oPr6
 4qcM6mrawMMRPGltrcLrdrhwsUPdCOvLbnIW0kjG7jZUIdXI1CF7hDcRo3TnUHF+bLRk3RyzsWS
 ngKdlc2SmbMITXgEriO3M7PPhqz0qJh9LR/69seVyj065+/KS/+Sri5T6/N1oRqZr7ofzHXJMfQ
 5MYl4XnfHsqGoYVqwi7l1rTuAeSfC3SFtAfuEE6/rbY/688Vm7hbNBz17PTGOqSkHVNd8IinOR3
 mj1IoNArU/ilZj9iuKOa8GFc7AVBV6Jns86NImAvw+EVvWgEkM+w==
X-Google-Smtp-Source: AGHT+IG697c7BaJT/V+fjrZB76EL97s5FlHsCb/Xr3cR3z6kfFGtb6TPGUVAJYQkijeoo310sGolRw==
X-Received: by 2002:a17:903:8c3:b0:295:9d7f:9294 with SMTP id
 d9443c01a7336-29b6becdfdbmr132609875ad.21.1764009435633; 
 Mon, 24 Nov 2025 10:37:15 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b2bb7c1sm142441675ad.99.2025.11.24.10.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 10:37:15 -0800 (PST)
Message-ID: <f35a7426-b77c-4208-834b-393ccf819fc4@linaro.org>
Date: Mon, 24 Nov 2025 10:37:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/4] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20251124143036.4113886-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251124143036.4113886-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 11/24/25 06:30, Peter Maydell wrote:
> Hi; here's an arm pullreq for rc2: three small bug fixes and
> one trivial removal of a duplicated #define.
> 
> thanks
> -- PMM
> 
> The following changes since commit fb241d0a1fd36a1b67ecced29d8b533316cf9e2d:
> 
>    Merge tag 'staging-pull-request' ofhttps://gitlab.com/peterx/qemu into staging (2025-11-23 11:46:53 -0800)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251124
> 
> for you to fetch changes up to 579be921f509fb9d2deccc4233496e36b221abb3:
> 
>    hw/display/exynos4210_fimd: Account for zero length in fimd_update_memory_section() (2025-11-24 11:01:23 +0000)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * hw/display/exynos4210_fimd: Account for zero length in fimd_update_memory_section()
>   * hw/arm/armv7m: Disable reentrancy guard for v7m_sysreg_ns_ops MRs
>   * hw/display/exynos4210_fimd: Remove duplicated definition
>   * hw/arm/Kconfig: Exclude imx8mp-evk machine from KVM-only build


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

