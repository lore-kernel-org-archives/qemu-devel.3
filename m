Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0459CEE342
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 19:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syc65-0007UK-J7; Wed, 09 Oct 2024 15:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syc64-0007Tr-6K
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 15:11:44 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syc60-0005cn-Gz
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 15:11:43 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9d2195eso83447a12.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 12:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728501098; x=1729105898; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C0RUEWrRv7rtEVdW/RebQVbtGax3Ed9XzDJhLIOA66k=;
 b=mnoY0Db11WW4kZXoW0BCEqPx0ij/pNisjONf3xf8O0TKKrPt2qUXHBBpF29OOtPf8x
 3suRF5yS/eD5rJ5etUFXGWQ384nwsB1XCdWo7s+hZJSVosWvcNnQ8jm+kf597SPxoML5
 PxvC8qW7uuukP7YEiGzekgwzTRJ3sWxoN/mXhQ0l7tcBj/ezeq/QYKC1O6d/mv3xIhsC
 EHx0Fr/9G1N3HPAo9GXyo9wANVFl96ugFAWt3EKKuU+OtGFo1cWK9seA/JuI9nHHq2A0
 xck0voJZPSqRKxakwpW/PDMUj7dm+IxxQBMa7JXEmjcvzckBarKqqer52BUElyFeWC7P
 QPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728501098; x=1729105898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C0RUEWrRv7rtEVdW/RebQVbtGax3Ed9XzDJhLIOA66k=;
 b=vylmNULBPNPS3Ef6iTNujbhGrRWL4OeUYgJb/yWbiz4CEohuavt//o/5vyuD+2UECS
 rSs5JaZfC21hHYG/n0n27f90yyfQiaGsFZ7Qtx+ya5d2PXN1AW1JMpA31he5osE4Lamd
 AETH3jfeXGDEmr42IOeSn6bsKIVK4uTcHCjhZ++UJmxXikSFbFeWu6O1qk8OzNn/yzYI
 L5uZ2a88QoXvpFt1SKutgacXBKE4gUx/b+N3mF/xCssftbo741pD2VM3DZtNubMbXRi7
 xEVIebJM9Ba9pRaAKP7WX1V7BLCTJ1eYKjzzIDsXiO51wojwe2NRbjt26kqAoyX5Qck/
 ZEyg==
X-Gm-Message-State: AOJu0YwNMbmz7tAMio9mX0bZ5FOBVYCqY1HwDE7oiugETG706B78LPoS
 verVHQcJM3BUNQSXEuRJATelwGdVy36T2X8CKCHEkctbAxS7rSe60tYoHDrZlOb9XTfd0Y2bEhf
 uaxnKlSXaIOAuTwVk65Xif4ZncnvJ9vO021uaRA==
X-Google-Smtp-Source: AGHT+IHABuDv9IX/UVRUQJ0WOz7zwQ9aoSS9UXWMVSd3qIJAXZYVx8sY9zK5sxCDgic235unH/8ZWNbN1Jdf3yON5yo=
X-Received: by 2002:a50:cb88:0:b0:5c2:5438:6ea with SMTP id
 4fb4d7f45d1cf-5c91d5a53c8mr2538769a12.19.1728501098215; Wed, 09 Oct 2024
 12:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241008141337.2790423-1-peter.maydell@linaro.org>
 <5f6f6e20-988e-4455-bb76-34416463c930@redhat.com>
In-Reply-To: <5f6f6e20-988e-4455-bb76-34416463c930@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Oct 2024 20:11:26 +0100
Message-ID: <CAFEAcA_09nCSKHNL0=sZvUxR6HvY=PeG-hYSB_wv_FO_k+kEdg@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Bump qmp-cmd-test timeout to 120s
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 8 Oct 2024 at 15:16, Thomas Huth <thuth@redhat.com> wrote:
>
> On 08/10/2024 16.13, Peter Maydell wrote:
> > The qmp-cmd-test test takes typically about 15s on my local machine.
> > On the k8s runners it takes usually 20s but sometimes about 60s,
> > because the k8s runners have wildly variable execution time.  If
> > they're running slow, we hit the default timeout.  Bump the
> > qmp-cmd-test timeout to 120s to avoid this.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   tests/qtest/meson.build | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> > index 2b90abf0007..b207e386965 100644
> > --- a/tests/qtest/meson.build
> > +++ b/tests/qtest/meson.build
> > @@ -7,6 +7,7 @@ slow_qtests = {
> >     'migration-test' : 480,
> >     'npcm7xx_pwm-test': 300,
> >     'npcm7xx_watchdog_timer-test': 120,
> > +  'qmp-cmd-test' : 120,
> >     'qom-test' : 900,
> >     'stm32l4x5_usart-test' : 600,
> >     'test-hmp' : 240,
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Applied directly to hopefully reduce CI flakiness.

thanks
-- PMM

