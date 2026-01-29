Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7D6D358D1
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 07:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlMDS-00049Z-Df; Thu, 29 Jan 2026 02:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <3160104094@zju.edu.cn>)
 id 1vlMDP-000484-1L
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 02:13:19 -0500
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <3160104094@zju.edu.cn>) id 1vlMDM-0004GS-Mv
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 02:13:18 -0500
Received: from zju.edu.cn (unknown [183.129.171.42])
 by mtasvr (Coremail) with SMTP id _____wC3H4SECHtpsJpWAA--.3793S3;
 Thu, 29 Jan 2026 15:13:09 +0800 (CST)
Received: from [10.138.104.34] (unknown [183.129.171.42])
 by mail-app1 (Coremail) with SMTP id yy_KCgBHUtyDCHtpQPvrBQ--.426S2;
 Thu, 29 Jan 2026 15:13:08 +0800 (CST)
Message-ID: <396462f8-b3f5-4451-9d5e-1ddcad195e43@zju.edu.cn>
Date: Thu, 29 Jan 2026 15:13:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] accel/tcg: Fix uninitialized hostp in
 get_page_addr_code_hostp
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260128010715.347776-1-richard.henderson@linaro.org>
 <20260128010715.347776-3-richard.henderson@linaro.org>
From: Panda Jiang <3160104094@zju.edu.cn>
In-Reply-To: <20260128010715.347776-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: yy_KCgBHUtyDCHtpQPvrBQ--.426S2
X-CM-SenderInfo: qtrwiiiquqmko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?vEbRywXKKxbFmtjJiESix3B1w3sL8hBMFUTpd3cX36+dE6DPAN7iCt/gLhxLJ5hnLg
 KjdW9YdTa8lQerqvWm+lkv19CkQkORVrdSuqcuxMzgZjDs0mKcYwJspWnMG3FgSJ01LWnn
 Bbgdo/WhkMDT8XgLyCgB5rM+H8XhqwExY4Cjs2QP
X-Coremail-Antispam: 1Uk129KBj93XoW7urWxGF1DXFW8tw43CF1ruFX_yoW8ZrWDpF
 W7KrZ0kF95Gw4xt34qqF4xXF1jkrn7GFsrWw1Fkwn8Zw15XFnYqw4qkay0vF4UKrWkZr4j
 yF4aq3WkZFWDA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
 xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
 CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
 xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcV
 AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzWlkUUUU
 U
Received-SPF: pass client-ip=209.97.182.222;
 envelope-from=3160104094@zju.edu.cn;
 helo=zg8tmja5ljk3lje4mi4ymjia.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 1/28/26 9:07 AM, Richard Henderson wrote:
> This uninitialized value violates the contract in the
> documentation comment, and may lead to a SEGV during
> translaton with -d in_asm.
> 
> Change the documentation to disallow hostp NULL.
> Pass hostp to probe_access_internal directly.
> 
> Reported-by: Panda Jiang <3160104094@zju.edu.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hi Richard,

Thanks a lot for the patch!

> ---
>   accel/tcg/internal-common.h | 2 +-
>   accel/tcg/cputlb.c          | 7 +++----
>   accel/tcg/user-exec.c       | 4 +---
>   3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
> ...
> @@ -1545,7 +1545,9 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
>   
>       (void)probe_access_internal(env_cpu(env), addr, 1, MMU_INST_FETCH,
>                                   cpu_mmu_index(env_cpu(env), true), false,
> -                                &p, &full, 0, false);
> +                                hostp, &full, 0, false);
> +
> +    p = *hostp;
>       if (p == NULL) {
>           return -1;
>       }
> ...

I have a small question regarding the implementation choice. My initial
thought was to simply initialize *hostp to NULL at the beginning of
get_page_addr_code_hostp to solve the uninitialized variable issue.

I've been comparing that with your approach of passing 'hostp' directly
into probe_access_internal(). As I see it, the main functional
difference is that in your implementation, if probe_access_internal()
succeeds but the subsequent check
'if (full->lg_page_size < TARGET_PAGE_BITS)' fails, the function
returns -1, but *hostp will hold a valid pointer set by
probe_access_internal(). With the simple initialization approach, *hostp
would always be NULL in any failure case.

Is this behavior intentional? I was wondering if it provides some kind
of performance benefit or gives the caller more context even on this
specific failure path.

Thanks again for the fix!

Best regards,
Panda Jiang



