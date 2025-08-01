Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4585C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv6S-0002mR-1x; Fri, 01 Aug 2025 15:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtYn-0005S4-D7
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:28:49 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtYl-0003l0-QX
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:28:49 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-718389fb988so24567747b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069326; x=1754674126; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jYL50F8Qj6gCv5iTDe+gUEKu9G/Yn+Gq/6KTF0VE1zQ=;
 b=B905NoGSPoO3hSpu2e3gHhBo4h9m17uGOAoJE/wl3ZwJLPxrL69beLTKv+Vob1RuQA
 GStv52fq8/lfCcNWiHolrrP8Sin3E2BuzM4/7x/+qeUbFFZgQemajv+yJ7o3B+CZBCNS
 O/NXp7XMx1QCVZKRT7EXTevoxA51I/hDy81Ls+I0R2kn/jPhWXDzqibPK2GCu4dNeP+z
 nswgwmBh+nGSEyTHMobsm5k8VSLdMxquHlKXalAVVo/lhxf14GEK04h08L/gXLDHsaaR
 chAe8y2elJh7IGLahSl8RiYaPGNz1qXXuyJpQaKGsnmsO5wBBPG8JmwSV7ATQNZl+e21
 v2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069327; x=1754674127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jYL50F8Qj6gCv5iTDe+gUEKu9G/Yn+Gq/6KTF0VE1zQ=;
 b=Duj9EZKmDHO/6Z6kbNeK+TluMf1ksaf1AYRF98N7rvqBmjUeCu/7Ea0pAVy7CNKlvU
 35h5kxermEwNAGV+P3iTHokQLEo8Xi+NaXY3XdWr9jhBdGQPm9xusHcecBOjEOgHzpMq
 vY5CJdCn+f8sdc8zO9lI6TyFjcEMYzpPEyOuJJIO/R4tu9a3ft0/r9WgqQbx5ryrdi1r
 J+zOuz/5zTcwpH3Rla0jlj+pIF6bS2PWbS/ozLSBQ0EPUBy8Z5J0Iynv0e93KsMgC2rg
 4EtHzSlZaOwetRREkBLogkYULh5rNpgqKtDU4ZVcKLWLxSLS+Cg0OE0wovz+8gWs/rYu
 rbAA==
X-Gm-Message-State: AOJu0YwNEckBU8HV+tH3xnNKHYQOFX4X5oErZSMTeO9IcvcJh76vlDis
 ZHeHRqE5jfclFjO+vnaC16VZ18JtI8vr6Ahh46Om6izbz5OXbW73C+sLAa1qFjChoqJzYynUOhK
 guDL+nWVOHnYSW0pTvwqG4LtSnaKm21y4tJ7arUianA==
X-Gm-Gg: ASbGncusu0lmGjPDX0Ev/sBxkUDAdtGFg6EGl/zt/4ASIBE6hgZ/xNc85wv55qxCC5w
 syJw7AYn/VPGWH4UXMEUYQaz0TfYF2wRDbUr0xVfxkTVh5BQgsFNblAd5IZmUZ6NvijFljkqsH3
 rHMSRl4vu9SOqincqTV21Xt3m8LH5sWb8Q/JU09vWMBh5Or1GGgLOaKpu5biJ5yQARE15/mpWeh
 gc7l5cM
X-Google-Smtp-Source: AGHT+IF+LYFVnrvUVAeW8DfiktD2Iyo4VnzzcQCJlOC2Z9nCTkznL8IQgM17h10cgUG8ovrxwB4HhtUvB7j1QXdI87o=
X-Received: by 2002:a05:690c:91:b0:719:fa9e:b4e9 with SMTP id
 00721157ae682-71b7ed16cb4mr6744857b3.4.1754069326641; Fri, 01 Aug 2025
 10:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-31-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:28:35 +0100
X-Gm-Features: Ac12FXyVZD_o7T2i9wjYhG-QSLZ385nYjmfIVPKz0virSlvz3PHlJNk1s8zmtSw
Message-ID: <CAFEAcA_BeutgFgOWTbRviUmj5fNAOK1Cau47RjPcrbxi98hOYg@mail.gmail.com>
Subject: Re: [PATCH 30/89] linux-user/microblaze: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c             |  8 +------
>  linux-user/microblaze/cpu_loop.c | 39 ++++----------------------------
>  2 files changed, 6 insertions(+), 41 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

