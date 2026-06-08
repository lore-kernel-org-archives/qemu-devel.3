Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60F4CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:03:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWU0P-0004zJ-J7; Mon, 08 Jun 2026 03:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wWU0L-0004yk-5u
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:02:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wWU0I-0001yF-NU
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 03:02:36 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxZngGaSZqhLARAA--.22697S3;
 Mon, 08 Jun 2026 15:02:30 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDxSMECaSZq3XafAA--.25915S3;
 Mon, 08 Jun 2026 15:02:29 +0800 (CST)
Subject: Re: [PATCH v3 00/14] target/loongarch: Move CSR registers to struct
 CPUSysState
To: Bibo Mao <maobibo@loongson.cn>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@mailo.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <20260605082552.175336-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <8018f2ba-3008-dc7e-79d4-0d09dadd84a6@loongson.cn>
Date: Mon, 8 Jun 2026 15:04:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260605082552.175336-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxSMECaSZq3XafAA--.25915S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF1DCFW7JrW3uw45Zw47trc_yoW5Zw4rpr
 yxuwn5KFW8JFZrJF1kXa43Xa4DXr47Gw4293Wftry8C3y5ZryfuF4kJa92gF1UJ348Gry2
 q3WrCw1DZFWUZ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.97, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ÔÚ 2026/6/5 ÏÂÎç4:25, Bibo Mao Ð´µÀ:
> Here new structure CPUSysState is added in CPULoongArchState, CSR
> registers are moved to CPUSysState, qemu timer will be moved to this
> structure in future. With incoming LVZ supported, there will be two copied
> of CSR registers, so it is simply to add CPUSysState array.
>
> Also new field sys_state is added which points to CPUSysState at
> beginning, and it can be changed during VM exit/enter entry. There is no
> function change, all is code movement or variable rename.
>
> ---
> v2 ... v3:
>    1. Modify the spell issue in the comments.
>    2. Change type as unsigned int with return value of function
>       get_csr_offset().
>    2. Split patch 13 into two smaller version, macro CPU_CSR_OFFSET is
>       added special for user mode rdtime emulation in one patch.
>
> v1 ... v2:
>    1. Rename get_current_state with env_sys, variable name cur with sys,
>       since cur/get_current_state is misleading.
>    2. Add modification with files in directory linux-user/loongarch64/
> ---
> Bibo Mao (14):
>    target/loongarch: Add new field curState in CPULoongArchState
>    target/loongarch: Use sys_state in cpu.c when accessing CSR registers
>    target/loongarch: Use sys_state in cpu_helper.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in file arch_dump.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in kvm.c when accessing CSR registers
>    target/loongarch: Use sys_state in tlb_helper.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in tcg_cpu.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in csr_helper.c when accessing CSR
>      registers
>    target/loongarch: Use sys_state in op_helper.c when accessing CSR
>      registers
>    linux-user/loongarch64: Use sys_state when accessing CSR registers
>    target/loongarch: Add default CSRFL_BASIC info with flags field
>    target/loongarch: Add wrapper function get_csr_offset()
>    target/loongarch: Add macro CSR_OFFSET and CPU_CSR_OFFSET
>    target/loongarch: Add new structure CPUSysState
>
>   hw/intc/loongarch_dintc.c                     |   4 +-
>   linux-user/loongarch64/cpu_loop.c             |   5 +-
>   linux-user/loongarch64/elfload.c              |   4 +-
>   linux-user/loongarch64/signal.c               |  16 +-
>   target/loongarch/arch_dump.c                  |   5 +-
>   target/loongarch/cpu-mmu.h                    |   4 +-
>   target/loongarch/cpu.c                        | 120 ++++-----
>   target/loongarch/cpu.h                        |  49 ++--
>   target/loongarch/cpu_helper.c                 |  41 ++--
>   target/loongarch/csr.c                        |  10 +-
>   target/loongarch/csr.h                        |  10 +
>   target/loongarch/gdbstub.c                    |   3 +-
>   target/loongarch/kvm/kvm.c                    | 228 +++++++++---------
>   target/loongarch/machine.c                    | 118 ++++-----
>   target/loongarch/tcg/constant_timer.c         |  10 +-
>   target/loongarch/tcg/csr_helper.c             |  55 +++--
>   .../tcg/insn_trans/trans_extra.c.inc          |   6 +-
>   .../tcg/insn_trans/trans_privileged.c.inc     |  16 +-
>   target/loongarch/tcg/op_helper.c              |  45 ++--
>   target/loongarch/tcg/tcg_cpu.c                | 107 ++++----
>   target/loongarch/tcg/tlb_helper.c             | 137 ++++++-----
>   21 files changed, 549 insertions(+), 444 deletions(-)
>
>
> base-commit: 5611a9268dae7b7ff99d478ed134052a9fc7e9f7
Tested-by: Song Gao <gaosong@loongson.cn>

Applied to loongarch-next.

Thanks.
Song Gao




