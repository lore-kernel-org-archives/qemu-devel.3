Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7BEC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhaV-0007kl-A5; Fri, 04 Jul 2025 10:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhSv-0008N0-JH
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:32:38 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhSt-0007UT-Ao
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:32:37 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-714078015edso8646567b3.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639554; x=1752244354; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2baG7bZ6dgB9epKa4XJxfahUy1VTGMjlJefV7FSwaDg=;
 b=eA+OEmQ26vHtARt7i776DN/lAMK7KMTWRkXo7gU0bPRwSYjPbQpPcWFc4aH+qk5YsC
 xI0nqxkFAPEwc6VSajSP9lImdFaQOfdLYm9xPGLmUD1epOgzFw4EYLD/jv8o8JGAM6y+
 TDUHaiKdE5Yx5dXIBrBB6cagAoULDtlD7ZLTLLiCcyCndPMTgZNI+p1XTfwYs5jr8yCy
 aRGdcalMb4Qvk/uCKUeP4xOfsp3VjuBrdHHWDPkxHfZ0xVafrOncOAPPdu/KIUYZuCfj
 oN8UhDqzjkwDnPbZH9EHCR5lvK1faxXz+83D0ANzJ5GogkqG4I84NSdEdCuyZKoPNMWH
 shZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639554; x=1752244354;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2baG7bZ6dgB9epKa4XJxfahUy1VTGMjlJefV7FSwaDg=;
 b=isPNiZmruDA8KOixJ8xf/Yo7/UC/49I/nmJRoeusGM/QD6H20qhO8x8wCKxsnlcALe
 2He20BfEtljOHnLaq5yOvzeSkMKPRw+wC28n7w/QkBrpIaAIWFBM8vJlObX0ll6QBveu
 NlpHLIEW0ilnrZqYO3aBdOzB7Y+xfKNcc4yDThiA26Mqv2NRkOM5whVdsmNSoFaT+VVh
 MV0/kcesEdASXY6mpeXZLK5lwPTrVW+MESrzI6zSZ1/dCaBBj0HGGwj9N6/s/kOVENdB
 Zep7h4Qn3XWeIrpnCt5Sd4QR2UbOqAOmZ7vVi3ZwvfMoekOwpb07vpoaUWbn7ArDhlZz
 mpRA==
X-Gm-Message-State: AOJu0YwNcvkBFx5Z627RCLnNgmGwduFT36COlQlC2FXLzUsQx16rSZfY
 eCA+jUkD1rmTx6I8p1whaxHKnRmFgm/gcDKibus4Zg3CutzNwPbCzCT2XpN63JKVV3eNP5bNlsb
 ICVBkyadn3XzgFwA45mHLBwCA5nZ7gcSyp6gOcU3qg/jlRwUUHhf+
X-Gm-Gg: ASbGncuPx5loWksa8Zyu4tRV40B6JleQok7GtE0j5erOOKnvPM1XYT3PoRhrGRV+yTR
 1lZNXB8fs0eF8NmLRR2maNFkpn8DfHEcIpq9pibsmrnWEcd0TS/n92m2v9r/iDS83rajIj++4kl
 xx+l10eiDUPFZTb8CVUKi9TzeLN62a7r/3d//aD+4PuOu1AQVmkYerDY4=
X-Google-Smtp-Source: AGHT+IFdnNtG0A7wI0EFqHeiHm4JIG6W1M/v8xy2Y3BXavE6fXg+6s0fhwnpYMt29LoYvcV4xg6oYNvBA7ci+dBBK+8=
X-Received: by 2002:a05:690c:6f82:b0:70d:ed5d:b4dd with SMTP id
 00721157ae682-7166b699231mr26909327b3.25.1751639554255; Fri, 04 Jul 2025
 07:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-73-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-73-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:32:22 +0100
X-Gm-Features: Ac12FXymEPYrxyH0OmnyefFcShIVL8mI2lRA4uVASC_dpfbCbWZx9bbcqVK9szk
Message-ID: <CAFEAcA8oES6+USn_gZB=D6cDHsfJdyqRNhvf2Ne1j4xHf5w41g@mail.gmail.com>
Subject: Re: [PATCH v4 072/108] target/arm: Expand do_zero inline
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Fri, 4 Jul 2025 at 15:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Expand to memset plus the return value, when used.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_helper.c | 28 +++++++++++-----------------
>  1 file changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

