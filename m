Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60EFC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 23:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOlww-0006Db-77; Mon, 09 Jun 2025 19:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOlwq-0006Bl-PE; Mon, 09 Jun 2025 19:30:38 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uOlwo-0004oW-I2; Mon, 09 Jun 2025 19:30:36 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-5307e208234so3345356e0c.0; 
 Mon, 09 Jun 2025 16:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749511833; x=1750116633; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAbun4juQuHmlY1hP7OgTj8V/In3X8Kd6wJPYVlxHew=;
 b=aQDo20YMS2t1vIcd/UXEJ5Y5ZxFlBb09aukeibgyRAG0jTQagmfDheFu/1XV6J+ZaZ
 qrN0aNh1oH4w6nhce1K9MON5y6BJBPzmYih+19p7PkAmNq2HvgAUjYkn4X7U6KM2SvJD
 WKf9e3ltXwl5O5mgspRzclEfTOZmOGYQmuYbg3aUV1sfxcQFNjZxKjTncFy7kSYacdzm
 nMuNMdDV8pGI9L/pcObrvzYINb82NbVClwOd5byofCefRzCygUUTfUSwjLFq3wxrt54A
 RIP4rWgIUY9fb8c/vD7CoW/gEK6gkZSuGx0p3ZIUCuU93XQBBWzbUuVKcz01bV+JIHjS
 D8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749511833; x=1750116633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAbun4juQuHmlY1hP7OgTj8V/In3X8Kd6wJPYVlxHew=;
 b=Y6DOIiGEKYl/GilBOXeqdQLTLR2hYJlXWRMzFONqWWM8yyCS2Jvusbv+O+n1O83vd0
 ojrEwOnd2hBC6d88IUgjsSu8pr/T12BJxLZALCG6ZFzcf4nffM1fN1iLoYWtgmYhKkvM
 yszgNB6SiZNx98AKPanTSRjP+2c3HZyyWExkjXSS230QHn/DEYnC/1PiYH3Ac8cUF9Dh
 0ehlQWLXhJnpgHmRT2aY2tdK+1G6fh29/0LYkwdbBL9wKzUxgzcABt/gNxex3CoqCHer
 AuXxw4QFRCtCVH5nX77WtI7UE+jgVnNArZGQcxcHzYtuMudL15nRJh+3gk6Qz6lrF6HX
 E4lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4v8DnJKXbGuwbyXeGdvoZUSCvKQgig1Y1HvuZ363JzBPxoB/8Qr9Bri1GBbTrDBYzJCRgytG2zT+inw==@nongnu.org,
 AJvYcCWqUBVqYtdQuS23UhYk12ScGl4Oxl8ipDxTcUFEHScokxyPrVGr5gYXGlRGxahyRJQpN/ts3cqXc/i2@nongnu.org
X-Gm-Message-State: AOJu0YyZnPo9uV8a4hvYgRt6/gX46xeIo5qEkZ6LtyciQRBMMQJkKIpy
 KOGC7DBWgqaVFpQNvm2t+QAGzcJiE6+p8rIeYjg6J5anstbGxnPg8KARY5QaRSJ4jkYFy+BidKa
 cY9aaGsis4LfGeriLSB9fz18aOmg6gws=
X-Gm-Gg: ASbGnctMzzbXBsiFFhc5Yho3bdk/4UZacbxUzZENPste2SIfAG4f2a6sIpP5fxY6Slo
 ZYl4zVQAko8+tI1tAk69ymhfwQ7ID2Lxgpgal4DFY7rLQ3Rk4yZ7KETrv5WmfKHfd4QStj8F8PC
 aykzHgOOsSQ6eYCW7h6Ipc9IrNiH2dvVu0rOFwp4tU1bhRdOUHb2+0httb2nFBn5PoLbXj9GeJ/
 g==
X-Google-Smtp-Source: AGHT+IHcUKxmR58tfOJ49cwMMT5Ki3m1lSaa4bYXMJ3EMDHx1/yUGkM5D34nle2KcBuBcq5PVollOgpT+Wkmzs00U48=
X-Received: by 2002:a05:6122:800d:10b0:530:6955:1889 with SMTP id
 71dfb90a1353d-53114a93b1fmr324563e0c.1.1749511832999; Mon, 09 Jun 2025
 16:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250609131731.1464616-1-ben.dooks@codethink.co.uk>
 <20250609131731.1464616-3-ben.dooks@codethink.co.uk>
In-Reply-To: <20250609131731.1464616-3-ben.dooks@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Jun 2025 09:30:07 +1000
X-Gm-Features: AX0GCFv-sYi6dGS_GsBoXE0hfI_QN0euHHEjWOuNdqJoQt0H6Mm28CNtVQqhhSM
Message-ID: <CAKmqyKNH1X6iPJEzqenCprdj-Gjw4eA=Fbm6+V08WQHqFkEh0w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] target/riscv: add cva6 core type
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk, 
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 alistair.francis@wdc.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
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

On Mon, Jun 9, 2025 at 11:18=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> Add TYPE_RISCV_CPU_CVA6 for the CVA6 core
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 1ee05eb393..3daf75568c 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -34,6 +34,7 @@
>  #define TYPE_RISCV_CPU_BASE32           RISCV_CPU_TYPE_NAME("rv32")
>  #define TYPE_RISCV_CPU_BASE64           RISCV_CPU_TYPE_NAME("rv64")
>  #define TYPE_RISCV_CPU_BASE128          RISCV_CPU_TYPE_NAME("x-rv128")
> +#define TYPE_RISCV_CPU_CVA6             RISCV_CPU_TYPE_NAME("cva6")
>  #define TYPE_RISCV_CPU_RV32I            RISCV_CPU_TYPE_NAME("rv32i")
>  #define TYPE_RISCV_CPU_RV32E            RISCV_CPU_TYPE_NAME("rv32e")
>  #define TYPE_RISCV_CPU_RV64I            RISCV_CPU_TYPE_NAME("rv64i")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..fca45dc9d9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3009,6 +3009,17 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .misa_mxl_max =3D MXL_RV64,
>      ),
>
> +    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_CVA6, TYPE_RISCV_VENDOR_CPU,
> +        .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVS | RV=
U,
> +        .misa_mxl_max =3D MXL_RV64,
> +        .cfg.max_satp_mode =3D VM_1_10_SV39,
> +        .priv_spec =3D PRIV_VERSION_1_12_0,
> +        .cfg.pmp =3D true,
> +        .cfg.mmu =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zicsr =3D true,
> +    ),
> +
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
>          .misa_mxl_max =3D MXL_RV64
>      ),
> --
> 2.37.2.352.g3c44437643
>
>

