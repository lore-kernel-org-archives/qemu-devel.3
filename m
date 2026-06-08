Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA34BCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 18:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWeIR-0005XV-9B; Mon, 08 Jun 2026 14:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWeIM-0005VC-Ew
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 14:01:56 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWeIK-0001tF-Kb
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 14:01:54 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66061993121so4386182d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 11:01:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780941711; cv=none;
 d=google.com; s=arc-20240605;
 b=lGmjxPzqKVP99nRuRu1n/VlpLv9cQVdD0m8I5QNziQ0J11GujjpH+fzIE3ND4c5wGA
 O0pyMp6ZBGlNta9EgH04/iYBLtZM/ySqeYOme+pQMyjSbO7lOn/znrIXjrjtKw+YNNyK
 5sJDNvEgg4Ytr7EPLVFNkSfxSrHBGbaluk3FktUFXSE7T/xeAHI4gTczFheIqHF8gYEp
 mCTJMLjN+enalZD8T6FAHbZKrTqyn5W1t4BLYq/kYlhgvm7odmXlLL6dK++e7YkJaklK
 jvUbyB6wmSNn2mtCCaL+fv713ZJ3mIWMhX5jlNrTHt8/I6Kjh2Bc1WkN2lomyyK2lFT7
 kn0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PbmVMlBTI1D89FAE/1WRXmY+YS4Lim1UF2iTW3DOm/k=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=fOLe9K/91vBebapP3r+WztEPNIZWgNGwSXBxRQuA+ArnTr7eKuqdB/k3615wutMgR8
 E6V9jgqSNiksPiEQRG3RD7FzJecl2slSdKPDl8bZQUaAYfylWBzAdPez3cmGUUsYhsP5
 sW+RvqqzQyOzwJJ7ZIqdahnlv8ovFYFp3xOjykNvsI6/L5k4LUbFPpO2BW19QttVIS2b
 yXhVo/JO5K6QgyoZNQbAfTxDOI99fPLi9c5wJe9F59DfnJ/CwZyxlvPp0wkblERINuOF
 lfAtQhKDOQCuPDafjzTLMteK2SdK1ds23Ua7PgDcEUJ5ljedYL09Cvi8ABDF0MQsa8Ct
 nbWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780941711; x=1781546511; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PbmVMlBTI1D89FAE/1WRXmY+YS4Lim1UF2iTW3DOm/k=;
 b=z5FrqqS286ftUcPLeq28b+9mgAXnMbejP+rs//xj6TGDtaVNYP1MHwSFK7jMCeZQc4
 gKnr0ohtMEs8lhD5b2u6tXttzI4GV0aCd9kGerjbMGcdcU0tVWzlEEuuF+zo4YuH7yox
 CijOvrnPpZE2VqkPpB8sO2uH7LPEHLsyWIalhXgYepliBPICZK4TvIqMWGMisL2uNZWd
 FKx1Pjw+40qj7KTPdReRvdywlZFHWg9U8TOLm8FXjwtfpivjqyG2RDPyAlVtK2QHynU8
 UHfGxgOYtS/FVsMwivLxvxw/ojklltCBdlortu1a9nEAOO9MRKp5jJ6Dxe2p/l/6nsL6
 ksZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780941711; x=1781546511;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PbmVMlBTI1D89FAE/1WRXmY+YS4Lim1UF2iTW3DOm/k=;
 b=bC9wQh5Sh8ELcAZiqYWD/p+T9txGTY/XDV+xGhe273BTLwx0FlUyKx5sl+FeiB0TjS
 M11+SDYH+9O36hDijqi2atdCxzZrGw7SYutJR4x6/Iz8M0nIrwesJjOgE39QZKt4m72+
 thVx6psvCizL1ozuakglEy0gLhHidkdhQoVWDH7HuFKXKl1F6vvJLDuaETQvB3LudHOE
 +9BFJFZbGJKpXxXawgU2z6kC1mfuXBapI5BU1/2XLEPKfZVdR+sCvlA8p/RtGW4d20kB
 rDHh4YVharmjCBjreD3+OcwbAX61isHoqAARXOi6UB91sRD/8uFFK2RnMOz1QE5lBF/Y
 tfqQ==
X-Gm-Message-State: AOJu0YyuyqnA8clKajHKw56eNGvaVeHpZkRlR9zVQyjKVhVMUNtK+FLn
 i2MvsCd6OJ0rAK1DbBr+wXPchsgNdK0aNSxt2LRuqPGZUPDqNZJAb7KYhgNDQsilnxlMwQtYdjg
 MbCoUrSa4CYRxRoUhW9m8fn9l4bw5MIcK2H11zeLBbzRKkbCUgkyz
X-Gm-Gg: Acq92OEon9qap/Et34A7pboPNLmLqvRuriVLL2pC0Tm4v042+e7uwX/sNsMzj5ySlwm
 oDkywWNCTqE+zLwdLwCuRYrlzT8UFO//VOEGKykwiA/h4SmHQsH4tKPuMaEUqRTfiJcOeDX//K8
 4qyM+iAP+zXzMii0LaaHMkREhWfY5BNr4qo76SBuqa6Ke/hYvKXVQ8hmtvtSPK0JAue8yiOwX/d
 RVMbtlcguamwbmKy4oQ/BT+dwL3dmvTF+JM00hlVl3ChOdwuyCuknA1dqBnSEzcHlRAb6vAqIw0
 iYEZqmmcE1JfTw7RHWgF11676nXJo8c7QQC/D+OuMZxd2tHrtnsB5ZqbjBIAS5VI6avsFpj28b6
 hjJ7gjpI/5ewV
X-Received: by 2002:a05:690e:4088:b0:65e:a838:e9d1 with SMTP id
 956f58d0204a3-66106facf32mr14822490d50.59.1780941711504; Mon, 08 Jun 2026
 11:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-12-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 19:01:39 +0100
X-Gm-Features: AVVi8CfhupZr1gs4g6lDkJ1lkkyKBM22J0Sw6aeJNxKrMvFtuGmrFCSLAQz9rNI
Message-ID: <CAFEAcA-Ju8GTfpahUiypBSUyhJNURk0-63PFqA5bhkY1w6EmZA@mail.gmail.com>
Subject: Re: [PATCH v9 11/45] target/arm: Implement F1CVTL, F1CVTL2, F2CVTL,
 F2CVTL2 for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 3 Jun 2026 at 04:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

