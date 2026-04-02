Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25363D39413
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8G37-0007ha-Sp; Thu, 02 Apr 2026 07:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w8G33-0007gD-20
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 07:17:18 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w8G30-00028n-Bz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 07:17:16 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6501547d7edso771924d50.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 04:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775128632; cv=none;
 d=google.com; s=arc-20240605;
 b=iwumPR0RPK1PMfBs3aP3ThxTeitx+TeBNg4bsGMcRJcZQ47TTSogPLLICK27LiLTCH
 0bZVWgOvmxfrHprCIDsDAUUOIpaWQP3dyuiPdi7nkLHNMF53GZlPgSXGR+AJ+ZhC5+k0
 ey90CbH3utP5uvmDczGpaM2yzsloiy9GDm/Bs7qgbt+XPy9NTwloPDz+s1h6/AYzqye1
 JoM/YQe/z/A8misF5iXQj4vzVRFh3JjodmAoAevutEnrWgKLOgO9pESYq8RZ5UOjOvlQ
 lTWmNc1406RgAgwVdPMPkQTksonEpma/cRkHtNBswtzY4gTkYJN9BcIWU87a92O/Y2Ox
 U5MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IUVtHv9CaQTlE1ApCtPVjBKYyai83t3OO/g8dSSIlsI=;
 fh=qi+Jp7UQIJ0rTubs3BdDDr6Q7dNucOHu6pXalRdk4dE=;
 b=EP3co+ofZZChkgbOhsqTk49IvSoQ8CI8EiwObu6yNxEdo+4oWu0bsFyWBJzLtBc0mI
 9ybkDtBl4R+CBeRLTZmQEG5gKz6IuikVpaLFkMGnnowa9UPrTKdqVb/VtRemAeKPlNYN
 i0bkxr/o1TYgw9MI3hRrO/CaNYdtxiI5AVcLETbmFEiqc47RZBNzdU8ecVqH0jvCZ8WF
 lnZY6jfUsgn8tp0E17YWf/jk/7zwN7DOQlbootH7ZgNMdv+FP7luotehXpIYQNyXGOIQ
 QNK2fAsfQps8VbQLy5g1mHLe+fV3zeU4TU86BqSqFuXfUZ/1VTkqTIDNDSbT6MaxCzsi
 yong==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775128632; x=1775733432; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IUVtHv9CaQTlE1ApCtPVjBKYyai83t3OO/g8dSSIlsI=;
 b=EW3/t3hJyWmVFe/eoFYGBWFuJcNUZpl8ffJigraJUN6Kxr1wti3NWvaMPxKsBcyf9P
 lMYIO4Ix4Tl4oXov46KIVTABYp5eCnapTLtxuY947262Kk3vmjDSE0/MyOUsdYx7DD5u
 dmDZSOMxZ3S0sFtJ4rLdp8xl+YVIxR/PK7/08BPzkd1Us4AaYy3g7qrzxv2+mZtaZneE
 LP5uaSVAlCJcLge/8plDLWNhDsWKdfFadzOwCk/gv+HPFBO0oRsw4xVHtCYowH92XYUx
 ZlSvforpDjXwursWwC1j/FsLA0ra2zDwjSfeBINPiEXLaxDgzYvYHkF9Yw1DsI6b6SN2
 ZMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775128632; x=1775733432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IUVtHv9CaQTlE1ApCtPVjBKYyai83t3OO/g8dSSIlsI=;
 b=EE8GwtpR6addxSnuHhTopHHKIbe2nFCK3rWyR4DBNHqHyZcnLnWbzR+laziWHkmmBP
 yBoTXI/3nYMli0Oln3GNGixneQYsYpITD9iAlfmIQljfCBqS38XGt5V/IzR//xEa6ubS
 KWzN0g8JOf9G+XDwJzD3jXl5IlYnqcd6fhakw6TcMl4eKmjlGy6MNxbqIfGMnH4rJrWj
 +tjCPbTyj8L0MHjjBl5v3LPnzq/6RkiC8AQnAGWTbkrWUNaM/1FzYIiuebL9AjuqGVSm
 FsmMs4dHHiFGPSLAuwuA6U4TcwetRC2nErygKnu3l4Zc7LMOyu2i+X1hEtyOlVTk5vP7
 3ouw==
X-Gm-Message-State: AOJu0YyvY+xvVN1CJnZP+Fm6DGG5Or8tsuYRjTsDkDwiLzJg/GG9Z9qt
 MMw06PZoohSbD/VrgjpssHOZxgvxVG+rWDOj99+RlHjiNpWt2hLf+7INjEEHbim7JhUZ6agE9es
 cWIQErYJWQpZGwcLykH54YmtwIZt1zYQOQcntyKAKN4yKUrmxVuQaiB0=
X-Gm-Gg: AeBDietLdpR6cbVMYkTIflH2oQviUvCnP9kbcKHlBdBHaqdSuK2Yi+Z5K2N9mmut4RI
 ZE9ehpEq8ysQ4Pk+AMeyP07sgB7uD/yiI+EP1tfoS3G4tBz9BqY6wes1XIR+cv7hWqUKzbDwyFs
 YggsISii5mm9FJJglIgYOTzO0qN4j+TELLOsITPKdNCbq1M0ltcjm/deI1Mr1Eqg9CoDSl+P99T
 McFrjG+WNRHLSHcOmACp1SEQmnzlgsLww4deEs6zfB4TXYNOZrGDRMR2TrIOf4GQHtZQKMkj1D4
 F2BvrwjT8IgvuLNuZQr/sRRHnz69BUy/JGNNoplOMo8A43oIkmcD5m+kfTxAlOfPyqWNo/axhqS
 1kg==
X-Received: by 2002:a53:b4d0:0:b0:64e:e0fc:a314 with SMTP id
 956f58d0204a3-6502fe7bf8amr4557982d50.69.1775128632265; Thu, 02 Apr 2026
 04:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260401220720.19555-1-mohamed@unpredictable.fr>
In-Reply-To: <20260401220720.19555-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Apr 2026 12:17:00 +0100
X-Gm-Features: AQROBzAV94odNk4MQPdJgImb3kgtACC_8dUyZasaiwXt9GWJXTptjuwHxnp0q0A
Message-ID: <CAFEAcA8qchsEganwrejiqoWabUd_BmNfnS0AXzWR+tT61OsjyQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: cpu: add HCR_E2H on reset for EL2 + !E2H0
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Wed, 1 Apr 2026 at 23:07, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

This could use some rationale in the commit message:
why do we need it, what goes wrong, etc.

> ---
>  target/arm/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index ccc47c8a9a..5ffb1e3096 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -685,6 +685,10 @@ void arm_emulate_firmware_reset(CPUState *cpustate, int target_el)
>          }
>      }
>
> +    if (have_el2 && !cpu_isar_feature(aa64_e2h0, cpu)) {
> +        env->cp15.hcr_el2 |= HCR_E2H;
> +    }
> +
>      /* Set the CPU to the desired state */
>      if (env->aarch64) {
>          env->pstate = aarch64_pstate_mode(target_el, true);
> --
> 2.50.1 (Apple Git-155)

thanks
-- PMM

