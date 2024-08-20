Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD7AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 08:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgKQe-0000Xf-7v; Tue, 20 Aug 2024 04:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgKQc-0000X9-JO
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 04:41:23 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sgKQa-00064v-MM
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 04:41:22 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f3ce5bc6adso28840441fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 01:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724143278; x=1724748078; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YqZvv2kEqvcbRzWm1CZPTiidR8LzbsML7RFTqak7cY8=;
 b=Q6nJEChqFHweZeNboRAFOks8GmFDbDEoGeg3T1grOoavQT5fveZsay9BCNZ5Z4clUt
 P4+emaML7Ea/cvuYrNGVZpJ5g1WtX4N6YIRnf30nJI5TjlZazUzFUUA4/o+DS7F5IOnk
 /mEVd4/LRkOKTsDPFg3iOjJAJkDlVdbV9R0d0/J2ip/0nlKYbtY4rbvRzxFdpHPaYYxn
 rvUMrYFKyGBrjbsJ+WjiNIG15J6fyC1gx+WzWsXw6j+mm7BxD1DJ0ltQevoWTk6wg/jn
 Z/EwcJacdw26OyjM5M7+NsCxGKBb1f0NUvBMNJiy6joD1rmgj+LCFEr4ATlWqzI0z2F2
 tP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724143278; x=1724748078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YqZvv2kEqvcbRzWm1CZPTiidR8LzbsML7RFTqak7cY8=;
 b=U5FH6GH4ONFDg9ti5hOnvA3PQxLEiAjEGJO6sLOAz++exffz/bbzTQe9t2+fQemX1g
 Mb/FMjudH/tAKkTLvI8SkudqW2fBvg/iQNckreIIyvCY8wmJ9ycKzZdaV5B/50goJ508
 9kwpBsEf8K+DADjKNKJ4npVrVR/jWny1ugBo58I/Xoia6nRwLNDKJhpuZtGCrz2eRr4g
 wQyhZNBwTD90USAm5rWH/7bdH/1OH6z0FygRUNj8ySjYSCbwOmn/zXQ7koympLxXwie/
 y/8o8+m+ZnqLX2N5Z8/71N7Bnk/Ew2MFIVIKLLkMl3OqKv5tdlOhQjJTkbmikIj3QRf6
 1lHA==
X-Gm-Message-State: AOJu0YyI3hfgoRHaqKT0KDOvlyVqgQW/EAFkskw6SfDerWaxvDkCknEv
 RgSxp7bOyvnvq5iPhDPXJmpRJJLJVfPeReBA9aO6VGVBYD224u4ofl5PU2Y+toJ7rkVNuu6fHd4
 yM6dm1NLU2WkAViheGixBj9POEvGuDdp+4jRxgg==
X-Google-Smtp-Source: AGHT+IFgvdzbNE97plFlj04RE0kzwRuU1WDsy8aUqzfqTZa6lNLqi9reXz5ydYaWlPODsRBPlTTziIYomUNHIKBKyCs=
X-Received: by 2002:a05:651c:1504:b0:2ef:2472:41c7 with SMTP id
 38308e7fff4ca-2f3be576689mr94444051fa.7.1724143278072; Tue, 20 Aug 2024
 01:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240725055447.14512-1-yaoxt.fnst@fujitsu.com>
In-Reply-To: <20240725055447.14512-1-yaoxt.fnst@fujitsu.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2024 09:41:07 +0100
Message-ID: <CAFEAcA_MDwXrgi3xALUZcRrNq_ds6LyL2HwvCS+Syv8vwDGW-Q@mail.gmail.com>
Subject: Re: [PATCH] scripts/coccinelle: New range.cocci
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 25 Jul 2024 at 06:55, Yao Xingtao via <qemu-devel@nongnu.org> wrote:
>
> This is the semantic patch from commit 7b3e371526 "cxl/mailbox: make
> range overlap check more readable"
>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  scripts/coccinelle/range.cocci | 49 ++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 scripts/coccinelle/range.cocci
>
> diff --git a/scripts/coccinelle/range.cocci b/scripts/coccinelle/range.cocci
> new file mode 100644
> index 000000000000..21b07945ccb2
> --- /dev/null
> +++ b/scripts/coccinelle/range.cocci
> @@ -0,0 +1,49 @@
> +/*
> +  Usage:
> +
> +    spatch \
> +           --macro-file scripts/cocci-macro-file.h \
> +           --sp-file scripts/coccinelle/range.cocci \
> +           --keep-comments \
> +           --in-place \
> +           --dir .
> +
> +  Description:
> +    Find out the range overlap check and use ranges_overlap() instead.
> +
> +  Note:
> +    This pattern cannot accurately match the region overlap check, and you
> +    need to manually delete the use cases that do not meet the conditions.
> +
> +    In addition, the parameters of ranges_overlap() may be filled incorrectly,
> +    and some use cases may be better to use range_overlaps_range().

I think these restrictions mean that we should do one
of two things:
 (1) rewrite this as a Coccinelle script that just prints
     out the places where it found matches (i.e. a "grep"
     type operation, not a search-and-replace), so the
     user can then go and investigate them and do the
     range_overlap they want to do
 (2) fix the problems so that you really can apply it to
     the source tree and get correct fixes

The ideal would be (2) -- the ideal flow for coccinelle
driven patches is that you can review the coccinelle
script to check for things like off-by-one errors, and
then can trust all the changes it makes. Otherwise
reviewers need to carefully scrutinize each source
change individually.

It's the off-by-one issue that really makes me think
that (2) would be preferable -- it would otherwise
be I think quite easy to accidentally rewrite a correct
range check into one that's off-by-one and not notice.

thanks
-- PMM

