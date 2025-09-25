Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CF1CAC5A7
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 16:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1p4q-0001lz-Ro; Thu, 25 Sep 2025 12:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1p4g-0001iQ-Pl
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:44:10 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1p4a-0006lo-Ri
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 12:44:06 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63470a6f339so886147d50.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758818629; x=1759423429; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Avz+VIlvR6gz7e9l6LC4wxdknt0PmsqW3o1KtO4/JTs=;
 b=qQ7ImcTuRWEtV2U7GObNLEmOWrTffao0VluL4e2/iJwmm2vWItYgJLRX1l/UhuckN1
 dSKRgdTRu8LJWRb+SOdSXAJCqjileQuiFlGda9o1l6hd0ang/VYfVxTZ70fdkfNuL/oC
 2+OIS/6PSSZi+CSMM8McIbuZc1xdbRBI4jZtuQPeKHDpRqZ4zCUogTp5wd8xlTz1jXJC
 c8VHa4UKba3eoF80RfnwrpMSedi9KvmGWTxC5Q7Din4Mdhn9QC+BGQTaLc4X10disIuO
 MSGcLfvycETdVOlHG4hFDuIvzt/4xodGaNo1VNg+d0J/znVkD14py6UAT9YadirxSglY
 k81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758818629; x=1759423429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Avz+VIlvR6gz7e9l6LC4wxdknt0PmsqW3o1KtO4/JTs=;
 b=cWgp+UQw1jDi5TgW78nY0gClYy6OSa2eQeWkNTwR7Ji1HnQ9hUONDR51bOLMRO6Myj
 G70CvEdBXWvBB6sn1uHnp5R7qnyuaTDfcbx8n/sTStjrT/kDLn4A9ynEHpvbbic2kDlK
 PwtGxPSYO/aRcnWV3bn1zDvupHW7fONMEkhEkvSG+95ejG4kN3wHSswKdIHz6EzJxWu7
 GZNKrvrO0fTlwMt/HcdWnhs3vFCdMxqJ9Be9iP3yokFJ7Y271d5uCPAj8EO7mIf7hvk3
 WYERQpy+2Z9lpsPnxof73DLNA4rnLZYLWqhvvUDG8FevPWOTux43aWjw21TPV7h3s4Pv
 xNEQ==
X-Gm-Message-State: AOJu0YyDNQDT+v1MEzKEFIbMA9eY4sxe+3vr6Fr23q6sBTPYXo8EToJb
 wtbUvzkySai+MYSS4O3xKTSwwTun+Clp4Slndgzolc7hfo1QYqwyY01dF6mekvhnd3EJBqJIWn/
 l9V2RZghjI6P2l9gGogVtbvhHA3mXWLvY2cRNc/gLEw==
X-Gm-Gg: ASbGncvPn7/eZN3Bx5Jmk8EUCELWFePvVPfxqy7BqfmSV4HYwh2Zbe22ZiJsRUykPGf
 UISRseXAnZy/YPST0HpZyBvzQZamytM0J8WghzLbNMs/JRI8uO8Du+Ez40Xk+dCCfx/QJgtw3XP
 58f0fxZmdvWd767wKGS49wl4i2TCtf7dHZZ21POCeib0eV1gJyuMlWSaS/7U59lBwTLdky/AlwI
 lCxII8Z
X-Google-Smtp-Source: AGHT+IFo4N3STM/hEupT+btF/XkiU+0i+kmTaZpKHdBmrHj1u2vnRoXgC4Wrmrs+8toimMGJm7XrzhXc+aEYipimmfU=
X-Received: by 2002:a05:6902:c0d:b0:ea3:d862:9ce8 with SMTP id
 3f1490d57ef6-eb37fc0f818mr3999528276.16.1758818629172; Thu, 25 Sep 2025
 09:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
In-Reply-To: <20250909-pcie-root-upstream-v1-0-d85883b2688d@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 17:43:37 +0100
X-Gm-Features: AS18NWA8HlYr7KjDJs9TVn_Zge2w8KC87qQ0NZn3Qml_IoBa1ltN7pZTctfmM4Q
Message-ID: <CAFEAcA_ha9tN7RZ0j4Bn+_wXksiYxvwOLcx-egnckk2T6Vx+gw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Introduce PCIE Root Complex on Nuvoton npcm8xx and
 npcm7xx
To: Yubin Zou <yubinz@google.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, Titus Rwantare <titusr@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Tue, 9 Sept 2025 at 23:11, Yubin Zou <yubinz@google.com> wrote:
>
> Improvement to QEMU:
> These changes enhance QEMU by adding emulation support for a new piece
> of hardware, the Nuvoton PCIe root complex, which is prevalent
> in both NPCM7xx and NPCM8XX Board SoCs.
>
> Impact (Before/After):
> - Before: QEMU lacked a specific model for the Nuvoton PCIe host.
> Emulating platforms using this SoC meant PCIe capabilities were either
> missing or inaccurate.
>
> - After: QEMU can now model the fundamental aspects of the
> PCIe host controller. Virtual PCIe devices can be attached to emulated
> NPCM7xx and NPCM8xx machines, and the guest OS can interact with them
> through a more faithful representation of the on-chip PCIe hardware.
>
> Signed-off-by: Yubin Zou <yubinz@google.com>

I have made a few comments about general patch structure,
but reminder that Nuvoton-interested folks should be reviewing
Nuvoton patches for detailed correctness, not assuming that
I will :-)

thanks
-- PMM

