Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D534F10F92E3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 16:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7cPO-00037F-9H; Tue, 31 Mar 2026 12:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cPL-00035W-KC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:57:40 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7cPI-00023o-D5
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 12:57:39 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso8946805d50.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 09:57:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976255; cv=none;
 d=google.com; s=arc-20240605;
 b=JP1OAv6UzunUPe53/+ehh5hWKyTi9zaHnzP6jstOV3uEUvIkXJPtG1DZQLMhQjna73
 0qHuCYx8jDjX/Nm+NIqhSiDAH/W7f5ZErAd1iZ01ScAdcrWeGkQYb1ai9MboLzKw++ZI
 fsTYiUJp6orxCtOq4ppHmHV6oM8E+yVQgrCgMh3vrvGJyqu0H1KpwuImbQ7/TkqJhu4H
 ZFYnMJijGU/aoteqPyovQsul428wxCyQNAn7cjqIEOgxEhBKSGLahYPqfaSM2yFb0oms
 J346IRnKY20Tuq0y2aAIMMEronon0c8TdxKeY06hSZFgvtnQmmMsAXqaMHso4XkUDc9t
 +vew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NNVS0U9cghrUwlphwuETo+cau/aLoHDBM41hKbEqqFY=;
 fh=C6nSCE5LKC5RuqcGtrq9dsN9XQcZIV+WhX4ZNDyo0OM=;
 b=NehB1C52u9sknLKk9a11zn2opmYtMaTdJsEUWi47FbMvjiBET/9dkjHPySL3YdpLRR
 nGwpnJ0u0BiaNZXW6Bac9vxw6AOj6z/QUVpSnptlpP6G6wIcdf9QO5nxYzq8AN2hFlY6
 iB0N82HiOWLZ9vdaVMmmmNvkBoAQCewSkzxo7bsH293Vlm0uuRZEV1X+eiA/iLiILvgU
 3yl6OiU3JTWtR7yUe3jbtOCNOYE4VV6s+RZ7e5sXOt8ruUTXICLU7pabeWHf4hEqM2if
 R0Jx/6G3cr/Rkdm2xjqn6WIlx4dOjdpg6IKURaSQh+qcnGLfa0QxBFXDw0+oDV7xmFlP
 uc2w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774976255; x=1775581055; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NNVS0U9cghrUwlphwuETo+cau/aLoHDBM41hKbEqqFY=;
 b=N0Ffbh5tU9ERHlQVTrp4PUGyezJYEOZgZhmKwnXe0lXY37S2qOHlZejk32G4gJ4oTl
 0I/PE0qA4UbFaSNstTmM55bA2PZCI/A9pcGrW1RjHeRU0Dl2wkYBsoqeG5xHbHUyCcKu
 TTxHyNdzaA5kAJg5P1lmkuX5/VOON3kmpcV+Lk2bCE4pLta1o2ivO/3qNE7oAybGzBte
 c92menyvE+sDsv8hfeZDiCzVaKJHKvMmR5w+f6bJxPt4J6AFRh3OPkQrQ6v/8aP56GLl
 iSjU/CyHfhMXvpp/kxym3UX9QkotH8xbb4fyZxZ+F4vT+JPQ7fIQbAkJvr2odfnL64oF
 WWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774976255; x=1775581055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNVS0U9cghrUwlphwuETo+cau/aLoHDBM41hKbEqqFY=;
 b=l9IHoqNvFTmScPjrRDzEtJj8qYO8QdEsNUwCsaGxV20KTrA/AskBv0V0TyW2x9Qgl4
 Rd6yd9UHB7L9xQCUQp3p0GfoSQCz2yUo/9EcXP9bvKOMiIoU346yrhqs6hYDQFfgoaPU
 HYonjDh1g1tC8P9MhruXQ25N8Woc3AKvKILkCSjMnBBtm194d+9AVcx5GRpXYNfJRkjY
 11G7bs7BklhpHIaRCZFBvJ1VXjE9w4oUViyZ+DjCFHmy9lUq2Zhzq2mr5VzWNvmCPhtk
 NHvgpjagL73czrCGsdM+0v+qPnMK3rwEllRUMbxAyhtLbsMNIKQYQ6NB1qKilIQqWm5l
 COHg==
X-Gm-Message-State: AOJu0YxTTQokehhN6P3vl4PDT3V0PKPI0MlExoQURYU0YHilGCSZBmZC
 c6wAsLS+E8K0ekJooWuhv1k2PBsuegxy1e3jFXVaE90S8QNhtGsYW1KVim7Ao/TiyrDsVVujv8k
 9TuwEWd1Ov5Aah+34RLi5lQWO9M4R/XTGr32J2TzhWgQjjIQPPzM9nbw=
X-Gm-Gg: ATEYQzz6XS13HI0ov9SuyJKHXMZ7EShWa7ZtLmM5B48xl2lzWLsY7uUxny8jlrCdcWj
 w2cRVBI6DrGj+IRSRgvMmNVocsOret1dH9lLU9FPzE58iHtzxFvs5V1YFZb1dguzwXtaspP563e
 rJGpRPjF90wv0EceLDjwmMWIRFxq3kg/BYVfGufb+3nHvNGDWETMiDzi6aDodrJwcnjEweYsVWa
 8x7jw95GOr3ElNwaUAxDATU1El7Hm+sYIvCLxaUkxfBuiHo2NS+xloQKnUQZXIgMrGA6W5Ku5yX
 KIy5ab45P3uQ6yWJ65HbkQKvYcComKj67gSZzD6nVrZT4bf8ZQ1jssDT9+fFn9d/gTwFvkNnpZr
 Ctg==
X-Received: by 2002:a05:690e:43cd:b0:64e:e380:c841 with SMTP id
 956f58d0204a3-64ff73cafcbmr11659106d50.50.1774976254996; Tue, 31 Mar 2026
 09:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260317053827.25051-1-shyliuli@aosc.io>
 <CAFEAcA8OHsqAfbU-C90VdtVineOHhKKZYg+7H1dTcqNeyKcGOQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8OHsqAfbU-C90VdtVineOHhKKZYg+7H1dTcqNeyKcGOQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 17:57:22 +0100
X-Gm-Features: AQROBzBA_sdR_3fqd6dpT4HzAsDDhfUXNZqnX1-WOcx8KOlVdPQozxSUxiXaWG0
Message-ID: <CAFEAcA_W_n0UEJpBP_E5a8PFD6eUCG0NyRR3npbdpbS-OZLVEQ@mail.gmail.com>
Subject: Re: [PATCH] linux-user: Make openat2() use -L for absolute paths
To: Sun Haoyu <shyliuli@aosc.io>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Fri, 20 Mar 2026 at 10:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 17 Mar 2026 at 05:38, Sun Haoyu <shyliuli@aosc.io> wrote:
> >
> > openat2() ignored the -L prefix and opened host files directly.
> > For example, openat2("/tmp/file") opened /tmp/file on the host, not
> > QEMU_LD_PREFIX/tmp/file like openat() does.
> >
> > Fix this by using path() to rewrite absolute paths. Skip this
> > when RESOLVE_BENEATH or RESOLVE_IN_ROOT is set:
> > - RESOLVE_BENEATH rejects absolute paths anyway
> > - RESOLVE_IN_ROOT resolves relative to dirfd
> >
> > Now openat() and openat2() work in the same way.
> >
> > Link: https://gitlab.com/qemu-project/qemu/-/work_items/3341
> >
> > Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
> > ---
> >  linux-user/syscall.c      | 11 ++++++++++-
> >  linux-user/syscall_defs.h |  7 ++++++-
> >  2 files changed, 16 insertions(+), 2 deletions(-)
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I'll collect up this patch for a pullreq for rc2.

thanks
-- PMM

