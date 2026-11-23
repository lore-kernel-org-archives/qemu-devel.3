Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BE606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KIfMsJNp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVT3Z-0005i0-B8; Mon, 23 Nov 2026 07:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVT3Q-0005dD-FW
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:21:52 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVT3P-0002vv-0c
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 07:21:52 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b4c685c751so26348017b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 04:21:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795436509; cv=none;
 d=google.com; s=arc-20260327;
 b=gVVm/M9GvZ93ERJx3DJucUO8aAFjf74UwOiokP7FASA6xbSTdB4DzoCVs9MyLe/ER7
 4xjkk13aGIeGmgSRO79gvv9BxkHC1Sd0Dgi/x3JTIMPlVVyVYB8+aMp8WI7gpD7krGK9
 G8jBEQ6LzDWfPYzdlA103y2R9qY39ne2GTqjUShSNRgfclUU1cYnUfZRdhwEZeDrPdKe
 mQ77ydkDI4kkEoTugjXflq1advq5BLbrW7jaCDuLF3Vu4V+wi2t/FeXT2/7ALtX/+YyC
 0oXX5JhkEM0Dnzq3nXSArnfzFjYIWFeQoqq8PSFYOFuuQAw4djy7LtJcmZKaDPZY4U+8
 QkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b0DtdAGH9rbHxFLixlQfAqIFfg9ZWvxzVJYbFSuaic4=;
 fh=LKIX6mL3VIRLGHaj+MJkwKn8otVLPibjcCOi5MZqphE=;
 b=VrUWe5rcnFDt6tW3gAH18vjg2zWmXtOjy2eT6Mh02kmc8nrNVYDFnmfB5Oip0MEtRi
 +x7asq2H0auAdWCuxgmFg8wJqcaORqE9sDDgTvPrLdnPp0q5q6+ALeQrU/H1yn2NYlJG
 zXUoaVnycCYWq8VOfcmwJkHa65Lihq8Gy1xozQA9X73tcYWPHv5XZ9OiYgpDIYBCCr+C
 fkDUtqUINEoAHjZzErE3wobNkVMgHxIEztnfsT+ltW6SDTnlsd/Kr3eTYZ/NX3SeTDvZ
 7fSZEF+yqRh2uTpuyQ67kXFHy1F8rR77YU2Qs+jfEhCQQsTkzxwUn5A+jh7C3foJW/Qd
 hfQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795436509; x=1796041309; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b0DtdAGH9rbHxFLixlQfAqIFfg9ZWvxzVJYbFSuaic4=;
 b=KIfMsJNpsOoj/fVNN96UyJ8Gyi0XUrM/gIQAsP+Om1/0vuQ18eol539JRpshNLjHgT
 eFwhmeQtjqEDj65aKvXX6yOUhyrTvEYj9A/IRoWjBxORGNLBWZwMnDYQdhA06xMa4QyI
 5gawj6b3tdOwSmAhhyGGF9pJOdJdQK6WRDQCf01lxCV3WLgt9O1D8nRN9/9N6S0HK/kG
 wiERMLU09IY7FHexkzSr1DPeHo87LwjkzvalINlNuHFvlhx4qFRR0M6hlNyn3knmjEVV
 55uVr9fl8tN9YfkE8OmFL/dXXZkKpQN2hae9c4WwPxkd6OToEqRBRgkwCMlMOyekRuYH
 jhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795436509; x=1796041309;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b0DtdAGH9rbHxFLixlQfAqIFfg9ZWvxzVJYbFSuaic4=;
 b=GL5FmWa9viSrIa7EJgP8NicUNGj01z3hmMgqWJAreARvKG4jZnrRsiVjAWjLDnwKUE
 AueD5DGB339lW9g/ZCXyqjFcvc13jlOKsBzqwaiOx+3L2EmRd0gr/UZG/ESkB2yb1mad
 mM4j/aKpAGl3mWCBlXQB0cqPVN6M++urRolbbbxk0jQT3FbY1820+BL1F+8Tumy31avZ
 q1UtNQJxo381y521tnuOP8fx9/qpLXL2UdcwoxrABWbge8HCl+vv2JPbXbLZwxBaPVkX
 Nf10GzyfdBt5MCAxn4RAnl55ysQdmOUomN4cnOI5yRRChTJyDniEUq4/L9hRo7KcoUEm
 CQng==
X-Gm-Message-State: APuU4Z9aUJ2p1GZRWZscU6IsNiKfgCYE78O8DEbV+TenayQcVf4QR5xR
 AHTFCRJxIWVXdJnpaOyfwIVeof7GQvebGubMMHUPL2cyFCAmSrrod5yf91EZaCo3nxSsnvGzliy
 VDA+HZFDUdTl74+PGeVKDhNSMVIMs7iiCxq6oydHGwQ==
X-Gm-Gg: AZFdTZdoF58ShXIWi8FY0xjXEvAiZNragJLQCUnWR7n7ieL6qjVAc5aKcMI667cm+1c
 JEbkpEXhTt9ms8rP96p44WsLdiNikKnAHs5Yy6zZMPA69eGUlS/5ilhsRudWjTCl9gqffWDqVQD
 TGZkpeualg9on1Oa02YtYmQscJpajC0E9P/zXmZHQKy7FDZ0Aoj/cwbWh3+fWCtlDKsi7QefUGE
 ofWdaSQ8j+0MOIO9WdaxBnz4c3eifIC0SpgxsNLNsEK7saCOz1Qm4TZLw72xhnjxEayb7gHpoyH
 mnCGBXh1rt+Xi1TsUbMu9a/GNMwM8qKJ2pwHCoJdqnpxd1WBGI4B3a854Wc5LhpZBu/ZyY+CWE2
 IOnRSpXof8UtU5qWuX1tAEGP3fiEls56wJ2K8nFpSKK9qhKsp+4lJYIGnwx1D6jTjKh28IHi0MT
 iilsgvWhJ+gJ6LsFSlkULa
X-Received: by 2002:a05:690c:3693:b0:8b3:1324:a74c with SMTP id
 00721157ae682-8b52047d8dcmr34345417b3.53.1795436509404; Mon, 23 Nov 2026
 04:21:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120124923.1656220-1-peterx@redhat.com>
 <20261120124923.1656220-3-peterx@redhat.com>
In-Reply-To: <20261120124923.1656220-3-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 12:21:37 +0000
X-Gm-Features: Aa3M54o932K2Sox5umNtdFXVNO4i61_ZHXNcpUkAsiHwolUe1oqINX-HGwqwFXU
Message-ID: <CAFEAcA8i1-QX-x+fvcfEMknia1owTAukRxNQ1Rb0H6KnwCKt2w@mail.gmail.com>
Subject: Re: [PATCH for-12.0 2/6] hw/gpio/zaurus: Move VMSTATE_VALIDATE()
 check into post_load_errp()
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 12:49, Peter Xu <peterx@redhat.com> wrote:
>
> To pave way for removing VMSTATE_VALIDATE(), remove the use in this file by
> moving it into the post_load_errp().
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  hw/gpio/zaurus.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
> index 3cf626a550..a60f4d4393 100644
> --- a/hw/gpio/zaurus.c
> +++ b/hw/gpio/zaurus.c
> @@ -23,6 +23,7 @@
>  #include "qemu/module.h"
>  #include "qemu/log.h"
>  #include "qom/object.h"
> +#include "qapi/error.h"
>
>  /* SCOOP devices */
>
> @@ -188,12 +189,24 @@ static void scoop_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>  }
>
> -static int scoop_post_load(void *opaque, int version_id)
> +static bool vmstate_scoop_validate(ScoopInfo *s)
> +{
> +    return !(s->prev_level & 0xffff0000) &&
> +        !(s->gpio_level & 0xffff0000) &&
> +        !(s->gpio_dir & 0xffff0000);
> +}
> +
> +static bool scoop_post_load(void *opaque, int version_id, Error **errp)
>  {
>      ScoopInfo *s = (ScoopInfo *) opaque;
>      int i;
>      uint32_t level;
>
> +    if (!vmstate_scoop_validate(s)) {
> +        error_setg(errp, "irq levels are not 16-bits");
> +        return false;
> +    }

I would put the condition inline rather than into a function
(especially since the function name is not very informative).
Otherwise this looks good to me.

thanks
-- PMM

