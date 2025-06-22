Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB35AC7115A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 08:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTGVI-0005vp-TX; Sun, 22 Jun 2025 04:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1uTGVH-0005vR-0P
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 04:56:43 -0400
Received: from out-189.mta1.migadu.com ([2001:41d0:203:375::bd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zenghui.yu@linux.dev>)
 id 1uTGVD-0007ok-As
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 04:56:42 -0400
Message-ID: <816aeea6-34c3-461c-b596-f8701a9d1557@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1750582594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5+wsnavqjrNt65TA2neNKeG2mkyqrA9F4stbFQXeNQ=;
 b=ppO4HumKtmF+/3pfesOhkTQhbwGUzUx5gXbHFKbXMXbHkiz8goZwK0YkYfTLw49jCNheaN
 HWErfSsDYuADtvoNzfpea50bWaXF3gTbnCmPCaKuRq7uFUtVskbGXi/8Rm0AlDnvKOQUIN
 E2G/2VHLPIWkLNGD+KXv0MmbWAanUqo=
Date: Sun, 22 Jun 2025 16:56:27 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] hvf: arm: Emulate ICC_RPR_EL1 accesses properly
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, agraf@csgraf.de
References: <20250315132030.95209-1-zenghui.yu@linux.dev>
 <CAFEAcA9YUmXA=bA4FERwqSEP86RFUhUKUcLvVVSV64p_QJKnbA@mail.gmail.com>
 <d9c8d200-4453-48d7-b14a-8e15a7cf6602@linux.dev>
Content-Language: en-US
In-Reply-To: <d9c8d200-4453-48d7-b14a-8e15a7cf6602@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::bd;
 envelope-from=zenghui.yu@linux.dev; helo=out-189.mta1.migadu.com
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

Hi Peter,

Sorry for the long delay..

On 2025/3/21 00:55, Zenghui Yu wrote:
> On 2025/3/19 00:56, Peter Maydell wrote:
> >
> > ICC_RPR_EL1 is a read-only register.
> 
> Yup! Writes to it should result in an UNDEFINED exception. I completely
> missed that point..
> 
> > But hvf_sysreg_read_cp()
> > and hvf_sysreg_write_cp() do not check the .access field of the
> > ARMCPRegInfo to ensure that they forbid writes to registers that
> > are marked with a .access field that says they're read-only
> > (and ditto reads to write-only registers). So either we should
> > not list ICC_RPR_EL1 in this list in hvf_sysreg_write(), or
> > else we should add the .access checks to hvf_sysreg_read_cp()
> > and hvf_sysreg_write_cp().
> >
> > I would favour the second of those two options, because it's
> > more robust and means we only need to care about the access
> > permissions of a register in one place. Plus we already get
> > this wrong for some registers: for instance ICC_SGI1R_EL1
> > is write-only but we will permit the guest to read it.
> >
> > So I suggest a 2-patch series:
> >  * patch 1: add the checks on .access to hvf_sysreg_read_cp()
> >    and hvf_sysreg_write_cp(): they need to call
> >    cp_access_ok() to check this
> 
> Thanks for your detailed suggestion Peter! I come up with something like
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 650b7f4256..a7ca7975e0 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1264,6 +1264,9 @@ static bool hvf_sysreg_read_cp(CPUState *cpu, uint32_t reg, uint64_t *val)
> 
>      ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
>      if (ri) {
> +        if (!cp_access_ok(arm_current_el(env), ri, true)) {

I wonder if arm_current_el() can be used at it to determine the current
exception EL.

|static inline int arm_current_el(CPUARMState *env)
|{
|    // ...
|
|    if (is_a64(env)) {
|        return extract32(env->pstate, 2, 2);
|    }

I failed to find where env->pstate gets updated on vcpu exit. Please fix
me up if I've missed any obvious points.

> +            return false;
> +        }
>          if (ri->accessfn) {
>              if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
>                  return false;
> @@ -1545,6 +1548,9 @@ static bool hvf_sysreg_write_cp(CPUState *cpu, uint32_t reg, uint64_t val)
>      ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
> 
>      if (ri) {
> +        if (!cp_access_ok(arm_current_el(env), ri, false)) {
> +            return false;
> +        }
>          if (ri->accessfn) {
>              if (ri->accessfn(env, ri, false) != CP_ACCESS_OK) {
>                  return false;

Thanks,
Zenghui

