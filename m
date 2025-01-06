Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F04E77197
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 00:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUbGB-0003pv-Sj; Sun, 05 Jan 2025 19:46:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUbGA-0003pi-P7; Sun, 05 Jan 2025 19:46:22 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tUbG9-0000eZ-0E; Sun, 05 Jan 2025 19:46:22 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-5160f80e652so3859090e0c.2; 
 Sun, 05 Jan 2025 16:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736124379; x=1736729179; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHeen0Na/un64+8Rj0TrYkaF97UWMlPJybZ7W8/Tmek=;
 b=hYTJgHO6mwbU55uw3aVJGd6zsvcAqvlEVFYv4qOEXxOxmu0FSwKJLrgUY29EbW/oYd
 R7oBkYNUQ3vO1qJb+MDc/GErpnUlKA82EMfQweiJWkganoI8Yt62jF7mJqlAZu5gIqHX
 lM8oTFt8ij0UtkGuzIbDHM+paCLzHaJSLD82Mcr5X5z0DzlZD8yXqgWCH9wuv0kZD54x
 KYIPFzGAPSqH1wWviWodlNwec9yklobEIfQgMsggfpapTVI9+gp6VEmdCHDo05XFh8nj
 XotGV7SXwoekrxA+u4zC5R+smScvyhVpKJ6ZEUizbK6bsv9AYTPijXMVoMloRs35bTUp
 aE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736124379; x=1736729179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHeen0Na/un64+8Rj0TrYkaF97UWMlPJybZ7W8/Tmek=;
 b=RSNTOJGAiwHsJe+WFWvLSJxiH1oVPoPKEKViGgYC3ZctOyjm6poiiFMXRqX4ISwy/6
 lpnkAuKoz1CssHgEW9ZmcKtVbA4X/jAG/z8414vhUyUEoP0T/1LDiU0BRwcCVgxA5mfW
 lnW/YgfNUlwJuwpSWfllDVakUwQM4tIOst87EnusdrKWP+/DokXWItj1em8QkxDJzqq7
 YdL+ggEzrqaz5Y4XR0a+TRL+eJOxR2puWyeKz0gRYTRmUY6vhcf7ga0UvLWxkJA7s4FQ
 ivI70vQ813KPVOx1883ZFkgHR92nCQfHFwa/YTmKaQ/KdY9Pfpq7pq2PhyiplB3RqsIK
 iBrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs8D77OKWFOh7oZbXH3Rk+glnbvFjZOmGgJtgWRUe4FgcM95s5Zx6m1JP/sxqULVdhw2OnDPMmC6Oa@nongnu.org
X-Gm-Message-State: AOJu0YxwHMvQ34/xz5wWhGrW4Y4nRW4a5S9b4IKsD+wrIR65I3xXmSvQ
 NA1MpzdrqcyKrgSz/Y7bgDdTCW5pBuWYTIeiZoC/rNyG1aIX5icPVV2NC9MDH5ke4z0VF3QCNRv
 eQg/9FmS2XHHEzV/2L5AvTn+/enk=
X-Gm-Gg: ASbGncuw3+VP/G1pEP+xGvhXa+hpQnNWHNhThHHeHGXqxcbviIkl1xUKwszbyg2AKHh
 +ajeUYcdEn0/ITLA+5t4OsxzrXAcV7rB6uBV0uHDCAFuoDMRRQHau6HBroZYkJhMvSlg=
X-Google-Smtp-Source: AGHT+IFbJ39RxNOimTbjKbKKMzUCOld7Qa+cU7yT2GOWXfTrgZawozmAlzUR6JDwvznPjGb5erLyaP+tSABskUa/SXU=
X-Received: by 2002:a05:6122:659b:b0:516:2d4e:4493 with SMTP id
 71dfb90a1353d-51b75c3d499mr40011210e0c.1.1736124378831; Sun, 05 Jan 2025
 16:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20250102181601.1421059-1-richard.henderson@linaro.org>
 <20250102181601.1421059-3-richard.henderson@linaro.org>
In-Reply-To: <20250102181601.1421059-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2025 10:45:52 +1000
Message-ID: <CAKmqyKPgW59So96a9Kv2e9sH7OBNOjvLDaBLkCk-GCjH2KgNSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tcg/riscv: Use BEXTI for single-bit extractions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 Alistair.Francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Fri, Jan 3, 2025 at 4:21=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tcg/riscv/tcg-target-has.h |  8 +++++++-
>  tcg/riscv/tcg-target.c.inc | 13 +++++++++++--
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
> index 10e61edc45..ea38ee5cbb 100644
> --- a/tcg/riscv/tcg-target-has.h
> +++ b/tcg/riscv/tcg-target-has.h
> @@ -64,7 +64,13 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, u=
nsigned len)
>          /* ofs > 0 uses SRLIW; ofs =3D=3D 0 uses add.uw. */
>          return ofs || (cpuinfo & CPUINFO_ZBA);
>      }
> -    return (cpuinfo & CPUINFO_ZBB) && ofs =3D=3D 0 && len =3D=3D 16;
> +    switch (len) {
> +    case 1:
> +        return (cpuinfo & CPUINFO_ZBS) && ofs !=3D 0;
> +    case 16:
> +        return (cpuinfo & CPUINFO_ZBB) && ofs =3D=3D 0;
> +    }
> +    return false;
>  }
>  #define TCG_TARGET_extract_valid  tcg_target_extract_valid
>
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 12c3cffcc0..83ec7cd980 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -162,6 +162,7 @@ typedef enum {
>      OPC_ANDI =3D 0x7013,
>      OPC_AUIPC =3D 0x17,
>      OPC_BEQ =3D 0x63,
> +    OPC_BEXTI =3D 0x48005013,
>      OPC_BGE =3D 0x5063,
>      OPC_BGEU =3D 0x7063,
>      OPC_BLT =3D 0x4063,
> @@ -2307,9 +2308,17 @@ static void tcg_out_op(TCGContext *s, TCGOpcode op=
c, TCGType type,
>              } else {
>                  tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2);
>              }
> -        } else if (a2 =3D=3D 0 && args[3] =3D=3D 16) {
> +            break;
> +        }
> +        switch (args[3]) {
> +        case 1:
> +            tcg_out_opc_imm(s, OPC_BEXTI, a0, a1, a2);
> +            break;
> +        case 16:
> +            tcg_debug_assert(a2 =3D=3D 0);
>              tcg_out_ext16u(s, a0, a1);
> -        } else {
> +            break;
> +        default:
>              g_assert_not_reached();
>          }
>          break;
> --
> 2.43.0
>
>

