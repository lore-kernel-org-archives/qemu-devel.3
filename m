Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7D8CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWWDu-0002T6-RZ; Mon, 08 Jun 2026 05:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWDr-0002Sl-Ml
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:24:44 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWWDp-0007Nq-VR
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 05:24:43 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-660e9ff0587so1617308d50.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 02:24:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780910680; cv=none;
 d=google.com; s=arc-20240605;
 b=QXoqu0xNUSTko4c5fCRNjgo6Pf5BxPmVBH2ibrNXKwbxrs0MoAByXxEngv4uSPlY1x
 GEmOrIFoMQYHBHQ8rqvXmL0f/hpstxTzj69j/9aCH1gvu039/1CfMcAtSlJ+RIBSwJ7h
 CcOwZtUISrCoAOuCRZ/uCxs/6/Q/cGqYI+E9b5hhRjqhAtcJEQVxVuT2xquwq6u+Mzrm
 ANImwE0VvnYOWEdoRBh4fIy/Telsm8Pp24vxLZKtjg7uHfRHTofzUkfozoz/5+E56r+s
 JeAqjsZO46cnApsVD0kBw6Ebqpw4xxE+DE+XxzWjPV8hsvxTIuEkjb0EBqyWeW49Kq7N
 iuXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vPidOw72KGAxsKvn0SeAXzVGd4KUgMOCY/GVTBKBj00=;
 fh=VdU0ZIHHM7Xuu0AoHAY9TnsLw+Rmx6THNQ8Qxyqt4ys=;
 b=RzP9sHo/q9DnReIUZn91HcNgN4SCc+yburzt8GR+ANb8u7qQJ5vI5YWbvMAehbHmTD
 g7eGjSg2CPlErsCrivcTxSQ/MFYXzA6esn1Zgj4ArVrUAuZ7VP5HIHHbiwdD+Af3lzIG
 +iZlZ3mQ8BwDVIlsTOYW1xqFbAVpkY6BHx/XjSnvQHyPnVp1N8A6suLywbIkHoF0JWoq
 BEES8Cb4tunBIiMDwYpICLDafSSeHkN04TfSE5U5d0rQOegq5hkjvdT6bLXPAr7zm/Da
 bwkmjg9eBWeA3r6x1ZmAJV4CY28eBgk4VsfViFcqqPjirs1jrv6xQEKywL7idBh8LK3e
 Uk5A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780910680; x=1781515480; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vPidOw72KGAxsKvn0SeAXzVGd4KUgMOCY/GVTBKBj00=;
 b=X3koX8J3/KmEFmnChMsOqIGT4/GsUEwgq9t4VfDywsoo4pvxXJ7H0gXjLE4Oz3bF+n
 FHZjL/fCKUUw0a/dIhOyud+myQJyIPq9dDjtfg1em4hdUhwExUujuzstGmsiEq2mdObn
 ASnLE54EhokCLDsTM3wVWktzdXklp5Yyp1D/7qv15lXVtnxED+GxXnjiIPYKwpXI/8QO
 5IN9zXB25Z+eXJ2LllkATGWy1pqkT+5nv1lV2m6PcGeb6rB8Iry1eF2qZiZgMZ1jk587
 /HGfwJmvJ+TYTuR2zSMGU1LSUZzkXMFLhpKwKnKT0LJWHAuUud0w3ACPDuArF3LKiIlx
 dKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780910680; x=1781515480;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPidOw72KGAxsKvn0SeAXzVGd4KUgMOCY/GVTBKBj00=;
 b=W8vPpI80EO6SfeU6gcu14yJxOkOh2JA+hKAIUwuCCQ1yCqZAwpBAT9KogZlJ8m9D3X
 k8lRaugugSgFd10ISw/IsEkN1yyAfhlqgOqNXlL41JkYmUC0jpHEh2SC6col1nqv85J+
 STLGmvW/wgvWPzMg8oAPBrl4bgrhbQ+imthsUj1kEmNm8HFhboQlaR2m/SqbItsXk/6W
 CbYvsBfG6sJyTgkmSfQOmY3yMZ3QKblEpFv8mgzyHr37kVEO1z5QrL0ZFHkxQx4cDr4+
 XBX3UD9ymKzzRqatpKDgfjDeXCx1pkRRJZFR94puSUZv3/9v2gakLEEGuHoXdO6o8TE8
 9d7w==
X-Gm-Message-State: AOJu0YyURBOpxZx2tiukDzh9o08GBymrNk25wuNBFKKDwveWpt3iaNL4
 zvelFSOj+EBkUAx7kOEztTjcWbpcTiV4b4nIDgM1R2OhRvLUmlfrYr/orns+X1qXYaFMN0fF5sh
 ciaKTL0TsM6Wsw5sNKrygnfr91AmfXIUA1YIs8mx2LA==
X-Gm-Gg: Acq92OEQk7qW9gdZ2A4UE4GXrU6qDhL6xGLlTvvF9nv7t+2iaPAb43XrCTG57QfHy5p
 2kKzIooAX+Hr9GQQqM0+FcRDejzZrR0IJUetFYQnA5qkmCZbOVj9uNWCS/y8QeOBCz7CkK8wnrg
 2RhR1g2rOTSMumEO68Kki3tlFis0pIOCaoh+f4Z4vQQ33u62dBzkQ9WGUwjsGciwwsL5lTa9h0U
 r+b9iNDDo7gDDX0Pmacxcobp1mc1jbRPNdtGSZhLWreVpmbygxo8yTsOKSrr6+szJQofffKsuGA
 EiBfBIlsRhJBbHQtnbf7HgeTePgAOuykSo2ls8w6NE4T2/wL2LEKWuAQluoMnqb8EDUBjLsunrA
 eegll3WMu0jRI
X-Received: by 2002:a53:d005:0:b0:660:71c3:aadf with SMTP id
 956f58d0204a3-66106f171e7mr11183960d50.39.1780910679706; Mon, 08 Jun 2026
 02:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260521112806.504961-1-kraxel@redhat.com>
 <CAFEAcA8hbObntY8Tp+kOV7btb-io92O9GW99-6SPxigPJUjPrw@mail.gmail.com>
 <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
In-Reply-To: <aiE5LrpfnJRbkx-A@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jun 2026 10:24:28 +0100
X-Gm-Features: AVVi8CdENXUQ5vy8mT0gx7QJrIkh525pM64K1wcDTX4Imtu2W-EYWjQ_XZpwpe0
Message-ID: <CAFEAcA_ow2ro3h0nfhY3jA_XToAnjdVFNPrF25aWLd=X2cnmaw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm: add support for shim loading
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 4 Jun 2026 at 10:27, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, May 28, 2026 at 03:28:05PM +0100, Peter Maydell wrote:
> > On Thu, 21 May 2026 at 12:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Also little refactoring in preparation
> > > to avoid code duplication.
> > >
> > > Gerd Hoffmann (3):
> > >   hw/nvram: add load_image_to_fw_cfg_file()
> > >   hw/i386: switch shim loading to load_image_to_fw_cfg_file
> > >   hw/arm: add support for shim loading
> >
> > Any chance of some information on what this is?
>
> It passes the shim binary to the efi firmware,
> in addition to the kernel binary.
>
> x86 has this for a while already, this brings arm on par.
>
> docs update with some background below.
>
> take care,
>   Gerd
>
> --- a/docs/system/linuxboot.rst
> +++ b/docs/system/linuxboot.rst
> @@ -17,6 +17,15 @@ Use ``-kernel`` to provide the Linux kernel image and ``-append`` to
>  give the kernel command line arguments. The ``-initrd`` option can be
>  used to provide an INITRD image.
>
> +The ``-shim`` option specifies the shim.efi binary.  This is needed
> +when using direct kernel boot with UEFI secure boot enabled.  The
> +verification chain used by linux distros requires shim.efi.  Typically
> +shim.efi is signed by micsosoft and verified by the firmware.  The
> +linux kernel is signed by the distro and is verified by shim.efi.  So
> +without shim.efi in the loop secure boot verification will not work.
> +Usually you can find shim.efi as ``EFI/BOOT/BOOT{X64,AA64}.EFI`` on
> +distro install media.

Thanks. I'm not sure why you'd want to enable UEFI secure boot
when you're not booting via UEFI, though.

Do we actually run the shim.efi code, or is it just there to
be "verified" ?

-- PMM

