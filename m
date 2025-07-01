Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD35C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUjv-0006YT-RL; Tue, 01 Jul 2025 02:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWUjO-0006MQ-NW
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:44:39 -0400
Received: from sg-3-17.ptr.tlmpb.com ([101.45.255.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWUjH-0005T8-Er
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751352262;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+RWATnOMQAgcgPbpXo+CqAUJzR9cf2W8DwFLMlOXr0A=;
 b=xqmBJYz7IjFlm7VRfK67M2wZcoeOYiQO3giG0bKK7VGF7QaRQr0N1/RPZBg/zlpwdaxabe
 b/a09mUQ8BsHzL7tn3hKzUK0Bjtgp/D0iIruFySpy7vV6sVJB1xJ90m+PgbSr112r1H0Vg
 q/j/jWv3T9rumlF+yZNne1UqLMiW6uNRBVvUsUweQZVwzRQkuqJltDNTTZe+aD92HXrIAC
 JyAU7xg2rRdHyfbBFBNknl0po0H/Vy14PgMz6Y+11ji8EORmN8es+W14VO/90sLnWLX2xE
 VN620z8X/hNugCY1t4ZRpeyCZ/hFuveCA9IsgFUp8q/8Z8krhN6O4+yZmfNW2g==
In-Reply-To: <20250627132022.439315-4-max.chou@sifive.com>
Subject: Re: [PATCH v2 3/3] target/riscv: vadc and vsbc are vm=0 instructions
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Content-Language: en-US
References: <20250627132022.439315-1-max.chou@sifive.com>
 <20250627132022.439315-4-max.chou@sifive.com>
User-Agent: Mozilla Thunderbird
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Tue, 01 Jul 2025 14:44:19 +0800
To: "Max Chou" <max.chou@sifive.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, <antonb@tenstorrent.com>
Date: Tue, 1 Jul 2025 14:44:18 +0800
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Message-Id: <93e9c3c4-a405-4409-a8e7-ff69ac39c977@lanxincomputing.com>
X-Lms-Return-Path: <lba+2686383c4+306335+nongnu.org+liujingqi@lanxincomputing.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=101.45.255.17;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-3-17.ptr.tlmpb.com
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

On 6/27/2025 9:20 PM, Max Chou wrote:
> From: Anton Blanchard <antonb@tenstorrent.com>
>
> We were marking vadc and vsbc as vm=1 instructions, which meant
> vext_check_input_eew wouldn't detect mask vs source register
> overlaps.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/insn32.decode | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index cd23b1f3a9b..5442203ecaa 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -451,14 +451,14 @@ vwsubu_wv       110110 . ..... ..... 010 ..... 1010111 @r_vm
>   vwsubu_wx       110110 . ..... ..... 110 ..... 1010111 @r_vm
>   vwsub_wv        110111 . ..... ..... 010 ..... 1010111 @r_vm
>   vwsub_wx        110111 . ..... ..... 110 ..... 1010111 @r_vm
> -vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_1
> -vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_1
> -vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_1
> +vadc_vvm        010000 0 ..... ..... 000 ..... 1010111 @r_vm_0
> +vadc_vxm        010000 0 ..... ..... 100 ..... 1010111 @r_vm_0
> +vadc_vim        010000 0 ..... ..... 011 ..... 1010111 @r_vm_0
>   vmadc_vvm       010001 . ..... ..... 000 ..... 1010111 @r_vm
>   vmadc_vxm       010001 . ..... ..... 100 ..... 1010111 @r_vm
>   vmadc_vim       010001 . ..... ..... 011 ..... 1010111 @r_vm
> -vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_1
> -vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_1
> +vsbc_vvm        010010 0 ..... ..... 000 ..... 1010111 @r_vm_0
> +vsbc_vxm        010010 0 ..... ..... 100 ..... 1010111 @r_vm_0
>   vmsbc_vvm       010011 . ..... ..... 000 ..... 1010111 @r_vm
>   vmsbc_vxm       010011 . ..... ..... 100 ..... 1010111 @r_vm
>   vand_vv         001001 . ..... ..... 000 ..... 1010111 @r_vm

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

