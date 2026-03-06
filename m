Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C71DFCC050
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZlw-00011c-1w; Fri, 06 Mar 2026 13:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyZlq-0000zW-2m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:19:31 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyZll-0002yX-OV
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 13:19:28 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so8978372d50.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 10:19:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772821164; cv=none;
 d=google.com; s=arc-20240605;
 b=RV8Q1LhruC72vMQ+gLuryD2I7It8tT4Y8eJeT8110MkMFmrwjliEHV55hjyKZmxI1L
 TIlw7Jav8vw43D369GULlZszfQlCQ1DcgB7Msdufqa15vPzH90bPnNgE5NiFa+YB9Hz4
 i9xhzY/jdHmuah7OXxURNctcdA9C8maBDbSB36MFNPpEEAz+06EAg4We46OqrFmh3Kes
 lrzDmvuJ66qjxIkBuWNt0Vf/gJBH0aZyG74aH9LskP0zLDVWuOv3YXOnbSCGr7Wvck81
 RWlAz1MYsgbSrlOam5ZmmLGbhSLyn2LHJGfBaIN30AULO5+Geub4GTTCx8Dv0qZUdYqZ
 m4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bG6FfD5uY+Fbvj8h+7TftOMFxQRh5TNeJFjYUR7L8/Q=;
 fh=F6bOIkOA5aBYREcZAmFgJCjXkzyN1AsEyw/DQQWelOI=;
 b=Uwu7c6+Jh/DjCJplocPv72H1nH3gDTWHGKnuj+iqVrfOcvR/eMoANrU7ztoBySTYyR
 qG4m79J7S/+PRluw9jm8rTKG7xjyNvws4EZERAbfguMnFFXHB4O4jIdB6yfFO7myBAjs
 B0gsPZVKQHLU0bPWPsI6xD5E8SDQ+SX1LcAdgXzOn5Bx5la8FoaQjj9NegvqbDFHOLNi
 GfOjOcAgxWYd4oKAnEwXfRH+zHcpCHpkLKypyu50Isi6EuhLXQTZSEsI7KK3k+oEkGfH
 NCHoC7xl3q9DjiKxxxuO+Fx6I95ZlNlkHvnrKbmWGVJIx1eASgV66e9buSVPFFl3BnSt
 yEKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772821164; x=1773425964; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bG6FfD5uY+Fbvj8h+7TftOMFxQRh5TNeJFjYUR7L8/Q=;
 b=EaqvbDeJLA0hDDfhszvnKWMLxOZZLY4Zp4cNx3IVK5hiqiXkfQSrdXHf4qf3xUeB/x
 q+dHQV2hLJu18TpG2WHmigZ8DlMUtjvHBkbVYr/j60Oqop4w8nLoiKxoT1/uh6ofAJ4h
 4kZGamFfSpmEHI1KmH+UPm2iijqz2N58IxBwl9DcTf24gKk2UxeQM0PbnWD/ZEUgcQIi
 6zEEMcIRzro4+FC0LooJOWA9n1SvVea8g0Nu/lx375ZPVSADQmN96r1EPZBxbFHwqcW3
 6qZNfT4GZ3LDNIgMvNoRmE/2sDZbnwMuSE1hqR88o/UQD9L6B5CzBdJoYXA0vNPSrNQy
 Xguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772821164; x=1773425964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bG6FfD5uY+Fbvj8h+7TftOMFxQRh5TNeJFjYUR7L8/Q=;
 b=cb3yx02JK2SpnnmYn+QVA5SPEOiDAPs29mzJuZxra+b68dnsy6zYq/wE+nb3hr4pqK
 ufDTv//SG/3nJ8N47sviW74KeGK/9ukRXtt/Ob7RBC6F9/OdGgwlyBZDHhIYX8haHBdb
 PudgcUsFV8PZ6aNdGpe6P06elmX/UxwjdxZ+q7DP6MpO51/Ijuhz+Iy4MCYCguYfAW9K
 1Tb02x6phFCu7ex0AfFuNfRrt4Scl1+0lwb+DoX37yDf7JM/QRCmjAROch4sMzySAR/J
 DX3oiSa+22x9xEnPuhiobvlnBpwOoDK7n6Cd4+915fy61wxDKTICVjqu3sD2YGtiuI4o
 6EmA==
X-Gm-Message-State: AOJu0YwiOTj4Tulg2h58PBpAyLtGGuf7s3cNXrP0wAJ55mzZKUp/dVEI
 NnwEGWiz4BT5tSUTZI6dUByI6VMd9T1G8pnhgOjbUDI0TM4TjGiQ7vJxOuNCwbNpGXt1GnQQBTI
 Qsf5Bpvb5kX+6KRU/hrf/j7AlfbeK12i8mwAJA7M4jA==
X-Gm-Gg: ATEYQzwqU7xlgQDLXakyJ1UdePV1+KQyvzFJJMiSFN25FJ9H+gZ5wAsOZ0DgZ8292TZ
 GF0x2u9d3slBSHJkgmykozjIOtHDLVnfs94ffhqoCCe7n7+ksTlIaNiV/CkaHrgq5jGlrBwLdIP
 SBUrKTnQiB5NFOrc4uDYINkWqO3k4DJ9cjRBZqbQLaIKS+KaZ0rtsMv/dX8k8CrtrNVkv6HFKJe
 TnPLEe9eICI69zv2iUgOnFDMznLmpWKsC3PKAmLplfsPamLj66Ruix7WBj/Q2J4ui2kvg1JLUF2
 SQSKOgqdHm7dhEIHNxbp+7X0T3+2JQ98SD9w3m+bLxHeRTJCuOyZmsDZgNBCMEdNxZA=
X-Received: by 2002:a53:ee62:0:b0:649:ceac:7332 with SMTP id
 956f58d0204a3-64d142ff79fmr2142975d50.61.1772821163654; Fri, 06 Mar 2026
 10:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20250207210540.24594-1-deller@kernel.org>
 <20250207210540.24594-3-deller@kernel.org>
 <CAFEAcA_VWSYYE+GdDRwxpWzOX6qVYptjYOe--azOzo4_pre_+A@mail.gmail.com>
 <aasZKZ1FQY5ytrb2@p100>
In-Reply-To: <aasZKZ1FQY5ytrb2@p100>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 18:19:12 +0000
X-Gm-Features: AaiRm51-04PCeY9gkwmUwaY09Y2nw_JZAIZE6tempJ80Vgk8Mzia0xjEzrJ76-s
Message-ID: <CAFEAcA8MLNYfDe_0chBmo+wwwNJoUHWj4Sg1nhCNSjodCzTOtw@mail.gmail.com>
Subject: Re: [PULL 2/6] hw/hppa: Wire up Diva GSP card
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>
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

On Fri, 6 Mar 2026 at 18:13, Helge Deller <deller@kernel.org> wrote:
> Background: During development of the various machines it was
> easier for me to just disable/enable the Diva card from the command
> line via the "disable" property.
> Commit 16786eb7bf86 ("hw/hppa: Add BMC on 64-bit machines only") now
> simply disables diva on B160L, and for the C3700, although it never
> had Diva boards, we will use Diva until we get SuperIO implemented.
>
> The patch below should address this.
> Maybe you can review?
>
> Thanks!
> Helge
>
>
> From: Helge Deller <deller@gmx.de>
> Subject: [PATCH] hw/hppa: Avoid leaking a diva-gsp device
>
> Create a Diva-gsp unconditionally on all 64-bit PCI machines.
> The A400 usually comes with a Diva card. The C3700 has a built-in
> SUPERIO chip, which we haven't implemented yet, so running with an
> emulated Diva is the best we can do for now.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Noticed-by: Peter Maydell <peter.maydell@linaro.org>
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index f55e84529f..50ace81528 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -380,18 +380,15 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>
>      if (pci_bus && hppa_is_pa20(&cpu[0]->env)) {
>          /* BMC board: HP Diva GSP PCI card */
> -        dev = qdev_new("diva-gsp");
> -        if (dev && !object_property_get_bool(OBJECT(dev), "disable", NULL)) {
> -            pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
> -            if (!lasi_dev) {
> -                /* bind default keyboard/serial to Diva card */
> -                qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
> -                qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
> -                qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
> -                qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
> -            }
> -            pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
> +        pci_dev = pci_new_multifunction(PCI_DEVFN(2, 0), "diva-gsp");
> +        if (!lasi_dev) {
> +            /* bind default keyboard/serial to Diva card */
> +            qdev_prop_set_chr(DEVICE(pci_dev), "chardev1", serial_hd(0));
> +            qdev_prop_set_chr(DEVICE(pci_dev), "chardev2", serial_hd(1));
> +            qdev_prop_set_chr(DEVICE(pci_dev), "chardev3", serial_hd(2));
> +            qdev_prop_set_chr(DEVICE(pci_dev), "chardev4", serial_hd(3));
>          }
> +        pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
>      }
>
>      /* create USB OHCI controller for USB keyboard & mouse on Astro machines */

Yes, that looks good to me, so

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I think we can also now delete the "disable" property
in the diva-gsp device itself, right?

thanks
-- PMM

