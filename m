Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57F2C5CFC1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtjqX-0003bk-P7; Tue, 11 Aug 2026 06:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjqV-0003Wv-HZ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:36:35 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtjqU-0006Yl-0Q
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 06:36:35 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-81ed073fed0so38734647b3.0
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 03:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786444593; cv=none;
 d=google.com; s=arc-20260327;
 b=N9f0X+z+e7cbf7wtNO4Ne5LyZ6hhJ4lwnHq6YhxWP+3EwJ0Z8Y4cs645O7bc86dc9s
 GdOH1JplbQ9pd6LBINbxkzafMYQh8RCRHsv5YJ2b9TVLgKNntIpVRDw6+JPioWxogNZu
 XrlZgJ4Fte0JK+qxbMCWK1HMKrPUHYVMbnWe9/SzrEldLtZwMhqYEfvwuveKmwL/DsEL
 vzqq4zoINJc+3fXGTJ+nDZiYA7xFDE7AKI774+SdXP7aqza5lALRHaq38foMJW4RsYqH
 QlqB5YYwtyCN2kdK5u/dS7ZpCMe49SW4mywt6lhM/tABdYQJoXlmt3R+VgYm9rGsok1j
 2kDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Gm0XULbSxQTlWawHD7XwU7KoRE003Cuaudv2NO9XgsI=;
 fh=xKLZUZonxIa2TERcMHkeRYNEB+oXwA3LeXHf94o6WLY=;
 b=oHJ1Z3iPVBK6NlSuMp6McYwPsAPbTuGJ9IDsTBiNQ6q0jS3sEgKRLvruwGjAmz5lPj
 /qLK2OlepBlWkFCbh0n6YfkwgY8bGPVXXTqGrzEuDo/A+ekVFRPU/1hBIBVWBgSm7s1u
 r7FLDKvefHGxOXjGvkjGDDa1KPdf6iXlPoE1xIfo5DQEnCi7SA6qGbGU3U01QmeLvE4l
 zxDJCLU14jZE5zyNB9l+Z4eYw51PMjyd1R+3wTuqqtEjWY/8nj7Dj2NkgSRltYJ5uVoq
 fW2bmhsVGlsJ/mRtab+/3wr24qiSDbAVZ6N8/onMogntWBniLvpVGZVIaRMBgIMY0tRT
 H3+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786444593; x=1787049393; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gm0XULbSxQTlWawHD7XwU7KoRE003Cuaudv2NO9XgsI=;
 b=byN+K+nr0hdJVroGxpJYPgWGFxS965FGUtkt+czWmgIWvEUHjQYTGTN7Wg3lN8ICJ/
 jzi3uY8QEq2crHR2RwiYCh+FFzduaw7J3qDrf2PjzvCVlV49hHfuTVjz+v/SPi5v5cpk
 v9q8ofJCV2CwSjjIthTdv1jQp/pIyU/q2AyTQQjnbdO1aKajnhDM97P0sm/Tk5vkehQP
 hvpGaEvbsNzTqFf5eo+u4WLtVGm3MqE4T+djp0UZJVZDUktlpNeeivrQbW0nFlgr1HBJ
 GJivMhHLgauinHJoqmRGTra5cq+0yB5b0jZeisvcYQF2Ld+0kmbzPcge7cjGg4aiHGdM
 wjpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786444593; x=1787049393;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Gm0XULbSxQTlWawHD7XwU7KoRE003Cuaudv2NO9XgsI=;
 b=h/rj5c/9pCRbwOmh8GiM8EDL2p2Oi3Xh4Hj3PrYGHXRxcm/MvjZIskkhSyJMDVSg6K
 fHirqeCKkpPUNZQfLE3SoVmwDxVUfn+P2mFwW/jNX6l1xJyrnRNz2Fbhaitw3sCKXLGX
 3Kl4JShIB+Uwjv3ankSTVF/V00SvcL5aA0D54SIpWLxVlSa08roscPhWyq4wY9MJY9tA
 9/Iay4//sfPS/ylHHX+Q2VENe40DBPslDvULgHyrDTrwdJ+M54iVV3pOZ62EvMRkDFyv
 5G4bY6wQwIjJkHWiyGGNKZ1uuTsDa7PbFt2OZTaJt8OzAuw/Ovyk2WFJjP/AYabnJN8s
 zjew==
X-Gm-Message-State: AOJu0YzUrBHvaXJrKt3T9/u97y410DV1McIWF8a9JXcZxSxbBeZpzMAk
 NJbFgntr1K5j6LUfwJhJAu0LsX2uEFTpJwv5Q2Q/eoUcJWA9+NLZejdMjOZG90DpBBxw4j2Zlu2
 lVXzmaBljR08gRYtPXdqbyDXhxQLtGkS6/LGNhurfgC0ZVC2BFvGY
X-Gm-Gg: AR+sD12wW+lul+IMzO5FsdYXbQdnL+uodVOqDa9nqblZMV+LF+hOQ2AtB7kuciCm0JN
 4xo/a4d6+Mni0dziIR7NhRQoryfI5rlgxJ+x3TqduzrhQ0To6Y4uZcRbv35jlyf68kpUTlp+F9x
 9cdi1whqDi98usPxcQe4ePJQ1LwBLFq0dI6M9LkNwUJEC8TgSFnkCYokfyFG0sQYu7gwg7oa8fb
 7gwYkcyzA+XDac02hXGqeA/EGOXrh2qTdLtnlhwZgMLfHWCMGLBJMwmd9JZ2gATEb5NNiRJcClf
 vOCHZlI/YxPnCC+us+tk09eu3JgAzX5HDgkLcH/KxdCWKxk1aQCAOftOSrd9KF335PcnzUNChW/
 i+YPR32rDWNejcjHuKQqBKQXTRSFO
X-Received: by 2002:a05:690c:3692:b0:814:585f:73c8 with SMTP id
 00721157ae682-82f20de3471mr16100137b3.0.1786444592678; Tue, 11 Aug 2026
 03:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260804144611.31735-1-huang.botsz@gmail.com>
In-Reply-To: <20260804144611.31735-1-huang.botsz@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2026 11:36:21 +0100
X-Gm-Features: AUfX_mwsoVjRpZBKE9oGqAf9A2BOIEBhCFVSjW3BDXJOKIdmJfEtFjQzUiPv9_c
Message-ID: <CAFEAcA_Kmqp60+Edu1kKCH8=GbK6RH4ebgTaUjBPB_L=QZtPFg@mail.gmail.com>
Subject: Re: [PATCH] hw/i2c/bcm2835_i2c: Correct iomem size
To: botszhuang <huang.botsz@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@mailo.com, qemu-arm@nongnu.org, 
 sef1548@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 4 Aug 2026 at 15:46, botszhuang <huang.botsz@gmail.com> wrote:
>
> The last valid register is the Clock Stretch Timeout (CLKT) at
> offset 0x1c. Since it is a 32-bit register, the total memory
> region size should be 0x1c + 4 = 0x20.
>
> Update the size parameter in memory_region_init_io() from 0x24
> to 0x20 to accurately reflect the hardware specification.
>
> Signed-off-by: botszhuang <huang.botsz@gmail.com>



Applied to target-arm.next ready for when we reopen development
for 11.2; thanks.

-- PMM

