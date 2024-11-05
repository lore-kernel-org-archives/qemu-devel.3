Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB48D2B92E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KSY-0004XN-Hf; Tue, 05 Nov 2024 09:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8KSV-0004Wn-8U
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:23:03 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8KSP-0004rP-PQ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:23:03 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c94a7239cfso3335174a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730816572; x=1731421372; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWGoG6ZzrPxyArmuXwECddf2LDtCVJBByXZPcI6uoYw=;
 b=IJDFcAbriA8IBNatCBCuAMUAzLwIuBsorFpbyDm4apnDSYpWC8EsPD+BIdmwSNMeuN
 fZWwwixHxm3LLtLOuwMMDNTCsdgKU9Z7u+K7IV/MQGWM22sS2I3ivsPJz/WviGt8/q2Q
 YG4g12YqhEV8y57WLJWu6LZc9BF6kw3rOHjq0JJBYrbWnVaZ4lCl3kO0ofabzXk1uAda
 PqwrUyC5MQuTlobBMvRh+sAGsyjDXlhXo5jZQH4wYTvxl5OVlpW3BkLRHxEnXKxLDA7E
 v35BDY/IydbiRk5QZyMvDxdAJRvWyfD+mogsCFFG2bVA1MuuzIjP1V2qaxnsnwjU34pW
 3jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730816572; x=1731421372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWGoG6ZzrPxyArmuXwECddf2LDtCVJBByXZPcI6uoYw=;
 b=DrGKk7o3uwu7IfTT4ORx+F0HZTw+OLZ0b5aGpk68wS0VafrLSsLaLgGkbQ6jiH9L1Z
 XUEkof5VBT6FE+5IbMwTkShYzss+sQPsuLD6r7KXF/m6CMxahedRg8IwFAWOX5nQQaY5
 02WJ6vBvpyz+iV9buKJds5wfVmLlDOGWDs86Y9SJpWom3y3++nzyu+2/2Tkd1kQAydqv
 yOoaMoV9DvZha7j232L2v3E6MzxEaDEvO3ltJojv7WPiSmic5j4XZ/7SmuOCS3BD4YHy
 xZMTVSyQLLl2Px1CqUpzv7h5gNI1FjtpjhbQcvn/8wDP7edVR7f6jqK2LB6gP5xrZVg5
 jCiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcOZIi+/NoX8j/57zs2kxWMXdz06IH0uCsxhFFP2JLuJicWKnWMGAWOyEHFJ3umOAhQvEVLljcZuVQ@nongnu.org
X-Gm-Message-State: AOJu0YyNfifdc/nrJri8c8O4HNGlzXORzaSxG9abHteSzfoeN0PLf0c0
 w4CSIeUrWHafRSzmb5BtWMiCbrBf73ZzncSCuQ3kmRpCDPneK60wH7M4Wso/PbWA3OxSQrjkdZ4
 +3/K7SL4BW1rJoFuRP9JqN5iLgw5ArO3YEJauGg==
X-Google-Smtp-Source: AGHT+IGUrx9hzC/zEe6+1TlVBod6GcFu/wZVkgV8TE+zpS7qrPASlRquojI6zQgRuRnXCewle5pUTy0ArRdSdSntuiQ=
X-Received: by 2002:a05:6402:5215:b0:5ce:e5c9:4491 with SMTP id
 4fb4d7f45d1cf-5cee5c9455cmr3558343a12.15.1730816572306; Tue, 05 Nov 2024
 06:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20241104101501.2487001-1-clg@redhat.com>
 <d69c9a35-8044-4b04-ac8d-6d47223a961a@redhat.com>
In-Reply-To: <d69c9a35-8044-4b04-ac8d-6d47223a961a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 14:22:41 +0000
Message-ID: <CAFEAcA8qj0e8LHQ_TN-c7H2bS1BD_Fd0ddBYyVBT5BKNWZM6OQ@mail.gmail.com>
Subject: Re: [PULL 00/10] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 4 Nov 2024 at 10:39, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On 11/4/24 11:14, C=C3=A9dric Le Goater wrote:
> > The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c152=
47bd:
> >
> >    Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/ali=
stair23/qemu into staging (2024-10-31 16:34:25 +0000)
> >
> > are available in the Git repository at:
> >
> >    https://github.com/legoater/qemu/ tags/pull-aspeed-20241104
> >
> > for you to fetch changes up to 8df5fd815e841bf33fb51e1e6e5be9c31d529b94=
:
> >
> >    aspeed: Don't set always boot properties of the emmc device (2024-11=
-04 10:12:02 +0100)
> >
> > ----------------------------------------------------------------
> > aspeed queue:
> >
> > * Fixed eMMC size calculation
> > * Fixed IRQ definitions on AST2700
> > * Added RTC support to AST2700
> > * Fixed timer IRQ status on AST2600
> > * Improved SDHCI model with new registers
> > * Added -nodefaults support to AST1030
> > * Provided a way to use an eMMC device without boot partitions
> >
> > ----------------------------------------------------------------
> > C=C3=A9dric Le Goater (1):
> >        aspeed: Don't set always boot properties of the emmc device
> >
> > Jamin Lin (5):
> >        aspeed/soc: Support RTC for AST2700
> >        hw/timer/aspeed: Fix coding style
> >        hw/timer/aspeed: Fix interrupt status does not be cleared for AS=
T2600
> >        hw/sd/aspeed_sdhci: Introduce Capabilities Register 2 for SD slo=
t 0 and 1
> >        aspeed: Support create flash devices via command line for AST103=
0
> >
> > Jan Luebbe (1):
> >        hw/sd/sdcard: Fix calculation of size when using eMMC boot parti=
tions
> >
> > Patrick Leis (1):
> >        hw/arm: enable at24c with aspeed
> >
> > Peter Maydell (2):
> >        hw/arm/aspeed_ast27x0: Use bsa.h for PPI definitions
> >        hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ calculation
> >
> >   hw/arm/aspeed.c         | 38 +++++++++++++++++++++++++-------------
> >   hw/arm/aspeed_ast27x0.c | 33 ++++++++++++++++++++++-----------
> >   hw/sd/aspeed_sdhci.c    | 40 +++++++++++++++++++++++++++++-----------
> >   hw/sd/sd.c              |  4 +++-
> >   hw/timer/aspeed_timer.c | 15 +++++++++------
> >   hw/arm/Kconfig          |  1 +
> >   6 files changed, 89 insertions(+), 42 deletions(-)
> >
>
> I just did an update with Philippe's trailers. No code change.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

