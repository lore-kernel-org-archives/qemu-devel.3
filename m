Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F48C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 03:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOTPT-00052e-FW; Sun, 08 Jun 2025 23:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOTPR-00051x-3M; Sun, 08 Jun 2025 23:42:53 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOTPP-0005kn-Gx; Sun, 08 Jun 2025 23:42:52 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4e773c50385so1914661137.0; 
 Sun, 08 Jun 2025 20:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749440570; x=1750045370; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SeXuhu/MTPN6ipXeRBjbBQRHBKI5PimiBHoP5kZ2alk=;
 b=Gx9eKacgs+8PwNxV2oANvWsOChw8Up9lHKYR6+i/Ne6bFMqe+A7rHiTj1tdEwRFDXC
 Fa2PB/DdGifEEHUtq/MLtHOhYMhcRvD0UVeGRX9Wcqv2HQdrfPSLt0kV7o2d5aldR2zE
 FeJsKclxrwvHU0r8I06/ZA007UVfkMQs/r5Cgl3LP+hf3GxDPV+cb38KeVMxx+qlZ0Yj
 yduDgBXy8F/lzLR8U0dXDzXn7bfs4aMtM0xHPz7R1cdyHIk56s/C/2Qqy2FCJ3kIr3Vy
 5mq0Y+sMeZlZK9AapJgvdxjkj807gYg05EfiVW6TA7QwFsIRGZYC3t6vkaH/1sGwwWLW
 fYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749440570; x=1750045370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SeXuhu/MTPN6ipXeRBjbBQRHBKI5PimiBHoP5kZ2alk=;
 b=k/HnsfLHoTNJyTWSqWncyNE8nhqds8/Xf60WzN3n6/rRhHcjiRI8C6FaDvn7X2/8Of
 26sZGkQLGDY8vqUm3qskAftXkHykWQfQZgU4k6Qe1LLKJvhsgpSEAOjqkzMWxy9zq6rW
 QwbvpDKnlomvF4IEcP+M+dCnhR/d3+voxQ4Xw2mx81+q3MGQ5HzOeMw5i4ZPsDd1PQQV
 GovmMefZW5fktkbywAJggrtlr+Lv1NGz1utDenD01yVWXO2g+yYNuWji9T63BkUMkI1h
 j2cfZOBhxKF7iz1csglkMfVuTL/OGALdAQQcVadHn8cel8Np18QIKmyFwB3vbJ7c9heD
 vbGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPz/G5BsxJG3+PSZvDGafwKcc2hHumwtu8J6voRdyB1NL1Z/SU1QaDgrrEjxOmtpKJfkn+91pcEQB/@nongnu.org,
 AJvYcCWAcJhtEkLtPsQBI9+G3twBnXSxxRiAuiVMjiNrNQJafQq5bcbKN+pXx9u2PsZxaLgydkY+OC7yPH9s5Q==@nongnu.org
X-Gm-Message-State: AOJu0YyFJuNt35+wNYhEBouW8H+2SCjvREbMesktevi+R8nTS6sk/+u0
 Aqyxu3WyzNw7e/N+OalUcPht8CBo+PlLORh4/iP42ACyZCd/ySNCk5Q476rlUn0TR9TQNYy98j6
 oiJePyOa++CEyo/wrioNvB5JKNo8nDq8=
X-Gm-Gg: ASbGncspnNwEebNFToSqQk9Sy4OPlYhSoIjajMNGdQ0V6hXUUnjZ6SwopD2mwfDGSba
 JZXzNw+/zQJeHS/cYLcgAC+vMFH5/KTvrT4Xdu1f1veGfhMADC05nGdyMX+n6524pbOPBOtWK8k
 9s4XqgKaF9bNutmh4SxSoHqq1Zqc7Dako0DpqmONkF1efS+tLe4ZWegMok0Ev67xVeGIjtUN0Ih
 g==
X-Google-Smtp-Source: AGHT+IHIS2xWSEcrXxMdYvv39oQOMrHe334qJZ+VNHxQ/L5QldJL17EMOJ5v7fxdxqfGCBySxowy+ZUXEi5jfZS/1mM=
X-Received: by 2002:a05:6102:5487:b0:4e6:d9b8:ddd5 with SMTP id
 ada2fe7eead31-4e772a2af39mr9352116137.17.1749440569965; Sun, 08 Jun 2025
 20:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250605124848.1248-1-liujingqi@lanxincomputing.com>
In-Reply-To: <20250605124848.1248-1-liujingqi@lanxincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Jun 2025 13:42:24 +1000
X-Gm-Features: AX0GCFtxOU3rE3j9DomMbeuvnbVyUgWC1D02BoapvIk3plvigJRTzpzspu5t4Lo
Message-ID: <CAKmqyKOj9RnDX9hmZ=yqrmSM3Q+U96UJ9pFiLengb-vk=ydWkA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu: Fix PPN field of
 Translation-reponse register
To: Nutty Liu <liujingqi@lanxincomputing.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
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

On Thu, Jun 5, 2025 at 10:50=E2=80=AFPM Nutty Liu <liujingqi@lanxincomputin=
g.com> wrote:
>
> The original implementation incorrectly performed a bitwise AND
> operation between the PPN of iova and PPN Mask, leading to an
> incorrect PPN field in Translation-reponse register.
>
> The PPN of iova should be set entirely in the PPN field of
> Translation-reponse register.
>
> Also remove the code that was used to clear S field since this
> field is already zero.
>
> Signed-off-by: Nutty Liu <liujingqi@lanxincomputing.com>
> Reviewed-by: Tomasz Jeznach <tjeznach@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> V1 -> V2:
>  - Commented by Alistair
>  - Reviewed by Tomasz
>  - Remove the extra code
> ---
>  hw/riscv/riscv-iommu.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index a877e5da84..d8b1cb03a8 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1935,11 +1935,7 @@ static void riscv_iommu_process_dbg(RISCVIOMMUStat=
e *s)
>              iova =3D RISCV_IOMMU_TR_RESPONSE_FAULT | (((uint64_t) fault)=
 << 10);
>          } else {
>              iova =3D iotlb.translated_addr & ~iotlb.addr_mask;
> -            iova >>=3D TARGET_PAGE_BITS;
> -            iova &=3D RISCV_IOMMU_TR_RESPONSE_PPN;
> -
> -            /* We do not support superpages (> 4kbs) for now */
> -            iova &=3D ~RISCV_IOMMU_TR_RESPONSE_S;
> +            iova =3D set_field(0, RISCV_IOMMU_TR_RESPONSE_PPN, PPN_DOWN(=
iova));
>          }
>          riscv_iommu_reg_set64(s, RISCV_IOMMU_REG_TR_RESPONSE, iova);
>      }
> --
> 2.49.0.windows.1
>

