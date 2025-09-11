Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819AACAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwh2b-0007UQ-J8; Thu, 11 Sep 2025 09:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uwh2W-0007U0-TJ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:08:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uwh2R-0006zl-PM
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:08:40 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxM9DFycJotz0JAA--.19955S3;
 Thu, 11 Sep 2025 21:08:22 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxTMHDycJophaOAA--.3764S3;
 Thu, 11 Sep 2025 21:08:21 +0800 (CST)
From: gaosong <gaosong@loongson.cn>
Subject: Re: [PATCH v7 02/11] hw/loongarch: add virt feature avecintc and cpu
 feature msgint support
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250910091150.2424979-1-gaosong@loongson.cn>
 <20250910091150.2424979-3-gaosong@loongson.cn>
 <604e9ede-e83c-f433-c96f-e1e341b39171@loongson.cn>
Message-ID: <78e92f8c-c1d4-e4ca-0d27-7c5b524b3529@loongson.cn>
Date: Thu, 11 Sep 2025 21:08:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <604e9ede-e83c-f433-c96f-e1e341b39171@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxTMHDycJophaOAA--.3764S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3ZFW8trWxJr48JryxWry5Jrc_yoW8JrW3Ao
 WUKF1fJr15Jr4jkryDJw17Xry3Jr1UGrnrAryUCry3JF1xtr4UJ34UGryUt3y7tF1kGr1U
 GryUGryjyFy7Ar1rl-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QVy3UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.551,
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

在 2025/9/11 上午9:32, Bibo Mao 写道:
>
>
> On 2025/9/10 下午5:11, Song Gao wrote:
>> Avecintc feature is added in LoongArchVirtMachinState, and it is used
>> to check whether virt machine supports the advanced interrupt controller
>> and by default set avecintc with ON_OFF_AUTO_ON.
>> LoongArchVirtMachineState adds misc_feature and misc_status for misc
>> features and status. and set the default avec feature bit.
>> Msegint feature is added in LoongArchCPU, and it is used to check
>> whether th cpu supports the Message-Interrupts and by default set
>> mesgint with ON_OFF_AUTO_AUTO.
>>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> Reviewed-by: Bibo Mao <maobibo@loongson.cn>
>> ---
>>   hw/loongarch/virt.c                   | 32 +++++++++++++++++++++++++++
>>   include/hw/loongarch/virt.h           | 14 ++++++++++++
>>   target/loongarch/cpu.c                | 29 ++++++++++++++++++++++++
>>   target/loongarch/cpu.h                |  1 +
>>   target/loongarch/loongarch-qmp-cmds.c |  2 +-
>>   5 files changed, 77 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
>> index 31215b7785..37c38ae63f 100644
>> --- a/hw/loongarch/virt.c
>> +++ b/hw/loongarch/virt.c
>> @@ -48,6 +48,27 @@
>>   #include "qemu/error-report.h"
>>   #include "kvm/kvm_loongarch.h"
>>   +static void virt_get_avecintc(Object *obj, Visitor *v, const char 
>> *name,
>> +                             void *opaque, Error **errp)
>> +{
>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
>> +    OnOffAuto avecintc = lvms->avecintc;
>> +
>> +    visit_type_OnOffAuto(v, name, &avecintc, errp);
>> +
>> +}
>> +static void virt_set_avecintc(Object *obj, Visitor *v, const char 
>> *name,
>> +                              void *opaque, Error **errp)
>> +{
>> +    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(obj);
>> +
>> +    visit_type_OnOffAuto(v, name, &lvms->avecintc, errp);
>> +    if (lvms->avecintc == ON_OFF_AUTO_OFF) {
>> +        lvms->misc_feature &= ~BIT(IOCSRF_AVEC);
>> +        lvms->misc_status &= ~BIT(IOCSRM_AVEC_EN);
>> +    }
>> +}
>> +
>>   static void virt_get_veiointc(Object *obj, Visitor *v, const char 
>> *name,
>>                                 void *opaque, Error **errp)
>>   {
>> @@ -692,6 +713,7 @@ static void virt_init(MachineState *machine)
>>       hwaddr base, size, ram_size = machine->ram_size;
>>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>>       Object *cpuobj;
>> +    LoongArchCPU *cpu;
>>         if (!cpu_model) {
>>           cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
>> @@ -717,6 +739,10 @@ static void virt_init(MachineState *machine)
>>           }
>>           qdev_realize_and_unref(DEVICE(cpuobj), NULL, &error_fatal);
>>       }
>> +    cpu = LOONGARCH_CPU(cpuobj);
>> +    if (cpu->msgint != ON_OFF_AUTO_OFF) {
> it works only if  lvms->avecintc == ON_OFF_AUTO_AUTO, there should be 
> error report if lvms->avecintc == ON_OFF_AUTO_ON and cpu->msgint == 
> ON_OFF_AUTO_OFF.
>
emm,  I missing some check here.
>> +        lvms->misc_feature = BIT(IOCSRF_AVEC);
>> +    }
>>       fw_cfg_add_memory(machine);
>>         /* Node0 memory */
>> @@ -847,6 +873,8 @@ static void virt_initfn(Object *obj)
>>       if (tcg_enabled()) {
>>           lvms->veiointc = ON_OFF_AUTO_OFF;
>>       }
>> +
>> +    lvms->avecintc = ON_OFF_AUTO_ON;
> why is it ON_OFF_AUTO_ON rather than ON_OFF_AUTO_AUTO?
>
should be ON_OFF_AUTO_AUTO here.
>>       lvms->acpi = ON_OFF_AUTO_AUTO;
>>       lvms->oem_id = g_strndup(ACPI_BUILD_APPNAME6, 6);
>>       lvms->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
>> @@ -1239,6 +1267,10 @@ static void virt_class_init(ObjectClass *oc, 
>> const void *data)
>>           NULL, NULL);
>>       object_class_property_set_description(oc, "v-eiointc",
>>                               "Enable Virt Extend I/O Interrupt 
>> Controller.");
>> +    object_class_property_add(oc, "avecintc", "OnOffAuto",
>> +        virt_get_avecintc, virt_set_avecintc, NULL, NULL);
>> +    object_class_property_set_description(oc, "avecintc",
>> +                            "Enable Advance Interrupt Controller.");
> I do not object to adding feature in board side, however its name 
> should come from manual. Its name is dmsi rather than avecintc, and 
> this board feature depends on CPU feature msgint.
>
> With TCG mode, there are four conditions:
>   msgint=ON   avecintc=ON                system works
>   msgint=ON   avecintc=OFF               ??            like 3A6000
>   msgint=OFF  avecintc=OFF               system works
>   msgint=OFF  avecintc=ON               system fails
>
With TCG mode, misgint=ON avecintc= OFF  system works.
> With KVM mode, there are combined condition wit host added, especially 
> when host mode is "msgint=ON avecintc=OFF"
>              VM                       Host
>    msgint=ON   avecintc=ON       msgint=ON   avecintc=OFF      ??
>    msgint=ON   avecintc=OFF      msgint=ON   avecintc=OFF      ??
>
I am not sure this case, I think  the guest sytem should work but not 
use avecintc.
> Regards
> Bibo Mao
>
>> machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_UEFI_VARS_SYSBUS);
>>   #ifdef CONFIG_TPM
>> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
>> index 7120b46714..68b8e92e99 100644
>> --- a/include/hw/loongarch/virt.h
>> +++ b/include/hw/loongarch/virt.h
>> @@ -23,6 +23,7 @@
>>   #define IOCSRF_DVFSV1           7
>>   #define IOCSRF_GMOD             9
>>   #define IOCSRF_VM               11
>> +#define IOCSRF_AVEC             15
>>     #define VERSION_REG             0x0
>>   #define FEATURE_REG             0x8
>> @@ -31,6 +32,7 @@
>>   #define MISC_FUNC_REG           0x420
>>   #define IOCSRM_EXTIOI_EN        48
>>   #define IOCSRM_EXTIOI_INT_ENCODE 49
>> +#define IOCSRM_AVEC_EN          51
>>     #define LOONGARCH_MAX_CPUS      256
>>   @@ -69,6 +71,7 @@ struct LoongArchVirtMachineState {
>>       Notifier     powerdown_notifier;
>>       OnOffAuto    acpi;
>>       OnOffAuto    veiointc;
>> +    OnOffAuto    avecintc;
>>       char         *oem_id;
>>       char         *oem_table_id;
>>       DeviceState  *acpi_ged;
>> @@ -84,6 +87,8 @@ struct LoongArchVirtMachineState {
>>       DeviceState *extioi;
>>       struct memmap_entry *memmap_table;
>>       unsigned int memmap_entries;
>> +    uint64_t misc_feature;
>> +    uint64_t misc_status;
>>   };
>>     #define TYPE_LOONGARCH_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
>> @@ -91,6 +96,15 @@ 
>> OBJECT_DECLARE_SIMPLE_TYPE(LoongArchVirtMachineState, 
>> LOONGARCH_VIRT_MACHINE)
>>   void virt_acpi_setup(LoongArchVirtMachineState *lvms);
>>   void virt_fdt_setup(LoongArchVirtMachineState *lvms);
>>   +static inline bool virt_has_avecintc(LoongArchVirtMachineState *lvms)
>> +{
>> +    if (!(lvms->misc_feature & BIT(IOCSRF_AVEC))) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>   static inline bool 
>> virt_is_veiointc_enabled(LoongArchVirtMachineState *lvms)
>>   {
>>       if (lvms->veiointc == ON_OFF_AUTO_OFF) {
>> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
>> index 55ee317bf2..0258bea6df 100644
>> --- a/target/loongarch/cpu.c
>> +++ b/target/loongarch/cpu.c
>> @@ -495,6 +495,31 @@ static void loongarch_set_lasx(Object *obj, bool 
>> value, Error **errp)
>>       cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, value);
>>   }
>>   +static bool loongarch_get_msgint(Object *obj, Error **errp)
>> +{
>> +    return LOONGARCH_CPU(obj)->msgint != ON_OFF_AUTO_OFF;
>> +}
>> +
>> +static void loongarch_set_msgint(Object *obj, bool value, Error **errp)
>> +{
>> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>> +    uint32_t val;
>> +
>> +    cpu->msgint = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>> +
>> +    if (kvm_enabled()) {
>> +        /* kvm feature detection in function kvm_arch_init_vcpu */
>> +        return;
>> +    }
>> +
>> +    val = cpu->env.cpucfg[1];
>> +    if (cpu->msgint == ON_OFF_AUTO_ON) {
> Why it is special for ON_OFF_AUTO_ON? what about with ON_OFF_AUTO_OFF?
> Can user disable this feature?
For TCG ,  user can enable and disable this feature.
For KVM.  enable this feature should depends with host msgint features.
>> +        if (FIELD_EX32(val, CPUCFG1, MSG_INT) == 0) {
> checking with FIELD_EX32(val, CPUCFG1, MSG_INT) == 0 seems unneeded ??
this is for  cpu LA464 which has MSG_INT bit , but not set this bit on 
cpu init,  we allow users enable msgint feature.
>
>
>> +            cpu->env.cpucfg[1]= FIELD_DP32(val, CPUCFG1, MSG_INT, 
>> value);
>> +        }
>> +    }
here should if cpu->msgint == ON_OFF_AUTO_OFF  disable msgint 
feature.and set MSG_INT = 0.

Thanks.
Song Gao.
>> +}
>> +
>>   static void loongarch_cpu_post_init(Object *obj)
>>   {
>>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>> @@ -503,10 +528,14 @@ static void loongarch_cpu_post_init(Object *obj)
>>       cpu->pmu = ON_OFF_AUTO_OFF;
>>       cpu->lsx = ON_OFF_AUTO_AUTO;
>>       cpu->lasx = ON_OFF_AUTO_AUTO;
>> +    cpu->msgint = ON_OFF_AUTO_AUTO;
>> +
>>       object_property_add_bool(obj, "lsx", loongarch_get_lsx,
>>                                loongarch_set_lsx);
>>       object_property_add_bool(obj, "lasx", loongarch_get_lasx,
>>                                loongarch_set_lasx);
>> +    object_property_add_bool(obj, "msgint", loongarch_get_msgint,
>> +                             loongarch_set_msgint);
>>       /* lbt is enabled only in kvm mode, not supported in tcg mode */
>>       if (kvm_enabled()) {
>>           kvm_loongarch_cpu_post_init(cpu);
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index fd3d94b55a..1e8a9dbef8 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -396,6 +396,7 @@ struct ArchCPU {
>>       OnOffAuto pmu;
>>       OnOffAuto lsx;
>>       OnOffAuto lasx;
>> +    OnOffAuto msgint;
>>       OnOffAuto kvm_pv_ipi;
>>       OnOffAuto kvm_steal_time;
>>       int32_t socket_id;  /* socket-id of this CPU */
>> diff --git a/target/loongarch/loongarch-qmp-cmds.c 
>> b/target/loongarch/loongarch-qmp-cmds.c
>> index 1d8cd32f5f..152cd4a551 100644
>> --- a/target/loongarch/loongarch-qmp-cmds.c
>> +++ b/target/loongarch/loongarch-qmp-cmds.c
>> @@ -41,7 +41,7 @@ CpuDefinitionInfoList 
>> *qmp_query_cpu_definitions(Error **errp)
>>   }
>>     static const char *cpu_model_advertised_features[] = {
>> -    "lsx", "lasx", "lbt", "pmu", "kvm-pv-ipi", "kvm-steal-time", NULL
>> +    "lsx", "lasx", "lbt", "pmu", "msgint", "kvm-pv-ipi", 
>> "kvm-steal-time", NULL
>>   };
>>     CpuModelExpansionInfo 
>> *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>


