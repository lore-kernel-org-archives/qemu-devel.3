Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE309CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcuxz-00027t-9V; Thu, 25 Jun 2026 21:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuxr-00022Z-Vi
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:02:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuxo-0001UB-M2
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:02:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so827605a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:02:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435755; cv=none;
 d=google.com; s=arc-20260327;
 b=Rqq0p/W0nOBx7arqL5Glzso39ODsOkq4vHELkS55ZPupzzXokJfEQPzXbRhRApHZTi
 Bl7Jjtj3vomKqFuAFQhOjbhXTBblZQlcVi2avDQAJSNLJO++KnnAnJ1qXX7y+Vc9TlQ/
 07ERxPfkB8tEq354NBZCEdN1/vv2jvONfM4NhJKgdoLpgC0t2SiR0WlImJSGbZNkXiZd
 bqnTUfyqJzsCGT/h7M7xjzXFTgZHqebWQnDyUKtDs/Yr3dthlj+nfD1U5XyIcQuXGjQx
 RIq7LDGWwniGnaBHbLOx0Dh5IIlHLrt2JvlD9Vo/8HwhphvUmDY07qFEex+qPTDupDeC
 3I9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TTloW+0t4dsK3rw8MN+g55lrP0Q+tGDko2A3h3Tgjko=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=G9MdYLZdh6+BGuh5o7wAQeik3wMWvCbCMXAp7e/cuuJtyOt/PvCem/YEmQF05K0zQY
 oVpboXLiAApaRpw+cPYMwDgl//rSejAM9EthHJb4g9Bnx9FrfVSKo6Pc9U1So41v/PPI
 UcTmu1JyaaqhsYjXZIqpFt2JYvCYwY6ss6pVf+GXblrDBsS5yc6eEEi/btGMPJTeL7DQ
 2DCtRvMpXwsZv68W/9sBlu8DUWHv2HNbjgwQHiIEW9QKr8PFBNnL/zHTLvBNyzJ7+zVL
 U0BKm17g3AGGdBNUo0E1IscEv6ovNtc+n8XFy5BpKr2O0t+Ub8irZy1RbEzpAldg7zBJ
 61pQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782435755; x=1783040555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTloW+0t4dsK3rw8MN+g55lrP0Q+tGDko2A3h3Tgjko=;
 b=UNcyfLD1IAEORUkbDN3mwnP0VqtkeXYTh/uO0wDy27UdTX+tdhYCE4ZPmrZzvGDLEM
 DJq11HfeQQRRjP+vHSnd9HcDcsMB03GJPi4gByHksqwjAO62fbTZ7NHniQRNrqxqR41G
 Fk8wU8MgoEVMX7/paAvabD6C2FIUvt5enoRkWqO6ZG4bJMaB4FkZ12y9xG+Xs6aLL1pF
 pPSgydt/K/ln34opZP3OPhCm/9o/YtUS9uqgk3UHoJuaM4Bv6+fc6hCfRnEi2SJ3Ohq/
 c9Eyv5YkmwobRsxNUvoyyXzH6NfZDjk455ov9J52tzi2spbJSLIYufTbDMexz4U8b6bH
 fioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782435755; x=1783040555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TTloW+0t4dsK3rw8MN+g55lrP0Q+tGDko2A3h3Tgjko=;
 b=YMFPbBxEBaiNFCOFQuV44SMIRFoht7yv5/Z+8PwQXjnKcGb5k6gFIg0KFtT0kCoK6A
 ba+XiOFY8DJSPBvEyh4U/emc2Ai9MGNi8VDV0nOOGWCx5VcV58x5Cnrl/vj48AvJjAnS
 co/SPUFJudYYbDxODYtlpAn8v4Gq2k/fJa1KhuzDsL/F44MJcFlMaUO+o9385p+hlgJ4
 tREe030us2pYIBvWcmrqRrzZPtfDzdsmmdJ1s6d0tBDsacRXOS4sURY1cZlMSN4dhuiK
 RdYUwc0U3WTVMl4+4mLSqwtyy8iDncpO070kizJEWhxgAZVO4fv19mzeqzkQfdKHkwRL
 kfaA==
X-Gm-Message-State: AOJu0YxEAZI1uTnZdkOg3snIf/pOBXq29/oJsFeD3tHox4gQGiWyxAU7
 DDY3JsHVKpvSMjModcVqCP+Wdg1Elq1EufswAETy7eouFoI8ZL6izS38iK1xVO7resnhENs7yM5
 ExrvH3bGPQ9RDg06+jlnRFqZgzck5wpE=
X-Gm-Gg: AfdE7clnK1a3PndjDbr6WvTXSMoTUyBhjOnRkrOGjL15tcPMhyUhXvwB7553IT2shjO
 da8LrER0SS74mfjbSYJ45d1d+59Q4S9X2vwb1kSaq08OMyqSGBen+AqSzD9ytLGW6BVBufXylzV
 irruS71rLqlSQ6JCoqnjMHj1HUVG9L+Giv63cyUHoOBcwlcv9fliC/kDowMRNe1h0aPzT5V0RF1
 JCx86o1Awsj33PwP3I2Kirz9/E/UxQYb5nPrRcjhLFebFPUi7XcspeDPo/4SXEPfcbtha+eps6z
 RqIjNhr58ROHLdlfS6IPnDZzRJiTBn4on4Db0Q==
X-Received: by 2002:a05:6402:3492:b0:697:ad88:8cd7 with SMTP id
 4fb4d7f45d1cf-69810a5d610mr833450a12.10.1782435754630; Thu, 25 Jun 2026
 18:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-12-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-12-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:02:08 +1000
X-Gm-Features: AVVi8CcKd-y1F2VsnBUFHpfu9w6vD2j-_R3zM_HhB1TxMGUUbqxPVmdgtKTFO4s
Message-ID: <CAKmqyKMoQ20-XE14yB=35RnCJAa3CGQCEZZtkKrFeSE7RVgaJg@mail.gmail.com>
Subject: Re: [PATCH v2 11/24] target/riscv: move riscv_cpu_set_nmi() to
 tcg-cpu.c
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Wed, Jun 24, 2026 at 10:10=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> This function is related to Smrnmi and non-masked interrupts, firing up
> interrupts via env->rnmip from riscv_cpu_local_irq_pending().
>
> This is all TCG only code.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 8 --------
>  target/riscv/tcg/tcg-cpu.c | 7 +++++++
>  2 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5e951ea19c..cba7d2502e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1160,11 +1160,6 @@ static void riscv_cpu_set_irq(void *opaque, int ir=
q, int level)
>          g_assert_not_reached();
>      }
>  }
> -
> -static void riscv_cpu_set_nmi(void *opaque, int irq, int level)
> -{
> -    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
> -}
>  #endif /* CONFIG_USER_ONLY */
>
>  static bool riscv_cpu_is_dynamic(Object *cpu_obj)
> @@ -1183,9 +1178,6 @@ static void riscv_cpu_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
>                        IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
> -    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> -                            "riscv.cpu.rnmi", RNMI_MAX);
> -
>      if (mcc->def->num_triggers) {
>          env->num_triggers =3D mcc->def->num_triggers;
>      }
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index fef66557c2..4af5cd9c73 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1662,6 +1662,11 @@ static void riscv_register_custom_csrs(RISCVCPU *c=
pu, const RISCVCSR *csr_list)
>          }
>      }
>  }
> +
> +static inline void riscv_cpu_set_nmi(void *opaque, int irq, int level)
> +{
> +    riscv_cpu_set_rnmi(RISCV_CPU(opaque), irq, level);
> +}
>  #endif
>
>  static void riscv_tcg_cpu_instance_init(CPUState *cs)
> @@ -1674,6 +1679,8 @@ static void riscv_tcg_cpu_instance_init(CPUState *c=
s)
>      if (mcc->def->custom_csrs) {
>          riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
>      }
> +    qdev_init_gpio_in_named(DEVICE(cpu), riscv_cpu_set_nmi,
> +                            "riscv.cpu.rnmi", RNMI_MAX);
>  #endif
>
>      misa_ext_user_opts =3D g_hash_table_new(NULL, g_direct_equal);
> --
> 2.43.0
>
>

