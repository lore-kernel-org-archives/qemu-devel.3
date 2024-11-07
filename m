Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCC5D43352
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 12:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t91V0-0008TM-GX; Thu, 07 Nov 2024 07:20:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t91Uv-0008Sx-L8
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:20:26 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t91Ut-0007jP-BI
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 07:20:25 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxuuCBsCxnH1k3AA--.44975S3;
 Thu, 07 Nov 2024 20:20:17 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAx18B_sCxn5gVKAA--.2025S3;
 Thu, 07 Nov 2024 20:20:17 +0800 (CST)
Subject: Re: [PATCH 00/10] hw/intc/loongarch_extioi: Split into extioi common
 and extioi
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20240920090507.2692125-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <bc2885d5-5ab4-d24a-62f4-9c4d7c7421cf@loongson.cn>
Date: Thu, 7 Nov 2024 20:21:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240920090507.2692125-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAx18B_sCxn5gVKAA--.2025S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ury5WFyUZF48GFW3Aw15WrX_yoW8AFW5pF
 17Cry3ur48JwnrX3s3K3WUXF98Jrsagry2qF1akryfWrnxCry09348XryfXFyxG3s5t34q
 vw1rWw15WF1DArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
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

ÔÚ 2024/9/20 ÏÂÎç5:04, Bibo Mao Ð´µÀ:
> In order to support irqchip_in_kenrel method, split loongarch extioi
> emulation driver into two parts, extioi common and extioi TCG driver.
> LoongArch extioi common driver includes vmstate and property interface,
> also vmstate load and store interface is defined in extioi common driver.
>
> In future LoongArch extioi kvm driver can inherit from extioi common
> driver.
>
> Bibo Mao (10):
>    include: Add loongarch_extioi_common header file
>    include: Move struct LoongArchExtIOI to header file
>      loongarch_extioi_common
>    include: Rename LoongArchExtIOI with LoongArchExtIOICommonState
>    hw/intc/loongarch_extioi: Rename LoongArchExtIOI with
>      LoongArchExtIOICommonState
>    hw/intc/loongarch_extioi: Add common realize interface
>    hw/intc/loongarch_extioi: Add unrealize interface
>    hw/intc/loongarch_extioi: Add common file loongarch_extioi_common
>    hw/intc/loongarch_extioi: Inherit from loongarch_extioi_common
>    hw/intc/loongarch_extioi: Add pre_save interface
>    hw/intc/loongarch_extioi: Code cleanup about loongarch_extioi
>
>   hw/intc/loongarch_extioi.c                | 110 +++++++--------------
>   hw/intc/loongarch_extioi_common.c         | 113 ++++++++++++++++++++++
>   hw/intc/meson.build                       |   2 +-
>   include/hw/intc/loongarch_extioi.h        |  84 +++-------------
>   include/hw/intc/loongarch_extioi_common.h |  99 +++++++++++++++++++
>   5 files changed, 259 insertions(+), 149 deletions(-)
>   create mode 100644 hw/intc/loongarch_extioi_common.c
>   create mode 100644 include/hw/intc/loongarch_extioi_common.h
>
>
> base-commit: 01dc65a3bc262ab1bec8fe89775e9bbfa627becb
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


