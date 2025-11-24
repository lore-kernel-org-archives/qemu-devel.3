Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA219CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:29:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTok-0000Z9-Qx; Mon, 24 Nov 2025 05:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNTmm-0008TF-Rx
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:27:12 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNTmj-0001h4-L6
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:27:06 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-63f9beb2730so3128674d50.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 02:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763980024; x=1764584824; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IH+tVktUvnIYfS+s5xTGqoXsukiAMNrSam2SRoNxLp0=;
 b=UX1b+5EmUIwD/LQ9rbGwhKwacOHQLLYr12sgpr973YQvwpKghpr1kYnRfJxI5wO2gN
 l8gswmkasIcfeeY3KV3S7/gqmcuznpLAxdIDEeWX3PoITu+4oFWObCXbhg/BXtBRKv42
 6KFrTij9cloevMTIMQHj7Dj1Cl/HjY2wxfpVjiMgc1LuulI9jZj9QzSk1auua2jn9i6n
 IhbQ79tdb0ljqZcaA9qAfw2fQ7T8o7/pW90yEVuErzeI8Oi3RRUDCTj5qHan6iBONjdm
 UOybq5b9iI/E8uLqpi2GOnkvv4IX8muSOeJrYKqFZJPPSPVS2KftFclqJ0uszISLLjye
 ewRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763980024; x=1764584824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IH+tVktUvnIYfS+s5xTGqoXsukiAMNrSam2SRoNxLp0=;
 b=FTAzqxnLycZj3FUPnMJ8oMY+A7SsS72bVTdbBZ/lFP3W/MgJznybsLme7XqrgJOB5X
 lORTHx+6B6Wl1z1SZBZ0Uzz77OMq2jcNVRjugrrIxUIvPxtFxSpvA0SxHxdVORoEqccF
 1LPR2oz7F+EAl4MQaF/kZ3z9sK8HCHE7sTOkjGkydEA48t5y5ECDcI9ZTvyj81uZbw14
 tHQDB4cO2M7O4UmgSKUeIzRBQ8B5ZmKvXaRR/gdLU9cHhpJRHJeiijWxmYV994vy0nSL
 Btel58PzmwlXUf0kdxCvEjPnaU/PDvFIqZdewHD8mL5H9Aa34+MkCLjHXTEI5m4+fVvt
 mj4Q==
X-Gm-Message-State: AOJu0Yyuq+SZ6W6jAA+iwpGxWny0fdtsD4nhsTy2Q1vbda9kiqrqFTO2
 mpon2ggrenE6CN3GrTTQ2Mk7pzSJ3EaAccJtttYP0+MkMrZOIzyBS1S7W+B9Fb4ZkiI8GBonFqa
 P5obkGXAA1416MEkGofuK94DgQs5D0ivmel8i36Za3w==
X-Gm-Gg: ASbGncuil8MLeIbTNbWO7FYEidc1ZhbnznmEXmsTWFUJrEm459gSn2QRZnz/WfRmK2o
 LOu7cHYUv7AtmFcMLEcyQ38a4fMPwKTs6Lyv0VA8WFqvFNiO1Kt0aj6qyjSP32xxi/trvNjbh+j
 GmiXsdDCh6y1eN3him+tSHNFdndkmky/FOKdVIjk+izi24tYoqO8H51WSnpUBPt6kTkz8ZzGfd4
 dqSg6tQA7TI3xY9gHMO1JoZqtHRbScxwCVAjfGd5v/Kol3rIqmPCSCm0XYLCA6StX5ikshM9Qml
 qwBJMaw=
X-Google-Smtp-Source: AGHT+IHLvF0XUMkdzCYS7wNsFiewY9ZPICNofUVb0vrbbFFwhNEmm3Nc5Sz9bfxwKdoQq0ZKQTUxq0ngYggKVztaxsw=
X-Received: by 2002:a05:690e:d8a:b0:643:79b:fb1b with SMTP id
 956f58d0204a3-643079bfda1mr6196627d50.21.1763980023760; Mon, 24 Nov 2025
 02:27:03 -0800 (PST)
MIME-Version: 1.0
References: <20251119203759.5138-1-shentey@gmail.com>
In-Reply-To: <20251119203759.5138-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Nov 2025 10:26:52 +0000
X-Gm-Features: AWmQ_blpWYofeSl5Nfpn4qBG3wJ-LHn3DxvM2zqvgF4u7cdi9xrle6lVf8P7PEQ
Message-ID: <CAFEAcA893XcTzwwivboB_T252mwFjH8jQYh3PJbkkyXijgV8kg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/Kconfig: Exclude imx8mp-evk machine from
 KVM-only build
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Wed, 19 Nov 2025 at 20:38, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Fixes make check failures on an aarch64 host when QEMU is configured
> using '--enable-kvm --disable-tcg':
>   qemu-system-aarch64: unknown type 'arm-gicv3'
>
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Tested-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>



Applied to target-arm.next, thanks.

-- PMM

