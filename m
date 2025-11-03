Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005E8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 06:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFnit-0002Vo-Vv; Mon, 03 Nov 2025 01:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vFnis-0002VP-Fn
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 01:07:22 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vFniq-0004zI-5Q
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 01:07:22 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4eba124d189so45758611cf.2
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 22:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762150037; x=1762754837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrW4fJfvdSR7vFlGrPFSg55tFffmPEhBQOGhWlaXmJo=;
 b=BiY9BZnYyj+U89T3jWVo1Wqa08fSb17RvG6jXWqoXhAf+PT4t5OWvJBInl14Be/vQ6
 wdXGtC4A1RG0JFHf1zvdidxcKZp5YVY7P5qnpugrTDuv/hkKp9ez3C9zAcKmhQ7B8oWl
 VUA4RI4BAwy7W1DgxgJYFAjxvCC6mOKv13FKLcNDnB7W2PFIigwvrgN8keKxzpbvEnPQ
 AM3Y1cGIylukcZtLNgwqo8bKSB1M4hKmuBu21V4y6mHoAZzWkcynBIRHxDu8mKJFTsaG
 m0A/HU9EMtiup38KmHQiHu+15eEvriu8GKLTuXod57JnUFirDTREHk6YpTn8ksSMaxpm
 9adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762150037; x=1762754837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrW4fJfvdSR7vFlGrPFSg55tFffmPEhBQOGhWlaXmJo=;
 b=izwprfdJZMzleLGt8YeSKd5rkluFmy9hjJsQ2pk0gqjpylbNbThKKtmb2JP8ZVPIN8
 LgXRd8Q9oWIYra9jUx9Rv5LHqebigDPz6w214Ekxb+3LaClI0wrgb321AXdydBYCEhfU
 mpEkMetHEdagzShw5SyTxrF0e86UHM1Pbn25hnC9ej36LkOgXgZRsmo0UYhsjl50qBmF
 /uAJRZ+HNvP5ALUEQ6wJ2+QHdx0rqslS3F3NF1HB6glXGX3Env5I4dUD+AONXBCt5z2C
 XvvxquP1QmzXb6IehsiehWzLiFtZi1sQbcuMduiD0grkjtNQgcqxaZj1KwRy8owy0n21
 Sp2g==
X-Gm-Message-State: AOJu0YxBgB7QzJ680e+sTPtPfg6HfsZFzGxZhwkIdTR1BeRXda9jGlOC
 PoxFWqqlate0W8Yrq4VSOjriykUP45SrbuqPaT7labSxGysHt12xGmMvftc4qlkrF4Xt6XGmCWc
 gJDfqid60dyqlX2MF2u7vXBFadFqbv7ckli8lW38DWg==
X-Gm-Gg: ASbGnctweR7Q9zoXO38CVFpjuOdj7M6hJOHmg346BOxVXcuDW9V14XlwdrPmfFXirtR
 IcxJxk25I3tkV0kCmG+gogIL8fYVY4d7+usXr3rkS2pLj9iHym5A7YfyRZ/VEbfJNr+RJNwGdkC
 bUzXBwCj7DXq2uz3ela6hx4JD+tUE2kpvPkSSCq7hXsm+JrAA+DleZDHCfgJC7sGfQhMEv5BBt3
 vAP7gnw4ErxIVHEyOe75pz3IRmm+BzzCunEUI2qK7E3XG2h0iVS/+BWatARLMQc4x5Eh8aZFHXo
 R3inDKCG9g4BRFYu
X-Google-Smtp-Source: AGHT+IGuIjZ0Bkc1iunCpM7mWZI4l6CDd/Dwu7lpqq5VgYePWiwhzDpNzXT/FgPooPDHc81nse721o3ZB02A8cpz/kA=
X-Received: by 2002:a05:622a:1a08:b0:4ec:f156:f465 with SMTP id
 d75a77b69052e-4ed30fa9c34mr162018281cf.47.1762150037263; Sun, 02 Nov 2025
 22:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20251102231903.65409-1-osama.abdelkader@gmail.com>
In-Reply-To: <20251102231903.65409-1-osama.abdelkader@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 3 Nov 2025 10:07:06 +0400
X-Gm-Features: AWmQ_bkVv_Q78qz3Qb4cWgkEXpLhwqeXt7sbR8IgVhG4jnH3kp5Kh4o_jOLZyJc
Message-ID: <CAJ+F1CJHP54C-mr1AXPS3H=tLiiG5AM-ExdRieAwNifhtrXKAA@mail.gmail.com>
Subject: Re: [PATCH] hw/audio: Remove dead code from ac97_realize
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, Nov 3, 2025 at 3:20=E2=80=AFAM Osama Abdelkader
<osama.abdelkader@gmail.com> wrote:
>
> Remove unnecessary PCI configuration register initialization that was
> marked with TODO comments indicating it's redundant:
> - PCI_COMMAND register is already 0x00 by default, no need to override
> - PCI_BASE_ADDRESS_0 registers are automatically set by pci_register_bar(=
)
>
> This aligns the code with the pattern used by other PCI audio devices
> in QEMU (via-ac97, intel-hda, es1370) and removes 15 lines of dead code.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/ac97.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
> index be7a39377f..60daa62ea3 100644
> --- a/hw/audio/ac97.c
> +++ b/hw/audio/ac97.c
> @@ -1279,30 +1279,11 @@ static void ac97_realize(PCIDevice *dev, Error **=
errp)
>          return;
>      }
>
> -    /* TODO: no need to override */
> -    c[PCI_COMMAND] =3D 0x00;      /* pcicmd pci command rw, ro */
> -    c[PCI_COMMAND + 1] =3D 0x00;
> -
> -    /* TODO: */
>      c[PCI_STATUS] =3D PCI_STATUS_FAST_BACK;      /* pcists pci status rw=
c, ro */
>      c[PCI_STATUS + 1] =3D PCI_STATUS_DEVSEL_MEDIUM >> 8;
>
>      c[PCI_CLASS_PROG] =3D 0x00;      /* pi programming interface ro */
>
> -    /* TODO set when bar is registered. no need to override. */
> -    /* nabmar native audio mixer base address rw */
> -    c[PCI_BASE_ADDRESS_0] =3D PCI_BASE_ADDRESS_SPACE_IO;
> -    c[PCI_BASE_ADDRESS_0 + 1] =3D 0x00;
> -    c[PCI_BASE_ADDRESS_0 + 2] =3D 0x00;
> -    c[PCI_BASE_ADDRESS_0 + 3] =3D 0x00;
> -
> -    /* TODO set when bar is registered. no need to override. */
> -      /* nabmbar native audio bus mastering base address rw */
> -    c[PCI_BASE_ADDRESS_0 + 4] =3D PCI_BASE_ADDRESS_SPACE_IO;
> -    c[PCI_BASE_ADDRESS_0 + 5] =3D 0x00;
> -    c[PCI_BASE_ADDRESS_0 + 6] =3D 0x00;
> -    c[PCI_BASE_ADDRESS_0 + 7] =3D 0x00;
> -
>      c[PCI_INTERRUPT_LINE] =3D 0x00;      /* intr_ln interrupt line rw */
>      c[PCI_INTERRUPT_PIN] =3D 0x01;      /* intr_pn interrupt pin ro */
>
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

