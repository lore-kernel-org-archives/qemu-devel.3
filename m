Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA011C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weTo8-0008Uo-Tg; Tue, 30 Jun 2026 04:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weTo7-0008UW-RZ
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:27:03 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weTo6-0005bK-6v
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:27:03 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6649ffb1d01so3235970d50.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 01:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782808021; cv=none;
 d=google.com; s=arc-20260327;
 b=ojI8s/T2CaiUU6eubq8BOx6g69XTacyT22usy4SIC8TFYws6JJwZKUu+RyouwDzy8e
 gyKhuAKHS2pM7RiBtLLwJOPX7VxJVAlI4S/+Q5bfz5g/aPNuvM10X8vPgOaCpWu73nxZ
 c5MDl79cRjKRDtQ+aIVRFELzsGP/XEr/xdyHs6gLKw8D4sqMeldvigMcI+/zjke3sYJK
 H/YhWR8PcDOKcVgelp4D7oGW2WkczC8bklHkupPqGFFTwJ/kJgFpGevF0IGgE0Gbv06H
 QrkHPUvq7Tenf5eOzMRQzWjV3v7b6tPmUmh2FQEuqVAp23zBlCcLE+c13TBPJrjGhYxF
 17ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SlRlj1e3taTMD9vV8kdpKn9bhuRAl17GuqMiySNCEAE=;
 fh=EJPBCAJWPxH9F4vzEEBwB6ALmNVBlqGrTMf+Eah+0tw=;
 b=IGz4MYM9qwab9kckmIDINKw14c2ZOu+Cp0t9xJC1JqY3UpPhjp1CYzlb0eL508OPEj
 zSlGU/HkMI+nJfxhDqwcckJue/BiU5m5wbjXlA5T9NlMa8bA6fT/7XlrC62GJOWxSiPE
 lsKWnsOCqvtZeK6nhtGr5wRBjdJI6Ph7PsrBGAU6QoQsu2PoS6yhTDZ+RQenf7gvN/vY
 6VbwuMvS8PAg0jkzB/dG4kxx1HXz9yAzLoZqAgwYyVcjUt2oRd3wkgMAApTYJ3imvbby
 hnyu1DKPlcWWgQEBBGsa2e+I8ocq8u4A10JZo9f67jmYYAZS/5L/jP9v3rBFU1JmJ8N4
 7RPQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782808021; x=1783412821; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SlRlj1e3taTMD9vV8kdpKn9bhuRAl17GuqMiySNCEAE=;
 b=ZRZH/VmaGsVc27+ReV50XNJhz+uY4ADuRlgy8IPbjwzA8bw3VivAT3AmNbQyolzTZR
 5qVPxEZIvhfPU2sp8LmwY4GuYeUPRn66rVEDo8+xx/VF92mykLXRf1uJ9abOaGNfqBPS
 ZV6qVX2v4hpnCB3L+zoCBLKCyp9DmnNm0Pzzz7q23aEX716/onQa70BecGzZGjgseGm3
 EHmIUxJ21O6gsqjh7NmH5tSloR2tHrKLDtQR1hV9iTReBOXilsHR/SEnyxXrrP0KBn1b
 SvgASH6xlWRumMGnSpc0kFK8g0vp2xkkbRS3NdxgKHpD0OazOj8HF4gI7PhFc5ZT3Y6s
 Eazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782808021; x=1783412821;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlRlj1e3taTMD9vV8kdpKn9bhuRAl17GuqMiySNCEAE=;
 b=hxutqCmcwHHwM0TMbZDxyPk18nJzhV9WtPu7SEmElbbj1dAWRSG5SfgLZGKawJNrnh
 HAzEhIYNlLN3yB4Imbz2Jt6E+z92WXkqT30NEJtvKWfgEHveR0Ajf64cN9THyeLpfT2O
 b7GAEPXDNHkayBaxRQ+DANxff7FbSUwlAqVziG85ES25hyda40UYDLs3mhCjkCaHOCrN
 Ko0th+h1CmApe3eqklgqSgz5pGK37Egooi8lQs6iDwFBwgLX2u9T5OukOqTWovtR0HSe
 0nx405kJkgpq1hYuls5xUgtmOU/8TWNhi73irvsgxLeQy2nUHbFVGlvv4qmZWNwRYF8r
 Yihg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqak6Mf/drdXfbipuGmdynyzMZcKbDOFD4CBpg3dQQDAFAg1QTiqo6dBr1FzE+/CzHJe/MRXrjlVELs@nongnu.org
X-Gm-Message-State: AOJu0YwjaQeCciICU75WZFKyvPXdU6tQGieOoep1TFzmuKFL4FOxFfv5
 THOobDLKlhzJ1TL8CP9yMm6ALzmuJEp9XoQRLAH5BVFAHnhSqzhBEShNAWLJ69jZTD8XHAYDI7o
 eiDMbuETH5v6aZI42AUX+de081l5M6qSI6gf9JRc09Q==
X-Gm-Gg: AfdE7cm7D/6YGSyU4qLGzlhUNrivJCaZC7OtFP0SuW/tckxKLtFIskkQOoCX9fcv2Gn
 IY9TXZSH2rAnEM5yJk1hl5MhFDSyB4+js7Uw0eqLVBSr/SURP12y5BVPOJykvutZjMUjoUAsFv3
 oQvS37VU4dik4pWy3FiikvvTm5D0Hd7lUXdPygb9X93PFwPjNWJe2mItJNOW6WuzXi2Xv1l6GJQ
 3WV9zPf45kxlRsqBBRF39fOrx+f1PIvtYtZmsFN7f0LmGFKM6iyII3MPZB83V7AbV1Nn3magnRL
 QPNdUANVUV5Hdi6iSvDbYCs5ke3Z5T7HbxuyrzNXLB+zop2TrCyXCxQw
X-Received: by 2002:a05:690e:419b:b0:664:94d6:776 with SMTP id
 956f58d0204a3-664f96dba20mr2368743d50.13.1782808020724; Tue, 30 Jun 2026
 01:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260625111201.1645847-1-mark.caveayland@nutanix.com>
 <20260625111201.1645847-2-mark.caveayland@nutanix.com>
In-Reply-To: <20260625111201.1645847-2-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jun 2026 09:26:49 +0100
X-Gm-Features: AVVi8CeixruMaq7V5ToWsn01_Hp0fTARgK37ij8LgZGyyDKf7T9_FF7isevbCK8
Message-ID: <CAFEAcA8or7xgrNvP2G_in3Y7TF_N4s4mxHoU+mPkS5-OsZLMug@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object
 props to class props
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, alistair@alistair23.me, 
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Thu, 25 Jun 2026 at 12:12, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/adc/npcm7xx_adc.c | 77 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 70 insertions(+), 7 deletions(-)
>
> diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
> index 3584c27c75..833e01a913 100644
> --- a/hw/adc/npcm7xx_adc.c
> +++ b/hw/adc/npcm7xx_adc.c
> @@ -20,6 +20,8 @@
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/registerfields.h"
>  #include "migration/vmstate.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"
> @@ -229,7 +231,6 @@ static void npcm7xx_adc_init(Object *obj)
>  {
>      NPCM7xxADCState *s = NPCM7XX_ADC(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
> -    int i;
>
>      sysbus_init_irq(sbd, &s->irq);
>
> @@ -240,15 +241,63 @@ static void npcm7xx_adc_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      s->clock = qdev_init_clock_in(DEVICE(s), "clock", NULL, NULL, 0);
>
> -    for (i = 0; i < NPCM7XX_ADC_NUM_INPUTS; ++i) {
> -        object_property_add_uint32_ptr(obj, "adci[*]",
> -                &s->adci[i], OBJ_PROP_FLAG_READWRITE);
> -    }

In the old style we get to use "adci[*]", which avoids the
boilerplate of creating and managing the string for the
name with the substituted-in integer value:

        g_autofree char *adciprop = g_strdup_printf("adci[%u]", i);

Is there a way of keeping that with the new setup?

> -    object_property_add_uint32_ptr(obj, "vref",
> -            &s->vref, OBJ_PROP_FLAG_WRITE);
>      npcm7xx_adc_calibrate(s);
>  }
>
> +static void npcm7xx_adc_get_input(Object *obj, Visitor *v,
> +                                  const char *name, void *opaque,
> +                                  Error **errp)
> +{
> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
> +    uint32_t idx, val;
> +    int res;
> +
> +    res = sscanf(name, "adci[%u]", &idx);
> +    if (res == EOF || res != 1) {
> +        error_setg(errp, "unable to parse index from %s", name);
> +        return;
> +    }
> +
> +    val = s->adci[idx];
> +    visit_type_uint32(v, name, &val, errp);
> +}
> +
> +static void npcm7xx_adc_set_input(Object *obj, Visitor *v,
> +                                  const char *name, void *opaque,
> +                                  Error **errp)
> +{
> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
> +    uint32_t idx, val;
> +    int res;
> +
> +    res = sscanf(name, "adci[%u]", &idx);
> +    if (res == EOF || res != 1) {
> +        error_setg(errp, "unable to parse index from %s", name);
> +        return;
> +    }
> +
> +    val = s->adci[idx];
> +    if (!visit_type_uint32(v, name, &val, errp)) {
> +        return;
> +    }
> +
> +    s->adci[idx] = val;
> +}
> +
> +static void npcm7xx_adc_set_vref(Object *obj, Visitor *v,
> +                                 const char *name, void *opaque,
> +                                 Error **errp)
> +{
> +    NPCM7xxADCState *s = NPCM7XX_ADC(obj);
> +    uint32_t vref = s->vref;
> +
> +    if (!visit_type_uint32(v, name, &vref, errp)) {
> +        return;
> +    }
> +
> +    s->vref = vref;
> +}

In the old code, we say "I want a uint32 property", and we get
one. In the new code we have to have a lot of code here that's
manually calling sscanf and doing visitor pattern stuff.
Is there a way to say "give me a uint32 property" and have
the implementation be done in common for the new style ?

>  1 file changed, 70 insertions(+), 7 deletions(-)

This diffstat makes me want to say we haven't got the
APIs for doing this right yet.

thanks
-- PMM

