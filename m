Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C72EC8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUic-000638-0m; Tue, 01 Jul 2025 02:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWUiX-00062W-Up
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:43:45 -0400
Received: from sg-1-22.ptr.blmpb.com ([118.26.132.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWUiL-0005Hh-Mi
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751352191;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=tETfWgbJ709zQxCvjvE0bpy0jjiJnpGnZKpr8dWVvgg=;
 b=3M15RYaM4vJ1t3bCWL4W7WQ8ktNu8i+KFtP8RyDYVva/0pNrQ/Xt1cYUv5NsUwSR5nyVvz
 8fyq+WFYStntYZDZIEujYh0t9BjUqLa3uKAAIEvJjx1AT2enbUXuXsZ16X7lI7jZxVXYi4
 bZJzYr0XsfA/I1c9rbGBc2+JAnxNuOceFPRNOYnRCMNFdeFeU93kMpbbyqCq0eh8Wn143M
 +vm0Nn9NCrONJzPVjFi5+YRf0DGzsqX5F0s2hoxuAOM2460PcCE53VfeuyvZCDr4q25nE6
 KNMNp9bJB16uc/Qft6wcdvVRPQglrH4wxhkq5PK0rorRuqqAkz4OfoJJsypIvQ==
In-Reply-To: <20250627132022.439315-3-max.chou@sifive.com>
User-Agent: Mozilla Thunderbird
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, <antonb@tenstorrent.com>
Date: Tue, 1 Jul 2025 14:43:07 +0800
Message-Id: <69d73c59-2ff6-4446-ac23-c36b0e299afc@lanxincomputing.com>
Content-Transfer-Encoding: 7bit
To: "Max Chou" <max.chou@sifive.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 2/3] target/riscv: rvv: Apply vext_check_input_eew to
 vector reduction instructions
Mime-Version: 1.0
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
References: <20250627132022.439315-1-max.chou@sifive.com>
 <20250627132022.439315-3-max.chou@sifive.com>
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Tue, 01 Jul 2025 14:43:08 +0800
Content-Language: en-US
X-Lms-Return-Path: <lba+26863837d+bb7641+nongnu.org+liujingqi@lanxincomputing.com>
Received-SPF: pass client-ip=118.26.132.22;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-22.ptr.blmpb.com
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

On 6/27/2025 9:20 PM, Max Chou wrote:
> From: Anton Blanchard <antonb@tenstorrent.com>
>
> Handle the overlap of source registers with different EEWs.

Above description is the same as [patch v2 1/3].
They are different functions.
Maybe need to add some different description.

Otherwise,
Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index ec34d0d8c47..ac6f1d04c6d 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3293,6 +3293,7 @@ static bool reduction_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew, a->vm) &&
>              vext_check_reduction(s, a->rs2);
>   }
>   
> @@ -3309,7 +3310,8 @@ GEN_OPIVV_TRANS(vredxor_vs, reduction_check)
>   static bool reduction_widen_check(DisasContext *s, arg_rmrr *a)
>   {
>       return reduction_check(s, a) && (s->sew < MO_64) &&
> -           ((s->sew + 1) <= (s->cfg_ptr->elen >> 4));
> +           ((s->sew + 1) <= (s->cfg_ptr->elen >> 4)) &&
> +           vext_check_input_eew(s, a->rs1, s->sew, a->rs2, s->sew + 1, a->vm);
>   }
>   
>   GEN_OPIVV_WIDEN_TRANS(vwredsum_vs, reduction_widen_check)

