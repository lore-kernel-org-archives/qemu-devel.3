Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27656C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weDKb-0003QB-FN; Mon, 29 Jun 2026 10:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weDKZ-0003PG-DC
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:51:27 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weDKX-0006RD-SD
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 10:51:27 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-664d7863920so1035977d50.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 07:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782744684; cv=none;
 d=google.com; s=arc-20260327;
 b=jgku2epmxqI4BsMZgNOlUfHbxEX1nkGBBV3Y4pGQIBOsGm2FQjbcm9CkpZqo50U3V/
 mDScV0XRWfcCsAhsfOvX26vfpJMaCZIDV5BOi0TvXp0y9omLcNLb8YrcB1o02bceOdj2
 WrU3DdAKZkqVA7lcnWLwmciuDe/oTk3sZqK4vCOO+mOZjZloViTXXRtJ9plso5LwYGpk
 03DoJ4CRPXy6A7UlgM6XzUAuSVoz5SgPX4SfcS6h8bDL7RewSkIgDNCQt7A829iBYdvl
 bkSojhIUhFmJyarIHu65gqV/pUMYcFcSVou8caUB0ZKUZL0IZeNSp8QRfY0SmOKoi8g9
 VuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tnNOR9XALSS/+ObunG4i4AC+ILmrrqT3An3XQPSAdsw=;
 fh=veedc57u4K6/11cE7NZuRLfy/OlNqq0+rv4lUD8EkAs=;
 b=tAqlqDcw1ih4wIDHDddzPyiW3ExYJCILlHVOhHehL0rvWOv0JHUwZIaxEqVsKOelMl
 qwoEpo6OVmc3FXuL6DOJ+JOEgtX2IFEHJ+jNNy+OJpt8omCpoSBzODh+snvS9FGEhZMQ
 Rc/N5a80K0vZtbdBZSUGsXcOtmgKcs4K2GuezjRt/7Shrs2Dy/pab0L7xoTOs1/KOJOy
 +2+2vOjs8TKotrCzLDLbPCtJ7dKuFGxDOGmMaDv/h2FUkFaYcQ5aDJkXJfWqXX+XwMXW
 hnrlGygvI/tzYqkYwsyT6F0L80AFnxm5/Ctzh559HjWXa2hbAlW92yy6Z6T0i82bm3f/
 EXjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782744684; x=1783349484; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tnNOR9XALSS/+ObunG4i4AC+ILmrrqT3An3XQPSAdsw=;
 b=G7e7oe9ptzx3MSVi97q99zDd31AUBpgtVf/yfr6Inu8XydUSghpVWsDqFVXpgYVc8i
 RbX9gIPv91i8OqRMuMP3WZ17OTGJGLGdZRVfVigQHtmm6rmwnOlPIFVndK0pZrG9ECDS
 DJcIJxysWyxtoKe4zVeoioVgdl3ehhPMY0cNm7XJzZ8AAN9HxSejvXkZJoFfUihZwA/v
 zjARPYyGv3INGpw3t1UsaoLwkDuWw1ebxZLeruNWD4ZbvSeCIlfS4s2SPNCjRxFonlre
 VKzgE6m+luNvfCLjG8Vf4dX9OcBLowVtbAVZ7BhsXm+ICz0gGvKbLvYdAeefoCX1GHpF
 gkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744684; x=1783349484;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tnNOR9XALSS/+ObunG4i4AC+ILmrrqT3An3XQPSAdsw=;
 b=UDcdFBT7lnDSuV1kmdPuwRBctOk9rvISjTcVApAj3bskErBcUkuTH2a79NrGh69LR0
 UUmnQSBIOg3XpGdfPEXDWYRZtj/jKU0ATHncvNzy/ahtuxlGK7Wen+mw2NiXnnREPkTd
 CepYcZ/JiY5VlXSevCfgZDy1eBgrr7YlUtAU7nCm+gkMWPK3wSFBYsfnCM6lBAsbkBrB
 nDcDy9/JxdGeMy3SwC80kI5VjPhmlAM2HwGQm4UfpZj5mJ37SBzYjvTVyturFgn10jaw
 IwXBkLd5mPZ9BwfcerM45tY36r9g7c9YGq8JewzeU0n268uM68At6XWQwXnWGERFdulA
 HY8Q==
X-Gm-Message-State: AOJu0Yyg9l4i2WMrfcIqBZ/QY1tCo3O1lGZ9O2eN6RPKAreLyv0Fmjdf
 8TfTIQDHe95BAGr1a7XLrcoYbEH9doVdV7M2QoUzo+bfI0ts9QM5D0H4EtkxqScMGAMxLP/6Xh0
 qL3RcMoI3AfFikwOm0YGMbgnSUc9XBzHC47FsNFeyrg==
X-Gm-Gg: AfdE7cn4HNOmXJ0bGiob8PHSPD6UoHkIRInqHhE45cV+bIjGm1hCi/YgYffv6FzSya9
 hqphF4iQtMHYKRbtL0bEmH40pGHyjZnjgpd/3CrmSND1ogecm/dyKHvuyhHrjI0X6mkSFXGXKSI
 rBlSVF9tneygJIXPKRGxayuxOmXFIi2C1YpTfeGiFjtIKqTXCjRzYZsNTOmv0xQjMjfwZpxAJZe
 nfXMtYHmChi430DYdVNx/+P4Sqd2lyNBJ/R9ZDnS2Vsm/rdrDaKwvH5lwcclwZX3GpK/LHvH8tC
 lJT4pfA6M8OETscljD1gZIOPOi477oGzHZXGOc78Wg5wTnah5VMA6CcD
X-Received: by 2002:a05:690e:4185:b0:664:efd9:3def with SMTP id
 956f58d0204a3-664f9746b5dmr6288d50.1.1782744684510; Mon, 29 Jun 2026 07:51:24
 -0700 (PDT)
MIME-Version: 1.0
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-16-imammedo@redhat.com>
In-Reply-To: <20260624102830.1355552-16-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2026 15:51:11 +0100
X-Gm-Features: AVVi8CdLvrZcNbpiXupPUXApaSNcgo_GRpLxcSgg7N-88Os4Rn-WmmjUyEMdQ2o
Message-ID: <CAFEAcA8xYw-rKWLWMUkSgYJB_c6tbpvuiJ0KhgnV84Xa2ui+2g@mail.gmail.com>
Subject: Re: [PATCH v3 15/17] sbsa-gwdt: move all foo_REFRESH logic under
 REFRESH condition
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, eauger@redhat.com, 
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 24 Jun 2026 at 11:29, Igor Mammedov <imammedo@redhat.com> wrote:
>
> No functional change, just code reorganization to
> prepare for direct WCV load support in the next commit.
>
> While at it, simplify timeout calculations
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/watchdog/sbsa_gwdt.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index 6113dcd077..5ee0e06af5 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -109,22 +109,18 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
>          return;
>      }
>
> -    /*
> -     * Extract the upper 16 bits from woru & 32 bits from worl
> -     * registers to construct the 48 bit offset value
> -     */
> -    timeout = s->woru;
> -    timeout <<= 32;
> -    timeout |= s->worl;
> -    timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
> -    timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -
>      if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
>              (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
> +        uint64_t offset = (uint64_t)s->woru << 32 | s->worl;
> +        timeout = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +                      muldiv64(offset, NANOSECONDS_PER_SECOND, s->freq);
> +
>          /* store the current timeout value into compare registers */
>          s->wcvu = timeout >> 32;
>          s->wcvl = timeout;
>      }
> +
> +    timeout = (uint64_t)s->wcvu << 32 | s->wcvl;

It is very unclear that this is a no-functional-change patch.
Previously we based the timeout on WORU/WORL. Now we are
basing it on WCVU/WCVL, which only in some cases are set to
a timeout value calculated from WORU/WORL.

This needs more explanation at minimum.

thanks
-- PMM

