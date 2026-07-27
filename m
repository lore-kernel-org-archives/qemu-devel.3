Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49FDC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 17:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woPRA-00040M-7w; Mon, 27 Jul 2026 13:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1woPQy-0003zE-AK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:48:16 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1woPQw-0005KI-Ee
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 13:48:11 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cc73e322dbso28774485ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 10:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785174489; x=1785779289; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D6AaTX4Uqd9bA6yMQ+v73NbLFYn5C2iFqghzbvxGqqM=;
 b=rjpQ19f7mSdgpHcEjbq9bwh4tm0sDCY6s4TPzIyKzMezGNLmtkqeOQEriWaRPxi0pE
 qN7HnW3+R9k+r0JnM1Psv21zNIwxj/1/QQO/cEoxups99fD0VzSQP5oWxORi7poh9Ggu
 kO3p4b55lTc++64JmprGDYluS6qIW1XTBlbaZcUmWyJt3NiLctMaqNu4BrOL10WRtKX2
 Rv+eR2GUogeil7HD0o/Ct70c9fhzPa1oAGfMTBZtfWtG2nZ6q2v3vobMMWSZnCnleyRC
 pDmfxLmOWJzewpp4GctAQdPVCSIaV/WgwNhwM4roSXmTXLKGxE/YADuJkKSG6p7D1gEq
 CkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785174489; x=1785779289;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D6AaTX4Uqd9bA6yMQ+v73NbLFYn5C2iFqghzbvxGqqM=;
 b=OhrHi/DyPi4V/V0CvQxQ/2usOu4w4zPjAqmndETLJZQCu4Wy2tEQD9XBG5qT1uJNA2
 vNs+sxMFXrpr5Fmhl7uJbXPjxFmcFvaWn10XBzPS5HzDR+4mJ4DITQxetCbG+vQfZaNJ
 yLquV6qp6oPTELWgPQsl0YMHYNtYTe60rw65n7ibj5bcBb0FHw2D59nw4tTEQeEe2BnK
 SznDOiF3E3mfaUWDX2M7J7GV7NJtu6DJ0AxhIKlxRO3Y0rQg45k4SEs8/7O7fy3fxp1U
 p/8A2xaQKbmQy0gLAXn1U2GshXj3j0hEpPFZ4keBF88MWle4cjDk5kKaRbApzB2dUALT
 0+SQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7fXXOtNMsau+3/GHggUkP07rX8JRsh2aqMxaINu9Hi8uJtuNWNtQBHTeJyLVykSPuTcwV54krGRgA@nongnu.org
X-Gm-Message-State: AOJu0YylbwOcJw80eL5VG2tMZa35RVpY7qpnWN/6hJ/IS/ApPojVtqAp
 DtIfPVvSzFcVAwJ7Pi0j3pNU1Qc3V+GKl/l8JYxsN4jiaQoMoNzYLCNeb6ScIKaD9/k=
X-Gm-Gg: AR+sD106sLrJBP6HGp2ekwFhFCb7e2fZ7cGN82ht4UfPiwbnt1MVrRxa9CehyLMrUDn
 2dOxNpXG1dfq6LqGc52W+5c4NweSNvr7prq9STWTgaFZ4il5PcI7qZQidfWc1gvk75+6gsNxZzZ
 hMG16zfAVL2jREy8Ze8fMTGhOjCwGbdbI/Uk7xF+PdGHxTXMXjGQ8kqkVVR4YMGeyHkaea4qcgA
 8tOVJtx0dthRcsaKh4KmXaUUcTUJQ8BjvVcP4Z9zmw3rM2rDtyk7sUpDvHTaE0QKqIutI6+dEZg
 Mw63x5/q7Ynm5vXcfITD1U1tXPxNjHcjJYWHBpmgb3y/8QfSutVnGA6pZ/hPBPB/+/xT/iSEIZB
 fwNI/eE/YPsVh/aZDQ8x06AkK0SKj5K52+0ExuBJ0PAQ3VlQuqvijciwJcM7ArzyJf54kxD4Jtc
 MKXDQHBcACdQ+QFWa7c9zjgSqwfbmE4VHpCB0VqJpgBxW/WbEBpgV+
X-Received: by 2002:a17:903:acb:b0:2ce:d34a:5959 with SMTP id
 d9443c01a7336-2d00f48d041mr2220245ad.44.1785174488306; 
 Mon, 27 Jul 2026 10:48:08 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde7d978esm38836485ad.59.2026.07.27.10.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 10:48:07 -0700 (PDT)
Message-ID: <ad7b0a31-5bca-420c-9c75-6e90a930d15c@linaro.org>
Date: Mon, 27 Jul 2026 10:48:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Don't NOP the SEV insn on v6K CPUs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260727151325.1428686-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260727151325.1428686-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 7/27/26 08:13, Peter Maydell wrote:
> When we implememented SEV to do something on A-profile rather than
> being a nop, we got the condition slightly wrong, and made it only
> effective from v7.  In fact the instruction's Arm encoding has
> non-NOP behaviour from ARMv6K.
> 
> The effect is that a kernel boot may hang on a v6K CPU like the
> ARM11MPCore.
> 
> (This wouldn't have been so noticeable if we feature checked the WFE
> instruction, and had made the same mistake for the condition on both
> instructions.  But we never have done the feature checks that we
> ought on WFE, so the mistake on SEV meant that we showed the 11mpcore
> guest a WFE that did something and a SEV that was a NOP.)
> 
> The v7A Arm ARM is not entirely clear about whether v6K has the Thumb
> SEV encoding or not: it says "ARMv7 (executes as NOP in ARMv6T2)",
> leaving v6K not stated.  The 11MPCore TRM says it has at least WFI in
> both Arm and Thumb, and the v7A Arm ARM uses the same condition text
> for WFI, so I make the assumption that WFI, WFE, and SEV all get
> their functionality for both Thumb and Arm in v6K.  It's possible
> that this differed between v6K CPUs -- the 1176 TRM says it has the
> v6K STREXD/STREXH/STREXB etc, but the WFI is the old-style cp15 one.
> 
> Keeping the condition check the same for both Thumb and Arm encodings
> is the conservative choice: if guests try to execute the Thumb SEV
> insn it will be because they want SEV, not because they want a NOP.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/4044
> Fixes: 60e7ee5bb7cd ("target/arm: implements SEV/SEVL for all modes")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> Picking this one up because I think we should fix it for 11.1
> and Alex is on holiday. The "WFI and WFE should have a feature
> check" part we can leave for 11.2.

Really?  I'm tempted to call the mismatch between wait and signal to be the "real" bug.


r~

