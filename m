Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BEFC9EC93
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 14:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfIka-000205-3B; Mon, 12 Jan 2026 09:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mpe@tenstorrent.com>)
 id 1vfAgl-0002A6-5j
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 00:42:03 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mpe@tenstorrent.com>)
 id 1vfAgi-0000b0-Mf
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 00:42:02 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8719ac9af7so85767666b.0
 for <qemu-devel@nongnu.org>; Sun, 11 Jan 2026 21:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1768196518; x=1768801318; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qddfOCZOjO3MvQyTGNVXdwU/1+f4GO6nIVEaVrlmsc=;
 b=I9JxwYIg4bcJqAx46QALAsaMZoQLFNxARuQ0JEjIQTkVMg+y17bXWHNYcD3+4R/9f4
 DUlDuXx3uqEtrUNsrC+x/FCX6m4IS0SnCIWjUP2gSaGw6fH3vpnWzj+8JFcE6m7MeUU5
 pRCGCZeVEDxAo2XGppqTnjzWtuRzEPEQLHLCkbNqJ24RNfZkquGD6nHrSYrzaSRr370o
 v71oZq4qD1mwH3vY0Bqry2FqzYM3F82sqN6RrsxtCDr1uSywn6KyrO23OmWBv6ZrvGHr
 7EnmxzIPeq0/uTBZtOpeiwKZNNxMgClr6tulYTX83Ff+KNDoz9IC7ZO0z6yp/BIwCbb/
 xlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768196518; x=1768801318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8qddfOCZOjO3MvQyTGNVXdwU/1+f4GO6nIVEaVrlmsc=;
 b=NOl0SotE0ShO49LxTK4W99psuwXMkhK0l7a1yNMO63Vy+83qwy8l/eVfAkkQw8DvjP
 7gpbdDbeoSsn/1BiPWG0BusF2Nx6i9RMCypOgLIgHI5on//9LlofGJoeRsRhKD+6U5ca
 OoPFFz0jTFYSyvRjRKO+5Ik+A9EtgNLGV2uEzSDfZOXHL5dI8cR2wx1Ha0Hsw5K/LJ5D
 Qk7cajFv6nPk9F6GbWkKS+rE3fZHdNZt+w2D8Qj61bOO/m90I/vvJbyC0FsR7vGDklU8
 vk50oYpt1y24iXvpSb/TdNSzvrD8QjsJvTNcvTKsUkdAVPbiA0Zm0tqyxMI8/yCK5SYO
 tXPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPzUqmmwQ7hW1VoYLbQjDOkMAZiQAILNnXzLqr0hZ3mLiXJEMnj5EDUihFHBr7h+2eC43B24APalJp@nongnu.org
X-Gm-Message-State: AOJu0YzJPxhUSd2CKoUi9d8yG3bkKfAydYc0hn3/1Kfsi8hNjKiLJopl
 3XBdACF+yWOVjVLLj9BS9Abxo6pgTHoaWxFi99cJU6S0LaTjWyS6LbzNjLtha6UiZRV3z6r4I5b
 rnN94/javZ2zmUQZAXAckSFiSLHqK3K9qFVnPyyGosA==
X-Gm-Gg: AY/fxX4UWdGRxHAVp1qkJr0Y8r3b+DT3XF9Q0CJP4VbK119rl7DBNdQBrTMQlVl+vx0
 4RJG9uRdeIWzqjBfxc2FlmBOMCNimepGuck9q4czw8xQE7xRhRZsGaL7AZ9gyDr3r1UD58e6aP5
 F1N1hHUHWZ8ErbyB/KLiQwAc6PYq+YUaL5Hcu6buTKJLJ6WgkH3lifkI+3peIVzu+1IsYme4V01
 3rw0n8ikx5H1uQK+pj/LkX5NMCdLNwg9WQJyZmXxgRSeqn+OVQ8yLv+lLzDQ+DxsS9PRxws
X-Google-Smtp-Source: AGHT+IGUS04BhzHDdx3sJ0gdh88EW9V4KhUaEbV3dytBw+u7VmOLfb5Z7Kx9o3WueeJ8Uo3IJB2pMdYc5cslBjZKQFk=
X-Received: by 2002:a17:906:aa0c:b0:b79:cd80:6fff with SMTP id
 a640c23a62f3a-b84299bcce9mr1683168166b.17.1768196518543; Sun, 11 Jan 2026
 21:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20260109134145.398565-1-joel@jms.id.au>
In-Reply-To: <20260109134145.398565-1-joel@jms.id.au>
From: Michael Ellerman <mpe@oss.tenstorrent.com>
Date: Mon, 12 Jan 2026 16:41:47 +1100
X-Gm-Features: AZwV_Qgt7rArxqamu7LacAF4LOaCcKx9lh-w4IKEUyOSn_-QLlJWzF5sttcDYTE
Message-ID: <CAACLP0V2vuut7Rjy5MheV-2+ObQK9vU-27g-QYiwsxOJ1w1NDw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: tt-ascalon: Add Tenstorrent mvendorid
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, 
 qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=mpe@tenstorrent.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 Jan 2026 09:17:30 -0500
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

On Sat, Jan 10, 2026 at 12:42=E2=80=AFAM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> JEP106 has two vendor IDs for Tenstorrent. We will use Bank 16, hex 0xa1:
>
>  ((16 - 1) << 7) | (0xa1 & ~0x80) =3D 0x7a1

The value LGTM, it matches JEP106BM, and matches the Tenstorrent
documentation I have.

I would probably say that it's company 33. Which is 0xa1 with the
parity bit added, but the parity bit isn't used in the calculation,
ie:

  ((16 - 1) << 7) | 33 =3D 0x7a1

Mentioning that it's company 33 (0x21) would make it a little easier
to match it up with other public sources, eg openocd:

  https://github.com/openocd-org/openocd/blob/1ebff3ab33c77e3f8fb4e1ddda262=
b606b572af1/src/helper/jep106.inc#L1935

> Add it to the Ascalon CPU definition as the mvendorid CSR.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Michael Ellerman <mpe@oss.tenstorrent.com>

cheers

> diff --git a/target/riscv/cpu_vendorid.h b/target/riscv/cpu_vendorid.h
> index f1ffc66542a0..751a13aace47 100644
> --- a/target/riscv/cpu_vendorid.h
> +++ b/target/riscv/cpu_vendorid.h
> @@ -8,4 +8,6 @@
>  #define VEYRON_V1_MIMPID        0x111
>  #define VEYRON_V1_MVENDORID     0x61f
>
> +#define TENSTORRENT_VENDOR_ID   0x7a1
> +
>  #endif /*  TARGET_RISCV_CPU_VENDORID_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index efdec49e49ed..85ce4d83a371 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3190,6 +3190,8 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .cfg.ext_svnapot =3D true,
>          .cfg.ext_svpbmt =3D true,
>
> +        .cfg.mvendorid =3D TENSTORRENT_VENDOR_ID,
> +
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
>      ),
>
> --
> 2.47.3
>

