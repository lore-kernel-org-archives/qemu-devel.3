Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C862C88E53
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 13:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6T9h-0007R0-Fa; Tue, 15 Sep 2026 09:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T9Z-0007Q2-Ng
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:24:54 -0400
Received: from mail-yx2-x11.google.com ([2607:f8b0:4864:41::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6T9Y-0001WN-C9
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 09:24:53 -0400
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-67109935888so2985113d50.3
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 06:24:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789478691; cv=none;
 d=google.com; s=arc-20260327;
 b=Nsn3rAogvxkE+RFYDAlbLFZ0ehHiRHTqM89ffpm5xbuUz6ekNZ18er/5/guwmCCfi3
 wbxdUCV+Ay5uHb6v9EVZrrDdPo67pjJxmEDi6Dzrc4vHVEjwDnr/ncdaUWhs1e+J1luH
 8RVVSTxemwqDgSMV7Kmf1x2FicRTZ3PM4+djp33r1v18zmefMjmMa6bswoiyOU0Rf1O0
 RWSSJS4ipbvP5VW0uRc3iEVKsP4cOocsDIDz3E+HfnYSOZOkK+o0CDkRe8ZZjnZb9iNi
 iVzyor96bzIPEn7Gy5kULbQ8drG3jxQ0G38gUQQAFtyRa7y8no4mFSWFVE+wK1rW+yiX
 66jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6+uIadRXMt1YyyZJrfNME7Jp4XW/MuXCFcCG/Lhvxos=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=FzWsSKRiy7hA12xhElvw84sADb295MfsrmZEMCPSokUmtTHQqLJwEVzY0+7L2Td3jJ
 pOem6u6SpsKY3s3mgoQ4gplE5J7bdyMIl+BQ+WFUXDHT1WsmFXCwJ+hGQ7/MH5ERCs8E
 PvIeDG9K+iohgzdveDoHamdUu7xiS7THRZmf+WJ2FOckwpg3zHKkUdWRZqfVLRE68VSH
 3J3Wq8FsSQUy9470nKGBoCSzVrKyMA6p4UtVkD0NgzyvXIM12XLF8ki94/YwcZUDCz7Q
 nmJ2WAK/g5avOGH6xe5DrvywclkAeL2QuPf8Oz7ecIAeqbVsaJp1HOWhvEsQZT6pYace
 /V7g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789478691; x=1790083491; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6+uIadRXMt1YyyZJrfNME7Jp4XW/MuXCFcCG/Lhvxos=;
 b=IPQcqdBPmcyaixitxdh7xpWh+BcFrPUrlXcS96oUsrlfo6GwQ6tbOhLdTLRFx9mHL3
 XehDABcLwUPDaygeDjery5TTdzyBxtwTT2xbJENsPOFvPupaG9A6jX0gEmz7XsOWwm2q
 EKc+NpHX/jCB1MxaXl6E4ZJnz2p5BqnBryHGca3utTBMILl5L3FJh5vLIMU3+HW8Lj/T
 4hmkvNO4tuwUSW1jBqm30yzdiVJproTTdN9laEZJFzT31xqCy/k0qlZ6lM7w+Ds5TutU
 NSqb09hYch5F54U7je8kPx3v8bH5/EVImbdptgL0Z46iuRU+OrNLOvNgtK7u2hxLXxs/
 Bbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478691; x=1790083491;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6+uIadRXMt1YyyZJrfNME7Jp4XW/MuXCFcCG/Lhvxos=;
 b=apRYyhrvkfX6T4B0WQu3IFx1RKHxnjlt38yL1+LsLO2FXCfy6is1wz7BOcomf4TJVy
 EF2zke1+JCrFQyssxqaFFtag0KNeBzxk5LAgS3oUGZGcZzxf/Frzun58h0u+RZzXqqHb
 x1gP1zaR27lj+skUhh0vpRt4zOrNS8FMM2ysP+8QhL+iET6JWjBYhmajxpN+kH7yuxDg
 silpUzKTrdjyEINT/eDYgPVNXAXrNLdsymfAOSPdFvvS++BVirk9DddiQbuoBg7mvFnE
 X0Ff6gKxrjIlaMk93sxhVqCedE1DEwkgzRwrrKC1JpEX6D717CP0flCNc+c1V7tRFxDS
 tsKA==
X-Gm-Message-State: AFuF++kng5cd1GRApPBBmvcZrsW5xJ2atpQTyStkaPg1+JIOcFhReW2p
 1dex1NjkQEFBhNGU0WRfYlbw2xRZ4SKwGd9AKZhOnkMfuk3DaDN4kqgSlZyEDnpGlomXLO1uBLg
 PagWM61+gJI3MXGfo0JeMxrbjGTlwWDQQbqgUvElo1g==
X-Gm-Gg: AYBFou3Z0oW365TwSa4BiZi1qaq9896/zVBfUSJ1SEt7tjUUr3hUJxzZmEqkv+y0Ao1
 TDpYKUFEX6Z05kao9hXLXqRGNDzpNnmBd1Y26J/1krIC0vmvFnvjWQNgv6GgN0C6L5GZUa87R0G
 xTpZEkiSZYITMpXfixiVBudUEoJmxc4fDTd4KqBfX4jyFyWsr6ilA8k8V1+uN1AxmnCRLoJeNBg
 Di37Lg1fdeKhmFoEjELYQ9vmhvjg2vzt/k1SuU/NP+M6Bvwq5DmUaK5VRjYjvso98nu8Nxsse23
 LdeBNYHQsCgZcmkuHbuj2zVTS0E3nNi5WPuqz6XCjyd/dFmLFjdWLQ1vHLmnYY0aF9b3cpUYqUn
 VwPRaTVYfn01txNRyvDvRINA0sl8tAGbrTpPbaNM=
X-Received: by 2002:a05:690e:4847:b0:671:3036:42d8 with SMTP id
 956f58d0204a3-6714e195eefmr2109528d50.45.1789478691139; Tue, 15 Sep 2026
 06:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
 <20260914192323.29250-2-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260914192323.29250-2-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Sep 2026 14:24:39 +0100
X-Gm-Features: AcwNN1VZcTL8MUriRccmhp4MrsAftCIaOrq_UzFByKnLYUYJKKWYT10Jn36EyUQ
Message-ID: <CAFEAcA9R82YEX8qcz+CK7=ypSLZFadfrx+jWqMBnGGq6NYn5_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/6] target/arm: enforce Armv6-M NVIC limits
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 14 Sept 2026 at 20:24, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> Armv6-M supports no more than 32 external interrupts. Its ICTR and Active
> Bit Register locations are reserved, and Cortex-M0 implements two priority
> bits.
>
> Reject Armv6-M NVIC configurations with more than 32 external interrupts.
> Add a check-tcg test that verifies the reserved register behavior and
> priority masking on the microbit machine.
>
> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

