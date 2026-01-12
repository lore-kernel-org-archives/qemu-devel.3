Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93D9CF45BB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 18:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfMEc-0002Vz-MT; Mon, 12 Jan 2026 13:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfMEF-0002IY-PC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:01:35 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vfMEB-0007YB-O7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 13:01:22 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-78f89501423so59845787b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768240877; x=1768845677; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbISUAdfS7mo5moSMKSs2utarK9gYflYXVaNuqHzwhQ=;
 b=G0Qvt3qKp+puPjWWwv2ePg2tPeOagzAqyF2vlY4GQCUtRYwukk3boSEf8dpkBjatAe
 HzBkofi6EhZ4du6xVjTycl11HcoyvtcXYHsVtsLZlBCWNRewafBi1DYPA3gJSxOVVasA
 nmW4TwKRUkaiuqc3CrRmQAVglmegfY4EHZmd4C+8dGqiDTsY3RM+92/ofMN3OQG8hxdA
 IA+n9xaNE7M2RuCU9njZaY1X+aEmzpiMTnNtFgto+txJqkiTOBnHbQZGB3aeS062Zgeb
 zWgqoRP1dN95RZn6qWI93oN09XpV7rzHJiYpTM+w6PE70a32mUCVvvmEig0QoGim9pev
 fbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768240877; x=1768845677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xbISUAdfS7mo5moSMKSs2utarK9gYflYXVaNuqHzwhQ=;
 b=WdNQICWoYtqLB7sZf7W2qfHo9kRHNHRekW0KUmIwgLGYSdql5U35mE3QbnNh92U3I5
 fr3Y8Bl91otBgldK5opplBAy8FDq/pCiWB1042mb1VRNSiBxmGCjvGlNgHXBm8ECnkPH
 UUMGaMNgV+BEh+TMU3nS9f9jCd4q9aCq3oMnTSJrWah2k7HTigwDpJqEOC9HDQGYqoUu
 rs+mN+NqyK1clVo7rS6w5S0j+QXRUg7BWVFp43uRTqDG4HBhI83pZwm2OitBEawmy563
 3fwLtjfOXI55Q/RV5CiMVVj7aHPfhnMxWvxlP4O8fkyWGFgILj5kiPbeWZd2dh+QcO1i
 12Jw==
X-Gm-Message-State: AOJu0YzBU1TP+MxuPsRjrBndaghIg6jxvj/ntNTzeJHBt4T9dhxMZ2u7
 fFdijuNX2VgWpnxxNZ7QnpH9Ju3OChLGNvV7z/+U3aNya8MefRnOJEnlxPuw5MrRTsFOBTLFVH2
 SmIBi0vaYhb8mZIFhyM2ih/qvNMx3Djdx6Dr0283org==
X-Gm-Gg: AY/fxX4SmqLawZcnPH+wE/j31PK0vIHe4J8abotfuucybk/8qVl7WhP4qLVeNlBdSuM
 k9MzlwJR6uipzXxxwRWKwtonJp6LoWRY61gutH+MLRtiZGvNRnwH6tt3CdTnaQORazsnAfKgifS
 s+MNDZ1uZFu5673lQIW01ekVBs8132p6tG3SvgMZnxgF+TNs+vXbdsaVN5FA1nVWrJFL/9VyFPl
 0ABZLrp3KLgTnRqo8a2N//xnUqOmutbXAewgCOPEtoFMikKNS77i4v/mTtzOvsSrizy5FwG/flD
 3DlC/q2niqUC+6hFpn51Nmw=
X-Google-Smtp-Source: AGHT+IEZwWhr9ukILCIAS3V07tnx1/wr9CETCoEksdVTnr2K8KAu5rADCNep8ZeqHC8NARPQ9yGKocowyH0LiAlz4aQ=
X-Received: by 2002:a05:690e:bc7:b0:646:9ddf:5f2 with SMTP id
 956f58d0204a3-648f62abb2emr198964d50.31.1768240877061; Mon, 12 Jan 2026
 10:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20251223223712.17047-1-ruslichenko.r@gmail.com>
 <CAFEAcA_SSnwo0N8j_zz4jRrzcewAiRaVCENj1_gzdBVCthNVFg@mail.gmail.com>
 <CAN-aV1E3Od-ZNy=SFK4XSQfcAFBr=953Vwujne=qmKfxNt5bcw@mail.gmail.com>
In-Reply-To: <CAN-aV1E3Od-ZNy=SFK4XSQfcAFBr=953Vwujne=qmKfxNt5bcw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Jan 2026 18:01:04 +0000
X-Gm-Features: AZwV_Qgc_zhneCjXmwbCq_weyoB6qUou9o2xvMEgTQvuLfDktcytUMecjI4XTeM
Message-ID: <CAFEAcA8eTRjviWfw64Frj7NCred5HRapZALMsq3AfLUaHMj7Tw@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/arm/smmuv3: add support for combined irq
To: Ruslan <ruslichenko.r@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>,
 Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Mon, 29 Dec 2025 at 21:21, Ruslan <ruslichenko.r@gmail.com> wrote:
>
> On Sun, Dec 28, 2025 at 6:08=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> >
> > On Tue, 23 Dec 2025 at 22:37, Ruslan Ruslichenko
> > <ruslichenko.r@gmail.com> wrote:
> > >
> > > From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
> > >
> > > Some platforms use combined irq type, in which case
> > > only single interrupt line is used, instead of 4
> > > different irq's for each type.
> > >
> > > Add emulation support for combined irq mode.
> > >
> > > This mode can be selected by platforms by setting
> > > 'combined_irq' property.
> >
> > Which platforms?
>
> As I can see in ML Linux there is currently at least one platform
> using such mode:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm64/boot/dts/xilinx/versal-net.dtsi#n1010
>
> In our case we are working to emulate Renesas R-Car X5H SoC, which may
> also use this configuration.
>
> >
> > The other way to approach this would be to have the
> > relevant SoC/platform models create a TYPE_OR_IRQ
> > or gate to wire the interrupts together.
>
> Thank you for suggestion! We will try to implement this approach instead.

It looks to me as if at least for Arm's SMMU implementations
they only have the multiple-interrupt outputs:
https://developer.arm.com/documentation/101542/0001/Signal-descriptions/TCU=
-signals/TCU-interrupt-signals?lang=3Den

and so an SoC which has a "combined" interrupt is presumably
doing it in the SoC with an OR gate or similar logic.

If the SoC you're modelling uses an SMMU implementation
where the SMMU itself provides the combined interrupt,
and you have the documentation for that, we could look at
whether it makes sense for QEMU's SMMU also to offer that.

Generally I find it works best if in QEMU we follow the
same pattern the hardware is using for where we put
functionality, whatever that is.

thanks
-- PMM

