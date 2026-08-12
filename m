Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E5FC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu6Qa-0005ov-IU; Wed, 12 Aug 2026 06:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu6QY-0005og-W8
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:43:19 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu6QX-0004Sm-F2
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:43:18 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-81ed2a06b9eso9122527b3.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:43:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786531396; cv=none;
 d=google.com; s=arc-20260327;
 b=UZaSKMKUsCtQy7kBzMA7uHDIbxJHeMT60xJ92urYCVVlw6ys28F4EBJpC14PFJm3VJ
 /+Wk8Ft51nH/zcsM26h7036iRHf3KqLALVSU6K9BK6mcCb6vcFGPjaLcwmlzeXdHRm79
 UZjvLqJmGg/oNuSb4nGuVwo8BRcjWtYwCtMWOvp88AL6dIKXlN3EU6uME/a/WwBKEkad
 UyWG7Us3A+I4CqEmzMUnMv6XbXctVpquqSEaVI586cCU92AXWYwdV7sqQu9X0/CyExMC
 tlmcwB218ZTOAXanL3BgfMzQ4x81GUT4Ojk78F/5I1rVzcDtMzpS939vm46Nbfh1R1Vv
 gVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qXG5e6TLfXDlJCp2Kn32oPKIFBCqZDLXYnS/oDDCYb4=;
 fh=sa54kRfqZCSJoqqovfbLshesdcnvoIzhJ6jhb/uDQ0k=;
 b=sf/PATDlPTQAipi4T0JpP7W6aVyTVpVMEwrt8OiMdd5Wkgx1SLP/JyronX0Cw0o4EC
 orr7qvA+3yErF52+OHxOce7Pgc0CvDtpPvaWNzSO9nqivu4OB0KGwIbw6Jd2o0f7Lki5
 LsI1H7skMLIWRzyImIfR+QJHxClElSuUIdq55afAK4XiiYcqGeT2TUiVMxFCcwQTclE1
 CvZAEKD3kEhtfvpbAAUSroqdws6zrjpuQHMHPfZiYcADtyidBiCMbHbZYIPG8pzco4mV
 a/DuR69qQ7kRATh1Yq9ee3kNgXu5vWPIBUuErkH4eI08COfXWuazSMJvTSthKrWzJFxO
 x4Lg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786531396; x=1787136196; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qXG5e6TLfXDlJCp2Kn32oPKIFBCqZDLXYnS/oDDCYb4=;
 b=DfEtTXHsS6M4KFFdhCUEjkw57odT8AcjjUZiMgg20SfFT5CQpnRS+bATK50elvejJ2
 C40ufKHXMkI3EPC/Har6HHTUIvHfAoMiJkA6oNFGi/KmqSXneQYE/k4yxUaxqBhWGYLc
 LB3QbNgSXOQAYK92+rmQza7Zr1rtLdcnMUqbDebf9F1EC4H026+kApUOk39Hyt3i2vID
 drOHbI34cuYb6DiKOtAMi154taUCI9m/uAfDRtWlHXi4LjroTLd6S1mjVv0+7PQj14Ds
 PvQ285btgA3mARFkdcOC4GFXY0D+EQIZ1AlbHM+Da80pZDZ4Trqwu2ADrjr401+YmShJ
 tq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786531396; x=1787136196;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qXG5e6TLfXDlJCp2Kn32oPKIFBCqZDLXYnS/oDDCYb4=;
 b=MrJOscxsr9ALDBjOAlB9ObKvRbN6ksLcSTilqxAzGyCE1xmqFAPda9DAnIlR0mhpCS
 mpQfbSlCVCqbUs0FMv8LCh+01UfsQiE0fC7fnr/HvW0EzBzKf+GQbxkORgRmapc0oovF
 O6owhPLJtU5hVuWxt1RnhsWc2EzS/KbjoFjgNF+6tP4+nMnQz4lo4Bioj0jgelXFeSUS
 pgQ7q+bL0XqZbYu6pm+Lntr8CBuR30pJJCkZdym8DDdqUrp+3Uy4PT7EmgQqtV3B07nB
 T5v/02jSML+v+Fnftltl4nyp9FJQGa6fX+LYM8ijHTruUzAY78vd7VWfxp89v/h1RFT5
 laNg==
X-Gm-Message-State: AOJu0YyICqROW3dQpEfjYezZz7Jps0tmm/aBkeoOSdqsIF6uvuI246fK
 38zeRW3ELZriuL4NYf5AoFF/bbeSHH51TcB1uitXiVzZE602/+d4W23rNpqJBhkuI7qmH98iXEZ
 n+GFoV92VW3kt099jrI7rdMWZxPm4j21P8Qhngj4/V/FsPyt8hIV8Z4A=
X-Gm-Gg: AR+sD13rJq6WiKreR8G2AegAgx4FP4NMqtECXMpUPKbLyso/CwkSvWacST90HlNGE+c
 BlMv8HqsrSZA0Jzn61Jg8kumK2ieDtR9Upu4JDmWkMW5ShuKuuCEzCTsxCx8Tp7aVjgGCXaqaAg
 uaWeGg4X9zHluYLOIn+c5L+wI8tbPUMPoB4MG9bPQCPMXQSEy9qPGDeLOPe2E+f4ek10jv8MIEQ
 Hk7aQzpFQbTx5Hlm/PTNN61TjSNEtdBtvE1pnCUkZdhA/etARPaM819iWrnVUIC4pPyLRRBe2vR
 zUHO504d73vCbxtdEqezd+zs2VOZTrMPPM+woQiptw+JGzdMwkkswU9v/3DDzYn3Fe5VOf5Y+dA
 wvp1AC7Y5vwYrGa2hZq7Qo10GB+Nx
X-Received: by 2002:a05:690c:112:b0:803:6bb9:1753 with SMTP id
 00721157ae682-8310a4c52aamr20156717b3.21.1786531395609; Wed, 12 Aug 2026
 03:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260713073033.3883619-1-kchiu@axiado.com>
 <CAFEAcA_=DVVwQYdpwnhbzF_GwR9gZp4sJa-C97caA0i7zofADA@mail.gmail.com>
In-Reply-To: <CAFEAcA_=DVVwQYdpwnhbzF_GwR9gZp4sJa-C97caA0i7zofADA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Aug 2026 11:43:04 +0100
X-Gm-Features: AUfX_mwjvclEFWPTb8rczu4uepI7ZHC2Rv-ByP6PuXknCzsx3UiylzwIrswAEZg
Message-ID: <CAFEAcA-CRhcSEQL8wWMjyLJR5j8x01d7dXRNpfHDds8qC1qzcw@mail.gmail.com>
Subject: Re: [PATCH v7 0/8] Add Axiado SoC AX3000 and EVK board
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Mon, 10 Aug 2026 at 16:31, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 13 Jul 2026 at 08:31, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
> >
> > This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
> > The model for Axiado SoC AX3000 supports
> >   4 Cortex-A53 CPUs
> >   Arm Generic Interrupt Controller v3
> >   4 Cadence UARTs
> >   1 SDHCI controller with PHY
> >   8 Cadence GPIOs
>
> Thanks; I've applied this to target-arm.next ready for when
> the tree reopens for 11.2.
>
> I made a couple of minor fixes to save you doing another respin:
>
> (1) you can't use %lx in logging printf format strings for printing
> a variable of type 'hwaddr' (it isn't a "long" on all hosts, and
> this won't compile on some systems) -- you need HWADDR_PRIx . I
> fixed some cases of this in patches 2 and 4.
>
> (2) we don't require the "<public>" and "<private>" marker comments
> any more, so I removed them from patch 7.

I also found that an issue with the Kconfig info caused a build
failure when any non-arm target is enabled in configure. This
fixes it (and makes the kconfig match how we do other board
and SoC kconfig stanzas in hw/arm/Kconfig):

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d0ae131628..e22c34a2e1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -728,7 +728,6 @@ config ARMSSE

 config AXIADO_SOC
     bool
-    depends on ARM
     select ARM_GIC
     select CADENCE # UART
     select AXIADO_CLK
@@ -739,4 +738,5 @@ config AXIADO_SOC
 config AXIADO_EVK
     bool
     default y
+    depends on TCG && ARM
     select AXIADO_SOC

so I am squashing that in accordingly.

-- PMM

