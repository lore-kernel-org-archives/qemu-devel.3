Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B59606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=EV6fW7Fp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQbN1-0005Gf-C4; Mon, 09 Nov 2026 21:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xQbMy-0005Fm-ND; Mon, 09 Nov 2026 21:13:56 -0500
Received: from [115.124.30.111] (helo=out30-111.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1xQbMr-0000eU-N4; Mon, 09 Nov 2026 21:13:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1794276805; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=cq4krLDnjKOaTIwH7WVcvc1++uWNrEfCrMkgQ7Bmh2U=;
 b=EV6fW7FptkyxkayrVH5XvKaU+miJ/G+Zar8EJfG+uGOVH7m9gVIHg1gwMpE5AlJhIOp9p8WORDuvyASw1cOiqMgHR/B8SIaXYQkf5GblsZZgb5WMvzS5ZR6l0gAbSPNbhPpm2i5aQbDnpI0ZQn3rZa0ykkxXiF8VV7ORwmixEz8=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R971e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0XETUN1t_1794276803; 
Received: from 30.166.65.98(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0XETUN1t_1794276803 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 10 Nov 2026 10:13:24 +0800
Message-ID: <cc5fdb8c-0e99-40e8-9c93-ff3a8702d4a9@linux.alibaba.com>
Date: Tue, 10 Nov 2026 10:13:23 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Use gen_goto_tb() for vsetivli exits
To: WX Chen <wxchen0913@gmail.com>, qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.111 (deferred)
Received-SPF: pass client-ip=115.124.30.111;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-111.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-24.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/4/26 1:34 AM, WX Chen wrote:
> This change adjusts the translation exit of `vsetivli`. While preserving
> the existing helper, state update flow, and TB boundaries, it uses the
> generic `gen_goto_tb()` path to reduce the overhead of repeated successor-TB
> lookups.
>
> `vsetivli` is used to set the vector length and type, and both its AVL and
> vtype encodings are provided by immediates. Given the CPU configuration and
> the source TB execution context, after this instruction completes normally,
> the vector state changes relevant to subsequent translation are
> deterministic. Therefore, this exit is eligible for direct TB linking.
>
> Measured on an AMD Ryzen AI 9 H 365 (x86-64) host, using qemu-riscv64
> with -cpu rv64,v=true,vlen=128,elen=64. A RISC-V GCC 14.2.0 cc1 built for
> rv64gcv compiles the packages with -O2 -g0 -march=rv64gcv -mabi=lp64d.
> Only cc1 runs under emulation; make, the compiler driver, assembler and
> linker run on the host.
>
> Each variant is warmed up once, followed by three paired clean builds in
> AB/BA/AB order, using -j1 and fixed host CPU affinity (CPU 7). Median build
> wall times are:
>
>                    Before (s)    After (s)    Wall time reduction
>    LZ4 1.10.0         125.017      123.060                  1.57%
>    zlib 1.3.1          71.062       70.310                  1.06%
>
> In a separate untimed test, a loop executes two vsetivli instructions per
> iteration for 37 iterations. Host-side GDB entry breakpoints show that
> helper_lookup_tb_ptr() entries at the two successor PCs fall from 74 to 0.
> The guest still executes 74 vsetivli instructions. Initial TB dispatch and
> link establishment still occur through the normal dispatcher.
>
> Signed-off-by: WX Chen <wxchen0913@gmail.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei
> ---
>   target/riscv/tcg/insn_trans/trans_rvv.c.inc | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/target/riscv/tcg/insn_trans/trans_rvv.c.inc b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> index a22e2cae6ce8e5a055c106fb76c305c92ac53d3c..b299c82d7a29057433e280b49b5220e6ad71498f 100644
> --- a/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_rvv.c.inc
> @@ -234,8 +234,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
>       gen_helper_vsetvl(dst, tcg_env, s1, s2, tcg_constant_tl(0));
>       gen_set_gpr(s, rd, dst);
>       finalize_rvv_inst(s);
> -    gen_update_pc(s, s->cur_insn_len);
> -    lookup_and_goto_ptr(s);
> +    gen_goto_tb(s, 0, s->cur_insn_len);
>       s->base.is_jmp = DISAS_NORETURN;
>   
>       return true;
>
> ---
> base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
> change-id: 20261104-research-vsetivli-direct-chain-20261103-69536f07be37
>
> Best regards,

