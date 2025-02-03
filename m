Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74907C0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 01:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1telJ7-0007SY-Rb; Sun, 02 Feb 2025 20:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1telJ0-0007Pi-MD; Sun, 02 Feb 2025 20:31:20 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1telIy-0006D2-Oe; Sun, 02 Feb 2025 20:31:18 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-51c7b5f3b8bso1213263e0c.2; 
 Sun, 02 Feb 2025 17:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738546274; x=1739151074; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXCJCrSXUkUTp1DmIu0lJK0yfYrll3qT0ys8xvAfP70=;
 b=iuXrpVXz+WVknmS33U+y1Sb/vYTuK/ptIK+tW7TuVDgmQfA51xPUT6seggIC9AT5wV
 obnr4wPPowTIRrm90/9SpZedyK3cOUVK3/DCGt5Jwtp8tLAPprCGzcqOou9P2jXs1XIa
 owxpJKHsxEHvqsdY3P71M2kSLir0XFHshsBzkXZhh8RoEIhVez1gB5Uif5Y2bMAlruW/
 evYutgRBWkASdWsvjdM94zJPEQk9vpqlvPAchYyiu7D5i6h8Fm+MxlVjXfNOyu2C7j6U
 6HeX20z5CpdjXgTwp46q34q5d5Lp8Vy6NfxVSQRaO32HfQ9NLO1K+Rdh51OLAm3tcuGr
 ojuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738546274; x=1739151074;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXCJCrSXUkUTp1DmIu0lJK0yfYrll3qT0ys8xvAfP70=;
 b=of34nSmU3ckZR0Hutr8XHhpVJA9JJoxU8mVZpBqPakKjMalE5Ovieo3ukQhh0HUDsG
 ipL5SDp3KqDSyss/zBGoNdoCLxSzhOMBAgdef1Me2UMqCJftQGs0rmoEaCu/ik0n7Yl4
 koHmgGEkFwT5SEm8qoHSqYGz35U2kzLy+zDCR4Y61eKwQbhISxzr0ZhsGc71TgQum7Lf
 kMM6bvt/nU3AtZZgtvPFtH2kFeDe6PMR4r8SO8YeHA6DqDiV11sjtvY1+C0a5i5VRXdo
 PiqwgEC9fq34Pjepy2TOnyGaIlzQfc7ON1EBv8usVpbYXiztRdlf5Q2Va6pVJKy9pASW
 WG1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Tmnuo5MOeZwKCKj10rzvV7zQOSy9rW0b3n/l+Sb2K32jDos3/bMliiKM+2d0+UtVFUS9CmcKiIVW@nongnu.org
X-Gm-Message-State: AOJu0YxrH0FXiCruBxpdirjVQhm10NKaBvA58gCNbQgb+DUQ7BG0AA4Z
 dUPoEBeUTJMYTnm95eUW7iBO0BeWXdJlZ6b1XP1IAlcMrjgXbnouTtm2ghxvKMrlvH6omoYW+KJ
 8CmTcbj4h30lI1PQpLBegAV5PWmk=
X-Gm-Gg: ASbGncvpxSIp9M9WLNU3QtBjnogUyUAQrA3jLGP6as649URm/Q8/8/rj3SSud5ifZbE
 nNi8QpBthL//amC4///kQ9OWJKCnOJCXEU56ygbpsSdT9wMN8leMSOz0h21zZsOXSfX87g+bzpL
 kWXXHRwHIcLDrKCTifa8XaDFia6A==
X-Google-Smtp-Source: AGHT+IGuU0+8IQPOweAi1qVqQshNtv+eDZVMGGXd5C6rLZXaDl8oxrz5m7kWMU4w6KwonO3n865JeTNchK2oh88SIc0=
X-Received: by 2002:a05:6102:2c0f:b0:4b9:c326:f998 with SMTP id
 ada2fe7eead31-4b9c327004fmr8828119137.24.1738546273638; Sun, 02 Feb 2025
 17:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20250128060546.1374394-1-alistair.francis@wdc.com>
In-Reply-To: <20250128060546.1374394-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Feb 2025 11:30:47 +1000
X-Gm-Features: AWEUYZkbWOMIJBcsNqGN-J9KkiS-Fzzn7NKRk1p8arRBpLs6JQ5hOqnY0WRfxSc
Message-ID: <CAKmqyKNyjq=SdHAefyzVP1wj=o5-FBOLf61MAe0KtbsMO6K0cA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Bin Meng from RISC-V maintainers
To: palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, philmd@linaro.org
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Tue, Jan 28, 2025 at 4:05=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> Bin Meng has been a long time contributor and maintainer for QEMU RISC-V
> and has been very beneficial to the RISC-V ecosystem.
>
> Unfortunately his email has started to bounce so this patch is removing
> them from MAINTAINERS. If in the future Bin Meng wants to return we will
> happily re-add them.
>
> Note that I'm not removing Bin Meng as a "SD (Secure Card)" maintainer.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  MAINTAINERS | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7be3d8f431..a0e305aa99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -318,7 +318,6 @@ F: tests/functional/test_ppc_74xx.py
>  RISC-V TCG CPUs
>  M: Palmer Dabbelt <palmer@dabbelt.com>
>  M: Alistair Francis <alistair.francis@wdc.com>
> -M: Bin Meng <bmeng.cn@gmail.com>
>  R: Weiwei Li <liwei1518@gmail.com>
>  R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>  R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> @@ -1599,7 +1598,6 @@ F: include/hw/riscv/opentitan.h
>  F: include/hw/*/ibex_*.h
>
>  Microchip PolarFire SoC Icicle Kit
> -M: Bin Meng <bmeng.cn@gmail.com>
>  L: qemu-riscv@nongnu.org
>  S: Supported
>  F: docs/system/riscv/microchip-icicle-kit.rst
> @@ -1626,7 +1624,6 @@ F: include/hw/char/shakti_uart.h
>
>  SiFive Machines
>  M: Alistair Francis <Alistair.Francis@wdc.com>
> -M: Bin Meng <bmeng.cn@gmail.com>
>  M: Palmer Dabbelt <palmer@dabbelt.com>
>  L: qemu-riscv@nongnu.org
>  S: Supported
> @@ -3721,7 +3718,7 @@ S: Orphan
>  F: hw/i386/amd_iommu.?
>
>  OpenSBI Firmware
> -M: Bin Meng <bmeng.cn@gmail.com>
> +L: qemu-riscv@nongnu.org
>  S: Supported
>  F: pc-bios/opensbi-*
>  F: .gitlab-ci.d/opensbi.yml
> --
> 2.48.1
>

