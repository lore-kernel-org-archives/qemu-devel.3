Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB449C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VVz-0006zB-Pm; Thu, 03 Apr 2025 21:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0VVy-0006yW-H2; Thu, 03 Apr 2025 21:06:34 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0VVx-0007g7-0Q; Thu, 03 Apr 2025 21:06:34 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5242f137a1eso693527e0c.1; 
 Thu, 03 Apr 2025 18:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743728791; x=1744333591; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pTI2P2GLe9F/0v6fBX9O/GFysCKIWZ/L46PcvjWJJ4U=;
 b=Ix/Q969VRxMMiNCp+KrUTQKnEZuDuqDqDfZsGq6Mee1IUI4XyAGnGdB0JYwVafABpC
 5Ykzh5khC5xqZjJz/S+etmFKNGufAgyOeaqHQLr4UFT94N11avfMra8TYdzrvQ9ddtaO
 CdJQJcD7JSFG/Mzbn1QzsxKuSUeMVPxkZxOoKr3VOcFy0SKKhbrXwNTNwwE9ac8b5MUQ
 pa9hdGxV0ytFo1Pb/381zqUFgoIXpKiWLJRQucmABAi+d0jOXwqeD2tlMWAOjta3XeOe
 0LQAtYAy6nv7LJnR0eFzAowUpKKK9bc7fREDg+q7WhzbjWQWpCIen/pZQ4N3Vtk8jG//
 CddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728791; x=1744333591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pTI2P2GLe9F/0v6fBX9O/GFysCKIWZ/L46PcvjWJJ4U=;
 b=gUcayfd0oEETLUZUnPTyAk2F2ncVwPFk6zUPpfIerwRtUok4+fBXGiYBR/B0xzKB9H
 H/i61XIft3ZXoKLOMiqmSy+ZlZllVvlUOg6XVlnSsGe53iwS2rEd0eGpV3DZmu+8b5Zo
 oP1TDFUg0HdJQyQYNr2GkH2mpfqgvEjiji86qBP07OfraC+P/DjHV2mzqxu93uLHE0+f
 nFiHdo4U/73d8A9XYO/A/VEbbbZpEaLUD0gh1AoEYN6uuxHVUnu2vHzyOS9tM/X+LoBQ
 1jbR8TmtWLD9mjNZSpQymz+g+cz2evrrwg6HWZSXAZ87dSl5EZxTARBFEcofGZQ1mHxt
 Quyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVikP24do5EqCj+vFKOg7p+y471s9BhzBLFYJVopIrZl5FoVtRms/8DBLIAbmAgnKXc00r5bPxBlKbd@nongnu.org
X-Gm-Message-State: AOJu0YxEMZuNiAp23Q8vFrY/JIGVUU/wv2PUG/Fgg5K/x4Cv4D9saPhu
 zXb2/6n83QpWzxpeCpDottU8ssRFfVRsUmmY2QiAPwDDW+GRmvwxG1G458PA3tINUbLpoEMKmV2
 j4BrB0Nj2fCbUKafIlU5/sD3B0g3+xw==
X-Gm-Gg: ASbGncsM4LKO3gxkS8fNE7/xz5yUXsQdGKXqoqkDOV0kTr0bCiRfLmE5SXocgbDKWEW
 Mv8M19uX7XJ7q4z4HbPo00ZVyKMXohmOs7qyZcCpK6RhOJfXFDviv9ysSEEIrHu1pDaHkhigrZl
 miT1OyXXip3tJcAeyx/BfyUzhUwCKsjRPKKOwKGUwiRMbz37js6dbJtOIC
X-Google-Smtp-Source: AGHT+IGdxmybhTAvvjHlK7qBiyK3DI1X5QI8h7rf69sflbd3WQwexW3OtVr/xbUhTyrjmmz452PtH1ojWuOFgs3P84Y=
X-Received: by 2002:a05:6122:659c:b0:520:3987:ce0b with SMTP id
 71dfb90a1353d-5276443fba4mr1649440e0c.2.1743728790837; Thu, 03 Apr 2025
 18:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-6-loic@rivosinc.com>
In-Reply-To: <20250313193011.720075-6-loic@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:06:04 +1000
X-Gm-Features: ATxdqUHRylB0up0p1FsrDmDLBZZxAZDtoWBEWgCvPle0NKaPxXVAsO4Wue9hWAM
Message-ID: <CAKmqyKPmu4D+_mbsG7U8yHtmH79ZoBuzkpTGBYVhUQ=QprJ_gg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] target/riscv: pmp: remove redundant check in
 pmp_is_locked
To: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Fri, Mar 14, 2025 at 5:35=E2=80=AFAM Lo=C3=AFc Lefort <loic@rivosinc.com=
> wrote:
>
> Remove useless check in pmp_is_locked, the function will return 0 in eith=
er
> case.
>
> Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 845915e0c8..c685f7f2c5 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -58,11 +58,6 @@ static inline int pmp_is_locked(CPURISCVState *env, ui=
nt32_t pmp_index)
>          return 1;
>      }
>
> -    /* Top PMP has no 'next' to check */
> -    if ((pmp_index + 1u) >=3D MAX_RISCV_PMPS) {
> -        return 0;
> -    }
> -
>      return 0;
>  }
>
> --
> 2.47.2
>
>

