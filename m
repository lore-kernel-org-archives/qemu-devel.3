Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5F3C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 16:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjcg-0002r8-Hd; Mon, 23 Jun 2025 12:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTjcb-0002k0-8M
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:02:15 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTjcZ-000053-SY
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 12:02:13 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e81877c1ed6so3492926276.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750694530; x=1751299330; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4XETAhPurFJrUermtDdX6SBvcT3qubfx3v+iXpq3KCI=;
 b=auJbsAF0N6cfE4K2hfvDVVGP32vpu/DJijHrn9PX9hST2eTKlN0qsYah+Hez9v8fpm
 FA8+O7u2hBcY9bHktq1Ta5R4OjbIxryEdQNyGEK3R1bACKxPdug957qlbWvH+n9e4rjO
 yqg3Ex9OEfxdH1JTxJgYDMG0Va0MgTE4YS0bpn7+s7VSRtg78XIf34T5XG3/1NfB+0DV
 GiSRZOL0dQ3pAlRuNJXcPm7NH/XztW5o1MN/ltsVQw1PDHypNuZn47KOgXV12QIIAoIz
 CJI9wQWoLN395N5p2a84xIDargY6ylrVKO9euf09uVInQf7AIx9jCG8PPy/AtZcdpvWo
 P/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750694530; x=1751299330;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4XETAhPurFJrUermtDdX6SBvcT3qubfx3v+iXpq3KCI=;
 b=fdi7Ij40rJEA6mGiOoPeM9U+uifFeACZh5JPACTpyvn4+DXq+nj8PdcsO4eQY60DdP
 6ucfngSQ0c5TTBZ+oXB58jIf92tFtBRCabZSGqhY3gi0ee88AkR0w7eujvzDyy5CzYmk
 9nzB0lRwh7qszv3BYRLKeTIyLvwPJkpoPlpCSXcWxONzLjOFf9wjRjppkqEw8SJ3/TSW
 D5VJMHLcUMvbTVubB9dd0EegHfQTcJMnf1lbUOin4XNMj/S0Gw/kwhOqEM3MAEjASP/Q
 cFfBfv7ReIfnRhqm1jWtZA8ilxYENRlJE/koMdcF2zr4JaqHfudaj2vKQWWEr+iV4NlO
 X2Pw==
X-Gm-Message-State: AOJu0YywDkCpmlvSx4h2EeW+tq4xRtxpDB6DGi+v2tNpyLya5tCYjxVO
 dd9DyVUr5Ux01jpTE7p1wNZnyTfSVAqP1f4iSGbRlNzgJYuk/2B2+Gjkl/oMelp25lTULEx5Cmd
 NkEnDqIZ5z1cXiuNuIo8tYm2GegL7IUm2j4VkCt0Y8w==
X-Gm-Gg: ASbGnctFTDtqMHJq20Buf+PRXSmG5m9zsPviN5t1WA53dxZ0oho2l0QhtUhDvvAnA36
 Utok4ZN930AMK3q/T6u2Cf2/mQBpZ91KGwO5foEQwPTSVxMEM9LWbuLPEnfo1w6mvZ1MG+FMZK+
 CX/UF1F4SEEDlYJrQ9xVkld78IJxTsDarjjtoKs5NW+cG/L0zN8wodZQk=
X-Google-Smtp-Source: AGHT+IG1pCGzfnJFxo5pXpE2JoS5ZlG0IyNeVw8c8i/1v38ujMhw9LxCLsmifQfjl8HeB5D8IDdIDOTk3aOJgc/GPH0=
X-Received: by 2002:a05:690c:7105:b0:712:c5f7:1eed with SMTP id
 00721157ae682-713f67f4efcmr707337b3.16.1750694530327; Mon, 23 Jun 2025
 09:02:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-31-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 17:01:58 +0100
X-Gm-Features: AX0GCFsBdpPU0oepvJQE8xhrNyqGIjx-egWx1YfFIM_QJo7qXKS6_CGyqaIhkG4
Message-ID: <CAFEAcA-oRL5YEdFOaymksYnOFdCX2eOjwrsDWdQHOEhVr_+0gQ@mail.gmail.com>
Subject: Re: [PATCH v2 030/101] target/arm: Implement SME2 Multiple Vectors
 SVE Destructive
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Sun, 22 Jun 2025 at 00:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sme.c | 65 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/sme.decode      | 36 +++++++++++++++++++
>  2 files changed, 101 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

