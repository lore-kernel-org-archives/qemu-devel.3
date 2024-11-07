Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC8BD43367
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 14:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t93Lu-00037I-5O; Thu, 07 Nov 2024 09:19:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t93Lr-00036s-Pz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:19:11 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t93Ln-0005B8-Ts
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 09:19:11 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539e6c754bdso887816e87.2
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730989145; x=1731593945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrU7JtnQpJfpKvgjf8ImTJz+wPnBRZpkFW5d/kkrvwc=;
 b=MPgr6KC2vvhYByqtwQFaTlg0tf+/vWVJmvHnHSJswkrY81ExmIW6v0JapO/PYENa4C
 sQuM8mTMups73xDkw3JVCK+pH2l1uWSTZGqTeMake9+bAqEn70+iwPFd80sxmNvuLOfz
 fppcdtkNiYrz1LtD+yvfYXJFEqEpltNq6UdfUxbjG1VXCYadkAODEXAAgnyun29I9Cmu
 +Qs6hGPavbQey5qxe3ggOgLYGwQDwnYOVNCq4IaiAGdM1vQUeIgH1ypCcDfkt3z2LPS3
 QRDyFBY57DBrwPLI1F3jv4dWsMPHDuG1D+L7GNk8Tz9pYu/4HU0OAWPqHcgSb+CJ79t8
 9t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730989145; x=1731593945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrU7JtnQpJfpKvgjf8ImTJz+wPnBRZpkFW5d/kkrvwc=;
 b=Im4lkJvt1RPkbYKxbA4PcQuCEqbKyTAqbPU8bnduEQo6eh5QERlUb5G5uaMb309gjo
 3xoASob2cl6+Ik7ko5JmqkKAP7Ks6s0EnF/uJp/uwkJ/cHcDyt4xDpODC5GU6oMnNil+
 qL0qM5+9TrFp0jpM0rV/YDvp3M5aU9RHjsUUvEwg324jfMusleHCrzpTTjFZD+JHMfeb
 +gwZjs8tyT332NbT/DnkorGCJ32TUePLUB3mkD+EOpYbD0xEGF3lOkc9e3JdUmlJ6F6m
 vTKpM8TsW1qHod5ndE2Weeb6aS1ZM0qvg7105bTWuQdQkgsUgwmkXUiPqDu7D/S1Ck6O
 503A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhzV4zvo8xSMHnzHO7m6BlGA6IQrcf9mYg7o7AXJsjboWPxInGO8/1QuLipTHvrRJdeWfamJEsAqNz@nongnu.org
X-Gm-Message-State: AOJu0Yy/1J0QVoqLjcio4uXcbdgEyP7IqwDdNRM0H74z38umnSWXXqr2
 rEo2WyAI+GgsGUWix2Q+vK0oAN85vTPzu6JtbGc34WoeDAYAj9YDZ9eBmKMV1BALn6smg+gUDoX
 p5u1ixVItrtDsLTc4ICUuKHvhYx7Jf7lVvnS/uQ==
X-Google-Smtp-Source: AGHT+IH0RJFjPb1JwCF8jir+KmP9wPddavTWFnNG+nSrRXy9mNG4SVtDYrPiF5IjsS+dd4TRAWLLg8ElLmTewPpvtB4=
X-Received: by 2002:a05:651c:1602:b0:2fa:d354:1435 with SMTP id
 38308e7fff4ca-2ff1e7c9011mr1630691fa.0.1730989144699; Thu, 07 Nov 2024
 06:19:04 -0800 (PST)
MIME-Version: 1.0
References: <20240725235410.451624-1-npiggin@gmail.com>
 <20240725235410.451624-16-npiggin@gmail.com>
 <49b1d57d-e0bf-4b64-b6ef-3cb4e1da5d65@kaod.org>
 <CAFEAcA869xMGhB+K1x722CL0bD0a55+oWofpsW610HSycz_Yag@mail.gmail.com>
In-Reply-To: <CAFEAcA869xMGhB+K1x722CL0bD0a55+oWofpsW610HSycz_Yag@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 14:18:53 +0000
Message-ID: <CAFEAcA9pNo4Yyt42msbs4jqk6xACziUMSfeNnxPt-WWpRtn7BQ@mail.gmail.com>
Subject: Re: [PULL 15/96] ppc/pnv: Implement POWER9 LPC PSI serirq outputs and
 auto-clear function
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Glenn Miles <milesg@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Tue, 5 Nov 2024 at 17:35, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Mon, 29 Jul 2024 at 11:11, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >
> > On 7/26/24 01:52, Nicholas Piggin wrote:
> > > The POWER8 LPC ISA device irqs all get combined and reported to the l=
ine
> > > connected the PSI LPCHC irq. POWER9 changed this so only internal LPC
> > > host controller irqs use that line, and the device irqs get routed to
> > > 4 new lines connected to PSI SERIRQ0-3.
>
> Ping! It looks like these issues are still floating around...

I just noticed that they were fixed in the pullreq that just
landed; sorry for the noise.

-- PMM

