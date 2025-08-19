Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D9ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoMuW-0007ei-1g; Tue, 19 Aug 2025 10:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoMuT-0007e6-SI
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:01:57 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoMuS-0008Kx-DB
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:01:57 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e934c8f9751so2462322276.2
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755612113; x=1756216913; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OH1DlBWHp7eUWXxpE53r66lIpq1bNIsM74ty/7lwss4=;
 b=xc1A/bHO9eieb/fooXKjroZRMYdKes/CySqpos9k+nKnXP2eZqRgKfjXb+Fjyf2kOQ
 aDwqwI1IWFjICNs/uEPh3U+akEvNelEnPQ8Md+1vR4ZH31smHl4VzjN6rwDIPL9Lvz12
 aRNIDr/W+bz+4kVmiLSOpTwfVc826KxyTIYUIR3NSXQwQNOS+njiHBiqbwUiJbA34GEu
 hi+ayNYMduIvzT6iyBjFpMIBRE0cKKB2xfkQxPiXd8pdTnFWNp6W54b2kROb1d48l1+r
 Vtt3vFONCH44oevZ3n5KCt0uayYMtBrZxf88FNoopA46mluFg84BKvvjRY2QQ4fqQ8HF
 0ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755612113; x=1756216913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OH1DlBWHp7eUWXxpE53r66lIpq1bNIsM74ty/7lwss4=;
 b=EBMFMUingVHtn3u/Vm2eL9zqeW/rrZbuC1bZiVzVTsh/7aIdpIK/VyW9NkkrdNulml
 QdfIaxfRAOVnxm9CBYAYoMrSjCFGxkL1qbpMJ9E8WiJyX2d8m7oLUKAgdxrbQIMthhnS
 vkAmDVdui9brswTyzoSRpxO/6VvNuQZYVVbe2v/0rJPQOc1f+NQ7FHaEPvIr4XfKsIBn
 VIpTegnA2WlUbg1y6pKDDwwuCOoh0xVqAt2pw0bMAoq5WRTGm2jEz6fJMXTgBOuDimgl
 FkuBb9J2a2IUWg5/ZchJOhO1cR6+ycvImsvIp6ZlmDSPM84q75+B146uFpMIg/S+hAam
 A+ow==
X-Gm-Message-State: AOJu0Yy8l6XaEN0Wwh/+SMAkRZ3cerXzY/Sac9B5ZJQ3Ywa5QrPgo/zP
 ehLj7S9mnV2cHuxd9psqYGUi7wYx2ZHmtkVASvZy7W7rb4rjYSp+IoOjvfzo9HGh7wyzVZ04uCh
 I/y6exOtMHPy7MPUkhkvGo5+6Tlbh/qXzpqMOwjfA6w==
X-Gm-Gg: ASbGncsX9RVJFmXMHJYkrC7LpA3OH7QaPDKkTgLUhVaezlHYHWD9gs1UYDCJYgmgdPv
 xhbCquZyXuuBh2tBYVahExYBKgza5U9Mgp3KPPbsQUBfb8IhREamdjaBy1XX/z4J9FCTpxFQVLY
 gaU8U1yJZPzn1q8Gaj0wR0ooLiDFu6iKpRB8TcOFMb1/6QqMrxVGs8m9p3AFlZXWB50+Kkuos/M
 j7igu7x
X-Google-Smtp-Source: AGHT+IF5OFm1JtU2qgiWPHV/Huih9luJSbZS3kvCapCi2Tk7GFg/+ruD4guuXDQDnGPV6Bd2vFPGX/JAjulDNNvqgvc=
X-Received: by 2002:a05:6902:3411:b0:e93:3d61:d5c with SMTP id
 3f1490d57ef6-e94e62962eamr3279533276.24.1755612112017; Tue, 19 Aug 2025
 07:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250815122653.701782-1-richard.henderson@linaro.org>
 <20250815122653.701782-2-richard.henderson@linaro.org>
In-Reply-To: <20250815122653.701782-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 15:01:40 +0100
X-Gm-Features: Ac12FXyN6s5xSD7DjNK6HxeRrjgS3roOhQcEmMNwkvj5b_gjS9VJQxQP5qzVEwA
Message-ID: <CAFEAcA9zAWsx-w7LxSu7gdp36KwV1Y-tVCug0ZS5Pd_3sdzFBA@mail.gmail.com>
Subject: Re: [PATCH 1/7] qemu/atomic: Finish renaming atomic128-cas.h headers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Fri, 15 Aug 2025 at 13:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The aarch64 header was not renamed with the others, meaning it
> was skipped in favor of the generic version.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 15606965400b ("qemu/atomic: Rename atomic128-cas.h headers using .h.inc suffix")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  .../include/aarch64/host/{atomic128-cas.h => atomic128-cas.h.inc} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename host/include/aarch64/host/{atomic128-cas.h => atomic128-cas.h.inc} (100%)
>
> diff --git a/host/include/aarch64/host/atomic128-cas.h b/host/include/aarch64/host/atomic128-cas.h.inc
> similarity index 100%
> rename from host/include/aarch64/host/atomic128-cas.h
> rename to host/include/aarch64/host/atomic128-cas.h.inc
> --
> 2.43.0

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

