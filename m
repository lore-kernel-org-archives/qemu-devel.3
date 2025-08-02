Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6F8C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIvK-0000de-Ok; Sat, 02 Aug 2025 16:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiItz-0007bs-1m
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:32:24 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiItx-0004cR-NU
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:32:22 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e8fd07da660so1548123276.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166740; x=1754771540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0fW/vt4cR7atq4YZS/t1uMqezuvJuu+MLlIKZHZBV04=;
 b=O8Htxox03RhzmN6nIN9Ke85a+x1gTxP90FlbOAA76e09pLbVqAPKo9xsLM00S6tGZf
 LrsaU9ndwOiJYa7LOwK5YQtghQuy5EaVf3u15RVSUWgGyYpSvqLJku6JbwuigiXKwhWT
 vYe7lEvXGjWGj/mscTkFRhL1z6xdc3RzwkZ/WBjG6W2bYFSo8dibIi0rOS214AQeM0ZF
 EbW8SmsBdR6qb40gXyJu+JsZ6odZe9PHiiI0bz3LG3Mzsv029CEIe3S18kzcHBDX+evQ
 /FaEvdjI3a8RifXuKPH/2hSS+wyZKmLCY3hGAZjlIwg/hXNsuiTs4ddfTvaIz4j4PUM3
 KcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166740; x=1754771540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0fW/vt4cR7atq4YZS/t1uMqezuvJuu+MLlIKZHZBV04=;
 b=POqSwH/i49VZqiT6cbp434FhmfVHe5Zyo/m6lOuKF/z/ObcZT/2K7O84/9Zoj0x/0E
 tMC4NPEyMWk2FwtezPJpG4fAykqHeG3iqW6ga/yg/zWCiIsHqobQDj1RwRhiFmGVbvSY
 Wn55nyOHyiWHUEPUWNwFeT2EObjynEPQ/LNdPQLsTSq6Dv1959kBX9Lx3CngNeVFrzAJ
 /uGWOcHBWqhX2K6V0PMH8pFvKL5VylETxPm+guMyjrw6a3FGntmA8yuOaeosYb+Rvg3k
 qhDDGq2/stUnOmkdMiQ3xT2UKcAhAx6+gb5VTxwx5DuHaAf1/lPcDo06f2BkHhcDkTXk
 I56A==
X-Gm-Message-State: AOJu0Yxm29sBqGyT/kC7rlUeUCxkr2K1W36F+n1LR02imxCh2vZYKq4g
 sxSazMS/Ae1rdofwFga6BE41n43lNUxwA0cAwL8tlpWOyvnc3bqASlv+G9V3pbKHfizWeJ25jmA
 lIy94TTxT01xaGhw7AJZvRIOu060QLI0oqUShF7ukaw==
X-Gm-Gg: ASbGncs9GQ5/8ASjatchKKnPKRodYCHNW1+a+gTyaI23ksGktAOWXuUkUQrLPFTT33B
 FeL38Itf2h5vliQ+rgxijkRvsP0CPC0utSQgvQ2/gQy84XiB/YraynQErF66m0V3Zyh4iuexXkg
 br+4jTeWkPnbUuKWqAc0JCNs6b4idi+GycbF2A/uB3ISihhU1uE2hJ6leZDwq07PQIOHrFW2dbE
 s8NXtIV4MDM18b1MMc=
X-Google-Smtp-Source: AGHT+IERJ9ZS/IthU8U2JhOOFfnUgjlHb2GRTDxt65OqiXR18oGvHwX7DCLbDACdDCS64Sp31GAM4n1MJvnhIGaaGME=
X-Received: by 2002:a05:690c:d96:b0:710:f55f:7922 with SMTP id
 00721157ae682-71b7ef89dd6mr58370487b3.34.1754166740595; Sat, 02 Aug 2025
 13:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-79-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-79-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:32:09 +0100
X-Gm-Features: Ac12FXwfgJyG-kzjCKg1baMnuic3L73_BVikIrfyOVcjt-J6hSubVwoRGOyZ6o0
Message-ID: <CAFEAcA_LiXb2=4AGso+CqBJbEbGPTa90dgkpqj1JkG8A2UV+2Q@mail.gmail.com>
Subject: Re: [PATCH 78/89] linux-user: Move elf parameters to
 hexagon/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Wed, 30 Jul 2025 at 01:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/hexagon/target_elf.h | 3 +++
>  linux-user/elfload.c            | 7 -------
>  2 files changed, 3 insertions(+), 7 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

