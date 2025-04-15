Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA86C369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 11:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4eIZ-00083e-5L; Tue, 15 Apr 2025 07:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u4eIK-00082L-I0; Tue, 15 Apr 2025 07:17:37 -0400
Received: from out28-173.mail.aliyun.com ([115.124.28.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lc00631@tecorigin.com>)
 id 1u4eIH-0006vO-0F; Tue, 15 Apr 2025 07:17:35 -0400
Received: from TC-DZ-03-0020.tc.local(mailfrom:lc00631@tecorigin.com
 fp:SMTPD_---.cNHiXnY_1744715836 cluster:ay29) by smtp.aliyun-inc.com;
 Tue, 15 Apr 2025 19:17:20 +0800
From: Chao Liu <lc00631@tecorigin.com>
To: philmd@linaro.org, Chao Liu <lc00631@tecorigin.com>, alistair23@gmail.com,
 palmer@dabbelt.com
Cc: alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 zqz00548@tecorigin.com
Subject: Re: Re: [PATCH v1 1/1] hw/riscv: fix PLIC hart topology configuration
 string when not getting CPUState correctly
Date: Tue, 15 Apr 2025 19:14:58 +0800
Message-ID: <20250415111459.1443-1-lc00631@tecorigin.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <07a97219e3f7e342c668d6772acc4c0a8eb4d4f3.1744709888.git.lc00631@tecorigin.com>
References: <cover.1744709888.git.lc00631@tecorigin.com>
 <07a97219e3f7e342c668d6772acc4c0a8eb4d4f3.1744709888.git.lc00631@tecorigin.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-BeenThere: qemu-riscv@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.28.173;
 envelope-from=lc00631@tecorigin.com; helo=out28-173.mail.aliyun.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, MAILING_LIST_MULTI=-1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

> Hi,
> 
> On 15/4/25 12:05, Chao Liu wrote:
> > riscv_plic_hart_config_string() when getting CPUState via qemu_get_cpu()
> > should be consistent with keeping sifive_plic_realize() by
> > hartid_base + cpu_index.
> > 
> > For non-numa or single-cluster machines, hartid_base should be 0.
> > 
> > Also, to ensure that CPUState->cpu_index is set correctly, we need to
> > update it with the value of mhartid during riscv_hart_realize().
> > 
> > Signed-off-by: Chao Liu <lc00631@tecorigin.com>
> > Reviewed-by: zhaoqingze <zqz00548@tecorigin.com>
> > ---
> >   hw/riscv/boot.c            | 4 ++--
> >   hw/riscv/microchip_pfsoc.c | 2 +-
> >   hw/riscv/riscv_hart.c      | 1 +
> >   hw/riscv/sifive_u.c        | 5 +++--
> >   hw/riscv/virt.c            | 2 +-
> >   include/hw/riscv/boot.h    | 2 +-
> >   6 files changed, 9 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> > index 765b9e2b1a..d4c06e7530 100644
> > --- a/hw/riscv/boot.c
> > +++ b/hw/riscv/boot.c
> > @@ -44,13 +44,13 @@ bool riscv_is_32bit(RISCVHartArrayState *harts)
> >    * Return the per-socket PLIC hart topology configuration string
> >    * (caller must free with g_free())
> >    */
> > -char *riscv_plic_hart_config_string(int hart_count)
> > +char *riscv_plic_hart_config_string(int hart_base, int hart_count)
> >   {
> >       g_autofree const char **vals = g_new(const char *, hart_count + 1);
> >       int i;
> >   
> >       for (i = 0; i < hart_count; i++) {
> > -        CPUState *cs = qemu_get_cpu(i);
> > +        CPUState *cs = qemu_get_cpu(hart_base + i);
> >           CPURISCVState *env = &RISCV_CPU(cs)->env;
> >   
> >           if (kvm_enabled()) {
> > diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
> > index 9c846f9b5b..5269336346 100644
> > --- a/hw/riscv/microchip_pfsoc.c
> > +++ b/hw/riscv/microchip_pfsoc.c
> > @@ -275,7 +275,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
> >                                   l2lim_mem);
> >   
> >       /* create PLIC hart topology configuration string */
> > -    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
> > +    plic_hart_config = riscv_plic_hart_config_string(0, ms->smp.cpus);
> >   
> >       /* PLIC */
> >       s->plic = sifive_plic_create(memmap[MICROCHIP_PFSOC_PLIC].base,
> > diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> > index a55d156668..522e795033 100644
> > --- a/hw/riscv/riscv_hart.c
> > +++ b/hw/riscv/riscv_hart.c
> > @@ -138,6 +138,7 @@ static bool riscv_hart_realize(RISCVHartArrayState *s, int idx,
> >       }
> >   
> >       s->harts[idx].env.mhartid = s->hartid_base + idx;
> > +    CPU(&s->harts[idx])->cpu_index = s->harts[idx].env.mhartid;
> 
> Why do we need this particular change? CPUState::cpu_index isn't related
> to RISC-V HART index, it is meant for the accelerators (KVM, TCG, ...),
> and shouldn't be used by hw/ code.
> 
> Otherwise the rest LGTM.
> 
> Regards,
> 
> Phil.

Thanks for the reply, here is an update to cpu_index, mainly for consistency
with the following:

static void sifive_plic_realize(DeviceState *dev, Error **errp)
{
    ...

    for (i = 0; i < s->num_harts; i++) {
        /* this get cpu with hartid_base + i */ 
        RISCVCPU *cpu = RISCV_CPU(qemu_get_cpu(s->hartid_base + i));
        if (riscv_cpu_claim_interrupts(cpu, MIP_SEIP) < 0) {
            error_setg(errp, "SEIP already claimed");
            return;
        }
    }

    msi_nonbroken = true;
}

But when adding the cpu to the global chain table, the cpu_index starts at 0.

Maybe there is a better way to handle this here?

For example:

1. When updating the cpu_index in the upper level, we can set a base id, and by
setting this base id, we can update the cpu_index indirectly.

or

2. Modify sifive_plic_realize() to iterate over cpu's to avoid getting them
by id.

I haven't thought of a better way to handle this at the moment,
so we can discuss it further

--
Regards,
Chao

