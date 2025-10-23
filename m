Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD307CCD1AB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 03:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBlnt-0003iZ-7Y; Wed, 22 Oct 2025 23:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vBlnl-0003i3-2r
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 23:15:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vBlni-0001U8-69
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 23:15:44 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxXNLUnflowJgZAA--.55249S3;
 Thu, 23 Oct 2025 11:15:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxicDSnfloNDkCAQ--.20151S3;
 Thu, 23 Oct 2025 11:15:32 +0800 (CST)
Subject: Re: [PATCH v5 00/14] target/loongarch: Add hardware page table walk
 support
To: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20251016015027.1695116-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <f33f4c94-a07a-a9d1-8126-97b5b9307c61@loongson.cn>
Date: Thu, 23 Oct 2025 11:15:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251016015027.1695116-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxicDSnfloNDkCAQ--.20151S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXrWkXr18ZrWkAFWDJryfXwc_yoW5tF45pr
 W7ur1rKrW8trZrArn3XasIgwn5Wr43Gr42q3Wftry8Cw45tryIvF1vy3yvg3WUJ34rWryj
 qF10kw1UuFs8ZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.936, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/10/16 ÉÏÎç9:50, Bibo Mao Ð´µÀ:
> Hardware page table walk (PTW for short) is one feature supported in
> Loongson 3C6000 system. With hardware PTW supported, if there is an TLB
> miss, hardware will take PTW and fill it in TLB if matched, report TLB
> exception if not matched.
>
> With hardware PTW supported, bit Present and Write in pte entry is HW bit.
> Bit Present means that the page is valid, and bit Write means that the
> page is writable. At the same time HW will set bit Valid with read access,
> bit Dirty will be set with write access.
> ---
> v4 ... v5:
>    1. Add common API update_tlb_index() in new patch 11, it is to partly
>       flush QEMU TLB when update LoongArch odd/even TLB entry. And it can
>       be used by both SW/HW PTW hardware.
>    2. Record TLB index if found and update TLB from this index during PTW.
>
> v3 ... v4:
>    1. Rebase the patch on the latest version.
>    2. Set PTW feature disabled on LA464 CPU by default, ON_OFF_AUTO_AUTO
>       on max CPU type.
>    3. Add field tlb_index and mmu_index when searching TLB table in new
>       patch 10
>
> v2 ... v3:
>    1. Reserve high 48-63 bit PTE attribute with huge page, which is
>       discard and converted to physical address wrongly.
>    2. Reload PTE entry rather than restart hardware PTW if PTE entry is
>      updated with other CPUs and qatomic_cmpxchg() fails.
>    3. Since Huge page bit is the same with Global bit, judge huge page from
>       page table level rather than Huge page bit.
>
> v1 ... v2:
>    1. Add wrapper function loongarch_cmpxchg_phys(), and use
>       qatomic_cmpxchg() API to update PTW access/dirty bit.
>    2. Add restart hardware PTW if qatomic_cmpxchg() fails
>    3. Rename loongarch_page_table_walker() with loongarch_ptw().
>    4. Add debug parameter in loongarch_ptw(), with debug mode it is to
>       get physical address only. With normal mode, bit Valid and Dirty
>       will be update.
> ---
> Bibo Mao (14):
>    target/loongarch: Use auto method with PTW feature
>    target/loongarch: Add CSR_PWCH write helper function
>    target/loongarch: Add present and write bit with pte entry
>    target/loongarch: Add function sptw_prepare_tlb before adding tlb
>      entry
>    target/loongarch: target/loongarch: Add common function
>      get_tlb_random_index()
>    target/loongarch: Add MMUContext parameter in fill_tlb_entry()
>    target/loongarch: Add debug parameter with
>      loongarch_page_table_walker()
>    target/loongarch: Reserve higher 48 bit PTE attribute with huge page
>    target/loongarch: Move last PTE lookup into page table walker loop
>    target/loongarch: Add field tlb_index to record TLB search info
>    target/loongarch: Add common interface update_tlb_index()
>    target/loongarch: Add basic hardware PTW support
>    target/loongarch: Update matched ptw bit A/D with PTW supported
>    target/loongarch: Add bit A/D checking in TLB entry with PTW supported
>
>   target/loongarch/cpu-csr.h                    |   4 +
>   target/loongarch/cpu-mmu.h                    |  62 ++++++++
>   target/loongarch/cpu.c                        |  25 +++
>   target/loongarch/cpu.h                        |   2 +
>   target/loongarch/cpu_helper.c                 | 146 ++++++++++++++---
>   target/loongarch/tcg/csr_helper.c             |  15 ++
>   target/loongarch/tcg/helper.h                 |   1 +
>   .../tcg/insn_trans/trans_privileged.c.inc     |   1 +
>   target/loongarch/tcg/tlb_helper.c             | 148 ++++++++++++++----
>   9 files changed, 348 insertions(+), 56 deletions(-)
>
>
> base-commit: 8109ebdb95c45d9062c7e6e7beae0ee571fca4f8

For this series:
Reviewed-by: Song Gao <gaosong@loongson.cn>


Thanks.
Song Gao






