Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D42DBCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:09:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENK6-00016x-0y; Wed, 07 Oct 2026 04:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1xEK0I-0002z7-UO
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:16:07 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qingwei.hu@bytedance.com>)
 id 1xEK08-000684-1s
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:15:38 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-93a40a9a01aso294830985a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1791350123; x=1791954923; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uS5ot8pqG3I+KzBdOp/XACvi4DmSZfhk1PKuxhtf74k=;
 b=lzNDZbhLNY49RAkyQHwzO8zCpB6hPQzehuZfqVjf1qSiwx4/w1AAp5GE1SSVr1oSJe
 QkWfLB1ecU6gRo4ZYMMmGN0TqAi2kHk22wK3m37t1V7sWzycRKbDCauILK9f10DS8DMJ
 jVJaDnd/iz/73AaXDJPij4IpMrAgNZk58pe+QakfcKw2c9PC0Z92xxdBi/uNS1sib2zz
 zyyNlTihUP1gZ4JABF953SMec8fopN181hZiS/nwj2imyrE2RaR2qeQCXXwFY7EHMgtx
 PsXRDsHR8Dq8IOwXh+bxEr/akpDVZ1D+WqHx4XLAqq222aM7R+n+viAo3SEAx9iPKBNg
 B2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791350123; x=1791954923;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uS5ot8pqG3I+KzBdOp/XACvi4DmSZfhk1PKuxhtf74k=;
 b=nBBctwtMGL/FGeYZ2BFLFCY8YVrZMeQLXkaLRJ92JEktRxOutID8t16wa5EMBOWSk0
 X4D35eCq1jmEE959TIRW72P5CFTshDoGArxF0IST1DsbN9uaMQVHA8GwYN6Z8Qw6JCK6
 7Y6iRBOCrNziKN3SOfM5izQqS+Ho5v05zCLUQusNo+AEBHWZv8HfoC6Rz7mSBlEqab8L
 po/+1bh72jWzcNA615OKYbKvNDEPZZH0dZ2klzBV+HRb459R8NxFZgovFOEi18mequCZ
 v9swhvhYGoLbHpqW43mchyshhL5xB9HtxhJlH9U319SjqxIp+jzW2J3yAT+/qZAz0G7T
 t48w==
X-Gm-Message-State: AFuF++nx2B06pAIZU6a53RjMJZpOaZQITXEf3biPOD2TwYk0TLIo2TED
 wVAA40vo32UPVWxosCVCdh4swZB8jN6MjBVDdGs4QWBYVHZBTN2v6BHvkakb0akTzamku1zfYHw
 +O7AW5X/0rA==
X-Gm-Gg: AYBFou293f9sNrv0u2LTqQkUK0DOn2FItzR2DtdnKJRUirjd8ja9bCW6Mggl8J3cvB4
 51mcRshfN9xj5qvHevGV9gn7yyPuGz5jEbfKtLnkvbUxU1HI+mpM/Iy4MwofO2cQB7uM0qq9W4R
 6elDo6DtscIkr8mkJvmXaVEN6vh3N3r6N5LcHgsj7tVYW3QKigLn8G6hqvmp6XdFCWfBS5P84/N
 KM0DFo+8nIThFoOc2xAlOCCJSd067XCDJCdz9WwkuqQg4B5rVj+NcSeDDHzxtp9tgtL+85ZmjCf
 M96P8KuKF3U1tW3bQ0CJ0pVH+OC53U6A4YtZ02WJngNp+cc8l6RjIsm4yvS505UMJdyA4HowV8R
 oRZJZJXSl+4ww28pGGXgb5ApFPi0JKFy7HTIUrcwqLoDc844LXpbjO1ladOYmK5KuB+2WIvqCsB
 DmgZNj72ICOFB7/i7ncsnhQNMR4ZDKXyuZ51UzP2wOOgEAAcNb+ba/5L69yFF+eOIsp1UHK56kK
 MUXkEaCP14HYefkOGtm4ZF6pWs=
X-Received: by 2002:a05:6a21:ed01:b0:3dd:a9a9:3966 with SMTP id
 adf61e73a8af0-3e11aa53f5fmr1013124637.42.1791255217244; 
 Mon, 05 Oct 2026 19:53:37 -0700 (PDT)
Received: from smtpclient.apple ([139.177.225.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cce6d2402ccsm1704760a12.6.2026.10.05.19.53.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 19:53:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 4/4] hw/riscv/virt: Limit interrupt identities to what KVM
 AIA supports
From: Qingwei Hu <qingwei.hu@bytedance.com>
In-Reply-To: <20260928-spacemit-k3-v1-4-8c57d0596b87@butz.st>
Date: Tue, 6 Oct 2026 10:53:14 +0800
Cc: qemu-devel@nongnu.org, Sunil V L <sunilvl@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AB465835-0ECC-4A80-A410-FBC0C945140F@bytedance.com>
References: <20260928-spacemit-k3-v1-0-8c57d0596b87@butz.st>
 <20260928-spacemit-k3-v1-4-8c57d0596b87@butz.st>
To: Stefan Butz <mail@butz.st>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=qingwei.hu@bytedance.com; helo=mail-qk1-x72a.google.com
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

Hi Stefan,

> On Sep 28, 2026, at 14:06, Stefan Butz via <qemu-riscv@nongnu.org> =
wrote:
>=20
> The number of interrupt identities supported by the host's KVM AIA
> is limited. On Spacemit K3 and Tenstorrent Atlantis to 63.
> virt machine alwayas aks for 255 identities, so it fails if on those
> platforms.
>=20
> Read and apply host limit from KVM AIA device and apply.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4599
>=20
> Signed-off-by: Stefan Butz <mail@butz.st>
> ---
> hw/riscv/virt.c              | 12 +++++++++++-
> target/riscv/kvm/kvm-cpu.c   | 16 ++++++++++++++++
> target/riscv/kvm/kvm-stub.c  |  5 +++++
> target/riscv/kvm/kvm_riscv.h |  1 +
> 4 files changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 28fa31d538..2af85ec5c3 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -78,6 +78,16 @@ static bool =
virt_use_emulated_aplic(RISCVVirtAIAType aia_type)
>     return riscv_use_emulated_aplic(msimode);
> }
>=20
> +static void virt_kvm_aia_create(RISCVVirtState *s)
> +{
> +    kvm_riscv_aia_create();
> +
> +    s->num_msis =3D MIN(s->num_msis, kvm_riscv_aia_get_num_ids());

The host may support more than 255 guest interrupt identities, but
this MIN() keeps num_msis capped at the default value of 255.
Is this intentional to preserve the existing default? Would it make
sense to allow users to configure a higher value when the host
supports it?

> +    if (!virt_use_emulated_aplic(s->aia_type)) {
> +        s->num_sources =3D MIN(s->num_sources, s->num_msis);

The value of num_sources has been modified here, while the value of
aplic_props.irqchip_num_sources set in create_fdt_sockets still uses
the default hard-coded value.

> +    }
> +}
> +
> static bool virt_aclint_allowed(void)
> {
>     return tcg_enabled() || qtest_enabled();
> @@ -734,7 +744,7 @@ static void virt_machine_init(MachineState =
*machine)
>     }
>=20
>     if (kvm_enabled() && virt_use_kvm_aia_aplic_imsic(s->aia_type)) {
> -        kvm_riscv_aia_create();
> +        virt_kvm_aia_create(s);
>     }
>=20
>     /* Initialize sockets */
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 1098581e7a..0409af3255 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1870,6 +1870,22 @@ void kvm_riscv_aia_create(void)
>     }
> }
>=20
> +uint64_t kvm_riscv_aia_get_num_ids(void)
> +{
> +    uint64_t num_ids;
> +    int ret;
> +
> +    ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
> +                            KVM_DEV_RISCV_AIA_CONFIG_IDS,
> +                            &num_ids, false, NULL);

The KVM CONFIG_IDS GET attribute writes a u32, so num_ids should
be uint32_t. With the current uint64_t variable, the upper 32 bits
remain uninitialized and may affect the MIN() result.

The return type, declaration, and non-KVM stub should also be
updated accordingly.

> +    if (ret < 0) {
> +        error_report("KVM AIA: failed to get number of msi");
> +        exit(1);
> +    }
> +
> +    return num_ids;
> +}
> +
> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>                         uint64_t aia_irq_num, uint64_t aia_msi_num,
>                         uint64_t aplic_base, uint64_t imsic_base,
> diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
> index 672f635b08..f5f5418b3c 100644
> --- a/target/riscv/kvm/kvm-stub.c
> +++ b/target/riscv/kvm/kvm-stub.c
> @@ -14,6 +14,11 @@ void kvm_riscv_aia_create(void)
>     g_assert_not_reached();
> }
>=20
> +uint64_t kvm_riscv_aia_get_num_ids(void)
> +{
> +    g_assert_not_reached();
> +}
> +
> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>                         uint64_t aia_irq_num, uint64_t aia_msi_num,
>                         uint64_t aplic_base, uint64_t imsic_base,
> diff --git a/target/riscv/kvm/kvm_riscv.h =
b/target/riscv/kvm/kvm_riscv.h
> index 532e42b0df..d8ae73fa1e 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -24,6 +24,7 @@
> void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
> void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
> void kvm_riscv_aia_create(void);
> +uint64_t kvm_riscv_aia_get_num_ids(void);
> void kvm_riscv_aia_init(MachineState *machine, uint64_t group_shift,
>                         uint64_t aia_irq_num, uint64_t aia_msi_num,
>                         uint64_t aplic_base, uint64_t imsic_base,
>=20
> --=20
> Git-157)
>=20

Best regards,
Qingwei Hu


