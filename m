Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA64C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 00:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwFV-00080R-IP; Tue, 28 Jan 2025 19:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwFM-0007zY-EJ; Tue, 28 Jan 2025 19:48:01 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwFK-0002Vq-SW; Tue, 28 Jan 2025 19:48:00 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5160f1870f3so1857550e0c.0; 
 Tue, 28 Jan 2025 16:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738111677; x=1738716477; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lz26FLioiiDEbLzbWJndIdzGUsjgsatgdS60Qo1tt6c=;
 b=GMLeQtlwqdhHQrU8Edd9kAD2Rp3YgloGI9/DrDN4xTXsoCSr5wDmzp9GUoYOha4Ikv
 WviudYNspkzny0FjFb53LH/49oy7o9kNNZxCRjQpQsosemzxPmws1Um68CX41nD/L5sv
 thHfe5fUg9hYwy0u3SlNiPtqMtkDFQTFhQv4mW0MSPzEMUOWwGLro3z8yN7jfvw2ufqs
 3yWpDfAiRrXidbZ+GvxGUc11yJb5ilQ+Iobdovx/Fa9VnclvxuHLEfMyHz7N11v5lwgE
 KqgJAx9FzbDIirsUtK8lWMmQjoCKhJEnzXoNJJ2QbEl7gxbtI7M405uHAdM1dLgqt6dD
 dDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738111677; x=1738716477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lz26FLioiiDEbLzbWJndIdzGUsjgsatgdS60Qo1tt6c=;
 b=rE20eottmCHVgJvL0lDPAsaMH9LE1xx0/9CWxRZ1NLAstPdS5LqWji2GnH/W4qQMoG
 uM0S3xtKG9Bb7R7qYh8wvFjulXjGMCQsJbyXe1iiviACnmQ8HO73YQE7kBzZ50kKeHc1
 wo7gTqMg73aF0Cl41cTDZZ6skPHLnNTEbI20UZL0CmN0e4Kl8gtXWG/7xofRF+VDO8Kv
 iW9SoZbGVjxj5vK9WeWRoLoBcM7C0MtzTsd9EmKX120gpSbrzy+SckSTg/sUHhi5HK5w
 q5ve7IIi9MZLXcG4O5gIZonq+SoQOXshxiOGyprks7g2atp02ayQo9l2bqpE5rZ8oUCs
 H/Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/kFz4642DfyJZYLJ5oZj1mfaHP96/x7lWaLgdFE/anlv02wy8UFNFt9KtX73Mzy8Z4gE8fxUd1QB4@nongnu.org
X-Gm-Message-State: AOJu0YwfAHZtdMdcz2Va0se0VJlAGjLBDSlEkr7T9YoIctP3hLVZId5+
 Ix/oDncT6nGUifTEGWZ3ddlekILaGATn+biAnTdjyib7r9iGB8VeuDPULcmL0L0btMD05ZzNeXo
 9zP4bLzhO3Fl+WxL01sEJMxqW80U=
X-Gm-Gg: ASbGnctBZPqEK+mC1llzeCsw9QQ48Ll8/YqatNMEd+jbRzpW4wL8B+RJpVhK34/A7p8
 pFoLVbQJHdbvVYpIq0o/Y2SxMoUZbQdtLeCmhkv37VwNKtWVyq+iWgptTBRzn8ZJZ35/9ocYxp7
 CkyG5LGCSRzmWe1rx6mz5GO9eH4w==
X-Google-Smtp-Source: AGHT+IFkzih4C69SB9h0mjRMPCeGNdtxXYh7QkjPV7AXu9/lNh77T3KTh9YsrX2nJI3JGMuyb1RPXUR6b3q1Yv/UkZM=
X-Received: by 2002:a05:6122:4011:b0:518:8753:34aa with SMTP id
 71dfb90a1353d-51e9e5699b0mr1750036e0c.10.1738111677271; Tue, 28 Jan 2025
 16:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20250115-pmu_minor_fixes-v1-0-c32388defb02@rivosinc.com>
 <20250115-pmu_minor_fixes-v1-1-c32388defb02@rivosinc.com>
In-Reply-To: <20250115-pmu_minor_fixes-v1-1-c32388defb02@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 10:47:31 +1000
X-Gm-Features: AWEUYZl2ypl2sahTaOYD53IpHh4gSdrQH4ojqbrHkQvHBM-xTcFtxTTWjEam2e8
Message-ID: <CAKmqyKO9SLuAnXNG76g-RQfUYJQZWTuUFWpzTC-hu37X2_OrUQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: Fix the hpmevent mask
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jan 16, 2025 at 10:51=E2=80=AFAM Atish Patra <atishp@rivosinc.com> =
wrote:
>
> As per the latest privilege specification v1.13[1], the sscofpmf
> only reserves first 8 bits of hpmeventX. Update the corresponding
> masks accordingly.
>
> [1]https://github.com/riscv/riscv-isa-manual/issues/1578
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  target/riscv/cpu_bits.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index f97c48a3943f..b48c0af9d48e 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -9,6 +9,10 @@
>                   (((uint64_t)(val) * ((mask) & ~((mask) << 1))) & \
>                   (uint64_t)(mask)))
>
> +#ifndef GENMASK_ULL
> +#define GENMASK_ULL(h, l) (((~0ULL) >> (63 - (h) + (l))) << (l))
> +#endif

We should use the existing MAKE_64BIT_MASK() and avoid adding new mask macr=
os

Alistair

> +
>  /* Extension context status mask */
>  #define EXT_STATUS_MASK     0x3ULL
>
> @@ -933,9 +937,8 @@ typedef enum RISCVException {
>                                              MHPMEVENTH_BIT_VSINH | \
>                                              MHPMEVENTH_BIT_VUINH)
>
> -#define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
> -#define MHPMEVENT_IDX_MASK                 0xFFFFF
> -#define MHPMEVENT_SSCOF_RESVD              16
> +#define MHPMEVENT_SSCOF_MASK               GENMASK_ULL(63, 56)
> +#define MHPMEVENT_IDX_MASK                 (~MHPMEVENT_SSCOF_MASK)
>
>  /* RISC-V-specific interrupt pending bits. */
>  #define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
>
> --
> 2.34.1
>
>

