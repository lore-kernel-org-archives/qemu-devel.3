Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15929C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 07:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIMZV-0005BB-JU; Fri, 23 May 2025 03:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliver.upton@linux.dev>)
 id 1uIMZO-0005AQ-At
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:11:54 -0400
Received: from out-172.mta0.migadu.com ([91.218.175.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oliver.upton@linux.dev>)
 id 1uIMZK-0003uT-Pk
 for qemu-devel@nongnu.org; Fri, 23 May 2025 03:11:54 -0400
Date: Fri, 23 May 2025 00:11:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1747984306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z14A0a3u8kB2J/zGRzHx2IwSMKs1AKc3y/w9qkOU9Yk=;
 b=M8J6yJoGpcJW9jnWMjkh1DXuXC9/cT8YuBx0LlSz+QIV+W3hnw3qLXPAWWVeywKAlVDi15
 Z4qdrTHUNeSDI3elGhZnuB1mtBjtnZjyefaHNWEKmQKldkB3LYfjsW65EOVyDm+mg3TLxk
 84jy2cm30oJy+WfyWwgMdagbfCWMp3w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] target/arm: Ignore SCTLR_EL2.EnSCXT when !ELIsInHost()
Message-ID: <aDAfpy1JCV11cG84@linux.dev>
References: <20250521190228.3921172-1-oliver.upton@linux.dev>
 <dd52d28f-dde9-4506-a850-dd1222a4c903@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd52d28f-dde9-4506-a850-dd1222a4c903@linaro.org>
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=91.218.175.172;
 envelope-from=oliver.upton@linux.dev; helo=out-172.mta0.migadu.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On Thu, May 22, 2025 at 09:06:06PM -0300, Gustavo Romero wrote:
> Hi Oliver,
> 
> Thanks for patch.
> 
> On 5/21/25 16:02, Oliver Upton wrote:
> > Using an EL2 that enables SCXTNUM_ELx for guests while disabling the
> > feature for the host generates erroneous traps to EL2 when running under
> > TCG.
> > 
> > Fix the issue by only evaluating SCTLR_EL2.EnSCXT when ELIsInHost().
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

%s/EnSCXT/TSCXT/

My bad.

> > ---
> >   target/arm/helper.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> > 
> > diff --git a/target/arm/helper.c b/target/arm/helper.c
> > index 7631210287..83d4236417 100644
> > --- a/target/arm/helper.c
> > +++ b/target/arm/helper.c
> > @@ -7389,16 +7389,16 @@ static CPAccessResult access_scxtnum(CPUARMState *env, const ARMCPRegInfo *ri,
> >   {
> >       uint64_t hcr = arm_hcr_el2_eff(env);
> >       int el = arm_current_el(env);
> > +    uint64_t sctlr;
> > -    if (el == 0 && !((hcr & HCR_E2H) && (hcr & HCR_TGE))) {
> > -        if (env->cp15.sctlr_el[1] & SCTLR_TSCXT) {
> > -            if (hcr & HCR_TGE) {
> > -                return CP_ACCESS_TRAP_EL2;
> > -            }
> > -            return CP_ACCESS_TRAP_EL1;
> > +    sctlr = el_is_in_host(env, el) ? env->cp15.sctlr_el[2] :
> > +            env->cp15.sctlr_el[1];
> > +
> > +    if (el == 0 && (sctlr & SCTLR_TSCXT)) {
> > +        if (hcr & HCR_TGE) {
> > +            return CP_ACCESS_TRAP_EL2;
> >           }
> > -    } else if (el < 2 && (env->cp15.sctlr_el[2] & SCTLR_TSCXT)) {
> > -        return CP_ACCESS_TRAP_EL2;
> > +        return CP_ACCESS_TRAP_EL1;
> >       }
> >       if (el < 2 && arm_is_el2_enabled(env) && !(hcr & HCR_ENSCXT)) {
> >           return CP_ACCESS_TRAP_EL2;
> 
> Do you mind providing a bit more of context when these erroneous traps happen?

Sure. I was looking at updating our CSV2 limit in KVM [*] and needed to
implement SCXTNUM_ELx as part of that. Accessing SCXTNUM_ELx from a KVM
guest under TCG leads to an unexpected trap taken to EL2 in spite of
the fact that HCR_EL2.EnSCXT=1.

The host kernel still has SCTLR_EL2.TSCXT=1 which appears to be the
source of the trap.

> Do we have an issue in QEMU's gitlab about it? What are the QEMU options for a
> VM where this issue can be reproduced and, is there an easy way we can reproduce it?

You could try reproducing with the linked KVM patches but it is worth
noting the current trap routing is rather obviously wrong when compared
to the pseudocode in the ARM ARM. More generally, using the host's
SCTLR to compute traps while in a guest EL is unlikely to ever be right.

[*]: https://git.kernel.org/pub/scm/linux/kernel/git/oupton/linux.git/log/?h=kvm-arm64/csv2_3

Thanks,
Oliver

