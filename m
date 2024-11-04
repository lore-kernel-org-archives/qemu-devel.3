Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8282D132AB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ufo-0001E7-Hk; Mon, 04 Nov 2024 05:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7ufk-0001Dk-UI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:51:00 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7ufg-0003Q4-R8
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:50:59 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5ceb03aaddeso4207266a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730717453; x=1731322253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gclXQ6NgDPQejj3W6tl371AcJXzxEWWNEMLWWOTGKfk=;
 b=E2seSSsms6uNeODnYpAA0rDx0BVgbGmhqzldTbPwUXlF7y0ik2ft5JdG5OKJw4cs0W
 mg3KjodX9zDHI8CPiCEyBl39LGxpDBEzzSK5Z1AR7+n1lljHsvASS2rWdMkLBalA+vHm
 A1AResLYdN3njaYJMRjBzfjwYRmy8W0+FN9Lern488pmiCz7rC0lkgeXEAS47kaJH0j6
 s6/XAlvaxFkx9esQzwZJ56FMCg6ClzcvtLeyKTlbWu64K9Cu3bvJVX+NEEWIVE0X0xc6
 uwZS3ZG+/ndK0PrJ06m14ijzclwqR12q2Et1daaw64mqT1KnI+C06lddfapIIEGZOmFc
 hJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730717453; x=1731322253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gclXQ6NgDPQejj3W6tl371AcJXzxEWWNEMLWWOTGKfk=;
 b=wWO2QsaptgyZnXeXJ/YHe/yNI0mmqxb158dGO75WVyV6ilc+Zy6yTJ2xtWBwOcugt7
 tOsQrOiOHNOzQc1CJ/wV2D/Z/zVG25K76/IqclGJUVKz18KTGOdCYxuUeVui/3KuRuju
 ymONEmNRjzoqe96o8yvH0wAzL593TqU9cI7i0mRr/7h4NVDz+4HfLb2UTnbKhzgQ67Pv
 tcG70N2AwOSNxcq3T0vogb+VAXbDHCZuVoESNn1n/zMpxhkKtk3oDiGv0iRlaIu8oG9n
 CalBDywsdZ/uxa9XEHW1o5FAOMIgbAHDjG6TjN5e8mvIRzWs9hRaPI9cwk7UmDwv7gTX
 dTYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlLXMxIcUhpc4rOBipLmY8cb+ynz0yRwE7bJ2WWEt4mdaQPLkggoZeiwTtK98A/XLryukt2bgjjb2g@nongnu.org
X-Gm-Message-State: AOJu0YxhoWMm2NT6xq76ysCglizFWTJSaoO937Vu+BZMuT5Z2agWdsTg
 TMDlp1NyjOjp1aZi2KngZbyqwVgsHsPOEvBVkO9ZJ9VZcqx8+XzIzXSBJvFQEoo=
X-Google-Smtp-Source: AGHT+IEV9ywGBbr15GOvc6rij4jjEQpde9nyt4wfhpIYatlIVTQFcFdSd9PmFKzcmYJL/u72lycQJg==
X-Received: by 2002:a05:6402:40c4:b0:5ce:b113:f38d with SMTP id
 4fb4d7f45d1cf-5ceb113f6acmr11890018a12.28.1730717453059; 
 Mon, 04 Nov 2024 02:50:53 -0800 (PST)
Received: from [192.168.21.227] ([91.223.100.66])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac76fb46sm4066687a12.26.2024.11.04.02.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:50:51 -0800 (PST)
Message-ID: <0e767aee-f9c6-4efe-a91d-40fef98a285b@linaro.org>
Date: Mon, 4 Nov 2024 10:50:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/arm: Add new MMU indexes for AArch32 Secure
 PL1&0
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241101142845.1712482-1-peter.maydell@linaro.org>
 <20241101142845.1712482-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241101142845.1712482-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
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

On 11/1/24 14:28, Peter Maydell wrote:
> Our current usage of MMU indexes when EL3 is AArch32 is confused.
> Architecturally, when EL3 is AArch32, all Secure code runs under the
> Secure PL1&0 translation regime:
>   * code at EL3, which might be Mon, or SVC, or any of the
>     other privileged modes (PL1)
>   * code at EL0 (Secure PL0)
> 
> This is different from when EL3 is AArch64, in which case EL3 is its
> own translation regime, and EL1 and EL0 (whether AArch32 or AArch64)
> have their own regime.
> 
> We claimed to be mapping Secure PL1 to our ARMMMUIdx_EL3, but didn't
> do anything special about Secure PL0, which meant it used the same
> ARMMMUIdx_EL10_0 that NonSecure PL0 does.  This resulted in a bug
> where arm_sctlr() incorrectly picked the NonSecure SCTLR as the
> controlling register when in Secure PL0, which meant we were
> spuriously generating alignment faults because we were looking at the
> wrong SCTLR control bits.
> 
> The use of ARMMMUIdx_EL3 for Secure PL1 also resulted in the bug that
> we wouldn't honour the PAN bit for Secure PL1, because there's no
> equivalent _PAN mmu index for it.
> 
> Fix this by adding two new MMU indexes:
>   * ARMMMUIdx_E30_0 is for Secure PL0
>   * ARMMMUIdx_E30_3_PAN is for Secure PL1 when PAN is enabled
> The existing ARMMMUIdx_E3 is used to mean "Secure PL1 without PAN"
> (and would be named ARMMMUIdx_E30_3 in an AArch32-centric scheme).
> 
> These extra two indexes bring us up to the maximum of 16 that the
> core code can currently support.
> 
> This commit:
>   * adds the new MMU index handling to the various places
>     where we deal in MMU index values
>   * adds assertions that we aren't AArch32 EL3 in a couple of
>     places that currently use the E10 indexes, to document why
>     they don't also need to handle the E30 indexes
>   * documents in a comment why regime_has_2_ranges() doesn't need
>     updating
> 
> Notes for backporting: this commit depends on the preceding revert of
> 4c2c04746932; that revert and this commit should probably be
> backported to everywhere that we originally backported 4c2c04746932.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2326
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> The regime_has_2_ranges() part is correct but does leave a minor
> beartrap for the future if we ever do for some reason need to
> identify "has 2 ranges" in an AArch32 codepath...
> ---

Series:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

