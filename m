Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AF9C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 11:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlQsF-0001UR-Tk; Fri, 21 Feb 2025 06:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlQsB-0001Tf-NE
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 06:07:11 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlQs8-0004vO-4Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 06:07:10 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso2267080276.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 03:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740136026; x=1740740826; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j0iuVL5uRNjEBhv19j5iFrLDzJIsMvGVoVmD/PbvVyM=;
 b=tnI4i+jqdHQAoSbQUDkmE27Fhp6Kqw/M8QFcxGrmO7DsnkCrbsljVuSGdrTROsLfat
 KcDtnOWQgy9UDW5cR1bJRmuyRp8f/ZxIDPqhDdrEOiPnAEr+5jiy5jlosFOwaxMffoF7
 7QOGQdPpQmI8Y/ENqaT5jZDJ+xDLRadbP/4g6oTCl1SAxWfwWzvV+3GHt00dOoe1kWOx
 c/ZHt8li4Avfyi/8Wz/rVQjk2LlbYzdtbZ4xe+I+MpE9zJFn0aMK+NU7QMVCoWNj+UFl
 KuwLmrXnE72fUn+m0dlEHYW7XFzS43mDraWDyrd1cdJG3hn0SQ7Bd9kTEmdxcbMhIkFT
 muUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740136026; x=1740740826;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j0iuVL5uRNjEBhv19j5iFrLDzJIsMvGVoVmD/PbvVyM=;
 b=RA/yynStef6JpY78pPnSneW9Y0WlM0XrvTh7A6ZeVdoX9aVNLkHyxUnpgGtJUu3Uoa
 vNOm8cPzR8bumYyyXsEIApp/H5GF88XKmZ8xsTCcygHxcOX5GT8NeNmiQ/8VrWhqN3XQ
 aXy/ymjPRpDsq6Xpi8UDq/5DZ+cmZZvYcM41MB8Mlk9ZypbCiIN0+eNMCI1og5FaPvyF
 hB8zE6VC1F9gnDggqBuDJuu75pZKJhBwj/smnDQi2jNCAAUnp0UxR/DTNfS7DgazIJeB
 Dh1xCOJkRrVLMFc5qT+FuzieXD7dS4ot9ExZYjxfDWvXavOgECbn7VbvXkvWokhoYuFK
 kh8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdzdGyRIrVXICzSMz69Mxn0mIilvGkAlFzIZ6NY/fHvXmllPD48i/peVY6rwY7Djuhniy9oz5zs/kd@nongnu.org
X-Gm-Message-State: AOJu0YwPV8UKUo/0pKIJBg97TKfCBqqQTGq72JRJaR23haRBwpiL5Or/
 Kx47MJns9hTKfkdDXKTqc0B30qaxMeen2bVHHXSnhD2GMbTAFfmU60wIgsgd2vCLaMxoOJuJuWC
 NgmZ72Ndgl8SRRV4JPEXRGLVIU7ifBloIT6jMiw==
X-Gm-Gg: ASbGnct43dh9LnZ8smctl3bIKvAbNg5CZDsiwmIiwiHo/Yb6hsEO0vhdmGaaYk9L6Ul
 Grk+JWdvWxx9PBmB2z3KiGHJ/ZQ/12h4dVkUDPvs7H86SAIZ4xsB4SZl8YeX/lfktMWL5jx8iOv
 NHS29T8S1B
X-Google-Smtp-Source: AGHT+IGkVfCQCiWgAijZabMDhvzMoHvNhaxzdOpdZB/iuv4LRgBX3V4rf+B1zkpNP9suF4jlznuqxVA1kClW2zqHygo=
X-Received: by 2002:a05:6902:2009:b0:e57:4226:8ae0 with SMTP id
 3f1490d57ef6-e5e245ea305mr2019479276.18.1740136026267; Fri, 21 Feb 2025
 03:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20250204125009.2281315-1-peter.maydell@linaro.org>
In-Reply-To: <20250204125009.2281315-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2025 11:06:54 +0000
X-Gm-Features: AWEUYZnaaduxKBn4Kxvc0587KaFp95ZqpGxb_reG_aFq8vhRnk7oix-28vY84hE
Message-ID: <CAFEAcA-y7hERhCAE0wyxR=HsCpmq_T3VQVGPW4B4GvwvrMMP0w@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] target/arm: Implement SEL2 physical and virtual
 timers
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ping? Patches 1-5 need review here.

thanks
-- PMM

On Tue, 4 Feb 2025 at 12:50, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> This patchset is a respin of Alex's patches, with some extra fixes
> for bugs I discovered along the way in our existing code (and
> a bit of refactoring to make the fixes straightforward). It is:
>
> Based-on: 20250130182309.717346-1-peter.maydell@linaro.org
> ("target/arm: Clean up some corner cases of sysreg traps")
>
> because it wants to use the renamed CP_ACCESS_* constants that
> that patchset introduced.
>
> The bugfixes are not super exciting as they mostly are oddball
> corner cases, but I've cc'd them to stable anyway. The actual
> implementation of the missing SEL2 timers also should go to stable.
>
> Alex Benn=C3=A9e (4):
>   target/arm: Implement SEL2 physical and virtual timers
>   target/arm: document the architectural names of our GTIMERs
>   hw/arm: enable secure EL2 timers for virt machine
>   hw/arm: enable secure EL2 timers for sbsa machine
>
> Peter Maydell (5):
>   target/arm: Apply correct timer offset when calculating deadlines
>   target/arm: Don't apply CNTVOFF_EL2 for EL2_VIRT timer
>   target/arm: Make CNTPS_* UNDEF from Secure EL1 when Secure EL2 is
>     enabled
>   target/arm: Always apply CNTVOFF_EL2 for CNTV_TVAL_EL02 accesses
>   target/arm: Refactor handling of timer offset for direct register
>     accesses
>
>  include/hw/arm/bsa.h       |   2 +
>  target/arm/cpu.h           |   2 +
>  target/arm/gtimer.h        |  14 +-
>  target/arm/internals.h     |   5 +-
>  hw/arm/sbsa-ref.c          |   2 +
>  hw/arm/virt.c              |   2 +
>  target/arm/cpu.c           |   4 +
>  target/arm/helper.c        | 324 ++++++++++++++++++++++++++++++-------
>  target/arm/tcg/op_helper.c |   8 +-
>  9 files changed, 296 insertions(+), 67 deletions(-)
>

