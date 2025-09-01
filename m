Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A62FCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 06:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usyKV-0001xF-Rh; Mon, 01 Sep 2025 02:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyKK-0001ff-Jb
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:47:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1usyKI-00035T-8U
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 02:47:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45b82a21e6bso14887805e9.2
 for <qemu-devel@nongnu.org>; Sun, 31 Aug 2025 23:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756709255; x=1757314055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrSihotYn5GpaEcJXoXJKDIWieFByybwgyLWSGvnHSA=;
 b=TbiBmdI8uiLTw1ewIvf4ss/t6NYibH6pTxECQRSt2XkjHd2xudQjwZi3dbJteU7DRs
 F0W81887nlITryRK+xoBYH5CLrP8ROCOO5gf3qjvPliRQCbFXiLxhWiBw+rqkZLaVoUE
 XaDBNQwyZAaDjBm9VmAvqfsgaZYwhcP1HojGRF/LBUuaPB6MQN4x3N+CNIolfgG+MLMA
 tv3LB3b7WPeukfZmyk8FgLDsvNmQh/RC42G5sRHYZ0/wCX4U7AEFLTZQIZAnlhLqFnnF
 oe4i34CNObfzq5cS3QO90/A321a2CP3AsYnvR42oaJdMCjKac1S98qW4lPJ1GAW/6PWH
 tCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756709255; x=1757314055;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrSihotYn5GpaEcJXoXJKDIWieFByybwgyLWSGvnHSA=;
 b=RfXefX9ncfSjxjDQZG7iXtk9u8OYuLZWhVwAJCc5ukObImggoeoMKHq4/5JvoV9kkh
 LjefU5suUpu/Fi4YtbSUlxRtGry4bxq2RL6VdPdJPann5VetS0TPrsC530Hlvi0Pc8gO
 JdsbqY4jF77OG/tI3D7WnzU9py9jq2vv4ArWY+d2darNlPAUeYfYxQG6qEhkM7DFtVxf
 vgmtgL0bNYX3GP4O4yWsG7X8ybrr0hzWx7Skt4zWz2V3WMDjpkC4wI/agBYqoFDJnc42
 Yj1w6qyFckBbxe6C24C14cBV1aMHDS0prP1aPwwF3nReAQilkdKST56Ndi6mWHYUHsS2
 gEbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXosg4lCZ049T5VL/9xCkFumtstf4tcM7+QNkBZztB18g46z+KzaKJUK9ZpBJkpFSpi7mtowIqNnm50@nongnu.org
X-Gm-Message-State: AOJu0Yyr4yah27MQAuS7mR6WTxlL57/usZpBshDYysfFioh9e5tDobdG
 bHakmfU8lnPPfw24gLvndkGQDCdX88ruH4JUVCz7To2hPHmvO1nsGJUZ6PEZE6uEgio=
X-Gm-Gg: ASbGncuDm8kXejk4cOrpOWVQP9R30fC33ABb/h+2q50/yWn0XgOMSPXDmLTujwDXY81
 qC3Kl1z3ytpeo7fbLL2Z3kNOEvGfpP1nTTNM/R1zkjesq86tiERsf5kBarL7VZkCfxp1LtYcV7K
 YcwW51Adh9QPYhU4dccIiN7vP9Oyyg6x2CJmuH+cVXQHNRzv8/tsbUH+RJ+SEJLrp4IA0DW+lkf
 /iQ3b5fjsF3tysEZe4+5kMq/mdoDQ/JBIs+IKVrtkpMJPdv3JzFBbb5sgLWS+Mo/MjRddpjKWOp
 P1Z1IcNPj/RsKLI+1DIni8Ic/DOxruE+XVF+YFYn8XlmDES3Jd2ihnyHqVPtOnkCxTq6+h2/ukq
 0l4Hj7viVLPRqtvdQsqcV2yxfKXQd3EmB6vPTgpGjSNx1eC77/guuNnXShqy6fj7PsF2iXCQ/HR
 0I
X-Google-Smtp-Source: AGHT+IFsfy+3hvq4FTJZmslPEmZ/wLiXfyImsv/wxYHwdxhE7DNKL/9+ULDJ1W4S4A9OziPxPUQcMg==
X-Received: by 2002:a05:600c:4fd6:b0:458:bd31:2c27 with SMTP id
 5b1f17b1804b1-45b85588134mr50777455e9.23.1756709255429; 
 Sun, 31 Aug 2025 23:47:35 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d48760d1c9sm6081758f8f.17.2025.08.31.23.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 Aug 2025 23:47:34 -0700 (PDT)
Message-ID: <15e89f6e-ba93-47d1-a4d5-e0a81d1371de@linaro.org>
Date: Mon, 1 Sep 2025 08:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/19] target/loongarch: Add header file cpu-mmu.h
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-5-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730030202.3425934-5-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 30/7/25 05:01, Bibo Mao wrote:
> New header file cpu-mmu.h is added and move mmu relative function
> declaration to this file.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/cpu-mmu.h        | 30 ++++++++++++++++++++++++++++++
>   target/loongarch/cpu.c            |  1 +
>   target/loongarch/cpu_helper.c     |  1 +
>   target/loongarch/internals.h      | 20 --------------------
>   target/loongarch/tcg/csr_helper.c |  1 +
>   target/loongarch/tcg/tlb_helper.c |  1 +
>   6 files changed, 34 insertions(+), 20 deletions(-)
>   create mode 100644 target/loongarch/cpu-mmu.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


