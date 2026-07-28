Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA02C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woiud-0006r1-PI; Tue, 28 Jul 2026 10:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woiuD-0006P4-UF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:35:47 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1woiu0-0000EV-AM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:35:35 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-66899fe9077so6200175d50.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785249323; cv=none;
 d=google.com; s=arc-20260327;
 b=Gi7Dv7YkLxO9uMJhVvKZbOJHnmpjaqprTuYAoypx1UWOZxY5piVJApeflKX+1e4LTH
 FZXc7mOgeGXHDFUPW6/ilQSrShD7HsXCcPAKqoTqHl48sjP5ltEulEqU+aAinf7Gfkel
 iVAYuZ6EMOyyIngohnWx27cG7bOxPpTb9RGVSv8pG5nWrhBOehpO6KP8bqJEsIygnaUv
 Z8dM2fkGPf+iOJlKFwQBCrVyy4AGgYamHuLBEP4FdNGU4Sn24Md4vOtox/KkxPFj1Crn
 MnAiAftz4i0RNZW2YmaqGvqMGKWiX0qKumEyfsYn70AxgW6D+a7Zii8oDKuv09Q1flfQ
 HgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8zdjuGvJTGsQwq2F1n0Ey0GkjCD1z1YqRCka3lBjlr0=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=eXoGCMMSBupU5m6UoOX2/zqgeAEI3egMNO5L0iv4ALNGaRLhR7S8napHHtpMBSwOus
 if/Ntb+Eci5mXaEEFrLnHQ3O7Aa3o9DGq05uf9tjRPLl+ThCACZ+2R302MaMSXSA+nCa
 xry0XMJE6zZEmWykRRh31ro5Jpt0ioMLbOnL7CFobZ6BpT1e8sRp2piquWhGBM0TjXmB
 38ckJHL0H9nLvsIfnddt03M5pABIj67kDGn7TWQOEv7uPL4X5Cc+34Krr4wLxPQ7qYg7
 MzCF96LVsTIC1xF5QH9BPSiMXtHWBbmTmK4xU019PUbq8cj1JRT7b0C5CI6LUMtJQa50
 dQBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785249323; x=1785854123; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8zdjuGvJTGsQwq2F1n0Ey0GkjCD1z1YqRCka3lBjlr0=;
 b=qeNecfh4exff0mNMbQ46IDLJOXGzEmYHt8/tBODXZE9yOzVcX9v7D8k+sNeqZw69Hf
 3aU04O8E1BjoYCcQdsdeBpFw7jHizG2vxXiy1MqHB2GRpwb3J8B/3bWOoE7ylSdCiohx
 Tvu8iYz5vfGhLcdp2FhHnh8DSVi7Afmiwy3302xdNb9+YQxMgyeiH6bfOOsCq6327Dm8
 IGxdJYiWZH7Ic+dHpHV6suWUaicg5sXKo1jSaijaR4ko3XDGw1QBveQPr4K30OopTvcf
 YE3sue+pnVtoNyvtWIdwc8jREtRX6kwWWzTEpv5abnfnimwVBlG+sBt1Bf+ygXjurrm2
 BI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785249323; x=1785854123;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8zdjuGvJTGsQwq2F1n0Ey0GkjCD1z1YqRCka3lBjlr0=;
 b=tOVY1O2OlVA5UMaZz9Zc9B9O23CZ42DoednMT6Qm2gcw1/0migqjYaS1irOrEbyPjC
 nDmdMCaWxdljJbwpo77Kw0I9h5pkY+fA61dfDU0TwX9Ll46R6isfXBWZoYXeGf167lwj
 STYJVGMBl4rPNX0pPL4IjtZNB1nB1qDJCgo1Xjlb+DIZ2+e7MDRjCyf1vrS6Ymr9c9gn
 Ew7w/QWbgFTo1P6CSu+axny7nRT9L1w8m+SpvpRpqxTUCpiY4NuX0f52LAkhMey/BJBA
 nJNhBr4eqkVsfuzz+Kgh7MoMLiaa/0O+rz58mK4KsYMhLBcf3ZN7ZQ6CdJgOW3DEuQDM
 r96w==
X-Gm-Message-State: AOJu0YzBC3lb6ock3LuSEdqSqltDb6/ki8DcMNfzuENGfDMgZu74Umvl
 BtRYpxT1C+jCF5d2gutKrrTO1w7pVnoxfyMvUzDrgwm8N1S+KkJDn1BgwMLZuPUajjZZQE6gp+J
 i8f8Fe7v8WcpN0/DpwP/8oRLxhH80JUZUgi5ua1uZaQ==
X-Gm-Gg: AR+sD13aefTpYYC10O7xFQipFAsdacaQbc6GrD/s3Rd0NH/NS/oMN2sNCTtaqGPsyz2
 CGsDI0ZBys2EVpXICG0UfX9AJ0bxEv5mQ61NSG4i2JuLP58Q1WY2flUhfo6O/YzT5xv3mDncf/z
 yAfR5ffxcj7TNdolgmIR8A9OWSlypZNDfQILmZ3GfrYAhEptgBtj5hBIHMCynYXWLLs1+gm3K6M
 GN20WUt1Plpx+eCIYB+rpsCNYgSNN/kxeqqiSZqJeR9RMfU6A2uWblapGDeVWelfgjlDtmp0uTT
 A1U+m65YKMNkB+qI/O3Hgk6jlFPifR/7BItWUf9GViQYig==
X-Received: by 2002:a05:690e:25e6:b0:667:8b91:2419 with SMTP id
 956f58d0204a3-6690587b56cmr845448d50.96.1785249323330; Tue, 28 Jul 2026
 07:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-11-richard.henderson@linaro.org>
In-Reply-To: <20260717232306.378988-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 15:35:11 +0100
X-Gm-Features: AUfX_mybFjM-ZTAbW-M7iEp3YfR85oNH22ooPlplyuhKoeDN2wuNIhtfWjP20s4
Message-ID: <CAFEAcA--TV8fXLHFBUbUEi0wr+4Vu+wqYED2RevMG3bUyEpMnA@mail.gmail.com>
Subject: Re: [PATCH 09/17] target/arm: Drop TLB_MMIO check in
 allocation_tag_mem_internal
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Sat, 18 Jul 2026 at 00:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There is a memory_region_is_ram check later that
> actually does that this was trying to do.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/mte_helper.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 997248bd57..6177dea842 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -181,17 +181,6 @@ allocation_tag_mem_internal(CPUARMState *env, int ptr_mmu_idx,
>          goto fini;
>      }
>
> -    /*
> -     * If not backed by host ram, there is no tag storage: access unchecked.
> -     * This is probably a guest os bug though, so log it.
> -     */
> -    if (unlikely(ret.flags & TLB_MMIO)) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "Page @ 0x%" PRIx64 " indicates Tagged Normal memory "
> -                      "but is not backed by host ram\n", ptr);
> -        goto fini;
> -    }

The memory_region_is_ram() check is on the MR we got back
from looking up the tag addr in the tag address space
(which should always be RAM unless the board code messed
something up). That's not the same as this check, which is
looking at how the physical address is backed.

Does RAM being monitored by a plugin appear as the TLB_MMIO
flag here, or is that some other flag? If it does appear
as TLB_MMIO, that would be a reason not to make this check
here. But in that case you need to adjust the logging
on the !memory_region_is_ram() check below, because we
will now wind up there for both the "board code error"
case (address is backed by host RAM but there's no tag RAM
for it) and the "guest error" cases (guest configured some
MMIO-backed range as Tagged in the page tables).

thanks
-- PMM

