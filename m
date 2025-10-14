Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD61CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8f0H-0003y2-2z; Tue, 14 Oct 2025 09:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8f0C-0003xR-KB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:23:44 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1v8f07-0007UU-Bo
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:23:44 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cmFFz705sz6GDSZ;
 Tue, 14 Oct 2025 21:20:39 +0800 (CST)
Received: from dubpeml100004.china.huawei.com (unknown [7.214.146.78])
 by mail.maildlp.com (Postfix) with ESMTPS id CD74D14010C;
 Tue, 14 Oct 2025 21:23:29 +0800 (CST)
Received: from dubpeml500004.china.huawei.com (7.214.147.1) by
 dubpeml100004.china.huawei.com (7.214.146.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Oct 2025 14:23:29 +0100
Received: from dubpeml500004.china.huawei.com ([7.214.147.1]) by
 dubpeml500004.china.huawei.com ([7.214.147.1]) with mapi id 15.02.1544.011;
 Tue, 14 Oct 2025 14:23:29 +0100
To: Salil Mehta <salil.mehta@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Salil Mehta <salil.mehta@opnsrc.net>, Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Topic: [PATCH] hw/intc/arm_gicv3_kvm: Avoid reading ICC_CTLR_EL1 from
 kernel in cpuif reset
Thread-Index: AQHcPPUb159YqalKN0iW0Ad9cDluebTBcyuAgAAtQ0A=
Date: Tue, 14 Oct 2025 13:23:29 +0000
Message-ID: <eebfcb04afc2498d8969d96fcbcf0926@huawei.com>
References: <20251014102439.319915-1-peter.maydell@linaro.org>
 <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
In-Reply-To: <261d6938fc894b1ca0979aef30fb9e1c@huawei.com>
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
> devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Salil
> Mehta via
> Sent: Tuesday, October 14, 2025 11:41 AM
> To: Peter Maydell <peter.maydell@linaro.org>; qemu-devel@nongnu.org
>=20
> Hi Peter,
>=20
> > From: qemu-devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org
> <qemu-
> > devel-bounces+salil.mehta=3Dhuawei.com@nongnu.org> On Behalf Of Peter
> > Maydell
> > Sent: Tuesday, October 14, 2025 11:25 AM
> > To: qemu-devel@nongnu.org
> >
> > Currently in arm_gicv3_icc_reset() we read the kernel's value of
> > ICC_CTLR_EL1 as part of resetting the CPU interface.  This mostly
> > works, but we're actually breaking an assumption the kernel makes that
> > userspace only accesses the in-kernel GIC data when the VM is totally
> > paused, which may not be the case if a single vCPU is being reset.
> > The effect is that it's possible that the read attempt returns EBUSY.
> >
> > Avoid this by reading the kernel's value of the reset ICC_CTLR_EL1
> > once in device realize. This brings ICC_CTLR_EL1 into line with the
> > other cpuif registers, where we assume we know what the kernel is
> > resetting them to and just update QEMU's data structures in
> arm_gicv3_icc_reset().
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I've only tested this fairly lightly, but it seems to work.
> > Salil, does this fix the EBUSY issues you were seeing ?
>=20
>=20
> Let me try this and get back to you.  Also, just to let you know that -EB=
USY
> can return from other places as well. Please check  my reply in the other=
 mail-
> chain.


Got this.

(gdb) handle SIGUSR1 nostop noprint pass
Signal        Stop      Print   Pass to program Description
SIGUSR1       No        No      Yes             User defined signal 1
(gdb) run
Starting program:
/opt/workspace/code/qemu/qemu/build/qemu-system-aarch64 --enable-kvm -machi=
ne virt,gic-version=3D3 -cpu host -smp cpus=3D2,disabledcpus=3D2 -m 300M -k=
ernel /opt/workspace/code/linux/linux/arch/arm64/boot/Image
-initrd /opt/workspace/code/filesystem/rootfs.cpio.gz -append console=3Dtty=
AMA0\ root=3D/dev/ram\ earlycon\ rdinit=3D/init\ maxcpus=3D1\ acpi=3Dforce =
-nographic -bios /opt/workspace/code/uefi/edk2/Build/ArmVirtQemu-AARCH64/RE=
LEASE_GCC5/FV/QEMU_EFI.fd
[Thread debugging using libthread_db enabled] Using host libthread_db libra=
ry "/lib/aarch64-linux-gnu/libthread_db.so.1".
[New Thread 0xfffff5b5eb40 (LWP 31994)]
[New Thread 0xfffff4e88b40 (LWP 31996)]
[New Thread 0xffffd4dfeb40 (LWP 31997)]
Unexpected error in kvm_device_access() at ../accel/kvm/kvm-all.c:3475:
qemu-system-aarch64: KVM_GET_DEVICE_ATTR failed: Group 6 attr
0x000000000000c664: Inappropriate ioctl for device

Thread 1 "qemu-system-aar" received signal SIGABRT, Aborted.
__pthread_kill_implementation (threadid=3D281474841870368, signo=3Dsigno@en=
try=3D6, no_tid=3Dno_tid@entry=3D0) at
./nptl/pthread_kill.c:44
44      ./nptl/pthread_kill.c: No such file or directory.
(gdb) bt
#0  __pthread_kill_implementation (threadid=3D281474841870368, signo=3Dsign=
o@entry=3D6, no_tid=3Dno_tid@entry=3D0) at
./nptl/pthread_kill.c:44
#1  0x0000fffff6ee2054 in __pthread_kill_internal (signo=3D6, threadid=3D<o=
ptimized out>) at ./nptl/pthread_kill.c:78
#2  0x0000fffff6e9a83c in __GI_raise (sig=3Dsig@entry=3D6) at
../sysdeps/posix/raise.c:26
#3  0x0000fffff6e87134 in __GI_abort () at ./stdlib/abort.c:79
#4  0x0000aaaaabc84a98 in error_handle (errp=3D0xaaaaad20b720 <error_abort>=
, err=3D0xaaaaad7e1a80) at ../util/error.c:38
#5  0x0000aaaaabc84c74 in error_setv
    (errp=3D0xaaaaad20b720 <error_abort>, src=3D0xaaaaabee91d0 "../accel/kv=
m/kvm-all.c", line=3D3475, func=3D0xaaaaabeea5a8 <__func__.13> "kvm_device_=
access", err_class=3DERROR_CLASS_GENERIC_ERROR,
fmt=3D0xaaaaabee9e60 "KVM_%s_DEVICE_ATTR failed: Group %d attr 0x%016lx", a=
p=3D..., suffix=3D0xfffff6fb3570 "Inappropriate ioctl for
device") at ../util/error.c:80
#6  0x0000aaaaabc84fdc in error_setg_errno_internal
    (errp=3D0xaaaaad20b720 <error_abort>, src=3D0xaaaaabee91d0 "../accel/kv=
m/kvm-all.c", line=3D3475, func=3D0xaaaaabeea5a8 <__func__.13> "kvm_device_=
access", os_errno=3D25, fmt=3D0xaaaaabee9e60 "KVM_%s_DEVICE_ATTR failed: Gr=
oup %d attr 0x%016lx") at
../util/error.c:115
#7  0x0000aaaaaba1c2b0 in kvm_device_access (fd=3D0, group=3D6, attr=3D5078=
8, val=3D0xaaaaad7b18f8, write=3Dfalse, errp=3D0xaaaaad20b720
<error_abort>) at ../accel/kvm/kvm-all.c:3475
#8  0x0000aaaaab98d204 in kvm_arm_gicv3_realize (dev=3D0xaaaaad7ac930,
errp=3D0xffffffffea00) at ../hw/intc/arm_gicv3_kvm.c:938
#9  0x0000aaaaaba27584 in device_set_realized (obj=3D0xaaaaad7ac930, value=
=3Dtrue, errp=3D0xffffffffeaf8) at ../hw/core/qdev.c:599
#10 0x0000aaaaaba32c78 in property_set_bool (obj=3D0xaaaaad7ac930, v=3D0xaa=
aaad7930c0, name=3D0xaaaaabef01a0 "realized", opaque=3D0xaaaaad302430, errp=
=3D0xffffffffeaf8) at ../qom/object.c:2375
#11 0x0000aaaaaba302b4 in object_property_set (obj=3D0xaaaaad7ac930,
name=3D0xaaaaabef01a0 "realized", v=3D0xaaaaad7930c0, errp=3D0xffffffffeaf8=
) at ../qom/object.c:1450
#12 0x0000aaaaaba36a78 in object_property_set_qobject (obj=3D0xaaaaad7ac930=
, name=3D0xaaaaabef01a0 "realized", value=3D0xaaaaad793200, errp=3D0xaaaaad=
20b728 <error_fatal>)
    at ../qom/qom-qobject.c:28
#13 0x0000aaaaaba306b8 in object_property_set_bool (obj=3D0xaaaaad7ac930, n=
ame=3D0xaaaaabef01a0 "realized", value=3Dtrue,
errp=3D0xaaaaad20b728 <error_fatal>) at ../qom/object.c:1520
#14 0x0000aaaaaba268a4 in qdev_realize (dev=3D0xaaaaad7ac930, bus=3D0xaaaaa=
d68cb20, errp=3D0xaaaaad20b728 <error_fatal>) at
../hw/core/qdev.c:297
#15 0x0000aaaaaba268e8 in qdev_realize_and_unref (dev=3D0xaaaaad7ac930, bus=
=3D0xaaaaad68cb20, errp=3D0xaaaaad20b728 <error_fatal>) at
../hw/core/qdev.c:304
#16 0x0000aaaaaaf8fbfc in sysbus_realize_and_unref (dev=3D0xaaaaad7ac930, e=
rrp=3D0xaaaaad20b728 <error_fatal>) at
../hw/core/sysbus.c:254
#17 0x0000aaaaab6375dc in create_gic (vms=3D0xaaaaad6849f0,
mem=3D0xaaaaad59cee0) at ../hw/arm/virt.c:889
#18 0x0000aaaaab63d850 in machvirt_init (machine=3D0xaaaaad6849f0) at
../hw/arm/virt.c:2810
#19 0x0000aaaaaaf86a50 in machine_run_board_init (machine=3D0xaaaaad6849f0,=
 mem_path=3D0x0, errp=3D0xffffffffee48) at
../hw/core/machine.c:1722
#20 0x0000aaaaab3ab98c in qemu_init_board () at ../system/vl.c:2723
#21 0x0000aaaaab3abdd4 in qmp_x_exit_preconfig (errp=3D0xaaaaad20b728
<error_fatal>) at ../system/vl.c:2821
#22 0x0000aaaaab3ae430 in qemu_init (argc=3D19, argv=3D0xfffffffff238) at
../system/vl.c:3882
#23 0x0000aaaaabb85008 in main (argc=3D19, argv=3D0xfffffffff238) at
../system/main.c:71
(gdb)


Please check:

[1]   https://lore.kernel.org/lkml/6ef5f8d7b52b4eee8dbf9186046e920c@huawei.=
com/
[2]   https://lore.kernel.org/lkml/8b82541b805b4a9293f15740df73eaa8@huawei.=
com/


Many thanks!

Best regards
Salil.


> >
> >  include/hw/intc/arm_gicv3_common.h |  3 ++
> >  hw/intc/arm_gicv3_kvm.c            | 49 +++++++++++++++++++++---------
> >  2 files changed, 38 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/hw/intc/arm_gicv3_common.h
> > b/include/hw/intc/arm_gicv3_common.h
> > index 38aa1961c50..61d51915e07 100644
> > --- a/include/hw/intc/arm_gicv3_common.h
> > +++ b/include/hw/intc/arm_gicv3_common.h
> > @@ -166,6 +166,9 @@ struct GICv3CPUState {
> >      uint64_t icc_igrpen[3];
> >      uint64_t icc_ctlr_el3;
> >
> > +    /* For KVM, cached copy of the kernel reset value of ICC_CTLR_EL1 =
*/
> > +    uint64_t kvm_reset_icc_ctlr_el1;
> > +
> >      /* Virtualization control interface */
> >      uint64_t ich_apr[3][4]; /* ich_apr[GICV3_G1][x] never used */
> >      uint64_t ich_hcr_el2;
> > diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c index
> > 9829e2146da..b95e6ea057a 100644
> > --- a/hw/intc/arm_gicv3_kvm.c
> > +++ b/hw/intc/arm_gicv3_kvm.c
> > @@ -666,11 +666,24 @@ static void kvm_arm_gicv3_get(GICv3State *s)
> >
> >  static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo
> > *ri)  {
> > -    GICv3State *s;
> > -    GICv3CPUState *c;
> > +    GICv3CPUState *c =3D (GICv3CPUState *)env->gicv3state;
> >
> > -    c =3D (GICv3CPUState *)env->gicv3state;
> > -    s =3D c->gic;
> > +    /*
> > +     * This function is called when each vcpu resets. The kernel
> > +     * API for the GIC assumes that it is only to be used when the
> > +     * whole VM is paused, so if we attempt to read the kernel's
> > +     * reset values here we might get EBUSY failures.
> > +     * So instead we assume we know what the kernel's reset values
> > +     * are (mostly zeroes) and only update the QEMU state struct
> > +     * fields. The exception is that we do need to know the kernel's
> > +     * idea of the ICC_CTLR_EL1 reset value, so we cache that at
> > +     * device realize time.
> > +     *
> > +     * This makes these sysregs different from the usual CPU ones,
> > +     * which can be validly read and written when only the single
> > +     * vcpu they apply to is paused, and where (in target/arm code)
> > +     * we read the reset values out of the kernel on every reset.
> > +     */
> >
> >      c->icc_pmr_el1 =3D 0;
> >      /*
> > @@ -691,16 +704,8 @@ static void arm_gicv3_icc_reset(CPUARMState
> *env,
> > const ARMCPRegInfo *ri)
> >      memset(c->icc_apr, 0, sizeof(c->icc_apr));
> >      memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
> >
> > -    if (s->migration_blocker) {
> > -        return;
> > -    }
> > -
> > -    /* Initialize to actual HW supported configuration */
> > -    kvm_device_access(s->dev_fd,
> > KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
> > -                      KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
> > -                      &c->icc_ctlr_el1[GICV3_NS], false, &error_abort)=
;
> > -
> > -    c->icc_ctlr_el1[GICV3_S] =3D c->icc_ctlr_el1[GICV3_NS];
> > +    c->icc_ctlr_el1[GICV3_NS] =3D c->kvm_reset_icc_ctlr_el1;
> > +    c->icc_ctlr_el1[GICV3_S] =3D c->kvm_reset_icc_ctlr_el1;
> >  }
> >
> >  static void kvm_arm_gicv3_reset_hold(Object *obj, ResetType type) @@
> > -
> > 939,6 +944,22 @@ static void kvm_arm_gicv3_realize(DeviceState *dev,
> > Error **errp)
> >                                      kvm_arm_gicv3_notifier,
> >                                      MIG_MODE_CPR_TRANSFER);
> >      }
> > +
> > +    /*
> > +     * Now we can read the kernel's initial value of ICC_CTLR_EL1, whi=
ch
> > +     * we will need if a CPU interface is reset. If the kernel is anci=
ent
> > +     * and doesn't support writing the GIC state then we don't need to
> > +     * care what reset does to QEMU's data structures.
> > +     */
> > +    if (!s->migration_blocker) {
> > +        for (i =3D 0; i < s->num_cpu; i++) {
> > +            GICv3CPUState *c =3D &s->cpu[i];
> > +
> > +            kvm_device_access(s->dev_fd,
> > KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
> > +                              KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_type=
r),
> > +                              &c->kvm_reset_icc_ctlr_el1, false, &erro=
r_abort);
> > +        }
> > +    }
> >  }
> >
> >  static void kvm_arm_gicv3_class_init(ObjectClass *klass, const void
> > *data)
> > --
> > 2.43.0
> >
>=20


