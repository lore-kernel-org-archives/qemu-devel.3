Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B36CCF11F4
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syt3z-0008PE-TI; Thu, 10 Oct 2024 09:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sysdS-00038K-07; Thu, 10 Oct 2024 08:51:18 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexei.filippov@syntacore.com>)
 id 1sysdQ-0005KY-43; Thu, 10 Oct 2024 08:51:17 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 002D3E000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1728564672; bh=iY+sMuUPhCif/8x2KC/os6bw0J2Aj+bQQOCTd+WEx4k=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=zACgJVZezNg77MbGuTBs401fcTR7ssNcJRM/AMNshy/UzuYUXilwU5+j5Dye4Yl6u
 Rw8be1JyZ+kwgCA6h2gVwxWoPpV+MLsogLCtkmrq5jq5MlGZPgqTN4RqwYx/QO1q/C
 L0s0uus5ZK6JrniuyTLZizDyGRs1DJPo0k2oHoxw+U08+mRulhF5S8rHJfp6GWtcYp
 dtPpYVtROLg1JPKbSZ/qoQdv+i5fgmJMuBi9xbJOKTlU9sfRvFTMBBv4txPDqUypaf
 OAQAo6plE7AgcsNZBGx0BXxLN5sI5KXJDuMBEGa0XYdip6KbqYfQ03smUV2tNNkX+m
 tU4ObImP15NIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1728564672; bh=iY+sMuUPhCif/8x2KC/os6bw0J2Aj+bQQOCTd+WEx4k=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=gwApwUzz2JjZRNYbiZwH1yB6vbMrgGwNLyK9PWGfueeCpqG3bzrQ0ze9OpLKMdULP
 k97fWVOr/unF58x6YIuCLvzAJJcVe9iTqk15hOY1vKLRyMaHjKu+tfpB/3WblZsEka
 vyCydeXrxxwXMsFQcIHT0xVk9ruD92YK8Hs2Ep3L6cwPFfzF+QeB6We3WTxHrAnkV7
 Rlrf0yGeLrU74Kwj9mLCz6AhDDMY2iBiD403zVIlFHMyGy3hoL1gj5wU+GBbio04iN
 i4eeFxs9nScEPZ9bqLHUHq5W3OwBCGO7rUlgYYeBaUWFbzuHU/fisGmb0w9Io0vTKr
 KMgRMFBWkr6Ow==
Message-ID: <43613048-ba0b-4fc0-9ee2-b987a6dc86e4@yadro.com>
Date: Thu, 10 Oct 2024 15:51:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] Allow platform specific PMU event encoding
To: Atish Patra <atishp@rivosinc.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>
CC: <alexei.filippov@syntacore.com>, <palmer@dabbelt.com>,
 <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <bin.meng@windriver.com>, <dbarboza@ventanamicro.com>,
 <alistair.francis@wdc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
Content-Language: en-US
From: Alexei Filippov <alexei.filippov@yadro.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=alexei.filippov@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 10 Oct 2024 09:18:37 -0400
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



On 10.10.2024 02:08, Atish Patra wrote:
> Currently, the pmu implementation is virt machine specific that
> implements the SBI PMU encodings. In the future, individual machines
> would want to implement their own custom event encodings as there
> is no standard event encoding defined by the ISA. There is a performance
> events TG which is working on defining standard set of events but not
> encodings. That allows flexibility for platforms to choose whatever
> encoding scheme they want. However, that means the generic pmu code
> should be flexible enough to allow that in Qemu as well.
> 
> This series aims to solve that problem by first disassociating the
> common pmu implementation and event encoding. The event encoding is
> specific to a platform and should be defined in the platform specific
> machine or cpu implementation. The newly defined callbacks can be invoked
> from machine specific cpu implementation or machine code itself depending
> on the requirement.
> 
> The first 5 patches in the series are generic improvements and cleanups
> where as the last 5 actually implements the disassociation for the virt
> machine. The current series can also be found at[2].
> 
> I recently found that Alexei has done a similar effort for SiFive FU740[1]
> but the implementation differs from this one based on how the cpu callbacks
> are invoked. For example, Alexei's series implements a single callback for
> all the events and has defined machine specific counter read/write callbacks.
> However, it just defaults to get_ticks() for every event. IMO, that is
> confusing to the users unless we can actually emulate more generic events or
> machine specific events.
> 
> I have separate callbacks for each type of events that we currently support
> in Qemu (cycle, instruction, TLB events). Separate callbacks seems a better
> approach to avoid ambiguity as we have very limited event capability in qemu.
> I am open to converging them to one callback as well if we think we will
> be extending set of events in the future.
> 
> Once we converge on the approaches, we can consolidate the patches
> so that both SiFive FU740 and virt machine can use the same abstraction.
> 
> Cc: alexei.filippov@syntacore.com
>
Thanks for CCing me and your patch. Your done a great work, but still I 
do not think this approach with per event callback are scalable enough. 
I'll suggest to collaborate to work your and mine solution to unite them 
to one patch set. Let me know what do you think.
> [1] https://lore.kernel.org/all/20240910174747.148141-1-alexei.filippov@syntacore.com/T/
> [2] https://github.com/atishp04/qemu/tree/b4/pmu_event_machine
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
> Atish Patra (10):
>        target/riscv: Fix the hpmevent mask
>        target/riscv: Introduce helper functions for pmu hashtable lookup
>        target/riscv: Protect the hashtable modifications with a lock
>        target/riscv: Use uint64 instead of uint as key
>        target/riscv: Rename the PMU events
>        target/riscv: Define PMU event related structures
>        hw/riscv/virt.c : Disassociate virt PMU events
>        target/riscv: Update event mapping hashtable for invalid events
>        target/riscv : Use the new tlb fill event functions
>        hw/riscv/virt.c: Generate the PMU node from the machine
> 
>   hw/riscv/virt.c           | 102 +++++++++++++++++++++++-
>   target/riscv/cpu.h        |  52 ++++++++++--
>   target/riscv/cpu_bits.h   |   4 +-
>   target/riscv/cpu_helper.c |  21 ++---
>   target/riscv/pmu.c        | 198 +++++++++++++++++++++-------------------------
>   target/riscv/pmu.h        |   3 +-
>   6 files changed, 246 insertions(+), 134 deletions(-)
> ---
> base-commit: 19a9809808a51291008f72d051d0f9b3499fc223
> change-id: 20241008-pmu_event_machine-b87c58104e61
> --
> Regards,
> Atish patra
> 

