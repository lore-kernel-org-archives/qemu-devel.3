Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC6CC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 16:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVwCK-0005X2-Vv; Fri, 02 Feb 2024 11:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVwCJ-0005U5-58
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:15:23 -0500
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVwCD-0001xN-MZ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 11:15:19 -0500
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51117bfd452so3885638e87.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706890515; x=1707495315; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kvXEFUuV8IOKYjP2vnC6TKa8wP5byRrDTvekBA0Qdn0=;
 b=oa8zy3wB9TOMI8JvsyFnbAtahTGgsNPadFdch7UKX826URpwlLjKdpV1CYLHnwd0Db
 DCM2kjPDkuJbrUtLIGDv2P8UAL4hbdBdXN/m+TmBaetLnHRXaZGcy5cR7x5rZF2p8O2E
 h/7JslU7Z+nxmshmTatqzoIPZqhDewujb+GZqGTzPzYIvSsJgPQK01AAmKwyC/hCr1EY
 g7po2O2X2YEsWhNZ+HW/OjJBe8d9DPdEsfF3UsmRpAPnrs8JaKUYNqT3XAOzkjPGSCEZ
 Kp9zoT7EmnYG8POBCnH4kP6Q+RUV7Q7JKUe84L7uLeCVe2kYkJUDx1D2qzEkPQ/1h3VA
 d6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706890515; x=1707495315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kvXEFUuV8IOKYjP2vnC6TKa8wP5byRrDTvekBA0Qdn0=;
 b=Y0TlPoXtdm5UvYTtpUNPSh/SdcuGtQBCneFVwU9ijK+farqb+T2gnVVUs8abwpSXz3
 P4pNwypXxEAgqEZuDisR3Krdul6BBDwONSv3gMIpY00YHDbiBFYYBC3WoIVeHWMzyO7v
 YOWByZoJ46Q+b3+xEq0m/NPMulnNyn/BIWZ/quKV2HfmZGWbil+8wB/LZG//xCEUqg1/
 e2PHG52Xfk5spPRYjyVKO1QjaL4x/Nvz8oM5DeYq6uUokzhSpsQH6H0Ukzs3G8gCwDVy
 +vonf92b1ZvOOatNZFxAoINtwep3emKQQ+bQoWYKjr7Ftqx1YoummmgwDAkNm8Z+p3Ds
 kVeA==
X-Gm-Message-State: AOJu0YzD1BWRYsDdg9H+T9UBCmNHcaFA5GS+v9fJi1sk/r0RwFARVBr5
 kR8GlA+48AOfk2k5AXDXUCslHiwkd4B6Ps34WcgTNd/Bh83c+OFWrm0vL5Cp2BZXKzQ3Rxm+lLY
 zH0AW8ieJzAXfEM16YOdFuVghTKsIQaugkJHcpg==
X-Google-Smtp-Source: AGHT+IHV5Rwv8cxsAn5rtyQX1vnvpao1aYAXO08RQdE36NEaBJ9mmhUSZrGR5n49x1SheJrcYH53p8veavn6Mc4iXMY=
X-Received: by 2002:ac2:549b:0:b0:510:c7c:5a6a with SMTP id
 t27-20020ac2549b000000b005100c7c5a6amr3950906lfk.61.1706890515036; Fri, 02
 Feb 2024 08:15:15 -0800 (PST)
MIME-Version: 1.0
References: <20240201164412.785520-1-dwmw2@infradead.org>
 <CAFEAcA9-e=hzN62vkq-P575yMvjqmm1sNwNMswUDnqj1gCRmOA@mail.gmail.com>
 <dff9919b512fde570184f6d075f9420277f273d6.camel@infradead.org>
In-Reply-To: <dff9919b512fde570184f6d075f9420277f273d6.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 16:15:04 +0000
Message-ID: <CAFEAcA-DKOGs=gd0stCMzn1K0MYcVGkwJE4X_nnVibnMbWX3HA@mail.gmail.com>
Subject: Re: [PULL 00/47] nic-config.for-upstream queue
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 2 Feb 2024 at 16:01, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Fri, 2024-02-02 at 15:32 +0000, Peter Maydell wrote:
> >
> > $ ./build/all/qemu-system-hppa -M C3700
> > Segmentation fault (core dumped)
>
> Ah, got it. Some HPPA machine types don't have a lasi_dev.
>
>
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -362,9 +362,11 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>      }
>
>      /* Network setup. */
> -    lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
> -                    qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
> -                    enable_lasi_lan());
> +    if (lasi_dev) {
> +        lasi_82596_init(addr_space, translate(NULL, LASI_LAN_HPA),
> +                        qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
> +                        enable_lasi_lan());
> +    }
>
>      pci_init_nic_devices(pci_bus, mc->default_nic);
>
> New pipeline running (FWIW) at
> https://gitlab.com/dwmw2/qemu/-/pipelines/1162635873
>
> What is the next step? Post the full series as a v5, or perhaps just
> the single fixed patch which is now at
> https://git.infradead.org/?p=users/dwmw2/qemu.git;a=commitdiff;h=2c20b4ee96db
>
> ... and then another pull request?

If that diff above is the only change, then:
 * roll a new pullrequest with the fix squashed into the appropriate patch
 * have the subject marker be "PULL v2"
 * you can send just the cover-letter and the one patch that has changed,
   you don't need to resend the entire series (though it's not a big
   deal if you do send the whole set of mails again)

> The docs are fairly clear that pull
> requests can't have even minor changes that haven't been posted
> separately... and I guess the above incremental doesn't count?

Which bit of the docs is that? It's not our actual practice,
so we should really fix the wording. The principle is "don't
stick code into pullreqs that hasn't been through the review
process", but in practice especially for submaintainers who
know the system it's not uncommon to say "I'm going to
squash change X in and take this" or similar rather than
forcing submitters to do another round of sending out patches.
There should be *something* on the list to say this change was
put in, but eg the exchange in this email thread is fine for that.

thanks
-- PMM

