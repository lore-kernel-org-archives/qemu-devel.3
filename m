Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D222CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIxL-0008Mr-FM; Thu, 15 Oct 2026 06:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHIxJ-0008MF-Pr
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:45:01 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHIxI-0006rE-7E
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:45:01 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-677dbe051d4so1451993d50.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792061099; cv=none;
 d=google.com; s=arc-20260327;
 b=j2Ybk70geuFEea3DoyuyieqlIx8GoRclxcVw8P+bN9/56++VV0w0ul7d30mCwNgikw
 mUV56WSoLn/3eMO1sPmRttOxhcMvppDY4UrywunDYoo0vdbrM6b3DOFv7SHElO5ezW/u
 ZgNRHnZ/mMRIpb5/9Sx6uRtyUhzJim2BKuiv04ncKQ/z+k/bDIEuDy9Xl6VKES2cHr+v
 apfOCBkiDHUMj62asqhi517YTNVUG8YYfMCPOYLnUlxkNZhO1qEyED+qjtiDdq4LbpP+
 m/TIxv3fQhv5zrllyKRVf4YyxsExg1RSiHLsx+w2+7MlamzFe/rabE618oFZZtuOTjKW
 BtsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=VeK25S39q0agAlFTm8ppyZypDBOICxzXmnVPINozsHk=;
 fh=0z0tY78QlcBwmaAB6eW4EsZKBH3ToroYRqMhCwRjN+8=;
 b=V8hEB3vC6CwzureBGs2ZGN8objJ9/D4A3CfiCImSDHlyuNeyX8/G0ZBvkzG2FMwlA4
 FTF+2y8iROtB6LXu0m9jYvWhMZBK+7lPKWv/lApb7KSbxWupdzw7dzBwHOyGgRxgnJwO
 FMupjI8krwUsDUIDTtn4tG8vYhVOM4FDNPl7p9IkY9kV54NieyZ6pqYSEC2/o2SfhRUV
 TyLDABY7rjnnRfI9oZU4PtJIPt0GKFyog7c1NX2BbpiWDkbGLfnyIsSct0Jp3vxgfKVO
 DMYVrwwo1r2lBuzHlgbDxr/fcE17fdBxdZdgsYLhRfnLfjJ0SOwdkh9WQGG8aM6upnlV
 RA6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061099; x=1792665899; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VeK25S39q0agAlFTm8ppyZypDBOICxzXmnVPINozsHk=;
 b=NQU5YCmzlDf6bajD+u4Ct1h7P0fy77IznI4vE0P5FcAOFIYAbbUY2/2XvbE7Oz2ihG
 7zvGoD98/ibIFeDyF+93Z1pD8TLFf0CdM5ebtdWfDk95bIupDDwZjW2UntYpGKGzEqE0
 NdCXapILgrwoneoOkI4KsmvquRQ7cV1GeB15oESiHJUdrPq8OoHdwlLvgPh1Os6YKfe/
 wsijrrx8Fg0YwOpkRFuc2XIuG83GMQNP55oGITH+N0uu6NUzvtesZOrKGGmnnjrx8xlk
 R+BAio7FgCg9tj1KCsOJO463vTl7MGpHu0TGrz0aGaFJkxdxgLFW9ofUi84aUlEhpqz0
 kpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061099; x=1792665899;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VeK25S39q0agAlFTm8ppyZypDBOICxzXmnVPINozsHk=;
 b=XH/WnCkiC3xVMKe6AVxshxO+9SbVTx97qy9Quel7HtdAHLkSH0Kxn/QoCQ4nrj28ga
 PD/BJNPMzSS8cO4swHpCw8pycQ6eBROQriBjcnXQt42SNMHadyVQL7Qw0c6bG3s+MiwK
 nDOvnwa1Ft5WCVpqZRF8jQS3kyP4Yje53RfmtZZwK4K68+3JKgS4l716EHihZkNt5afb
 /YoIYj0C1GMRPuzfD1p1uSr3sIk1hdEcc6OHWkUY9R1rX82N4iwSdd+phuIFGmpxxtSj
 /3gZBfLr79WTcIhqFrU48NqFxNoEF5fdLRqtJsVZpVIQgERe4/6myN1hSI0rErhLZWnU
 j3NQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQUd3jwibYpBxUEiZWUV4Q01W4+JkWntogeae8QK88EvzA3f4tc0iftiCqbwRqb9MXQ0SCbZ9CdMeI@nongnu.org
X-Gm-Message-State: AFq9FYLv6hYtyq2jIvTxx0NdwR0QHL0/zuubfZaSZO94Xt9H+e6Og8df
 MbrZNhPj3os8cdhdDjMjDs2EtFFQStuJTxnZV8aQ/ZRQur1cIm2uvXNWxw8YMdfSrgzAAJCrGzn
 v5Z7kXK7VUCrpsm9Ie8+ZUNF3/YMp+uZs7wIH25/E1g==
X-Gm-Gg: AYBFou179lvJ7JrVCKfxG+j6ftjlA4AEIBN1XNUxV8xOHCFOchRnlGD+xOUvEcMyxJw
 qzUkHlaeo5QZ1r39+yb3ibgVVFzqOwUjDDFSjhuuOuOVGoNAEqNZFc0nk/N15VKjJuIMnIT76nF
 H0eTsB6OksOhS5opm2UkpJGB401pEmAoCkTqw9kGDo+rKyWTPwJFSbadn5g5/10jwg65Z+7mC53
 IF2fm5wEKj6tgvcQkpQTmaP+BQ3IpPLD0LSQwoglSwSrRvU2LwnIFgeDaQueeatYTRJykYsvVqg
 L3xnHP0UkR4m8IWFFZgtEnmu1kAZcZqJlam7+GNZ5CXZncQx/LWyS2JQxqhsGzkJBxnD0EdtvtS
 aRcNShbebSIw+C139BEHYn3HdWMg/AGKL7hYCRrQ=
X-Received: by 2002:a05:690c:c4f1:b0:8b0:a957:80d4 with SMTP id
 00721157ae682-8b0a957861cmr38502717b3.20.1792061098493; Thu, 15 Oct 2026
 03:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-46-peter.maydell@linaro.org>
In-Reply-To: <20261013083933.1024405-46-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 11:44:46 +0100
X-Gm-Features: AclHuK_ttN2KSCuGuhflcafMj_TsXvjLxdxzYKAKelL-cFqGoltBNz86LukSdK8
Message-ID: <CAFEAcA9kpkC65TgGkh+7shjvckOUj3d-RN0FP4PWtrBPz4AU5A@mail.gmail.com>
Subject: Re: [PATCH 45/86] target/arm: GICv5 cpuif: Handle PPI injection in
 vPPI pending writes
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Tue, 13 Oct 2026 at 09:40, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In this commit we update the logic for writes to the virtual PPI
> pending state by the guest using the PPI_CPEND or PPI_SPEND registers
> to honour the DVI registers, so that the pending state of the
> underlying physical PPI is updated.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/tcg/gicv5-cpuif.c | 69 ++++++++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
> index cdde759bf41..5a2927faf75 100644
> --- a/target/arm/tcg/gicv5-cpuif.c
> +++ b/target/arm/tcg/gicv5-cpuif.c
> @@ -816,16 +816,61 @@ static uint64_t gic_ppi_pend_read(CPUARMState *env, const ARMCPRegInfo *ri)
>      }
>  }
>
> +static uint64_t gic_ppi_vpend_to_ppend(CPUARMState *env,
> +                                       uint64_t value, int reg)
> +{
> +    /*
> +     * Given a mask of bits which are virtual PPI pending bits being
> +     * changed, output the mask of bits which are to be changed in the
> +     * physical PPI pending state, by adjusting them for the the timer
> +     * PPI redirection.  We require that the input value has already
> +     * had the bits masked out for vPPIs that are not direct-injected.
> +     */
> +    if (reg == 0 && (arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == HCR_NV) {
> +        if (arm_is_secure_below_el3(env)) {
> +            /* vPPI 20 is pPPI 30; vPPI 19 is pPPI 27 */
> +            if (value & (1 << 20)) {
> +                value |= 1 << 30;
> +            }
> +            if (value & (1 << 19)) {
> +                value |= 1 << 27;
> +            }
> +        } else {
> +            /* vPPI 26 is pPPI 30; vPPI 28 is pPPI 27 */
> +            if (value & (1 << 26)) {
> +                value |= 1 << 30;
> +            }
> +            if (value & (1 << 28)) {
> +                value |= 1 << 27;
> +            }
> +        }
> +        value &= ~((1 << 26) | (1 << 28));

This "clear bits 26 and 28" line should be inside the "else" block,
and the "if" block should have an equivalent line for "clear bits 19 and 20".

> +    }
> +    return value;
> +}

-- PMM

