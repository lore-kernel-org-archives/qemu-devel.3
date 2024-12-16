Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CE0E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 04:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN392-0006fw-Rr; Sun, 15 Dec 2024 23:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN391-0006fA-14; Sun, 15 Dec 2024 23:55:47 -0500
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN38z-0004MI-7K; Sun, 15 Dec 2024 23:55:46 -0500
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-51619b06a1cso1970109e0c.3; 
 Sun, 15 Dec 2024 20:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734324943; x=1734929743; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EDbbJ8/0/ImSc1Hn0zTVodv5EIlnSBzh0NR3dPMWfiM=;
 b=G8KZTZZLOUMHgCpvbS4JHc1qT6bj4VxucNeDm6pvWR5l4ERKVUJhGOqVb2F5QtrMF6
 8U6gr9pHSx4JsRlG9hkWjxec0F6GCVFSFELjT3HOH2EUQ3m7gVUgDKGxycK2+rzNb2Sq
 eOcAnaA5ApzsbJ335ghP4Lfm8bZGrZK0cXcdNnj0hRBKXRxSNsXd4KZfFcze2KF7uVGD
 OGUJRVm60oGt78HiuCebWn2uqRccZC2L2Mu7Z3d0AICrgp05F/7dNgYAw6QP99Davnnm
 Kvnc2p5SB20NpfrsTBVkXEJnaYIjio8yqgTEw3yOASUGcs9jqO6per9ZRLERMJTq2XFr
 KxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734324943; x=1734929743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EDbbJ8/0/ImSc1Hn0zTVodv5EIlnSBzh0NR3dPMWfiM=;
 b=PN9Y4bVdvJTMqO6s1gIy9vCmQNYx1T/zpvBGGRsARFXbz4ASozgaNdlI7rccj/Z5v3
 qdnLK4f5T9aR+T6fhe4HHWrRx6IGPAM/c+bdoWZ/u7EhiDwCKnAS4UsrkyiCdlX6JHSB
 LH3P8KPyoKFzGlxXW9OtD7GSVOFIO/0szX8YY/64vdb5scSdz3JAEdLSlZcv0obJTX7y
 ffmKM9LK0wUnvfNLlEHMLo7cyUuIdGkOnETjVu+UEn8HLiYJxb142d0tkqUXVfV7ZqLJ
 VfapMMXFxoC8ONlGr+yk32W6psdPuLasVwo9i7i46BcImmLN6Co/cI2qdp7XjKTL8EWq
 NM/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk1AKIe6XgXwfZ0HiiYGXEfvO9VCFLi+u2khIWJKgyeMA7ijA6ZycL9iiMGAhzEyLA2RDVxZuarHds@nongnu.org
X-Gm-Message-State: AOJu0YxQiFyG+Hoy9YIj5R8RuOhvuw3J3ScceG9MZfNm6i9zdyEptpB1
 ltXr+/8I6lI3CSZgx4olOww3oKwHK5i0fL1CzddgyVcpoQZeQYvKe9qjuX3tV3EG2cphFCbTAHZ
 kHFLMwvYqVPf/9NQ9dKm9YjcV34M=
X-Gm-Gg: ASbGncux9qRcEDXcvB168j2HFriOFGjoik+ENSav4Lul3nGlc3lkwJ9tqFjg518v5c2
 uiU28F/VB5MoVFdE2oZvbE+IKQqaYIyGGPpSIu0kA3+rbIfIptQdjHxKOKYx2FoVXSIXE
X-Google-Smtp-Source: AGHT+IG1y6P/MBv2ymasYVym1ij5dHBIDbZr9PwCYaPDQgZfiIJc03Fhgjv+Ufg/BkE+/zvpuyfXr5iLI6HMqM3h1u8=
X-Received: by 2002:a05:6122:1dab:b0:518:9040:6700 with SMTP id
 71dfb90a1353d-518ca4a4181mr10817771e0c.11.1734324942846; Sun, 15 Dec 2024
 20:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20241211211933.198792-1-fkonrad@amd.com>
 <20241211211933.198792-2-fkonrad@amd.com>
In-Reply-To: <20241211211933.198792-2-fkonrad@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Dec 2024 14:55:16 +1000
Message-ID: <CAKmqyKNeqRNfB3p_U4Q3kmV43rdD+b3P0t7qq7FZtGv46imQnQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv: add a trap-misaligned-access property
To: Frederic Konrad <fkonrad@amd.com>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org, 
 francisco.iglesias@amd.com, Luc.Michel@amd.com
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

On Thu, Dec 12, 2024 at 7:21=E2=80=AFAM Frederic Konrad <fkonrad@amd.com> w=
rote:
>
> On riscv target, misaligned accesses are either authorized and implemente=
d in
> hardware, or unimplemented and generate a trap to be implemented in softw=
are.
>
> At the moment misaligned accesses for rvi just succeed, the intention of =
this
> new property is to let the user choose to have a trap when a misaligned a=
ccess
> happens.
>
> Signed-off-by: Frederic Konrad <fkonrad@amd.com>
> ---
>  target/riscv/cpu.c     | 5 +++++
>  target/riscv/cpu_cfg.h | 1 +
>  2 files changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b5..1696d3db2a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2697,6 +2697,11 @@ static Property riscv_cpu_properties[] =3D {
>       * it with -x and default to 'false'.
>       */
>      DEFINE_PROP_BOOL("x-misa-w", RISCVCPU, cfg.misa_w, false),
> +    /*
> +     * when set, misaligned accesses will generate a trap.
> +     */
> +    DEFINE_PROP_BOOL("trap-misaligned-access", RISCVCPU,
> +                     cfg.trap_misaligned_access, false),

This should be the last patch, we want to implement the feature before
we expose it.

Alistair

