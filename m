Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFC1106ACDD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0lXg-0006xP-MU; Thu, 12 Mar 2026 15:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0lXe-0006x6-Lx
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:17:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0lXZ-0002AQ-89
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 15:17:50 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso1077570f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 12:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773343067; x=1773947867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PDf5jSGjnIDAdHBu5Qhu1kzjWhtjJpZQzm6NfazXxxY=;
 b=xgGn17rUiBoJ541BVPaSMSgcI7tjCeyFI6/Gelw1KXSehtJk8AJdRNAeWG7dqtaPZT
 UoxSyC+SXiJSiVabJ59m+lo3UlZb2muRkCiBBps8MTddJgLJ/Nby99wgHo3orNHod207
 H9xySpyPX91oD5j5PPigERd4LYtxM7uLzOf27IeLqTKtBbj7f4YRmKNNpXFkkg+05i8X
 es/RbBLaSBtyVsO6U8P3NKFd1qMrrOrz6ubG6zK/bZPl1akBDzQ7top7peRlmXKf2xOA
 wnuOaPugnvNv7nwKk9eDm1ktZsToLdpi/mnV84oE0zdkZo0HNRpuLLpKHFsP5m0p5Bj1
 FAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773343067; x=1773947867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PDf5jSGjnIDAdHBu5Qhu1kzjWhtjJpZQzm6NfazXxxY=;
 b=oq1dMKE6fHYAAMoGx7s2iGtZ/zmscwtQNnNbDk1KLqfMiLMqtfyHtGhoGb7AcGsRn7
 XvM83+Ph1IDMFhp87I/H3M3vUXO+Quvt6c7A7RHGl+aBqaAWUpYxuMHI7U19yt+iAQnY
 ZbjgsZopHBmrilD2yPmyXEpabn2ZqBlJL63b1o8wKYDQfbz1pe0fOUSedCLoyoPK2cYi
 ozjPOeEJUPJRAxSoIC7/TD8WsuzNoK5gpWw11wmN++9gt2Vxz3rDc61no2WX5M+RIk+G
 Sr5zzVMd2HS/Nv1wgnS7ppUurerdxB3Wr+GM+++kB6QR41cQj79iXAkSA9J3GvuQ10bt
 eCIA==
X-Gm-Message-State: AOJu0Yx+66MFkXNv8WlaIpLXL/CnE3puVydPNtBkd4XAGS2NT6dg60Jm
 qtQOwSrNt0g9pCojHZrjphmyrrcMLOQwcuUg046V2FVn8+ssPtBTILuE9Oy4m2ggihUszN3+lRl
 8QJFR0fA=
X-Gm-Gg: ATEYQzyYN6EELWk+PEMe+FKHQJVrS/jInMi+eb/Io6+vPuFd8yPNUqHbC/tVLLQyEZU
 Azjjh8jkDppL50ESwC7Vj15IxlUtJVi4yKluc5BDKyH8MmMg33nc4/Rz2FbgQZEgNDy59mNnbFQ
 T+74IuV2paJwaBTJD0gKaSeqdnBN2rJCzE7iN7cIbGLWFd0+t2NO1yy0NveSGna0fn8z7/VyTaU
 bcJl6jLX8XUAOyCKkIFeqh1HzHMR4xH8IO90SrX1xS4KivIqeJWeDYSRfun039tDyvmWxG7Tkjw
 ttMx/T2CR3KzT0J5e0NYq7xtNh86PkftPpQ+36BlX8ZF1daCZwRvi5iQFftz/bzC95pvwVsWn9y
 J9Td9E0anthmYMREOMJPl/PMkdN6Gil0UMy5cHEtmCZl/0zQlk+CLzsj/8N+8WmeGbCsBwuv5OO
 /ut1Y9//yFc0dfrV4eyTiEGizN8G1octxLm3ew8JAEzZWZJjPN+jTam4GCygEzjQAwjLgMCE2Pc
 yH1
X-Received: by 2002:a05:6000:2509:b0:439:b811:11de with SMTP id
 ffacd0b85a97d-43a04d7c5a0mr1711401f8f.7.1773343067565; 
 Thu, 12 Mar 2026 12:17:47 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe22e9ddsm8710147f8f.37.2026.03.12.12.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 12:17:46 -0700 (PDT)
Message-ID: <60baf145-e580-4bb0-b8f6-18a40b1a561f@linaro.org>
Date: Thu, 12 Mar 2026 20:17:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] semihosting/uaccess: Swap bytes based on
 runtime-configurable endianness
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Martin_Kr=C3=B6ning?= <martin.kroening@eonerc.rwth-aachen.de>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260311-semihosting-cpu-tswap-v3-0-8e239575ec08@eonerc.rwth-aachen.de>
 <CAFEAcA8DJW07LLpBM_sfeKcCDgJUQcTN3n+6b75eTJXSpcF_Ow@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8DJW07LLpBM_sfeKcCDgJUQcTN3n+6b75eTJXSpcF_Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 12/3/26 19:35, Peter Maydell wrote:
> On Wed, 11 Mar 2026 at 16:28, Martin Kröning
> <martin.kroening@eonerc.rwth-aachen.de> wrote:
>>
>> The semihosting ABI [1] states:
>>> Multi-byte values in memory must be formatted as pure little-endian or pure
>>> big-endian to match the endianness mapping configuration of the processor.
>>
>> This series ensures that semihosting data is properly byte-swapped if
>> the guest's CPU is currently in a different runtime-configurable
>> endianness than the host's CPU. This is done by adding cpu_internal_tswap()
>> functions and then using them in semihosting/uaccess.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3258
>> Buglink: https://github.com/taiki-e/semihosting/issues/18
>>
>> [1]: https://github.com/ARM-software/abi-aa/blob/2025Q1/semihosting/semihosting.rst#the-semihosting-interface
>>
>> Signed-off-by: Martin Kröning <martin.kroening@eonerc.rwth-aachen.de>
> 
> Applied to target-arm.next, thanks.

FYI I was not ignoring this series, just postponed until freeze date,
and was looking at it earlier today. Interestingly this also fixes
my issues with m68k! So I'm glad to provide:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

