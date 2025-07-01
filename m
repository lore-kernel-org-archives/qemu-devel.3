Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0E6C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 03:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWRxV-0005Ml-QN; Mon, 30 Jun 2025 23:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWRxG-000557-EO
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:46:46 -0400
Received: from sg-1-22.ptr.blmpb.com ([118.26.132.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWRwx-00029v-Vm
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 23:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751341563;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ZjBDEG6u0udUnHhJWxtHNgyP4T+dzUhvRivYbx5iq8w=;
 b=PlE3lfEA5jsr5mLyT2/eft4iUrBX9f62kQxjOpOnHtE34ziqnJiFJ+J0N+PWWh4xerk01d
 GLJj7QFKuMdoJ4SL4JpvFJiz1FcQOJPRhfxlOSGM2BKhz2EjiZZCrh8TTgM9Kr79aUx0ST
 FAoYqoIcKWPCx7zAm3ov5WlplUQfEIp7bef3PQ8KqfMeF+Ncd6F8vqmCRj93Yi9gPP5q14
 bE4ZCbz0paULetUftgZ1FEvgkn0bBkaZ3ecMyhbuRofqBaNkuU9visd+bg3oxXsbKXEo5n
 AYIs9Yv/WjkXGITBfIfTEaW5Pwo/HdxG7Pm6c/HnIZq1kts7/9xSKLtMpd2/qg==
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Tue, 01 Jul 2025 11:46:00 +0800
References: <20250701030021.99218-1-jay.chang@sifive.com>
 <20250701030021.99218-3-jay.chang@sifive.com>
Message-Id: <c8a2beb3-6a66-4d63-ac0b-e88c4dc53d64@lanxincomputing.com>
Mime-Version: 1.0
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Subject: Re: [PATCH v3 2/2] target/riscv: Restrict midelegh access to S-mode
 harts
Date: Tue, 1 Jul 2025 11:45:57 +0800
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250701030021.99218-3-jay.chang@sifive.com>
X-Lms-Return-Path: <lba+2686359f9+afc48c+nongnu.org+liujingqi@lanxincomputing.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Frank Chang" <frank.chang@sifive.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: "Jay Chang" <jay.chang@sifive.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Received-SPF: pass client-ip=118.26.132.22;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-22.ptr.blmpb.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> RISC-V AIA Spec states:
> "For a machine-level environment, extension Smaia encompasses all added
> CSRs and all modifications to interrupt response behavior that the AIA
> specifies for a hart, over all privilege levels. For a supervisor-level
> environment, extension Ssaia is essentially the same as Smaia except
> excluding the machine-level CSRs and behavior not directly visible to
> supervisor level."
>
> Since midelegh is an AIA machine-mode CSR, add Smaia extension check in
> aia_smode32 predicate.
>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>   target/riscv/csr.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0e0ad37654..74ec0e1c60 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -374,8 +374,11 @@ static RISCVException aia_smode(CPURISCVState *env, int csrno)
>   static RISCVException aia_smode32(CPURISCVState *env, int csrno)
>   {
>       int ret;
> +    int csr_priv = get_field(csrno, 0x300);
>   
> -    if (!riscv_cpu_cfg(env)->ext_ssaia) {
> +    if (csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    } else if (!riscv_cpu_cfg(env)->ext_ssaia) {

+    if ((csr_priv == PRV_M && !riscv_cpu_cfg(env)->ext_smaia) ||
+        (!riscv_cpu_cfg(env)->ext_ssaia)) {

Would the above code be better ?
Otherwise,
Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

>           return RISCV_EXCP_ILLEGAL_INST;
>       }
>   
> @@ -5911,7 +5914,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_MVIP]     = { "mvip",     aia_any, NULL, NULL, rmw_mvip    },
>   
>       /* Machine-Level High-Half CSRs (AIA) */
> -    [CSR_MIDELEGH] = { "midelegh", aia_any32, NULL, NULL, rmw_midelegh },
> +    [CSR_MIDELEGH] = { "midelegh", aia_smode32, NULL, NULL, rmw_midelegh },
>       [CSR_MIEH]     = { "mieh",     aia_any32, NULL, NULL, rmw_mieh     },
>       [CSR_MVIENH]   = { "mvienh",   aia_any32, NULL, NULL, rmw_mvienh   },
>       [CSR_MVIPH]    = { "mviph",    aia_any32, NULL, NULL, rmw_mviph    },

