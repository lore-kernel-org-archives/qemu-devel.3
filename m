Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE68E9A049
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 13:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt3dx-0005Wc-Ma; Thu, 19 Feb 2026 08:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt3dt-0005Qd-8F
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:00:29 -0500
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt3dr-0005bT-EO
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 08:00:28 -0500
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-793fdbb8d3aso6989007b3.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 05:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771506026; cv=none;
 d=google.com; s=arc-20240605;
 b=F7P/DhIm/zVjgoFh6G3DWilLgAjqgQNRDnKXn0k1pBWEkUdvNGE/OFrbYVeU3yZayd
 uNxI2IDczCKQ/ziXIWDCb5Vm6NNlbeC+SOKbmzbv+Ev7Aw67F3OD65GzQMTB1ZxZOugm
 iCUXInu/jzznlsgpx6J5wgVoc8OWyLC2pQf/nrY7BDyNnq6KqUgsd1QLhyZNQ+DIM0/k
 vOQ9S+AMBJx5DofkYsZ15hawB1G99kucboHFeCSNkbgbPP0SrLLfhqU/1wkWywlWDKWZ
 n4EZ4SWiufHGQVN5tWyzSfmX0ooH+VIdSB2xv+vFS5xhBqIVTSGqc+Sg1MpcxzmsvdxS
 +Mtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6f/cv+8SseqLRrX0F+EZo+zHcoceiYv1Ox6pEsi36q4=;
 fh=QKWwYWnU74tEpagxyzKMxXfdzss8yZtT/YtRGw+kJm4=;
 b=Krj9EVOtu3NuO8UBuCUZ9bU1nH+nquAIpJj/LwWHgz9W0+VVK32rISSdglBII7Tc+w
 Y2rX6xvMLS9rN6hzY/xKhS1D8XANC4zpIFL/0lBjXdcJaVacXFAMuW1gHN4Mho568RLU
 4gZ5R5TNLjQVPWnlUaS2MM8gPYkYadrIAZfGV7c6P3hAfHKJbmndfDGmV5uEXx7lscUB
 FS0oGRtRmYdL7833ctMJcBOsP0MDrJgWdxFECAx+foEjGOGJNGBU1cAIITeSBwHXiJKt
 YfwFiyrAdmK8agB+4xsuvnPj0MKAEfmIGnucMxeOhkh11OEJSRtMfueFZWwGniazF0Eb
 5ZvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771506026; x=1772110826; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6f/cv+8SseqLRrX0F+EZo+zHcoceiYv1Ox6pEsi36q4=;
 b=qemoBINR3+UKDTPVas6bqCCLBSm5VAF/nR6E5sUBeyKAU2O3Y9cmXKp/jc0I8B3K2z
 oPxKalXlOccE42WRtMrQj7Ct9VlIFDIwQyQkY8e4zWeIY9FJ9NnwN4UxCnUxX1bwZsia
 rxGTLtufwWI6rqM5362/eLc61u6ohscE0cAlUPiX3lNzcurV+z1R/KH+TsDq3d3HjcTY
 vQJOWubdStZIzQeeZn/7XukIawqxXab/5xLgaZYsdHNDHN4/pm+Aegv9w0SyL5JC/jsC
 YID2pfAIBhN18b30qyapoOXktlMXFJUBoTO8lvL+XPSQt1CUVi1dtbSxQS4k4fJQ82uY
 wn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771506026; x=1772110826;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6f/cv+8SseqLRrX0F+EZo+zHcoceiYv1Ox6pEsi36q4=;
 b=NuO4/2corFDFoC3pO3zPwcwwbANIz3iqGm2TG5Byt1smvFXyD/JDWaohA0cNrbxvRG
 wnvTBRg1fr0Bupn+DVcEtLOK+qT6mz4AsFf7Y+z1IMvMECt9zKAtxnxENCEF01Jb/h2k
 +USZi2DKeLNcRA9KlUodofxqma/ydF0f3sMiqgJEw3dPPQBuNJ6f1JuPNlN8fUBZVV8e
 lYEVoWf71LgVMrS8JbRkROSY7icfGYRUhKwK+ovcVUUwf+vBib28CRXPbIGUihruGfBL
 +WZr+xQHgXhJTcuhB3SQmmCKuir2a7kW3f72vvFOFBLq0tHYCNUhvZx6OWYnEZJUMGXU
 hhgg==
X-Gm-Message-State: AOJu0Yx1PDnK1vzbPFqP6ATkW0orisNYUuF1qT/mkI6E09XSfxjGIhs/
 3+Qo86IIi5Ig+yqGuvPpqmqs9DoZwU3OZKoo9KZ4/1d7/Zenz0xb2Ma0GzzykPeQJEOGOMrGuLF
 6wwHpbpyPnjOZCIJf7xQby3uzZm8q4zAf9DI7gVBpxw==
X-Gm-Gg: AZuq6aJLsgbZWn96Dr/O2y2DrB/zcWNHPOMTs3QoE3lon4HD/VYpDXn3XAkxMfLsMfl
 6/MwJ4YnySgavMgLtb8csE7qdJUXIiO31WIJ3fZsQHB+bRaeeabcok2OpLaR2rGGWfW//Z3szgk
 oszznoBUiq5LzFsDagPZEZBobY6ChmmAf3kwAml0T7DVGcZuRMMle94RVJgwqfvMY2+5Uc9qbIl
 6M70jHSgxYA3Q95uijI/jAWGhLql2uCHVhBS8QSb2aqXdkSZy0EK8Y8SVq1Y/E+37IyBhf+C4DF
 aW3Sqy4u/JNdOtwSTcKQKotan3hYKR7E0pUI8kzNiPyhxVdHC8MbJkoMwfOj34I20Sc=
X-Received: by 2002:a05:690e:2545:b0:649:c7dd:d2ea with SMTP id
 956f58d0204a3-64c14b896f2mr14014752d50.39.1771506025538; Thu, 19 Feb 2026
 05:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20260206131438.1857182-1-imammedo@redhat.com>
 <20260206131438.1857182-9-imammedo@redhat.com>
 <CAFEAcA_QO_Pm5qKy2xOer+VmyMZ6KZ1KdUpf_ETV9fQu4YmaHg@mail.gmail.com>
 <20260219131751.4e4e4e0e@imammedo>
In-Reply-To: <20260219131751.4e4e4e0e@imammedo>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 13:00:13 +0000
X-Gm-Features: AZwV_Qh7IKSBE9HvlvvZ4OpzeXRNav7wR-J006OU-6EbLgLx-VtnrgnHg12Levw
Message-ID: <CAFEAcA-qaSRM9MJDk2nhDQKWoP7odcou2DXff-fuYPNEE=g6vg@mail.gmail.com>
Subject: Re: [PATCH 08/11] arm: virt: create GWDT watchdog paired with WDAT
 ACPI table
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, anisinha@redhat.com, 
 pbonzini@redhat.com, shannon.zhaosl@gmail.com, philmd@linaro.org, 
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Thu, 19 Feb 2026 at 12:17, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 18 Feb 2026 19:08:36 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:

> > Please can you also add support for exposing this device
> > in the device tree ?
>
> It's possible,
> but we probably should not enable it if acpi variant was requested,
> to avoid confusion on guest side.

Why? Almost every other device on this board we advertise
via DTB for device tree guests and via ACPI for ACPI guests.
(The exceptions are things like the CXL handling that really
only has an ACPI representation and can't be described in the DTB.)

> For Windows it doesn't really mater, for linux it does.
> on x86 linux guest uses a quirk to disable native iTCO watchdog
> in favor of WDAT one if later is present.
> I assume quirk is not desirable so we should expose only a preferred
> variant.

For this Arm board there is no watchdog except the one you're
adding in this patch, though.

> > Can we have a command line option name that isn't ACPI
> > specific, please? There's nothing inherent to ACPI about
> > "I would like a watchdog device".
>
> that is specifically asking for ACPI flavor being used/configured.
> acpi specific option conflates 2 things:
>    1. watchdog device creation (of the board choice) with properties tuned for WDAT usage
>    2. how to expose it on firmware level (in this case ACPI WDAT table)

Right, and I think that's the wrong way to approach this,
at least for the virt board. We should either always create
or allow the user to ask us to create a watchdog device.
And then we should do what we do for all the other devices,
which is expose it via both the mechanisms that we have
for telling the guest about hardware (ACPI and DTB).

thanks
-- PMM

