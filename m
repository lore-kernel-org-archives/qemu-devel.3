Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B39C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKdg-0004N6-Uz; Tue, 20 May 2025 06:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHKde-0004MI-Ht
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:56:02 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uHKdc-000193-QX
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:56:02 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-70cb334de0cso29236617b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747738559; x=1748343359; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d56XuPPi1HP2EPqByeAtI9ZEpb23Z+LV9ArzkamKZHM=;
 b=wKdc5sFFC0UsmBKAUpDcYCslHnNIacGdJRtgLZ8mz3iOg3QBHFmRDSWR1UU2GFKsMy
 7JZkYFWIM8lINSXUhdxxh98q18SHJrRwPjwaW3c9BrXP9qErckLwPKpTRgO3Ibitvrlf
 J4vSBHDI7XR9VtPA0TGG2tzXv15OSELCmS/3ZHfNdx/XhWe1Mx6jd0rJKgUeNtDYUc0O
 2evZWZR6vPoUwsCe5ajmROyXttuckGGhcn/ufKrXUCpc8RLHQ+fdIpwUcalfdVf7Cevw
 5zuqs+ZV+IAQWAbPuzaPQL4g42dNpvG6LEa+0tt52nvHwge4xXaivgCGkcIvb67WF5/A
 oDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747738559; x=1748343359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d56XuPPi1HP2EPqByeAtI9ZEpb23Z+LV9ArzkamKZHM=;
 b=rtcl2bGp4Q0+ShmmwQq9Rlb/HhAspzXX2ZXbwXQyeVMLFgjGsH+LAPmFEPnkAS/a7c
 7Q9EB2Tgw1BG+3HIj3FHywRu5P6XC+UKM5KfScuB/U/x2eAxTItC+jk/I1eCloXzxYqu
 6MnLF5j0W7Bauq0E2S28rJ+MkY7PTeUChaxMc+Gn2gwns4dEv0kWEYh1aBEG5ad7h7EZ
 L1q5jCcUQODwIdzomgRLqVXUC3TbjESIXgATvdlib11gG02YGMHOzzGVQzt7njQoxyBM
 dkXcgUZylftQNJouQcM4rzBSlJZ5OlEINEWevsuh/AZq/hdlQhc8tcwgBhD4dmUGNteM
 9+IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLlX9hzkPtDy1V5KDGE/XAt2CfwCTt4mPX4DujKl7jP9C2R+hnvXDproSAwwl35HspLezrVr3usGQH@nongnu.org
X-Gm-Message-State: AOJu0YxjHh5cYnE3p2d8qNs3JKrexiSCaPaCl+jKZ0ljWeBeuJvcRpxz
 z3G9jzS9+cti4By9tHpb9vdfhtUyEVXMgnWfWAq6Yk2tz4/qyVs3qkwZ7/AW8hkJ66f/f98aze+
 83I46M/SI9Zw+8/ce97IwMXDmbq+4KE3BqN+aN2M83g==
X-Gm-Gg: ASbGncuBh5i/5Zdu3kAk96Xap7F+okpo2kSEJu6e9Ax/AK12njmGZ30LShsyohiQKp2
 LTTjvxOhjzV+3joEqTc8WDEKOjdFv6GW2TNJXfOMgwLVBFNE5W0kGpYXRUdC5zRfPGsq5jteJsI
 7ESnCZEoa5fnA+jUK85/zKXe3OFtk0AIHdQ99HOfzo2Fiq
X-Google-Smtp-Source: AGHT+IHbX85FjHQ1ryzOqIq8Vw1anY/OmP5dmTpu5cKIx6nJNiDF+XWk6sLVirv+EI4x0bJog2nND/UAk4aJGNeWs/c=
X-Received: by 2002:a05:690c:74c8:b0:702:5134:aab0 with SMTP id
 00721157ae682-70ca7baf406mr259144617b3.32.1747738559451; Tue, 20 May 2025
 03:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142050.3642741-1-linux@roeck-us.net>
 <CAFEAcA-zPwJrq3oQk3MRp9ZCyTzDOg2-Je00v20pVzrKe8he6w@mail.gmail.com>
 <5d350a95-886e-420c-8b0d-a3be57b9490d@roeck-us.net>
 <CAFEAcA-9MCRfHb+O-qdMHAOgSVEUY26h7dUzF-yaF81oFZHs4w@mail.gmail.com>
 <TYZPR03MB689654CB39D47E3ACCC24A29DB96A@TYZPR03MB6896.apcprd03.prod.outlook.com>
In-Reply-To: <TYZPR03MB689654CB39D47E3ACCC24A29DB96A@TYZPR03MB6896.apcprd03.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 May 2025 11:55:48 +0100
X-Gm-Features: AX0GCFuER6MgQpEK2WT8SOEamRDgQgQTgmcL8dbc6efsCslvLIqKHkwlMIosPto
Message-ID: <CAFEAcA9fvhoxABfY1kgDg2Xa7ZVpYfA0_9wwi3MkDfUJZ6U18A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
To: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Hao Wu <wuhaotsh@google.com>, 
 "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>, 
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>, 
 "tali.perry@nuvoton.com" <tali.perry@nuvoton.com>,
 "CHLI30@nuvoton.com" <CHLI30@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Tue, 13 May 2025 at 02:04, KFTING@nuvoton.com <KFTING@nuvoton.com> wrote:
>
> Hi PMM:
>
> From: Peter Maydell <peter.maydell@linaro.org>
> Sent: Sunday, May 11, 2025 9:42 PM
> To: Guenter Roeck <linux@roeck-us.net>
> Cc: CS20 KFTing <KFTING@nuvoton.com>; qemu-arm@nongnu.org; qemu-devel@nongnu.org; Hao Wu <wuhaotsh@google.com>
> Subject: Re: [PATCH] hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
>
>
> On Tue, 18 Mar 2025 at 19:54, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 3/18/25 09:59, Peter Maydell wrote:
> > > On Sat, 15 Mar 2025 at 14:20, Guenter Roeck <linux@roeck-us.net> wrote:
> > >>
> > >> Without psci_conduit, the Linux kernel crashes almost immediately.
> > >>
> > >>      psci: probing for conduit method from DT.
> > >>      Internal error: Oops - Undefined instruction: 0000000002000000
> > >> [#1] PREEMPT SMP
> > >>
> > >> Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
> > >> Cc: Hao Wu <wuhaotsh@google.com>
> > >> Cc: Peter Maydell <peter.maydell@linaro.org>
> > >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >> ---
> > >>   hw/arm/npcm8xx.c | 1 +
> > >>   1 file changed, 1 insertion(+)
> > >>
> > >> diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c index
> > >> f182accc47..e5a1929ed7 100644
> > >> --- a/hw/arm/npcm8xx.c
> > >> +++ b/hw/arm/npcm8xx.c
> > >> @@ -346,6 +346,7 @@ static struct arm_boot_info npcm8xx_binfo = {
> > >>       .secure_boot            = false,
> > >>       .board_id               = -1,
> > >>       .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
> > >> +    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
> > >>   };
> > >
> > > Why do we need this for npcm8xx when we don't need it for npcm7xx?
> > > Or is it also broken on 7xx?
> > >
> >
> > I don't see a reference to psci in npcm7xx devicetree files in the
> > upstream Linux kernel.

> > I guess the aarch32 versions of the board don't use psci and the aarch64 one does.
>
> > Would any of the Nuvoton folks like to comment on this patch?
> > It looks like a correct fix to me.


> Yes, the aarch64 uses psci.

Thanks for confirming; I've applied this to target-arm.next.

-- PMM

