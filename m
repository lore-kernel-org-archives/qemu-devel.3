Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA82D4899D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgk1L-0004TC-CB; Fri, 16 Jan 2026 08:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgk1G-0004Su-CO
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:37:42 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgk1B-0007Em-8X
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:37:39 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so15860205e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 05:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768570655; x=1769175455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTSz941HVsO95uiEgXS6uJr90DAznk8SCpu+CG0XZzE=;
 b=mQUAnYatZpY8XDP3WD5AxReuNJdSpowFxEshCkTkzhqUnAK9P/BAHgQn3WJ0jutndA
 4COTy8Te8jh/vYKvU4ERnQtIxMprmK5yps+AH7vdQEE0HNNT1bb96kGTZi7jjNQ2Iyyl
 241G2qZ3wgx+Bu444tC1OowHgM5BdB2pySSoxAlaF0Eev+hWq3Zt2J7KDAlJ/tWBaut/
 f7N0r53TTJZQHtpWVkil2Cx6MaCuBZJq+4DTJPUw9uvnzIaX3WG3rzRQ+QvrhXnYSQRa
 c3nH0wYVqFCXmRKyBzjFuXCertvfLqkFBOgyxoDtMu3+8m+HzWr++Rb3yFsmQFUdNGUl
 6pEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768570655; x=1769175455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aTSz941HVsO95uiEgXS6uJr90DAznk8SCpu+CG0XZzE=;
 b=n/AP3g3VSVWiDvNPkHbmjcX2ig3p7TnMVy+YKjGMtJcRdFoNdqbcabgt1vSL2XTddc
 6Tg0mIR8KtIR+KGYaGHe+poVZ5C0VqvL8YsBAFBARwp9bXBosFtm2ySFUMpWp9E3PEqH
 4XM6WZUGsI96pavedSjaAfqsaPpkAQSARvPnGsum8nyF5QCQDuVXEtpjbdWgr5JWJbeW
 Zrmes1lbjnb85PltubPa9VnRFF7JWh2YRqr+V5x01zoAMea+FMFmouUw8mOVcqXN6K+u
 ByX2Jezy5rD6xplOYCQtqEykrjrzzazq8R3y0pHGDVC2H9gvktNoPNbfFMRL1VtTFnRg
 xH4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv/YZA4AK17LcmzT/PqQmQhoNRo3sTJDtyATTuNdHGT623bphwHF3OAOxCkQscbYsdDGrzxjnpedOp@nongnu.org
X-Gm-Message-State: AOJu0Yzz++bUXHaR5S0NM1t9Aif9gxApt9JyG9I57E3iOmHyZ3TT45dz
 tw1HWrxbpa0I5b3QDQAetN4xMhjJgewflAq8QeBGkxNgvEXsr1R9qWKmW1CxjIiQmlE=
X-Gm-Gg: AY/fxX7AQf9WlM3dUmQZR1tO5cdw3/HJ1hTUGWRE/btaVjhdpok/o4ItWwoGRaHCza0
 S3Gqq+ukJsnm8q48RxVIC/LBiZYrIgxrqMzknd3nHt/mCBAJd2HBCf41i/7PveaylbS/BCBgNPN
 /AvOKlso3i2u75rNyvGm+XE9kczt5RuuC4JGVweLOJ1p1YuUPefs6D30fzghdXxB+Hbbz2giyjp
 Y1FuSqLZpJ6dn1n6xh3OCIt4MNiHYOiP/fLIlMzNBcDfVWUvdaQAc5+X3ZMojdV8Ql0YZMa2FjB
 YsmsN3zCkTEgLJpX2vMcEfCCW6/Rn2d7wPmm8Sp/r+XCyDsrtBRxqW9Hn73rQolkB43u0TZI7St
 cox1/Wx7kseSSJPVjQyooEiCwKcgctsl6rkN2Mqqsz8W6dp/ewGjbuy36wlxIWHrzPwEs9n/aRm
 dzpugP14QJnsZ3MhVUIfFGM9ckIfhcrHNrCgeckdCaNc2vCxxoc3UT7w==
X-Received: by 2002:a05:600c:4f15:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-4801e530d15mr39115375e9.3.1768570655505; 
 Fri, 16 Jan 2026 05:37:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f428b954esm98288565e9.7.2026.01.16.05.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 05:37:34 -0800 (PST)
Message-ID: <a6d592ab-3473-4355-8578-e001f58b3751@linaro.org>
Date: Fri, 16 Jan 2026 14:37:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] misc: Clean up includes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
References: <20260116125830.926296-1-peter.maydell@linaro.org>
 <20260116125830.926296-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116125830.926296-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 16/1/26 13:58, Peter Maydell wrote:
> This commit deals with various .c files that included system
> headers that are already pulled in by osdep.h, where the .c
> file includes osdep.h already itself.
> 
> This commit was created with scripts/clean-includes:
>   ./scripts/clean-includes '--git' 'misc' 'hw/core' 'semihosting' 'target/arm' 'target/i386/kvm/kvm.c' 'target/loongarch' 'target/riscv' 'tools' 'util'
> 
> All .c should include qemu/osdep.h first.  The script performs three
> related cleanups:
> 
> * Ensure .c files include qemu/osdep.h first.
> * Including it in a .h is redundant, since the .c  already includes
>    it.  Drop such inclusions.
> * Likewise, including headers qemu/osdep.h includes is redundant.
>    Drop these, too.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/core/machine-qmp-cmds.c         | 1 -
>   semihosting/arm-compat-semi-stub.c | 1 -
>   target/arm/cpu32-stubs.c           | 1 -
>   target/i386/kvm/kvm.c              | 1 -
>   target/loongarch/csr.c             | 1 -
>   target/riscv/csr.c                 | 1 -
>   tools/i386/qemu-vmsr-helper.c      | 1 -
>   util/cpuinfo-aarch64.c             | 1 -
>   8 files changed, 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

