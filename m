Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6BACCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 10:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8zDS-00012J-58; Wed, 15 Oct 2025 06:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8zDP-00010q-JJ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:58:43 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8zDI-0006iO-B2
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 06:58:43 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmp22481Gz6L51H;
 Wed, 15 Oct 2025 18:57:14 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id 03580140371;
 Wed, 15 Oct 2025 18:58:16 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 11:58:15 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Wed, 15 Oct 2025 11:58:15 +0100
To: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTC/hsA
Date: Wed, 15 Oct 2025 10:58:15 +0000
Message-ID: <d6f9dfa368b2419998379ac9dd986a7b@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
In-Reply-To: <20251014102439.319915-1-peter.maydell@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.66.179]
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
> Cc: Salil Mehta <salil.mehta@opnsrc.net>; Marc Zyngier <maz@kernel.org>
> Subject: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
> kernel in cpuif reset
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
>=20
>  include/hw/intc/arm_gicv3_common.h |  3 ++
>  hw/intc/arm_gicv3_kvm.c            | 49 +++++++++++++++++++++---------
>  2 files changed, 38 insertions(+), 14 deletions(-)
>=20
[...]
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


Above changes assume that the driver's configured value of the ICC_CTLR_EL1
system register is the same as the default value. I've verified that this
currently the case. However, it safe to assume that this will remain true
in the future as well?

If it is acceptable to always use the default values, then the existing cha=
nge
proposed in RFC V6 only requires a minor modification. Specifically, we can
remove ' first_psci_on_request_seen' and other related code that updates
the driver-configured value after the guest kernel has loaded during runtim=
e.

We can instead cache the value once during the first cpu_reset() for each
CPU interface and reuse that cached value for all subsequent cpu_reset()
operations.  This would simplify the implementation while retaining
major goals.

https://lore.kernel.org/qemu-devel/20251001010127.3092631-22-salil.mehta@op=
nsrc.net/

You humble Consideration:

Calling pause_vcpus_all() at VM initialization time--during  the first
cpu_reset()--should not cause any issues, as all secondary vCPUs are idle
(i.e. their PCs are not initialized and kernel has not yet loaded). Pausing
such vCPUs at this stage should not be a disruptive action.

Moreover, if this stage poses a problem for a KVM device IOCTL access, it
similarly affect other components like GICv3 ITS, which also uses KVM
device IOCTL during GICv3 reset hold. At this stage all the vCPUs should st=
ill
be in a pre-boot or idle state

static void kvm_arm_its_reset_hold(Object *obj, ResetType type)
{
[...]

    if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                               KVM_DEV_ARM_ITS_CTRL_RESET)) {
        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                          KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_ab=
ort);
        return;
    }
[...]

}

We are not even pausing vCPUs here, yet we expect above KVM device IOCTL
to succeed on the first attempt. The operation also ends up acquiring the
mutex for all vCPUs within the KVM.=20


Many thanks!

Best regards
Salil.











