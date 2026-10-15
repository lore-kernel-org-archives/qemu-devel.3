Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434A5CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHL2q-0004WK-G4; Thu, 15 Oct 2026 08:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHL2n-0004W4-OS
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:58:49 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHL2l-0002AG-Ro
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:58:49 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-67990a45e02so1724623d50.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 05:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792069126; cv=none;
 d=google.com; s=arc-20260327;
 b=B371lVlMWAlMceElk3NhsWq5t4s0weScPEmqYnPLAdsf8W6EJrzcGLR8PN7rdRFAS3
 HY74rtsnlg57mtZcK83BI5h+7Ym3kk4Oa9112NndZkfnkUOtG+jgr++GxRosTbErQ2T7
 TIGarsUYSjstEX/qA7NPJynx6aDuFmU+PJ3kBcjZRgHluu/ruksrJTIoVqwli0tOrU34
 eq/cK5ZGuWJvDTDraY6bsuEaf3tu1szwfx714bCCROwuCTX/2tQtiBGWEWRJojQg/s1S
 w+MBHp8zVzaLAe1rd9U1KlHt+DzlS3uAC7SmKNPmyanMDz7hq+9GT4JiztDh1ldosBRi
 xQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Y6dYryj+plDWbkbSNyxktgN1TwjBiV4Lix3Sp+BV40M=;
 fh=Yrx4vQe00BZsIPxO4F8lg1/YapBrjycVHbvHsbUERps=;
 b=F/0BwxV7dvuK4L+LgJ55918GAv08GMLd/1fCC4kfEOHQzY6ydaU4v/HDRb71Tke2l8
 1OuqSXe6R6y1iWqM0kxIrt4if65Xkggx0BEKwC737t0Hdp1MQg0q1nWIJL8NzJpru0mv
 78f73axmFUSPoeYs4nn+Z6wPT00Uf9So3Fe95wIQMfsQcbK9QF6bOFiDThcmNPygbgd/
 p2u4UL4zMGucsiCynAwQztSaAhA/Lpb1phA5HWQ/A5ElHjpHZR/YlRS5O+9OEdB3upFQ
 rGycGVc9HiOKHqXnNi5YUhh/jp6bWYljC+/kmIV3f5FqsFd3fQiy+mG3hUGPbzh0ORwk
 1KbQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792069126; x=1792673926; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y6dYryj+plDWbkbSNyxktgN1TwjBiV4Lix3Sp+BV40M=;
 b=jm4WvL9UVqm8qU8Ku//R136s4SbOvZxks3vG/OAd8ppB9CLY1pkHWhvVFBxh/IfNvB
 MbTE3g5JPQaEBoZ2RISVJDaYare1r2siCW8FVSN56w8PBXa/6t7i7DWnapXfQYeklD+Z
 6dAsEVjEP4G56hSKDsz2E1lEeLaXpucdcB0rbQohy7bKyr4O0/tS31UuCTpX+meg9Miw
 oIYk7ozVmNaITpubepJTkkq/4bevJ0qCxrOUZe1WUvuRKHQ7bywsEDaINYtp2J5/O5e1
 9F6AUksnewwrZvxgvl7arXFHAcrTsRrAEZCuL9cCQB9zdoA3ikp0vOeYQYSs24sJr939
 /aoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792069126; x=1792673926;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y6dYryj+plDWbkbSNyxktgN1TwjBiV4Lix3Sp+BV40M=;
 b=RDX+rBeHPkNePcmPhmZ8TQtbnrEqqtbRbGY4VfEBXflXZ0pJ5nY/2atJZBR6/O4bVK
 n5hrt8RDeodvQQc6FOMD1y9BJrep1f8zjdRj+HhkiuYKEQ4QnCYw5BRQz6f94HeZlqGB
 WoakC4tfPaoVWg9dnZKNkZkufUywKYvNaMYl8RlGEsV0dlk71WXunjAuLBYb2uiAC+bh
 3SagL+l01e2oqDtZcevbhMJNLr+Y2Er19zwnfqrI4HuonF4Ah8mA+lHiYeTP3jCsX0OA
 wkEMQYskPMd66iMqRfcvNxN70JdUImhV8snrk2Fpf7hcPhmUpA9C4IYr534LC9PqeVI0
 sDEw==
X-Gm-Message-State: AFq9FYLPZ/AF0G5mHuRPtydggQ22thqhoKZogFNT7ujMgE9GgW19K+1O
 isF12xvqd6eA67BiWJ0/rlTL4LAdv9i55Z9XqlPfsGKVa6TwllVi75Yf2LUdDXCfTqMNU6lrDnH
 eqm8seJWDDLeewMIZ1MU0LqrmLVZ8oUmpzqfPYQXcDQ==
X-Gm-Gg: AYBFou3cL18uXLR/WuvK3GKdDq4omignGJj16AB9n3f9utZt/WEjlQ0TJhFFLxFZVIu
 oDk1egy5dUp3NRd1IMoA0q6trW1bCQkWU/0FfBzdg7ik/95p6qXGqBoh6upvGc1YmXt5nTt6c35
 PWv+hg/dBLB39UHTcbHZnPIy8zEBkT3i7fCUNgJHwwCA5jrE0eIMHlK3jjY+iUR2GjzcNhNM3QE
 +D6NcWaHYyv5j+XdYlKN+RSVEj5IU5WFMH1bBAAh+vykX8uSHILMmZ+o0hdVsGSPfCcfvrqVFw7
 R4jVN9igkWjkt68Ptj/Xu7iYaZLKEm/di0BcXS63LmTHA4rJaSOWQa+uxNTTYQn7f5Qa+lc510i
 F+rhMoToIhzL0guamZ7OuDawxe3rcCQVQniXL4/o=
X-Received: by 2002:a05:690e:e82:b0:679:a2f4:386e with SMTP id
 956f58d0204a3-679a2f43a01mr489584d50.9.1792069126353; Thu, 15 Oct 2026
 05:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
 <20260725012635.4925-3-marcelomanzo@gmail.com>
In-Reply-To: <20260725012635.4925-3-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 13:58:33 +0100
X-Gm-Features: AclHuK_2_79LIMsj823fFKwdwiEyEow-A-OBXYTjuA-vQWmhD7Ee4CCQ1lV0jIk
Message-ID: <CAFEAcA_BfVKY6eU_7O6uw=NDE0VYCU_ZVDdXcgZULnT-ztvfzA@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/arm/bcm2838: enable BCM2838 RNG200
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Sat, 25 Jul 2026 at 02:26, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> Wire the BCM2838 RNG200 device (added in the previous patch) into
> the SoC: instantiate it in the peripherals block, map its register
> region at the real BCM2711 physical address, and connect its
> interrupt through both the GIC and the legacy GPU interrupt
> controller path (matching how the device's own realize() wires it,
> mirroring the pattern used for the older BCM2835 RNG on raspi0-3).
> Also stop raspi4b from masking out the "brcm,bcm2711-rng200"
> device-tree node, now that the controller it describes is actually
> implemented.
>
> Adapted from patch 16/41 of Sergey Kambalin's Raspberry Pi 4B series
> (patchwork series 829638) against current QEMU master.
>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>


> @@ -82,6 +85,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
>      BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
>      MemoryRegion *regs_mr;
>      MemoryRegion *mmio_mr;
> +    MemoryRegion *rng200_mr;
> +    qemu_irq rng_200_irq;
>      int n;

These are variables with the scope of the whole realize function,
but they're not actually used more than once. We tend to prefer to
write this kind of thing without the intermediate variable, as e.g.
  sysbus_connect_irq(dev, ..., qdev_get_gpio_in_named(....))

But we already do this in this function with the mphi_mr, and I
don't object enough to ask for a rewrite, so:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

