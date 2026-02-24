Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B71EF5862
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvZS-0003gx-KL; Tue, 24 Feb 2026 11:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvZR-0003gj-Dg
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:47:37 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuvZN-0002CQ-0Q
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:47:36 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8842e5a2a1so817708066b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 08:47:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771951651; cv=none;
 d=google.com; s=arc-20240605;
 b=LU8z2kcfkngr6530LUiquNn92e8KbSjT5xna4e7mWDqGT3PPSRhmRaynZ00Yk+c6B2
 JndGXSSIGoU6326cW3kM4S2pXE7t4kZMaa0MghkDiYKMaaUsBF7/+U9eDnu/WJ4hHIIk
 8s71O+aqqISmsjJMs1bnjMeuANR4Wr+97sHpSWn8wvN0OSRQTee9BNQ2GdOtd3ntLtQo
 B8YKDkoJj790br78fx7d0lQJ22cq9duisygziPJFgZaw0OLvA/MOOqhBtDEUmsa8ES/B
 O5uYcXYbFcl1N3AqW1VHXmvKq+4ZtgePpGYD+pESs+dCC6ZsiOyqq0REVnQoZv4q5mfN
 6acQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZULbb1EyghyE5CwjH3wRKtABBw9P94DasYK1jhZfeOE=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=kL2cimLaKkZffQJTp1rgk0jzbgjMDjkunLYWaISFm8VZADN55k5+RdJmMz79cIKMov
 2kExGIZI7PU5Hvm4wPifWy4RLCK6hePi7quNZnwki6KfNpRZl1LLXto8fpmyHYmDdUQx
 L7AZ1d6b6wNHYOJyfTN8mruwtcAf4imfGjkEgHVFPgCUTshZiBkK9m3t32mjYpQaVtaI
 yJbqvYo1Oy30SLEL7P1oLmgtXXOxjBTiV1pYDvptqK2fT5mH7iOcKwM6pqtKymwldlIQ
 gXonX73PBr2lAqWSmo5BTdQatV1cte8JGudTbTQW7O7eMLcml4FE5ykOakDAscWkTiDp
 50sw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771951651; x=1772556451; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZULbb1EyghyE5CwjH3wRKtABBw9P94DasYK1jhZfeOE=;
 b=h0dwMKlVHjzs3KS+Tw76/11ig4tsbjGSaepxtGut6+ib46nTxoPyJV4GkNtgr3Ti5L
 2ep/uJBs7iSwc+koK0DNbYKZUILbR3IhpGUyWP/8yRJBv7HvfoAcHAFKY0Bz1tXBL/3H
 ughwEvexCLMNgHatyJRLJz3fxxzrGGU76mhu1BL16IcykaCMdHnbV/jHkhhW5FYX57uM
 pkuRznIufaUPiAcZcBrCDX6axwE61ax5LEXnOGMzH6b0bziMpGteRw+N63duG+MRbfSe
 7d7XuN8d8dBqcR962Xw6UXmOBA8fd7x5hcfbuVj2GvDomn1OzDm04MwlOL8m/uQ4oGtp
 PaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771951651; x=1772556451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZULbb1EyghyE5CwjH3wRKtABBw9P94DasYK1jhZfeOE=;
 b=JGOwdbcNsq73xeSiXAimyAcJiE/5QhK5ZyEDD9v32vUuDkfAWch6Q0EhzOEytVPNDg
 J+CRWxgP5J3suqX5W8zYmH6lQXXFNIK6YRSBgCBEDTtB2mb2iA/dLmPxy03Dl3isT4B3
 FcQO5ZfB24o19gC8hCHLoPX9HQrRUPAOl7LIFTnb7T+xT2O+Ke94O2EB+vB/itVYSB1F
 boGnv6KuhpiGOAFar7W3NFNdaj0BGACVC26D0D9fJKbnXWQ/rBQXHjLZCLrfybgvn1S0
 QTdlVKKxrbcYJme3/hp1fN5QTfquaTuK1N/+Wjj2ayjtb0B30CV79eHr8FT6raQ/zeq8
 g12w==
X-Gm-Message-State: AOJu0YzZDfrdp0807RqDEHrB34wIpsRz3NpCPJ1+GMO0jlRx29YgdgBA
 /bvU2soju9Pf5HXkrk9x0h4rVFeDb71qCVNeWi1HMU5oASLeALSfUc2e3SbQxZZaFomeYBeJHIz
 N++iY+GAVJi4wOlRbsy+YzngEB4oqWxsyuTVoajtJKo7LpBlG2dCI
X-Gm-Gg: ATEYQzyqB05/q2HLHbRq74BuRFbHqrw4SABS9mJQHTc4F9jTBZsEc6OwxmMFEDf9PEe
 buQDAxPlF9WyFG+Ht6ZyTqB2RclCifhEKLdsGpprvJ+WbGKWrDOR2e6NJkDsBEwKIpxHYIXO87Y
 zXZETiHNEKCV0HXzgWNzUkvcpPrgKmWYEiA4idbFmDGnGBUNeQg4ZP1TXaeP9dcLcBkIXZyWKnX
 grgRqawCJU70W9pcyamqK2tqT2Pk9XwUGX7/CDwOnYjyNyQ7rtRlOF9StAwuV5nztXEYWtgqJ7M
 nTsfy9NJIBCC0NO7FU94nGcR+Vvjwype02B2KPh8vLP7yJPGi8jo5wknbRpb3ccPMws=
X-Received: by 2002:a17:907:7fa3:b0:b80:3fc4:37bd with SMTP id
 a640c23a62f3a-b9081984f0amr765064066b.7.1771951651330; Tue, 24 Feb 2026
 08:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20260216034432.23912-1-richard.henderson@linaro.org>
 <20260216034432.23912-4-richard.henderson@linaro.org>
In-Reply-To: <20260216034432.23912-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 16:47:18 +0000
X-Gm-Features: AaiRm50oRLJmQ5NbMYAs7yxpk_efKn9zBQgIh1YX4K2N7GYvyA-bI5j-qNrvzWI
Message-ID: <CAFEAcA9GhWHbW2q2M5v24OHXzCGqNG0LS5kBOMw0BgnXdQ8_dQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] target/arm: Move kvm_arm_sve_get_vls within
 kvm.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Mon, 16 Feb 2026 at 03:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Prepare to adjust the invocation point and visibility.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm.c | 108 +++++++++++++++++++++++------------------------
>  1 file changed, 54 insertions(+), 54 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

