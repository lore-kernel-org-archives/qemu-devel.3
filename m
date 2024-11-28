Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46158D70DE3
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 16:47:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGhfG-0001uY-5O; Thu, 28 Nov 2024 11:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGhfD-0001ts-2B
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 11:46:48 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGhfB-0005w2-1O
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 11:46:46 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3823e45339bso766639f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 08:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732812402; x=1733417202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EwOKRV1c0unBwmZqya/i1H+QUXgqDtyYNKtve5ADmRI=;
 b=Qzw80BvDnKUPkM4Edh3gb95yY6sa3z6tBF+GI865PZhhNyVNZP/kAPhsAwPJ1eK0ZZ
 gbeCzzMv+4FvnkgU6/Ngg0HqAwWaUMA6TmyoR2dfDi6RbvScyECWGqTsro1sc7I/BLNs
 c/6PbsKGQKN/tx6ZpAJ3W3Un4OeIvJ4GkkDQOU1bPr6sBIK9AOKPpeIN1OAyV8BG3lIX
 JuPkcNdI847oGTv5+JS+gfT7q7v/I97KwJpnBAV04HYkLwEGAqBZOYOTTxf7IlHuR/Z3
 WQPnzl33/yBOVfiHRoOvomHypRPr/8mTPcUwzsd1pkmc6c9PPNlMsMa8EAl+Fmfpo2hc
 UFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732812402; x=1733417202;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EwOKRV1c0unBwmZqya/i1H+QUXgqDtyYNKtve5ADmRI=;
 b=e2EpbG8P6VtdYSQ/9bUF6+JXuzGJyeqPpQFjcjz/7SLrMv/iWr0Sgbi5B03YHig+OT
 +xVfsVbAuGwYD1CJY2wQQJutPqBpdxg2hQ5D6fRbatvWcLEEvnQHMiI3P8JDUcR2SeVQ
 MRfIkjuWhT5njlmWFzlnle6N2LiTPSwFT8/Nel5BrAynJzOdGC9jNCUQ/jbPvzQfPVut
 jNwSnVk4GLRkPzrAVk8RFDFr/9x/0krckht2eN32vH0+53o+zKsCcESwcytqparmSt3p
 BEvmbxMBeEkeUVwkRkQb8Ly0BKA8GwGQ6Y0OfG5/Iqj4pj/UbW2nLBRnFB6eAAQvNx6O
 48BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRl/GWp4h6JlAPFrP/jchdG2ijTSxoggeU6BK3kDvC+BacDI+wAr8M34WgoR7dC9bhsmH5z6zyeDF/@nongnu.org
X-Gm-Message-State: AOJu0YyVfODuYCTRcxkjH7uqqe/v8+S8U7F8CLWI97el/McU2TvO7HwN
 6eNeMZ7vrfosq0VaB69X89htShgZvgzjK376YEe12mS6yaZ9x/O3xfYEm64HuYs=
X-Gm-Gg: ASbGncvuKwDUjsUKZMirGjHkuR2wj/hcHLexV6UM1h9f863SOwctkTSSbnhpidqdmzz
 PbyMo106pSodKkYzD0H5C7kPBi7ms1gPNGvvy8iwZuhsNlDXJk2N9fceWIzUaozoh7QKHRgvbBw
 68S6YxdiwWo/5PlfkcIPJqu4PjL8/BG03sOdWasYu+TUYhK/djL4m8usn2ZQ26ht+kC5Te7aGA0
 juc//4FyY5+naBF2/amd9dI/bxStmw6WwQD4l5u3Bz82ulG1rUJp6pVeDzTBT7PC4TSuSkX7IGJ
 yhbUB9AgC2h8EYMUkrn3
X-Google-Smtp-Source: AGHT+IHQzULr5uvxakNF1ITghpVAkvYqmnyNnA2TLjE8aWFEUy8+tmGTkTj7tFxUquqyIBQi9rd5TQ==
X-Received: by 2002:a5d:6d08:0:b0:382:4b40:becc with SMTP id
 ffacd0b85a97d-385c6eb7f82mr6333988f8f.3.1732812402514; 
 Thu, 28 Nov 2024 08:46:42 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd2e940sm2041864f8f.15.2024.11.28.08.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 08:46:41 -0800 (PST)
Message-ID: <e9404dd2-56d2-4c6d-81f2-76060c4b4067@linaro.org>
Date: Thu, 28 Nov 2024 17:46:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Fix kvm_enable_x2apic link error in non-KVM
 builds
To: Phil Dennis-Jordan <lists@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: "Shukla, Santosh" <santosh.shukla@amd.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, mtosatti@redhat.com, suravee.suthikulpanit@amd.com
References: <20241113144923.41225-1-phil@philjordan.eu>
 <b772f6e7-e506-4f87-98d1-5cbe59402b2b@redhat.com>
 <ed2246ca-3ede-918c-d18d-f47cf8758d8c@amd.com>
 <CABgObfYhQDmjh4MJOaqeAv0=cFUR=iaoLeSoGYh9iMnjDKM2aA@mail.gmail.com>
 <CAGCz3vtTgo6YdgBxO+5b-W04m3k1WhdiaqH1_ojgj_ywjZmV7A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAGCz3vtTgo6YdgBxO+5b-W04m3k1WhdiaqH1_ojgj_ywjZmV7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 28/11/24 17:38, Phil Dennis-Jordan wrote:
> Paolo, could we please apply either Sairaj and Santosh's fix at
> https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/ 
> <https://patchew.org/QEMU/20241114114509.15350-1-sarunkod@amd.com/>
> or mine to fix this link error? As neither patch has so far been merged, 
> 9.2.0-rc2 still fails to build on macOS, at least on my local systems. 
> I'm not sure why CI builds aren't jumping up and down about this, but 
> neither the Xcode 15.2 nor 16.1 toolchains are happy on macOS 14.7/arm64.

Just curious, is your build configured with --enable-hvf --enable-tcg?



