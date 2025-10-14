Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77977CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 10:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cTC-0002Ek-WB; Tue, 14 Oct 2025 06:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8cT9-0002EC-Ho
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:41:27 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8cT3-0003PS-23
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 06:41:27 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cm9fc24WBz6GDNK;
 Tue, 14 Oct 2025 18:38:16 +0800 (CST)
Received: from dubpeml500003.china.huawei.com (unknown [7.214.146.145])
 by mail.maildlp.com (Postfix) with ESMTPS id CBA0D1402FE;
 Tue, 14 Oct 2025 18:41:05 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml500003.china.huawei.com (7.214.146.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 11:41:05 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 11:41:05 +0100
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuA
Date: Tue, 14 Oct 2025 10:41:05 +0000
Message-ID: <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
In-Reply-To: <20251014102439.319915-1-peter.maydell@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.67.200]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

> From: qemu-devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org <qemu-
> devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Peter
> Maydell
> Sent: Tuesday, October 14, 2025 11:25 AM
> To: qemu-devel@nongnu.org
>=20
> Currently in arm_gicv3_icc_reset() we read the kernel's value of
> ICC_CTLR_EL1 as part of resetting the CPU interface.  This mostly works, =
but
> we're actually breaking an assumption the kernel makes that userspace onl=
y
> accesses the in-kernel GIC data when the VM is totally paused, which may
> not be the case if a single vCPU is being reset.  The effect is that it's=
 possible
> that the read attempt returns EBUSY.
>=20
> Avoid this by reading the kernel's value of the reset ICC_CTLR_EL1 once i=
n
> device realize. This brings ICC_CTLR_EL1 into line with the other cpuif
> registers, where we assume we know what the kernel is resetting them to
> and just update QEMU's data structures in arm_gicv3_icc_reset().
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I've only tested this fairly lightly, but it seems to work.
> Salil, does this fix the EBUSY issues you were seeing ?


Let me try this and get back to you.  Also, just to let you know that -EBUS=
Y
can return from other places as well. Please check  my reply in the other
mail-chain.

Many thanks!

Best regards
Salil.

>=20
>  include/hw/intc/arm_gicv3_common.h |  3 ++
>  hw/intc/arm_gicv3_kvm.c            | 49 +++++++++++++++++++++---------
>  2 files changed, 38 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/hw/intc/arm_gicv3_common.h
> b/include/hw/intc/arm_gicv3_common.h
> index 38aa1961c50..61d51915e07 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -166,6 +166,9 @@ struct GICv3CPUState {
>      uint64_t icc_igrpen[3];
>      uint64_t icc_ctlr_el3;
>=20
> +    /* For KVM, cached copy of the kernel reset value of ICC_CTLR_EL1 */
> +    uint64_t kvm_reset_icc_ctlr_el1;
> +
>      /* Virtualization control interface */
>      uint64_t ich_apr[3][4]; /* ich_apr[GICV3_G1][x] never used */
>      uint64_t ich_hcr_el2;
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c index
> 9829e2146da..b95e6ea057a 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -666,11 +666,24 @@ static void kvm_arm_gicv3_get(GICv3State *s)
>=20
>  static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo
> *ri)  {
> -    GICv3State *s;
> -    GICv3CPUState *c;
> +    GICv3CPUState *c =3D (GICv3CPUState *)env->gicv3state;
>=20
> -    c =3D (GICv3CPUState *)env->gicv3state;
> -    s =3D c->gic;
> +    /*
> +     * This function is called when each vcpu resets. The kernel
> +     * API for the GIC assumes that it is only to be used when the
> +     * whole VM is paused, so if we attempt to read the kernel's
> +     * reset values here we might get EBUSY failures.
> +     * So instead we assume we know what the kernel's reset values
> +     * are (mostly zeroes) and only update the QEMU state struct
> +     * fields. The exception is that we do need to know the kernel's
> +     * idea of the ICC_CTLR_EL1 reset value, so we cache that at
> +     * device realize time.
> +     *
> +     * This makes these sysregs different from the usual CPU ones,
> +     * which can be validly read and written when only the single
> +     * vcpu they apply to is paused, and where (in target/arm code)
> +     * we read the reset values out of the kernel on every reset.
> +     */
>=20
>      c->icc_pmr_el1 =3D 0;
>      /*
> @@ -691,16 +704,8 @@ static void arm_gicv3_icc_reset(CPUARMState *env,
> const ARMCPRegInfo *ri)
>      memset(c->icc_apr, 0, sizeof(c->icc_apr));
>      memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
>=20
> -    if (s->migration_blocker) {
> -        return;
> -    }
> -
> -    /* Initialize to actual HW supported configuration */
> -    kvm_device_access(s->dev_fd,
> KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
> -                      KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
> -                      &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
> -
> -    c->icc_ctlr_el1[GICV3_S] =3D c->icc_ctlr_el1[GICV3_NS];
> +    c->icc_ctlr_el1[GICV3_NS] =3D c->kvm_reset_icc_ctlr_el1;
> +    c->icc_ctlr_el1[GICV3_S] =3D c->kvm_reset_icc_ctlr_el1;
>  }
>=20
>  static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type) @@ -
> 939,6 +944,22 @@ static void kvm_arm_gicv3_realize(DeviceState *dev,
> Error **errp)
>                                      kvm_arm_gicv3_notifier,
>                                      MIG_MODE_CPR_TRANSFER);
>      }
> +
> +    /*
> +     * Now we can read the kernel's initial value of ICC_CTLR_EL1, which
> +     * we will need if a CPU interface is reset. If the kernel is ancien=
t
> +     * and doesn't support writing the GIC state then we don't need to
> +     * care what reset does to QEMU's data structures.
> +     */
> +    if (!s->migration_blocker) {
> +        for (i =3D 0; i < s->num_cpu; i++) {
> +            GICv3CPUState *c =3D &s->cpu[i];
> +
> +            kvm_device_access(s->dev_fd,
> KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
> +                              KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer)=
,
> +                              &c->kvm_reset_icc_ctlr_el1, false, &error_=
abort);
> +        }
> +    }
>  }
>=20
>  static void kvm_arm_gicv3_class_init(ObjectClass *klass, const void *dat=
a)
> --
> 2.43.0
>=20


