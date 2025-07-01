Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988DBC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 03:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWRzc-00075p-Br; Mon, 30 Jun 2025 23:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWRyZ-0005yL-II
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:48:10 -0400
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWRyV-0002zI-Ai
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751341674;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=T744kqp8F+vAcMTM1lypMu4rDENDDT47dC++iAMaxZU=;
 b=Pk61Bttq6A/dCDVg9HqgAhscOnaw0FZx6MUThlDgQ1vhQA/xZMAX4Tz3FukHzaN4C0ny2p
 sJIvtLy5oJv1oSsVkWT5BwHIUEsm9UQ/z8oFEyfI+gbpFm2M0flkAyILLwQ+wiRuN/FnN8
 47c2XFTSJuPUp8Yj9nay9FfoMUqWc4l04p+Ml6hp1RKYcjR8NTk76CwwmF4ohEpUNy8+Nk
 IeeqrU1SWvGKcqKy8o7k3IW3wn/N7ePvsbrU35sZGtuX3OfdwY1lSkzZ5DnH8f24jCE6px
 jI0C0R1TyMKEAtg9Uz28spQ5KzO6wiJw5+jxTQtaY2h+Nym27n536ZB3rdmUfQ==
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Date: Tue, 1 Jul 2025 11:47:49 +0800
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+268635a68+a41bc4+nongnu.org+liujingqi@lanxincomputing.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Frank Chang" <frank.chang@sifive.com>
Message-Id: <fad98061-eceb-4dae-ac7c-5a95bea1d582@lanxincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
In-Reply-To: <20250701030021.99218-2-jay.chang@sifive.com>
Content-Transfer-Encoding: 7bit
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Tue, 01 Jul 2025 11:47:51 +0800
To: "Jay Chang" <jay.chang@sifive.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v3 1/2] target/riscv: Restrict mideleg/medeleg/medelegh
 access to S-mode harts
References: <20250701030021.99218-1-jay.chang@sifive.com>
 <20250701030021.99218-2-jay.chang@sifive.com>
Received-SPF: pass client-ip=118.26.132.17;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-17.ptr.blmpb.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/1/2025 11:00 AM, Jay Chang wrote:
> RISC-V Privileged Spec states:
> "In harts with S-mode, the medeleg and mideleg registers must exist, and
> setting a bit in medeleg or mideleg will delegate the corresponding trap
> , when occurring in S-mode or U-mode, to the S-mode trap handler. In
> harts without S-mode, the medeleg and mideleg registers should not
> exist."
>
> Add smode predicate to ensure these CSRs are only accessible when S-mode
> is supported.
>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>   target/riscv/csr.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6296ecd1e1..0e0ad37654 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5862,8 +5862,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>                             NULL,                read_mstatus_i128           },
>       [CSR_MISA]        = { "misa",       any,   read_misa,    write_misa,
>                             NULL,                read_misa_i128              },
> -    [CSR_MIDELEG]     = { "mideleg",    any,   NULL, NULL,   rmw_mideleg   },
> -    [CSR_MEDELEG]     = { "medeleg",    any,   read_medeleg, write_medeleg },
> +    [CSR_MIDELEG]     = { "mideleg",    smode,   NULL, NULL,   rmw_mideleg   },
> +    [CSR_MEDELEG]     = { "medeleg",    smode,   read_medeleg, write_medeleg },
>       [CSR_MIE]         = { "mie",        any,   NULL, NULL,   rmw_mie       },
>       [CSR_MTVEC]       = { "mtvec",      any,   read_mtvec,   write_mtvec   },
>       [CSR_MCOUNTEREN]  = { "mcounteren", umode, read_mcounteren,
> @@ -5871,7 +5871,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>   
>       [CSR_MSTATUSH]    = { "mstatush",   any32, read_mstatush,
>                             write_mstatush                                   },
> -    [CSR_MEDELEGH]    = { "medelegh",   any32, read_zero, write_ignore,
> +    [CSR_MEDELEGH]    = { "medelegh",   smode32, read_zero, write_ignore,
>                             .min_priv_ver = PRIV_VERSION_1_13_0              },
>       [CSR_HEDELEGH]    = { "hedelegh",   hmode32, read_hedelegh, write_hedelegh,
>                             .min_priv_ver = PRIV_VERSION_1_13_0              },

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

