Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1EBCEF177
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syApn-0001SO-NE; Tue, 08 Oct 2024 10:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syApl-0001RS-MP
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:05:06 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syApk-0005kw-5v
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:05:05 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c88e45f467so1923137a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728396302; x=1729001102; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aetDmH2NilGTvMf839NYi3b2dnOTF5pYiBjtZB77M6M=;
 b=d0FSxDA+QFG8nsXHTJJS8qCdlfuxvHaDVbKXwzGQVtzJ1mXPQGDd515khPIu13SeRA
 Jqqfm/Wuoqi52GR7oKv8Bi+PoLJnn9mQeEXNRKaDx+h4xAQvC+CqAg+9lkuuAKwLmIpR
 dv6cQ3MLb19cVbr/zz0KdzPjlyG+pJCdRurOCiYYtUdbzVfqw2I2Kxo/ngqiOj6DAdU5
 CUlXh1heUpHHsblzOYS9+PA5cbQf8VCApdYoZrWbtlHtUjnYeCR65cwRUyC0KRsxsx6z
 as4c0viKOn6LYJqTQnGgFfXapvuKjQjxfHSN5i4Kg1E5aLuK/59yntoWlRJ9b6/RD1qc
 aLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728396302; x=1729001102;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aetDmH2NilGTvMf839NYi3b2dnOTF5pYiBjtZB77M6M=;
 b=IgFRs9gfzdHcOhqRkIqcJdWVUqMN8ti1PLX+YxtoM4od3A8n6nv0nlh2344pKk5iPU
 5ljekEQC1uvZIX7tj0edXwkWN5UPKDkq4VMX8YFYKDf1jKqH0K5dWBtrLl2s0InlPZwv
 AHvKt70opvMzm3M+qxxWof18/6JwpurQPE5Cpx3B8U2biZVTOBylBuFd9lCvGbhJuAoF
 GIGPHoaq+pTNFuwpM/n3v6sGkDsnYRfEFX2PpkOfF/zN7AvuLzdEmnRbeDXY9m9bfmz7
 O38Kmss5sM57fCQAd8328r+PdwLX4HgtCS9kYBxhvBeLqqaRJhmTGz4Sa9BYnjRyPdPi
 2/QA==
X-Gm-Message-State: AOJu0Yxg+MrpQlE6x5LlGAPD6fGgjrl2lvj/HehQ6sVz6N3hEDiypq87
 g+VsbGMq0/8ymS4JcWXyqIA8ovjcMPA6Foha99PEWjDfo2TX1D/YmiGv+UxbM4Z2VftyoKqgaoz
 rGQlAuDGsALsTeuAPUJAf+cbviO6yMkknTlbJ2w==
X-Google-Smtp-Source: AGHT+IF6H3Lvl6/NmA82bxuWyc/gR8SMikRNZ7hPVFOE+nrj/em3ufiBwEctKYWf3rwHepOwHOxLcsK7Ag6vWLVesNE=
X-Received: by 2002:a05:6402:4307:b0:5c9:3f1:e5cd with SMTP id
 4fb4d7f45d1cf-5c905c7a8famr3615578a12.0.1728396302336; Tue, 08 Oct 2024
 07:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-4-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:04:51 +0100
Message-ID: <CAFEAcA8L9djaHeeEShySGa0LKt-qDovgBxvFMDTOF_+=J7+u3w@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] include/exec/memop: Move get_alignment_bits from
 tcg.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This function is specific to MemOp, not TCG in general.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

