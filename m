Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E182BC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 18:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thYmE-0002LF-64; Mon, 10 Feb 2025 13:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thYm7-0002HU-J7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:44:56 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thYm5-0000OH-PX
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 13:44:55 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21f6d2642faso56363125ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 10:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739213092; x=1739817892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H3moLxLewMxzs0CS8P9mcRcDeLqv7d096A0lcW9I63k=;
 b=l6jFygqjKYmC+Yc4Bm+yhX79GWlJLNNLE+QOV4AJW/6KHT4biJyxnPzO7syKQc1Kci
 Sq6+p2/SZG35D6f5B95CBXaOiGGRpg8IwP/5+DnFQcqJoQ6KCjHu/jm2jybncnbTx5QS
 yQg2ipu4kNXkUCeZBOFzwklDqgducc+aDUAW+a+27S713V+OPld93MekFwk5arl3BPR0
 OLxwzZ2V90ty8zOHY0AZHfmPzz+awx5V+TlWBDMgwVI03numx6/x5dz6icF7OFpeWhcy
 DdSEJ4c/ZmqIm+pTPIwYRaGr6XCqFx1qWi7+sFF6zXLnuNWAqqACwdceTz5MGqMec9Y6
 lC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739213092; x=1739817892;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H3moLxLewMxzs0CS8P9mcRcDeLqv7d096A0lcW9I63k=;
 b=cZcQCAcxhAnimBC5iMcgUK5a0hsHEjm0OfqqEEJ0ViwVPZI03M+iR5wL369WF0N3yV
 I6W3DsHNI4YWOnwTRGk+MRo2SuTpzqrI4lCMc2nNmKCNlNwHy8GJSoVxIz/wmYhG8tlN
 QsecTPaBODSgCj9k1o2zS7kKBlC6d5XIrETi0nyPddg76UzMVJqBcEmaplJtYRahDNQi
 j4TnML55na4RGOPIvQUzgw+hbmrABRulSI2NjdUSbYkXr7CdybNfWGbj1lj08UcIXENi
 528KvjAzYomJ3ImKVqMKiKMf9AG5NUGJLL64pWPLjvO71fDdGp50kGQnFyLF34qAGsV/
 OcMw==
X-Gm-Message-State: AOJu0Yykd/ma23djMX5Sj3F8FpTRFbxOJ3I+s8fCkJ1P67mcQTstp5Dk
 8PBw6DT4skfDUR7FUjISkGEEn+ZSn0ydpnzAalndDmoSUMo67aaJsCttDorvF3ywUhZM7n6G0iL
 +
X-Gm-Gg: ASbGncsA2MwC3ZDhSadSbTSQi0ERu6kiXi7F0LEcztw8IuhtbcX+0TDcvuSdnKkYd65
 0VOjy2WcOu5rDJD0FEQoaYqxaRYuyiamKXvxwH675/vWT4K96UVMCaHwvvllZ+6fj6IFWBTZvjG
 O3q1KDXWItptczYm4F3Dkenkai4Ma8LWhj0QIfBb54mbNv1QOmnTZvUpt9XKgquLbb1ipHFxvlo
 BJpEoPNyef7BByzsySgTYpT51VBVqavKS+Dwc/vv0YnlJBatHe6jIDPfpmLZjAMW89Q7G7yxxMg
 NzznCHYig11jgQoyoS9hVfy5LK2DZJvUJRHc2OB8Y/wb5Ks0XgPqQw0=
X-Google-Smtp-Source: AGHT+IGTRQhfcvwiemVZUahhGGOJ9T3wwaXOQfMrsFWAQFA/XuwJhovIzThJW4CgfP4vjJqgDOlLfA==
X-Received: by 2002:a05:6300:668b:b0:1e1:9f57:eaaf with SMTP id
 adf61e73a8af0-1ee03a242e4mr26267043637.6.1739213091796; 
 Mon, 10 Feb 2025 10:44:51 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-730878016d6sm2945446b3a.21.2025.02.10.10.44.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 10:44:51 -0800 (PST)
Message-ID: <fcd1143a-40f0-46b9-898a-9a04cc7ff471@linaro.org>
Date: Mon, 10 Feb 2025 10:44:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/arm: Report correct syndrome for UNDEFINED
 CNTPS_*_EL1 from EL2 and NS EL1
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-2-peter.maydell@linaro.org>
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

On 1/30/25 10:22, Peter Maydell wrote:
> The access pseudocode for the CNTPS_TVAL_EL1, CNTPS_CTL_EL1 and
> CNTPS_CVAL_EL1 secure timer registers says that they are UNDEFINED
> from EL2 or NS EL1.  We incorrectly return CP_ACCESS_TRAP from the
> access function in these cases, which means that we report the wrong
> syndrome value to the target EL.
> 
> Use CP_ACCESS_TRAP_UNCATEGORIZED, which reports the correct syndrome
> value for an UNDEFINED instruction.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: b4d3978c2fd ("target-arm: Add the AArch64 view of the Secure physical timer")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

