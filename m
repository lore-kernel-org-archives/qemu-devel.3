Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6338BD58B00
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4eZP-0002CP-7D; Mon, 23 Mar 2026 08:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4eZN-0002Bs-3v
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:39:45 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4eZL-0002e4-Jd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:39:44 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-798374d0f44so70927277b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774269582; cv=none;
 d=google.com; s=arc-20240605;
 b=N21G6ijSabUbo7kB/bvFQQt//jElw4SX+XixvErEjPm8AHihirtSe+ZDSjO7SrQNHm
 0jFsy0hEksYvL5yR/71D5cRQAXkdyyWzzmMSNs9XP+cEHoh27BB/nECumF71AcR7W/5Q
 yy7FsgFY+lPT6cEAHFozAWyd4jDmgwC+1DKu8oxJhpx+O/yNwNGw7SGhticwcnhP5ISg
 0mH41gG30wAsGMxuZvkNemQLkNKLw5Q4bAlTXHaZeMDtoR+oWzyc1NPbafdA5seKaHqr
 YzkOtvbsJCHTLzbNUdPezfIZfmAFhDIMUGSfw0VIHiGrgfEehZlAfjLGMampKs4/+swE
 4oVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R7JL3klp5R0qHeWkPx3riPndEVfG7uwqPmPnbUGg0nU=;
 fh=Ep0uaJipAhObsWjFYu6sRYa/1NUAk1w0dh43gVx3LDU=;
 b=lLdFT71bYQRP+bjlwURFFZEQITu5m93oj2yxy9jMc2c0xQpEYy8NRdpyMxTUV/Pkjm
 R5n52PWvO6UP34flfFiIPfKAlWZCYjNLwLOjsMU7oqdp3p9+grmVBEGmzrEYsOFz4d1o
 cFM6BnLOQ05HUHHRJxH4HT22PukINKZZyAqRueLZtKUBgPNoA1Kt5zjbhj4pcATrhLcM
 Ws9vi+peZaR65KZvkh6F+VBvgkZD8KO/6fftA615oCTlDm/tNqPMF1fjh2wr5R1C5Jl9
 RcSI5Bad3mddu2B2CDRhL/IFnk1M2qbSkTzhFud0Aud3RHdRdSU5U5raSIqMq2ezCLaa
 Uvag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774269582; x=1774874382; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R7JL3klp5R0qHeWkPx3riPndEVfG7uwqPmPnbUGg0nU=;
 b=awysDPJ4ugnWD7OjiWOIKBj9JwogB/qP0bfbc/hOC0mFeJGyxRPeS9df9YH7GLxKYg
 xPYbQRMxmyUAocmXkgt2wumA029SDqwcWyw7TWyiI+J/48C/FTFyfAgXbDNeUbF5tRM3
 qKSuAYxE6waav2QcZeqZkUrJH12CCOdvFchGsPDfvdnP4LCmGQOm7dtvOYtoc3MD+bDi
 Y9WLVfKMIO2Yhjdb7H+pK5F/M/ZxX1NVNpNiXc/RwK/1Y+dpLZcQHgf96Ib0u1PTrMhn
 sWZrd7eBmiaQaQOOW9qcf/3bRFdujRhDXb4dk9nuJtdBBuVC/WHEbm8IGbEoE6o7GzT7
 cyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774269582; x=1774874382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7JL3klp5R0qHeWkPx3riPndEVfG7uwqPmPnbUGg0nU=;
 b=JYCZEP2knNZylm/nv9C/jvvMEfwM5RMexTBSKLmo7SywGfKii3nNaP17fKcGpVBfeL
 tzuV3VzgfYRInUPBWvpXRxXqm/uRD8m9wBVOCpg/pZVTaLJQoyQO0As+QwtT4zXpbDcj
 hpDu7jxDkMvioQCTXk1DLQ92hefOKEVMVW8aCIEwZpdbDdKWUTv2zIP2sKV5LWAa9Wfv
 ZX8ZfyPrO/46Lcri7108Xnq+Y7vVX1m9lILAbQSHpmVJOKRfRjLUFH+M+/5rxAx9Olx6
 TYlKiBRlyvYS5Y6ku56DqJE9xrZWKnezCZBUCor19zd8CjiBMglqV66kmBzPe0bJGG+S
 NaTw==
X-Gm-Message-State: AOJu0YzZ/DEoOauqnMyQGhqVVb4/i9oKPHsC+kN3G7QIZHU0PATbk5kW
 FKBRjf79chZdDA3MLGL1zdqu+iiCXXB+D5OFoY98woQsXh1gCKB+sxwVf3nxcBivAm0rqRl6gVY
 BoyyDKiamkKkf4pOdlEy2xKATdtMFX1mvCmYX4gyOOw==
X-Gm-Gg: ATEYQzzYpmZzavnX5a72H+5OqMdAekmUFfkoKZCxgK5czAUl2Yv9ngh70XenasuI42W
 LWNEfR+veimR3r6LscFAIXe7Yl/xvcObKI2u8w5BBr2bJZkSjhtsaHdMN70TOd43E2y7LKr7qcq
 SF3TzgCK7cZJAreDKgKRCYZWIwo0WMAhaZ1JftRFT4HhjenxdPDsJ89zcR6meB5zNX06RgYyOTc
 w+fpL1Pqoaha9XCIFlise7gI0Q8Q8sQ/1ISN1+5idjsZptajEjPEIsTQxi0kRpFmcSqLaMLP96U
 Bfqdj9kxkYFP32ECF3jXXt5JS02OF9q4RG/F3HKoYAzvmoKf2ql0hU77/uj8NNHbJhE=
X-Received: by 2002:a05:690c:e3ce:b0:79a:b586:7389 with SMTP id
 00721157ae682-79ab58679f6mr29605587b3.20.1774269582257; Mon, 23 Mar 2026
 05:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260323120613.355019-1-magnuskulke@linux.microsoft.com>
In-Reply-To: <20260323120613.355019-1-magnuskulke@linux.microsoft.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 12:39:30 +0000
X-Gm-Features: AaiRm50mw_b035xTPgZi3DJMUYXQE3ixuwng2zLVlN7HjkzA_JX0TX9uraipWxI
Message-ID: <CAFEAcA-EfRkCXWu061c1uZsW4BC4qKut_uju6U4NyiNuYbf5EQ@mail.gmail.com>
Subject: Re: [PATCH] include/hw/hyperv: add QEMU_PACKED to uapi structs
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Wei Liu <wei.liu@kernel.org>, Aastha Rawat <aastharawat@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Mon, 23 Mar 2026 at 12:06, Magnus Kulke
<magnuskulke@linux.microsoft.com> wrote:
>
> The uapi definitions are marked with __packed hints in the kernel
> headers, since we want to keep the contract of the Microsoft Hypervisor
> ABI explicit, we should also added them in our vendored files, with a
> few notable exceptions where the attribute is a noop.
>
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  include/hw/hyperv/hvgdk_mini.h | 37 ++++++++++++++++++++++------------
>  include/hw/hyperv/hvhdk.h      | 14 +++++++------
>  2 files changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index cb52cc9de2..7d7b2e9b36 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -7,6 +7,8 @@
>  #ifndef HW_HYPERV_HVGDK_MINI_H
>  #define HW_HYPERV_HVGDK_MINI_H
>
> +#include "qemu/compiler.h"

osdep.h includes compiler.h, so it is always present for all C
files; you don't need to explicitly include it.

thanks
-- PMM

