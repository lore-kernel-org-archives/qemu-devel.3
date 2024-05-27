Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B53C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBSh0-0005AS-4q; Mon, 27 May 2024 01:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSgn-000590-0m; Mon, 27 May 2024 01:14:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSgl-0000AS-8d; Mon, 27 May 2024 01:14:28 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5785eab8d5dso2866894a12.3; 
 Sun, 26 May 2024 22:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716786865; x=1717391665; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVNH5eEampbFo5A38ZuDA0nt2kSf/bDSHDyllKC807w=;
 b=Eu/6khTQalkp3aoZXzivD87lTzqs0SLAVOtl0NdzEDaRbj7aSVjL5GSZnOIf7OYeSk
 xXBFe7dj2pQkeHHFTtAjrdAKzXCb9RhaampiS6DRzwy1r9dnF4KplNejDLOx21PRLeBa
 gupEmRxbMO26D3xdLFm76gCqEni9APYlQor2SBfm/k2SP16fOIeaYxyBXt5MYGkuA/V5
 Jft3YoVgqcLEVe0xP72quu4TFj5xUlMookMa7CRDp7L97V4CS5e5xLP21uy7R8wWIer/
 6lUfjxrwwjzh/zTIm6wG6pE6viTsH6nnw1S9qGJQ+kbkY15leX4XnuCqt3/TY83u4qyF
 94BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716786865; x=1717391665;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zVNH5eEampbFo5A38ZuDA0nt2kSf/bDSHDyllKC807w=;
 b=CWj3aszEQcY7ke6UCT4Z7Y3UXn+FnIFLZfeOo9E8bxDPxPNaVWNdOTi/OJaIcLPvQe
 /PNcn2F98AkMf1vntqCGJmZtcWLu+HLrBzyGe9nZyQ2IaOweosO0D8LpC9tpshT9Kb+Z
 uuF6fgbhV3B3Qpja3bnl3ts3rIydh0I7HldDz+Ozm81xKyGQUM1V7Lhyhdo84WnbCqpL
 gyr4SMDlBj7ydKVVa6qGqA8a5pCU/jLW3FAyZit3icbm8IIHTM6ctIxHMgOEPIWETOT2
 xUF9nf5XNSx8JbZfqZKAnhwPXfDj5b3J5w8VwJ6N6XP0gtVQB6rIwKVM/HcJMrJggpSk
 QNmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMTDkwy6e+bGqxlDAcpsMgfG6z7R7fuUeLIUeJvtG96npEqeiOZneZ1BKr049MgM9L/82TcUBI+CUP0MrIlc5IX3uoWlVL9nnLyyOOhiCiQ0SGl2Nv7hSDNOuPQw==
X-Gm-Message-State: AOJu0YyAQRKB9ns8aREeeSMZGKxM1VoLO27cCsNqJeYZb7oIr6hwX/l0
 3glFLefso7bTXZsFRxAZzNrUE3wciMKeVJsRfmiTZ3tQ9P0SA76xhG4+/STuhf8xiXTFuxLv7Ph
 gG8uyUqimSaGIIcpGcX4iW/WTYcY=
X-Google-Smtp-Source: AGHT+IEt+EV4IX7QJWWVe+ElqmWXPex+uBpCdlxO+g1AhKJHSPh16KKVP4z/ZbMSl1gR2BeQn5Rb9m49M+ZJpVB6dMQ=
X-Received: by 2002:a50:cccb:0:b0:570:5b70:d76d with SMTP id
 4fb4d7f45d1cf-57851a5bf02mr5636873a12.28.1716786864938; Sun, 26 May 2024
 22:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
In-Reply-To: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 May 2024 15:13:57 +1000
Message-ID: <CAKmqyKPOwY6Hi8m8C6yMd-jYMxY1RTGObqiZDymTJBVupi+AMQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: zvbb implies zvkb
To: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, frank.chang@sifive.com, 
 max.chou@sifive.com, paul.walmsley@sifive.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Thu, May 16, 2024 at 10:35=E2=80=AFPM Jerry Zhang Jian
<jerry.zhangjian@sifive.com> wrote:
>
> - According to RISC-V crypto spec, Zvkb extension is a proper subset of t=
he Zvbb extension.
>
> - Reference: https://github.com/riscv/riscv-crypto/blob/1769c2609bf453563=
2e0c0fd715778f212bb272e/doc/vector/riscv-crypto-vector-zvkb.adoc?plain=3D1#=
L10
>
> Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>

Do you mind rebasing on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next?

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 40054a391a..f1a1306ab2 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -658,6 +658,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
>      }
>
> +    if (cpu->cfg.ext_zvbb) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
> +    }
> +
>      /*
>       * In principle Zve*x would also suffice here, were they supported
>       * in qemu
> --
> 2.42.0
>
>

