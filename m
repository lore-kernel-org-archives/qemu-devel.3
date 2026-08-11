Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF9FC5B574
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthBU-0006h2-J4; Tue, 11 Aug 2026 03:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wthBO-0006gR-Nx; Tue, 11 Aug 2026 03:45:59 -0400
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <17746591750@163.com>)
 id 1wthBK-0000Ln-Kq; Tue, 11 Aug 2026 03:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Subject:To:From:Message-ID:Date:MIME-Version:
 Content-Type; bh=Z8rwcxwN7wQC0Pgz/GxqK5M4nF905d7dJUdmyfDu0TI=;
 b=D2MAhjFTNSIdbVa220NFtvakV94pxD2lUm7BDsgCnu5VXnibBX7jAumWDeBWSf
 IicAkguRxV0CHaYIdNE8tIQ8maJQ14hPYyXrljQZHNrTBn4AnOT1xD8ILJkFDY/t
 Gns1QsWaW1E/DZ18+V7dmhvGYyt4c30qA56e47wqWr+74=
Received: from [10.2.10.30] (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDXtukS0npqq8c8NA--.113S2;
 Tue, 11 Aug 2026 15:41:11 +0800 (CST)
Subject: Re: [PATCH 6/9] target/loongarch: Enable disassembly via capstone
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, philmd@mailo.com, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-7-richard.henderson@linaro.org>
From: Song Gao <17746591750@163.com>
Message-ID: <8209e377-df22-8412-1b23-12fa853f0a59@163.com>
Date: Tue, 11 Aug 2026 15:41:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260809013343.664966-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _____wDXtukS0npqq8c8NA--.113S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFWDJw4kJr4xKF4kWw1DGFg_yoW8AF4kpr
 yDCFyfG3y8tr9xGas5ua4a9Fn8Xa1xGr1avFW7uayvyFsI9F4jqw4vk39IvFn8J3y8Ww1I
 9rn3uw1UZF48J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRgyCZUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: jprxlkywvzilivq6il2tof0z/xtbC8hnz-Gp60hmzrwAA3j
Received-SPF: pass client-ip=220.197.31.3; envelope-from=17746591750@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FROM_LOCAL_DIGITS=0.001,
 FROM_LOCAL_HEX=0.006, NICE_REPLY_A=-1.998, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


在 2026/8/9 上午9:33, Richard Henderson 写道:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/disas/capstone.h | 6 ++++++
>   target/loongarch/cpu.c   | 8 ++++++++
>   2 files changed, 14 insertions(+)
Reviewed-by:  Song Gao <17746591750@163.com>

Thanks.
Song Gao
> diff --git a/include/disas/capstone.h b/include/disas/capstone.h
> index db1abe7f70..a922f7627f 100644
> --- a/include/disas/capstone.h
> +++ b/include/disas/capstone.h
> @@ -40,6 +40,12 @@
>   
>   #endif /* CONFIG_CAPSTONE */
>   
> +#if CS_API_MAJOR < 6
> +#define CS_ARCH_LOONGARCH       -1
> +#define CS_MODE_LOONGARCH32      0
> +#define CS_MODE_LOONGARCH64      0
> +#endif
> +
>   #if CS_API_MAJOR < 5
>   #define CS_ARCH_RISCV           -1
>   #define CS_MODE_RISCV32          0
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fb03424ffa..7007622630 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -29,6 +29,7 @@
>   #include <linux/kvm.h>
>   #endif
>   #include "tcg/tcg_loongarch.h"
> +#include "disas/capstone.h"
>   
>   const char * const regnames[32] = {
>       "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
> @@ -694,8 +695,15 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>   static void loongarch_cpu_disas_set_info(const CPUState *cs,
>                                            disassemble_info *info)
>   {
> +    CPULoongArchState *env = cpu_env((CPUState *)cs);
> +
>       info->endian = BFD_ENDIAN_LITTLE;
>       info->print_insn = print_insn_loongarch;
> +
> +    info->cap_arch = CS_ARCH_LOONGARCH;
> +    info->cap_insn_unit = 4;
> +    info->cap_insn_split = 4;
> +    info->cap_mode = is_la64(env) ? CS_MODE_LOONGARCH64 : CS_MODE_LOONGARCH32;
>   }
>   
>   static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)


