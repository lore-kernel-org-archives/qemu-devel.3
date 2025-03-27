Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED8CC36010
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 14:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txnuC-0006ln-4B; Thu, 27 Mar 2025 10:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1txntv-0006je-DG
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:08:08 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1txntt-0001bY-EM
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 10:08:07 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-548409cd2a8so1224927e87.3
 for <qemu-devel@nongnu.org>; Thu, 27 Mar 2025 07:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1743084483; x=1743689283; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWOqSHcqRisiqKFLedCxylaiIRUqDjao++K0tkWOY6M=;
 b=Zc89tK2fli1AQqLhDI/1Z4cBrcwVzcqAH9wK1R5HNdl9yeDh7pnEBKCTF93mQAQ2tB
 kpqW99mtco03tGgcpt9OgGJmPELEEo6+IZGZYv/6mBv3pv7Glb4ZLZoTlLWNONBexKT/
 dKZilZYYkIGlk2OUgWdSnUm7zh09SeiVZ+/QWs2SC2/OVg6kry1MvI5wJjMgQsaTzC0i
 qO1HfjarjiHmAS20txThARlbaNE4v9nU4UttFm5obf0oaRgcjUtWd43LAf6I9YvmJanM
 FjLvWxlSe5q+Q8333Yy7q3zcMHrVwiBayTy502W6XvyaTE2O3X3pj7uUqX59uEd9lTd9
 S0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743084483; x=1743689283;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWOqSHcqRisiqKFLedCxylaiIRUqDjao++K0tkWOY6M=;
 b=dh/GboFjwW+uwGR92/j8Y00ZwG/IDnt/+TLFoMJwEm7Wyg6Tvc8belrfzVZBru9yKY
 2CPteoYZSnhkCMxhoN2x0nd2M5fm8yPwPAtKqkINPhWocuauGGSoZkxbODbd4TBHb7UE
 2qqvSeNFTyABjHiCzRjFbX7POWU5GlJ/Dl6JrSp4YuIZwdb+rjSXBTCA0Fg1ArUk3WkP
 0VzMC6B2m3dsQxTJHDsWtJjw/z2PYI6uziGQIE1kOb9UJLVncTZVeSG/9ZauY1DTuMXQ
 Cc3WjKDB96bjtrpSTRMW0XaK91TltES8ixKk/ajhAWP4l1vFIhH4koPWNT2lEi992NmH
 zISQ==
X-Gm-Message-State: AOJu0YxmBkeVEOCzYYVM61yD3RnKz7pJ7ZTzAIpeDJUae9Xd8CK9+nOh
 6JCVKAeIZliPIFYeXHEIW/pEEn9E1P7M3JR+hjwOlnFOlRUBsTNQtnT5qc8pvMyKtrNzlGVxHaq
 /BhGtlmIPSAApDOOVezkR9+1yqPnRuC6Xlth56XTk533Bw61CTP8nUo/VGaZRD1XCi/SoQ0FSlF
 5SNr8xDlmIUCaVGeFgSF/9XwEWnAeDUqbkljmIYx5BFHHQ9ds=
X-Gm-Gg: ASbGncv6NYkouMhWWmhtNjRfxTeNpP4EUuNy9ITk+C+093ik4LMRkWqEza7d6OjnjL6
 8RQ1JTNSw1jteQ317RoQB1Pv+DiEwLj2nJ4Ol2s+4CiTo3grDdjUrE7yYpuB3c5na1ZQOpVyf4I
 nWiOMv/84gRiwlCKNpOJf9Usw1sSk/NBg6AVpIk+tzhZCsWA4H16JHl07WKNqpMQ41wNlhZrfsH
 kXPS8oVcO6yDiiaPuTfoC01B2wI7xDlgI9FvS6swFhad4GgB6r/p4KGMfqNN6AZ0gyE/fbcBbLQ
 r+ziiR9HGLMfmJc+2ww2u3vXkviqjqgas7iQnBen1txUlEFVeK8/dxT7Zr86+JeqCkaJpC6Stao
 oHFJ7Lh9vwg==
X-Google-Smtp-Source: AGHT+IEUPmc3YgsRvc6usYc3bL0B1u5oCfGCIEWBHOC8qodb2GwEne6MI2llhBFUolyITXNyXDDIWQ==
X-Received: by 2002:a2e:b98f:0:b0:30b:e3d9:37e5 with SMTP id
 38308e7fff4ca-30dc5e3164fmr12404121fa.13.1743084122468; 
 Thu, 27 Mar 2025 07:02:02 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com.
 [209.85.167.50]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30d7d8f4280sm24640261fa.73.2025.03.27.07.02.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 07:02:02 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5498d2a8b89so1116256e87.1; 
 Thu, 27 Mar 2025 07:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCV1RjEMQY9Uuqie5GgmHoXhCnvhUBFSALlpHneHikqvSwaVO5sXgxo5MgiDxoE7zmjBozc7YzMMuAxH@nongnu.org
X-Received: by 2002:a05:6512:2212:b0:549:91d3:8e66 with SMTP id
 2adb3069b0e04-54b011ce4b6mr1282152e87.8.1743084121563; Thu, 27 Mar 2025
 07:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250327130256.653357-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250327130256.653357-1-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Thu, 27 Mar 2025 22:01:50 +0800
X-Gmail-Original-Message-ID: <CANzO1D0begQ8ZY9LeVnoGUzR-hpVFtRqgiM2z2NoLfb2sAhBhA@mail.gmail.com>
X-Gm-Features: AQ5f1JoCRdv0tcQjtm8VUPpbZBgt7Nl_z1vihSqQSEeAjzbxauHNd1lCF1usx_0
Message-ID: <CANzO1D0begQ8ZY9LeVnoGUzR-hpVFtRqgiM2z2NoLfb2sAhBhA@mail.gmail.com>
Subject: Re: [PATCH for-10.1] hw/riscv: do not mark any machine as default
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2025=E5=B9=B4=
3=E6=9C=8827=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:04=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
> made it default for qemu-system-riscv32/64. It was the first RISC-V
> machine added in QEMU so setting it as default was sensible.
>
> Today we have 7 risc64 and 6 riscv32 machines and having 'spike' as
> default machine is not intuitive. For example, [1] is a bug that was
> opened with the 'virt' board in mind, but given that the user didn't
> pass a '-machine' option, the user was using 'spike' without knowing.
>
> The QEMU archs that defines a default machine usually defines it as the
> most used machine, e.g. PowerPC uses 'pseries' as default. So in theory
> we could change the default to the 'virt' machine, but that would make
> existing command lines that don't specify a machine option to act
> weird: they would silently use 'virt' instead of 'spike'.
>
> Being explicit in the command line is desirable when we have a handful
> of boards available, so remove the default machine setting from RISC-V
> and make it obligatory to specify the board.
>
> After this patch we'll throw an error if no machine is specified:
>
> $ ./build/qemu-system-riscv64 --nographic qemu-system-riscv64: No
> machine specified, and there is no default Use -machine help to list
> supported machines
>
> 'spike' users that aren't specifying their machines in the command line
> will be impacted and will need to add '-M spike' in their scripts.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  hw/riscv/spike.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 74a20016f1..ba88d3a07b 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -349,7 +349,6 @@ static void spike_machine_class_init(ObjectClass *oc,=
 void *data)
>      mc->desc =3D "RISC-V Spike board";
>      mc->init =3D spike_board_init;
>      mc->max_cpus =3D SPIKE_CPUS_MAX;
> -    mc->is_default =3D true;
>      mc->default_cpu_type =3D TYPE_RISCV_CPU_BASE;
>      mc->possible_cpu_arch_ids =3D riscv_numa_possible_cpu_arch_ids;
>      mc->cpu_index_to_instance_props =3D riscv_numa_cpu_index_to_props;
> --
> 2.48.1
>
>

