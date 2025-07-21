Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F99C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 07:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlC1-0001gX-He; Mon, 21 Jul 2025 03:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1udl9M-0000HO-C4
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:41:30 -0400
Received: from sg-1-19.ptr.blmpb.com ([118.26.132.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1udl9A-0002di-PN
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 03:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1753083655;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=wa3RCuAY4MjKRk0lqcNRRb0V56nCIJpB7b0XkTaJ40Q=;
 b=wBUYweQYHNdGhCB1Gld+0zdF5uW1yn5AdY8O0UzpuJCIzMHJ8LJ6frz5XgTXwrFvakVlt9
 gEFtnuActHC8Eo8eNzLESXAlB4qeZbwP4N+Lr6ZwAJY2RK/J4p+0WU3/cND9lSaNKVh3ct
 WUiEx5PELQ5Mf0OK4wrfzD7bXmj39KdEvelXN3aOsxuX86R1pdsrxxxqexLh41YAdYh4bj
 tsOFIVsOCCKxjeqaMA/C2J0rJlzx9u19I45OrBCKDkW0C8BOybIaca9gwcTw1yKEYgjTCj
 29uUfgVhfdf/eg+nLOi1zNfD0P1Xqlynu6J6DDBjYmM+Kd3rWub/XQs0JEObuA==
Content-Language: en-US
Date: Mon, 21 Jul 2025 15:40:51 +0800
Message-Id: <883ca2b3-9054-4578-b46f-efb8d67f32d3@lanxincomputing.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2687def06+5d5add+nongnu.org+liujingqi@lanxincomputing.com>
References: <20250708060720.7030-1-luxu.kernel@bytedance.com>
In-Reply-To: <20250708060720.7030-1-luxu.kernel@bytedance.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Mon, 21 Jul 2025 15:40:53 +0800
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: 7bit
To: "Xu Lu" <luxu.kernel@bytedance.com>, <palmer@dabbelt.com>, 
 <alistair.francis@wdc.com>, <liwei1518@gmail.com>, 
 <zhiwei_liu@linux.alibaba.com>, <apatel@ventanamicro.com>
Cc: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] target/riscv: Fix exception type when VU accesses
 supervisor CSRs
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=118.26.132.19;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-19.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/8/2025 2:07 PM, Xu Lu wrote:
> When supervisor CSRs are accessed from VU-mode, a virtual instruction
> exception should be raised instead of an illegal instruction.
>
> Fixes: c1fbcecb3a (target/riscv: Fix csr number based privilege checking)
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>   target/riscv/csr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8631be97c5..9bebfae3f0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5577,7 +5577,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
>   
>       csr_priv = get_field(csrno, 0x300);
>       if (!env->debugger && (effective_priv < csr_priv)) {
> -        if (csr_priv == (PRV_S + 1) && env->virt_enabled) {
> +        if (csr_priv <= (PRV_S + 1) && env->virt_enabled) {
>               return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>           }
>           return RISCV_EXCP_ILLEGAL_INST;

Reviewed-by: Nutty Liu <liujingqi@lanxincomputing.com>

Thanks,
Nutty

