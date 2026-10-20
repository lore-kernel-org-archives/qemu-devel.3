Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26C2606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vmexit.de header.i=@vmexit.de header.a=rsa-sha256 header.s=mail header.b=KOvMdZx6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ6iV-00063b-L0; Tue, 20 Oct 2026 06:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJ6iT-00063L-K3; Tue, 20 Oct 2026 06:05:09 -0400
Received: from vmexit.de ([2a0a:4cc0:c1:d4ba::2] helo=gizmo.vmexit.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ralf@vmexit.de>)
 id 1xJ6iR-0000oK-A4; Tue, 20 Oct 2026 06:05:09 -0400
Message-ID: <75ba3867-3825-4ec5-8efc-02e32065d657@vmexit.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmexit.de; s=mail;
 t=1792490701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+b+5SSs4tNvmQJMvJtLP7EdnbOZuRWcDPtIiywrrX3o=;
 b=KOvMdZx6qviQD/FVowB5g0n/aM1ShcinOLcUAaSaIJRbZDglGGa97UAC8AVMUMzIhmcCCN
 bEVVrYdoxoKULWp3B4juKFpm5A0N6ES0/hXu5qn9O/68bIgofDjNHGQDYJLQTfIKEt5gex
 yow8B76nj/In2vLF/L8s6xVMZ9BEj8k=
Date: Tue, 20 Oct 2026 12:05:00 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] hw/riscv/virt: only describe PLIC contexts that exist
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Bin Meng <bmeng.cn@gmail.com>
References: <20260927231838.236616-1-ralf@vmexit.de>
 <0abd8b75-8fd5-465f-9b67-5fdc161cc14f@oss.qualcomm.com>
From: Ralf Ramsauer <ralf@vmexit.de>
Content-Language: en-US
In-Reply-To: <0abd8b75-8fd5-465f-9b67-5fdc161cc14f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a0a:4cc0:c1:d4ba::2; envelope-from=ralf@vmexit.de;
 helo=gizmo.vmexit.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 9/29/26 01:26, Daniel Henrique Barboza wrote:
> Hello,
> 
> On 9/27/2026 8:18 PM, Ralf Ramsauer wrote:
>> From: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
>>
>> The PLIC device is created from the topology string built by
>> riscv_plic_hart_config_string(), which gives a hart a supervisor context
>> only if that hart actually has supervisor mode.  The device tree, in
>> contrast, lists a machine and a supervisor context for every hart,
>> unconditionally.
>>
>> The two have disagreed since commit 7d10ff8a4d ("hw/riscv: virt: Use the
>> PLIC config helper function") taught the device about harts without
>> S-mode and left the device tree behind.  Boot with
>>
>>      -cpu rv64,s=false,u=false -smp 4
>>
>> and the PLIC implements four contexts while the device tree advertises
>> eight.  Contexts are numbered by their position in 'interrupts-extended',
>> so a guest that takes its context number from the property gets it wrong
>> for every hart but the first: hart 1 drives the context of hart 2, and
>> the upper harts address contexts the PLIC never created.  This is what an
>> M-mode kernel on the virt machine runs into; sifive_u already omits the
>> supervisor entry for its management hart.
>>
>> Emit the supervisor entry only for the harts that have supervisor mode.
>>
>> Fixes: 7d10ff8a4d ("hw/riscv: virt: Use the PLIC config helper function")
>> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
>> ---
>>   hw/riscv/virt.c | 21 +++++++++++++++------
>>   1 file changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index d4b501802f..d0ce9dc862 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -165,14 +165,23 @@ static void 
>> create_fdt_socket_plic(RISCVVirtState *s,
>>               plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
>>           }
>>      } else {
>> -        cells_length = s->soc[socket].num_harts * 4;
>> -        plic_cells = g_new0(uint32_t, cells_length);
>> +        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
>> +        cells_length = 0;
>>           for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
>> -            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
>> -            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
>> -            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
>> -            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
>> +            CPURISCVState *env = &s->soc[socket].harts[cpu].env;

Thanks for the review, sorry for the late reply!

Okay, with your comments, and having the helper in mind, I now see that 
we can also get rid of that nasty if-elsery here, if we did something like:

has_m_mode = !kvm_enable(); // constant for the platform (applies on all 
harts for virt as well as sifive-u, afaict)

plic_cells = num_harts * (has_m_mode ? 4 : 2);
for_each_hart(i) {
   if (has_m_mode) // constant
     fill_m_mode_ctx();

   if (hart_has_supervisor) // dynamic per-hart
     fill_s_mode_ctx(i);
}

And we then have the almost same pattern for sifive_u, besides the fact 
that we always see m-mode there.

Which now could allow us to factor that whole logic out. I'll see what 
we could do here. Will test that, and provide a v2 soonish!

Thanks,
   Ralf

> 
> There are a few things to consider here.  First is that we have a very 
> similar PLIC
> code in the sifive_u.c board.  I believe we want this fix also applied 
> there.
> 
> Second, we should avoid accessing CPU internals in board code.  In an 
> ideal world
> the board would be completely oblivious to what the CPU is about, e.g. 
> its extensions
> and accelerator mode.  In practice we have to account for accelerator 
> differences since
> KVM and TCG requires different stuff w.r.t irq controllers and timers 
> and so on, and
> at least for now this code is being open coded in the boards.
> 
> For the problem you're addressing here I would like to avoid making the 
> board accessing
> the CPU env and checking for RVS.  My suggestion here is:
> 
> - we need a pre-patch that adds a helper in cpu.c that tells whether a 
> CPU has supervisor
> mode.  Something like:
> 
> (cpu.c, could be right after "riscv_cpu_is_vendor")
> 
> bool riscv_cpu_has_supervisor_mode(RISCVCPU *cpu)
> {
> #ifndef CONFIG_USER_ONLY
>      if (kvm_enabled()) {
>          return true;
>      }
> 
>      return riscv_has_ext(&cpu->env, RVS);
> #else
>     return false;
> #endif
> }
> 
> same thing in cpu.h.  The justification for this helper in a separated 
> patch is that
> "next patch needs to verify supervisor mode for CPUs in hw/riscv board 
> code", or
> something around those lines.
> 
> 
> - in this patch you can then do:
> 
> 
>  > +            if (riscv_cpu_has_supervisor_mode(s- 
>  >soc[socket].harts[cpu])) {
>  > +                plic_cells[cells_length++] = 
> cpu_to_be32(intc_phandles[cpu]);
>  > +                plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
>  > +            }
> 
> And we're at least trying to obfuscating the CPU internals from the 
> board a bit.
> 
> 
> And please do the same in sifive_u.c.  Don't need to be in this same 
> patch, so feel
> free to add another patch  just for the sifive_u board.
> 
> 
> Thanks,
> Daniel
> 
>> +
>> +            plic_cells[cells_length++] = 
>> cpu_to_be32(intc_phandles[cpu]);
>> +            plic_cells[cells_length++] = cpu_to_be32(IRQ_M_EXT);
>> +
>> +            /*
>> +             * The PLIC implements a supervisor context only for 
>> harts that
>> +             * have supervisor mode, see 
>> riscv_plic_hart_config_string().
>> +             */
>> +            if (riscv_has_ext(env, RVS)) {
>> +                plic_cells[cells_length++] = 
>> cpu_to_be32(intc_phandles[cpu]);
>> +                plic_cells[cells_length++] = cpu_to_be32(IRQ_S_EXT);
>> +            }
>>           }
>>       }
>>
>> base-commit: 81ce3a87737aa50716c42db8886082d12783e0a1
> 


