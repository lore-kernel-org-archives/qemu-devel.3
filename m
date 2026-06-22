Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9DACDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 05:00:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbWlB-0004K5-8J; Mon, 22 Jun 2026 00:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWl7-0004JP-Sz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:59:45 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbWl6-00081S-4C
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 00:59:45 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-697b8540279so483323a12.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 21:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782104382; cv=none;
 d=google.com; s=arc-20240605;
 b=aEqWksVAAANLboQXSnP9u01+Hnyed7qDFwWFAyd/bRHERUcrJ7amfWJpeLo7mZFZnU
 fBm49PW4ttWBIQdndmTgzBDjTATxRBxQdahVrQ3mrzonnYc1QjiasJZ2VluEj3UI9qrW
 2ZgtAu4RxLAsoobJl7QDlLEiRRSq8vePUz7fA05ni58kRPCRy+/dzHeKPmzV2ZRXpkWy
 L6AM70rpMP8QrVYEbq3Dx9EX55YZP8h56wxvHlgEvhx8YaVyfT1oJpLBeK0xE8MshzZ4
 kqJWn5QA63whGrxauqu2E+d9xao5BmcwdZtIHZVTK58k1wjVMK3AnV0bdRaLGOd3L4L9
 vvVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=h5eRS3JBtzTis1RyBjwRpM8b3wRmaXjyAApR0YSW3GY=;
 fh=y/39rxWsHsSIhiCgFyox46bvYsAfNaBS3wRFv9pkMrs=;
 b=M+rV4Ahf50Ms2GdgrgMMPjMBIh9Z062yQDXMCuAEXqAOXIxzj6Dm3ABGsIXiILIcWT
 JcEz+KEmsU9KIIGXPdRHUtwqO5VW/CA0k0FeQq5uApK5toeioG4GoVX6Pt6ZvnLp4bxv
 t4hxtNw/IzwZGuxm9g5PFhuUFiyaDfQoTTq8yFADZkRM1gj/NcR8KPGWu4z2gyR3I2zT
 jLhnpG+tUeHiM6bvMP+ROeOP2hpZom0eyGRcQV7DhIcRcMZ9t8RYqMJDcVlASOT7x0n7
 KJ+ZXuI6pyMjsZEQYXbV5PyAP8ZPHoIsTNAo5f66aTqwMKPvfFEx+iPRyo3TCzts8UYO
 wpWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782104382; x=1782709182; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5eRS3JBtzTis1RyBjwRpM8b3wRmaXjyAApR0YSW3GY=;
 b=OcTJfgDMGP5N48SexuBMC125quFErITZ5N0NonQMe+1yDWnZtjKMY1MzUzvh8y8j/8
 aPr2TLkXz7H/9wCa51TKYtNFihFGTicLtJOjXZvjI4bM9I4B1rY/9JZ0PSFgOqT0+3kV
 7qMvDpb0SsGEtCg9Z3B7oi3amPoCSq7FMlL5yyKTBk0agyxJn5F0eBNBupMwSDDD+bp0
 4o0mDBu1/h6lrMOX9DmmlCMl1+p8tzqHnZUUopV71qZ5mAPTFrLwDGAKAGlSgGS2gP2N
 Uo3/k4cWkbaWE/8d0wyGT+QWiLJkAqbghac2SeRpdv1FTH6hGODtujI26oYZVOS1IGWr
 xd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782104382; x=1782709182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h5eRS3JBtzTis1RyBjwRpM8b3wRmaXjyAApR0YSW3GY=;
 b=JnlqqZK98d54t2fTWQQxjjSLhYq2eFeziG/2Ee5eFcpvsIAEOE5omi0ioDcZttjXlw
 X4ZHiF2zRCr7E5ZoA4CrJqPsoc/9QYTvarzOWPfb510DVsJPPzp44Dsgg6oIGNpWC8BK
 2MgqkbialrNmUUgxltnwqZXcN8s2cBYfHkKKedcJc2tYD7lMSuOf/iVV+pKgpGDerJ8S
 KBEVXfbqYP2Mnnu+RykQy8Hhu3lWPnkVIfo3BETu8KR/8NWSm1EyfIynZN9HefuVvvFv
 T5EQnhPe7jfCke7Ieoc0xROw+KpAtYBJOHkTM1v9SA/3reUokH8saaiOZgPycvV+RT4n
 p7pg==
X-Gm-Message-State: AOJu0YxD93d6AnfEEW+n4PR4LHPbRmAP8URV6D7WB4RTl7jpG1DSLtb0
 T8mIJQzYVXmIeHDp97LPZrJZtSciB8O9HAHqVOG2wHalUhcl4KSeyHmB7f1CiN3xiLYw9FnLva5
 UgSjBdUlPusQe2divhjIsLJYbHd4kFIk=
X-Gm-Gg: AfdE7ckBpNlhUMD2VuWcMBd3NjNO1qIHADuWxP1hJAHaUedfIntHhuD1oOkkGoA8ga6
 n7gdi4gkvIHtlRVrN7iQ2E994Zzvz9KWGR68BcRqYp0E19GEXjJbfAe0pgPzv91wjlBMzdTcHIA
 Wbb+88NuzN+yPIR+AZrK0zczPrudOvB3sKqdHsB7Nw+Suv6JLc0MTH/UT1Ux66sdQ9gBcJ7WN7Z
 GS2WOXKn2w4+dc+OhfQ5jWIjAx+mME+4EJ2Nbln17ZaBdTryVUFFoL8V7LJ5YTlTAE+IH6pb1ZW
 JNSRZGB3+iQoFTAobPNitquFpH8=
X-Received: by 2002:a05:6402:5309:b0:696:9973:5cdb with SMTP id
 4fb4d7f45d1cf-697569b97d2mr4566333a12.28.1782104382592; Sun, 21 Jun 2026
 21:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
 <20260616235939.1358663-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260616235939.1358663-4-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 14:59:16 +1000
X-Gm-Features: AVVi8CfyR0wIO0mWHwCEQdiwUG0QlsfDr3_nBqjEsU_eZMNBfMsA9lBY0BWt4W4
Message-ID: <CAKmqyKNFAq27dm1iKUFWHwNHCftiNKp9vKjW=BcXmnEfjxzW8w@mail.gmail.com>
Subject: Re: [PATCH 3/5] hw/riscv/sifive_u: add #address-cells in PLIC FDT
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Jun 17, 2026 at 10:01=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> By Linux FDT docs in [1] the "address-cells" property is mandatory.  Set
> it to zero.
>
> While we're at it let's also put this new value and the interrupt-cells
> value in macros, like the 'virt' board is doing.
>
> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/interrup=
t-controller/sifive%2Cplic-1.0.0.txt
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/sifive_u.c         | 5 ++++-
>  include/hw/riscv/sifive_u.h | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b3468254f5..7dfc18d3ec 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -213,7 +213,10 @@ static void create_fdt(SiFiveUState *s, const MemMap=
Entry *memmap,
>      nodename =3D g_strdup_printf("/soc/interrupt-controller@%lx",
>          (long)memmap[SIFIVE_U_DEV_PLIC].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
> +                          SIFIVE_U_PLIC_INT_CELLS);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
> +                          SIFIVE_U_PLIC_ADDR_CELLS);
>      qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
>          (char **)&plic_compat, ARRAY_SIZE(plic_compat));
>      qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index e4c9860d50..aed966a62d 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -156,6 +156,8 @@ enum {
>  #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
>  #define SIFIVE_U_COMPUTE_CPU_COUNT      4
>
> +#define SIFIVE_U_PLIC_ADDR_CELLS   0
> +#define SIFIVE_U_PLIC_INT_CELLS    1
>  #define SIFIVE_U_PLIC_NUM_SOURCES 54
>  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
>  #define SIFIVE_U_PLIC_PRIORITY_BASE 0x00
> --
> 2.43.0
>
>

