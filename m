Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833B9CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 02:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwAWG-0002AM-RL; Tue, 09 Sep 2025 22:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uwAWD-0002A5-TJ
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:25:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uwAWB-0003pn-9z
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:25:09 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxH9N_4cBoxaIIAA--.18250S3;
 Wed, 10 Sep 2025 10:25:03 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDxQ+R+4cBoCVGLAA--.51447S3;
 Wed, 10 Sep 2025 10:25:02 +0800 (CST)
Subject: Re: [PATCH v4 3/3] hw/loongarch/virt: Register reset interface with
 cpu plug callback
To: Bibo Mao <maobibo@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
References: <20250906070200.3749326-1-maobibo@loongson.cn>
 <20250906070200.3749326-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <35933eb0-8597-f0d1-fe26-f5e22a3f3375@loongson.cn>
Date: Wed, 10 Sep 2025 10:28:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250906070200.3749326-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDxQ+R+4cBoCVGLAA--.51447S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw4xZr13XF15WFW5CrW5XFc_yoW5Gr1xpr
 ZrZ3Z0kFs5Jr4DZ3y7tasxZF1kZr1xKr4a9Fn2yF1Fk39rJr1UXr12vF9FvFyUA34FgF1Y
 vrnYk3ZFva15trXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.932, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

ÔÚ 2025/9/6 ÏÂÎç3:02, Bibo Mao Ð´µÀ:
> With cpu hotplug is implemented on LoongArch virt machine, reset
> interface with hot-added CPU should be registered. Otherwise there
> will be problem if system reboots after cpu is hot-added.
>
> Now register reset interface with CPU plug callback, so that all
> cold/hot added CPUs let their reset interface registered. And remove
> reset interface with CPU unplug callback.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/loongarch/boot.c | 13 -------------
>   hw/loongarch/virt.c |  2 ++
>   2 files changed, 2 insertions(+), 13 deletions(-)
Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 5799b4c75c..a516415822 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -350,13 +350,6 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>       return kernel_entry;
>   }
>   
> -static void reset_load_elf(void *opaque)
> -{
> -    LoongArchCPU *cpu = opaque;
> -
> -    cpu_reset(CPU(cpu));
> -}
> -
>   static void fw_cfg_add_kernel_info(struct loongarch_boot_info *info,
>                                      FWCfgState *fw_cfg)
>   {
> @@ -439,12 +432,6 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>   void loongarch_load_kernel(MachineState *ms, struct loongarch_boot_info *info)
>   {
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(ms);
> -    int i;
> -
> -    /* register reset function */
> -    for (i = 0; i < ms->smp.cpus; i++) {
> -        qemu_register_reset(reset_load_elf, LOONGARCH_CPU(qemu_get_cpu(i)));
> -    }
>   
>       info->kernel_filename = ms->kernel_filename;
>       info->kernel_cmdline = ms->kernel_cmdline;
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 31215b7785..bd5cff1f1e 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -1014,6 +1014,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
>       /* Notify acpi ged CPU removed */
>       hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &error_abort);
>   
> +    qemu_unregister_resettable(OBJECT(dev));
>       cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>       cpu_slot->cpu = NULL;
>   }
> @@ -1038,6 +1039,7 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
>                                &error_abort);
>       }
>   
> +    qemu_register_resettable(OBJECT(dev));
>       cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
>       cpu_slot->cpu = CPU(dev);
>   }


