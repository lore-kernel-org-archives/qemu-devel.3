Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F475CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 10:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBsnT-0000p0-Cw; Thu, 23 Oct 2025 06:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vBsnS-0000om-3g
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:43:54 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vBsnQ-00084H-2L
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 06:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=wrVEUk0hbhiNHRCsP0pbve8d28pq4R933LqdrNSHt5g=; b=peNHI7zJhYyJSbU
 oAgsOlSYLBl0OVWf6qXUYXainLS3zs99rBZjdLlTYhZLvg4JEdxEah+Nfl1ukQgbjvnlkbX5+4lhT
 TnfTGGOnNZjCG7tOB3gFbza99GDCxpc4FhjH/oYPx7tZGlsJh6RLBI+qJrLVKNhVkbOHcf4XSRko3
 Dk=;
Date: Thu, 23 Oct 2025 12:46:31 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Subject: Re: [PATCH v3 29/34] target/riscv: Fix size of trigger data
Message-ID: <mfhg7njqvfv563gdy43sme4d2jemjoybmemzrzewi42ngrlxq2@xbuo4frf5qj6>
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-30-anjo@rev.ng>
 <3395a80a-d3db-4ebd-a11c-e7746d59c9ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3395a80a-d3db-4ebd-a11c-e7746d59c9ce@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/10/25, Philippe Mathieu-Daudé wrote:
> On 14/10/25 22:35, Anton Johansson wrote:
> > mcontext is at most 14 bits in size with the H extension, fix to 16
> > bits. trigger_cur indexes into tdata*[RV_MAX_TRIGGERS] which holds 2
> > elements, fix to 8 bits.
> > 
> > Note, the cpu/debug VMSTATE version is bumped, breaking migration from
> > older versions.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> >   target/riscv/cpu.h     | 10 +++++-----
> >   target/riscv/machine.c | 12 ++++++------
> >   2 files changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> > index 85ad250a8f..e404b120bc 100644
> > --- a/target/riscv/cpu.h
> > +++ b/target/riscv/cpu.h
> > @@ -466,11 +466,11 @@ struct CPUArchState {
> >       target_ulong mseccfg;
> >       /* trigger module */
> > -    target_ulong trigger_cur;
> > -    target_ulong tdata1[RV_MAX_TRIGGERS];
> > -    target_ulong tdata2[RV_MAX_TRIGGERS];
> > -    target_ulong tdata3[RV_MAX_TRIGGERS];
> > -    target_ulong mcontext;
> > +    uint16_t mcontext;
> > +    uint8_t trigger_cur;
> > +    uint64_t tdata1[RV_MAX_TRIGGERS];
> > +    uint64_t tdata2[RV_MAX_TRIGGERS];
> > +    uint64_t tdata3[RV_MAX_TRIGGERS];
> >       struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
> >       struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
> >       QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> > diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> > index 376075b2bd..e86fc58e43 100644
> > --- a/target/riscv/machine.c
> > +++ b/target/riscv/machine.c
> > @@ -239,15 +239,15 @@ static int debug_post_load(void *opaque, int version_id)
> >   static const VMStateDescription vmstate_debug = {
> >       .name = "cpu/debug",
> > -    .version_id = 2,
> > -    .minimum_version_id = 2,
> > +    .version_id = 3,
> > +    .minimum_version_id = 3,
> >       .needed = debug_needed,
> >       .post_load = debug_post_load,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
> > -        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> > -        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> > -        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> > +        VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
> > +        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> > +        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> > +        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> 
> Pre-existing, but mcontext is not migrated. Deliberate?
> 
> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Since trigger data is migrated I think it is correct to also migrate
mcontext.  I'll add the migration entry to this patch in v4 and maybe
Alistair or someone else can chime in.

Thanks!:)

