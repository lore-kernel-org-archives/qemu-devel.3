Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04B8CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 14:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1n6n-0000WQ-0v; Thu, 25 Sep 2025 10:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1n6k-0000WD-Mw
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:38:06 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1n6i-0001T8-Js
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 10:38:06 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71d60157747so9782147b3.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758811079; x=1759415879; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OMWJMGXVc9HHDwP3xiyZIeNdiFlZVGvXOMNmaZr3GAQ=;
 b=Ms4ZIK5cJCT3pGFknilLg87nO8bvYCBd5zlEcfSyJ0ULdcPeWNB5L8QApJ/lw2QdFV
 JAY8i4TMu6BIjG3PgD3sgHgm4w5YzGTalrozyhX6IBCVrtbGmHTRiYX8LzJJc945hOQ0
 zxGK3wMnbvVyMGBB37mjHCugSC+0iuLmMLGFd4hYJoyDsqoKBayjCaNvYY2kuJM9Vyfa
 NXDI+dxEhKH/0xr/doCzleBKFVMrX2iCYCWmE+UyDAZ/BWV5EV6BcuPQF1dSA9ZfbCnJ
 Pv1RIWf7+7WzmKA/pC23dS8OBoWXCIQZccGJPz77nhh7t9Rao+BXn1PKeKhYdYo6/zeq
 CFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758811079; x=1759415879;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OMWJMGXVc9HHDwP3xiyZIeNdiFlZVGvXOMNmaZr3GAQ=;
 b=arA8QMre8wwOmdmGdIG13e+f0hfyZ+Z3Ba9itfPjj8mkg1822J3ppN62Ipe3Tr8oJZ
 RLnu44NdycFWvVSfx7pBO6GysV9Jh+ajisf3u+bAO2tRejoBnvJ4XRkF0TsGjVJShUtl
 FjGoqIoyfZeZ3qq6HCpPJJP1IJfG6zuIFlLgnWxfzjUHbU4bC94rZ3TlO+3yK7p3rftH
 XRbXsFSf4ClulrnP9qHFhyf0LyIV0IlM0Ft1x4Z6srkSorcWJmbFPOw7HP7xxQEUW+99
 iposrmN18abAKOpC8Q/7/5Ji3MQi33/i5PrRyWnCQsvtBD/3jLPCqYah2GyC0BLw2rBR
 ejGg==
X-Gm-Message-State: AOJu0YwN260kflCsDJUZJW7nBgodnlvvWnreDZCdRzvFdihxqnpcx10/
 zdslQ19UYotbhQ9sjtNMcCNM7Tv0pvGswkEiNMGAAt00B9LtTgVN24FkCGKnk0/iugJxI0kVC7z
 hmkleRv1X5NzBJ8TaKQ8cSCuMgWY1eaqVclaUVEUdL/hyVIc8WIDC
X-Gm-Gg: ASbGncvuE6jEx7D8v4uGWH8LPH5LK8RJtegpKORdZ27tcxd6eIgN0TAIlnXQVUY0K6b
 w6XVjQykQLZGnmUFgY/1aqnbahEw1MWr+Ngl+rLgXyaClGGk05vQx7rjDlmnFsbyus96SB4M/2Y
 4HqeRnQCFW5gPOoXmVZguISMGqyHt0iieVmiTUzfwk3UICBuSIQKBqp6frWWeiRv1kiMERWnTPe
 Iu+1IS5
X-Google-Smtp-Source: AGHT+IFuPX+SMediBR/46eOuhGmX97/hwoqB5YUbPA4uO32+OWDo0h6scJijOxa/mw4s3F2AJUXcX1bdqYQnLwlehkI=
X-Received: by 2002:a05:6902:2b09:b0:eb3:7973:374b with SMTP id
 3f1490d57ef6-eb37fa000a6mr3708584276.0.1758811078491; Thu, 25 Sep 2025
 07:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-37-richard.henderson@linaro.org>
In-Reply-To: <20250916142238.664316-37-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 15:37:46 +0100
X-Gm-Features: AS18NWBpi0-mbcAdBTAISbZ6QhjWhXzzUOMSI1rW20FTdDDe1-mfLbYB5c_PLzI
Message-ID: <CAFEAcA_b-g9YJN_-phznj7xiXYTrwL=3=_1VfwEW4hYuPBZ9uQ@mail.gmail.com>
Subject: Re: [PATCH v2 36/36] target/arm: Remove
 define_arm_vh_e2h_redirects_aliases
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 16 Sept 2025 at 15:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Populate vhe_redir_to_{el2,el01} on each ARMCPRegInfo.
> Clear the fields within add_cpreg_to_hashtable_aa32.
> Create the FOO_EL12 cpreg within add_cpreg_to_hashtable_aa64;
> add ARM_CP_NO_RAW.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

