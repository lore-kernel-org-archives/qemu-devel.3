Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71738C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mjP-0008SZ-M8; Wed, 16 Sep 2026 06:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6mjN-0008S7-2j
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:19:09 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6mjL-00070J-FA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:19:08 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea34ef3so755512a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789553946; x=1790158746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mvnW+JJP9vOkJ5M7YH+Us+HdCUd6sBefMeNNhb1sVFg=;
 b=hPkRv+thUVUln4Savr01dNbt58tONG6pIscazwKUlo8N89Wqz+38ihuM72FiyV0Hqn
 XdB2UmVz7zCJ2XcmvM1f+5Wm3rj5tweZXFsqhKTR1RKZf0MDv+2GH4ZaXOscC0cu9fCm
 s9Edh4dTenmVItCM3ZisHcRbGr3UXAzyhFx9RNbFfcw08OdJcFlnRrxlnri5JnMOB1bF
 z3aghSHDqCYPYssNEF6ZWS1bYQ/Eb88xL0Hy0zF4JrrlDyo6sAln2UxrGpE0oadzbkln
 OapjRCmO+UjIf+CnDd3PXcoTTcCyVQRb1xU2kq9ok7iSL2w7SNyZb37w9sthDe8JPYQh
 jb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789553946; x=1790158746;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mvnW+JJP9vOkJ5M7YH+Us+HdCUd6sBefMeNNhb1sVFg=;
 b=OW3LKangWmKo54MA0ptvVr4Kx6plfMHZv1d0S/I3BWjaBGtL6PPrjEVou17YlqxeRQ
 QfitSuYDbzhdzeOYHkItYqVnZUwpTmw70D24+WYJDL51rvC6fuo9bW7IYhy8n84AOsdj
 Xyeh9EOUF2PEa8EtwMZrvLmqCDShx3bP2v+elF0fGFpANZpbWS9FSzfBMK9WFbO/xEZk
 oPHAdEhsvbUp4eC8Dpkpq6pqTUWBvV3iCxzVmKJHvyYastpEd41tKjWSMYVNraFYexFP
 7LicIaokJkod3x6ow+A9ve/UqW5j41PXck2wmAXBoq5IwwJ8Zj3uKulz3rE1XCq6k0av
 2abQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwb1J9iWT6wOSlyGPoFFrkdMEjPuEkE760rOdiDb/oW0bPKBhN6NTOrIFKbUV7QFPMeyDz2WQeCdRFJ@nongnu.org
X-Gm-Message-State: AFuF++n6cbD5KfJqr+XlJaVyuuUbXtKelP6CSLKyZDWPjol8avLAtCSi
 C4Q08STMoyCBZh8s1FKrwmXWCVQlv/pjgOweosbCIDoX3UPhidiQEpJI8vE1gCELT/w=
X-Gm-Gg: AYBFou3LaACuBw6uOVKkhBQuwim2oHsPQ30XzihFKNh6ffyU+zs7burAeV9fo43oPW+
 xVNn16+TKqEDYYUjrYzCIJmT93h/GKoDlxwcpBeowtgn+YcbZLZmowHbGUbIRYVF94JgxoinRGl
 JS68gMK/ji+xV9UbPysFlm0LNwUlcLwW8Oqc1uvhgC/3eqWq3g7m9nXdJsGFJ+gOaxz9r8ipekx
 +xs9UuJfkK7PqM8pFXyueZlhJE91tT5cAHh1yrE5dWyvN+KOMW5P6Ky+C6gJF5nukYnY2hchBlG
 jo/icrsOOm6ZNmHyD6JVZ4Aesy4XnN65gnfkUVC/603GB6uQdtxWJ1ky8sosIQIcxvMNXByFKS/
 NehuC/tcEXlZH/IjW1KVy1B2Q2CnxREP2UTDheTdhwRlf7SDRo7dA2DVnF5haLbA81vLYDGkE3p
 hk83AjFuJxQAtmjwH4m11zEyozRtd3hOTlkJt8deet9ctqoFWgawI0R4XHrnItj3G/Fgi8XTeNF
 AoFd5YKkDrMa1PoBnlTjrltxeceU8N+3YAnm3aMijvSzKDkbFqjMIgMc+1cCw==
X-Received: by 2002:a17:90b:3a43:b0:39d:f5b1:e365 with SMTP id
 98e67ed59e1d1-39e1e559b78mr5201196a91.25.1789553945701; 
 Wed, 16 Sep 2026 03:19:05 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:845c:f507:397b:9b72?
 ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b030aesm6752322eec.26.2026.09.16.03.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 03:19:05 -0700 (PDT)
Message-ID: <d0f6d31b-af76-4a21-821a-8f997491abe6@linaro.org>
Date: Wed, 16 Sep 2026 00:19:02 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Fix TLB_MMIO check in tlb_plugin_lookup()
To: Anton Blanchard <antonb@tenstorrent.com>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20260916073209.1791732-1-antonb@tenstorrent.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260916073209.1791732-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

On 9/15/26 21:32, Anton Blanchard wrote:
> Update tlb_plugin_lookup() to check TLB_MMIO in slow_flags when
> TLB_FORCE_SLOW is set.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---
>   accel/tcg/cputlb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 7f7c208ba1..7150d6d126 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1593,7 +1593,8 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
>       data->phys_addr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
>   
>       /* We must have an iotlb entry for MMIO */
> -    if (tlb_addr & TLB_MMIO) {
> +    if ((tlb_addr & TLB_FORCE_SLOW) &&
> +        (full->slow_flags[access_type] & TLB_MMIO)) {
>           MemoryRegionSection *section = full->section;
>           data->is_io = true;
>           data->mr = section->mr;

Mm.  Missed when doing the conversion.

You don't actually need to test vs FORCE_SLOW; that's just there for the 
fast path to notice.  Just test slow_flags unconditionally.


r~

