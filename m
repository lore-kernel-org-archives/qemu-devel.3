Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C355C4451C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWVG-00062A-AB; Wed, 21 Jan 2026 06:36:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWUr-0005rU-Ad
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:35:37 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1viWUp-0001dl-UN
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:35:37 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-78fc4425b6bso60608097b3.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 03:35:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768995334; cv=none;
 d=google.com; s=arc-20240605;
 b=amEMomt0nU/uFkTg/MpJ/mYpNa0hRIPS22vxWv4Hs7j9FaKDlZgMLDenEyYMfHEFrr
 6GHiHcuhea3XhzXy1mXXIhmRg5Rby+PfXL5SI94IQogqekGFuXVTNR0J6d98k1oKs5uz
 hNSGEiIE9JUzIU3ZfBpMTmPZKo1AWIU1QSd51jTAt+sVOMBtny/eMGUngnyniUE5XaTw
 iaHjweytD3W8vVnHvS/1pir5dQl9AbNHTcfYqJEAla5Af6pUZ0hSYaXYkWur8aJ7tRWk
 rFSKKd+6rwalVL3oLgprvMf62iToKTGg0SM6TL+Mx6Iq5GQB1BFRzHUgxVaKqqvLqFAM
 PW3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CTXGStSvmm1yjBO9Xjutw8UK+wBr8b1H6oZ0poQIm1I=;
 fh=qDEitYY2TPRRMZ4OARbMiUT09q8rCCMKzcZWPtML1Tk=;
 b=gO+Dv07vgohdJqkDNdnfq/B0HpXMv8r2bgRqCj6zNoJu0iZ9AK4JvRPCIvQ6oLoPXy
 SR75eZCfp5upGuJzAgfOLtlUmao+itAu916hJLG0gOdbM69Nk799sR4SeqFvyhisDrRc
 WrYO20IN3YE7Q/7ClrFeAEf4sO2/IdZvzZidyA/e508wqnYGWHQ0q5kEZZ4dqXssBA8J
 65fWzGnbyTpIFKz0ZW7GNl5kpRAHgAe1FEUYcf/XJU8BLm5i6zWT1hOZIAvxqsVTKuDT
 6O4wWTNc1xyDIiPhbMmKTt9AevNlmD2jHWiQhkao23zbp/x2/1RBrxBvhRX+o6ku7Jyj
 ofXg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768995334; x=1769600134; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTXGStSvmm1yjBO9Xjutw8UK+wBr8b1H6oZ0poQIm1I=;
 b=RrHO2Z0JiarAdyrL7F6Y1Nmesh91uo7dgKJDqmgKFvPx5ojAKeWW9qh+QWJsZaneah
 F70+IXqSNKN8M2b8nY0eDHCQ6+ngn/Zu4KBO+IldTBdeB8LK05GTKHBoCDX0+3EpbcYc
 rsWYPiBHdySzuLHx72a/ImMdXJpVNeEpvlOzQSMljsLRJNicinqQ1hYv5hagZSx2s+UH
 k8DhSR7qrZJDvumh7pf1W1wukM6HAgbf05emUWLvAhU6byIq1HivmkBllZDhxa94uiSf
 LnuQQMNgad4BOPELJ5BEFYRZqQHsWbg09DAE9AGBWJJOhyYu6RmB0YQMJupRsApYCWfx
 er0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768995334; x=1769600134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CTXGStSvmm1yjBO9Xjutw8UK+wBr8b1H6oZ0poQIm1I=;
 b=PLDFvRQndB6s5GkwqMBBboInu1++qaZEF5tplPiiidsGi7CVJN/FR0UzhhnyaOJhjx
 B7cyNx1Ads6dunQD2dMqjeNx6YuHjWGJ2iBDkzMc4BW6GH4e4QXHm8//STSIyNZl3871
 s9PHEQsAI+DWHbomZmwx9rhQZAnsIinfkzJmasF/ZHfBiILK6ef1o2rFLAtSRS/26iQV
 HshYO28G70IoaSO2hRZZ/+KOnpDWfs9qO7f8z/9YkzXA5aoFfxlCAfDaEkU5rxLTOcU+
 xLauJdYK7FNfvWB8Ut8LegZXfwSrT6+Rd4TRj7bNF3MjgCq3mOfNiV6CACP8QzkQ2kr9
 eCnw==
X-Gm-Message-State: AOJu0YwxOMYDIfGljnmm69KxkXOgnQtBy+iaTDMRU10WG/E8qXSr54uX
 WpduFsi4rFJ2dCRk5uWGtyof42ZUAqJ+pYR3EbfQO/HSSG6zA3ZoI7EHcqVYPePDCSzFkA+XSKn
 dI+znidgwC9BjmctgjM5iZsdEmABGjNkdD4XhFneMKqmcQODp4pMC
X-Gm-Gg: AZuq6aJHZv6vXm7QUG9P05bgfP/R1Umcscwc5+uPW/A9YT4RxOh5IW38/WPRH0NC4Qz
 RYFf+bd1U7+b5ph9slL2A92A0IgBRjgb+oFBuTG+UC1gEhV88eaRrfB+sFTaaPrxUI2s+o4zifL
 x6rX5pPcFshED2yb4bm+yhXiQxr/Bs4wEEjScJrmLdwRzIVXl/ruVFBMiyCEYmCUvVgmcSvSHYP
 sWh1kvaptOVV0Hzv+bFBX9xllXU21+UU3KZ716VY+6jM6DApsnBSv/ueD4k98vSlBGAWCctSI0M
 Oa5a
X-Received: by 2002:a05:690c:6a08:b0:788:c21:b05c with SMTP id
 00721157ae682-7940a48aa91mr42179337b3.63.1768995333696; Wed, 21 Jan 2026
 03:35:33 -0800 (PST)
MIME-Version: 1.0
References: <20260121105932.135676-1-alex.bennee@linaro.org>
 <20260121105932.135676-3-alex.bennee@linaro.org>
In-Reply-To: <20260121105932.135676-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Jan 2026 11:35:21 +0000
X-Gm-Features: AZwV_QhdYF7RNzfudv_Yo6xtdJHYK7rGmuCbnFW6W2vq345xErmbhGyC2qQ03w8
Message-ID: <CAFEAcA8L7afLEPCxrjvPqB-pxfY4crsa-w8KmmKGHnAgiWrqVw@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/intc: declare GIC regions as little endian
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 21 Jan 2026 at 10:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The GIC should always be a little-endian device as big-endian
> behaviour is a function of the current CPU configuration not the
> system as a whole. This should have no functional effect as the GIC
> cannot be instantiated on a BE system but will help the single binary
> efforts.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/intc/arm_gic.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

