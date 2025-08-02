Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5A9C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJ0G-0003dV-Qp; Sat, 02 Aug 2025 16:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ0E-0003Vb-L2
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:38:50 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ0D-0005Xr-5R
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:38:50 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71b49a8adb2so27474777b3.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167127; x=1754771927; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9DgCkyJdUocBDv5VuprGQYdy+MVXJQugkzXPchaw5jk=;
 b=cciZeCarKakWf3Ucz58nM3Nl4YwHqVit68xddUPzuXx8pLnkSD/9EBAeSd5zPhucI5
 KjOeOBAiPVzD3e7z11t0OShAuoXc+Rdz4TIWOjc5GaHbLaVOrU6VezvQf1mhVT1wBZOY
 Ycm4BtfBwdgp4hk7wDYhvMGvn2wzjzCuD5GNXLsa/p3UWVXTwrA5Ft6A9XsyV7cne4lV
 7TE0KBvcMPWoz0EWgTkc/HL3y18zyPmBCmvJAaJ4k4igBA4QpcNlX7SpbC5VOUk9ok5K
 Y26R1ekbooaFguM8XCwMBcCfbCgdP0eEr3SJTJKsEcKGFsmSAWB+V92IBkVXrd3a+V1l
 ezDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167127; x=1754771927;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9DgCkyJdUocBDv5VuprGQYdy+MVXJQugkzXPchaw5jk=;
 b=cpcf0c16Jvw5CczhFl9RmlWg7D7+xHwlrFNlraxS6y7c8KxIdu7wW+q/OmDdYLugYT
 DsFX5yoWPnQ7uy9c70bdAr7yeaFR0MZx0kGPfiwlbNmg53zmASgnZPE3XJIMnlEiRLpq
 mR4YGTQsU9pi82CPd/WAlVY5T4RaBunn+0Cfj32gWkpSUBOm6fUjCThm8aC0a9z0+TF+
 CTunxEEZj46CUa52/arHhLPOC63Ma/6za2ijsdQZbWxuqlEw6iPUtjw9KiSXA2OGd6c9
 hEMXh6Fq1sHsKHofN6DPepXj2Vp74XonF5ohmt73rqTfRsKr5eG41J04XeVuZuYdki97
 C7xw==
X-Gm-Message-State: AOJu0YwVcGqbH0bNGBl/blyNjDwc+DGUcdJ/YgHupjcjjxVE3Y83DATA
 TBepZqQm4A6tivJGcZcfe/PxBt2CcNToYQL+c4lo8/we0VTaGVdLaB+ovHhvYKd+vOGyUTkPfai
 AYPpgwAPAEYT9vhrAyPUdA0MZ6RsjKv33RurtfEdF457xqCLXlobq
X-Gm-Gg: ASbGncu6Y3xmbh5TMKChPZ9RwDRDSJQUKPPVn97EarWFwCVKmyrFWIZPtiHA2x2n6mH
 VgVQCrOSo4n72pDiTjDbMbcV2V13AfvQ08+VU7byrpnSNZfVvGsu9EaD1Y+qWS/xn0pnPEqCBpH
 /Ff5juMTQD/B15Sq1w6v43JzfS3UkWn5vUbWDMKpIHkuwIBAeToQt61Yj5uAuBc7tRPeA68H08l
 PLP95Oq
X-Google-Smtp-Source: AGHT+IHsXeWIbO0dSD8Rq+Zpj1JHC/YzvHPuy6dmKqVbJSNMibc6KHHhyw2FxxUziOlm5BxCMBMchHK+RSl8y9i0pXw=
X-Received: by 2002:a05:690c:d94:b0:718:3b9f:f1f0 with SMTP id
 00721157ae682-71b7f7f5d12mr59213197b3.26.1754167127616; Sat, 02 Aug 2025
 13:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-83-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-83-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:38:36 +0100
X-Gm-Features: Ac12FXznHX58CtyCuq_c_MqYkxC1uGURtnfpFvcn7-aUEShmMG32ym3K9lpVetg
Message-ID: <CAFEAcA_8C2Hv3pJ0LreRM0swLE4nDDpMZziT6M+_486pfHHinw@mail.gmail.com>
Subject: Re: [PATCH 82/89] linux-user: Remove MAP_DENYWRITE from elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 30 Jul 2025 at 01:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The last use of this fallback was removed in bf858897b769.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 5 -----
>  1 file changed, 5 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

