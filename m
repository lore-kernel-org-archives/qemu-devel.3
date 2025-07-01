Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447B3C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 04:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWSLN-0003Wz-9V; Tue, 01 Jul 2025 00:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWSLL-0003WS-40
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 00:11:39 -0400
Received: from sg-3-18.ptr.tlmpb.com ([101.45.255.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWSLA-0001yl-LE
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 00:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751343070;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=8gIRZ1kwo5Pu64HyhfaR8mZGpB5Y5UAFxFge0JXhLoA=;
 b=HRSNtLf9e7FmduGJP7B4MpQdmiii23sgW0eNYFalzkz+v33tS7mGLOJ01OqhjUcst11Zyg
 +meqzWt68G4vYPNRaWyKRrZIbTfu2/xBuZMx73vsguitgKEaNRWnvVnkiu99gjN6mVzFiQ
 9UbJoKn3z64pugbYupQiXp6ED/dldwW80o8/zmUPu5Lq2oyXaaL+hmiFIbyn8Z7RwsErxc
 AdTWUQxuiqPtzsmml4C2IjoDU7HLhPj5joh+U0m24PX5wz/Jd55eJL0H5LHPvyz9YQwZv0
 WRMtpTxHSofSmXhSNDYqeiQDk03j1LFcBe0ZgrBT17E4Deh1/buvFswWzTw3Ww==
To: "Max Chou" <max.chou@sifive.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Date: Tue, 1 Jul 2025 12:11:05 +0800
References: <20250627132156.440214-1-max.chou@sifive.com>
X-Lms-Return-Path: <lba+268635fdc+e3eda0+nongnu.org+liujingqi@lanxincomputing.com>
Content-Language: en-US
User-Agent: Mozilla Thunderbird
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Subject: Re: [PATCH] target/riscv: rvv: Minimum VLEN needs to respect V/Zve
 extensions
Mime-Version: 1.0
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Tue, 01 Jul 2025 12:11:07 +0800
Content-Transfer-Encoding: 7bit
In-Reply-To: <20250627132156.440214-1-max.chou@sifive.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>
Message-Id: <4dc2ea0e-5869-4913-9cde-bb8e40705ca3@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Received-SPF: pass client-ip=101.45.255.18;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-3-18.ptr.tlmpb.com
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

On 6/27/2025 9:21 PM, Max Chou wrote:
> According to the RISC-V instruction set manual, the minimum VLEN needs
> to respect the following extensions:
>
>    Extension     Minimum VLEN
> * V             128
> * Zve64[d|f|x]   64
> * Zve32[f|x]     32
>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/tcg/tcg-cpu.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 163e7ce3642..187534009dd 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -416,12 +416,21 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
>   static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
>                                    Error **errp)
>   {
> +    uint32_t min_vlen;
>       uint32_t vlen = cfg->vlenb << 3;
>   
> -    if (vlen > RV_VLEN_MAX || vlen < 128) {
> +    if (riscv_has_ext(env, RVV)) {
> +        min_vlen = 128;
> +    } else if (cfg->ext_zve64x) {
> +        min_vlen = 64;
> +    } else if (cfg->ext_zve32x) {
> +        min_vlen = 32;
> +    }
> +
> +    if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
>           error_setg(errp,
>                      "Vector extension implementation only supports VLEN "
> -                   "in the range [128, %d]", RV_VLEN_MAX);
> +                   "in the range [%d, %d]", min_vlen, RV_VLEN_MAX);
>           return;
>       }
>   

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

