Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D095CA0EC4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 03:11:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um1sC-0001YX-U7; Tue, 12 Aug 2025 23:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1um1sA-0001Xu-9q; Tue, 12 Aug 2025 23:09:55 -0400
Received: from mail-m16.yeah.net ([220.197.32.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1um1rc-0001RB-AR; Tue, 12 Aug 2025 23:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=Message-ID:Date:MIME-Version:To:Subject:From:
 Content-Type; bh=0i4t+iVXztnfd6PoyjrMxbBDXos5ErwkV1LUwMLvQSE=;
 b=HNx0DCgAPN/H7hnrzwKjp1fjJbggmgLbD7UcacDs3qVqXa+qBWqdhk64+ctOLh
 ZBGJtwL8D0N1KcXpw+XiMYdJogdD0UvuMHjB8S96LQXq43DdvZdT3kCp9SvIeFdL
 Sp6BHHPv1+OkbPDay6W7kD1eK208NA6jtl7PcK0jE/QLQ=
Received: from [192.168.71.3] (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3dyBiAZxo_heOAg--.18116S2;
 Wed, 13 Aug 2025 11:07:16 +0800 (CST)
Message-ID: <4d658cff-d8ab-4d95-b340-c6b7b5375395@yeah.net>
Date: Wed, 13 Aug 2025 11:07:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jim.shu@sifive.com, dbarboza@ventanamicro.com
Cc: alistair.francis@wdc.com, arikalo@gmail.com, atar4qemu@gmail.com,
 aurelien@aurel32.net, david@redhat.com, deller@gmx.de,
 edgar.iglesias@gmail.com, eduardo@habkost.net, gaosong@loongson.cn,
 iii@linux.ibm.com, jcmvbkbc@gmail.com, jiaxun.yang@flygoat.com,
 kbastian@mail.uni-paderborn.de, laurent@vivier.eu, liwei1518@gmail.com,
 marcel.apfelbaum@gmail.com, mark.cave-ayland@ilande.co.uk,
 mrolnik@gmail.com, npiggin@gmail.com, palmer@dabbelt.com,
 pbonzini@redhat.com, peterx@redhat.com, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, richard.henderson@linaro.org, shorne@gmail.com,
 thuth@redhat.com, wangyanan55@huawei.com, zhao1.liu@intel.com,
 zhiwei_liu@linux.alibaba.com
References: <20701dc8-d156-4ad9-8945-282321c15527@ventanamicro.com>
Subject: Re: [PATCH v2 13/18] hw/misc: riscv_worldguard: Add API to enable WG
 extension of CPU
From: Chao Liu <chao.liu@yeah.net>
In-Reply-To: <20701dc8-d156-4ad9-8945-282321c15527@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: Ms8vCgD3dyBiAZxo_heOAg--.18116S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw4fAw1fWw4DGw4DKry5XFb_yoW7Jw47pr
 4rCF4aqr1DWry3J3W3XryxJF1Sg3s5Wr15Cws7Aa4fCwsFvFWxArn0k3y2kFn7XFs3Zr1F
 vFy2grWUua1SvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq6wAUUUUU=
X-Originating-IP: [114.88.98.193]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiNQSawmicAWRjqQAA3y
Received-SPF: pass client-ip=220.197.32.19; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On 4/17/25 7:52 AM, Jim Shu wrote:
> > riscv_worldguard_apply_cpu() could enable WG CPU extension and set WG
> > callback to CPUs. It is used by machine code after realizing global WG
> > device.
> > 
> > Signed-off-by: Jim Shu <jim.shu@sifive.com>
> > ---
> >   hw/misc/riscv_worldguard.c         | 87 ++++++++++++++++++++++++++++++
> >   include/hw/misc/riscv_worldguard.h |  1 +
> >   2 files changed, 88 insertions(+)
> > 
> > diff --git a/hw/misc/riscv_worldguard.c b/hw/misc/riscv_worldguard.c
> > index b02bd28d02..1a910f4cf3 100644
> > --- a/hw/misc/riscv_worldguard.c
> > +++ b/hw/misc/riscv_worldguard.c
> > @@ -92,6 +92,93 @@ uint32_t mem_attrs_to_wid(MemTxAttrs attrs)
> >       }
> >   }
> >   
> > +static void riscv_cpu_wg_reset(CPURISCVState *env)
> > +{
> > +    CPUState *cs = env_cpu(env);
> > +    RISCVCPU *cpu = RISCV_CPU(cs);
> > +    uint32_t mlwid, slwid, mwiddeleg;
> > +    uint32_t trustedwid;
> > +
> > +    if (!riscv_cpu_cfg(env)->ext_smwg) {
> > +        return;
> > +    }
> > +
> > +    if (worldguard_config == NULL) {
> > +        /*
> > +         * Note: This reset is dummy now and WG CSRs will be reset again
> > +         * after worldguard_config is realized.
> > +         */
> > +        return;
> > +    }
> > +
> > +    trustedwid = worldguard_config->trustedwid;
> > +    if (trustedwid == NO_TRUSTEDWID) {
> > +        trustedwid = worldguard_config->nworlds - 1;
> > +    }
> > +
> > +    /* Reset mlwid, slwid, mwiddeleg CSRs */
> > +    if (worldguard_config->hw_bypass) {
> > +        /* HW bypass mode */
> > +        mlwid = trustedwid;
> > +    } else {
> > +        mlwid = 0;
> > +    }
> > +    slwid = 0;
> > +    mwiddeleg = 0;
> > +
> > +    env->mlwid = mlwid;
> > +    if (riscv_cpu_cfg(env)->ext_sswg) {
> > +        env->slwid = slwid;
> > +        env->mwiddeleg = mwiddeleg;
> > +    }
> > +
> > +    /* Check mwid, mwidlist config */
> > +    if (worldguard_config != NULL) {
> > +        uint32_t valid_widlist = MAKE_64BIT_MASK(0, worldguard_config->nworlds);
> > +
> > +        /* CPU use default mwid / mwidlist config if not set */
> > +        if (cpu->cfg.mwidlist == UINT32_MAX) {
> > +            /* mwidlist contains all WIDs */
> > +            cpu->cfg.mwidlist = valid_widlist;
> > +        }
> > +        if (cpu->cfg.mwid == UINT32_MAX) {
> > +            cpu->cfg.mwid = trustedwid;
> > +        }
> > +
> > +        /* Check if mwid/mwidlist HW config is valid in NWorld. */
> > +        g_assert((cpu->cfg.mwidlist & ~valid_widlist) == 0);
> > +        g_assert(cpu->cfg.mwid < worldguard_config->nworlds);
> > +    }
> > +}
> > +
> > +/*
> > + * riscv_worldguard_apply_cpu - Enable WG extension of CPU
> > + *
> > + * Note: This API should be used after global WG device is created
> > + * (riscv_worldguard_realize()).
> > + */
> > +void riscv_worldguard_apply_cpu(uint32_t hartid)
> > +{
> > +    /* WG global config should exist */
> > +    g_assert(worldguard_config);
> 
> We usually add g_asserts() after the variable declarations.
> 
> > +
> > +    CPUState *cpu = qemu_get_cpu(hartid);

arm_get_cpu() uses CPUState::cpu_index to obtain the corresponding CPUState pointer.

However, CPUState::cpu_index and the RISC-V HART index are not necessarily strictly
one-to-one (for instance, when the hartid base is non-zero or when hartids are
discontinuous).

Typically, we use arm_get_cpu() at the accelerators, rather than in hw/code.

A better approach is to use cpu_by_arch_id() instead of qemu_get_cpu(),
in RISC-V cpu_by_arch_id() uses the hartid.

e.g.

     CPUState *cpu = cpu_by_arch_id(hartid);


Thanks,

Chao

> > +    RISCVCPU *rcpu = RISCV_CPU(cpu);
> > +    CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
> > +
> > +    rcpu->cfg.ext_smwg = true;
> > +    if (riscv_has_ext(env, RVS) && riscv_has_ext(env, RVU)) {
> > +        rcpu->cfg.ext_sswg = true;
> > +    }
> 
> riscv_has_ext() will segfault if env == NULL, and you're creating a code
> path where this might happen:
> 
> > +    CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
> 
> In fact, cpu == NULL will explode on you earlier via this macro:
> 
> > +    RISCVCPU *rcpu = RISCV_CPU(cpu);
> 
> You can either handle cpu == NULL with a clean exit before using 'cpu' to assign
> stuff or g_assert(cpu != NULL) for a more rude exit. But with this code as is
> you're gambling with segfaults.
> 
> 
> Thanks,
> 
> Daniel
> 
> 
> > +
> > +    /* Set machine specific WorldGuard callback */
> > +    env->wg_reset = riscv_cpu_wg_reset;
> > +    env->wid_to_mem_attrs = wid_to_mem_attrs;
> > +
> > +    /* Reset WG CSRs in CPU */
> > +    env->wg_reset(env);
> > +}
> > +
> >   bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock)
> >   {
> >       uint32_t wid = mem_attrs_to_wid(attrs);
> > diff --git a/include/hw/misc/riscv_worldguard.h b/include/hw/misc/riscv_worldguard.h
> > index 8a533a0517..211a72e438 100644
> > --- a/include/hw/misc/riscv_worldguard.h
> > +++ b/include/hw/misc/riscv_worldguard.h
> > @@ -48,6 +48,7 @@ extern struct RISCVWorldGuardState *worldguard_config;
> >   
> >   DeviceState *riscv_worldguard_create(uint32_t nworlds, uint32_t trustedwid,
> >                                        bool hw_bypass, bool tz_compat);
> > +void riscv_worldguard_apply_cpu(uint32_t hartid);
> >   
> >   uint32_t mem_attrs_to_wid(MemTxAttrs attrs);
> >   bool could_access_wgblocks(MemTxAttrs attrs, const char *wgblock);
> 


