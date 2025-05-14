Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1600C3ABCB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 06:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF5RL-0000si-NY; Wed, 14 May 2025 02:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uF5R9-0000oy-3l
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:17:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uF5R5-0006V4-Ia
 for qemu-devel@nongnu.org; Wed, 14 May 2025 02:17:50 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxnnOANSRouyvmAA--.11820S3;
 Wed, 14 May 2025 14:17:36 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCxPsd8NSRoqcrQAA--.10902S3;
 Wed, 14 May 2025 14:17:35 +0800 (CST)
Subject: Re: [PATCH v4 00/16] hw/intc/loongarch_pch: Cleanup with memory
 region ops
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20250507023148.1877287-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <9a83654a-0956-8833-8355-1f5e5a6d620e@loongson.cn>
Date: Wed, 14 May 2025 14:20:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250507023148.1877287-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCxPsd8NSRoqcrQAA--.10902S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXFyfCF4rZryUCw1fuFy7XFc_yoW5Ww13p3
 95uw1Ykrs7trnrZFZ2y3W8WFZ0k3Z3ury29FsIyrWIkr1fCF1rZrW8J34YvFyUG34xXryq
 qa1UG347X3WDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.146, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/5/7 ÉÏÎç10:31, Bibo Mao Ð´µÀ:
> This series patchset is to clean up with memory regions of loongarch pch
> pic interrupt controller. Originally there are three iomem regions:
> iomem32_low, iomem8, iomem32_highm. Since these regions only support
> 4 bytes/1 byte/4 bytes access, it is divided into three regions.
>
> Now it is merged into one region, this regions supports 1/2/4/8 bytes
> access.
>
> Patch 1-6 is to replace register name, no function change.
> Patch 7-16 is to use unifed memory region iomem, and supports 1/2/4/8
> bytes access with read/write ops for this region, and merge three
> regions above into one.
>
> ---
>    v3 ... v4:
>      1. Use uint8_t rather than bitfield in packed structure since there is
>         different definition about bitfield between gcc and MSVC.
>      2. Rebase patch based on latest version.
>    v2 ... v3:
>      1. Set address aligned with 8 bytes in memory region function
>         pch_pic_read() and pch_pic_write(), and only compare register
>         base address with 8 bytes aligned one.
>      2. Replace 0xff/0xffff with UCHAR_MAX/USHRT_MAX.
>
>    v1 ... v2:
>      1. Add 1/2/4/8 bytes access support with memory region read and
>         write ops.
>      2. Merge three memory regions iomem32_low, iomem8 and iomem32_high
>         into one region iomem.
>      3. Merge trace functions for ops in above three memory regions into
>         one trace function
> ---
> Bibo Mao (16):
>    hw/intc/loongarch_pch: Modify name of some registers
>    hw/intc/loongarch_pch: Modify register name PCH_PIC_xxx_OFFSET with
>      PCH_PIC_xxx
>    hw/intc/loongarch_pch: Remove some duplicate macro
>    hw/intc/loongarch_pch: Set version information at initial stage
>    hw/intc/loongarch_pch: Use relative address in MemoryRegionOps
>    hw/intc/loongarch_pch: Discard write operation with ISR register
>    hw/intc/loongarch_pch: Use generic read callback for iomem32_low
>      region
>    hw/intc/loongarch_pch: Use generic read callback for iomem32_high
>      region
>    hw/intc/loongarch_pch: Use generic read callback for iomem8 region
>    hw/intc/loongarch_pch: Use generic write callback for iomem32_low
>      region
>    hw/intc/loongarch_pch: Use generic write callback for iomem32_high
>      region
>    hw/intc/loongarch_pch: Use generic write callback for iomem8 region
>    hw/intc/loongarch_pch: Use unified trace event for memory region ops
>    hw/intc/loongarch_pch: Rename memory region iomem32_low with iomem
>    hw/intc/loongarch_pch: Set flexible memory access size with iomem
>      region
>    hw/intc/loongarch_pch: Merge three memory region into one
>
>   hw/intc/loongarch_pch_pic.c            | 331 ++++++++-----------------
>   hw/intc/loongarch_pic_common.c         |  13 +
>   hw/intc/trace-events                   |   8 +-
>   hw/loongarch/virt.c                    |   6 -
>   include/hw/intc/loongarch_pic_common.h |  57 ++---
>   5 files changed, 152 insertions(+), 263 deletions(-)
>
Applied to loongarch-next.

thanks.
Song Gao


