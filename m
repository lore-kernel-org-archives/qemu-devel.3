Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA8AD2AB3C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:51:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lgb-0008Cs-CR; Tue, 29 Oct 2024 08:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5lgZ-0008CP-83
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:50:59 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5lgX-0003MM-Qd
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:50:58 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c95a962c2bso6622009a12.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730206256; x=1730811056; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eByJrhKtItG7keppJweYgMWQqbkdmTSBHwqykj5SR2I=;
 b=JonVhGJIpNS/xSJbk7pc0fTDvNNOVsxTHKFT1VG+RYac6bVBwmeeXs8dy60muhu52X
 eNBoS45U2laQZneU3iSaW6sTFP1GwX7Yi7cPdBdFw3vsvfzH4b8Nby6lwNnY3z0dcwJ9
 ATx8RDjw74mq51JLfOcMI5zZzl71EATF26tNg52vqFJzgA3J83yARFLKKbKWdZCJh9rh
 Bb56dEBSw5hssxA51EL0v/Vcwqmmq/IqonHdmvyN0TVEfPjzXEM95mpmj/4A3g4/8XmP
 OSFHsXtbtRJIxf5EbwE+jXI4UQOCm8zqknrJwgvN71v+LNrQGMx9rLWWlzEHia2j1bem
 RxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730206256; x=1730811056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eByJrhKtItG7keppJweYgMWQqbkdmTSBHwqykj5SR2I=;
 b=XYjx60djo0yXV6tLtTb8eUBElKwbzSST2xrVfGsewzZUi5Ty/Fmt3pDAMGH+jq8zvu
 aVhm+IfMhicN/mmRNZLMLV4yQ3Y4Bh61eThUTUdCdyEPcNKP/lE1Unbk/XAf6anE4rBe
 fAACSwig93b/cCJTiTZvghMto7/DUfAUKanGjBxOCBTYw89Poj0g+/BkilHDbK9v6HFt
 WRJni3bG7Jq7BOKhnQzRuphcluUBi1vSCMCaqoLG7u58jVG8VhnZDTsIxLLxbZM9V7Su
 KZAN60uZ0YUQHAJQ0b29KljPd8AlIpWjAo+z89sT6D/IUlJOeEngpSlqAG02df30/efb
 3T2g==
X-Gm-Message-State: AOJu0YyyAmP5k9e6lnuf4IECIDRxI5aLo2MSYuPmXbOLsv6t2mjUQnGm
 2DRUcf9r0cnwxDPFGgnoXY+PdUnkdNTvFPXfxnenIM7jiLzw6zaTJpFdHXQfvERcPOdohY0EbSP
 NWbsY5i3jfhZJXkR16R7naAf1ljghvyamzFlkZ4lCesTfcCX9
X-Google-Smtp-Source: AGHT+IGO0os279f19K5wmBPSxG1OxQ/oEY0OANP1A9FVAW+o1qFyjmKDfBHkOF7/4/PtmMnH30sOUCyR50xjs6SWl0I=
X-Received: by 2002:a05:6402:26c4:b0:5ca:1598:195b with SMTP id
 4fb4d7f45d1cf-5cbbfa61785mr9946294a12.28.1730206255644; Tue, 29 Oct 2024
 05:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <173006362760.28451.11319467059840843945-0@git.sr.ht>
In-Reply-To: <173006362760.28451.11319467059840843945-0@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2024 12:50:44 +0000
Message-ID: <CAFEAcA_P=256Ttohd2YmzNRUK4vLcgAW40gopg6TkYkFXfevOw@mail.gmail.com>
Subject: Re: [PATCH qemu.git v2 0/2] docs/devel/reset: add missing words
To: "~axelheider" <axelheider@gmx.de>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sun, 27 Oct 2024 at 21:14, ~axelheider <axelheider@git.sr.ht> wrote:
>
> v1:
> - Add missing words in documentation
>
> v2:
> -  add plural 's'
>
> Axel Heider (2):
>   docs/devel/reset: add missing words
>   docs/devel/reset: add plural 's'

Thanks for this fix to the docs. I've taken it into
target-arm.next (squashing the two patches into one
since they're fixing a problem in the same sentence).

-- PMM

