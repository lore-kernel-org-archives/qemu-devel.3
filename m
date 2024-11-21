Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F068D743FE
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 17:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEBP3-0006LQ-BF; Thu, 21 Nov 2024 12:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1tEBP0-0006Hu-QV
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:55:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1tEBOy-0002dW-AN
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 12:55:38 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 11B9AA9940;
 Thu, 21 Nov 2024 20:55:21 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D6BA1176BD9;
 Thu, 21 Nov 2024 20:55:28 +0300 (MSK)
Message-ID: <50f70ee6-8f84-4685-9ad8-779980804ed8@tls.msk.ru>
Date: Thu, 21 Nov 2024 20:55:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: Enable 1G page support
To: Alexander Graf <agraf@csgraf.de>, qemu-devel@nongnu.org
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 Cameron Esfahani <dirty@apple.com>,
 Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230420225258.58009-1-agraf@csgraf.de>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20230420225258.58009-1-agraf@csgraf.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

21.04.2023 01:52, Alexander Graf wrote:
> Hvf on x86 only supported 2MiB large pages, but never bothered to strip
> out the 1GiB page size capability from -cpu host. With QEMU 8.0.0 this
> became a problem because OVMF started to use 1GiB pages by default.
> 
> Let's just unconditionally add 1GiB page walk support to the walker.
> 
> With this fix applied, I can successfully run OVMF again.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1603
> Signed-off-by: Alexander Graf <agraf@csgraf.de>
> Reported-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Hi!

Is this change not relevant or not needed anymore?
It's been more than 1.5 years already..

(it probably needs to be tweaked for the current state of things,
but I'm surprised there's been nothing at all for such a long time)

/mjt

> On my test VM, Linux dies later on with issues in interrupt delivery. But
> those are unrelated to this patch; I confirmed that I get the same behavior
> with 1GiB page support disabled.
> ---
>   target/i386/hvf/x86_mmu.c | 30 ++++++++++++++++++++----------
>   1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
> index 96d117567e..1d860651c6 100644
> --- a/target/i386/hvf/x86_mmu.c
> +++ b/target/i386/hvf/x86_mmu.c
> @@ -38,6 +38,7 @@
>   #define LEGACY_PTE_PAGE_MASK        (0xffffffffllu << 12)
>   #define PAE_PTE_PAGE_MASK           ((-1llu << 12) & ((1llu << 52) - 1))
>   #define PAE_PTE_LARGE_PAGE_MASK     ((-1llu << (21)) & ((1llu << 52) - 1))
> +#define PAE_PTE_SUPER_PAGE_MASK     ((-1llu << (30)) & ((1llu << 52) - 1))
>   
>   struct gpt_translation {
>       target_ulong  gva;
> @@ -96,7 +97,7 @@ static bool get_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
>   
>   /* test page table entry */
>   static bool test_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
> -                          int level, bool *is_large, bool pae)
> +                          int level, int *largeness, bool pae)
>   {
>       uint64_t pte = pt->pte[level];
>   
> @@ -118,9 +119,9 @@ static bool test_pt_entry(struct CPUState *cpu, struct gpt_translation *pt,
>           goto exit;
>       }
>   
> -    if (1 == level && pte_large_page(pte)) {
> +    if (level && pte_large_page(pte)) {
>           pt->err_code |= MMU_PAGE_PT;
> -        *is_large = true;
> +        *largeness = level;
>       }
>       if (!level) {
>           pt->err_code |= MMU_PAGE_PT;
> @@ -152,9 +153,18 @@ static inline uint64_t pse_pte_to_page(uint64_t pte)
>       return ((pte & 0x1fe000) << 19) | (pte & 0xffc00000);
>   }
>   
> -static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae)
> +static inline uint64_t large_page_gpa(struct gpt_translation *pt, bool pae,
> +                                      int largeness)
>   {
> -    VM_PANIC_ON(!pte_large_page(pt->pte[1]))
> +    VM_PANIC_ON(!pte_large_page(pt->pte[largeness]))
> +
> +    /* 1Gib large page  */
> +    if (pae && largeness == 2) {
> +        return (pt->pte[2] & PAE_PTE_SUPER_PAGE_MASK) | (pt->gva & 0x3fffffff);
> +    }
> +
> +    VM_PANIC_ON(largeness != 1)
> +
>       /* 2Mb large page  */
>       if (pae) {
>           return (pt->pte[1] & PAE_PTE_LARGE_PAGE_MASK) | (pt->gva & 0x1fffff);
> @@ -170,7 +180,7 @@ static bool walk_gpt(struct CPUState *cpu, target_ulong addr, int err_code,
>                        struct gpt_translation *pt, bool pae)
>   {
>       int top_level, level;
> -    bool is_large = false;
> +    int largeness = 0;
>       target_ulong cr3 = rvmcs(cpu->hvf->fd, VMCS_GUEST_CR3);
>       uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
>       
> @@ -186,19 +196,19 @@ static bool walk_gpt(struct CPUState *cpu, target_ulong addr, int err_code,
>       for (level = top_level; level > 0; level--) {
>           get_pt_entry(cpu, pt, level, pae);
>   
> -        if (!test_pt_entry(cpu, pt, level - 1, &is_large, pae)) {
> +        if (!test_pt_entry(cpu, pt, level - 1, &largeness, pae)) {
>               return false;
>           }
>   
> -        if (is_large) {
> +        if (largeness) {
>               break;
>           }
>       }
>   
> -    if (!is_large) {
> +    if (!largeness) {
>           pt->gpa = (pt->pte[0] & page_mask) | (pt->gva & 0xfff);
>       } else {
> -        pt->gpa = large_page_gpa(pt, pae);
> +        pt->gpa = large_page_gpa(pt, pae, largeness);
>       }
>   
>       return true;


