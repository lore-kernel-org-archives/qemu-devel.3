Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF029C982F2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 04:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8VWb-00049M-Dg; Mon, 21 Sep 2026 00:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1x8VWZ-00049E-Ei
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 00:21:03 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1x8VWW-0003zB-Pb
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 00:21:02 -0400
Received: from yuno-loong.localnet (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 9D6E4DFC6;
 Mon, 21 Sep 2026 09:50:57 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>
Subject: Re: [PATCH RESEND] target/loongarch: add get_sys() helper
Date: Mon, 21 Sep 2026 12:20:55 +0800
Message-ID: <u3zKTxIUQm662wDx7NaOSA@krgm.moe>
In-Reply-To: <e3adaec7-48f3-2a3c-5270-e2a0a2dd3ded@loongson.cn>
References: <20260920024305.18296-1-prcups@krgm.moe>
 <e3adaec7-48f3-2a3c-5270-e2a0a2dd3ded@loongson.cn>
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

On 2026=E5=B9=B49=E6=9C=8820=E6=97=A5=E6=98=9F=E6=9C=9F=E6=97=A5 =E4=B8=AD=
=E5=9B=BD=E6=A0=87=E5=87=86=E6=97=B6=E9=97=B4 11:40:37=EF=BC=8CBibo Mao wro=
te=EF=BC=9A
>=20
> On 2026/9/20 =E4=B8=8A=E5=8D=8810:43, SignKirigami wrote:
> > Add get_sys() to retrieve a CPUSysState by VM level. Use it to access
> > the host state in CPU initialization and reset paths, and name the
> > local pointer host to distinguish it from the currently selected state
> > returned by env_sys() or guest. There is no function change in this
> > patch.
> >=20
> > Signed-off-by: SignKirigami <prcups@krgm.moe>
> > ---
> > This patch is a resend of [1], Sorry for wrongly handling Signed-off-by.
> >  =20
> > [1]: https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg05969.html
> >=20
> >   target/loongarch/cpu.c | 45 +++++++++++++++++++++---------------------
> >   target/loongarch/cpu.h |  5 +++++
> >   2 files changed, 27 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> > index f22f64efb8..c71531c1cf 100644
> > --- a/target/loongarch/cpu.c
> > +++ b/target/loongarch/cpu.c
> > @@ -142,12 +142,12 @@ static void loongarch_la464_init_csr(DeviceState =
*dev)
> >       static bool initialized;
> >       LoongArchCPU *cpu =3D LOONGARCH_CPU(dev);
> >       CPULoongArchState *env =3D &cpu->env;
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D get_sys(env, VM_LEVEL0);
> Why env_sys() need be replaced with get_sys() in CPU init stage?
>=20
> Regards
> Bibo Mao
It needs to be distinguished from CPUSysState* which is gotten from
VM_LEVEL1, and from current vm_level after LVZ is imported.
Regards
SignKirigami
> >       int i, num;
> >  =20
> >       if (!initialized) {
> >           initialized =3D true;
> > -        num =3D FIELD_EX64(sys->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
> > +        num =3D FIELD_EX64(host->CSR_PRCFG1, CSR_PRCFG1, SAVE_NUM);
> >           for (i =3D num; i < 16; i++) {
> >               set_csr_flag(LOONGARCH_CSR_SAVE(i), CSRFL_UNUSED);
> >           }
> > @@ -300,7 +300,7 @@ static void loongarch_la464_initfn(Object *obj)
> >   {
> >       LoongArchCPU *cpu =3D LOONGARCH_CPU(obj);
> >       CPULoongArchState *env =3D &cpu->env;
> > -    CPUSysState *sys;
> > +    CPUSysState *host =3D get_sys(env, VM_LEVEL0);
> >       uint32_t data =3D 0, field;
> >       int i;
> >  =20
> > @@ -408,19 +408,18 @@ static void loongarch_la464_initfn(Object *obj)
> >       data =3D FIELD_DP32(data, CPUCFG20, L3IU_SIZE, 6);
> >       env->cpucfg[20] =3D data;
> >  =20
> > -    sys =3D env_sys(env);
> > -    sys->CSR_ASID =3D FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
> > +    host->CSR_ASID =3D FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
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
> > @@ -627,7 +626,7 @@ static void loongarch_cpu_reset_hold(Object *obj, R=
esetType type)
> >       CPUState *cs =3D CPU(obj);
> >       LoongArchCPUClass *lacc =3D LOONGARCH_CPU_GET_CLASS(obj);
> >       CPULoongArchState *env =3D cpu_env(cs);
> > -    CPUSysState *sys =3D env_sys(env);
> > +    CPUSysState *host =3D get_sys(env, VM_LEVEL0);
> >  =20
> >       if (lacc->parent_phases.hold) {
> >           lacc->parent_phases.hold(obj, type);
> > @@ -638,7 +637,7 @@ static void loongarch_cpu_reset_hold(Object *obj, R=
esetType type)
> >        * its value is equal to zero for boot cpu, it causes reboot issu=
e.
> >        */
> >       memset(env, 0, offsetof(CPULoongArchState, end_reset_fields));
> > -    memset(sys, 0, offsetof(CPUSysState, end_reset_fields));
> > +    memset(host, 0, offsetof(CPUSysState, end_reset_fields));
> >  =20
> >   #ifdef CONFIG_TCG
> >       env->fcsr0_mask =3D FCSR0_M1 | FCSR0_M2 | FCSR0_M3;
> > @@ -655,17 +654,17 @@ static void loongarch_cpu_reset_hold(Object *obj,=
 ResetType type)
> >       }
> >   #endif
> >  =20
> > -    sys->CSR_CRMD =3D FIELD_DP64(sys->CSR_CRMD, CSR_CRMD, DA, 1);
> > -    sys->CSR_CPUID =3D cs->cpu_index;
> > -    sys->CSR_TID =3D cs->cpu_index;
> > +    host->CSR_CRMD =3D FIELD_DP64(host->CSR_CRMD, CSR_CRMD, DA, 1);
> > +    host->CSR_CPUID =3D cs->cpu_index;
> > +    host->CSR_TID =3D cs->cpu_index;
> >  =20
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
> > +    tlb_ps =3D ctz32(host->CSR_PRCFG2);
> > +    host->CSR_STLBPS =3D FIELD_DP64(host->CSR_STLBPS, CSR_STLBPS, PS, =
tlb_ps);
> > +    host->CSR_PWCL =3D FIELD_DP64(host->CSR_PWCL, CSR_PWCL, PTBASE, tl=
b_ps);
> >  =20
> >   #ifndef CONFIG_USER_ONLY
> >       env->pc =3D 0x1c000000;
> > diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> > index c592f69885..477a5dee7d 100644
> > --- a/target/loongarch/cpu.h
> > +++ b/target/loongarch/cpu.h
> > @@ -512,6 +512,11 @@ static inline void set_sys_state(CPULoongArchState=
 *env, CPUSysState *sys)
> >       env->sys_state =3D sys;
> >   }
> >  =20
> > +static inline CPUSysState *get_sys(CPULoongArchState *env, int vm_leve=
l)
> > +{
> > +    return &env->sys_states[vm_level];
> > +}
> > +
> >   static inline CPUTimerState *env_timer(CPULoongArchState *env)
> >   {
> >       return &env->sys_states[0].timer_state;
> >=20
>=20
>=20





