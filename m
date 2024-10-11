Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006C9D0EE3F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 20:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szMS5-0002KI-Ma; Fri, 11 Oct 2024 16:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1szMS3-0002JX-RU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 16:41:32 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1szMS1-00024K-BS
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 16:41:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71e49ef3b2bso434073b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 13:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728679287; x=1729284087;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxj0Knne6+hTXBL6ihxyBgKQA/lLh6ykI711hYQZgr8=;
 b=kLYdBPoVv1LGBu+H1OAEdz0430id69HKPOQanrlhZabXDsMpJzI+mkFKxFidtF7Mch
 BVssgQfrM6la6vefnfQoDApzoRdadIOqWcZosm8B1Pnl7vpJmYHUddsy++yRxHxaXgft
 Kpq1z6SNbwUqKttOS7jR6sARnCtsayNrN8wO0u5V8+B0+CQC50TtH/MSNwr2F7NsA1gh
 uivi6ue7pDGLcZ7jnK2naLGjFzc3RGeAoELxPNzYHc3CpNTuWGF9cwNEFi9dsU7ciPts
 uQ/XW82o49+srCxROkk5e5WyHtkY2CyJaHn4K+gAyl68zl/GuieYrYlV62goXfzyb1B/
 kOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728679287; x=1729284087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cxj0Knne6+hTXBL6ihxyBgKQA/lLh6ykI711hYQZgr8=;
 b=J1ax/AeMuGdCXciy3/Kz7o2o/DCCFpHKWm75Ljr6hY6RR56ZGUigIjaiijI19Sx9a5
 kai6P+335AfJh/9t4uR15CXr5kcogvuhgd7fIhDKqLwncGVMqgqR/aQBOHl1CPfFs12v
 fLVrCqH9Qgqlszfgr0TCVXHzL4ljbYznCDpcCZIlmdCEzgL5O+bHlS4bYDKsPLuyknF+
 tZ2JLLEYQ+3in6wJZfuO8N2T5B21NDbIAaDcbiypvG224DNIiLWayue98YGtbWAA/fvq
 M5UlRe3o7aOsjB1nHwjBniFDK+xEddRIjyP7Zv31n7Ctzc6dUUt6AS29BX3BQq27EAme
 Bq3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhcCHlkcZeGsbfLax8sDpI7kE5NK+mvWhya1rT3paGXHxxGHep2f/boWXLbDZQG99+1MA23H4Nj982@nongnu.org
X-Gm-Message-State: AOJu0YxxRb7Dx89NP7KFHy17v4FCwJv6MCJbA3Kz2pdmepBbTkPY7Kxk
 CFNUn9emhhU4jCZ7HWH02uZ6ArXDpVgdp7MdjXSrYkRtelMCM4X1HycMt9VJ0l3sxTusIKUasDy
 NYrPcu7Keu6PIamTRJV/hOIQzOoXSaDfjk5sYAg==
X-Google-Smtp-Source: AGHT+IGKmtaL4TNwJd3xVPi2Ud5h0yYcIT5rV6CGbf0dgnTAjuXCZcnED3/2Gm4ClvOuzieOvvWFj6+cALiqWTNpnDw=
X-Received: by 2002:a05:6a00:4b53:b0:71e:44f6:6900 with SMTP id
 d2e1a72fcca58-71e44f66bc4mr3191132b3a.16.1728679286716; Fri, 11 Oct 2024
 13:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <20241009-pmu_event_machine-v1-5-dcbd7a60e3ba@rivosinc.com>
 <3746b775-0fa1-4eca-a25c-b961cf083451@yadro.com>
In-Reply-To: <3746b775-0fa1-4eca-a25c-b961cf083451@yadro.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 11 Oct 2024 13:41:15 -0700
Message-ID: <CAHBxVyHOVRmAi9rXZn-M8sW_ezrY529Wfdb8ttPr9WVjVzU=mQ@mail.gmail.com>
Subject: Re: [PATCH RFC 05/10] target/riscv: Rename the PMU events
To: Alexei Filippov <alexei.filippov@yadro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 alexei.filippov@syntacore.com, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 10, 2024 at 5:10=E2=80=AFAM Alexei Filippov
<alexei.filippov@yadro.com> wrote:
>
>
>
> On 10.10.2024 02:09, Atish Patra wrote:
> > The current PMU events are defined by SBI PMU
> > specification.  As there is no standard event encoding
> > scheme, Virt machine chooses to use the SBI PMU encoding.
> > A platform may choose to implement a different event
> > encoding scheme completely.
> >
> > Rename the event names to reflect the reality.
> >
> > No functional changes introduced.
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> >   target/riscv/cpu.h        | 26 +++++++++++++++-----
> >   target/riscv/cpu_helper.c |  8 +++---
> >   target/riscv/pmu.c        | 62 ++++++++++++++++++--------------------=
---------
> >   target/riscv/pmu.h        |  2 +-
> >   4 files changed, 48 insertions(+), 50 deletions(-)
> >
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 97e408b91219..2ac391a7cf74 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -820,14 +820,28 @@ enum {
> >   /*
> >    * The event id are encoded based on the encoding specified in the
> >    * SBI specification v0.3
> > + *
> > + * The event encoding is specified in the SBI specification
> > + * Event idx is a 20bits wide number encoded as follows:
> > + * event_idx[19:16] =3D type
> > + * event_idx[15:0] =3D code
> > + * The code field in cache events are encoded as follows:
> > + * event_idx.code[15:3] =3D cache_id
> > + * event_idx.code[2:1] =3D op_id
> > + * event_idx.code[0:0] =3D result_id
> >    */
> >
> > -enum riscv_pmu_event_idx {
> > -    RISCV_PMU_EVENT_HW_CPU_CYCLES =3D 0x01,
> > -    RISCV_PMU_EVENT_HW_INSTRUCTIONS =3D 0x02,
> > -    RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS =3D 0x10019,
> > -    RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS =3D 0x1001B,
> > -    RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS =3D 0x10021,
> > +enum virt_pmu_event_idx {
> > +    /* SBI_PMU_HW_CPU_CYCLES: 0x01 : type(0x00) */
> > +    VIRT_PMU_EVENT_HW_CPU_CYCLES =3D 0x01,
> > +    /* SBI_PMU_HW_INSTRUCTIONS: 0x02 : type(0x00) */
> > +    VIRT_PMU_EVENT_HW_INSTRUCTIONS =3D 0x02,
> > +    /* SBI_PMU_HW_CACHE_DTLB : 0x03 READ : 0x00 MISS : 0x00 type(0x01)=
 */
> > +    VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS =3D 0x10019,
> > +    /* SBI_PMU_HW_CACHE_DTLB : 0x03 WRITE : 0x01 MISS : 0x00 type(0x01=
) */
> > +    VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS =3D 0x1001B,
> > +    /* SBI_PMU_HW_CACHE_ITLB : 0x04 READ : 0x00 MISS : 0x00 type(0x01)=
 */
> > +    VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS =3D 0x10021,
> Pretty sure, this is not a good idea to rename them since the generic
> event even do not include TLB_* events as far as I know. It's acctually
> better to just leave generic naming as is and let the machine handle
> machine specific events separatly.

These event names are defined in SBI specification which virt machine
implements.
https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-pmu.adoc=
#event-hardware-cache-events-type-1

These are not RISC-V standard events. As I mentioned in the cover
letter, there are no standard RISC-V event names.
Adding the RISCV_PMU prefix is confusing as there is a performance
event TG which is trying to define standard events.

> >   };
> >
> >   /* used by tcg/tcg-cpu.c*/
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 203c0a92ab75..0f1655a221bd 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -1295,17 +1295,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs=
, vaddr addr,
> >
> >   static void pmu_tlb_fill_incr_ctr(RISCVCPU *cpu, MMUAccessType access=
_type)
> >   {
> > -    enum riscv_pmu_event_idx pmu_event_type;
> > +    enum virt_pmu_event_idx pmu_event_type;
> >
> >       switch (access_type) {
> >       case MMU_INST_FETCH:
> > -        pmu_event_type =3D RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS;
> > +        pmu_event_type =3D VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS;
> >           break;
> >       case MMU_DATA_LOAD:
> > -        pmu_event_type =3D RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS;
> > +        pmu_event_type =3D VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS;
> >           break;
> >       case MMU_DATA_STORE:
> > -        pmu_event_type =3D RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS;
> > +        pmu_event_type =3D VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS;
> >           break;
> >       default:
> >           return;
> > diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> > index 2531d4f1a9c1..c436b08d1043 100644
> > --- a/target/riscv/pmu.c
> > +++ b/target/riscv/pmu.c
> > @@ -38,40 +38,24 @@ void riscv_pmu_generate_fdt_node(void *fdt, uint32_=
t cmask, char *pmu_name)
> >   {
> >       uint32_t fdt_event_ctr_map[15] =3D {};
> >
> > -   /*
> > -    * The event encoding is specified in the SBI specification
> > -    * Event idx is a 20bits wide number encoded as follows:
> > -    * event_idx[19:16] =3D type
> > -    * event_idx[15:0] =3D code
> > -    * The code field in cache events are encoded as follows:
> > -    * event_idx.code[15:3] =3D cache_id
> > -    * event_idx.code[2:1] =3D op_id
> > -    * event_idx.code[0:0] =3D result_id
> > -    */
> > -
> > -   /* SBI_PMU_HW_CPU_CYCLES: 0x01 : type(0x00) */
> > -   fdt_event_ctr_map[0] =3D cpu_to_be32(0x00000001);
> > -   fdt_event_ctr_map[1] =3D cpu_to_be32(0x00000001);
> > +   fdt_event_ctr_map[0] =3D cpu_to_be32(VIRT_PMU_EVENT_HW_CPU_CYCLES);
> > +   fdt_event_ctr_map[1] =3D cpu_to_be32(VIRT_PMU_EVENT_HW_CPU_CYCLES);
> >      fdt_event_ctr_map[2] =3D cpu_to_be32(cmask | 1 << 0);
> >
> > -   /* SBI_PMU_HW_INSTRUCTIONS: 0x02 : type(0x00) */
> > -   fdt_event_ctr_map[3] =3D cpu_to_be32(0x00000002);
> > -   fdt_event_ctr_map[4] =3D cpu_to_be32(0x00000002);
> > +   fdt_event_ctr_map[3] =3D cpu_to_be32(VIRT_PMU_EVENT_HW_INSTRUCTIONS=
);
> > +   fdt_event_ctr_map[4] =3D cpu_to_be32(VIRT_PMU_EVENT_HW_INSTRUCTIONS=
);
> >      fdt_event_ctr_map[5] =3D cpu_to_be32(cmask | 1 << 2);
> >
> > -   /* SBI_PMU_HW_CACHE_DTLB : 0x03 READ : 0x00 MISS : 0x00 type(0x01) =
*/
> > -   fdt_event_ctr_map[6] =3D cpu_to_be32(0x00010019);
> > -   fdt_event_ctr_map[7] =3D cpu_to_be32(0x00010019);
> > +   fdt_event_ctr_map[6] =3D cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_READ=
_MISS);
> > +   fdt_event_ctr_map[7] =3D cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_READ=
_MISS);
> >      fdt_event_ctr_map[8] =3D cpu_to_be32(cmask);
> >
> > -   /* SBI_PMU_HW_CACHE_DTLB : 0x03 WRITE : 0x01 MISS : 0x00 type(0x01)=
 */
> > -   fdt_event_ctr_map[9] =3D cpu_to_be32(0x0001001B);
> > -   fdt_event_ctr_map[10] =3D cpu_to_be32(0x0001001B);
> > +   fdt_event_ctr_map[9] =3D cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_WRIT=
E_MISS);
> > +   fdt_event_ctr_map[10] =3D cpu_to_be32(VIRT_PMU_EVENT_CACHE_DTLB_WRI=
TE_MISS);
> >      fdt_event_ctr_map[11] =3D cpu_to_be32(cmask);
> >
> > -   /* SBI_PMU_HW_CACHE_ITLB : 0x04 READ : 0x00 MISS : 0x00 type(0x01) =
*/
> > -   fdt_event_ctr_map[12] =3D cpu_to_be32(0x00010021);
> > -   fdt_event_ctr_map[13] =3D cpu_to_be32(0x00010021);
> > +   fdt_event_ctr_map[12] =3D cpu_to_be32(VIRT_PMU_EVENT_CACHE_ITLB_PRE=
FETCH_MISS);
> > +   fdt_event_ctr_map[13] =3D cpu_to_be32(VIRT_PMU_EVENT_CACHE_ITLB_PRE=
FETCH_MISS);
> >      fdt_event_ctr_map[14] =3D cpu_to_be32(cmask);
> Ok, I guess it's time to do smthng generic to this function, cz if
> number of supported machines will go up it's going to be a problem I gues=
s.
> >

We can define a generic helper function in the pmu.c. Keep in mind
this is only required for the machines
without counter delegation extensions. In a few years, every new
platform will probably implement counter delegation
which voids the requirement of SBI PMU DT node.

> >      /* This a OpenSBI specific DT property documented in OpenSBI docs =
*/
> > @@ -290,7 +274,7 @@ void riscv_pmu_update_fixed_ctrs(CPURISCVState *env=
, target_ulong newpriv,
> >       riscv_pmu_icount_update_priv(env, newpriv, new_virt);
> >   }
> >
> > -int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_i=
dx)
> > +int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum virt_pmu_event_idx event_id=
x)
> >   {
> >       uint32_t ctr_idx;
> >       int ret;
> > @@ -329,7 +313,7 @@ bool riscv_pmu_ctr_monitor_instructions(CPURISCVSta=
te *env,
> >       }
> >
> >       cpu =3D env_archcpu(env);
> > -    if (!riscv_pmu_htable_lookup(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS,
> > +    if (!riscv_pmu_htable_lookup(cpu, VIRT_PMU_EVENT_HW_INSTRUCTIONS,
> >                                    &ctr_idx)) {
> >           return false;
> >       }
> > @@ -348,7 +332,7 @@ bool riscv_pmu_ctr_monitor_cycles(CPURISCVState *en=
v, uint32_t target_ctr)
> >       }
> >
> >       cpu =3D env_archcpu(env);
> > -    if (!riscv_pmu_htable_lookup(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES,
> > +    if (!riscv_pmu_htable_lookup(cpu, VIRT_PMU_EVENT_HW_CPU_CYCLES,
> >                                   &ctr_idx)) {
> >           return false;
> >       }
> > @@ -406,11 +390,11 @@ int riscv_pmu_update_event_map(CPURISCVState *env=
, uint64_t value,
> >       }
> >
> >       switch (event_idx) {
> > -    case RISCV_PMU_EVENT_HW_CPU_CYCLES:
> > -    case RISCV_PMU_EVENT_HW_INSTRUCTIONS:
> > -    case RISCV_PMU_EVENT_CACHE_DTLB_READ_MISS:
> > -    case RISCV_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
> > -    case RISCV_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
> > +    case VIRT_PMU_EVENT_HW_CPU_CYCLES:
> > +    case VIRT_PMU_EVENT_HW_INSTRUCTIONS:
> > +    case VIRT_PMU_EVENT_CACHE_DTLB_READ_MISS:
> > +    case VIRT_PMU_EVENT_CACHE_DTLB_WRITE_MISS:
> > +    case VIRT_PMU_EVENT_CACHE_ITLB_PREFETCH_MISS:
> >           break;
> >       default:
> >           /* We don't support any raw events right now */
> > @@ -464,7 +448,7 @@ static bool pmu_hpmevent_set_of_if_clear(CPURISCVSt=
ate *env, uint32_t ctr_idx)
> >   }
> >
> >   static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> > -                                  enum riscv_pmu_event_idx evt_idx)
> > +                                  enum virt_pmu_event_idx evt_idx)
> >   {
> >       uint32_t ctr_idx;
> >       CPURISCVState *env =3D &cpu->env;
> > @@ -473,8 +457,8 @@ static void pmu_timer_trigger_irq(RISCVCPU *cpu,
> >       uint64_t curr_ctr_val, curr_ctrh_val;
> >       uint64_t ctr_val;
> >
> > -    if (evt_idx !=3D RISCV_PMU_EVENT_HW_CPU_CYCLES &&
> > -        evt_idx !=3D RISCV_PMU_EVENT_HW_INSTRUCTIONS) {
> > +    if (evt_idx !=3D VIRT_PMU_EVENT_HW_CPU_CYCLES &&
> > +        evt_idx !=3D VIRT_PMU_EVENT_HW_INSTRUCTIONS) {
> >           return;
> >       }
> >
> > @@ -533,8 +517,8 @@ void riscv_pmu_timer_cb(void *priv)
> >       RISCVCPU *cpu =3D priv;
> >
> >       /* Timer event was triggered only for these events */
> > -    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_CPU_CYCLES);
> > -    pmu_timer_trigger_irq(cpu, RISCV_PMU_EVENT_HW_INSTRUCTIONS);
> > +    pmu_timer_trigger_irq(cpu, VIRT_PMU_EVENT_HW_CPU_CYCLES);
> > +    pmu_timer_trigger_irq(cpu, VIRT_PMU_EVENT_HW_INSTRUCTIONS);
> >   }
> >
> >   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value, uint32_=
t ctr_idx)
> > diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> > index 3853d0e2629e..75a22d596b69 100644
> > --- a/target/riscv/pmu.h
> > +++ b/target/riscv/pmu.h
> > @@ -30,7 +30,7 @@ void riscv_pmu_timer_cb(void *priv);
> >   void riscv_pmu_init(RISCVCPU *cpu, Error **errp);
> >   int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
> >                                  uint32_t ctr_idx);
> > -int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_i=
dx);
> > +int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum virt_pmu_event_idx event_id=
x);
> >   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu=
_name);
> >   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
> >                             uint32_t ctr_idx);
> >

