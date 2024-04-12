Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2A8C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvHgz-0004PT-VV; Fri, 12 Apr 2024 10:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvHgv-0004Op-8P; Fri, 12 Apr 2024 10:15:47 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1rvHgs-0001GY-PG; Fri, 12 Apr 2024 10:15:44 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 8BE6BC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1712931334;
 bh=s5KgHUMnTchmTncqtzelthPVC8GTkKnMtyhK8SjohpM=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=zKLKPE0jzRAXWt7ycxjBQbqiBg0X3tsD0S57LQ+tMk566+N+vz09KnSBIIROCiXzg
 NJDZcaowpkS2oSfMjnepXr672KgvAesKWLNZ3JMGIAsiYJrcxIfRP3vl42WUOq2pnY
 nh6Kfa+ARLvhGezUNMeL6lkPm6EzPD728cxUuNfnxU8VNXHOabJ0TNGT322udjJhah
 XV74l2eknkXhPFsBTF5aOEHiCUd+9/h9qt4onavRv2rdTLnyHZ2TqtwdI6Ryo/BTXo
 7AdhSbF+Y3OV1rioS4Kt8663DmF5R66joB7MQ85+smx/7S01Mc4gOHhgSpXFBRxj0U
 Dk0GL2aFHApFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1712931334;
 bh=s5KgHUMnTchmTncqtzelthPVC8GTkKnMtyhK8SjohpM=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=aLhmsM900vFM0k9NdVW26tizjjluXV/vRQK9RAaam9D8MaTenkkZwTqyw2h1YoWpH
 1nHzivXqB2JFkWfQAf2fDlRc1Qj1vB9HWKu06gXyTxdsT6kIkb66oN9IXvX8ztG+5E
 7kWO9//3SZSYFYRaOIGjIQExamamG9RsIsuPdtYF2XcOzn1pX15UbF/GUHOTnqJxTc
 5lO7Yit7gYrbSbzT900kWwFh+jPqd5IbEbkrYv6Csg0wPnVxlKNgLeu0m6xgsUm59Z
 TRPKR4DJ3l/uJaPVAP82VC7V0NDNk0/kkG36MAfltnKCTbYgulPgPyeo4P1sTONDue
 l7Dx75syV9IaQ==
Message-ID: <a8680fb3-8547-4b68-98d1-fd2d2d278375@syntacore.com>
Date: Fri, 12 Apr 2024 17:15:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <alistair.francis@wdc.com>, <bmeng@tinylab.org>, 
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <palmer@rivosinc.com>, 
 <richard.henderson@linaro.org>, Joseph Chan <jchan@ventanamicro.com>
References: <20240409175241.1297072-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Aleksei Filippov <alexei.filippov@syntacore.com>
Organization: Syntacore
In-Reply-To: <20240409175241.1297072-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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



On 09.04.2024 20:52, Daniel Henrique Barboza wrote:
> raise_mmu_exception(), as is today, is prioritizing guest page faults by
> checking first if virt_enabled && !first_stage, and then considering the
> regular inst/load/store faults.
> 
> There's no mention in the spec about guest page fault being a higher
> priority that PMP faults. In fact, privileged spec section 3.7.1 says:
> 
> "Attempting to fetch an instruction from a PMP region that does not have
> execute permissions raises an instruction access-fault exception.
> Attempting to execute a load or load-reserved instruction which accesses
> a physical address within a PMP region without read permissions raises a
> load access-fault exception. Attempting to execute a store,
> store-conditional, or AMO instruction which accesses a physical address
> within a PMP region without write permissions raises a store
> access-fault exception."
> 
> So, in fact, we're doing it wrong - PMP faults should always be thrown,
> regardless of also being a first or second stage fault.
> 
> The way riscv_cpu_tlb_fill() and get_physical_address() work is
> adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
> reflected in the 'pmp_violation' flag. What we need is to change
> raise_mmu_exception() to prioritize it.
> 
> Reported-by: Joseph Chan <jchan@ventanamicro.com>
> Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU translation stage")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu_helper.c | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index fc090d729a..e3a7797d00 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1176,28 +1176,30 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
> 
>       switch (access_type) {
>       case MMU_INST_FETCH:
> -        if (env->virt_enabled && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
> +        } else if (env->virt_enabled && !first_stage) {
>               cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
>           } else {
> -            cs->exception_index = pmp_violation ?
> -                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;
> +            cs->exception_index = RISCV_EXCP_INST_PAGE_FAULT;
>           }
>           break;
>       case MMU_DATA_LOAD:
> -        if (two_stage && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
> +        } else if (two_stage && !first_stage) {
>               cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
>           } else {
> -            cs->exception_index = pmp_violation ?
> -                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;
> +            cs->exception_index = RISCV_EXCP_LOAD_PAGE_FAULT;
>           }
>           break;
>       case MMU_DATA_STORE:
> -        if (two_stage && !first_stage) {
> +        if (pmp_violation) {
> +            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
> +        } else if (two_stage && !first_stage) {
>               cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
>           } else {
> -            cs->exception_index = pmp_violation ?
> -                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
> -                RISCV_EXCP_STORE_PAGE_FAULT;
> +            cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
>           }
>           break;
>       default:


Just tested your patch and found out that we still need to fix `if else` in
riscv_cpu_tlb_fill() after pmp check in 2 stage translation part, as I suggested
before, cz the problem with mtval2 will happened in case of successes 2 stage
translation but failed pmp check. In this case we gonna set
mtval2(env->guest_phys_fault_addr in context of riscv_cpu_tlb_fill()) as this
was a guest-page-fault, but it didn't and mtval2 should be zero, according to
RISCV privileged spec sect. 9.4.4: When a guest page-fault is taken into M-mode,
mtval2 is written with either zero or guest physical address that faulted,
shifted by 2 bits. *For other traps, mtval2 is set to zero...*
-- 
Sincerely,
Aleksei Filippov

