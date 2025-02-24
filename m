Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9707CC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 13:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmY7U-0005yj-6f; Mon, 24 Feb 2025 08:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmY7T-0005yX-6m
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:03:35 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmY7R-0002mZ-IL
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 08:03:34 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6f7031ea11cso37444837b3.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 05:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740402212; x=1741007012; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/+ZdrpsFK/HAtm3Dc2KtifAwV0SVPDIBmAlaYqs4aDQ=;
 b=tTMbO+KtS05RYMn/Bc6wZPEFkvk7Gle+NvlfHmpZT0yKPcZcDYivMINu226hMpKw2K
 mletR1D5XgMN5RxWkOjVy57zKXxyqgQoKKsrKz/0KOUzFKmqIftz4ITrdnpZxbWpx4vH
 F+H3WkJXjNHzllItz7Kf6r7O/KKiULFOJDK7zlA5unhqNYDQ+qTiCqtjnRc89LRr0Oeu
 d2K2cA/b3YuBARq32Z8lcC7+dJEg5hOxRe+uSYS30eeMNLvsCB66okgmmCILYxaVH7H8
 AN11y4ix4vF5R5cQPjzsXylZ0mjKfoVVbORH2VCek0IHdb3eHoHYwtn5grLSq9+N+WQu
 G++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740402212; x=1741007012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/+ZdrpsFK/HAtm3Dc2KtifAwV0SVPDIBmAlaYqs4aDQ=;
 b=NtmxrgkOKY+KP3UgDwjWoRgQ6vtDH2dRaCTxx514pswGWspbwZqxSWAuLj0EOHD7v6
 4xbqInBqZrj3Xa06jzBPLCa87rfUGNlBp/C5jSZaPRp2H8Nmt0/SUrrghnMTlBJ4AIEC
 4NhVcX6mZaoz7kol7bUAwamftTOp51YDsEMZIqRF1AWgrhe6HYAJYIw8iTZH7wwjI2Rn
 LyoVdqhWl3LVC9F53VjFj89+mD9ZtdQCs5ckvgt7jZSjPX12X7KYzx5Br2Cg8dJHinC+
 mnQVjFpqGYVkmKx8kjUVgFUfyVwktp/LLW9UfHTcVssahFqlIMZjTaQ74afhJFX/QO7V
 FW+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvMF+F3kmWp2glltd+yIbhK/zAukbYhyUgcyT28yRBvUCmx2ztp5R/QmiptoHJMYrfX8KsuD3LZpj3@nongnu.org
X-Gm-Message-State: AOJu0YzxQDWl480ZHwVYEHjZ807KYsZQCn7oqlqXLM38IEhNFjeQd/oi
 LkbZ0mLQBQlzm7DwL7XO3dqsRpEXAphyJ7gk9Ds/mJkUg5PA8wGpesR6qsTxut8y1kcqGalqo1Y
 v0zlE0NwGg2UGCGqKz6g6Jij/Xfx3PmH0W0prIg==
X-Gm-Gg: ASbGncsz47YeCrr91lO8wkYW9leLsOBnnBkqgAWROSZcvI9iiJYoHRY7P1LvfRsjhyr
 aQJMuNuZwA9w1peP5A2gELXMY+xJEoq8A28QUg3o7w7FGAXlCJCrwo9zJD6Zj5+ltsn2pwqLHVd
 Y+/HHjGu09
X-Google-Smtp-Source: AGHT+IGCHI/SyZsDvRO4hKuN/QBDiLl7lzSsI6rpMxQ8/KKtpKN5mmb5if6yZAHUKyhz5uhNZcMMx0smCZ+eCYd9Z3M=
X-Received: by 2002:a05:690c:6412:b0:6f9:b12b:8943 with SMTP id
 00721157ae682-6fbcc261b67mr122343087b3.19.1740402211085; Mon, 24 Feb 2025
 05:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20250220213832.80289-1-nicolinc@nvidia.com>
In-Reply-To: <20250220213832.80289-1-nicolinc@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Feb 2025 13:03:19 +0000
X-Gm-Features: AWEUYZm8lPJ2jrzALpypVuBJOIzZpsxNgfbF3HRsP2ZDKDW9lTsWKSJVT2Gl8zA
Message-ID: <CAFEAcA_qXpVkwps6ocR7CceYBvxWqv40QDwhRAfFECPQGwFbQw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/smmuv3: Fill u.f_cd_fetch.addr for
 SMMU_EVT_F_CD_FETCH
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Thu, 20 Feb 2025 at 21:39, Nicolin Chen <nicolinc@nvidia.com> wrote:
>
> This is more like a cosmetics fix since the f_cd_fetch and f_ste_fetch are
> basically the same field since they are in the exact same union with exact
> same type.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>



Applied to target-arm.next, thanks.

-- PMM

