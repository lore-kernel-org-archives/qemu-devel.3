Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17063CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTDj-0000kh-1n; Tue, 16 Jun 2026 08:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTDg-0000jz-UY
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:48:44 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZTDc-00037n-P4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:48:43 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-662bf1dab83so512159d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781614118; cv=none;
 d=google.com; s=arc-20240605;
 b=Vmg4Eyx0B1GsrJsm0gS59+128pI8YQzGAYGbPFYJj1qe8J5WA3keWIbBx8DnuMuGEv
 gFECcJ2BQ3ZqdpywoGDCEcKvtJRE2iKlCmikVowM3WrB9tu6Ql+b3LjgzW8xK0YMCdHT
 DflIAdt2UrUr0WFWV1Gg5kuZ6Hehpd05SMKMmFDdGzeULR0ebaoBoJyONab8bSvwmqGG
 1NggMRLbMZthu6nLeQAqXWY0osNCRLg4P6t4H0GVoyzaW7o68R7MhSPYgKrrAFGm6IrO
 /xQrn+9cHmhb4W4K3VVIxdLhPqYG4Kiu5VwBsCLshhGxjGH+feCvdMN2CLbdbf8tuZVS
 XJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i1pGzmnI/QvRqZdFy9heN9xomoKs5zp7pPEBsBs0YEY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=jPnHwCEeH35Na/0DRl/4HX82Z3ZJl+vEwukYfNMJrNNYMwligwmecMzJnu5OyxNOTG
 mKyKRKiN218oIel0UUd13ZQLGzpBdPUBXDb+YSyKqs/crZmHADXtlJ7hnYvBnm6FUMCt
 dGcfkP/mBGSMCFwGwIePpwhYckBVQVmwTSC1m61qy/J2UBAWywFWwR+16c+ytiqsFu0a
 qH0hr5GoWLOOk9GO+44XjkHMEFx4wcvQkqtlTzcTl+NrC9ZtYgxzMni12MozRoCW8Uay
 jnbnlVKH3is0BTfcL1ek+R40u6mD3f7B3kukSIR7+DY4mx2orVxpc4oim6OMdXLCM4Ru
 wKOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781614118; x=1782218918; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i1pGzmnI/QvRqZdFy9heN9xomoKs5zp7pPEBsBs0YEY=;
 b=U3jquDT+pH+sa4JJY+mm8LwD3rS01t3diW4d1FJxHl9qWGoIhmXe8xQUmwtSHEC34C
 f2lwsICFA76ZFEb4AS5aPOTbRdekR5oTRSM1pM+TXwQS1NBWMpqrh/yeDi54zHAADLqw
 67OPFso19UP93ou40WNGV2CxaUc0b9ZPY6jQd1qhnlaAPvMi1DcdFYx2StbG48sKpfCc
 IXWlkjmjgLusr1nx+zXVJGMXjkJh1mAdh4/DSgHG1k1qi6WHgg/jgbexu6foORJAjiLP
 70C2QX7rjUhKnOv3ZLdsCo6+IbEyBLCIpdxIvStgO0NOs29a4SsZ3PE/bUXZK3WSFth9
 RS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781614118; x=1782218918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1pGzmnI/QvRqZdFy9heN9xomoKs5zp7pPEBsBs0YEY=;
 b=HurmFhoyyNgImaokUtqPuwAXGh4dAkvrU6Oln8wTH2H6nEB0MPdiUfOTXOEQY3tv5u
 E5o9a8Rr1pEoFgvYIG9wKIVvgQtFxc8rT/4+FGdOqNVdWe+jO+MclEjXcHhHazDi8osN
 QshcPeuJtvKXmcYdsjgctx5rqUoOivRFIn1/C4C1dlXYnwm8128d3mM1TxfwfN6W8y5M
 5pg6Zm/G4t5lKg2cLtPLaagOPBeQFfhTcG5/wydYhvVdtRi+Khr3gyGoJxakfRFyQJVF
 mKuKIaBDY+tbsnyNB3mBoDHqZx0N/cnzTUHgXtFo7t/QRphCr7SQKEdqd8HlnYkcpcCg
 11Mg==
X-Gm-Message-State: AOJu0YxGiUkmXoNHhpfX20TKTk05Ym5MhaEVhhfCxcjph86cnyztH8rM
 4o2zF3pMS1hQUtKdrnex4sM4AqEnvnczNQaTqkYA3ZjIIUHavAv7wUIE3znKAIJMfQah6f7MtW3
 /memdWfGJf1R2ouPuSjNOm5HT5F5uAXETxtCfgCDP8Q==
X-Gm-Gg: Acq92OELPKpm93+VTxqJ/1zJnrXLfbluDenWcrKTgzGPqwqrGWuhA4IZ4kuVkmOSl1s
 PUragUpUalWfFhxZ0pxX56QdpcIwyAkRchMA176Sf9WItx73vSaTHcfyl8Qu8OITcb8sjYcwRTA
 DT8BoCf9eCLDp+++F8T1eT9urpggPCpQkVOGSaaWZBbloIPnF8DKIhodNQ+KLq+chWPEV0dpp6K
 Vbl3G/l7646vGUPUH1VS91yRz0b9xHUIZ0KAEyaWgx411SzRDiAk2JN77Uqe/66xH7gMTUDX+7a
 DKQfkLKgXF59gsTHbhnlvC0sfbqjAnHGc/PrWR5FUCrYeWrrXT29AafQBRRlHz2pNJHKsPr+oGI
 yJQ==
X-Received: by 2002:a53:d205:0:b0:660:d512:46dc with SMTP id
 956f58d0204a3-66285165c47mr9873321d50.57.1781614117437; Tue, 16 Jun 2026
 05:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-13-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-13-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:48:25 +0100
X-Gm-Features: AVVi8CdhsD3hKOMTbhrww1OomvH6v36TU1ngI2CzJg_G3MxBzfMqsEy2NR3XZ6k
Message-ID: <CAFEAcA_JJVwr+56Zw+8RV5MHJHyz5_rmVsgaqnZfJR-xpmcopA@mail.gmail.com>
Subject: Re: [PATCH 12/25] target/arm: Implement Floating-point convert
 (predicated, zeroing)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is FCVTX, FCVT and BFCVT.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

