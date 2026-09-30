Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD2CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 06:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBnsI-0003Mx-BU; Wed, 30 Sep 2026 02:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xBnsG-0003Mj-5Z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:33:04 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xBnsE-0002IM-G3
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 02:33:03 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e6598dd44so31384515e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790749980; x=1791354780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s2xUazeWbJuW4QCzJsbUerahTXj1bu2ad5ux7bUFuXU=;
 b=CX54G47FdjFGx1Ocgszrm8ZEtT+qiNTHp7GUTXdq4OsxM6kGVLhGbXKZKrA0kHplqw
 fUTq4B2Kjs2zWseshL26R6aK9Zz39QFkh8p0dGagcrsh0RBfXMUVBie+wGUFMe3eCfwz
 nPljOVdQKIkJOniq1JXmwjnWPEzztAEzjAWOjNzy9dqtCn+XCIPtd7b7xXWCq4m96eXG
 SyYwzd0MXy6LaQYzE6Rx679tHx7NakOwhdez89zfDhqxGOjadJ+K3J/6FuIyGb5jTxvD
 QtHwpoELbQ6SoCFNbgwyXwW083ckrT0VqcqeaefvnbDpi5rzUarIp0qtxcdPcJ9ZD4+Y
 KRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790749980; x=1791354780;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s2xUazeWbJuW4QCzJsbUerahTXj1bu2ad5ux7bUFuXU=;
 b=vwtxQ/3pS7G0bsB5a5skVflVNN3t2YqPxMLhJ/cpNLTzhQTdFRuuGBy67+Hb3vlB47
 u7HNAsQV1b4UGYbIiDqSIDf0oQQT3stZ8fPJylk8x/cOxhs0XcFRpbR8rSOcEK9n1ppk
 Q17yHGwotAde27eEl65hZbOCHGF9w93vwfYgGrdrLyEnERcBP0nPEc2HRLj687/cHaR5
 Ubj9Z8zHl/BIFdox7IYWpBS6xRiahAzw7XQTSY5p0xjJu56dnUEGtfRKHkfl1t+uQLFI
 FxjBHUSphrahsNKzkBO3dsq7IdpNHlFZleQrgSrJrLkzKJeHpEUCKrBDaqMMOrCBgcvY
 Y/YA==
X-Forwarded-Encrypted: i=1;
 AKwUvByHv8MqahgSY6C+xh0RTpuHvUUQ5DAzvkCfGHu4KyOdcdpCzjrWBfSN73+pdVOwQOT3yO4cJ3ySDG3s@nongnu.org
X-Gm-Message-State: AFuF++mDd8ofdZZ6wCJCErXMCirOTRIfNB66qL76yln8AeiZfOdi9x1z
 SBEsAZt+vle/90+8WUe4C1RofzGOFyVvnadnumvVeR6F59fK8OG6P2MumSp9V8IX+kk=
X-Gm-Gg: AYBFou0nvAgH9QL3G9vtfI9ivqHHjSDhf1PTdq0Qehx0REg5CNnLE9KTdRmsQdRXnDB
 3lmFbQVr/qoLgiA/707OAcWX/cHE6sH0CAygOetBZ9vOLJcyaCWQaKddUaKrlxTzIPBRn8eKlrk
 MyvMi++EVSIDcnX4BhZFgzmd6Z2qbjaq9G9iSi1TnJezLTEnvfv/mqTpTu3KhNmgKhy0X2RzO1+
 KjGrgkqyHaIgPk9gDaF/f93X1Y5obLWx4tE8YMmnTHF6IoLybeYCXCuTYWTNpF75+/fapeTsQpC
 SB2A9oB5XN5VLrcLwE5/QfD9ZmbbBPa0EK7iAQLwtewX72CIXycgN02rmDBshiZaqloEv2pnDY3
 75S5KdgelBxE19tuKUBIG/NP1MRS/flZvy1iIrNHB35jo+z8sIA9Oe1/ePWCWrxWC4AJpufCnMx
 ZrLogwTIcQ4Vx3b7WNTnN1miWPsQbzO/yh4yR8VLbbyFGYnv4hZnoVCGCKpOjzk+hpTfPC9iE4W
 KqCuwKMy2Q=
X-Received: by 2002:a05:600c:45d3:b0:49b:d03:8d3a with SMTP id
 5b1f17b1804b1-4a01aff2060mr4295175e9.11.1790749980562; 
 Tue, 29 Sep 2026 23:33:00 -0700 (PDT)
Received: from [10.70.4.56] ([157.231.30.34]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174e161bsm48942125e9.5.2026.09.29.23.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 23:32:58 -0700 (PDT)
Message-ID: <0fafdb2a-d3bc-4fca-8fb1-9d4580546b80@linaro.org>
Date: Wed, 30 Sep 2026 07:32:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/37] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm2-x10.google.com
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

On 9/29/26 11:00, Peter Maydell wrote:
> Hi; here's a target-arm queue: FEAT_UINJ is the biggest thing here,
> otherwise largely bugfixes of various kinds.
> 
> thanks
> -- PMM
> 
> The following changes since commit 81ce3a87737aa50716c42db8886082d12783e0a1:
> 
>    Merge tag 'hw-misc-20260927' ofhttps://github.com/philmd/qemu into staging (2026-09-27 02:02:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260929
> 
> for you to fetch changes up to 998b6db69e3ec58fd52ddc7a06ece6cf286f3c77:
> 
>    target/arm: Fix WFxT timeouts when the offset puts the count ahead (2026-09-29 10:58:40 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * whpx: arm64: check for physical address width after WHPX availability
>   * hw/char/stm32l4x5_usart.c: Support 16-bit writes
>   * hw/arm: Add GPIO to Allwinner A10 model
>   * hw/arm/tegra241-cmdqv: Keep VINTF page0 region alive
>   * hw/char/exynos4210_uart: fix fifo overflow
>   * arm: handle CCSIDR_EL1 as a demuxed register
>   * target/arm: model Cortex-M0+ privilege extension
>   * target/arm: Fix migration of Aarch32 Secure banked registers
>   * target/arm: Fix PMSAv8 shareability decode for R-profile MPU regions
>   * target/arm: Enable FEAT_UINJ for -cpu max-v9
>   * target/arm: Fix timer tick and WFxT timeouts when the offset puts the count ahead

Applied, thanks.

r~

