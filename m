Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3060C5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 08:00:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy37k-0000Kk-MM; Sun, 23 Aug 2026 04:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1wy37i-0000HQ-Qy
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:00:10 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1wy37b-0001UH-JF
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 04:00:10 -0400
Received: from yuno-loong.localnet (unknown [IPv6:2a14:640:1:12b5::1])
 by krgm.moe (Postfix) with ESMTPSA id 616FB2623;
 Sun, 23 Aug 2026 13:29:55 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: Re: [PATCH v3 6/8] target/loongarch: Add LVZ CPU runtime control
Date: Sun, 23 Aug 2026 15:59:53 +0800
Message-ID: <V1D66i6GR6mtEwfPu_3HXA@krgm.moe>
In-Reply-To: <8d612056-5403-ba82-5e39-87ee08bdcb96@loongson.cn>
References: <cover.1783673526.git.prcups@krgm.moe>
 <6b2c0a4b5a78df100ea7e36bfa8cfd31e1d6eeb6.1783673526.git.prcups@krgm.moe>
 <8d612056-5403-ba82-5e39-87ee08bdcb96@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

On 2026=E5=B9=B47=E6=9C=8813=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80 =E4=B8=AD=
=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 17:10:24=EF=BC=8CBibo Mao wro=
te=EF=BC=9A
>=20
> On 2026/7/10 =E4=B8=8B=E5=8D=885:00, SignKirigami wrote:
> > Wire the LVZ CPU property, VM entry bookkeeping, VM exit trigger, guest
> > interrupt delivery, guest constant timer support and guest CSR helpers
> > into the LoongArch TCG runtime, leaving memory translation and PTW
> > changes for a separate patch.
> This patch is critical exception and interrupt handling in different VM=20
> mode, I think it should be separated with different small patches with
> every VM special exception handling, interrupt handling, guest timer=20
> emulation for better review.
> >=20
> > Signed-off-by: SignKirigami <prcups@krgm.moe>
> > Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> > ---
> >   target/loongarch/cpu.c                | 277 +++++++++++++++++++-------
> >   target/loongarch/internals.h          |   8 +-
> >   target/loongarch/machine.c            | 125 +++++++++++-
> >   target/loongarch/tcg/constant_timer.c |  74 ++++++-
> >   target/loongarch/tcg/csr_helper.c     | 136 ++++++++++++-
> >   target/loongarch/tcg/helper.h         |  13 +-
> >   target/loongarch/tcg/op_helper.c      |  45 ++++-
> >   target/loongarch/tcg/tcg_cpu.c        |  65 ++++--
> >   8 files changed, 641 insertions(+), 102 deletions(-)
> >=20
> > diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> > index 492b17e136..093b2a057f 100644
> > --- a/target/loongarch/cpu.c
> > +++ b/target/loongarch/cpu.c
> > @@ -62,17 +62,22 @@ void loongarch_cpu_set_irq(void *opaque, int irq, i=
nt level)
> >       LoongArchCPU *cpu =3D opaque;
> >       CPULoongArchState *env =3D &cpu->env;
> >       CPUState *cs =3D CPU(cpu);
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >  =20
> >       if (irq < 0 || irq >=3D N_IRQS) {
> >           return;
> >       }
> >  =20
> > +    if (FIELD_EX64(host->CSR_GINTC, CSR_GINTC, HWIP) & BIT(irq)) {
> > +        loongarch_cpu_set_irq_guest(opaque, irq, level);
> > +        return;
> > +    }
> Should this piece of code be moved to helper_csrwr_gintc()?
This piece means when host interrupt is set and corresponding bit of HWIP i=
s true,
the host interrupt should be converted to guest interrupt.
>=20
> > +
> >       if (kvm_enabled()) {
> >           kvm_loongarch_set_interrupt(cpu, irq, level);
> >       } else if (tcg_enabled()) {
> > -        sys->CSR_ESTAT =3D deposit64(sys->CSR_ESTAT, irq, 1, level !=
=3D 0);
> > -        if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
> > +        host->CSR_ESTAT =3D deposit64(host->CSR_ESTAT, irq, 1, level !=
=3D 0);
> > +        if (FIELD_EX64(host->CSR_ESTAT, CSR_ESTAT, IS)) {
> >               cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> >           } else {
> >               cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> > @@ -80,18 +85,66 @@ void loongarch_cpu_set_irq(void *opaque, int irq, i=
nt level)
> >       }
> >   }
> >  =20
> > +void loongarch_cpu_set_irq_guest(void *opaque, int irq, int level)
> > +{
> > +    LoongArchCPU *cpu =3D opaque;
> > +    CPULoongArchState *env =3D &cpu->env;
> > +    CPUState *cs =3D CPU(cpu);
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +
> > +    if (irq < 0 || irq >=3D N_IRQS) {
> > +        return;
> > +    }
> > +
> > +    guest->CSR_ESTAT =3D deposit64(guest->CSR_ESTAT, irq, 1, level !=
=3D 0);
> > +    if (env_vm_level(env) =3D=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        if (FIELD_EX64(guest->CSR_ESTAT, CSR_ESTAT, IS)) {
> > +            cpu_interrupt(cs, CPU_INTERRUPT_GUEST);
> > +        } else {
> > +            cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
> > +        }
> > +    }
> > +}
> > +
> >   /* Check if there is pending and not masked out interrupt */
> >   bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
> >   {
> >       uint32_t pending;
> >       uint32_t status;
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >  =20
> > -    pending =3D FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS);
> > -    status  =3D FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
> > +    pending =3D FIELD_EX64(host->CSR_ESTAT, CSR_ESTAT, IS);
> > +    status  =3D FIELD_EX64(host->CSR_ECFG, CSR_ECFG, LIE);
> >  =20
> >       return (pending & status) !=3D 0;
> >   }
> > +
> > +static inline bool cpu_loongarch_hw_interrupts_enabled_guest(
> > +    CPULoongArchState *env)
> > +{
> > +    return FIELD_EX64(env->sys_states[LOONGARCH_VM_LEVEL_GUEST].CSR_CR=
MD,
> > +                      CSR_CRMD, IE);
> > +}
> > +
> > +static inline bool cpu_loongarch_hw_interrupts_pending_guest(
> > +    CPULoongArchState *env)
> > +{
> > +    uint32_t pending;
> > +    uint32_t status;
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +
> > +    pending =3D FIELD_EX64(guest->CSR_ESTAT, CSR_ESTAT, IS);
> > +    status =3D FIELD_EX64(guest->CSR_ECFG, CSR_ECFG, LIE);
> > +
> > +    return (pending & status) !=3D 0;
> > +}
> > +
> > +bool loongarch_guest_has_interrupt(CPULoongArchState *env)
> > +{
> > +    return env_vm_level(env) =3D=3D LOONGARCH_VM_LEVEL_GUEST &&
> > +           cpu_loongarch_hw_interrupts_enabled_guest(env) &&
> > +           cpu_loongarch_hw_interrupts_pending_guest(env);
> > +}
> >   #endif
> >  =20
> >   #ifndef CONFIG_USER_ONLY
> > @@ -104,22 +157,77 @@ bool loongarch_cpu_has_work(CPUState *cs)
> >           has_work =3D true;
> >       }
> >  =20
> > +    if (cpu_test_interrupt(cs, CPU_INTERRUPT_GUEST) &&
> > +        loongarch_guest_has_interrupt(cpu_env(cs))) {
> > +        has_work =3D true;
> > +    }
> > +
> >       return has_work;
> >   }
> >   #endif /* !CONFIG_USER_ONLY */
> >  =20
> > +uint8_t get_tgid(CPULoongArchState *env)
> > +{
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> > +
> > +    if (env_vm_level(env) =3D=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        return get_gid(env);
> > +    }
> > +
> > +    if (FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETGID)) {
> > +        return FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID);
> > +    } else if (will_return_to_guest(env)) {
> > +        return get_gid(env);
> > +    }
> > +    return 0;
> > +}
> > +
> > +bool will_return_to_guest(CPULoongArchState *env)
> > +{
> > +    if (!has_lvz_capability(env) ||
> > +        env_vm_level(env) =3D=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        return false;
> > +    }
> > +    return FIELD_EX64(env->sys_states[LOONGARCH_VM_LEVEL_HOST].CSR_GST=
AT,
> > +                      CSR_GSTAT, PVM);
> > +}
> > +
> > +bool has_lvz_capability(CPULoongArchState *env)
> > +{
> > +    return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
> > +}
> > +
> > +uint8_t get_gid(CPULoongArchState *env)
> > +{
> > +    return FIELD_EX64(env->sys_states[LOONGARCH_VM_LEVEL_HOST].CSR_GST=
AT,
> > +                      CSR_GSTAT, GID);
> > +}
> > +
> > +void trigger_vm_exit(CPULoongArchState *env)
> > +{
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> > +
> > +    if (env_vm_level(env) !=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        return;
> > +    }
> > +
> > +    cpu_loongarch_set_guest_timer(env_archcpu(env), false);
> > +    host->CSR_GSTAT =3D FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, PVM, 1);
> > +    env->vm_exit =3D true;
> > +}
> > +
> >   static void loongarch_la464_init_csr(DeviceState *dev)
> >   {
> >   #ifndef CONFIG_USER_ONLY
> >       static bool initialized;
> >       LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> >       CPULoongArchState *env =3D &cpu->env;
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >       int i, num;
> >  =20
> >       if (!initialized) {
> >           initialized =3D true;
> > -        num =3D FIELD_EX64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
> > +        num =3D FIELD_EX64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
> >           for (i =3D num; i < 16; i++) {
> >               set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
> >           }
> > @@ -251,11 +359,32 @@ static void loongarch_set_ptw(Object *obj, bool v=
alue, Error **errp)
> >       cpu->env.cpucfg[2] =3D FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HP=
TW, value);
> >   }
> >  =20
> > +static bool loongarch_get_lvz(Object *obj, Error **errp)
> > +{
> > +    return LOONGARCH_CPU(obj)->lvz !=3D ON_OFF_AUTO_OFF;
> > +}
> > +
> > +static void loongarch_set_lvz(Object *obj, bool value, Error **errp)
> > +{
> > +    LoongArchCPU *cpu =3D LOONGARCH_CPU(obj);
> > +
> > +    cpu->lvz =3D value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> > +
> > +    if (kvm_enabled()) {
> > +        return;
> > +    }
> > +
> > +    cpu->env.cpucfg[2] =3D FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ=
, value);
> > +    cpu->env.cpucfg[2] =3D FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ=
_VER,
> > +                                    value ? 1 : 0);
> > +}
> > +
> >   static void loongarch_cpu_post_init(Object *obj)
> >   {
> >       LoongArchCPU *cpu =3D LOONGARCH_CPU(obj);
> >  =20
> >       cpu->lbt =3D ON_OFF_AUTO_OFF;
> > +    cpu->lvz =3D ON_OFF_AUTO_AUTO;
> >       cpu->pmu =3D ON_OFF_AUTO_OFF;
> >       cpu->lsx =3D ON_OFF_AUTO_AUTO;
> >       cpu->lasx =3D ON_OFF_AUTO_AUTO;
> > @@ -267,6 +396,8 @@ static void loongarch_cpu_post_init(Object *obj)
> >                                loongarch_set_msgint);
> >       object_property_add_bool(obj, "ptw", loongarch_get_ptw,
> >                                loongarch_set_ptw);
> > +    object_property_add_bool(obj, "lvz", loongarch_get_lvz,
> > +                             loongarch_set_lvz);
> >       /* lbt is enabled only in kvm mode, not supported in tcg mode */
> >  =20
> >       if (kvm_enabled()) {
> > @@ -278,11 +409,11 @@ static void loongarch_la464_initfn(Object *obj)
> >   {
> >       LoongArchCPU *cpu =3D LOONGARCH_CPU(obj);
> >       CPULoongArchState *env =3D &cpu->env;
> > -    CPUSysState *sys;
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> >       uint32_t data =3D 0, field;
> >       int i;
> >  =20
> > -    set_sys_state(env, &env->sys_states[0]);
> >       for (i =3D 0; i < 21; i++) {
> >           env->cpucfg[i] =3D 0x0;
> >       }
> > @@ -322,6 +453,8 @@ static void loongarch_la464_initfn(Object *obj)
> >       data =3D FIELD_DP32(data, CPUCFG2, FP_VER, 1);
> >       data =3D FIELD_DP32(data, CPUCFG2, LSX, 1),
> >       data =3D FIELD_DP32(data, CPUCFG2, LASX, 1),
> > +    data =3D FIELD_DP32(data, CPUCFG2, LVZ, 1);
> > +    data =3D FIELD_DP32(data, CPUCFG2, LVZ_VER, 1);
> >       data =3D FIELD_DP32(data, CPUCFG2, LLFTP, 1);
> >       data =3D FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
> >       data =3D FIELD_DP32(data, CPUCFG2, LSPW, 1);
> > @@ -386,19 +519,19 @@ static void loongarch_la464_initfn(Object *obj)
> >       data =3D FIELD_DP32(data, CPUCFG20, L3IU_SIZE, 6);
> >       env->cpucfg[20] =3D data;
> >  =20
> > -    sys =3D env_sys(env);
> > -    sys->CSR_ASID =3D FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
> > +    host->CSR_ASID =3D FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
> > +    guest->CSR_ASID =3D host->CSR_ASID;
> >  =20
> > -    sys->CSR_PRCFG1 =3D FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_N=
UM, 8);
> > -    sys->CSR_PRCFG1 =3D FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, TIMER_=
BITS, 0x2f);
> > -    sys->CSR_PRCFG1 =3D FIELD_DP64(sys->CSR_PRCFG1, CSR_PRCFG1, VSMAX,=
 7);
> > +    host->CSR_PRCFG1 =3D FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE=
_NUM, 8);
> > +    host->CSR_PRCFG1 =3D FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, TIME=
R_BITS, 0x2f);
> > +    host->CSR_PRCFG1 =3D FIELD_DP64(host->CSR_PRCFG1, CSR_PRCFG1, VSMA=
X, 7);
> >  =20
> > -    sys->CSR_PRCFG2 =3D 0x3ffff000;
> > +    host->CSR_PRCFG2 =3D 0x3ffff000;
> >  =20
> > -    sys->CSR_PRCFG3 =3D FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, TLB_TY=
PE, 2);
> > -    sys->CSR_PRCFG3 =3D FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, MTLB_E=
NTRY, 63);
> > -    sys->CSR_PRCFG3 =3D FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_W=
AYS, 7);
> > -    sys->CSR_PRCFG3 =3D FIELD_DP64(sys->CSR_PRCFG3, CSR_PRCFG3, STLB_S=
ETS, 8);
> > +    host->CSR_PRCFG3 =3D FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, TLB_=
TYPE, 2);
> > +    host->CSR_PRCFG3 =3D FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, MTLB=
_ENTRY, 63);
> > +    host->CSR_PRCFG3 =3D FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB=
_WAYS, 7);
> > +    host->CSR_PRCFG3 =3D FIELD_DP64(host->CSR_PRCFG3, CSR_PRCFG3, STLB=
_SETS, 8);
> >  =20
> >       cpu->msgint =3D ON_OFF_AUTO_OFF;
> >       cpu->ptw =3D ON_OFF_AUTO_OFF;
> > @@ -412,7 +545,6 @@ static void loongarch_la132_initfn(Object *obj)
> >       uint32_t data =3D 0;
> >       int i;
> >  =20
> > -    set_sys_state(env, &env->sys_states[0]);
> >       for (i =3D 0; i < 21; i++) {
> >           env->cpucfg[i] =3D 0x0;
> >       }
> > @@ -439,6 +571,7 @@ static void loongarch_la132_initfn(Object *obj)
> >       data =3D FIELD_DP32(data, CPUCFG1, CRC, 1);
> >       env->cpucfg[1] =3D data;
> >       cpu->msgint =3D ON_OFF_AUTO_OFF;
> > +    cpu->lvz =3D ON_OFF_AUTO_OFF;
> >       cpu->ptw =3D ON_OFF_AUTO_OFF;
> >   }
> >  =20
> > @@ -596,11 +729,10 @@ static void loongarch_host_initfn(Object *obj)
> >  =20
> >   static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
> >   {
> > -    uint8_t tlb_ps;
> >       CPUState *cs =3D CPU(obj);
> >       LoongArchCPUClass *lacc =3D LOONGARCH_CPU_GET_CLASS(obj);
> >       CPULoongArchState *env =3D cpu_env(cs);
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >  =20
> >       if (lacc->parent_phases.hold) {
> >           lacc->parent_phases.hold(obj, type);
> > @@ -622,63 +754,72 @@ static void loongarch_cpu_reset_hold(Object *obj,=
 ResetType type)
> >   #endif
> >       env->fcsr0 =3D 0x0;
> >  =20
> > -    int n;
> >       /* Set csr registers value after reset, see the manual 6.4. */
> > -    sys->CSR_CRMD =3D FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PLV, 0);
> > -    sys->CSR_CRMD =3D FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, 0);
> > -    sys->CSR_CRMD =3D FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
> > -    sys->CSR_CRMD =3D FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, PG, 0);
> > -    sys->CSR_CRMD =3D FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATF, 0);
> > -    sys->CSR_CRMD =3D FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DATM, 0);
> > -
> > -    sys->CSR_EUEN =3D FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, FPE, 0);
> > -    sys->CSR_EUEN =3D FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, SXE, 0);
> > -    sys->CSR_EUEN =3D FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, ASXE, 0);
> > -    sys->CSR_EUEN =3D FIELD_DP64(sys->CSR_EUEN, CSR_EUEN, BTE, 0);
> > -
> > -    sys->CSR_MISC =3D 0;
> > -
> > -    sys->CSR_ECFG =3D FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, VS, 0);
> > -    sys->CSR_ECFG =3D FIELD_DP64(sys->CSR_ECFG, CSR_ECFG, LIE, 0);
> > -
> > -    sys->CSR_ESTAT =3D sys->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
> > -    sys->CSR_RVACFG =3D FIELD_DP64(sys->CSR_RVACFG, CSR_RVACFG, RBITS,=
 0);
> > -    sys->CSR_CPUID =3D cs->cpu_index;
> > -    sys->CSR_TCFG =3D FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
> > -    sys->CSR_LLBCTL =3D FIELD_DP64(sys->CSR_LLBCTL, CSR_LLBCTL, KLO, 0=
);
> > -    sys->CSR_TLBRERA =3D FIELD_DP64(sys->CSR_TLBRERA, CSR_TLBRERA, IST=
LBR, 0);
> > -    sys->CSR_MERRCTL =3D FIELD_DP64(sys->CSR_MERRCTL, CSR_MERRCTL, ISM=
ERR, 0);
> > -    sys->CSR_TID =3D cs->cpu_index;
> > +    host->CSR_CRMD =3D FIELD_DP64(host->CSR_CRMD, CSR_CRMD, PLV, 0);
> > +    host->CSR_CRMD =3D FIELD_DP64(host->CSR_CRMD, CSR_CRMD, IE, 0);
> > +    host->CSR_CRMD =3D FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DA, 1);
> > +    host->CSR_CRMD =3D FIELD_DP64(host->CSR_CRMD, CSR_CRMD, PG, 0);
> > +    host->CSR_CRMD =3D FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DATF, 0);
> > +    host->CSR_CRMD =3D FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DATM, 0);
> > +
> > +    host->CSR_EUEN =3D FIELD_DP64(host->CSR_EUEN, CSR_EUEN, FPE, 0);
> > +    host->CSR_EUEN =3D FIELD_DP64(host->CSR_EUEN, CSR_EUEN, SXE, 0);
> > +    host->CSR_EUEN =3D FIELD_DP64(host->CSR_EUEN, CSR_EUEN, ASXE, 0);
> > +    host->CSR_EUEN =3D FIELD_DP64(host->CSR_EUEN, CSR_EUEN, BTE, 0);
> > +
> > +    host->CSR_MISC =3D 0;
> > +
> > +    host->CSR_ECFG =3D FIELD_DP64(host->CSR_ECFG, CSR_ECFG, VS, 0);
> > +    host->CSR_ECFG =3D FIELD_DP64(host->CSR_ECFG, CSR_ECFG, LIE, 0);
> > +
> > +    host->CSR_ESTAT =3D host->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
> > +    host->CSR_RVACFG =3D FIELD_DP64(host->CSR_RVACFG, CSR_RVACFG, RBIT=
S, 0);
> > +    host->CSR_CPUID =3D cs->cpu_index;
> > +    host->CSR_TCFG =3D FIELD_DP64(host->CSR_TCFG, CSR_TCFG, EN, 0);
> > +    host->CSR_LLBCTL =3D FIELD_DP64(host->CSR_LLBCTL, CSR_LLBCTL, KLO,=
 0);
> > +    host->CSR_TLBRERA =3D FIELD_DP64(host->CSR_TLBRERA, CSR_TLBRERA, I=
STLBR, 0);
> > +    host->CSR_MERRCTL =3D FIELD_DP64(host->CSR_MERRCTL, CSR_MERRCTL, I=
SMERR, 0);
> > +    host->CSR_TID =3D cs->cpu_index;
> > +    host->CSR_GSTAT =3D 0;
> > +    host->CSR_GCFG =3D 0;
> > +    host->CSR_GINTC =3D 0;
> > +    host->CSR_GCNTC =3D 0;
> > +    host->CSR_GTLBC =3D 0;
> > +    host->CSR_TRGP =3D 0;
> >       /*
> >        * Workaround for edk2-stable202408, CSR PGD register is set only=
 if
> >        * its value is equal to zero for boot cpu, it causes reboot issu=
e.
> >        *
> >        * Here clear CSR registers relative with TLB.
> >        */
> > -    sys->CSR_PGDH =3D 0;
> > -    sys->CSR_PGDL =3D 0;
> > -    sys->CSR_PWCH =3D 0;
> > -    sys->CSR_EENTRY =3D 0;
> > -    sys->CSR_TLBRENTRY =3D 0;
> > -    sys->CSR_MERRENTRY =3D 0;
> > +    host->CSR_PGDH =3D 0;
> > +    host->CSR_PGDL =3D 0;
> > +    host->CSR_PWCH =3D 0;
> > +    host->CSR_EENTRY =3D 0;
> > +    host->CSR_TLBRENTRY =3D 0;
> > +    host->CSR_MERRENTRY =3D 0;
> >       /* set CSR_PWCL.PTBASE and CSR_STLBPS.PS bits from CSR_PRCFG2 */
> > -    if (sys->CSR_PRCFG2 =3D=3D 0) {
> > -        sys->CSR_PRCFG2 =3D 0x3fffff000;
> > +    if (host->CSR_PRCFG2 =3D=3D 0) {
> > +        host->CSR_PRCFG2 =3D 0x3fffff000;
> >       }
> > -    tlb_ps =3D ctz32(sys->CSR_PRCFG2);
> > -    sys->CSR_STLBPS =3D FIELD_DP64(sys->CSR_STLBPS, CSR_STLBPS, PS, tl=
b_ps);
> > -    sys->CSR_PWCL =3D FIELD_DP64(sys->CSR_PWCL, CSR_PWCL, PTBASE, tlb_=
ps);
> > -    for (n =3D 0; n < 4; n++) {
> > -        sys->CSR_DMW[n] =3D FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV0,=
 0);
> > -        sys->CSR_DMW[n] =3D FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV1,=
 0);
> > -        sys->CSR_DMW[n] =3D FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV2,=
 0);
> > -        sys->CSR_DMW[n] =3D FIELD_DP64(sys->CSR_DMW[n], CSR_DMW, PLV3,=
 0);
> > +    uint8_t tlb_ps =3D ctz32(host->CSR_PRCFG2);
> > +    host->CSR_STLBPS =3D FIELD_DP64(host->CSR_STLBPS, CSR_STLBPS, PS, =
tlb_ps);
> > +    host->CSR_PWCL =3D FIELD_DP64(host->CSR_PWCL, CSR_PWCL, PTBASE, tl=
b_ps);
> > +    for (int n =3D 0; n < 4; n++) {
> > +        host->CSR_DMW[n] =3D FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV=
0, 0);
> > +        host->CSR_DMW[n] =3D FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV=
1, 0);
> > +        host->CSR_DMW[n] =3D FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV=
2, 0);
> > +        host->CSR_DMW[n] =3D FIELD_DP64(host->CSR_DMW[n], CSR_DMW, PLV=
3, 0);
> >       }
> > +    if (FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ)) {
> > +         host->CSR_GSTAT =3D FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, GI=
DBIT, 8);
> > +    }
> > +    set_sys_state(env, &env->sys_states[LOONGARCH_VM_LEVEL_HOST]);
> >  =20
> >   #ifndef CONFIG_USER_ONLY
> >       env->pc =3D 0x1c000000;
> > -#ifdef CONFIG_TCG
> > -    memset(env->tlb, 0, sizeof(env->tlb));
> > +#if defined(CONFIG_TCG)
> > +    memset(host->tlb, 0, sizeof(host->tlb));
> >   #endif
> >       if (kvm_enabled()) {
> >           kvm_arch_reset_vcpu(cs);
> > @@ -739,6 +880,8 @@ static void loongarch_cpu_init(Object *obj)
> >   #ifdef CONFIG_TCG
> >       timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
> >                     &loongarch_constant_timer_cb, cpu);
> > +    timer_init_ns(&cpu->guest_timer, QEMU_CLOCK_VIRTUAL,
> > +                  &loongarch_constant_timer_cb_guest, cpu);
> >   #endif
> >   #endif
> >   }
> > diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> > index e01dbed40f..8a06ab9868 100644
> > --- a/target/loongarch/internals.h
> > +++ b/target/loongarch/internals.h
> > @@ -32,14 +32,18 @@ void restore_fp_status(CPULoongArchState *env);
> >   extern const VMStateDescription vmstate_loongarch_cpu;
> >  =20
> >   void loongarch_cpu_set_irq(void *opaque, int irq, int level);
> > +void loongarch_cpu_set_irq_guest(void *opaque, int irq, int level);
> >  =20
> >   void loongarch_constant_timer_cb(void *opaque);
> > +void loongarch_constant_timer_cb_guest(void *opaque);
> >   uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
> > -uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
> > +uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, boo=
l guest);
> > +void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on);
> >   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
> > -                                               uint64_t value);
> > +                                               uint64_t value, bool gu=
est);
> >   bool loongarch_cpu_has_work(CPUState *cs);
> >   bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
> > +bool loongarch_guest_has_interrupt(CPULoongArchState *env);
> >   #endif /* !CONFIG_USER_ONLY */
> >  =20
> >   uint64_t read_fcc(CPULoongArchState *env);
> > diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> > index 931a5ca5ba..f10101d501 100644
> > --- a/target/loongarch/machine.c
> > +++ b/target/loongarch/machine.c
> > @@ -7,6 +7,7 @@
> >  =20
> >   #include "qemu/osdep.h"
> >   #include "cpu.h"
> > +#include "internals.h"
> >   #include "migration/vmstate.h"
> >   #include "system/tcg.h"
> >   #include "vec.h"
> > @@ -200,18 +201,139 @@ static const VMStateDescription vmstate_tlb =3D {
> >       .minimum_version_id =3D 0,
> >       .needed =3D tlb_needed,
> >       .fields =3D (const VMStateField[]) {
> > -        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
> > +        VMSTATE_STRUCT_ARRAY(env.sys_states[0].tlb, LoongArchCPU,
> > +                             LOONGARCH_TLB_MAX,
> >                                0, vmstate_tlb_entry, LoongArchTLB),
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };
> > +
> > +static const VMStateDescription vmstate_lvz_sys =3D {
> > +    .name =3D "cpu/lvz-sys",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINT64(CSR_CRMD, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PRMD, CPUSysState),
> > +        VMSTATE_UINT64(CSR_EUEN, CPUSysState),
> > +        VMSTATE_UINT64(CSR_MISC, CPUSysState),
> > +        VMSTATE_UINT64(CSR_ECFG, CPUSysState),
> > +        VMSTATE_UINT64(CSR_ESTAT, CPUSysState),
> > +        VMSTATE_UINT64(CSR_ERA, CPUSysState),
> > +        VMSTATE_UINT64(CSR_BADV, CPUSysState),
> > +        VMSTATE_UINT64(CSR_BADI, CPUSysState),
> > +        VMSTATE_UINT64(CSR_EENTRY, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBIDX, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBEHI, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBELO0, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBELO1, CPUSysState),
> > +        VMSTATE_UINT64(CSR_ASID, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PGDL, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PGDH, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PGD, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PWCL, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PWCH, CPUSysState),
> > +        VMSTATE_UINT64(CSR_STLBPS, CPUSysState),
> > +        VMSTATE_UINT64(CSR_RVACFG, CPUSysState),
> > +        VMSTATE_UINT64(CSR_CPUID, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PRCFG1, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PRCFG2, CPUSysState),
> > +        VMSTATE_UINT64(CSR_PRCFG3, CPUSysState),
> > +        VMSTATE_UINT64_ARRAY(CSR_SAVE, CPUSysState, 16),
> > +        VMSTATE_UINT64(CSR_TID, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TCFG, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TVAL, CPUSysState),
> > +        VMSTATE_UINT64(CSR_CNTC, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TICLR, CPUSysState),
> > +        VMSTATE_UINT64(CSR_LLBCTL, CPUSysState),
> > +        VMSTATE_UINT64(CSR_IMPCTL1, CPUSysState),
> > +        VMSTATE_UINT64(CSR_IMPCTL2, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBRENTRY, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBRBADV, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBRERA, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBRSAVE, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBRELO0, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBRELO1, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBREHI, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TLBRPRMD, CPUSysState),
> > +        VMSTATE_UINT64(CSR_MERRCTL, CPUSysState),
> > +        VMSTATE_UINT64(CSR_MERRINFO1, CPUSysState),
> > +        VMSTATE_UINT64(CSR_MERRINFO2, CPUSysState),
> > +        VMSTATE_UINT64(CSR_MERRENTRY, CPUSysState),
> > +        VMSTATE_UINT64(CSR_MERRERA, CPUSysState),
> > +        VMSTATE_UINT64(CSR_MERRSAVE, CPUSysState),
> > +        VMSTATE_UINT64(CSR_CTAG, CPUSysState),
> > +        VMSTATE_UINT64_ARRAY(CSR_DMW, CPUSysState, 4),
> > +        VMSTATE_UINT64(CSR_DBG, CPUSysState),
> > +        VMSTATE_UINT64(CSR_DERA, CPUSysState),
> > +        VMSTATE_UINT64(CSR_DSAVE, CPUSysState),
> > +        VMSTATE_UINT64(CSR_GSTAT, CPUSysState),
> > +        VMSTATE_UINT64(CSR_GCFG, CPUSysState),
> > +        VMSTATE_UINT64(CSR_GINTC, CPUSysState),
> > +        VMSTATE_UINT64(CSR_GCNTC, CPUSysState),
> > +        VMSTATE_UINT64(CSR_GTLBC, CPUSysState),
> > +        VMSTATE_UINT64(CSR_TRGP, CPUSysState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static bool lvz_needed(void *opaque)
> > +{
> > +    LoongArchCPU *cpu =3D opaque;
> > +
> > +    return FIELD_EX64(cpu->env.cpucfg[2], CPUCFG2, LVZ);
> > +}
> > +
> > +static const VMStateDescription vmstate_lvz =3D {
> > +    .name =3D "cpu/lvz",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D lvz_needed,
> > +    .fields =3D (const VMStateField[]) {
> > +        VMSTATE_UINT64(env.sys_states[0].CSR_GSTAT, LoongArchCPU),
> > +        VMSTATE_UINT64(env.sys_states[0].CSR_GCFG, LoongArchCPU),
> > +        VMSTATE_UINT64(env.sys_states[0].CSR_GINTC, LoongArchCPU),
> > +        VMSTATE_UINT64(env.sys_states[0].CSR_GCNTC, LoongArchCPU),
> > +        VMSTATE_UINT64(env.sys_states[0].CSR_GTLBC, LoongArchCPU),
> > +        VMSTATE_UINT64(env.sys_states[0].CSR_TRGP, LoongArchCPU),
> > +        VMSTATE_STRUCT(env.sys_states[1], LoongArchCPU, 0,
> > +                       vmstate_lvz_sys, CPUSysState),
> > +        VMSTATE_STRUCT_ARRAY(env.sys_states[1].tlb, LoongArchCPU,
> > +                             LOONGARCH_TLB_MAX,
> > +                             0, vmstate_tlb_entry, LoongArchTLB),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +#endif
> > +
> > +static int loongarch_cpu_post_load(void *opaque, int version_id)
> > +{
> > +    LoongArchCPU *cpu =3D opaque;
> > +    CPULoongArchState *env =3D &cpu->env;
> > +    bool guest =3D FIELD_EX64(env->sys_states[LOONGARCH_VM_LEVEL_HOST]=
=2ECSR_GSTAT,
> > +                            CSR_GSTAT, VM);
> > +
> > +    set_sys_state(env, &env->sys_states[guest ? LOONGARCH_VM_LEVEL_GUE=
ST :
> > +                                                LOONGARCH_VM_LEVEL_HOS=
T]);
> > +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> > +    if (guest) {
> > +        cpu_loongarch_set_guest_timer(cpu, true);
> > +    }
> > +    if (guest && loongarch_guest_has_interrupt(env)) {
> > +        cpu_interrupt(CPU(cpu), CPU_INTERRUPT_GUEST);
> > +    } else {
> > +        cpu_reset_interrupt(CPU(cpu), CPU_INTERRUPT_GUEST);
> > +    }
> >   #endif
> > +    return 0;
> > +}
> >  =20
> >   /* LoongArch CPU state */
> >   const VMStateDescription vmstate_loongarch_cpu =3D {
> >       .name =3D "cpu",
> >       .version_id =3D 4,
> >       .minimum_version_id =3D 4,
> > +    .post_load =3D loongarch_cpu_post_load,
> >       .fields =3D (const VMStateField[]) {
> >           VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
> >           VMSTATE_UINT64(env.pc, LoongArchCPU),
> > @@ -285,6 +407,7 @@ const VMStateDescription vmstate_loongarch_cpu =3D {
> >           &vmstate_lasx,
> >   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> >           &vmstate_tlb,
> > +        &vmstate_lvz,
> >   #endif
> >           &vmstate_lbt,
> >           &vmstate_msgint,
> > diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/t=
cg/constant_timer.c
> > index f56e76d482..4d7d4bccbc 100644
> > --- a/target/loongarch/tcg/constant_timer.c
> > +++ b/target/loongarch/tcg/constant_timer.c
> > @@ -20,30 +20,64 @@ uint64_t cpu_loongarch_get_constant_timer_counter(L=
oongArchCPU *cpu)
> >       return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD;
> >   }
> >  =20
> > -uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
> > +uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, boo=
l guest)
> >   {
> > +    CPULoongArchState *env =3D &cpu->env;
> >       uint64_t now, expire;
> > +    CPUSysState *sys =3D sys_state_if(env, guest);
> > +
> > +    if (guest && env_vm_level(env) !=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        return sys->CSR_TVAL;
> > +    }
> >  =20
> >       now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > -    expire =3D timer_expire_time_ns(&cpu->timer);
> > +    expire =3D timer_expire_time_ns(guest ? &cpu->guest_timer : &cpu->=
timer);
> >  =20
> >       return (expire - now) / TIMER_PERIOD;
> >   }
> >  =20
> >   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
> > -                                               uint64_t value)
> > +                                               uint64_t value, bool gu=
est)
> >   {
> >       CPULoongArchState *env =3D &cpu->env;
> > -    CPUSysState *sys =3D env_sys(env);
> >       uint64_t now, next;
> > +    CPUSysState *sys =3D sys_state_if(env, guest);
> > +    QEMUTimer *timer =3D guest ? &cpu->guest_timer : &cpu->timer;
> >  =20
> >       sys->CSR_TCFG =3D value;
> > +    if (guest && env_vm_level(env) !=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        return;
> > +    }
> > +
> >       if (value & CONSTANT_TIMER_ENABLE) {
> >           now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> >           next =3D now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PER=
IOD;
> > -        timer_mod(&cpu->timer, next);
> > +        timer_mod(timer, next);
> > +    } else {
> > +        timer_del(timer);
> > +    }
> > +}
> > +
> > +void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on)
> > +{
> > +    CPULoongArchState *env =3D &cpu->env;
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +    uint64_t now, next, ticks;
> > +
> > +    if (!(guest->CSR_TCFG & CONSTANT_TIMER_ENABLE)) {
> > +        return;
> > +    }
> > +
> > +    if (on) {
> > +        now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +        ticks =3D guest->CSR_TVAL ? guest->CSR_TVAL :
> > +                                  (guest->CSR_TCFG & CONSTANT_TIMER_TI=
CK_MASK);
> > +        guest->CSR_TVAL =3D 0;
> > +        next =3D now + ticks * TIMER_PERIOD;
> > +        timer_mod(&cpu->guest_timer, next);
> >       } else {
> > -        timer_del(&cpu->timer);
> > +        guest->CSR_TVAL =3D cpu_loongarch_get_constant_timer_ticks(cpu=
, true);
> > +        timer_del(&cpu->guest_timer);
> >       }
> >   }
> >  =20
> > @@ -51,16 +85,36 @@ void loongarch_constant_timer_cb(void *opaque)
> >   {
> >       LoongArchCPU *cpu  =3D opaque;
> >       CPULoongArchState *env =3D &cpu->env;
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >       uint64_t now, next;
> >  =20
> > -    if (FIELD_EX64(sys->CSR_TCFG, CSR_TCFG, PERIODIC)) {
> > +    if (FIELD_EX64(host->CSR_TCFG, CSR_TCFG, PERIODIC)) {
> >           now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > -        next =3D now + (sys->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TI=
MER_PERIOD;
> > +        next =3D now + (host->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) *
> > +                     TIMER_PERIOD;
> >           timer_mod(&cpu->timer, next);
> >       } else {
> > -        sys->CSR_TCFG =3D FIELD_DP64(sys->CSR_TCFG, CSR_TCFG, EN, 0);
> > +        host->CSR_TCFG =3D FIELD_DP64(host->CSR_TCFG, CSR_TCFG, EN, 0);
> >       }
> >  =20
> >       loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
> >   }
> > +
> > +void loongarch_constant_timer_cb_guest(void *opaque)
> > +{
> > +    LoongArchCPU *cpu =3D opaque;
> > +    CPULoongArchState *env =3D &cpu->env;
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +    uint64_t now, next;
> > +
> > +    if (FIELD_EX64(guest->CSR_TCFG, CSR_TCFG, PERIODIC)) {
> > +        now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +        next =3D now + (guest->CSR_TCFG & CONSTANT_TIMER_TICK_MASK) *
> > +                     TIMER_PERIOD;
> > +        timer_mod(&cpu->guest_timer, next);
> > +    } else {
> > +        guest->CSR_TCFG =3D FIELD_DP64(guest->CSR_TCFG, CSR_TCFG, EN, =
0);
> > +    }
> > +
> > +    loongarch_cpu_set_irq_guest(opaque, IRQ_TIMER, 1);
> > +}
> > diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/c=
sr_helper.c
> > index 7dc33bc180..9ddb43222a 100644
> > --- a/target/loongarch/tcg/csr_helper.c
> > +++ b/target/loongarch/tcg/csr_helper.c
> > @@ -60,6 +60,26 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
> >       return v;
> >   }
> >  =20
> > +target_ulong helper_gcsrrd_pgd(CPULoongArchState *env)
> > +{
> > +    int64_t v;
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +
> > +    if (guest->CSR_TLBRERA & 0x1) {
> > +        v =3D guest->CSR_TLBRBADV;
> > +    } else {
> > +        v =3D guest->CSR_BADV;
> > +    }
> > +
> > +    if ((v >> 63) & 0x1) {
> > +        v =3D guest->CSR_PGDH;
> > +    } else {
> > +        v =3D guest->CSR_PGDL;
> > +    }
> > +
> > +    return v;
> > +}
> > +
> >   target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
> >   {
> >       LoongArchCPU *lac =3D env_archcpu(env);
> > @@ -74,7 +94,14 @@ target_ulong helper_csrrd_tval(CPULoongArchState *en=
v)
> >   {
> >       LoongArchCPU *cpu =3D env_archcpu(env);
> >  =20
> > -    return cpu_loongarch_get_constant_timer_ticks(cpu);
> > +    return cpu_loongarch_get_constant_timer_ticks(cpu, false);
> > +}
> > +
> > +target_ulong helper_gcsrrd_tval(CPULoongArchState *env)
> > +{
> > +    LoongArchCPU *cpu =3D env_archcpu(env);
> > +
> > +    return cpu_loongarch_get_constant_timer_ticks(cpu, true);
> >   }
> >  =20
> >   target_ulong helper_csrrd_msgir(CPULoongArchState *env)
> > @@ -110,6 +137,29 @@ target_ulong helper_csrwr_estat(CPULoongArchState =
*env, target_ulong val)
> >       return old_v;
> >   }
> >  =20
> > +target_ulong helper_gcsrwr_estat(CPULoongArchState *env, target_ulong =
val)
> > +{
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +    int64_t old_v =3D guest->CSR_ESTAT;
> > +
> > +    guest->CSR_ESTAT =3D deposit64(guest->CSR_ESTAT, 0, 2, val);
> > +    if (env_vm_level(env) !=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        guest->CSR_ESTAT =3D deposit64(guest->CSR_ESTAT, 2, 11,
> > +                                     extract64(val, 2, 11));
> > +        if (extract64(val, 2, 8) &
> > +            FIELD_EX64(host->CSR_GINTC, CSR_GINTC, HWIC)) {
> > +            host->CSR_ESTAT =3D deposit64(host->CSR_ESTAT, 2, 8,
> > +                                        extract64(host->CSR_ESTAT, 2, =
8) &
> > +                                        ~extract64(val, 2, 8));
> > +        }
> > +        guest->CSR_ESTAT =3D deposit64(guest->CSR_ESTAT, 16, 15,
> > +                                     extract64(val, 16, 15));
> > +    }
> > +
> > +    return old_v;
> > +}
> > +
> >   target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong v=
al)
> >   {
> >       CPUSysState *sys =3D env_sys(env);
> > @@ -123,13 +173,36 @@ target_ulong helper_csrwr_asid(CPULoongArchState =
*env, target_ulong val)
> >       return old_v;
> >   }
> >  =20
> > +target_ulong helper_gcsrwr_asid(CPULoongArchState *env, target_ulong v=
al)
> > +{
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +    int64_t old_v =3D guest->CSR_ASID;
> > +
> > +    guest->CSR_ASID =3D deposit64(guest->CSR_ASID, 0, 10, val);
> > +    if (old_v !=3D guest->CSR_ASID) {
> > +        tlb_flush(env_cpu(env));
> > +    }
> > +    return old_v;
> > +}
> > +
> >   target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong v=
al)
> >   {
> >       LoongArchCPU *cpu =3D env_archcpu(env);
> >       CPUSysState *sys =3D env_sys(env);
> >       int64_t old_v =3D sys->CSR_TCFG;
> >  =20
> > -    cpu_loongarch_store_constant_timer_config(cpu, val);
> > +    cpu_loongarch_store_constant_timer_config(cpu, val, false);
> > +
> > +    return old_v;
> > +}
> > +
> > +target_ulong helper_gcsrwr_tcfg(CPULoongArchState *env, target_ulong v=
al)
> > +{
> > +    LoongArchCPU *cpu =3D env_archcpu(env);
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +    int64_t old_v =3D guest->CSR_TCFG;
> > +
> > +    cpu_loongarch_store_constant_timer_config(cpu, val, true);
> >  =20
> >       return old_v;
> >   }
> > @@ -147,6 +220,65 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState =
*env, target_ulong val)
> >       return old_v;
> >   }
> >  =20
> > +target_ulong helper_gcsrwr_ticlr(CPULoongArchState *env, target_ulong =
val)
> > +{
> > +    LoongArchCPU *cpu =3D env_archcpu(env);
> > +    int64_t old_v =3D 0;
> > +
> > +    if (val & 0x1) {
> > +        bql_lock();
> > +        loongarch_cpu_set_irq_guest(cpu, IRQ_TIMER, 0);
> > +        bql_unlock();
> > +    }
> > +    return old_v;
> > +}
> > +
> > +target_ulong helper_csrwr_gstat(CPULoongArchState *env, target_ulong v=
al)
> > +{
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> > +    int64_t old_v =3D host->CSR_GSTAT;
> > +    uint8_t old_gid =3D FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, GID);
> > +
> > +    host->CSR_GSTAT =3D FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, PVM,
> > +                                 FIELD_EX64(val, CSR_GSTAT, PVM));
> > +    host->CSR_GSTAT =3D FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, GID,
> > +                                 FIELD_EX64(val, CSR_GSTAT, GID));
> > +
> > +    if (old_gid !=3D FIELD_EX64(host->CSR_GSTAT, CSR_GSTAT, GID)) {
> > +        tlb_flush(env_cpu(env));
> > +    }
> > +
> > +    return old_v;
> > +}
> > +
> > +target_ulong helper_csrwr_gtlbc(CPULoongArchState *env, target_ulong v=
al)
> > +{
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> > +    int64_t old_v =3D host->CSR_GTLBC;
> > +    uint8_t old_use_tgid =3D FIELD_EX64(old_v, CSR_GTLBC, USETGID);
> > +    uint8_t old_tgid =3D FIELD_EX64(old_v, CSR_GTLBC, TGID);
> > +
> > +    host->CSR_GTLBC =3D val;
> > +    if (old_use_tgid !=3D FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETG=
ID) ||
> > +        old_tgid !=3D FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID)) {
> > +        tlb_flush(env_cpu(env));
> > +    }
> > +
> > +    return old_v;
> > +}
> > +
> > +target_ulong helper_csrwr_gintc(CPULoongArchState *env, target_ulong v=
al)
> > +{
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> > +    CPUSysState *guest =3D &env->sys_states[LOONGARCH_VM_LEVEL_GUEST];
> > +    int64_t old_v =3D host->CSR_GINTC;
> > +
> > +    host->CSR_GINTC =3D val & 0xffff00;
> > +    guest->CSR_ESTAT =3D deposit64(guest->CSR_ESTAT, 2, 8, extract64(v=
al, 0, 8));
> > +
> > +    return old_v;
> > +}
> > +
> >   target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong v=
al)
> >   {
> >       uint8_t shift, ptbase;
> > diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helpe=
r.h
> > index 8a6c62f116..69f6cb352a 100644
> > --- a/target/loongarch/tcg/helper.h
> > +++ b/target/loongarch/tcg/helper.h
> > @@ -14,7 +14,7 @@ DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, en=
v, tl, tl)
> >  =20
> >   DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
> >   DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
> > -DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
> > +DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_WG_SE, tl, env, tl)
> >  =20
> >   /* Floating-point helper */
> >   DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_WG, i64, env, i64, i64)
> > @@ -98,14 +98,23 @@ DEF_HELPER_1(rdtime_d, i64, env)
> >   #ifndef CONFIG_USER_ONLY
> >   /* CSRs helper */
> >   DEF_HELPER_1(csrrd_pgd, i64, env)
> > +DEF_HELPER_1(gcsrrd_pgd, i64, env)
> >   DEF_HELPER_1(csrrd_cpuid, i64, env)
> >   DEF_HELPER_1(csrrd_tval, i64, env)
> > +DEF_HELPER_1(gcsrrd_tval, i64, env)
> >   DEF_HELPER_1(csrrd_msgir, i64, env)
> >   DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
> >   DEF_HELPER_2(csrwr_estat, i64, env, tl)
> > +DEF_HELPER_2(gcsrwr_estat, i64, env, tl)
> >   DEF_HELPER_2(csrwr_asid, i64, env, tl)
> > +DEF_HELPER_2(gcsrwr_asid, i64, env, tl)
> >   DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
> > +DEF_HELPER_2(gcsrwr_tcfg, i64, env, tl)
> >   DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
> > +DEF_HELPER_2(gcsrwr_ticlr, i64, env, tl)
> > +DEF_HELPER_2(csrwr_gstat, i64, env, tl)
> > +DEF_HELPER_2(csrwr_gtlbc, i64, env, tl)
> > +DEF_HELPER_2(csrwr_gintc, i64, env, tl)
> >   DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
> >   DEF_HELPER_2(csrwr_pwch, i64, env, tl)
> >   DEF_HELPER_2(iocsrrd_b, i64, env, tl)
> > @@ -134,6 +143,8 @@ DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
> >   DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
> >   DEF_HELPER_1(ertn, void, env)
> >   DEF_HELPER_1(idle, void, env)
> > +DEF_HELPER_2(hvcl, void, env, i32)
> > +DEF_HELPER_1(gspr, void, env)
> >   #endif
> >  =20
> >   /* LoongArch LSX  */
> > diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op=
_helper.c
> > index e63ac66daa..2829929738 100644
> > --- a/target/loongarch/tcg/op_helper.c
> > +++ b/target/loongarch/tcg/op_helper.c
> > @@ -12,6 +12,7 @@
> >   #include "exec/helper-proto.h"
> >   #include "accel/tcg/cpu-ldst.h"
> >   #include "internals.h"
> > +#include "qemu/main-loop.h"
> >   #include "qemu/crc32c.h"
> >   #include <zlib.h> /* for crc32 */
> >   #include "cpu-csr.h"
> > @@ -46,20 +47,20 @@ target_ulong helper_bitswap(target_ulong v)
> >   /* loongarch assert op */
> >   void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_=
ulong rk)
> >   {
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >  =20
> >       if (rj > rk) {
> > -        sys->CSR_BADV =3D rj;
> > +        host->CSR_BADV =3D rj;
> >           do_raise_exception(env, EXCCODE_BCE, GETPC());
> >       }
> >   }
> is this specail for host? or can VM trigger this expcetion?
>=20
> >  =20
> >   void helper_asrtgt_d(CPULoongArchState *env, target_ulong rj, target_=
ulong rk)
> >   {
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >  =20
> >       if (rj <=3D rk) {
> > -        sys->CSR_BADV =3D rj;
> > +        host->CSR_BADV =3D rj;
> >           do_raise_exception(env, EXCCODE_BCE, GETPC());
> >       }
> >   }
> Ditto, is this specail for host? or can VM trigger this expcetion?
>=20
> > @@ -85,6 +86,10 @@ target_ulong helper_crc32c(target_ulong val, target_=
ulong m, uint64_t sz)
> >  =20
> >   target_ulong helper_cpucfg(CPULoongArchState *env, target_ulong rj)
> >   {
> > +    if (env_vm_level(env) =3D=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        trigger_vm_exit(env);
> > +        do_raise_exception(env, EXCCODE_GSPR, GETPC());
> > +    }
> >       return rj >=3D ARRAY_SIZE(env->cpucfg) ? 0 : env->cpucfg[rj];
> >   }
> >  =20
> > @@ -111,6 +116,7 @@ void helper_ertn(CPULoongArchState *env)
> >   {
> >       uint64_t csr_pplv, csr_pie;
> >       CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >  =20
> >       if (FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
> >           csr_pplv =3D FIELD_EX64(sys->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV=
);
> > @@ -134,6 +140,18 @@ void helper_ertn(CPULoongArchState *env)
> >       sys->CSR_CRMD =3D FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, IE, csr_pie=
);
> >  =20
> >       env->lladdr =3D 1;
> > +    if (will_return_to_guest(env)) {
> > +        host->CSR_GSTAT =3D FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM,=
 1);
> > +        set_sys_state(env, &env->sys_states[LOONGARCH_VM_LEVEL_GUEST]);
> > +        cpu_loongarch_set_guest_timer(env_archcpu(env), true);
> > +        bql_lock();
> > +        if (loongarch_guest_has_interrupt(env)) {
> > +            cpu_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
> > +        } else {
> > +            cpu_reset_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
> > +        }
> > +        bql_unlock();
> > +    }
> >   }
> >  =20
> >   void helper_idle(CPULoongArchState *env)
> > @@ -143,4 +161,23 @@ void helper_idle(CPULoongArchState *env)
> >       cs->halted =3D 1;
> >       do_raise_exception(env, EXCP_HLT, 0);
> >   }
> > +
> > +void helper_hvcl(CPULoongArchState *env, uint32_t code)
> > +{
> > +    (void)code;
> > +
> > +    if (env_vm_level(env) !=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        do_raise_exception(env, EXCCODE_INE, GETPC());
> > +        return;
> > +    }
> > +
> > +    trigger_vm_exit(env);
> > +    do_raise_exception(env, EXCCODE_HVC, GETPC());
> I remember that hypercall instruction can only happen in VM mode with=20
> PLV =3D=3D 0, there should be exception even in VM mode with user mode PL=
V =3D=3D 3.
>=20
> > +}
> > +
> > +void helper_gspr(CPULoongArchState *env)
> > +{
> > +    trigger_vm_exit(env);
> > +    do_raise_exception(env, EXCCODE_GSPR, GETPC());
> > +}
> It is strange that there is helper_gspr(), gspr is not a instruction and=
=20
> it is a exception cause special for VM.
>=20
> Can we call do_raise_exception(env, EXCCODE_GSPR, GETPC()) directy?
>=20
> Regards
> Bibo Mao
> >   #endif
> > diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_=
cpu.c
> > index 4b1d44a164..594daa74b2 100644
> > --- a/target/loongarch/tcg/tcg_cpu.c
> > +++ b/target/loongarch/tcg/tcg_cpu.c
> > @@ -44,6 +44,10 @@ static const struct TypeExcp excp_names[] =3D {
> >       {EXCCODE_BCE, "Bound Check Exception"},
> >       {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
> >       {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
> > +    {EXCCODE_GSPR, "Guest Sensitive and Privileged Resources"},
> > +    {EXCCODE_HVC, "Hypervisor call"},
> > +    {EXCCODE_GCSC, "Guest CSR visited by Software"},
> > +    {EXCCODE_GCHC, "Guest CSR visited by Hardware"},
> >       {EXCP_HLT, "EXCP_HLT"},
> >   };
> >  =20
> > @@ -78,9 +82,11 @@ void G_NORETURN do_raise_exception(CPULoongArchState=
 *env,
> >   static void loongarch_cpu_do_interrupt(CPUState *cs)
> >   {
> >       CPULoongArchState *env =3D cpu_env(cs);
> > -    CPUSysState *sys =3D env_sys(env);
> >       bool update_badinstr =3D 1;
> >       int cause =3D -1;
> > +    bool real_guest =3D !env->vm_exit && env_vm_level(env);
> > +    CPUSysState *sys =3D &env->sys_states[real_guest];
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >       bool tlbfill =3D FIELD_EX64(sys->CSR_TLBRERA, CSR_TLBRERA, ISTLBR=
);
> >       uint32_t vec_size =3D FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, VS);
> >       uint64_t last_pc =3D env->pc;
> > @@ -96,17 +102,17 @@ static void loongarch_cpu_do_interrupt(CPUState *c=
s)
> >  =20
> >       switch (cs->exception_index) {
> >       case EXCCODE_DBP:
> > -        sys->CSR_DBG =3D FIELD_DP64(sys->CSR_DBG, CSR_DBG, DCL, 1);
> > -        sys->CSR_DBG =3D FIELD_DP64(sys->CSR_DBG, CSR_DBG, ECODE, 0xC);
> > +        host->CSR_DBG =3D FIELD_DP64(host->CSR_DBG, CSR_DBG, DCL, 1);
> > +        host->CSR_DBG =3D FIELD_DP64(host->CSR_DBG, CSR_DBG, ECODE, 0x=
C);
> >           goto set_DERA;
> >       set_DERA:
> > -        sys->CSR_DERA =3D env->pc;
> > -        sys->CSR_DBG =3D FIELD_DP64(sys->CSR_DBG, CSR_DBG, DST, 1);
> > -        set_pc(env, sys->CSR_EENTRY + 0x480);
> > +        host->CSR_DERA =3D env->pc;
> > +        host->CSR_DBG =3D FIELD_DP64(host->CSR_DBG, CSR_DBG, DST, 1);
> > +        set_pc(env, host->CSR_EENTRY + 0x480);
> >           break;
> >       case EXCCODE_INT:
> > -        if (FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)) {
> > -            sys->CSR_DBG =3D FIELD_DP64(sys->CSR_DBG, CSR_DBG, DEI, 1);
> > +        if (FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)) {
> > +            host->CSR_DBG =3D FIELD_DP64(host->CSR_DBG, CSR_DBG, DEI, =
1);
> >               goto set_DERA;
> >           }
> >           QEMU_FALLTHROUGH;
> > @@ -117,6 +123,10 @@ static void loongarch_cpu_do_interrupt(CPUState *c=
s)
> >           update_badinstr =3D 0;
> >           break;
> >       case EXCCODE_BCE:
> > +    case EXCCODE_GSPR:
> > +    case EXCCODE_GCHC:
> > +    case EXCCODE_GCSC:
> > +    case EXCCODE_HVC:
> >           sys->CSR_BADV =3D env->pc;
> >           QEMU_FALLTHROUGH;
> >       case EXCCODE_SYS:
> > @@ -218,6 +228,12 @@ static void loongarch_cpu_do_interrupt(CPUState *c=
s)
> >           qemu_plugin_vcpu_exception_cb(cs, last_pc);
> >       }
> >       cs->exception_index =3D -1;
> > +    if (env->vm_exit) {
> > +        host->CSR_GSTAT =3D FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, VM,=
 0);
> > +        set_sys_state(env, &env->sys_states[LOONGARCH_VM_LEVEL_HOST]);
> > +        cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
> > +    }
> > +    env->vm_exit =3D false;
> >   }
> >  =20
> >   static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr =
physaddr,
> > @@ -228,9 +244,9 @@ static void loongarch_cpu_do_transaction_failed(CPU=
State *cs, hwaddr physaddr,
> >                                                   uintptr_t retaddr)
> >   {
> >       CPULoongArchState *env =3D cpu_env(cs);
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >  =20
> > -    sys->CSR_BADV =3D addr;
> > +    host->CSR_BADV =3D addr;
> >       if (access_type =3D=3D MMU_INST_FETCH) {
> >           do_raise_exception(env, EXCCODE_ADEF, retaddr);
> >       } else {
> > @@ -241,26 +257,35 @@ static void loongarch_cpu_do_transaction_failed(C=
PUState *cs, hwaddr physaddr,
> >   static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchSt=
ate *env)
> >   {
> >       bool ret =3D 0;
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D &env->sys_states[LOONGARCH_VM_LEVEL_HOST];
> >  =20
> > -    ret =3D (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
> > -          !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
> > +    ret =3D (FIELD_EX64(host->CSR_CRMD, CSR_CRMD, IE) &&
> > +          !(FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)));
> >  =20
> >       return ret;
> >   }
> >  =20
> >   static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_=
request)
> >   {
> > -    if (interrupt_request & CPU_INTERRUPT_HARD) {
> > -        CPULoongArchState *env =3D cpu_env(cs);
> > +    CPULoongArchState *env =3D cpu_env(cs);
> >  =20
> > +    if (interrupt_request & CPU_INTERRUPT_HARD) {
> >           if (cpu_loongarch_hw_interrupts_enabled(env) &&
> >               cpu_loongarch_hw_interrupts_pending(env)) {
> > +            if (env_vm_level(env) =3D=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +                trigger_vm_exit(env);
> > +            }
> >               /* Raise it */
> >               cs->exception_index =3D EXCCODE_INT;
> >               loongarch_cpu_do_interrupt(cs);
> >               return true;
> >           }
> > +    } else if (interrupt_request & CPU_INTERRUPT_GUEST) {
> > +        if (loongarch_guest_has_interrupt(env)) {
> > +            cs->exception_index =3D EXCCODE_INT;
> > +            loongarch_cpu_do_interrupt(cs);
> > +            return true;
> > +        }
> >       }
> >       return false;
> >   }
> > @@ -279,6 +304,9 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPU=
State *cs)
> >       uint32_t flags;
> >  =20
> >       flags =3D sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MA=
SK);
> > +    if (env_vm_level(env) =3D=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        flags |=3D HW_FLAGS_GUEST_MODE;
> > +    }
> >       flags |=3D FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EU=
EN_FPE;
> >       flags |=3D FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EU=
EN_SXE;
> >       flags |=3D FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_E=
UEN_ASXE;
> > @@ -306,6 +334,13 @@ static int loongarch_cpu_mmu_index(CPUState *cs, b=
ool ifetch)
> >       CPULoongArchState *env =3D cpu_env(cs);
> >       CPUSysState *sys =3D env_sys(env);
> >  =20
> > +    if (env_vm_level(env) =3D=3D LOONGARCH_VM_LEVEL_GUEST) {
> > +        if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
> > +            return MMU_GUEST_IDX + FIELD_EX64(sys->CSR_CRMD, CSR_CRMD,=
 PLV);
> > +        }
> > +        return MMU_GUEST_DA_IDX;
> > +    }
> > +
> >       if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
> >           return FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
> >       }
> >=20
>=20
>=20





