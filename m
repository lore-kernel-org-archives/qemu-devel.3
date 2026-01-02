Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7355FA3729
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 15:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbgiE-00084B-9d; Fri, 02 Jan 2026 10:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vbgi1-0007xG-Jh; Fri, 02 Jan 2026 10:04:59 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vbghy-0001Zz-1B; Fri, 02 Jan 2026 10:04:57 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 602F1nAk032541
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 3 Jan 2026 00:02:56 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1h+hnK3OBi1TOOFX3eCgZtpm9N83bc+D4vaCQwqKoZQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:From:To;
 s=rs20250326; t=1767366176; v=1;
 b=cedcn8hXv8DfGQJZXQ2ab/HHZFuyvLMfQnznz9/e/UiaC03r3irIX3AGpn+mB8TV
 BmzX4cGV1Z22/2On1F6FigZdvd1D5DOtUrmTaTRhENz/58b3L0cRP/f5CLEZ0L6G
 WVXh0JKjQ4MmNalDkm02RwHarXy4Crxf3meGrnZ0lHu6yISJOGtoh5hxGTS+XBMb
 Y/Tfer+2+p9wlOStLu3aSSneW1bsBE/f3fw7ZyAxQz5Qv/72s4YaXSfs6h4I1Veo
 2h3CuKo1wUwl5AIEzw78wNGp+7Ld6h5xI+c+gijPWSJUW/2ZLiJRcA2OHpP16DCy
 GBfT93Oz9QNzisghp5x0/g==
Message-ID: <1806b1fe-c9b0-43d6-8dbf-c5389631f606@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 3 Jan 2026 00:01:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 06/28] hw/arm: virt: cleanly fail on attempt to use
 the platform vGIC together with ITS
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cameron Esfahani
 <dirty@apple.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
 <20251230000401.72124-7-mohamed@unpredictable.fr>
 <f0fc8c7c-50ad-408c-9127-a2404af4f28e@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
In-Reply-To: <f0fc8c7c-50ad-408c-9127-a2404af4f28e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/01/02 19:24, Akihiko Odaki wrote:
> On 2025/12/30 9:03, Mohamed Mediouni wrote:
>> Switch its to a tristate.
>>
>> Windows Hypervisor Platform's vGIC doesn't support ITS.
>> Deal with this by reporting to the user and exiting.
>>
>> Regular configuration: GICv3 + ITS
>> New default configuration with WHPX: GICv3 with GICv2m
>> And its=off explicitly for the newest machine version: GICv3 + GICv2m
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/arm/virt-acpi-build.c | 14 ++++++------
>>   hw/arm/virt.c            | 46 +++++++++++++++++++++++++++++++---------
>>   include/hw/arm/virt.h    |  4 +++-
>>   3 files changed, 46 insertions(+), 18 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 40ea6b6dd5..86024a1a73 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -473,7 +473,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, 
>> VirtMachineState *vms)
>>           nb_nodes = num_smmus + 1; /* RC and SMMUv3 */
>>           rc_mapping_count = rc_smmu_idmaps_len;
>> -        if (vms->its) {
>> +        if (virt_is_its_enabled(vms)) {
>>               /*
>>                * Knowing the ID ranges from the RC to the SMMU, it's 
>> possible to
>>                * determine the ID ranges from RC that go directly to ITS.
>> @@ -484,7 +484,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, 
>> VirtMachineState *vms)
>>               rc_mapping_count += rc_its_idmaps->len;
>>           }
>>       } else {
>> -        if (vms->its) {
>> +        if (virt_is_its_enabled(vms)) {
>>               nb_nodes = 2; /* RC and ITS */
>>               rc_mapping_count = 1; /* Direct map to ITS */
>>           } else {
>> @@ -499,7 +499,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, 
>> VirtMachineState *vms)
>>       build_append_int_noprefix(table_data, IORT_NODE_OFFSET, 4);
>>       build_append_int_noprefix(table_data, 0, 4); /* Reserved */
>> -    if (vms->its) {
>> +    if (virt_is_its_enabled(vms)) {
>>           /* Table 12 ITS Group Format */
>>           build_append_int_noprefix(table_data, 0 /* ITS Group */, 
>> 1); /* Type */
>>           node_size =  20 /* fixed header size */ + 4 /* 1 GIC ITS 
>> Identifier */;
>> @@ -518,7 +518,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, 
>> VirtMachineState *vms)
>>           int smmu_mapping_count, offset_to_id_array;
>>           int irq = sdev->irq;
>> -        if (vms->its) {
>> +        if (virt_is_its_enabled(vms)) {
>>               smmu_mapping_count = 1; /* ITS Group node */
>>               offset_to_id_array = SMMU_V3_ENTRY_SIZE; /* Just after 
>> the header */
>>           } else {
>> @@ -611,7 +611,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, 
>> VirtMachineState *vms)
>>               }
>>           }
>> -        if (vms->its) {
>> +        if (virt_is_its_enabled(vms)) {
>>               /*
>>                * Map bypassed (don't go through the SMMU) RIDs (input) to
>>                * ITS Group node directly: RC -> ITS.
>> @@ -946,7 +946,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, 
>> VirtMachineState *vms)
>>                                             
>> memmap[VIRT_HIGH_GIC_REDIST2].size);
>>           }
>> -        if (vms->its) {
>> +        if (virt_is_its_enabled(vms)) {
>>               /*
>>                * ACPI spec, Revision 6.0 Errata A
>>                * (original 6.0 definition has invalid Length)
>> @@ -962,7 +962,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, 
>> VirtMachineState *vms)
>>           }
>>       }
>> -    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && vms->its)
>> +    if (!(vms->gic_version != VIRT_GIC_VERSION_2 && 
>> virt_is_its_enabled(vms))
>>        && !vms->no_gicv3_with_gicv2m) {
>>           const uint16_t spi_base = vms->irqmap[VIRT_GIC_V2M] + 
>> ARM_SPI_BASE;
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 0fb8dcb07d..dcdb740586 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -737,7 +737,7 @@ static void create_its(VirtMachineState *vms)
>>   {
>>       DeviceState *dev;
>> -    assert(vms->its);
>> +    assert(virt_is_its_enabled(vms));
>>       if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
>>           /*
>>            * Do nothing if ITS is neither supported by the host nor 
>> emulated by
>> @@ -746,6 +746,15 @@ static void create_its(VirtMachineState *vms)
>>           return;
>>       }
>> +    if (whpx_enabled() && vms->tcg_its) {

The check of vms->tcg_its is apparently extraneous and should be removed.

tcg_its is a compatibility flag that tells not to emulate ITS when kvm 
is enabled for old machine versions and has nothing to do with whpx. 
Having vms->tcg_its in the condition lets the machine create ITS for old 
machine versions even if whpx is enabled.

ITS should be disabled whenever whpx is enabled since "ITS is neither 
supported by the host nor emulated by the machine" as the following 
comment points out.

>> +        /*
>> +         * Signal to the user when ITS is neither supported by the host
>> +         * nor emulated by the machine.
>> +         */
>> +        info_report("ITS not supported on WHPX.");
> 
> This use of info_report() is unusual. Any other configuration problems 
> are reported with error_report() in this file. Please maintain consistency.
> 
>> +        exit(1);
>> +    }
>> +
>>       dev = qdev_new(its_class_name());
>>       object_property_set_link(OBJECT(dev), "parent-gicv3", 
>> OBJECT(vms->gic),
>> @@ -957,7 +966,7 @@ static void create_gic(VirtMachineState *vms, 
>> MemoryRegion *mem)
>>       fdt_add_gic_node(vms);
>> -    if (vms->gic_version != VIRT_GIC_VERSION_2 && vms->its) {
>> +    if (vms->gic_version != VIRT_GIC_VERSION_2 && 
>> virt_is_its_enabled(vms)) {
>>           create_its(vms);
>>       } else if (vms->gic_version != VIRT_GIC_VERSION_2 && !vms- 
>> >no_gicv3_with_gicv2m) {
>>           create_v2m(vms);
>> @@ -2699,18 +2708,34 @@ static void virt_set_highmem_mmio_size(Object 
>> *obj, Visitor *v,
>>       extended_memmap[VIRT_HIGH_PCIE_MMIO].size = size;
>>   }
>> -static bool virt_get_its(Object *obj, Error **errp)
>> +bool virt_is_its_enabled(VirtMachineState *vms)
>> +{
>> +    if (vms->its == ON_OFF_AUTO_OFF) {
>> +        return false;
>> +    }
>> +    if (vms->its == ON_OFF_AUTO_AUTO) {
>> +        if (whpx_enabled()) {
>> +            return false;
>> +        }
>> +    }
>> +    return true;
>> +}
>> +
>> +static void virt_get_its(Object *obj, Visitor *v, const char *name,
>> +                          void *opaque, Error **errp)
>>   {
>>       VirtMachineState *vms = VIRT_MACHINE(obj);
>> +    OnOffAuto its = vms->its;
>> -    return vms->its;
>> +    visit_type_OnOffAuto(v, name, &its, errp);
>>   }
>> -static void virt_set_its(Object *obj, bool value, Error **errp)
>> +static void virt_set_its(Object *obj, Visitor *v, const char *name,
>> +                          void *opaque, Error **errp)
>>   {
>>       VirtMachineState *vms = VIRT_MACHINE(obj);
>> -    vms->its = value;
>> +    visit_type_OnOffAuto(v, name, &vms->its, errp);
>>   }
>>   static bool virt_get_dtb_randomness(Object *obj, Error **errp)
>> @@ -3427,8 +3452,9 @@ static void virt_machine_class_init(ObjectClass 
>> *oc, const void *data)
>>                                             "guest CPU which 
>> implements the ARM "
>>                                             "Memory Tagging Extension");
>> -    object_class_property_add_bool(oc, "its", virt_get_its,
>> -                                   virt_set_its);
>> +    object_class_property_add(oc, "its", "OnOffAuto",
>> +        virt_get_its, virt_set_its,
>> +        NULL, NULL);
>>       object_class_property_set_description(oc, "its",
>>                                             "Set on/off to enable/ 
>> disable "
>>                                             "ITS instantiation");
>> @@ -3488,8 +3514,8 @@ static void virt_instance_init(Object *obj)
>>       vms->highmem_mmio = true;
>>       vms->highmem_redists = true;
>> -    /* Default allows ITS instantiation */
>> -    vms->its = true;
>> +    /* Default allows ITS instantiation if available */
>> +    vms->its = ON_OFF_AUTO_AUTO;
>>       /* Allow ITS emulation if the machine version supports it */
>>       vms->tcg_its = !vmc->no_tcg_its;
>>       vms->no_gicv3_with_gicv2m = false;
>> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
>> index c5bc47ee88..394b70c62e 100644
>> --- a/include/hw/arm/virt.h
>> +++ b/include/hw/arm/virt.h
>> @@ -147,7 +147,7 @@ struct VirtMachineState {
>>       bool highmem_ecam;
>>       bool highmem_mmio;
>>       bool highmem_redists;
>> -    bool its;
>> +    OnOffAuto its;
>>       bool tcg_its;
>>       bool virt;
>>       bool ras;
>> @@ -216,4 +216,6 @@ static inline int 
>> virt_gicv3_redist_region_count(VirtMachineState *vms)
>>               vms->highmem_redists) ? 2 : 1;
>>   }
>> +bool virt_is_its_enabled(VirtMachineState *vms);
>> +
>>   #endif /* QEMU_ARM_VIRT_H */
> 


