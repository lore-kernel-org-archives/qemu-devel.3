Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF1B3FED3EA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 16:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGJ2V-0008DF-19; Fri, 24 Apr 2026 12:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wGJ2S-0008CA-La; Fri, 24 Apr 2026 12:05:56 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wGJ2Q-000742-9d; Fri, 24 Apr 2026 12:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=sbx/RKRMkl5PTDgYKAUcBw/iP09I3jWTM3uR4/reaBc=; b=FuKZus383TjkavS
 DBm2ThHuuCHMCHj+cz/eav2SoJaq3ww7JQ++am16c0WMeHETrvPkzYaOGe7+dnIQYN7VTJF5zduDl
 fqyKKgsT01N/HPMdGRe+L09LAM24tl+LFzcawo22WaCN5pVZXpWaQSxi+r10XuOsKdaTAu1G+GVVF
 DI=;
Date: Fri, 24 Apr 2026 18:10:01 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alvin Chang <alvinga@andestech.com>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 vivahavey@gmail.com, Yu-Ming Chang <yumin686@andestech.com>
Subject: Re: [PATCH] target/riscv: Make number of debug triggers configurable
Message-ID: <aeuQuank4zL2j6E1@hive.localdomain>
References: <20251201080524.186697-1-alvinga@andestech.com>
 <23006638-7d07-4e8f-b910-ef06c2dc13cc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23006638-7d07-4e8f-b910-ef06c2dc13cc@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/04/26, Philippe Mathieu-Daudé wrote:
> On 1/12/25 09:05, Alvin Chang via wrote:
> > In current implementation, the number of debug triggers was hardcoded as
> > RV_MAX_TRIGGERS macro. This commit replaces the fixed value with a new
> > "num_triggers" configuration, allowing platforms to configure the number
> > of debug triggers they want.
> > 
> > If no specific option is provided, the default number of debug triggers
> > remains 2 as before.
> > 
> > A new CPU property "num-triggers" is added to let users configure the
> > number of debug triggers from the command line. For example:
> > 
> >    -cpu max,num-triggers=8
> > 
> > Signed-off-by: Alvin Chang <alvinga@andestech.com>
> > Reviewed-by: Yu-Ming Chang <yumin686@andestech.com>
> > ---
> >   target/riscv/cpu.c                | 34 +++++++++++++++++++++++++++++++
> >   target/riscv/cpu.h                | 12 +++++------
> >   target/riscv/cpu_cfg_fields.h.inc |  1 +
> >   target/riscv/csr.c                |  3 ++-
> >   target/riscv/debug.c              | 23 +++++++++++++--------
> >   target/riscv/debug.h              |  2 --
> >   target/riscv/machine.c            | 16 ++++++++++-----
> >   7 files changed, 69 insertions(+), 22 deletions(-)
> 
> 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 36e7f10..b32ed78 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -450,13 +450,13 @@ struct CPUArchState {
> >       /* trigger module */
> >       target_ulong trigger_cur;
> > -    target_ulong tdata1[RV_MAX_TRIGGERS];
> > -    target_ulong tdata2[RV_MAX_TRIGGERS];
> > -    target_ulong tdata3[RV_MAX_TRIGGERS];
> > +    target_ulong *tdata1;
> > +    target_ulong *tdata2;
> > +    target_ulong *tdata3;
> >       target_ulong mcontext;
> > -    struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
> > -    struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
> > -    QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> > +    struct CPUBreakpoint **cpu_breakpoint;
> > +    struct CPUWatchpoint **cpu_watchpoint;
> > +    QEMUTimer **itrigger_timer;
> >       int64_t last_icount;
> >       bool itrigger_enabled;
> 
> 
> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > index 18d790a..c7244b7 100644
> > --- a/target/riscv/machine.c
> > +++ b/target/riscv/machine.c
> > @@ -239,15 +239,21 @@ static int debug_post_load(void *opaque, int version_id)
> >   static const VMStateDescription vmstate_debug = {
> >       .name = "cpu/debug",
> > -    .version_id = 2,
> > -    .minimum_version_id = 2,
> > +    .version_id = 3,
> > +    .minimum_version_id = 3,
> >       .needed = debug_needed,
> >       .post_load = debug_post_load,
> >       .fields = (const VMStateField[]) {
> >           VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
> > -        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> > -        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> > -        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> > +        VMSTATE_VARRAY_UINT32(env.tdata1, RISCVCPU,
> > +                              cfg.num_triggers, 0,
> > +                              vmstate_info_uinttl, target_ulong),
> > +        VMSTATE_VARRAY_UINT32(env.tdata2, RISCVCPU,
> > +                              cfg.num_triggers, 0,
> > +                              vmstate_info_uinttl, target_ulong),
> > +        VMSTATE_VARRAY_UINT32(env.tdata3, RISCVCPU,
> > +                              cfg.num_triggers, 0,
> > +                              vmstate_info_uinttl, target_ulong),
> 
> Breaking migration is a good opportunity to convert the underlying
> type to uint64_t. Although can be also done later.
> Anton, Alistair, WDYT?

In that case we should also change other debug fields

 - target_ulong trigger_cur;
 + uint8_t trigger_cur;
 
 - VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
 + VMSTATE_UINT8(env.trigger_cur, RISCVCPU),

and add migration to mcontext (https://lists.gnu.org/archive/html/qemu-devel/2025-10/msg03833.html)

 - target_ulong mcontext;
 + uint16_t mcontext;
 
 + VMSTATE_UINT16(env.mcontext, RISCVCPU),

I personally don't mind doing these changes, I have ~5 other migration
changes which are yet to go in that I'll resubmit soon.

-- 
Anton Johansson
rev.ng Labs Srl.

