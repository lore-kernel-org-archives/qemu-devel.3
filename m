Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B76BD609B2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 15:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVX7T-00080Z-8V; Tue, 16 Dec 2025 10:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVX7K-0007yO-Om
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 10:37:39 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVX7G-0004ib-L5
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 10:37:37 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7bc0cd6a13aso2680843b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 07:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765899450; x=1766504250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xa3b2KHn6rxbHqZCIAFol4i0PKFfkVXBd07NS2J2c4k=;
 b=Wmk0JSh4SLNM41kSgl5XkENcOG5vQZ5m/PfprQa1JaD74LmKv+jVGPFx27xQm/fnY6
 LhIQZjQvmFUIM/g4WDyvboJ9zMGrcQJb2vUy7JUbi8nS0Mej92X/cmMJH6Ikt3ziNn19
 7XZcQ4ndeZnXvF6EdijGlVfNHoulCvvEkvyekbv+0JQE72JFp6J/yQrWsNrlA6FgkO5Z
 0CceiE12N0tmOjQKCvQC3T/ORYcWzQEcwCGYc1feATAQez9DEd+7cnqmFTVI9+P0dNSy
 NPwZG1z+XiABB5uNo/q/tVLb/ZXh+QhG3DwK3LN2rOy1i1PEEQv80PcX3fTY1s3KpCYN
 c1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765899450; x=1766504250;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xa3b2KHn6rxbHqZCIAFol4i0PKFfkVXBd07NS2J2c4k=;
 b=nt2F0c+19H1YKpGtEyOQPRi3slWCnEGsBCjtHfwPT4esffznN/R7J5Xm9RWT3xbx0Y
 9xJo5JVUYipXlpTUO4SsZXaHGvYOuk41DfbH3oTk5snqTGsxQMy3Qr2TM0frty2e6pJq
 nDurukqkTo1xO/e4Su6JoC+/5OYaZJbCNq9cOrjeB4LXC0cF+PzyqN5sBVBFfaJ/3kJG
 TU/d1mzvXZ7wAydsYfe0UAZXgaGdS7iHesZHX1SQ5JWS2P0uBF53TYVYFy9gq31YiI2C
 CqSKc0xmPe+iIfzcIBrXRUnkaM/+F0xJV4BP9h9prR4pPAn0EolEoLALzbUvwMaclZ+S
 M6Bg==
X-Gm-Message-State: AOJu0Yy09oKOyf03VKdgOWJQQqadYFhDumCg5udwZUYIizot2P/WUDHk
 jqb0QFwlFDsvmHjOtQIbaabSIW++1tj9a0pRJuleJ84vrgWQDq8RTkmUvvXLeaHBRxY=
X-Gm-Gg: AY/fxX75aBt4lZmmZnzm+8f8pL65I/kgJ0gSC03HKmpohlIC/rsMfaVPzyHgAnYMJ7p
 qVzlWULa/8mxgNnBObTLHzBNJrgosTFSkU6O8ZugHf5UNmMWdjP3lJmWE/VMVcScWiuJn4iJ95X
 nqRorLtgG4V6KCvVe/SaAISVcP8WsJXqNCvGxRs2oMa2JLaLIOsukG+VFA92M0AzLjQliBxrCjD
 ffx8uCfEKgUCfOMQhfw1R3wLyiLqmxJSNSwHmLhjzyLBWapMLYfUiwCLuW4+TnkJ0J9tX4iFme2
 HySiYkiwU+w9UXfO7VRGPhEFf8jHotaBIHkgZpVvnTlmfw1/SQL8E2Gt3mTOFewy5m+ES6w224G
 rlnIIMcK23IL1LsIqMTvExikid4Pu49pGPssvbcVioAUOR/DDGW1/HidAM3Nnrtcrh0gk+ilFTo
 fbFHBMNNtdfRCO7PLNz5m66RRPUbWpKA==
X-Google-Smtp-Source: AGHT+IEZJizZbbMGam0F6FPIxcBs91ZYe7BDM5lGMFAN5Ah5n3M1i0Dv8IZelY8Bf9cAqtn4y/XVlQ==
X-Received: by 2002:a05:6a20:a128:b0:366:14b0:4b19 with SMTP id
 adf61e73a8af0-369aab23fccmr14954684637.36.1765899450335; 
 Tue, 16 Dec 2025 07:37:30 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26fa703asm15340101a12.16.2025.12.16.07.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 07:37:30 -0800 (PST)
Message-ID: <24443fbd-8914-4d63-b058-e13d4cb4a71d@linaro.org>
Date: Wed, 17 Dec 2025 02:37:24 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20251215172553.467516-1-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251215172553.467516-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 12/16/25 04:25, Kevin Wolf wrote:
> The following changes since commit 9c23f2a7b0b45277693a14074b1aaa827eecdb92:
> 
>    Update version for v10.2.0-rc3 release (2025-12-09 16:44:49 -0600)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/kevin.git tags/for-upstream
> 
> for you to fetch changes up to 307bc43095b8ab1765fd66c26003d5da06681c05:
> 
>    block: Fix BDS use after free during shutdown (2025-12-15 17:31:08 +0100)
> 
> ----------------------------------------------------------------
> Block layer patches
> 
> - Fix crash due to BDS use after free during shutdown (in particular
>    while migration is running)
> - iotests: Fix a typo that made a check to prevent overwriting a file
>    ineffective


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

