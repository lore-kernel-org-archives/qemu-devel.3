Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277B4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCQf-00009g-Bk; Mon, 13 Jul 2026 04:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCQb-0008S6-Av
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:54:17 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjCQY-0004GA-LS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:54:16 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-6649ffb1d01so3751364d50.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:54:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783932853; cv=none;
 d=google.com; s=arc-20260327;
 b=FZmFR+ZmBzcvwt3dPSaT+fneIVbH9TrH8bE+CESF3Q5ivfRtDaUcY2zRqDRa79b6cT
 qqrAMa/DPig7hRzyv7T5CnYDNe95t0Xi6AUHm2UTTvLa6VRdxOAi3E6Fl2c4Fj1fM3zN
 WeOcgeCryfrxV0d6Lzrn4gxnZB7R4xvYBFQtfZ2M+x9Q/YsmvQRAVJnbjalF6SVVfubu
 cWpX05h08fgYgKOz/HlzbS21uRsinqPPMgy/VPfktCtgduZnoM4KZx2lPS2PFEph9+KR
 5EuzBVMu/BaBwaILlSL7ln7VfaQ5ZWyRTuhT1/8n3I13NmqRUOYEPD6kwNvWO9UNp0pW
 MssA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hzak/7szTjivZFmxhLRh8gDxneB6K69+JW+oJN1FumQ=;
 fh=1F2N8ZB6PoyCVvvlfy0Uq2OMiNwo7c4n8YKM5X087GM=;
 b=CBlyOQsiNncgEsAusLJGbCq9LxHugccAIqLJ2quoFFZZfE/8fNmGTK83UkGo0y7INX
 VQXw+DTnobT124X/q2hmGUrox9j1d2cW3s/xN6YOCzkWzUlI5ohpI3GhsSKynwQq1j9V
 F8GKPXG4Om64I5TfrtDg/sNY8O6NWARW9uqFnCw0DW8Lzkt1yNENnRv/jIDMKFXtSpK/
 5zM1w8oo+Jb/O6ohZ9unbvdC9p8gCu8YU3efqWhXXUUYWcGHdXd7xdUaXFgG2DIguXcB
 0yc8jhpLz16wX1lnQ6eM6yNa7iBKq0a0OgyHOX5rbmBi/WDSwOThc9su5kKwlUfG37F1
 I8pQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783932853; x=1784537653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzak/7szTjivZFmxhLRh8gDxneB6K69+JW+oJN1FumQ=;
 b=rqIIcv0NOfBFpUVMcYuhBWP0QNGlSPn5nZ8SHkcpXUipTlCrH2VoSmiBjv+uJB9p1p
 fRMZuwRRDAatZMi3Z+sEhD/iHfstIvPrn6NblKiQv6kp+AWMxW+hMXpC8B/sahvngYmb
 iwMTAR2nhiySnacldB45IjTA/7sKrvDjD5/X0QcZvIBzuBBf/Dqc8HShM6V5RCSmjYNc
 OVH1rYp+KxhzK8n3tznu65keRV6HcvP+7X0islvYWIoF2UTdr5i8vs5swxVGvhTPIfOk
 vnm81rP3o9NFUxVAGIxDe81dYvMkqogLn2QFP8ofuIToFB+qB7Kxo4uvYx1NE3rrEBGB
 qBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932853; x=1784537653;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzak/7szTjivZFmxhLRh8gDxneB6K69+JW+oJN1FumQ=;
 b=f0e42+6a/pfHK1o9mocUFCIO7j8LsV93XL5Ag0aEd1LOMKFyrVqUFR2ldgArLJEJoe
 i8fz4jQ+E/yqcP7Nu9TNtoH7WJPSh3ueb3gjJHsf2t3ErkClKlQlbQhqvhvMPeM6wsby
 UMyN67UqWOUiF/p8nk+JhDRlJ0xNsGr3XfhT+sr8JzhheFKk9iwY6ZxN2v+8Oz8ZP0rS
 n/nEEo+wUlLVIcwWdM+ryxybGyD4W5RKD7pw5ls9Ecm78V1cbsgw6JfifD1cWaZBXpnR
 D+OfwGEwhjocZ2w0TR0rRZkX8asDlJfqYxZpsMNcfF0H9Z/oyM/2TBF8wJWCc4kCIrJu
 Ln6A==
X-Gm-Message-State: AOJu0YxodneKdWK4WW0p3w+eF4elE32IPs13PWPSV/ql1RUMMHZ9qe2m
 Km3p9azC+iZQRTOlaa8P1Kl/ePbEn+oQuFKYNKeTMwvYFAUhepD0YY8oL7zk04xErzegyu5ykWD
 VoBUadNv+XE6P5gWD5KBoDXWhzVFpccPwNQttKJw9Eg==
X-Gm-Gg: AfdE7ckHNllQW1vr4clC+dez1efAVe9KzY93mDWxjp84E9hMZ+yINF/5FBhh/Xxg5z8
 BJ/H9J6F7cFZbVcVTSY0Z8uyBtADW1l1bGynMe67s/5b7g6wfIJ+2lCCnnrNacoUtTTTXwt1XO8
 LVa74lqdr0jhJPfAxuXFEj3PWKbHPLo5BKNHo1QVOqNac2A8Ucqkimx8kTrWtuJ3DL2LTNHi4ar
 a2+knJZ7GM2PyFiP5Aof35h8AVzoU7w0MAyGYZvsrQSVzDTXUH9vxq28ZdfrbKuBNNH80OP0Rh+
 pCGar1eDlRU4DebJzqneRdFtgW95KIC/dN1ZhOx1J84qNg045gLnfnni
X-Received: by 2002:a05:690e:439a:b0:667:9980:6d82 with SMTP id
 956f58d0204a3-667d7c0d51fmr3828385d50.87.1783932852927; Mon, 13 Jul 2026
 01:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260710131500.2323848-1-alex.bennee@linaro.org>
In-Reply-To: <20260710131500.2323848-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2026 09:54:00 +0100
X-Gm-Features: AVVi8Cc_8RswlPwKavUF182A0n0boDX02Ce1rviWFbndFUOc5NI28ny_29kaF7Q
Message-ID: <CAFEAcA-ob0rVwKY6AQ2hzfp4oPFJAVB=EjVXWjCjLHxwROGcQg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/dma: don't allow weird transfer lengths for bcm2835
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 "open list:Raspberry Pi" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 10 Jul 2026 at 14:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The datasheet doesn't explicitly say that TXFR_LEN has to be word
> aligned but the fact there is a DMA_D_WIDTH flag to select between 32
> bit and 128 bit strongly implies that is how it works. The downstream
> rpi kernel also goes to efforts to not write sub-4 byte lengths so
> lets:
>
>   - fail when mis-programmed and report GUEST_ERROR
>   - catch setting D_WIDTH for 128 bit and report UNIMP
>   - add comments that the DEBUG register isn't a straight write

You dropped the comments in v2, so I've dropped this line from
the commit message.

> Yodel did some digging into the specs (see discussion link):
>
> {A} AMBA AXI Protocol Version: 2.0 Specification
>     https://documentation-service.arm.com/static/64256e84314e245d086bc88f
>
> {B} BCM2835 ARM Peripherals
>     https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf
>
> [1] {A} (p. 10-2)
> [2] {B} (p. 51)
> [3] {A} (p. 14-5)
> [4] {A} (p. 4-3)
> [5] {A} (p. 9-4)
> [6] {B} (p. 53)
>
> However was unable to come up with an unambiguous conclusion without
> testing on the real hardware. So in the absence of certainty and for
> the sake of addressing the DoS I suggest we merge as is for now.
>
> Link: https://lore.kernel.org/all/20251111105429.3993300-1-alex.bennee@li=
naro.org/
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3201
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>



Applied to target-arm.next, thanks.

-- PMM

