Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCE4C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we06u-00085I-D7; Sun, 28 Jun 2026 20:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we06o-00084r-A2
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:44:22 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1we06m-0002Gq-Al
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:44:21 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1274bedebfso4195366b.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:44:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782693858; cv=none;
 d=google.com; s=arc-20260327;
 b=N8W2SeNn4yNdobS8F8syAN7NC5GAMMzdZ1xvvdbaxqCuAI8pkJ4yiBOcdiIgfvxche
 xMO6GFZFs6gXnGsCjLCr0oDcfAbW3QZbx2NRDFnKUVgHWgDPsiv/5fWbgfbfkoA7qag3
 8ZFRtLOfOouHF0Rv/9FSnyni60AzUyOstT8C3Xemh3lXnncSErwLDTrAqUP0FUTzRo1s
 uPTRuIphCBRwdn6MUhYiyng0MiDcQRIYZoUsx3VGcYk7Fh1/ExBGBsFv/T6O5mmQ6HSC
 HQU/sj7dv89WfZ12d9o8/jIL8Vk2fy5/4WRKH8s0KOw//pPAQD8H+2HoxkNURlRxDEUX
 s+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6uDtZ0o+j0rDvg+zteeOITLj0DNIRtEZN3YEFYkP/fQ=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=PRXTrZiIUV2AnbO48DXPKjlXVNrNBhqnIXXIt1mIhWC6glU2bPOTTeflLs5ZX0OZAy
 3i3YqZcmuyBziNpNs08su7RiBXVf6mvgaK1fExVb0QKqXMB6n1XXaKQTc1BQPgQfMm2F
 5XacHEZq05MsmmQbDWxpjKeVlVAol1r8E0Upi+dLCl0uhoO1or+iTDi37bSbGMTDvydE
 3Lvcb+UCd19JaaVBSW0jFhtjfvw2kmxBCXwEvq/raaU3nwBMiyZPU+bZznDH/LquqoBO
 OIdNjp/HYKGOrGw/p0kiGQobMVTuYnmbephhsB0cm0Wj+sXEfj1KNCekx4lF5VDjNUzX
 0Sjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782693858; x=1783298658; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6uDtZ0o+j0rDvg+zteeOITLj0DNIRtEZN3YEFYkP/fQ=;
 b=mRWOY46NsCvRiBjdBAxJlHuXqJtygBGH60uWV6UqI31CkAneqHjestIDuIIHucomQg
 BXVV/deVYFcH80LBKoovUB7wurBfU0dRhc/Quade4g3Bb5erou4FgL5x3T/YC81HRUj1
 ElLClm2g+bA9V2kQ+s8Kcb87DaEqpTltS3vOZPfKPOg1+nxpo0fVSIlzS7Rqw1+geMv+
 hUTWSCkMLPU8+n/udeOI5V1hIBn2bm48jM8jC0Mjy7leROO/rY1jVyg4uYQMMdCNNxwP
 o33yW/Ym7KLdwgvHoNgQ4YO1RkCSF8/HSp4JNtgdgtfRMO1otRXNwXCVqqdgkYFEnLVB
 5sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782693858; x=1783298658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6uDtZ0o+j0rDvg+zteeOITLj0DNIRtEZN3YEFYkP/fQ=;
 b=cKQl7+jR1+9y1+l0aj0rnKE3L+YvhDqSnfKBVTou4sUB6zWUklUisfibmw5qhXzTzA
 fAYsl609NSnwsIlzDA8BNSt95fn98Abs1rf6uq2IS4u9vCFN3+DikoNrC0HpEpfFNy8t
 UIvdY6iAeVfwf3unic4uhcYsl7zo0FkjenZseDxpQApZdynQdveZXxsKLWavHVGAAT2E
 NSD2Rb9ZU+V9H8SEwivKA4zBB0Zr6tQlm5ok4DF61qLNysD+OqxfT0KrWpeFQBKJvu7B
 Pofz854nPw11Qruko3iBD4gJ4GmYp0DASU0tZqGLGESJYjKA5z7ZDpplV8BxFE1cdHWS
 jNDw==
X-Gm-Message-State: AOJu0YxUhdfRbKQSV/PCYAGxI4M+mw2LuwFNWXi5Lgwtj4vuL3iDAeb0
 9CaRaI4xfJD3EaYPnVN3cMmqqdItKlFFgXBp3DA4kI42h7pXUVCombvFHY+LcISXNlJXGwXk4Lu
 Ksn6u5sxOiosi8tdpi9cVDK+KutdZZpM=
X-Gm-Gg: AfdE7clnY1lilaZp/MxNRyvSqFJQUBTtbnPWzYs/ElTTtZAoA/yVwYacn+DA07xn91B
 UZn6WDsrQ0ZohwNKoddmW3CHh6eLKyQ2MuzFQnQ0X7MXCo8Ia8deteKKS4wmn/Pk6GUeapN50JP
 qIgU1NXDZnuSEBREtqJFy6kU2MqHSTcXUr/yMxHZRXTCnOt4rUXTEMksdG8300EeOhe4XXc4lH1
 Jjn8CJjc04729Hs9puxze/5KwXPaaSqZWv8oyd1Tpu8QFr9pGbIDKV6HTSPJ63wQF3FRNHXVxog
 lBtn8jpnJ8cMDnFE6/AUlSINzOo=
X-Received: by 2002:a17:907:84e:b0:bee:6806:d69a with SMTP id
 a640c23a62f3a-c1205ec932bmr793140666b.38.1782693858281; Sun, 28 Jun 2026
 17:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260626173341.3661446-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260626173341.3661446-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:43:49 +1000
X-Gm-Features: AVVi8CdlrV7cImRpN6aj5OEwwzpJ2hmUv6aO7Hh-L60PTNQuWuSRW9qIs-cP2Mw
Message-ID: <CAKmqyKP_ynyLb=ELf9f_aOMv+F=zjoiNpqBV_WD_BkNoMiuMNw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu.c: set RISCV_IOMMU_FQ_HDR_PV
 appropriately
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Jun 27, 2026 at 3:35=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We're hardcoding 'true' to FQ_HDR_PV in riscv_iommu_report_fault().  Use
> the 'pv' bool the caller provides that indicates if the process_id is
> valid.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3556
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index d47abf9eb3..3ea9130860 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -580,7 +580,7 @@ static void riscv_iommu_report_fault(RISCVIOMMUState =
*s,
>      ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_CAUSE, cause);
>      ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_TTYPE, fault_type);
>      ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_DID, ctx->devid);
> -    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, true);
> +    ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PV, pv);
>
>      if (pv) {
>          ev.hdr =3D set_field(ev.hdr, RISCV_IOMMU_FQ_HDR_PID, ctx->proces=
s_id);
> --
> 2.43.0
>
>

