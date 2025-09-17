Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36E5CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 02:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyhr9-0003ni-0Y; Tue, 16 Sep 2025 22:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uyhqj-0003i1-Dy
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 22:24:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uyhqP-0004BN-Oa
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 22:24:47 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxaNHNG8poOTQLAA--.24235S3;
 Wed, 17 Sep 2025 10:24:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxE+TLG8posH6aAA--.36116S3;
 Wed, 17 Sep 2025 10:24:13 +0800 (CST)
Subject: Re: [PATCH v4 00/13] target/loongarch: Small enhancement about TLB
 flush
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250906070441.3749413-1-maobibo@loongson.cn>
Message-ID: <6b490d7d-9ed8-67a8-652b-c09a6b07f759@loongson.cn>
Date: Wed, 17 Sep 2025 10:22:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250906070441.3749413-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+TLG8posH6aAA--.36116S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tw1xZr4UuFyDuF45tF1xtFc_yoW5JF4xpr
 W7Zry5GFW8ArZxXr1xtas3X34DZr47Gr4Iq3Z3tryrZrsxJryvvFn3t3929Fy5J3yUGr1j
 qF10y3WUZF45Z3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8w0eJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.599,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

ping for reviewing with patch 3/8/11  :)

On 2025/9/6 下午3:04, Bibo Mao wrote:
> This patch set is continuous MMU enhancement, it is focused on TLB
> search, especially on function helper_invtlb_page_asid() and function
> helper_invtlb_page_asid_or_g(). The code is similiar with function
> loongarch_tlb_search(), one common API loongarch_tlb_search_cb() is
> added for these functions.
> 
> Also there is optimization with qemu TLB flush, invalidate_tlb_entry()
> is used to flush one TLB entry rather than flush all TLB entries.
> ---
> v3 ... v4:
>    1. Change return value from bool type to pointer type with function
>       loongarch_tlb_search_cb() in newly added patch 8.
>    2. Modification with code view comments from Richard
> 
> v2 ... v3:
>    1. Remove optimization to flush QEMU TLB with MMU_USER_IDX, now both
>       MMU_KERNEL_IDX and MMU_USER_IDX bitmap is added.
>    2. Add field RESERVE with register CSR_STLBPS, field RESERVE keeps
>       zero when change register CSR_STLBPS.
> 
> v1 ... v2:
>    1. Add bugfix patch with CSR_STLBPS page size set issue.
>    2. Add tlb entry invalidation in function invalidate_tlb(), it can be
>       used in both helper_invtlb_page_asid() and function
>       helper_invtlb_page_asid_or_g().
> ---
> Bibo Mao (13):
>    target/loongarch: Use mmu idx bitmap method when flush TLB
>    target/loongarch: Add parameter tlb pointer with fill_tlb_entry
>    target/loongarch: Reduce TLB flush with helper_tlbwr
>    target/loongarch: Update TLB index selection method
>    target/loongarch: Fix page size set issue with CSR_STLBPS
>    target/loongarch: Add tlb search callback in loongarch_tlb_search()
>    target/loongarch: Add common API loongarch_tlb_search_cb()
>    target/loongarch: Change return value type with
>      loongarch_tlb_search_cb()
>    target/loongarch: Use loongarch_tlb_search_cb in
>      helper_invtlb_page_asid_or_g
>    target/loongarch: Use loongarch_tlb_search_cb in
>      helper_invtlb_page_asid
>    target/loongarch: Invalid tlb entry in invalidate_tlb()
>    target/loongarch: Only flush one TLB entry in
>      helper_invtlb_page_asid_or_g()
>    target/loongarch: Only flush one TLB entry in
>      helper_invtlb_page_asid()
> 
>   target/loongarch/cpu-csr.h        |   1 +
>   target/loongarch/tcg/csr_helper.c |   5 +-
>   target/loongarch/tcg/tlb_helper.c | 205 ++++++++++++++++++------------
>   3 files changed, 131 insertions(+), 80 deletions(-)
> 
> 
> base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
> 


