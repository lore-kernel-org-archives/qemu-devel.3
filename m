Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14139C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 10:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNwH-0004Vv-5a; Thu, 18 Jul 2024 06:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sUNvr-0003CY-UI
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:00:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sUNvo-0003qC-5t
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 06:00:15 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxTOmo55hmlIoAAA--.2763S3;
 Thu, 18 Jul 2024 18:00:08 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxMMSl55hmYKlNAA--.6729S3; 
 Thu, 18 Jul 2024 18:00:07 +0800 (CST)
Subject: Re: [PATCH v4 00/18] Reconstruct loongson ipi driver
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <70323100-002b-803f-8f85-23f1bf32c885@loongson.cn>
Date: Thu, 18 Jul 2024 18:00:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxMMSl55hmYKlNAA--.6729S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr45CrW5Kr4UJr4rtw13Awc_yoW5GryDpF
 1akw1a9r43ury7Crn3KrZ8XFW3CF95ua42vF4aka48ur9xXF10v348GFy5Xay7C345Xryq
 qFyrGryUKF17JrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.124,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2024/7/18 下午4:38, Philippe Mathieu-Daudé 写道:
> Since v3:
> - Use DEFINE_TYPES() macro (unreviewed patch #1)
> - Update MAINTAINERS
> - Added Bibo's tags
>
> Song, since Bibo reviewed/tested, if you provide your
> Acked-by I can queue that to my next hw-misc PR (pending
> Jiaxun testing).
>
> Thanks,
>
> Phil.
>
> Bibo Mao (16):
>    hw/intc/loongson_ipi: Access memory in little endian
>    hw/intc/loongson_ipi: Rename LoongsonIPI -> LoongsonIPIState
>    hw/intc/loongson_ipi: Extract loongson_ipi_common_finalize()
>    hw/intc/loongson_ipi: Extract loongson_ipi_common_realize()
>    hw/intc/loongson_ipi: Add TYPE_LOONGSON_IPI_COMMON stub
>    hw/intc/loongson_ipi: Move common definitions to loongson_ipi_common.h
>    hw/intc/loongson_ipi: Move IPICore::mmio_mem to LoongsonIPIState
>    hw/intc/loongson_ipi: Move IPICore structure to loongson_ipi_common.h
>    hw/intc/loongson_ipi: Pass LoongsonIPICommonState to send_ipi_data()
>    hw/intc/loongson_ipi: Add LoongsonIPICommonClass::get_iocsr_as handler
>    hw/intc/loongson_ipi: Add LoongsonIPICommonClass::cpu_by_arch_id
>      handler
>    hw/intc/loongson_ipi: Expose loongson_ipi_core_read/write helpers
>    hw/intc/loongson_ipi: Move common code to loongson_ipi_common.c
>    hw/intc/loongarch_ipi: Add loongarch IPI support
>    hw/loongarch/virt: Replace loongson IPI with loongarch IPI
>    hw/intc/loongson_ipi: Restrict to MIPS
>
> Philippe Mathieu-Daudé (2):
>    hw/intc/loongson_ipi: Declare QOM types using DEFINE_TYPES() macro
>    hw/intc/loongson_ipi: Remove unused headers
>
>   MAINTAINERS                           |   6 +-
>   include/hw/intc/loongarch_ipi.h       |  25 ++
>   include/hw/intc/loongson_ipi.h        |  50 +---
>   include/hw/intc/loongson_ipi_common.h |  72 ++++++
>   include/hw/loongarch/virt.h           |   1 -
>   hw/intc/loongarch_ipi.c               |  68 +++++
>   hw/intc/loongson_ipi.c                | 355 +++-----------------------
>   hw/intc/loongson_ipi_common.c         | 344 +++++++++++++++++++++++++
>   hw/loongarch/virt.c                   |   4 +-
>   hw/intc/Kconfig                       |   8 +
>   hw/intc/meson.build                   |   2 +
>   hw/loongarch/Kconfig                  |   2 +-
>   12 files changed, 568 insertions(+), 369 deletions(-)
>   create mode 100644 include/hw/intc/loongarch_ipi.h
>   create mode 100644 include/hw/intc/loongson_ipi_common.h
>   create mode 100644 hw/intc/loongarch_ipi.c
>   create mode 100644 hw/intc/loongson_ipi_common.c
>
A build error occurred with patch 15.

sed -i  g/Loongarch/LoongArch/g   *.c and *.h

For this series:
Acked-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


