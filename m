Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20C6E8536F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8gOH-0000O8-6R; Fri, 03 Apr 2026 11:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8gOF-0000Ny-33
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 11:24:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8gOD-0004KP-0N
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 11:24:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483487335c2so20665045e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 08:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775229891; x=1775834691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oPRuMBTp2qSn1gANhoA1+5oBJwwPs87xbXGdROwdpQc=;
 b=F8jXtmlMk6Brq8SjQ+WKWdGn446iOtu19FWkutCWwT0plYzetwVgU8pG7M9e/drboM
 nssJYCIkIEsob+dzh3DyBp3ZMopQYHYnZnAgtkc6bR3UgMkelxY2o3OsZakF4lJtsYoc
 QLvrvXbmtAYbm7JSyMOLHRGlEsKjynevVUVTulgrPehrolbSSFkbrTQxoJeVdn72x1R1
 DRKosP8rgeHbx9rYzJs+pY2vkeohvJNknczckzEogFx0In2sAsdH6JqLjpmU05ZuQ287
 KKx+RqkLN89V/nsujjFuTH4pSpncrtS5WahNdN4Ry7WLbzvqYxNI8XOTb2y9urlko+y+
 OXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775229891; x=1775834691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oPRuMBTp2qSn1gANhoA1+5oBJwwPs87xbXGdROwdpQc=;
 b=pTpcjwjH27jFbXnHQvNvN91z7XG/Gb6UExeYGPc5N38Giuof/yhatRQkY1Np/d/Jyz
 FllnkwjE5WjGL3mWS2BSukZnoUv+OPmRc7YSXGvDARb6hgdqClo7ZESSu9asLAz172Yz
 7Q3+F+2jZ9pCrZtrxQf5ZDfs4mU7xPb7fKUesqnBTBQz8htUYkmV79R3bkuhPEaqBopi
 cWPYbfUjFhQ0mXFR5wGjGlJ8h8mgaj+BJP2qs78exbhSVIJK2tfDVnZNeLMuFfFXOPFo
 bw2f6EQnYZRVb4Fv21vbTER/RSKrECNW30S0y0T1mSx6O7K76MiYP1tZKifEIpbHVYLI
 2fvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcxD83VqSXxsMTdwnIPXZzGdcC3vrtR6wt0LBmdsQrjXkdaDhpQE47ArSrySuxxg0wXzO98Csi2BLz@nongnu.org
X-Gm-Message-State: AOJu0YzAyBPgqGFnUSaqtTe3uLo496GxM+55mEbpwbcMlKKC1TgTbaGX
 +ae1TJCDe6BlADNVKLPpcsIPjRJirxEIAmHQQjvicp44qpL4XAefJL+Cv7IKGeHlYSU=
X-Gm-Gg: ATEYQzxeckenNmurgQuNWSlULpa+NvBQ2KZJddvSnIFxvIGGMatCUCVWVxVNkrVD5aV
 CSeDPSVVoBhFEguiwKHCUEz6UX8Jd96lYHh2R6xdpWcum/HiNTTwhTZw76kyOAOTejsQxA777Mg
 BLYtVu5F4noJ4F7kGhe+5vCZYS+YHMdeqVwBMSduGsHfDn5Ero2VXlljse+Gn9jsKfi23PE7VVR
 Va4C4KPWeK6qJ2ZkRyRy/AI/H4FGAY0dexTAnyRUfDYsZMB0B7UjrVKP0/QkfOcBuRwVYberwIz
 n7Lc/8Z4O7Nu6sLpb/zP8yvTIJBakbStpzNKU1dBiML4XrAPUH/Ir4J9ZJTf8G4ITepHTc2GSJW
 bU7ajxtyIHFOpQ9hhW48Vq6UFg9vVWhg7DeEfqABkU/fRNFBKCYzwd1x4xYhDPAVMoxqc3j7jp8
 mPmR4Az136N9Elsre0pKJt+m9Cl0McCzojXLENaeydvYCsMq9Z036bcbLBnNdYY829EQ==
X-Received: by 2002:a05:600c:83c9:b0:486:fb5c:3b20 with SMTP id
 5b1f17b1804b1-48899760093mr54762075e9.13.1775229891261; 
 Fri, 03 Apr 2026 08:24:51 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48899e48c7asm20330515e9.19.2026.04.03.08.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 08:24:50 -0700 (PDT)
Message-ID: <8f85b5ce-66ea-430f-9c5f-37b0603b9fae@linaro.org>
Date: Fri, 3 Apr 2026 17:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Move OMAP CP15 register definitions to
 cpregs-omap.c
Content-Language: en-US
To: Alessandro Ratti <alessandro@0x65c.net>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com
References: <20260403131458.446399-1-alessandro@0x65c.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260403131458.446399-1-alessandro@0x65c.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Hi Alessandro,

On 3/4/26 15:14, Alessandro Ratti wrote:
> The OMAP CP15 registers are only relevant to system-mode emulation
> of OMAP SoCs. Move them out of the monolithic helper.c into a
> dedicated file, following the pattern of cpregs-pmu.c and
> cpregs-gcs.c. This reduces the size of helper.c and compiles
> the OMAP-specific code out of CONFIG_USER_ONLY builds.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>   target/arm/cpregs-omap-stub.c | 10 ++++
>   target/arm/cpregs-omap.c      | 88 +++++++++++++++++++++++++++++++++++
>   target/arm/helper.c           | 79 +------------------------------
>   target/arm/internals.h        |  2 +
>   target/arm/meson.build        |  2 +
>   5 files changed, 103 insertions(+), 78 deletions(-)
>   create mode 100644 target/arm/cpregs-omap-stub.c
>   create mode 100644 target/arm/cpregs-omap.c
> 
> diff --git a/target/arm/cpregs-omap-stub.c b/target/arm/cpregs-omap-stub.c
> new file mode 100644
> index 0000000000..e0fe32632e
> --- /dev/null
> +++ b/target/arm/cpregs-omap-stub.c
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"

Instead:

#include "target/arm/cpu-qom.h"

> +#include "internals.h"
> +
> +void define_omap_cp_regs(ARMCPU *cpu)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/cpregs-omap.c b/target/arm/cpregs-omap.c
> new file mode 100644
> index 0000000000..5fa6b70150
> --- /dev/null
> +++ b/target/arm/cpregs-omap.c
> @@ -0,0 +1,88 @@
> +/*
> + * QEMU ARM OMAP CP15 register definitions
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"

Please use full target path:

#include "target/arm/cpu.h"
...

> +#include "cpregs.h"
> +#include "internals.h"

With the requested changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


