Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D13CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 19:36:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRxYs-0003jI-TB; Tue, 26 May 2026 15:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRxYo-0003iY-5K
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:35:30 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRxYm-00053h-Bq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 15:35:29 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-651bc83e74aso11251769d50.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 12:35:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779824127; cv=none;
 d=google.com; s=arc-20240605;
 b=Q9Gite3IUnCkqIPa3f/+Ch6bHhmOmfCBprstRmQh2ao8ZXez7XBlFBN3pFZLSciGcj
 0G+BLJ6v5BzLVXlWUyMgFvr1UYa47i57AxFY+nmde4Rfpedq60Ig5O4yJwMDd+CxIXM0
 u73yJ6DlYbUET40lVsgw7jFGcaO24w0R8UGm6nfXApegaa57+TaPyAvkFsAS8LAHlvVT
 HFJpEisEXqrTWCoc8pytu/8DfB1YS9raV3TOns5dE4Ml/ewe+IIjs+ykaOKDYxIu0Y7N
 kRbUDxQBDLF9J7sHlJE1FnwPw5nnyN2Aa9jAQ3lbSbzNleWZ5olr+8RyadZpwlSUO419
 AK8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=6PnqVaY/NN2kfARNKe9yvKSpfkwhROM4WdwQun3RfVY=;
 fh=PsKphPeJjYIi9dqXmYXpxYNjV6k0X4EwqnInklkzmR4=;
 b=O6EMeHmCzocW53oROydT0lUFAVQn5G9v64YEw5oxvE7md0ypxXty6VTaiaXnH2JwVK
 kWlX586ar+TNGFh7C1Tln4ddhHRzwzPxOUuLnuvH4wB4RKP5ro1rEl5cV8aOXF/PTcl5
 5SP6sDeZFxckoxNBAayaX4UY6KMz7JFAEHR4zpanQEjhbzbJmKDLNBtM9rfRAKtz3edu
 /FnTzIBqrtbYuPwvuMrmPjw1yj7TahmnMUkZQGo7yolpg6tl2JirY8+PzFEhbk8RfxB4
 TPiyLL4EqdRy6otrZVCe+rqHMtqRt/AolKElwC4Dt5SIJM2oenokveTxp0pFxjHkVnxa
 KvUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779824127; x=1780428927; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6PnqVaY/NN2kfARNKe9yvKSpfkwhROM4WdwQun3RfVY=;
 b=BMpc8DNO/6SWVzdha6aDIrHXAYQfzd1jDVbl+g0MPUD/iZNbHO+lt1gf4WL8xLQygH
 ngUEfslr4FYehZTezdpca01bMaRr2L0V8SJf62eP1qgtfHUu0/Vh46juxuTVrmTZPK8Z
 4z/B6I27xf6i5Igv0GLkKxgMjp8o/r9HVwk2/sj1bRVV5XxenKde6kzBVzPG88JGYGO0
 XoQ1bFO9wDqIK+7NWqdXg33+qxPBC7Xyy/JTIRzKMcxvfT957XYSkiSCTlk7Rf4DGS1l
 4AJxTs+izuTTi+jCo+cSgOr0Ju50qCDgeUO5y/p1Fb14CptMcKbJ3krbO864W18ZhBAl
 WOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779824127; x=1780428927;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6PnqVaY/NN2kfARNKe9yvKSpfkwhROM4WdwQun3RfVY=;
 b=qWF6KrY6QNRLEq5EIO1hQVQmuQAtzEeiVybF/gOWgDpmxaTPneg1o5q1YDY0Pwzvgy
 YUsbMeS9T22bWmZkIfUH5gH5OfKBlMEEohcpJZFPALNOY4lazU6KuJgDsEEnoyCElFhQ
 TdHe5oQ6+gmoO4Vow4R+TzjcbHqr0pGHkrrw9G8JDB5YYxjZ8zWAE1F7PXxsrOKrpaDo
 BqyM9MLLhmSTDjaGcwmhGCSd08t6tcBPXP+/MOxks65nlanQf1JwC+KsfQCu+v/8weki
 zKlbOUcEO2t0yv5Bln5b89Kr2RuD1PTm6gcv8fPI5zCiLQ2Ae8tqpiSdkmLte+5w+a0m
 WgUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uJuv+G12UJOqUuKU5uMLQtVAat1nVPJtXk/sr/SsqT/+YIrHA+BUSnliTouBc1nv0GT+xOcNTZtCK@nongnu.org
X-Gm-Message-State: AOJu0YwhhX3NoMLnDy1q7lDX93ahl0dZcYTuNnVV9H+Rfkb6mYcwOm7n
 wmGUHor8L4+US2UQqslTdvSa15IDoT6KskcsMRsm4NQFV59GP9IDGnstWVbplKdvj0RAEIBJPqp
 lJyls0M97u/uRUr/suNanv4bDpMD9898P84IATCPw3Q==
X-Gm-Gg: Acq92OHWGMEmbC2tyr1M+9TPKzfuGGqlYIP41PcYEIJKPDrx3Xc1ncRdwIuwjKVoPFQ
 uAzOvTHfs4fZPQ8TGS2Umua6UsGua0A9GeFLaqN7dlWqlgbzYH2FlSOgWXktfMf/Uf8B6DNNakZ
 Ice7h7pEWA3H3mogV4080ThC2G+FBkFnd9F5fRmYlLx8uOghiGO5yQm4g7OHsi7IIYksFjdBN5I
 qiAR8LZncmCYGv5sexc3sNFWsp0oGc9QlBnwDiqUUlNPDKQUckADoQwaYPcdvgdrO+IKmKbnbuR
 1055MGi9+VDM9VlwUgDBAP31gE1enoj6hpVXdyIPeBZ8sBoVcSM3D0wWQr6ewxK68qCYIjHsCKO
 y01pEEvgAOTG1
X-Received: by 2002:a53:b1c3:0:b0:65c:2b92:f8de with SMTP id
 956f58d0204a3-65ec9808584mr15451807d50.28.1779824126670; Tue, 26 May 2026
 12:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260526174155.2491217-1-peter.maydell@linaro.org>
In-Reply-To: <20260526174155.2491217-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 20:35:15 +0100
X-Gm-Features: AVHnY4L3r75_kZNWoOipqsJoijL-re3oIYdX5SBKVTZIMVgYWh1PfJw-_HfyngI
Message-ID: <CAFEAcA-dKxq8S=Mb7NfgRp3060QwokbUkxey5u-XcwB77Nam3A@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Don't assert if 64-bit EL2 AT insn sees a
 Domain fault
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
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

On Tue, 26 May 2026 at 18:41, Peter Maydell <peter.maydell@linaro.org> wrote:
> +    case ARMFault_Domain:
> +        /*
> +         * This can only happen when doing an AT insn at EL2 for an AArch32
> +         * stage 1 EL1&0 translation regime using short-descriptors, and
> +         * the translation hits a Domain fault. This needs to be reported in
> +         * in the long-format PAR. Compare pseudocode AArch64_PARFault_Status().
> +         */

The "in in" here should just be "in".

-- PMM

