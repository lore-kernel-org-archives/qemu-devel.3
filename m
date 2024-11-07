Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C95D43358
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91X0-0000jT-Q8; Thu, 07 Nov 2024 07:22:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t91Wz-0000jH-0b
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:22:33 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t91Ww-00085i-ON
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:22:32 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxG+IEsSxnC1o3AA--.43591S3;
 Thu, 07 Nov 2024 20:22:28 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxDEcDsSxnbgdKAA--.1661S3;
 Thu, 07 Nov 2024 20:22:27 +0800 (CST)
Subject: Re: [PATCH v2 0/8] hw/intc/loongarch_pch: Split into pic common and
 pic
To: Bibo Mao <maobibo@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20240918065426.2341823-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <dc8b7ee1-2fcf-e82e-a684-a80ab9e96c29@loongson.cn>
Date: Thu, 7 Nov 2024 20:23:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240918065426.2341823-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxDEcDsSxnbgdKAA--.1661S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW5KFy7AFy3GF43ZrW5Jwc_yoW8Aw4DpF
 Zxu34agr4kJrnrWrnaqa4UWF95Xrn7W3429F1akryxursxAr1rXw18t34fZFyUK3y5Gry2
 vr1rKw1UW3WDJrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU82g
 43UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.588, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

ÔÚ 2024/9/18 ÏÂÎç2:54, Bibo Mao Ð´µÀ:
> In order to support irqchip_in_kenrel method, split loongarch pch pic
> driver into two parts, pic common and pic TCG driver. LoongArch pic common
> driver includes vmstate and property interface, also vmstate load and
> store interface is defined in pic common driver.
>
> In future LoongArch pic kvm driver can inherit from pic common driver.
>
> ---
> v1 ... v2:
>    1. Reorganize the patchset, put macro and structure moving patch as
>       first one
>    2. Split the patchset with smaller patch, so that it is easier to
>       review
> ---
> Bibo Mao (8):
>    include: Add loongarch_pic_common header file
>    include: Move struct LoongArchPCHPIC to loongarch_pic_common header
>      file
>    hw/intc/loongarch_pch: Merge instance_init() into realize()
>    hw/intc/loongarch_pch: Rename LoongArchPCHPIC with
>      LoongArchPICCommonState
>    hw/intc/loongarch_pch: Move some functions to file
>      loongarch_pic_common
>    hw/intc/loongarch_pch: Inherit from loongarch_pic_common
>    hw/intc/loongarch_pch: Add pre_save and post_load interfaces
>    hw/intc/loongarch_pch: Code cleanup about loongarch_pch_pic
>
>   hw/intc/loongarch_pch_pic.c            | 106 ++++++++-----------------
>   hw/intc/loongarch_pic_common.c         |  97 ++++++++++++++++++++++
>   hw/intc/meson.build                    |   2 +-
>   hw/loongarch/virt.c                    |   2 +-
>   include/hw/intc/loongarch_pch_pic.h    |  70 ++++------------
>   include/hw/intc/loongarch_pic_common.h |  82 +++++++++++++++++++
>   6 files changed, 230 insertions(+), 129 deletions(-)
>   create mode 100644 hw/intc/loongarch_pic_common.c
>   create mode 100644 include/hw/intc/loongarch_pic_common.h
>
>
> base-commit: 2b81c046252fbfb375ad30632362fc16e6e22bd5
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


