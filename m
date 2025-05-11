Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FD1C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6wu-0000Ag-QU; Sun, 11 May 2025 09:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uE6wt-0000AO-Ih
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:42:35 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uE6wr-0002VN-IC
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:42:35 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-70a2b85aeb7so28892967b3.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746970952; x=1747575752; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c8QV6w8cr2EJNiCqD8Y9EVvczLMeIeIzR3zKiEmzbhE=;
 b=IrIyET3Lx3cwWV5tEJOhrn3MZVXGoVQgomKXgXGQTaB0mMRjdBA9XYfvDZsiOloDwl
 Hqljqw/UoAkWwN4gnD4L4y6zNwlYv02jt/zyz3c+g5TaGXOcKhcrCP+ThEI9dM/KEzNp
 CZzPyQmcNB4rzhIq1SQS5rFjJtZ5b1KhM/E7gzOGMg/pVO/bQNkCP8edo2fNk76061Z8
 qRn9dryUvD1nrEKoAxpvAgLl3EB4xFfzu3L8Yv6dY2rXDLPXM+AnWZ//zKd9bnhz76uK
 H6MJmGPW56A2c1lvv0m+1OXVvUNt0w1yiHkn72PbK8+wKBjkcO8yMpmCtUDt8nwgteX4
 7RPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746970952; x=1747575752;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c8QV6w8cr2EJNiCqD8Y9EVvczLMeIeIzR3zKiEmzbhE=;
 b=KDqyLN6ClKrvZZrD0hoyNb6GyO9LzuqTGQIWyyj2B7OGjFnboBxzwQH/LnGqsSgYnk
 tYsSsMrVA564F8GkUf4CnZoasJ83WtuEm51cVcTGsHNLaVUmLGyefUn4+M0NXFVtkqkB
 VKgahrjkcjtDILNTz0f6oimU92OjYUnmVu9Tq+yAvjGiOlfJSQvq7WAiCVUwxc26IiwX
 3CtAMYjbYX7htcyHPv5SH+Pp2PQyOiKzcrz3HAt7lalVyGIqo+A0xi1EUhZrh5Bx+wCb
 7FlBPIWsePegeD8QdJ3gwkQzZTvJVcAJoeJUq99vZXFXBd0LM9/IsdYCmMFwiFa46xW8
 12qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUunRwVmGNg+msoOPh1hxLykr1iEBTTHW3fgxtNOil68+Fp7TENvVsdu3TPtz9VQJxcy8Ka2A6rkPPm@nongnu.org
X-Gm-Message-State: AOJu0Yw1jpXEiCDl61FzQi6s19yQ/mZaObGB7tNfcuHRo1tzZopu0Sjk
 F9+17zb1J74/4xLDYoHXX1rvVfQfZHPh6GuLMgDCyBxbPVfxYKOVS8TSuE2qUzWSV9u+Y81bipX
 okTqr6iIiCNcRVTYzCtkMxIgTNYzl1rPzJ3i6g0+7ecHdPLHY
X-Gm-Gg: ASbGncu9Mldw5DPGJjBbw9p5mWsDbIyirP/DJ4URpjCxj3ucfs7vPpWvidRURHBhCX6
 2zbQ5klQ1l7zw4o48kguL3wp0aaLKGsQNwG6dkiovIplDl3R4vw0a5nA4NBzjWoaBDoYRjHdknc
 91Q4KK3zdMTdGfrL5qhRreMz3kFMSxcbv3MQ==
X-Google-Smtp-Source: AGHT+IG1VrEz6I59vmbbCenQVLUqlKXEbF7YtHhyIFFdzysMNA5Fjdh3+/IQ1AbW1HfQs6Y2Er341UH4rc8SgrazJrg=
X-Received: by 2002:a05:690c:9b02:b0:6f7:5a46:fe5f with SMTP id
 00721157ae682-70a3f9f1baemr133419117b3.1.1746970951726; Sun, 11 May 2025
 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142050.3642741-1-linux@roeck-us.net>
 <CAFEAcA-zPwJrq3oQk3MRp9ZCyTzDOg2-Je00v20pVzrKe8he6w@mail.gmail.com>
 <5d350a95-886e-420c-8b0d-a3be57b9490d@roeck-us.net>
In-Reply-To: <5d350a95-886e-420c-8b0d-a3be57b9490d@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 May 2025 14:42:19 +0100
X-Gm-Features: AX0GCFvYQrK_dqdtJp97tVMCTi_d9IIIX4A80GO-0yS9aEeHNHqdB2U0i6Pq22E
Message-ID: <CAFEAcA-9MCRfHb+O-qdMHAOgSVEUY26h7dUzF-yaF81oFZHs4w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add missing psci_conduit to NPCM8XX SoC boot info
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tyrone Ting <kfting@nuvoton.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Tue, 18 Mar 2025 at 19:54, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/18/25 09:59, Peter Maydell wrote:
> > On Sat, 15 Mar 2025 at 14:20, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> Without psci_conduit, the Linux kernel crashes almost immediately.
> >>
> >>      psci: probing for conduit method from DT.
> >>      Internal error: Oops - Undefined instruction: 0000000002000000 [#1] PREEMPT SMP
> >>
> >> Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
> >> Cc: Hao Wu <wuhaotsh@google.com>
> >> Cc: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >>   hw/arm/npcm8xx.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
> >> index f182accc47..e5a1929ed7 100644
> >> --- a/hw/arm/npcm8xx.c
> >> +++ b/hw/arm/npcm8xx.c
> >> @@ -346,6 +346,7 @@ static struct arm_boot_info npcm8xx_binfo = {
> >>       .secure_boot            = false,
> >>       .board_id               = -1,
> >>       .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
> >> +    .psci_conduit           = QEMU_PSCI_CONDUIT_SMC,
> >>   };
> >
> > Why do we need this for npcm8xx when we don't need it
> > for npcm7xx? Or is it also broken on 7xx?
> >
>
> I don't see a reference to psci in npcm7xx devicetree files
> in the upstream Linux kernel.
>
> $ git grep psci arch/arm64/boot/dts/nuvoton/ arch/arm/boot/dts/nuvoton/
> arch/arm64/boot/dts/nuvoton/ma35d1.dtsi:                        enable-method = "psci";
> arch/arm64/boot/dts/nuvoton/ma35d1.dtsi:                        enable-method = "psci";
> arch/arm64/boot/dts/nuvoton/ma35d1.dtsi:        psci {
> arch/arm64/boot/dts/nuvoton/ma35d1.dtsi:                compatible = "arm,psci-0.2";
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi:                       enable-method = "psci";
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi:                       enable-method = "psci";
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi:                       enable-method = "psci";
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi:                       enable-method = "psci";
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi:       psci {
> arch/arm64/boot/dts/nuvoton/nuvoton-npcm845.dtsi:               compatible      = "arm,psci-1.0";

I guess the aarch32 versions of the board don't use psci and
the aarch64 one does.

Would any of the Nuvoton folks like to comment on this patch?
It looks like a correct fix to me.

thanks
-- PMM

