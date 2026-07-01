Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 216ABC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wes9j-0006Ob-I1; Wed, 01 Jul 2026 06:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wes9h-0006OI-RD
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:26:57 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wes9g-0008Og-Cv
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 06:26:57 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-664ed6f5a48so106751d50.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 03:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782901615; cv=none;
 d=google.com; s=arc-20260327;
 b=UtHueDRZh2huQIHcgOoqQtRg1qbZDkC9kyTAYwQ2y+RH1rOLKFlcfy5mOzVaFW6D0s
 CCW4UBOZEbCvsxP3Sb6esX0KLrIUYUPTVij63BgdcZAiEZ69ch8RZiDggAWmn2F9onFc
 ApfD60b7HnOnhP9oxgIkr/dL34/IpmHIcZqOeJsNEAhrTSdXDRJ6bpsAW6nBhNr2B62D
 Vcryn8ji522vD4+kBv1OHreuxnDjklO1X08Vhdrl71td//mEkx44qPMrsWr3S0OUepXi
 ILhmHh+lFRKmy5wFj7WNgiNnBUNyB/u+JA4PolceTDfFEqx6WV7BBB1C3W0Y8GcXB4wi
 dmYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qYFW+WWfD5PaezUHltz0slqO0NBPEqZ8G1dPDnwB95o=;
 fh=qEaSV5hml6/+5wir6NShGHQvRue/Q+GVG4zia7ZRHxI=;
 b=G0rRYRpSJKgdD7HOqJlBAPC3JwhfnHUK+2VPTx1GGQXnQ4oj8MvnNdLZWkWzS+fg53
 3SxplPpm1TVreWhebx3v8ro/NO6kVKwRjQa2mUnLy8mXC7linQ+gm6nutK/fF/A5yWzk
 Szj7mb+KFdVNeigzX0B0vG8x3qDIcEesoGRH6zW08+XccNywlpSk3Y/cSOHJkHvljF7s
 rH25jA63xwEPBI9vL6KY/lSLYCSf3HFrVT1cLxg1sXQUhlDVzXv4wZK/TJpH7JEfKuw9
 5tn00/5i5QzxgKcm1U1+BIDXUTvJeKvH/lzOxHUpEmoJdamtc0YhsF3xOgLoQ/6LXYiQ
 3cMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782901615; x=1783506415; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYFW+WWfD5PaezUHltz0slqO0NBPEqZ8G1dPDnwB95o=;
 b=Snr0pr8dBgEnl5G6P9zMtqep+6P0d6SSP7uB5iuTNTK2X6KvAnODhoWBBidDa/k+JW
 kOEl3xJcpdkEHLC7EaTf4SqoNpmAMI+jBOchp0qeC10ckpw9k88R0jOPuUyVPToQXssW
 M2siy9NAKeRCzXoWzJYLK8gJLvN1aLDHypqgXTZyhE/qh752APpzQUnZrF6iGk7+NEgI
 bIWtrLoAWF/n1jZcXWFua+fabooCHRo7TOWG0LC1/Wwgzjs7LKHmEgDiWhfk1BwxkVuK
 4lbGD0wXXmajqGOpDLcC1v105xv7nFuXo35w7E4gEDhB6lstBcHpA0Unpu/yLQnJjtZW
 r0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782901615; x=1783506415;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qYFW+WWfD5PaezUHltz0slqO0NBPEqZ8G1dPDnwB95o=;
 b=n3iYcy53GxQdCyI/M4BWuOnz/pBhXXYo8g9L8d86qvrV2gb9KPHV/ZUppjXIyLSOB2
 5A4CheyJR52XH7WyAs1KVbCgBcJ5e1+JEB0iwTVdhVQYRNfH+JrGoEqeZ3RCPTitnPJ9
 5Daj9I5+a8NMed4MfORSOVYVTkdXSXn/k/NPdkfoTlaq8i8G/B2OaZjVlTa0Pce35jW9
 p6xpfIAfg3dxHGgzo7YeLGkKUdfwlzcyOpdb+jwqjR0oN2W7T44PpnTysuO1+kxz4iwt
 vqY2A3VwV0Agw+wPsVbzV0Yc6ILTFQgseCKNGO37vJtQjj5zCCpYrYfBTbxgO85Uv3I+
 AHGg==
X-Gm-Message-State: AOJu0Yx5RkSTYiv8cEPKhSQf9HJ/Dmdcjo93cz5x3AOk+LUnOkH2flHX
 +Hl+j1dEMMENv97pBS6gBARLB7CzgK2zfeyxdsLrhF089PUPJGy6Sj46URydRJDs16tYVTxK15B
 eQ3Hpnu79dlOKr/WTwHxvKdvCa0Al0UVXAL7GIMDuXG2AGJmObEmw
X-Gm-Gg: AfdE7ckDPM4Y3W2+9yFtngdySzDRAHnhFF33SAHW0e136l3y5mnxGwnXphv1mQDDceN
 ExVnJJ3JToRTmotU35OvOUVSFsBKjK4Ip7YJm33V3WQ5QHPcjXW9mdaXZIBTihlhGRZDIO9rlzO
 livuM+vZM8hDkAejDPVIXA0//5nuKmdXInmvUwyWrLjqHrRSI1QecDfkzkS56nFZlT7e9lNSqbR
 H0M6BhII7+20x0dLNgEE/Opunz5DSo69622Zp9svcmLvi5fn3kDx5/qgllPncM1Oflri+PioC6a
 PBoaQXbvV6a2woqESgXg63vvsYZdcCP1SOzwDsOC4LfnGm8bzPt1g7uV
X-Received: by 2002:a53:d017:0:b0:664:e1e4:4f with SMTP id
 956f58d0204a3-665219bd539mr1043218d50.24.1782901615191; 
 Wed, 01 Jul 2026 03:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260701080843.2418461-1-clg@redhat.com>
In-Reply-To: <20260701080843.2418461-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Jul 2026 11:26:43 +0100
X-Gm-Features: AVVi8Ce-Y6XNJ3BifL8B0hSXMi8CKJAUt0ecpvyRRdxjQdr2x-wDJnrmSJ_0jfE
Message-ID: <CAFEAcA-QHJ=HaBc5WSLLap8NdDw+tty4EFfGt6cmmNOK6e_m7w@mail.gmail.com>
Subject: Re: [PATCH] vfio/listener: Extend safe misalignment check to tpm-ppi
 region
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Wed, 1 Jul 2026 at 09:09, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> On aarch64 hosts with 64K pages, the platform bus MMIO allocator can
> allocate the 1KB "tpm-ppi" region at offsets not aligned to the host
> page size, triggering a noisy VFIO IOMMU warning at VM startup:
>
>   vfio_listener_valid_section received unaligned region tpm-ppi
>     iova=3D0xc005000 offset_within_region=3D0x0
>     qemu_real_host_page_size=3D0x10000
>
> Commit 851d6d1a0ff2 ("vfio/common: remove spurious tpm-crb-cmd
> misalignment warning") suppressed this for TPM CRB devices via a
> TPM_IS_CRB(owner) check. However, this misses "tpm-ppi" regions owned
> by other TPM types like SysBus/ISA tpm-tis devices.
>
> Avoid enumerating every TPM device type by matching the "tpm-ppi"
> memory region name directly in vfio_known_safe_misalignment().
>
> Signed-off-by: Cedric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/listener.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..c76ba285ddb7ef4f93bb081e6=
7de47b3aecbe212 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -355,8 +355,10 @@ static void vfio_ram_discard_unregister_listener(VFI=
OContainer *bcontainer,
>  static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
>  {
>      MemoryRegion *mr =3D section->mr;
> +    const char *name =3D memory_region_name(mr);
>
> -    if (!TPM_IS_CRB(mr->owner)) {
> +    if (!TPM_IS_CRB(mr->owner) &&
> +        !(name && strcmp(name, "tpm-ppi") =3D=3D 0)) {
>          return false;
>      }

I think this is the wrong approach, see my comments on the
other email thread. vfio should not be building up some kind
of whitelist of "this specific not-page-aligned RAM is OK",
because a not-page-aligned RAM backed MMIO region is in general
a normal thing to have.

thanks
-- PMM

