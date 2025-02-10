Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72902C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZQM-0005bv-RH; Mon, 10 Feb 2025 14:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZQJ-0005aP-0b
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:26:27 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZQH-0007PO-3X
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:26:26 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f53ad05a0so54663195ad.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739215583; x=1739820383; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=msS68gvM43idtk576E/ah7clspzQyq0+dANrbHf3jDg=;
 b=LImITZXAyyGweHcDCNLM+BLcUGdCLod9f68NkRJWNWbHAHHNnwAdq1RxI/cbLjb4gO
 lGC6U1KhG2f94ZKN6Cfcju7bKSqk54em/47wVqdGHGrBJVm09UNZBh2ChBQgCm7a8f+U
 UUB/Gz1NgKE2vBKJN+c1NzoGyuhsC+zXPSkeLy8umgV2b7Y2bDaFSxjPVZcpeW0aOJwW
 If9HAViYtsUThGdS8qrlFyjibIWYmxSjZ1cnsXld3hHQHKO5mKeQC2dEwRMNLM3hd/g1
 aIHi8u/6gDfaQQfchJpJ+9ZdaK6C73zJWD5o+4XQN3Yz5vZTA7qA8pT848OJLWo/oLX/
 xPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739215583; x=1739820383;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=msS68gvM43idtk576E/ah7clspzQyq0+dANrbHf3jDg=;
 b=GHdTaOvX0ztFXGVcBwpdaSxhZeALSJSiCfDqhIp9q7Cj0li5vYDcX6gvB+ItBC/C56
 Q8gSHS1o1wc8nIXp2o5RKgTsfbeCPXY0q+4EIk3F9vebGD+I6jdi9CDm3rXMP+dZdbC9
 Uy3o3jWv9AmVaNDd0T0tbmVxWDpJtYrPKcGfcS6wYCSfc/BwPLfHkK+jJY0tV6X+6VhJ
 lwOgVmcJgDIzHKXi165cdT3kbMTY/DyOq+8F0Yp/W074TpKwCoxo0YJnLpW5jtbvC5vk
 L6JY7lfCtR0mNL/n6N9RYVyvRtS6YkNj9Ej0ZQLJSuUMThJRBx9BquIeNknPuY6Gz+Y4
 z1ig==
X-Gm-Message-State: AOJu0YxPhsz4/yj7o2wjuA8xPNY025jCvhXsBWWbmyip2yEVWM7vRAof
 arrkGz9T9Xm12YZiBmkX6h4HsSFgz49F3JWG83qnprbazZXTrLiylZ82H17szdu1++8R22Ab2qO
 i
X-Gm-Gg: ASbGncttHDNlDxN+CF5k7Q/ERILVtSK7NBTj+m/L7HcSpd4yw5D0gLvrwp/NBTUqKfT
 bis5uQjtMZ9+NMjwmYgeP2mQ2ZqDRFe47JNmCWHfSkYuhuL6axD86VJYPHmL+rkjCDo5p7EnfA1
 KUciaoQriEAl9bFJMMqDFN+NYgwjPuuvDZ1RXs0RNkis4JCcZdU1jBT7wIO4H0Y0k8hmIr29z8g
 5ePzEzPa3SKcPo7KqkjnRihTMH/MB97HDJw/CzFjS5f7/lKOQQf1lu0f56vwFy57lMgvNVLVkr0
 sRL3Yx2EICzmFJq/hMmUqK3AC8yHrRumMfDI+pC5tkABuepzxQctO8s=
X-Google-Smtp-Source: AGHT+IGqDp+XVsbj4xL/P9bQPxtRMopJXdrD8Mz27FWhVPDKFGtzDtqgIZAjIhiwg8NQul2mIAf/eQ==
X-Received: by 2002:a05:6a00:99a:b0:725:c8ea:b320 with SMTP id
 d2e1a72fcca58-73217e64a13mr1181055b3a.14.1739215583501; 
 Mon, 10 Feb 2025 11:26:23 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7309292d439sm2022177b3a.174.2025.02.10.11.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:26:23 -0800 (PST)
Message-ID: <aec38cf9-29a9-4f7d-8bd3-a0def5f5e81c@linaro.org>
Date: Mon, 10 Feb 2025 11:26:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] target/arm: Support CP_ACCESS_TRAP_EL1 as a
 CPAccessResult
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-10-peter.maydell@linaro.org>
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

On 1/30/25 10:23, Peter Maydell wrote:
> In the CPAccessResult enum, the CP_ACCESS_TRAP* values indicate the
> equivalent of the pseudocode AArch64.SystemAccessTrap(..., 0x18),
> causing a trap to a specified exception level with a syndrome value
> giving information about the failing instructions.  In the
> pseudocode, such traps are always taken to a specified target EL.  We
> support that for target EL of 2 or 3 via CP_ACCESS_TRAP_EL2 and
> CP_ACCESS_TRAP_EL3, but the only way to take the access trap to EL1
> currently is to use CP_ACCESS_TRAP, which takes the trap to the
> "usual target EL" (EL1 if in EL0, otherwise to the current EL).
> 
> Add CP_ACCESS_TRAP_EL1 so that access functions can follow the
> pseudocode more closely.
> 
> (Note that for the common case in the pseudocode of "trap to
> EL2 if HCR_EL2.TGE is set, otherwise trap to EL1", we handle
> this in raise_exception(), so access functions don't need to
> special case it and can use CP_ACCESS_TRAP_EL1.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h        | 1 +
>   target/arm/tcg/op_helper.c | 6 ++++--
>   2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

