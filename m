Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8835CC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHanu-00056W-Fe; Fri, 16 Oct 2026 01:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHanm-000562-4F
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:48:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHank-0002bZ-96
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 01:48:21 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso27194875e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 22:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792129698; x=1792734498; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VRzc+tB86b/U3aKl2JUlAZ8dyjJP1bTmj7VI/KblNM0=;
 b=BlJqJ6WbQY78eKH7m57xCvMUJ69m2BnUY0Fpsp+E6VrYlGyis0zdMSv9dVWHJNfIcP
 3A6lB0w4V3i2gAmPVWYvEvI/uTSS079N9VR3kHPv9uMa1Z+jSfTSgl8mzGUZ4ULmHUR3
 COuuNzylBBEQswKKNZ9fTfJ7qK8BhMHNzGu83xa1bPxvd2rxf1i6OYwX7ImqLHWOjDg9
 UhOrZaLfbMjtQNW+JoXb9bzJ62Uu5NhGtMRAK3yUcGB9XVmxkK2leVfXoIsLxVl0/7xo
 zMbY+iTIBY7ai64rY0VmLL/5TzRQtYulZ+Kn+dyg6iR7KjjNZwHjqQ2ObZ7/8LeeIld1
 jxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792129698; x=1792734498;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VRzc+tB86b/U3aKl2JUlAZ8dyjJP1bTmj7VI/KblNM0=;
 b=M64nDTtsqWNBwfWAniDhYRLRUWGFqBXpU18a6mHKA1p6SBWoTL48gjKCAfOpsoza3z
 CiAWZAZzSYBfoLLa8OmFX4kRHgoZ05B7ARPZmNyTpG1mV/r5kXtrWzlP3gG8KXGPEnON
 n00ZzuOtg+fkJUuzhc2H+j2syDZ7xrmt/8z8R8B7sPW9zINI/m+ocsspapoiX/G0rvqf
 JC8mx7nEoRe/osu3klJvHObdrKW58ATpD2datvYK7L/D+JdX8a+jqaRNdtHp4hA+FdDe
 ygKmaMeR03+8aRMplgC+uY2JgolE6okBIzdpmnPUNgNv9rsEVSrLAoHHVAiZtpPNRrzN
 HWzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHk7LzKDRAnZJ3QaP2zFJXtMZGFAe2dxPlh733q/rbZu3BVf9cCCp/PEJCh6POljQJCbx2+ywy/JV4@nongnu.org
X-Gm-Message-State: AFq9FYI086CWtMo+fH+tqZvhuMsRLsLCBjhfct6MIWMu743qxQo2jbk0
 akaJc5wbn7ykVYD9yg2NxFAqz/rPRENZ75IuW9zwFi/LL2MMReLJOCibuJWH54AnekE=
X-Gm-Gg: AYBFou2XSvCn8LlNNMaVa2qdASoXh4RDk146NG8/IhjgU+AJvyJqBBe/UTWjIkprec1
 +CY6JDzgz0G5GXMx2UK1IOu4K4Sicka0NEORWMPS9jMr30Sp2ecoB3KuZeEHo39UTkLeAAdk8Iv
 QDIWXliHrJtdoCIn4OPviKf4LkYPJLEe/+CZuJUkj79sSHUrvXT7BjKTqa/+MnE1Pg8hFNDiVxv
 sJWhC1xphOalpyBe3qL10C5oV2XZycL9wAkJWOeXJAT6JUwPX8BWotujAPDj6Pum2Yu7ITr4oqN
 3/DsUgKj7lfhcvnIYTqjJyYs5I9pdjh47dtoR3JYodjegewWSTXECFuUDf6sj80/il5ON7fb+Qb
 kp80a7nkGiMnUfN87mGCH5YmZNIZKwAU6LEOXch0rxZziQ9Xopr6DlHbgLRymTeiE2sSttVLjmD
 vAy9ajgYsYsc4lDEeobgiW0ml/dG9oDD0X9sOgE2wTRW30IZyot64tx+HcUKx5gt8ndU4l73RRj
 Vb4P1AQmyeTESTz71nhfqCxv4MHgZhPDrZM0wdCch++mWnp
X-Received: by 2002:a05:600c:3e8f:b0:4a0:263c:704f with SMTP id
 5b1f17b1804b1-4a18e4a3fbdmr434011255e9.16.1792129697948; 
 Thu, 15 Oct 2026 22:48:17 -0700 (PDT)
Received: from [10.233.235.227] (p54a4c6f0.dip0.t-ipconnect.de.
 [84.164.198.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce325107sm15739115e9.3.2026.10.15.22.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 22:48:17 -0700 (PDT)
Message-ID: <91072755-5e80-400d-8fc5-78c4a54d91d1@linaro.org>
Date: Fri, 16 Oct 2026 07:48:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/50] riscv-to-apply queue
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20261016010237.1102834-1-alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261016010237.1102834-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

On 10/16/26 03:01, alistair23@gmail.com wrote:
> From: Alistair Francis<alistair.francis@wdc.com>
> 
> The following changes since commit 7e8d3c7fc460fe7cd28a3e423d7466fa292bc269:
> 
>    Merge tag 'pull-aspeed-20261015' ofhttps://github.com/legoater/qemu into staging (2026-10-15 14:58:28 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20261016
> 
> for you to fetch changes up to bfdd4f6a918ffad4f013d4f53a9adca1adc0aa3b:
> 
>    target/riscv: normalize Zcmt jvt.mode on writes (2026-10-16 10:40:39 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 11.2
> 
> * Check G-stage write permission for VS-stage A/D updates
> * Restore LCOFI handling in interrupt CSRs
> * Fix csrrs disasembly decoding
> * Stop translating after WFI
> * Raise virtual instruction exception on svinval instructions
> * Fix some KVM migration issues
> * Add support for Milk-V Duo board
> * Make MIP accesses atomic and BQL-safe
> * Add initial sdext support
> * Add SiFive Xsfvqmaccdod/Xsfvqmaccqoq int8 matmul extensions
> * Add the Server Platform Reference Board
> * Revert invalidate reservations after stores for linux user
> * Fix the UART register width in SPCR
> * Check Svnapot PTE before updating A/D bits
> * Add Tenstorrent Atlantis PRCM model
> * Fix RV32 fixed counter accesses
> * Write back fsgnjn.h and fsgnjx.h results
> * Ensure Zcmt jvt.mode is WARL

Applied, thanks.

r~

