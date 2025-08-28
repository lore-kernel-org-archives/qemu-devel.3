Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE4FCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgEK-0007C2-1a; Thu, 28 Aug 2025 13:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdSm-0000Xk-1k
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:18:53 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdSk-0005nz-3f
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:18:51 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71fab75fc97so6908637b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390728; x=1756995528; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vrIUWYCNu4ustt0GFffiQA0QhrmCDjpcEBzTyJJY++I=;
 b=IR6CxUqT/Zs/QsB0sCtgRkcqIvieWhR8W2ZNkmhpb4FSepfWwRBYHsnLHt7h/z+wOn
 GPaEMNQeoItArMwx9NW1bkxM0km7tlYfag6xeI02aqiWEgglMBxjGJxuSW6oeENSJxy/
 /SkNTerUnp1XHyreUtBdAi7izIc6KYX7nX9r5JdOIsi0MHdJkkpPrA/K4VgCZGJdIDxL
 d029bxM0E5fnf2qe+wLupCDQVMaHz0dXeZvWLWHVy22hLVK2cSDbmi1Gd1UQCh5NF7b0
 WY5+hAWNwwEESynZO3EWWTwXUeXKFBXT0SXYAA9T/YvKLxu8K8Rj8i/8KM/DwCy8zlzL
 +eeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390728; x=1756995528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vrIUWYCNu4ustt0GFffiQA0QhrmCDjpcEBzTyJJY++I=;
 b=OThrSzOu1mMrUlFbMTKCO7E055UNqo7h3402iEXDypu/gtt2RtRG/Om4UUY17klznu
 V0vZtS7voY5bNrA/ADKr4KQSnUjCOvxm1BjIYuEU1pHlDD6Ja7ycKS2WKEGBFohC4fgF
 S9It3aQjmEN/ffMNBQtUmQUitjKbsVQ9Zo7Jmb7tBSLOjlVbqAq75FQQX5uOf7W/7fVz
 glaVRVOrRU+bFXYkjIUM8QuRFc8QjM6xwN3Pfg1iAgpn3WCw7qzxnIKKU2OJbYWFD4Py
 H+zXVVPDpP6qpiVm3qpPwiHAXvaL/2YhwIU/+Ur24li0vVdumaqxEPfPlAiNL1ZlLgyz
 rWdg==
X-Gm-Message-State: AOJu0Yz1OIMVB34YQzpBkdt+t6OpwWk1BcJjmH2s+PzUF5//keb5ZaxR
 jub011mIW63EA3WToEBb5vynIHLpNrZ65U1x4FpqhLohIA/zYAy0OGVs20AoXCA4Tk4KF9f98F3
 MxbxN675uXryPxlQM1NFq2GpcQBrcKO0JU0BqhZYu/A==
X-Gm-Gg: ASbGnctIIzDSZ/NOhxwq8hKGL42C3Px+hT0QxY93ApWjcNgdo7kJt01KGpbTmo/EXZR
 MNP3wH2FNH5lHyreQCdSxf1qJ0gsnGuBavvvcuGgsEpj3xu7DugzVF6nFDQTquK8FbrS6cn6wKB
 AlUoIkXQbAfTKHNb6gPa1RM8c/jbyfT2HSTZqPQnkxut//NKtmbTDdvolzajzAXM53ybX2eTOJh
 rCrfjKw
X-Google-Smtp-Source: AGHT+IE1QuCWC586WQwywuvm5zZ9XatiHgZRFPHhb1mOrbRwe1iQzAptv/z80+zj9rPZTpk+VTGYd8bSaE22kQe/GJE=
X-Received: by 2002:a05:690c:2502:b0:721:6b2e:a095 with SMTP id
 00721157ae682-7216b2ea517mr9040137b3.49.1756390727948; Thu, 28 Aug 2025
 07:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-6-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:18:35 +0100
X-Gm-Features: Ac12FXwnn2cHMUp3Ewxx2enESbXouu3BZyVbqv_A-kYk4xIXWrVcbttFA-OKfhA
Message-ID: <CAFEAcA-iCPY-Udp6iM=JnLw7DXvGb32pdou4Cmvwgsd8sQnzZQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/87] linux-user/ppc: Convert target_elf_gregset_t to
 a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 28 Aug 2025 at 13:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

