Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2AEFAD3E6
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 01:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFieY-0004G8-3d; Wed, 22 Apr 2026 21:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFieW-0004Fe-1F
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:14:48 -0400
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFieU-0001YZ-Jt
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:14:47 -0400
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-8cb40149037so623387985a.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776906885; x=1777511685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bYS9OIIdzjJyw0rD4wKMCdNts4GgLNVvGELb1KDurbI=;
 b=ynDMlj3MShOy9Ila3164c60owKPSLz6gNOgvICN5iT+icqoKYmGfQnzE6MFNwptq78
 d2FJ0u4zV1ueK3rv90peRirq5GOR0Iyr4qHRGDT+ZqwLvafrENo2LgDQZ7qJBZt+10hS
 H65XXtT/lXJnU1p7e4I8tPIrnPwXhuMhSd/pvUY+CQFIkN8XunglicV3Ja8c4dxNH4sf
 gfF7JmIrmBsrTjpgAATcXs9gLYVYLoQctoNg7fc71oAzvnzcb9mu/y5F1npTWuTNzwwa
 xNXS0FJAQ4xRDjVqihsqvCODDBkihqHvbwbBRLMa/4A06pqZqrmWGNImIp/FfvaOx6wI
 ugMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906885; x=1777511685;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bYS9OIIdzjJyw0rD4wKMCdNts4GgLNVvGELb1KDurbI=;
 b=C/f3e07eUCR8XO5h604SLG+XlHr/5Y/EjN1FabitIwGztrNaugAwsOxVmx2SZ20jGk
 0hpjCKFl7G6c0RrCPNtI6DdT3lGfWEWgjKj4iyHzbfEIIOj5SovbSc3wT3lxNaIzt7R0
 /5LAUFAqpUAySe0MOTClS5chKNhVowPdjvDPuPdQfwS7fZ9rbVs9IswiUQz5gWh6VvpL
 P1XhDwX9iJJo1T0DXAjnfbJ7cUNVyNEe3k9qWzfitNGVo01E2SIPwMi8VnhFL07eJ7Um
 31n1exzfz2d671ARdbG5yb9wh5qLgV7kiKGHF2DSLa/TXBprrVUHlRqurEjM619sO/kM
 yrHg==
X-Gm-Message-State: AOJu0Yxv0VZqIFevmEj37YiI5TF1gm0/CcqBk29DBh0UhiPaXrXblsqZ
 LL5uBCl6lcEL0DC98pR8rLN30ueAMN454olnLiLh+fZp3fiZDVHSiw4ySwws/fzr7qdJJa9zfhf
 Yyw6eCsE=
X-Gm-Gg: AeBDieuMtxdYniDpGcJ8nMACO+0RvPriFPB2QRJGT0wX+bcYmKXOXjdFBhuR/M3eEEt
 X5NxC313qUG8x51zOu6EZjyp0c+tPDR1Lhfxw5ANNRax36HCtVj2pc9Hir0E/cRa1uSppago6ko
 LySu3CdfSgIRnQbXI5QZUEbX88eTgoaxDxq8vr6HKHNWGSASRq8LbHfBs/yJSdGN61sQyb+rZXx
 ajVJ0wOdvOYtp9NcdBc68x8uqO28UzCBxKq62v5ZhxVKDPmEVvatBiTQs/zvPI9COMQcxe++Dmt
 GntFP90S1VlQwQwSjIei1ZlcCC2QwOOnkVQlln1iDjzexjgEPkq7XOSbHo0DkL6WgEZIgDPvq7h
 5qY8sSEUwbj85oCkGThDDFhEz0QtY6YZOw3Vz7/YmudCTQMLyRUyz/Y/Igcr8JZKXjV5+5D3+0n
 esW42MeSA1tEGL2H6N8ciS/bs2rwKLBi18w+2FQ3AJG4GJ6t/doCzfzkOjpYmJf9GrkGADTd46Q
 VFz2rxokkMsqO2OAlcc4+L9IWVn
X-Received: by 2002:a05:620a:4690:b0:8cd:92c5:b3e7 with SMTP id
 af79cd13be357-8e790407b72mr3455174185a.18.1776906885329; 
 Wed, 22 Apr 2026 18:14:45 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d3204cc6sm1491713985a.0.2026.04.22.18.14.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 18:14:45 -0700 (PDT)
Message-ID: <e049b50d-1ffb-49da-8d82-7ee77a18274b@linaro.org>
Date: Thu, 23 Apr 2026 11:14:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/14] meson, target/arm/mshv: Enable arm64 build & add
 initial MSHV support
To: qemu-devel@nongnu.org
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-3-469f544778ba@linux.microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-3-469f544778ba@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
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

On 4/21/26 15:21, Aastha Rawat wrote:
> diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> new file mode 100644
> index 0000000000..1c82e2c593
> --- /dev/null
> +++ b/target/arm/mshv/mshv-all.c
> @@ -0,0 +1,54 @@
> +/*
> + * QEMU MSHV support
> + *
> + * Copyright Microsoft, Corp. 2026
> + *
> + * Authors: Aastha Rawat<aastharawat@linux.microsoft.com>
> + *          Anirudh Rayabharam<anirudh@anirudhrb.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "system/mshv.h"
> +#include "system/mshv_int.h"

#include "qemu/osdep.h"

is always first, for all .c files.


r~

