Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E40C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 16:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvJBp-0005kv-FN; Thu, 20 Mar 2025 12:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1tvJBi-0005kE-Qi
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:56:12 -0400
Received: from out-188.mta1.migadu.com ([2001:41d0:203:375::bc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1tvJBa-0006pP-D4
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 12:56:08 -0400
Message-ID: <d9c8d200-4453-48d7-b14a-8e15a7cf6602@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1742489757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQoIgeL4fO3BeHKQ5CMQfShjwnJSlNAjtNV/17HZLVM=;
 b=gJh6FMIPUtWWnXN4rUo1jOtRY9sqKc7myq5/83oy8op2vuT+kMPB2PsGvib7oviNF/64oN
 iNrc+lUnXbXJ8P8+NDHLS4b0qWbdfndGPObDj94juE0cgYj5vO5BMA5OJl3EuXH/1bvy17
 HlnvnMIDMnpLZliQyqA+6Ki+ht5Viq4=
Date: Fri, 21 Mar 2025 00:55:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] hvf: arm: Emulate ICC_RPR_EL1 accesses properly
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de
References: <20250315132030.95209-1-zenghui.yu@linux.dev>
 <CAFEAcA9YUmXA=bA4FERwqSEP86RFUhUKUcLvVVSV64p_QJKnbA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <CAFEAcA9YUmXA=bA4FERwqSEP86RFUhUKUcLvVVSV64p_QJKnbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::bc;
 envelope-from=zenghui.yu@linux.dev; helo=out-188.mta1.migadu.com
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

On 2025/3/19 00:56, Peter Maydell wrote:
> On Sat, 15 Mar 2025 at 13:21, Zenghui Yu <zenghui.yu@linux.dev> wrote:
> >
> > Commit a2260983c655 ("hvf: arm: Add support for GICv3") added GICv3 support
> > by implementing emulation for a few system registers. ICC_RPR_EL1 was
> > defined but not plugged in the sysreg handlers (for no good reason).
> >
> > Fix it.
> >
> > Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> > ---
> >  target/arm/hvf/hvf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> > index 87e35c1b71..650b7f4256 100644
> > --- a/target/arm/hvf/hvf.c
> > +++ b/target/arm/hvf/hvf.c
> > @@ -1359,6 +1359,7 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
> >      case SYSREG_ICC_IGRPEN0_EL1:
> >      case SYSREG_ICC_IGRPEN1_EL1:
> >      case SYSREG_ICC_PMR_EL1:
> > +    case SYSREG_ICC_RPR_EL1:
> >      case SYSREG_ICC_SGI0R_EL1:
> >      case SYSREG_ICC_SGI1R_EL1:
> >      case SYSREG_ICC_SRE_EL1:
> > @@ -1673,6 +1674,7 @@ static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
> >      case SYSREG_ICC_IGRPEN0_EL1:
> >      case SYSREG_ICC_IGRPEN1_EL1:
> >      case SYSREG_ICC_PMR_EL1:
> > +    case SYSREG_ICC_RPR_EL1:
> >      case SYSREG_ICC_SGI0R_EL1:
> >      case SYSREG_ICC_SGI1R_EL1:
> >      case SYSREG_ICC_SRE_EL1:
> 
> ICC_RPR_EL1 is a read-only register.

Yup! Writes to it should result in an UNDEFINED exception. I completely
missed that point..

> But hvf_sysreg_read_cp()
> and hvf_sysreg_write_cp() do not check the .access field of the
> ARMCPRegInfo to ensure that they forbid writes to registers that
> are marked with a .access field that says they're read-only
> (and ditto reads to write-only registers). So either we should
> not list ICC_RPR_EL1 in this list in hvf_sysreg_write(), or
> else we should add the .access checks to hvf_sysreg_read_cp()
> and hvf_sysreg_write_cp().
> 
> I would favour the second of those two options, because it's
> more robust and means we only need to care about the access
> permissions of a register in one place. Plus we already get
> this wrong for some registers: for instance ICC_SGI1R_EL1
> is write-only but we will permit the guest to read it.
> 
> So I suggest a 2-patch series:
>  * patch 1: add the checks on .access to hvf_sysreg_read_cp()
>    and hvf_sysreg_write_cp(): they need to call
>    cp_access_ok() to check this

Thanks for your detailed suggestion Peter! I come up with something like

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 650b7f4256..a7ca7975e0 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1264,6 +1264,9 @@ static bool hvf_sysreg_read_cp(CPUState *cpu,
uint32_t reg, uint64_t *val)

     ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
     if (ri) {
+        if (!cp_access_ok(arm_current_el(env), ri, true)) {
+            return false;
+        }
         if (ri->accessfn) {
             if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
                 return false;
@@ -1545,6 +1548,9 @@ static bool hvf_sysreg_write_cp(CPUState *cpu,
uint32_t reg, uint64_t val)
     ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));

     if (ri) {
+        if (!cp_access_ok(arm_current_el(env), ri, false)) {
+            return false;
+        }
         if (ri->accessfn) {
             if (ri->accessfn(env, ri, false) != CP_ACCESS_OK) {
                 return false;

I'll do some tests before sending it out.

Thanks,
Zenghui

