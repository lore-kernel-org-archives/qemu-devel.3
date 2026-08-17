Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADDC2C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 14:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvyel-0003j8-QC; Mon, 17 Aug 2026 10:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyek-0003iZ-GU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:49:42 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wvyei-0002en-NZ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 10:49:42 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-836d2861a39so40653997b3.2
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 07:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786978179; cv=none;
 d=google.com; s=arc-20260327;
 b=ZLN8j+MabWoGg0xKpgO+Rc8LtZ1EoC14R0pKLaahY/p85gKJ3jJ++fEhy8SacbaXVA
 9x0alsBH7h5M4JF26PufocsO3DrJ+mxCjSz3pc1+LMWZiL/hTlLt/isbtIkoxB9trk4x
 QMJoLaZF/OSnCJmmoLo3iSB99zRbLLlVCovST+OPMzUTBIw85fhxNUWjWk5LCj2UzeYL
 tfYz8CyXRlCX/1/kY5QDQZ20kNGGdW9b5Er3MCrXzBEojjD3EKXq4C51uBbmmGfRYYZN
 ommIeQEY0wLb+ix6tPpOMEW9lKzObR8UU3FlrJDrJOHCJKXCL7gPKk8Wo5sgCvi8iTbZ
 VmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2dz+O5+2rC1WuRdtahCmsmp+12rYUniA8XnOvH4E7yA=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=ZGVfY0FSEDieUGxuKGPaj/1fu7ZwIg6SWgQr8uaJn7nVFWYwI4nnWbfvDf3mDSv1Rm
 5fygELhYheR4zf7Y/l67JHvSseLE88sZ8K0k+85AzlwH6h+4Dx9e6QzingSGdhuzBgOB
 iiftzMN8WpebEEfjBSMI3MDymHWG2jS8e/iYkse9t/lfDhVabcpLlomTG/hbUgn2fJWR
 TQx04VNJtM14utgOjf4YpZ0dAm+X7VUs9bRWh2OxceD1g/gkNJb7kosgOqS702ZiJ8RP
 mlzhtkKU4zK62YbAUQxo+2s3PivY3cNZfTgiKHLIuc4ZLiyWm5cH48cf1n58CPduA+Hc
 uZiw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786978179; x=1787582979; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2dz+O5+2rC1WuRdtahCmsmp+12rYUniA8XnOvH4E7yA=;
 b=UBcJPGSFff1Fj8Di4AlnR8GB/0n8vfnkTKtGeq7EMxvv9lG7ntfHr+Dla8Rm9mvncF
 RJBdu3XkJ77J85/RMKm8dUSvEw5qwEKFFHwv2tWY0ML+cOgsyubC90NcOETVeq2RgYjZ
 wa2k8ESmUwSJGZ4mXKZMcBR/AI2z7/WSwkFcfhYl2qHHvX9YXss9OAT2tO17TBFDfrEY
 Mhc9AFHC2NPmjii0TWL0p8S5wxNzy7Wfpk4iKe46CADgUI76lP5XWQBRC6x+8WN5eM+A
 80WzIn4eZ0n2p50CzcZ8GAy8jrwbz/m51NDBBF8yoW8JbpUZgY6zxx89EUtKIH9fhjka
 KCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786978179; x=1787582979;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2dz+O5+2rC1WuRdtahCmsmp+12rYUniA8XnOvH4E7yA=;
 b=EboooNbleeoPOHyQntWw0KzgZOFOeNV0Vg0L3G/D09lkVDntc3kxlviyVDCxG9PM/y
 wgCiEhBBTRUfV/4wgW//HFWnYeryDbFii8av7ko0nPw0a3/zhP8p2siqVhfar80x8QN/
 kj3Jk8l8UeY+PTOBm8zF9ARvpgl9KLn78muzFx491LaOjtMQzvoEQpGcek01TILWJHaI
 KLuYy8ADgyoEEBd2iQd9k5/cwHD6sWtl9g3jHyLnG67yYli6cL8LBoOgx2AghIjsxCzw
 O2NkQLF00V19vlWC1Z3GAQmKhfntgswbG76+27elAlLylxU7NlIjaYqEkU2u6iykTt1n
 cmbQ==
X-Gm-Message-State: AOJu0Ywe3DjMYobxn3KdnOdE4bFVaxB3hpNGxmIZ6iMxoN4ZQGhG1zph
 mQWTlxJBVzeqgaO+QUF47fVj3DnPj6DsWCR3gzfAzvNgHgBxxkDSQ38V/oyFRRbJed1Jvx847gC
 culEFgOJdnL4vIULO+d8ZAsNmSguy0i/10BZTfn4qnw==
X-Gm-Gg: AR+sD10H6rEoZ6gvzxNYeaRiMrDbZspl2kfVioMbleFpvFqi52jP+OoifW4PowNLi4L
 bkjej6o7npXqkk5jMU/pY9WbZms06FVFJC91Bkn5yo2dvodijgbjXo3qaI+2P6SVuo2B5A+p5xE
 66VAbujrIUMEDHVD9dL2NqLrnAsHznXU6KGtTWHdsdn6hqSdXuT8pimDJOIxO83i9vNkDTdxKRw
 JoZ37xmRaIaDRg0+y3z8UrKNl/e9883Sqhzb+GQHk/Mfa08Gao1vE5t46NcmbA/2CK1b/pJviL1
 9NwWYjinXGP3NBhK4/S2JgX92DcteeDZwpmnGF10Y9LZn4b5253bqXqUp2ByGc1fc6YsORCuKBw
 thX05GjKUCN5fu1dGw5VZgBkyaPPh
X-Received: by 2002:a05:690c:6013:b0:81f:d3e6:82ea with SMTP id
 00721157ae682-8370dfb3914mr101496977b3.5.1786978179092; Mon, 17 Aug 2026
 07:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260812204435.295067-1-richard.henderson@linaro.org>
 <20260812204435.295067-10-richard.henderson@linaro.org>
In-Reply-To: <20260812204435.295067-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Aug 2026 15:49:26 +0100
X-Gm-Features: AcwNN1V4o9MTM2JqOL7PGEm5OFb4_wqyNrlxCYRJ_yQfS3hfr0tGmhiRFahjKyI
Message-ID: <CAFEAcA-bLDVEqqJs+Ty+s8nKbfDOzAxwXW4f6z7iPNcAKHgKqA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] target/arm: Annotate arch revisions in
 aarch64_max_tcg_initfn
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Wed, 12 Aug 2026 at 21:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Annotate the minimum revion from which each feature is OPTIONAL.
> Modulo some sorting of properties at the end, comment changes only.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +    t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2);       /* v8.1: FEAT_FlagM2 */

FEAT_FlagM2 is optional from v8.4

>      t = GET_IDREG(isar, ID_AA64ISAR2);
> -    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* FEAT_RPRES */
> -    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
> -    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
> -    t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
> -    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* FEAT_CSSC, FEAT_CMPBR */
> -    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* FEAT_LUT */
> -    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* FEAT_ATS1A */
> +    t = FIELD_DP64(t, ID_AA64ISAR2, RPRES, 1);    /* v8.6: FEAT_RPRES */
> +    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* v8.7: FEAT_MOPS */
> +    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* v8.7: FEAT_HBC */
> +    t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* v8.6: FEAT_WFxT */

existing thing, but WFXT is in [3:0], so out of order here

> +    t = FIELD_DP64(t, ID_AA64ISAR2, CSSC, 2);     /* v9.3: FEAT_CMPBR */
> +    t = FIELD_DP64(t, ID_AA64ISAR2, LUT, 1);      /* v9.2: FEAT_LUT */
> +    t = FIELD_DP64(t, ID_AA64ISAR2, ATS1A, 1);    /* v8.8: FEAT_ATS1A */
>      SET_IDREG(isar, ID_AA64ISAR2, t);


>      t = GET_IDREG(isar, ID_AA64MMFR0);
> -    t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6); /* FEAT_LPA: 52 bits */
> -    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* 16k pages supported */
> -    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 2); /* 16k stage2 supported */
> -    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN64_2, 2); /* 64k stage2 supported */
> -    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /*  4k stage2 supported */
> -    t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);       /* FEAT_FGT */
> -    t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);       /* FEAT_ECV */
> +    t = FIELD_DP64(t, ID_AA64MMFR0, PARANGE, 6);  /* v8.1: FEAT_LPA: 52 bits */
> +    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16, 1);   /* v8.0: FEAT_TGran16K */
> +    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN16_2, 2); /* v8.0: FEAT_S2TGran4K */

16K, not 4

> +    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN64_2, 2); /* v8.0: FEAT_S2TGran64K */
> +    t = FIELD_DP64(t, ID_AA64MMFR0, TGRAN4_2, 2);  /* v8.0: FEAT_S2TGran4K */
> +    t = FIELD_DP64(t, ID_AA64MMFR0, FGT, 1);      /* v8.5: FEAT_FGT */
> +    t = FIELD_DP64(t, ID_AA64MMFR0, ECV, 2);      /* v8.5: FEAT_ECV */

Existing thing: 2 is FEAT_ECV_POFF (optional from v8.5). FEAT_ECV is ECV==1.

>      t = GET_IDREG(isar, ID_AA64MMFR3);
> -    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);       /* FEAT_TCR2 */
> -    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);     /* FEAT_SCTLR2 */
> -    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);        /* FEAT_MEC */
> -    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
> -    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* FEAT_S1PIE */
> -    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* FEAT_S2PIE */
> -    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
> +    t = FIELD_DP64(t, ID_AA64MMFR3, TCRX, 1);     /* v8.0: FEAT_TCR2 */
> +    t = FIELD_DP64(t, ID_AA64MMFR3, SCTLRX, 1);   /* v8.0: FEAT_SCTLR2 */
> +    t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
> +    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* v8.2: FEAT_FPACC_SPEC */

Existing thing: MEC and SPEC_FPACC are out of order here and should be
after AIE.

> +    t = FIELD_DP64(t, ID_AA64MMFR3, S1PIE, 1);    /* v8.8: FEAT_S1PIE */
> +    t = FIELD_DP64(t, ID_AA64MMFR3, S2PIE, 1);    /* v8.8: FEAT_S2PIE */
> +    t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* v8.8: FEAT_AIE */
>      SET_IDREG(isar, ID_AA64MMFR3, t);

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

