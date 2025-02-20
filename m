Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B65C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl3Gs-0002VI-6A; Thu, 20 Feb 2025 04:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tl3Gp-0002Ui-Qs
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:55:03 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tl3Gm-00082y-Fy
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:55:03 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxTWvo+7ZnciJ8AA--.17382S3;
 Thu, 20 Feb 2025 17:54:48 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAxzMTk+7ZncREeAA--.45738S3;
 Thu, 20 Feb 2025 17:54:47 +0800 (CST)
Subject: Re: [PATCH v5 0/7] hw/loongarch/virt: Add cpu hotplug support
From: bibo mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20250211030834.3276732-1-maobibo@loongson.cn>
Message-ID: <1ef6ae3a-2513-8eb8-b97e-707faf2c7bd4@loongson.cn>
Date: Thu, 20 Feb 2025 17:54:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250211030834.3276732-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMTk+7ZncREeAA--.45738S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr13KrykCF4xuw48KF17urX_yoW5Ar48pr
 W3ArsxtFyUJrZ7A3ySya4ruFn0gr1kGw42v3WfAry0kw4agr1Fvr10yF98ZFWak340vFW8
 Xw1rKw1UZF1UJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.124,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Slightly ping.
Hope to merge to qemu 10.0 if possible :)

Regards
Bibo Mao

On 2025/2/11 上午11:08, Bibo Mao wrote:
> LoongArch cpu hotplug is based on ACPI GED device, it depends on
> patchset where TYPE_HOTPLUG_HANDLER interface is added in ipi and extioi
> interrupt controller class for cpu hotplug event notification.
>    https://lore.kernel.org/qemu-devel/0d920309-c7ba-48d8-b46d-04ac1e38efc7@linaro.org/T/#t
> 
> It can be verified with qemu command:
>    qemu-system-loongarch64 -smp 2,maxcpus=16,sockets=4,cores=4,threads=1
> and vcpu can be added or remove with hmp command:
>    device_add la464-loongarch-cpu,socket-id=0,core-id=2,thread-id=0,id=cpu-2
>    device_del cpu-2
> 
> ---
> v4 ... v5:
>    1. Use new calculation logic about physical cpu id, the max core-id and
>       thread-id is aligned up with power of 2.
>    2. Remove num-cpu property with ipi and extioi interrupt controller,
>       TYPE_HOTPLUG_HANDLER interface is added with the interrupt
>       controllers for cpu hotplug event notification.
>   
> v3 ... v4:
>    1. For cold-plug CPUs, move socket-id/core-id/thread-id property
>       setting from preplug function to CPU object creating loop, since
>       there is topo information calculation already in CPU object creating
>       loop.
>    2. Init interrupt pin of CPU object in cpu plug interface for both
>       cold-plug CPUs and hot-plug CPUs.
>    3. Apply the patch based on latest qemu version.
> 
> v2 ... v3:
>    1. Use qdev_realize_and_unref() with qdev_realize() and object_unref().
>    2. Set vcpus_count with 1 since vcpu object is created for every thread.
>    3. Remove property hw-id, use internal variable hw_id to differentiate
>       cold-plug cpus and hot-plug cpus.
>    4. Add generic function virt_init_cpu_irq() to init interrupt pin
>       of CPU object, used by both cold-plug and hot-plug CPUs
> 
> v1 ... v2:
>    1. Add new property hw-id, property hw-id is set for cold-added CPUs,
>       and property socket-id/core-id/thread-id is set for hot-added CPUs.
>       The two properties can be generated from each other.
>    2. Use general hotplug api such as hotplug_handler_pre_plug etc
>    3. Reorganize the patch order, split the patch set into 4 small
>       patches.
> ---
> Bibo Mao (7):
>    hw/loongarch/virt: Add CPU topology support
>    hw/loongarch/virt: Add topo properties on CPU object
>    hw/loongarch/virt: Add basic cpu plug interface framework
>    hw/loongarch/virt: Implement cpu unplug interface
>    hw/loongarch/virt: Implement cpu plug interface
>    hw/loongarch/virt: Update the ACPI table for hotplug cpu
>    hw/loongarch/virt: Enable cpu hotplug feature on virt machine
> 
>   hw/loongarch/Kconfig           |   1 +
>   hw/loongarch/virt-acpi-build.c |  35 +++-
>   hw/loongarch/virt.c            | 284 ++++++++++++++++++++++++++++++---
>   include/hw/loongarch/virt.h    |   1 +
>   target/loongarch/cpu.c         |  23 +++
>   target/loongarch/cpu.h         |  11 ++
>   6 files changed, 333 insertions(+), 22 deletions(-)
> 


