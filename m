Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06111CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 04:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTtq7-0000Dm-0k; Mon, 01 Jun 2026 00:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtq0-00009O-PK
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 00:01:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtpx-0004CI-FK
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 00:01:16 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so5704648a12.1
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 21:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780286470; cv=none;
 d=google.com; s=arc-20240605;
 b=Ug3YEI4x268BKXJKeAwq3o7zC6DGC7BZ0xd1S+xExAcOqaHOdtR343xMdZrQUr975Y
 UpQ6uy8L9nfIYRso+HfdIB/SG8bevO3u7UYRFFW4eDUxbjGbzMRhgQPqroMJpLvXGqhP
 hoSdJFxpC/RSzDwNT0QCf60SVCgDsNf84bVKWOw3JEPhzEpc/Z69Nr7yl2o0GolgsvQS
 dA3JxNwAlT/GyCetTfYZOME+HXaQkLB1UUoaeVGybcXdBbnPyPgUMhVZ0Axv/kULmUf1
 /V600o2B+FD3VSocX6pSQWR5HDancZixIEZlsXRABjgc8+1RD3ScGVejwYLWrexOTtPQ
 yliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Fb5KtcFXKjmTcRcYKLVlIMnXag4z2d2SS3kv89v/MbQ=;
 fh=oXbwLIQ6D7eZBIAfdMwTNx3JbGXBw4Kr6QcethzQnTk=;
 b=CK8mvMGRZZe0hIgN+ZpPKGUtPwj9kDjYn3hXDVkQauVg8txBqV9eus/aN3AYKbWKTC
 prxlDp4/mImwlqqwfgTzHkL3kux3aVXaWK1f0NMVwRcHyAR/v1E1YSzN24cEMoQMVmge
 dws9s3HiIOjguLEkcFVQ7R61Q4Nx2Yg6/hlFdpx+3fwela0gXAFp+LsY5eORssqjCPju
 OaCyxDvrCu91UPXE65/Rkw4hk7A3Ys1dPZtLay75BhcSUnk+t3Sza7Wc6AkuXxAMipYQ
 AToS/RQe6tQSEm7Nu2sOTicf9lSPXznU9FRPc8JyZa+LJ2pdNFApD4SfKph72yHmeEfC
 BI4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780286470; x=1780891270; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fb5KtcFXKjmTcRcYKLVlIMnXag4z2d2SS3kv89v/MbQ=;
 b=HhiqjZbamDI8/RgQmV9HPEsijIgl1t4HAQFaGGjDQzlIVmNpipypb2YjPVq2T7AgUy
 7V6Iagt5VWjwi0cHSNnMAU04dxKMWmHhzHQId0nI1CQZDV/lu470AHIYGKqMcxK1XSow
 uGKx/rsSh61BwaUbwjry7DJl7vRGV0VndBQjOYugwxWQtU3BHH/1M8bRHXZDYfvg430j
 YUURpE8r5AIwDkwE4KAIQc6TtDe+Y/i2Pmj2SW0dojUyOUpdPwwKM935ewZ2jzj/FUfZ
 RJHS/7e1lfLqtToINuuEKiR9UF9SZxz6lzpMu1Y2JJVZFYFNKz2d1srJuNfDk3+wi8Gy
 UL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780286470; x=1780891270;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fb5KtcFXKjmTcRcYKLVlIMnXag4z2d2SS3kv89v/MbQ=;
 b=flF9eNq+PuOCoA4m/o2JmsLLUPFHiBK5d1hRnztgHQ6Y6jItQ9VNbRJS/+uhGEOR0o
 7Qvf2vUnWPbzyTJ3MwM9/806oiu1EFbadmHysxlTl609GwfZ9btOjRP+z3JAm//CeLlC
 KUXYFs0MLWmzM5iG+GZnh3p+/+pSiICwVIjW383lb2dAuN4FI71Q3Sciyiw98rgXAJOB
 VADyTHQw1ACqcTObt67Q/B1Nl3lTrrAu4JPUs0+vyg2cXsFw4TqbySlqHCNl8JMMsLdj
 cpJY3EI0O7nj0fYUk1B4upD/Rtx2tQov/5aYLRHBtrr4VPgjm2MgqzI7fzz/RCBrWm7U
 vnTA==
X-Gm-Message-State: AOJu0Yw+YSp9ZDI3p5OOt/uW26bxzOKcqVNCzZgn4QpIl9aMxP5kvvfQ
 sLMavEmXgzhBUP8Kszq8QPOkIJy3nxtQwVsu4TzfkWVrSSKRRqlWxIhv3ecS0PnwI6WsOuSmVcT
 JIwrM722wvsqFTtNyuqbN6gGJlqiioBQ=
X-Gm-Gg: Acq92OFA75oHhKOfeG5/i7f7GXZ7j99n3IYDfafMo2oAb1WuWMVJDiRSgXkEsYATtDD
 QRX7U5Sq2ZcaudtViTyP2uGZ4gqBOLcdxPmIkEpv/cxuq3p2FyHW/1zh3M225ijQz4ogZbGVu3o
 Xuy6hdPm+ynRMFrQV+zgH3KwrwIx13qjggpl+NHYGQ5JQnDO4io9ZT09Ww43kqf/Q/HHF1CfQtj
 nzjX5k01t/fV57zW3XQqf442JpPIBftJNipc5BqrmDIlP9Pmga5/eVltKfrFuRWduOzbNeAc1bF
 EkoBNN1cAw2/QYZNeB52cWdLMfmc0X/n/xk8okv4fSvOt9xw
X-Received: by 2002:a17:907:783:b0:bd9:aa4d:c6b5 with SMTP id
 a640c23a62f3a-beaaf90de10mr539107766b.9.1780286470044; Sun, 31 May 2026
 21:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-10-philmd@linaro.org>
In-Reply-To: <20260527201348.29511-10-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 14:00:43 +1000
X-Gm-Features: AVHnY4LkDE1nweUS6wX1oPC-XfeEWW36GWT6MisBoUmIgxx4NSAWNkWcfkJsixc
Message-ID: <CAKmqyKOUUJ_DKWmqe279z7HVJMWOYFimZBtbuY-F=e+3PkLLbg@mail.gmail.com>
Subject: Re: [PATCH v11 09/12] target/riscv: Add big-endian CPU configuration
 field and reset logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

On Thu, May 28, 2026 at 6:16=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
>
> Add a big_endian field to RISCVCPUConfig and wire it into the CPU
> reset path. When cfg.big_endian is set, riscv_cpu_reset_hold()
> writes 1 into the MSTATUS MBE/SBE/UBE fields using set_field();
> otherwise it writes 0. This makes the reset value deterministic on
> both cold and warm reset.
>
> This models fixed-endian harts, not mixed-endian implementations where
> the guest can toggle MBE/SBE/UBE at runtime. The MBE/SBE/UBE bits are
> not included in the writable mask of any mstatus/mstatush/sstatus CSR
> write path (unchanged by this series), so the value chosen at reset is
> effectively hardwired per section 3.1.6.5 of the RISC-V Privileged
> Specification.
>
> The user-facing property and documentation are added in a later patch,
> once the full endianness support is in place.
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/cpu.c                | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 734fa079f28..9eb47af0a76 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -157,6 +157,7 @@ BOOL_FIELD(ext_xmipscmov)
>  BOOL_FIELD(ext_xmipslsp)
>  BOOL_FIELD(ext_xlrbr)
>
> +BOOL_FIELD(big_endian)
>  BOOL_FIELD(mmu)
>  BOOL_FIELD(pmp)
>  BOOL_FIELD(debug)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 52f143f1cd4..fef424f2bf9 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -739,6 +739,13 @@ static void riscv_cpu_reset_hold(Object *obj, ResetT=
ype type)
>              env->mstatus =3D set_field(env->mstatus, MSTATUS_MDT, 1);
>          }
>      }
> +    /*
> +     * Model fixed-endian harts: MBE/SBE/UBE are initialized from the
> +     * CPU configuration and are intentionally not writable via status C=
SRs.
> +     */
> +    env->mstatus =3D set_field(env->mstatus, MSTATUS_MBE, cpu->cfg.big_e=
ndian);
> +    env->mstatus =3D set_field(env->mstatus, MSTATUS_SBE, cpu->cfg.big_e=
ndian);
> +    env->mstatus =3D set_field(env->mstatus, MSTATUS_UBE, cpu->cfg.big_e=
ndian);
>      env->mcause =3D 0;
>      env->miclaim =3D MIP_SGEIP;
>      env->pc =3D env->resetvec;
> --
> 2.53.0
>
>

