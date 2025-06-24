Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5353AC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0VP-0001pv-9l; Tue, 24 Jun 2025 06:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU0VK-0001nT-NB
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:03:52 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU0VF-0004pH-NQ
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:03:50 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e819ebc3144so217194276.0
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750759423; x=1751364223; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BvenYMiVoSW37nxNeMOPEhbhTsmFtOEHLh3i4Cjl6aY=;
 b=rY+TJIgxJqO70uFC+oSXyaCC3wZ82XYYwUM8rHZKpG9MZeSJnu3w2RoFiiu9dt/Xgg
 pzNXXXxJK1Hd6EvVQ2HX8ZYIv5+KrV7WwY4Xv94TlyZDOUP8xJFM7p2JkK2p6VOk5LQ/
 LXrz56d+uWQMCylSBR3kukgJbfb7N/sLfkILrRGbmOMHcZ4USEGasAjEG9v82IApVbbU
 xX3FeEt0AR7NB4kyhW/NnmENHE5V1hzE5GpxmWov1g7P2vBFQTNovVahqZazMW6sLzyt
 zQk08RJLYcPnuHkcRhLp1H1kfarUxaLA2fKshqIUmvdYNZoM5fpPuCrJSoJeuOLceZFm
 Dfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750759423; x=1751364223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvenYMiVoSW37nxNeMOPEhbhTsmFtOEHLh3i4Cjl6aY=;
 b=rRwr4JRlQYI6YVGri1pWzqpHJHeewBYsmZWVe7kWHl63FNGeHmru9fYGoO3l2Tyn79
 c+ResNjc/G/lZ5Nrg3rEhTJjz22dIsTjywI9niX0cfqFd/tvYZE3Kmpu9QNj1xBSsUcM
 kRJ67GTisRVIuEuDfco5iA6ffDTuogzZdAUYMx/q1PdBPrfvLE2NHFl9hwJ23yqww88g
 HB3W0QYxNo2j1V5jY0hDKBmNBYwx3yJ1oZm+Qj93sg31EhMn2x9WRL+HJmQoPVyk7hFj
 JsQ2DDjVw7AUYmU4JP6qPq0BNgz+8SBL/SxE/UZkYkitsseD3xedDvre0+I/nE+VVaZk
 84WA==
X-Gm-Message-State: AOJu0Yxm+sgvKU50ktoRlKmP/95ZaFjW09sbHGct6XzGRkhQGAZ9XE5G
 nzqR23Ss4vF+QYDoJRH2znE9lBgZ96jAx7/2Fkjau7WWPSHZWFrdpP2MACvoq6rGy4/Shcmgmm6
 MpHCM7YW3gb4OWuYro011icg3uy0fKSBHIwloBVTCDBcNZOIroLx+
X-Gm-Gg: ASbGncuoBr2McLEwefY2txcO0r8a8/R5i7QQ7NYGCr9KT5CodOBHR6OM/ptqrZLoBpW
 Q3yEPbKkrPXGbjmdDk7Y9CoU2yktc62sazjOZWrgN1e08IRDmDl52vbAuUyM7RKnDClxjXrCxqF
 wK+XZRo1szs86vdynpPPTNQWcqxLZ+Ej2iBzim66S4zeK6
X-Google-Smtp-Source: AGHT+IEZYYHMe0zMYa275wickvcCLf7XS23x0DRmPF9mPoWibbVufRgd32joZjzj+bfssAyTl3lwwIIfDHzIvv3X/E8=
X-Received: by 2002:a05:690c:6203:b0:710:ebdb:83d3 with SMTP id
 00721157ae682-712c63b2629mr232024317b3.8.1750759423126; Tue, 24 Jun 2025
 03:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-42-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-42-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 11:03:31 +0100
X-Gm-Features: AX0GCFsv4tkdWLgGhH6LJ-X6fZHQwUljj9rYd1w7sX9TGlPkHv-jZi0HxRDZWK4
Message-ID: <CAFEAcA9y5nma0xZ1DpUQM4cZY6nCTpc49xy27UanVjfq5tmecg@mail.gmail.com>
Subject: Re: [PATCH v2 041/101] target/arm: Rename SVE SDOT and UDOT patterns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, 22 Jun 2025 at 00:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Emphasize the 4-way nature of these dot products.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 12 ++++++------
>  target/arm/tcg/sve.decode      | 12 ++++++------
>  2 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

