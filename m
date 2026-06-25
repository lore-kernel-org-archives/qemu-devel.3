Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CEDCDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclSW-0007lE-5K; Thu, 25 Jun 2026 10:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wclST-0007kq-QZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:53:38 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wclSQ-0002Wf-TC
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:53:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-84536e2857eso1578165b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782399213; x=1783004013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pe8nWvLBfzygNZPWMRaT+tp07NOPD0PfoMgkrq0GbTg=;
 b=t3CsBC0iA6nCt2ZpXwN4RtEfRtJAhTb5DhI0rQKQoid9AbHx6WkaeI04IcTqapSPIk
 TNFLbBVlsuJeFVRJCXLYPj3GqfQBO0D5kUy8QtEp4Rv7vx5FbLZUCHRNsPVOgwjZ7cSU
 KLEclDd3YMe+Vgj71MLLfA3oXEFzY6vc7IFsXMZYf9zcKhF5heAtryvVp+esuAyWeUYv
 /7JKxubPTfBpOFfpUArZV6UqxB08LWGhjwPtOrf+Wyn9wh9DLZMeeQQUDl0eC3RTwv7Y
 HWJ8vdkJF7aaToF/pqIfPCIubLoMSzxqNYArLLIbtz2JRR9X0ltqZgXaP37ZlVMvSW+N
 0fMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399213; x=1783004013;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pe8nWvLBfzygNZPWMRaT+tp07NOPD0PfoMgkrq0GbTg=;
 b=BQjezbbZ+kbYh3/T425CwHuY55UTBCm8SrOGWevOgszMuj1dy6hLMbJE8BDMWX2iYV
 +Wbt7DKXJYDsVhYSHk/NG0ZWle8zAyrPoSbiPQXA+vTtl/JqTc7Xj0Ot60aSAlXkOVvL
 u5x9RQgYZnTg9YkvXVBgzay0bjSdgc5H6K11DQRz2C2uJQnNxQc7PMC6WXR2j6uQH0ru
 yrhlRI2X/TjG2oX4E/xHe2DjmkyveNITozOB8euQ2kk/D8uAtT6FeWjpu4KP5PhgRQ03
 l6j5rpz5xBhR4gPPbWw2G6r6mt+Lc4ljCgIupF5NqNPKSaeSLp6QpE7jLHg77jq8aCUT
 iyeg==
X-Gm-Message-State: AOJu0Yyl9vDHVjpAGAfjTM8+ptLNCD7/gM6S3uqPx5OUH7s7Kcn9vPXu
 rNMB3R7Qdmzqo4euv8bfK01sLe0+v0esuKUMF+2aO3VgPXq/CmLBpBYDtHhcIww5Cjc=
X-Gm-Gg: AfdE7cmxGIcUYa36dMH/+3flZ8CIyjtC39KiFikEGEnqKaFiwwp32/iwENTG2eqcYYV
 4x8PGSm7Vo6FKR/K+VBC+bywNgznNSlSDwbrCXCUF2dMVY+tmJR2gNfawp6sm/e1UV2tmTgSNgL
 zVDtvJXaMQn/qdP4bipUQAwjARZBKUqc2dxDVipySy/HyhpjXZrDB7AWAj+B2+S7Ph3uefkpZNl
 vTZ6CgDrkTA7SU3ceyEqq+Y6HEOxV/CxN9J8W6LPpPmWeZn/II+X5H8hPJ4CU9uKMGt+UYUKD7g
 gSTXibx4CfzAaDYyTpgeu11kud3dN25lZO59cSqTFIF4t6bfX41sTE8anx9WyrpaA9IyUKVgvC1
 w4KSWBNfwR3dsWxPYUPUBqCX6eGjJ5KZyMcY71Sky0bKnbegCGAcxZfd/rA1iyQVScbmt3nSDVd
 5kk81YyVypdp+Km3VnmDiyZeQupptndtFRQ/rmq+CT9YueOz+wn3V5y9qUyA==
X-Received: by 2002:a05:6a00:1989:b0:845:bf3f:48de with SMTP id
 d2e1a72fcca58-845bf3f4983mr868469b3a.8.1782399213278; 
 Thu, 25 Jun 2026 07:53:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845bda73914sm621887b3a.10.2026.06.25.07.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 07:53:32 -0700 (PDT)
Message-ID: <5e16178d-a65d-4606-91fa-1a4700fd1ba3@linaro.org>
Date: Thu, 25 Jun 2026 07:53:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tests/tcg/arm: Tests for new FPRCVT instructions
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
References: <20260624-jmac-fprcvt-v2-0-dc6cf8e512b6@linaro.org>
 <20260624-jmac-fprcvt-v2-6-dc6cf8e512b6@linaro.org>
 <87qzlvhued.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <87qzlvhued.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 6/25/26 01:54, Alex Bennée wrote:
>> +ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
>> +AARCH64_TESTS += fcvt-fprcvt
>> +fcvt-fprcvt: LDFLAGS += -lm
>> +fcvt-fprcvt: CFLAGS += $(CROSS_CC_HAS_ARMV9_FPRCVT) -DFPRCVT
> 
> Do you actually need $(CROSS_CC_HAS_ARMV9_FPRCVT) in the compile?
> -DFPRCVT handles the compilation.

We should need the flag.  If we don't, then we're assembling the wrong insn.


r~

