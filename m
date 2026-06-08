Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DD7CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWeHo-0005Q0-NJ; Mon, 08 Jun 2026 14:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWeHm-0005Pa-NF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 14:01:18 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWeHl-0001lS-Bj
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 14:01:18 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-66077f6c438so4109633d50.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 11:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780941676; cv=none;
 d=google.com; s=arc-20240605;
 b=blYkVcerY2ZUBmoyeUG3Kn9F5ukWKIsjz+WCfWsRxkgYkdbv3ni8Jty08VqPZ9PWkZ
 4QAJH68krvvAyZA35+E1pBoWG1pD//UlYKgWfiUrHE2KGsv1cUKclBkKxcwPVpDIFZot
 SA8w5rmsmX/4Qce5mPDnaS25H3X2qNLnLWlAjgcvDJ58QCNML6FDFXDrKLHmDiPExu0o
 HmV4DHnSy3xvr7Se9CcnMKwrSytvhkJ7u7cqIzyZKzphASnFYhQKlzqF87+eNGXM9azC
 kvQXFftXA3ZwhvOaqa+evrFccTB3eVjPAVHf0LGF5eXCXUIkh5GQFhoH/kXYbUu3oJGG
 W0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CfifY6sYsF+eHso0dfjYm0PoKpEJEwLqFe6CgVK6Mps=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=B43hExA7HvA+qxcocxhN4+eUIfWyojVC0H+Brxnc9JEfq18kHGEfsm7HfeCtJ3ysUX
 61xWkoEfPYIhbRtBcqnf4/c6/h6aU44Ayvc5mrXTVpbDdcaNnXW/N/VPqTgo3CIdllOH
 puAJHodKrla+RBUxgOL9DK/yBg2drT/rs8ywHCWF19gQfK282crS9y5+MN5Idah5/20D
 UyWCYv0Uio+9HlK90TMNsPlXfRolOOq0o0Su+le7xB/SAwN0to8wisFu8Q0P3k3Cr3Om
 wDN5xRmwUFnoYG/DWTvLtkXXGHns/D5IR+3HVnSf3ARS5gIA/2P0p51qOz8H/w7wZsq9
 k6Tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780941676; x=1781546476; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CfifY6sYsF+eHso0dfjYm0PoKpEJEwLqFe6CgVK6Mps=;
 b=pUa31ruJQ59gNij1Se+ICM6Lfs3I7D9oMylWIVSqLZiIpRWuqIZCEjEI4gsH839F6a
 vCOMrgWPpJ+wmo7kIbEGph1shki2dSiV53+KasJS/eXf7W2NBEfo1cFxOwJII5pLLOM9
 v3yNF/qi9ZwUhii4ynKkPfHSI4t24C1IcXFxd9XPQn62juZjc7XEkFPLI0VLQNVStE37
 fwQCUf+MzTJzaAttyVDcapeZD8diIk3K+Mw1YsbUBZylNcIFEuv4J05ADAdI458pENWG
 BYar/61juwPf8JY6Tks/2v4/TrY3rtDpz7L9FfPRODq0NuaVyAjQh7fMghVIwksM238m
 Znww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780941676; x=1781546476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfifY6sYsF+eHso0dfjYm0PoKpEJEwLqFe6CgVK6Mps=;
 b=dSlyiOSgycbLv+dY0rfbbTSQUSCCHNWjuNceqHedVTHmsr0ArcdJqWsvDuk5/nO5sf
 0dzqzqblX6gMEIlMKFABmuv+3c6/S1P6kUcDU35XcAnihnnTLpPEbZBoYX88li2y1L2N
 KoWNDbtXwf7iLwZ5l7A9ysezUU+3Uu9BD4h7G0LqGoCdhzpdiSW6X9XYZd1z+einq0ZY
 kI2zbUHtcQeB+erlXwMcKCXwOQ/4qLBCiSYs+FOf2kMYSU2AHKPbpGUDY8SVXH309DUw
 59FC7g6Uvs/e9CFoC8N0EYX5/KHHD2C49xNXf0d4qn36Mu9Vpp+NxZkOgNhHtcg0Akj9
 z0qQ==
X-Gm-Message-State: AOJu0YzgOrFrLYnu0RbSjGmmY2vgbA9emApI37689ePXsmnSZJuk/boW
 GWkOdN6wj9forTFTS7GqoC88J9gLRdNKoCnIXW7P5zVmYRzKCdsdNz4O6JKuTVDGOT7gNUT7nYw
 otiKWg/FAsunKphfAwMio/21KnzJtfU2i2Z2KeREFQg==
X-Gm-Gg: Acq92OF4NLqxwKNq6IxLLpda9PDIiIajE1HHFqHE1qXvC+rk683HZtCP5gbMBGrGooS
 rSTaLgw6MORMaUmN7ACh+Ba6fuVs/kdfAEDikv+HljfwCHnh0ZRM/Qx9ILuZWmJu8xF0tU0JD6N
 E2wx0tQMC8ulL1GpepIZA7H8zjh+1FMdS9Jgqgz47B8guoNqKfOakY1dr9/2j6s+4yVJKptOad/
 yAu299utvTWT00nBNQiU3jWLJEXYFsv/MrQl/8rc1s4FmKZBfT4zM/luurGne7MmcQMtwsu6s6/
 +qU1/34HwPHFMof7wj3+u9TLq5H5cKTMaUWUs6RfNr+ZiABoLHIAVYiOgnHBBT4ei1+9bhPMRyh
 7Ew==
X-Received: by 2002:a05:690e:1c07:b0:660:8e61:1a5e with SMTP id
 956f58d0204a3-66106e156b2mr13890129d50.17.1780941664154; Mon, 08 Jun 2026
 11:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-14-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 19:00:52 +0100
X-Gm-Features: AVVi8CdKn-p8wzMPNKO_czrcm0sWR4D0bYTOMLcQRtxI4XOkPTmUStDV_nU-fnU
Message-ID: <CAFEAcA-vB9axYoTFeHAUdXS+tHH5rScvGEecOq2gEOc+xsvASQ@mail.gmail.com>
Subject: Re: [PATCH v9 13/45] target/arm: Implement F1CVT, F1CVTL, F2CVT,
 F2CVTL for SME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Wed, 3 Jun 2026 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-fp8-defs.h |  2 ++
>  target/arm/tcg/fp8_helper.c      | 47 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c   |  5 ++++
>  target/arm/tcg/sme.decode        |  5 ++++
>  4 files changed, 59 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

