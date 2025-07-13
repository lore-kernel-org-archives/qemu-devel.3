Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A070C83F17
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Jul 2025 22:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ub4ka-0007NX-US; Sun, 13 Jul 2025 18:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ub4jL-0005sO-At
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 17:59:34 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ub4jJ-0002HU-Nt
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 17:59:31 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-72c47631b4cso2471481a34.1
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752443968; x=1753048768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F781/ZweNMEa/HSDrQo9cJhkIzkPsp9k1uQLm+4+NUQ=;
 b=LCsYzqfmmmiVEhlOgQWjo9mrTEGjWYGrOE0+6QgaM2/6jxiLqH1i0pYC0/z/Rmu1aS
 S0ywO+FaEnzMvmpc/IZbeXGpFlZ1v18AkIFTw2oa6jSgEb+BdSS8+R5Oxs4Yr+j57++K
 GCIVD+r8mP5C1TSge2mr6/nYTPb6LqcDHJsiOTDu2HitwSqM+qMZH56O07cgFl5T6MlC
 gNQ7RYCzlKST+w6/tz4SxCxJkbhoSAXUiBbE2GFcq0fwmFzo3zHfLF9mAZCq11WB/3XY
 c+4WezG6Jrt/OzxWEDhDt7DTG5aTKrfsyDOd/e1U9MkW5fVHvhUpVdPvlIBukX6Il67Y
 72HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752443968; x=1753048768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F781/ZweNMEa/HSDrQo9cJhkIzkPsp9k1uQLm+4+NUQ=;
 b=HNwp3qB/mPoMnxdy5GUmv7xmntJld2z8y7fajIFoXZGY6yVykY9nUKYKouIUVkJWgb
 tIHJfr+zXe1JopAC/FLVyUMkuSW9zssbcHkXw/825ATGLRkYoI+Y+Zunst5T7Btgh5XR
 98ZQY3jqTh9vVGT3yrMXbhu2Yj5HD3uh+e2ZLDgJaKusnyJqUr5bkHE6Ei1+CUBsJnoS
 s/7NcAEc2BC0pMbbdmG/Iv5sAxI4wi0HpBuDNKq4tDL7/3WtPfck8qsIdHn9Gn73VUWC
 KmiRGsvxZ84BGB8U8AdvXTibRUi8i3iFUZk2cLpHSm3x/I5mle9eYuWS6+M+BRq/8uHE
 SUnw==
X-Gm-Message-State: AOJu0YxIMBBXyRYyEEu7EkU4njWeGQJ3SsmSyu7hGCIy7XfCr57LYlUp
 sTYbllkpqE+rp6avh5kYK1a3YW1xsahhz27zgJjHeOtComSYfMe4G4egcgN3xSfDn9c=
X-Gm-Gg: ASbGncsk+RigPqasjQXP2ODrmsVEFssTGHdcigQlMQh6v2jl7BuA04AwHeMfBFcY1vk
 Wx9vCm+tCfzyCwU84reLXyRVTa9bB4lSi7umjjslvhgCHfVN2YlsILQZR/t/zbxcnrinPf1CDWF
 cgAg1G0QSwetVH0kAaMPI5q5X1W++JQ0vRUCjFf0sKMuDu2fu6fkHKQe1tkdRIc2tcCXvMApzZj
 TZXdPNobCccatG5H46xv8z3yTpx/BaEFD2cI2Yrc9bvjHLeWEm4X2+Lo+q6GlKDWLGjPpE+cRBt
 PRMLll2ncaueWHoU+Sha+b1CVlxUYzS5IjqxJ00ZxdOYK9FzPpQkGsUl/gr2wg2fFaXIFDFLk8E
 aJdRlHI4AfGDxl3g8St0Z7uMhAUrcvFj226XLoyw=
X-Google-Smtp-Source: AGHT+IHn5yu02dAQgwR7An95BbiRtPADOwZiX2BwJeFLdxmE1bIl/Acng/XutQ7lHbdGXjS08SgnSw==
X-Received: by 2002:a05:6808:171a:b0:40a:56aa:c806 with SMTP id
 5614622812f47-415397b924bmr7292461b6e.22.1752443968212; 
 Sun, 13 Jul 2025 14:59:28 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141bbde341sm1335946b6e.27.2025.07.13.14.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Jul 2025 14:59:27 -0700 (PDT)
Message-ID: <21bfbfaa-f0df-413d-bad6-b69688ac381a@linaro.org>
Date: Sun, 13 Jul 2025 15:59:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] target/arm: Add FEAT_TCR2
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250711140828.1714666-1-gustavo.romero@linaro.org>
 <20250711140828.1714666-5-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250711140828.1714666-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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

On 7/11/25 08:08, Gustavo Romero wrote:
> Add FEAT_TCR2, which introduces the TCR2_EL1 and TCR2_EL2 registers.
> These registers are extensions of the TCR_ELx registers and provide
> top-level control of the EL10 and EL20 translation regimes.
> 
> Since the bits in these registers depend on other CPU features, and only
> FEAT_MEC is supported at the moment, the FEAT_TCR2 only implements the
> AMEC bits for now.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
This causes a regression in tests/functional/test_aarch64_device_passthrough.py, by 
continually trapping on an access to TCR2_EL1 while the HCRX_EL2 enable bit is not set.

Unlike the similar SCTRL2 failure, it's not 100% clear to me how the guest and nested 
guest kernels are related.  But it is clear that the outer kernel does not does not 
support TCR2_EL1 (and also doesn't manipulate ID_AA64MMFR3_EL1 to hide FEAT_TCR2), but the 
nested guest kernel does support TCR2_EL1.


r~

