Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B60CC6B30
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHIqu-00032E-51; Thu, 15 Oct 2026 06:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHIqs-0002ws-80
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:38:22 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHIqq-0006Dl-QF
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:38:22 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0c5a64de8so14240007b3.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792060699; cv=none;
 d=google.com; s=arc-20260327;
 b=Go2LgS1p4aOiau1WGmD2m8B5w5xxhIMgisJtr1p/xg9zTAzLvRvD3QxcbqJQmg58Re
 6iq0Bux4x8ToSyhS1Tw9lbWjs/zqF+oZ1J1rBs0FJOrpUHz6Ckg7tXRy7/Rit4XC7xMG
 O8fSP9zOtiQv9bE5tf9M+gfId9oW4K9fDfJaUFs6OS81YRB8i8z1dtRwRdRGvUWGjl14
 DF35oktoEH8ZeefN9GcmuUt5998RVti+mYtlDTXNtFHEyVYRYk75A2qPwuaK2jSjyJtB
 IQD6X8IPKDsLVHrb2eN28vVYPwDXii20DVn/O55PQ2SlRSYRn7ggU9kNSLql8aK000I5
 M9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=2n4IHwJGStSj6XIDhmiZ1DyVKnU97it7aYpS1dErJm4=;
 fh=0RECaB2mJjiBXd+iCBicpfL6UIFkDL6UugnNrsl3GH0=;
 b=R7QXF/FLJMZeEe+1RwXcSVjRS3zMx8lg1tgciIGm4ptuzhNk7e33AxKKjQ3ULKFUJ2
 SiI0VQOasDPSKfzPrCVRoVSrt9weaamimG9QlK4duUvlWV9ZCT1G5AT7/W1J74l/1S01
 HjNGFWWCq07JKY86VlXlz81dVzqlOzfznAMdI2BJR61x4nLebXq62atO8j4JCOgSYP0e
 5VnLh9h96oNaaFk2Wj7KP3HJ1VT48NDeOqS6ePc24uJ7yXC2FD2yM1m1STxjXRefuliZ
 hqrneYoau8nvjsxijjcKCKniaD9ikHGCDWf9VS2rrgKvD4dWJ2uLrU38B70cTN5V7ZqM
 CFCg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792060699; x=1792665499; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2n4IHwJGStSj6XIDhmiZ1DyVKnU97it7aYpS1dErJm4=;
 b=KLGpzO/vSaLaYspIUNbmKSkA83vPb1m5gFt4+aJ1DC/OBdDiPtDKpG3DsM/97xFikR
 7vY/LxqKlOv3kkakQ2w7JY6m9O9JLSugctNpczhVpK0HRRExQqvmdiZIwj5cmG+QbKGv
 d5KHRctES1cMcAdLgddXVdb0kWDaMayihk5dX2Ep1c1qYmBDRQ991CtvS9otNHlmaMGF
 At0m0AHzf8OOkj3ctHdG3mzKN5YWY3LsiUm7ato2NEv00jhkZmbvomdpVYTlR8oT/Snp
 IE3msPRaj7ePiG1YBe8IGyIf50+8iV+eeiI7WteHTtRd6fJ7G9HmL2lnxJNPfigMP/Vj
 /IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792060699; x=1792665499;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2n4IHwJGStSj6XIDhmiZ1DyVKnU97it7aYpS1dErJm4=;
 b=c9GEHYmuR0Ddqqc6ACjd1UigF1k+z4K9V73NI36xlVpgSGDbljc+BX0HwL47gKT1FC
 I4upR8q49MT9vddOnwKwTJsSSONOx/cKvSFsdF3Dc7x1tgrFV6Nx9es4pOsZkur3sajs
 lS7bKt/ZoDyLY0EKF5L/KzgWqzkvumDw4mvi8vyhaq8y3UJno3L6dx+DAB2fMTszIEOX
 jcUPtpzaQncNxIHiZFF7T7zp3/u41XIEE+Pol0xBnun2Mwb1OAqJal4J7LH57l3U5WXO
 ntw6R45/pCqSYKUZk7Au3rmwCOTX5mkI+wpJ+YvIA3EmkELiN28G2F1ov0yfDvGR+AWx
 XZCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByG0seIoh1D4Gh+7WNeJyuTt/JjsG5GbrJr7YLObTaXzv691rZa/mMNjs+Wplc4MR/8IvaUC44jP6GE@nongnu.org
X-Gm-Message-State: AFq9FYKMjyJiHoKaR/KviNCjYC8kU4LpMfOIka5f8H1EvUC2LdgGII+O
 tXWZ3TtX5u0bSxbb4rXI6GHgZP/uWuo40Hm7MlBGk6OAimvVvzonSjmTaNPiMEhuq2mGPV0yVh2
 5Ckc5Vl8qLJj0U4PotfPDUalLYbk2k1mBx7abopOzRZLNjfsmd9xz95U=
X-Gm-Gg: AYBFou3pSvURbzqmhmqLQ3CLdRrHRXNMeYKksIsTCAV20O7aY9nRsjP/cGfnS71kiM8
 kTGpgVvRpiMiuGO1OKZ1+wjKQhLpyUPCLgoLYbl+ktQ8gr5ej0MWj003AdTe70YdlYw6myNjvSx
 pFukFxYUzF3fEMd8UkRijK3KW7KjoWHYw2jkONQeKBUm5EsFbH/OnIbXyg18bZN8RG69jhHDkgN
 dcP698ViCcO4MpeW56m+PJ4+pF6dRIps5m8hciDA1eUviP9eq6GtZRbyY1vF883Bxdf0W3Rsh4A
 5c7AqCn0x61ScJw5dO0lHbvXvA1lt9GsdAZ/OX/ByZOm7S0liBENrwyxk4JiDhTPJdgiEeEJy6Y
 QaDHlhNSlB83C+lDJPDPNwVbgHylOnyq79NXdM54=
X-Received: by 2002:a05:690c:6d03:b0:8ae:68d9:cef4 with SMTP id
 00721157ae682-8b07d46649emr58856647b3.28.1792060699317; Thu, 15 Oct 2026
 03:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-79-peter.maydell@linaro.org>
In-Reply-To: <20261013083933.1024405-79-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 11:38:07 +0100
X-Gm-Features: AclHuK8m9hGewqbSVDBzHQSBzBbr7hoX_JxXqYxktbQmNdRBvDG988yndY5PuU0
Message-ID: <CAFEAcA8ze6dnn6=+0QOP+tU3wZcn85bQ8ibLChDUxzNwWbWXWA@mail.gmail.com>
Subject: Re: [PATCH 78/86] hw/intc/arm_gicv5: Recalculate vHPPIs on VIST and
 VPE mapping
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Tue, 13 Oct 2026 at 09:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> If the guest maps or unmaps the vLPI or vSPI for a VM via
> IRS_VMAP_VISTR, this affects the vHPPI for every VPE in that VM, so
> we need to recalculate it.  Similarly, if the guest maps a VPE for a
> VM via IRS_VMAP_VPER_WRITE, we need to calculate the initial vHPPI
> for that VPE.
>
> Add the calls to recalculate the vHPPI for these register writes.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv5.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index b4dbe7ce3e7..199547abaed 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -613,6 +613,19 @@ static void irs_recalc_vhppi(GICv5 *s, VMTE *vmte, uint32_t iaffid)
>      /* TODO: we may need to generate a doorbell interrupt. */
>  }
>
> +static void irs_recalc_all_vhppi_for_vm(GICv5 *s, VMTE *vmte)
> +{
> +    /* Recalculate the vHPPI for all VPEs in this VM */
> +
> +    for (uint32_t i = 0; i < (1 << vmte->vpe_id_bits); i++) {
> +        VPE *vpe = &vmte->vpet[i];
> +
> +        if (vpe->valid) {
> +            irs_recalc_vhppi(s, vmte, i);
> +        }
> +    }
> +}
> +
>  static const GICv5ISTConfig *ist_for_vint(GICv5 *s,
>                                            GICv5Common *cs,
>                                            GICv5Domain domain,
> @@ -2131,6 +2144,8 @@ static void irs_vmap_vistr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
>      }
>      return;
>
> +    irs_recalc_all_vhppi_for_vm(s, vmte);
> +

This call should obviously go before the "return", not after.

-- PMM

