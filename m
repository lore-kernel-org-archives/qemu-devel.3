Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65C6C0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 01:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thIWF-00077I-7I; Sun, 09 Feb 2025 20:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thIWD-00076w-7V; Sun, 09 Feb 2025 20:23:25 -0500
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1thIWB-0006RX-BG; Sun, 09 Feb 2025 20:23:24 -0500
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4ba7d7aa995so720027137.2; 
 Sun, 09 Feb 2025 17:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739150601; x=1739755401; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHaNFzAkQ/6cK53w3+F9cdjDsoiZOwToRR9MmMtflXg=;
 b=Cg7aT9JaYi17zkAtMYatxYEDHVO7ZIpJbdbMWbjmYcZYmerMDWg0zRzJoC0ZKtmX4w
 omQe4RRF7tnqhCcg5r1XUt1uzUSEj2yZvQ1Y9xkPCP5uOpzaGXExzzOGrba2infr+SS5
 r6boK9JDx36NmOmMD9KZstE6r4yfSgNVW5gFdXy0hZYM+64FWchaGVSeCdnVh1Yy6RGM
 OV/CF2tzz2LTX7jCp1hIg93o71wGGsk5Kt++JvfpSAWIL5AjVixQ2d1Dxsh41JTxNoXq
 SX28H6jscEkkWv8fukMpDI0xJMBh9D3J/U1foNUjwrGvxlUyGIsZoceycc+nsPRaTWg7
 zHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739150601; x=1739755401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHaNFzAkQ/6cK53w3+F9cdjDsoiZOwToRR9MmMtflXg=;
 b=DAdUuG39C9z42SH3mIX/v54uw1jX76OYJ3ysb9jlBHB5+EHwGjqewew5RZD3FHJn+I
 S0sOH1gLJ3mMDu46pG9JE7p+OzkdLyB201csCeQ1M0kKUfeh4x7jQC9J30EWiC5izbJz
 kz8tFEaYry6VYjiRdxAzUQvbev3RDPGTqP6mkVVs15whpZHHfpN/VL4wVTK9rcWqpTNS
 E59c+Kx+vEKlOZXZc7LaLo/KeRtgMly8oOKldREjvUZ5I9P8okY15TbXsznbMxhxfxqQ
 XLPnD/CVMxE22vC1hPofvcZh1YeJRmHpAkcP9G3LRz0ttQqzIUV00MVrCOe2PhQsBZL2
 No8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFohZgSrXh3SdYQ06AdsFQrx+I1LOAvLLBqKIEn4hJnP56hMtGioE/kX9YqaZtgcKJn6YOrMWfyDvy@nongnu.org
X-Gm-Message-State: AOJu0Yw1m8Qi/G4Rv9VelEdz/fukT11f87Lg6xDK8zgnCN97BoyASx8N
 SYXnPFb4kFlzdE0IDF8wu8nXIpYSbD+ZLYTBw5kxaYpKuzCZz0yIdqMunSTOMEAXyZUMWurbWVf
 AWqarR3MI3FQxiLRLtygfsNfeM5k=
X-Gm-Gg: ASbGncsd6lQLc0Q1kgwjluCUlEf+K6E0c+Pv/szDpzHJ/36FupPE6v3c5Z/TXARpZYV
 OQaJCQjFWCKfXk3kk3Tsijs0cJ6hzLA8eE2omzCNlrrJ3XPR5DIaBZy1tEGj//HCas+bmtCuUs5
 GB84VX5jPazFSwenlnHTBt2/RC6g==
X-Google-Smtp-Source: AGHT+IH4R8HYJeaAsHJhqNHjV5UitH8xV8l0ZQ3I2bJTxmsBpAB+QmptnG5P7rhuDobT0TCsIHqMJh03mDLLaqqp8sE=
X-Received: by 2002:a05:6102:6c7:b0:4bb:b868:9d2d with SMTP id
 ada2fe7eead31-4bbb868b96fmr2874583137.24.1739150601590; Sun, 09 Feb 2025
 17:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20250206-pmu_minor_fixes-v2-0-1bb0f4aeb8b4@rivosinc.com>
 <20250206-pmu_minor_fixes-v2-1-1bb0f4aeb8b4@rivosinc.com>
In-Reply-To: <20250206-pmu_minor_fixes-v2-1-1bb0f4aeb8b4@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Feb 2025 11:22:55 +1000
X-Gm-Features: AWEUYZlx7Zx1AzCC_umnj9vvKQ67ru_U6JKwfiYh3fU3erUW_iRMXka0DDibgBY
Message-ID: <CAKmqyKNv5Mz=y-SP89FpRzgsTK2grMpv1rPNU2OPN1PbSHQD3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Fix the hpmevent mask
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Thu, Feb 6, 2025 at 7:59=E2=80=AFPM Atish Patra <atishp@rivosinc.com> wr=
ote:
>
> As per the latest privilege specification v1.13[1], the sscofpmf
> only reserves first 8 bits of hpmeventX. Update the corresponding
> masks accordingly.
>
> [1]https://github.com/riscv/riscv-isa-manual/issues/1578
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index f97c48a3943f..74859c4bc8ff 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -933,9 +933,8 @@ typedef enum RISCVException {
>                                              MHPMEVENTH_BIT_VSINH | \
>                                              MHPMEVENTH_BIT_VUINH)
>
> -#define MHPMEVENT_SSCOF_MASK               _ULL(0xFFFF000000000000)
> -#define MHPMEVENT_IDX_MASK                 0xFFFFF
> -#define MHPMEVENT_SSCOF_RESVD              16
> +#define MHPMEVENT_SSCOF_MASK               MAKE_64BIT_MASK(63, 56)
> +#define MHPMEVENT_IDX_MASK                 (~MHPMEVENT_SSCOF_MASK)
>
>  /* RISC-V-specific interrupt pending bits. */
>  #define CPU_INTERRUPT_RNMI                 CPU_INTERRUPT_TGT_EXT_0
>
> --
> 2.43.0
>
>

