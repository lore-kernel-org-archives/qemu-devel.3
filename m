Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EC7CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZmeg-0003OQ-Nk; Wed, 17 Jun 2026 05:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZmed-0003LG-1I
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 05:33:51 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZmeb-0007Ht-0J
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 05:33:50 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-66067da0638so2957480d50.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 02:33:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781688827; cv=none;
 d=google.com; s=arc-20240605;
 b=FQ4rT5ph4Cizq5ZttKJ61WlZLG4O9zDCTPApRxS/m2vvakFqHwrlLAa5rh2Z1V0XK9
 0Aez8yiNksj3NHwnPdTf5jdSjjaQo8EdbBI8rssvtKxFOAqLHDPUM4miBfYSLt1K3P+m
 MrgBqNLqVoZm9ztP9qN8pZvzt6QyGNc4rFwB9wJry5EFH8lA+i2mKylLtqP16Xn/Oo5f
 BCcxvyZ33CcaZ6yJYtmqxEETXc5q2nfUrILeGBzf4aoQ2UsQyFrxEvf8AbOZNhf4PQ6v
 Fv0IQWXh+C7J2YBOHMsv5PyDMMzkzZpJFHKQjhggusXoc/naXLpJgPi3vxLrWBsr0GVK
 vRMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/ksVfi2RLGazqcwiYqrrKQE7r9oOHBWPdMTbcfRJ0Zo=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=cxbAKOo7wu54T/0sGglgDSCO3wskoZVtODPcrYNZW1iDCbk4DSP0ZlyknlREoUxZ7a
 gdjLnF4d5EA8uMNPaQe3h78v7tB4Y+PdI1Bz7G9gofAunrPUsaL10sudOZGaSgA2xK2l
 9mG0QqwqO/qxSJ1WqdEXP40CUdDPs2Ccbk8C4KRSHbrxiPW3gsp59UnSQn7SPz1X17Sq
 oavv7JxG5IcAbJmbZEK3u83W5a5K+xUfZjjFV7eB48oF43n5mvASrVKMq1EZbZKgpA2K
 g91SWQ8iLDhV/TN6IIneCnDejseU5R0B8mqHocdDWUb50aLTwFaLVKgjGfgrBrhZshF1
 iK9w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781688827; x=1782293627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ksVfi2RLGazqcwiYqrrKQE7r9oOHBWPdMTbcfRJ0Zo=;
 b=qHM3lcsskhOlAYQJ4GL8rJRIyRzWEPuEKytF/PvfNQoukx5rw7Z2dYBkZq/nTo6hZL
 i1YYgzylC/JF8xCfad7cM3q7pVn3M85z8tYKiFcXXX9Rb/oMgIOLpW3sK1mnfVZ842YM
 /maztYAJxveg8Bw5DQXpi68y9J8QZZrykDComw44B4C+///f3O0+Vm38Y4wxZ4mSvoom
 lUFE7mdcr6KRcmuESHPWdVl7TAE9RQfmzIGhlDUzulEHmLOy8vhYm3OJSn/5/ak9DJ1V
 8pdv+sYB9xA7iAcCCzuwVpOMHRIbU78EQ6qDKI2x3QQelxIZrOAKwAzbukStBHC9gQHl
 faTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781688827; x=1782293627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ksVfi2RLGazqcwiYqrrKQE7r9oOHBWPdMTbcfRJ0Zo=;
 b=m2pBF5jpFMQLFodi65Fz79L5u/FHyDZs7wxpqdROdNBZbJoxA/+Jocr6yP1SYNiIMy
 +JtnW/xrR0eS75qCQ1QJjMYE5THkcCBRLtBubjzpPcEUstttFEyr7RYHw2i0R6IbB8Hu
 mBmw/xPIP+YxehHwCBCbd/TZaHW5sg7CnInQNExA3O8CcJImuYlRo5p1NMY3ZTy24DDW
 BwLBXqR6tVzhe1xy/v1n88M8eTNGCd6gxdlnIxgWLn+qyYdRnALTOC4mx1SZ5kxkMCK1
 GQcpURaGx8pvu5KU+lscobiyqRa55z8+J+SZPHDTKNIsutqJ5uwhlzHFLOAuLbS1iNgU
 oIHA==
X-Gm-Message-State: AOJu0YxRKPvk/F/oEkWiSM0cNLXyt6OVE5al/qI/gTqVjByNvM0Qelv6
 viDdKq5HSj9SIcTyvqBsepkCOkaH8tQnip/0+8arovV9txPIDK30YAGfackotKQhTHFjVtcnjiq
 6i4Ih0LFbZekDA8E08VVIBdVp3roIGuRS9C9r4Lw04BxrYHrc4lcL
X-Gm-Gg: AfdE7cmS85Ly4K132z7EwumxvtVS8myvW3P5XCrKkAQlopgHPNX4YRuLAJvtZYyFWZc
 cDtDeub004eTiHi1H65C1NQZadmHenrWMqf4dJqzmm4xwM84NQrthlxfrq/6BOeUKlRM56bIjdJ
 7A90F4wTph+hPVGpUVbvwVaSgOaBqOw7s3dsct684RQZGq1ODCJjEexsB2e20yY2Dyu2tLV0XNh
 LPODOblPFdE67jLLaaOXLX91z9mha0kZLvvd5rKx9OSULRGxyaylMkvxKXHVm3nCy9I3TVrnJBI
 udfCDoB3agv1B9tyiL28bD4j9s7HM+sVQskE7ov7SOtvAhPzqK21XFqd
X-Received: by 2002:a05:690e:441b:b0:660:48b1:50fc with SMTP id
 956f58d0204a3-662cb984fb7mr1934694d50.29.1781688827168; Wed, 17 Jun 2026
 02:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260617085030.2586072-1-kchiu@axiado.com>
In-Reply-To: <20260617085030.2586072-1-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jun 2026 10:33:35 +0100
X-Gm-Features: AVVi8CeUBBdOnd6a93FqffmdB-UluQMTM1fSwaPK8WU_SvF9eXwPp8BSOq-gTTU
Message-ID: <CAFEAcA8Me2BsmEB4zOrpXpirt9zCVqTQafbfactd3-_8tRtMSA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add Axiado SoC AX3000 and EVK board
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Wed, 17 Jun 2026 at 09:50, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patchset introduces Axiado SoC AX3000 and a EVK SCM3003 for emulation
> The model for Axiado SoC AX3000 supports
>   4 Cortex-A53 CPUs
>   Arm Generic Interrupt Controller v3
>   4 Cadence UARTs
>   1 SDHCI controller with PHY
>   8 Cadence GPIOs
>
> Verified the machine "axiado-scm3003" with following command
>
> qemu-system-aarch64 \
>     -m 4G \
>     -machine axiado-scm3003 \
>     -device loader,file=u-boot.bin,addr=0x3C000000,cpu-num=0 \
>     -nographic \
>     -serial null \
>     -serial null \
>     -serial null \
>     -serial mon:stdio \
>     -drive if=sd,file=obmc-phosphor-image-evk-axiado-qemu.wic,format=raw
>
> Refer Axiado website for more product information
> https://axiado.com/products/
>
> Changes in v4:
>   1. Remove ERRP_GUARD from axiado_sdhci
>   2. Optimize ISR update function of cadence_gpio with logical operation

You still are not calling arm_load_kernel() in your machine init.
This is *not* optional, you *must* call that function.

thanks
-- PMM

