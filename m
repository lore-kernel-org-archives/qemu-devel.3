Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6EECA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESe3-0002yJ-CI; Wed, 07 Oct 2026 10:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xEScf-0002pa-Lj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xEScb-0000QA-Vc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 10:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791383271;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LFIezvnLCrW2LRts/Ps2+jrM34IHry8NRwOYanXHl4=;
 b=HKE/z+UZXMhridPEyoOkgsw8Nd6tCP3KjS5VEB8SDgdqkZbouL7VSpdOTLeDQbvMdS1KXT
 t1sogOmvfKaVG3T0wS+rw1/nE93ST/YZXGqUpke30xe54n8HodhilOwFkwK+WD7G5PLSr5
 HEwgZb/5tIlLkpxwIUza3D/ZmlA1QAg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-NceJizv6N2qB3tX0QAUNcw-1; Wed, 07 Oct 2026 10:27:50 -0400
X-MC-Unique: NceJizv6N2qB3tX0QAUNcw-1
X-Mimecast-MFC-AGG-ID: NceJizv6N2qB3tX0QAUNcw_1791383269
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c437ae7dbso1782139f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791383269; x=1791988069;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5LFIezvnLCrW2LRts/Ps2+jrM34IHry8NRwOYanXHl4=;
 b=0Xluvl43TDhtgA0GP5++TVyiG5RT/35mlSAtsZcLLzu6TzIFj98ko5koapkN4Xvj3M
 NTKCHUF52Zx+805ocDGb5MoAer5cRvZfXKszBN+nWcswUx3jfTCftGCgw15FDBOKDQBH
 I6zhM2uVjQFGoybtalPy68savoAhAaTU+7omLgiP41REKElEjQ7lAlJCKGUWi9Qwd2VT
 n08zl9FACoajd4R4CVrhDLUqyjpCAJMRnrt+U9Ydy//F9EVuIaizRCHa/uadKQdOcNY8
 ruTM/lEukblzQM5Tsod/qXhp8c3Oc6Mte+gSbxFBkpbWmCdtC/TbcAbsMtk7rXj7GfhJ
 juKQ==
X-Gm-Message-State: AFq9FYLsFNUIE0j39JLkoFZiw7252dRXYv6kaeHPICBUipD5Eg10zU9B
 QDS7PdhXGfVpMgcQPALhRxPyRVMGs5V/rzoa3pL0F6WrI6ww15ZUGPhK1HaDGiYN16nIg4FdpzK
 dkStDAIMxS22Yj5y72MhBc1Ft4BRs7aK9R3qOuNhu7aHOu8/wInXE7ctEoCjJnR8N+2zW3Ti8sv
 CYsolx6hoLlNI6m1257X9BKzCBm9CWXIzbQrcLlnj+Dzs=
X-Gm-Gg: AYBFou2XTpCCxqRraa9jWgdU/l/3wBDYLqLiYfamdaf/rNDboimvV5gTafoeDMfzsf4
 F97b3zEeUNjqw5JpkvMG7eGKJE9vjmdQRbm3WJbB4PsKLPtQT69gnW3f0K7jhqzj5Fa3nkhDocI
 A1toF8bfzquHniKj6zB0sHYyJYnpaHUCDuyRhzoukY+DAUgnv2K8rT4l2gdOwhsT1ROSC1rNAbD
 MbLqG3RdwbdlEuWfPIJwaDmo2sYnX8b+r3yOl0Xedksu2e6IAPztadMjtPH8FNFccEd3GJpOyCX
 s5FNt9xt9nivJlssMSZxr5MYcfCZ9QrS6IM12CPWYhEjooqnTuA/6Oba9ynMxBwr/oCraMTVU8r
 6Gnxgz/ddYV0pB8PFnjyEenBcBl1g7nX8VO5O+osSUa0rcsKt
X-Received: by 2002:a5d:6f04:0:b0:48c:4274:20d7 with SMTP id
 ffacd0b85a97d-48c688a9a8emr12849241f8f.6.1791383268710; 
 Wed, 07 Oct 2026 07:27:48 -0700 (PDT)
X-Received: by 2002:a5d:6f04:0:b0:48c:4274:20d7 with SMTP id
 ffacd0b85a97d-48c688a9a8emr12849151f8f.6.1791383268061; 
 Wed, 07 Oct 2026 07:27:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71bd7961sm5762490f8f.4.2026.10.07.07.27.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 07:27:47 -0700 (PDT)
Message-ID: <eb51a17c-df3d-4c09-958d-c4ad47183cc2@redhat.com>
Date: Wed, 7 Oct 2026 16:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 25/26] arm-qmp-cmds: introspection for ID register props
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20260916144721.751810-1-eric.auger@redhat.com>
 <20260916144721.751810-26-eric.auger@redhat.com>
 <233CFD50-5E65-47DB-89DC-A5CF27EB46D7@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <233CFD50-5E65-47DB-89DC-A5CF27EB46D7@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Khushit,

On 9/28/26 4:39 PM, Khushit Shah wrote:
>
>> On 16 Sep 2026, at 8:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Enhance the current host model query-cpu-model-expansion with the
>> capability to return SYSREG_* options and also test possible
>> values.
>>
>> If no SYSREG prop is set, query-cpu-model-expansion returns the
>> default host values for all SYSREG properties. They are extracted
>> from a scratch vcpu featuring all the KVM advertised capabilities.
>>
>> Here is a qmp-shell example:
>>
>> (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
>> {"return": {"model": {"name": "host", "props": {"SYSREG_ID_AA64PFR0_EL1_EL3": 1,
>> "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0, "SYSREG_CTR_EL0_L1Ip": 3,
>> "SYSREG_MIDR_EL1_PartNum": 3407, "SYSREG_CTR_EL0_DminLine": 4,
>> "SYSREG_ID_AA64MMFR0_EL1_PARange": 5, "SYSREG_ID_AA64MMFR1_EL1_ECBHB": 0
>> ../..
>>
>> It becomes also possible to test new SYSREG property values.
>>
>> With Full expansion of the host model, the SYSREG props are tested
>> against a scratch vcpu. With static expansion, no check is performed
>> against KVM but only against qemu code (the value does not exceed the
>> field size and if the field is associated to enum values, the set
>> value belongs to the list of arch enum values.
>>
>> Examples
>> (QEMU) query-cpu-model-expansion type=full model={"name":"host","props":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x13}}
>> {"error": {"class": "GenericError", "desc": "idreg SYSREG_ID_AA64ISAR0_EL1_DP set value (0x13) exceeds length of field (4)!"}}
>>
>> (QEMU) query-cpu-model-expansion type=full model={"name":"host","props":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x2}}
>> {"error": {"class": "GenericError", "desc": "idreg SYSREG_ID_AA64ISAR0_EL1_DP set value (0x2) does not match any arch valid enum value!"}}
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>>
>> v8 -> v9:
>> - fix the leak reported by Khushit
>> - implement static mode for host
>>
>> v7 -> v8:
>> - do not check if the prop exists (this is checked elsewhere with a
>>  different error message)
>> - clarify that examples given in the commit msg are based on qmp-shell
>>
>> v5 -> v6:
>> - add the write capability
>> ---
>> target/arm/arm-qmp-cmds.c | 107 ++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 104 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
>> index 83ec95c290..b52ca67f83 100644
>> --- a/target/arm/arm-qmp-cmds.c
>> +++ b/target/arm/arm-qmp-cmds.c
>> @@ -21,6 +21,7 @@
>>  */
>>
>> #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> #include "qemu/target-info.h"
>> #include "hw/core/boards.h"
>> #include "kvm_arm.h"
>> @@ -30,6 +31,7 @@
>> #include "qapi/qapi-commands-machine.h"
>> #include "qapi/qapi-commands-misc-arm.h"
>> #include "qobject/qdict.h"
>> +#include "qobject/qnum.h"
>> #include "qom/qom-qobject.h"
>> #include "cpu.h"
>>
>> @@ -83,15 +85,20 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>                                                      CpuModelInfo *model,
>>                                                      Error **errp)
>> {
>> +    bool use_scratch_vcpu = kvm_enabled() && type == CPU_MODEL_EXPANSION_TYPE_FULL;
>>     CpuModelExpansionInfo *expansion_info;
>> +    ObjectPropertyIterator iter;
>>     const QDict *qdict_in;
>> +    ObjectProperty *idregprop;
>>     QDict *qdict_out;
>>     ObjectClass *oc;
>>     Object *obj;
>>     const char *name;
>> +    int fdarray[3];
>>     int i;
>>
>> -    if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
>> +    /* we support static expansion for host model only */
>> +    if (type != CPU_MODEL_EXPANSION_TYPE_FULL && strcmp(model->name, "host")) {
>>         error_setg(errp, "The requested expansion type is not supported");
>>         return NULL;
>>     }
>> @@ -136,6 +143,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>     if (model->props) {
>>         Visitor *visitor;
>>         Error *err = NULL;
>> +        int fd = -1;
>>
>>         visitor = qobject_input_visitor_new(model->props);
>>         if (!visit_start_struct(visitor, "model.props", NULL, 0, errp)) {
>> @@ -146,6 +154,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>
>>         qdict_in = qobject_to(QDict, model->props);
>>         i = 0;
>> +
>> +        /* Test legacy composite option settings */
>>         while ((name = cpu_model_advertised_features[i++]) != NULL) {
>>             if (qdict_get(qdict_in, name)) {
>>                 if (!object_property_set(obj, name, visitor, &err)) {
>> @@ -154,11 +164,85 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>             }
>>         }
>>
>> +        if (!err) {
>> +            arm_cpu_finalize_features(ARM_CPU(obj), &err);
>> +        }
>> +
>> +        /**
>> +         * Test SYSREG option settings
>> +         * In full mode, build a scratch vcpu that reflects composite legacy
>> +         * options
>> +         */
>> +        if (use_scratch_vcpu) {
>> +            Error *local_err = NULL;
>> +            bool has_virt = object_property_get_bool(OBJECT(current_machine),
>> +                                                     "virtualization",
>> +                                                     &local_err);
>> +
>> +           if (local_err) {
> Hi Eric,
>
> Nit: indentation
sure
>> +                error_free(local_err); /* the machine property does not exist */
>> +            } else {
>> +                if (!has_virt && object_property_find(obj, "has_el2")) {
>> +                    object_property_set_bool(obj, "has_el2", false, NULL);
>> +                }
>> +            }
>> +            fd = kvm_arm_create_init_scratch_vcpu(ARM_CPU(obj), errp);
>> +            if (fd < 0) {
>> +                return NULL;
> Leaks obj/visitor.
Right, I fully revisited the error path
>> +            }
>> +        }
>> +
>> +        qdict_in = qobject_to(QDict, model->props);
>> +        for (const QDictEntry *entry = qdict_first(qdict_in);
>> +                 entry != NULL; entry = qdict_next(qdict_in, entry)) {
>> +            const char *key = qdict_entry_key(entry);
>> +            QObject *val_obj = qdict_entry_value(entry);
>> +            ObjectProperty *prop;
>> +            Visitor *v;
>> +            bool success;
>> +            uint64_t val;
>> +
>> +            prop = object_property_find(obj, key);
>> +
>> +            if (!g_str_has_prefix(key, "SYSREG_")) {
>> +                continue;
>> +            }
>> +
>> +            /* consume the prop to avoid unexpected parameter */
>> +            if (!visit_type_uint64(visitor, key, &val, errp)) {
>> +                goto bail_out;
>> +            }
>> +
>> +            v = qobject_input_visitor_new(val_obj);
>> +
>> +            if (!object_property_set(obj, key, v, errp)) {
>> +                goto bail_out;
>> +            }
>> +
>> +            if (use_scratch_vcpu) {
>> +                ARM64SysRegField *field = (ARM64SysRegField *)prop->opaque;
>> +                uint64_t newfv;
>> +
>> +                if (!visit_type_uint64(v, name, &newfv, errp)) {
> The name is not initialised in this scope… It carries value of last processed legacy prop
damned. now fixed with reusing previously retrieved val
>> +                    visit_free(v);
>> +                    goto bail_out;
>> +                }
>> +                success = kvm_idreg_write_scratch_vcpu(ARM_CPU(obj), fd,
>> +                                                       field, newfv, errp);
>> +                if (!success) {
>> +                    visit_free(v);
>> +                    goto bail_out;
>> +                }
>> +            }
>> +            visit_free(v);
>> +        }
>> +
>>         if (!err) {
>>             visit_check_struct(visitor, &err);
>>         }
>> -        if (!err) {
>> -            arm_cpu_finalize_features(ARM_CPU(obj), &err);
>> +
>> +        if (use_scratch_vcpu) {
>> +            kvm_arm_destroy_scratch_host_vcpu(fdarray);
>>         }
>>         visit_end_struct(visitor, NULL);
>>         visit_free(visitor);
>> @@ -190,6 +274,18 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>         }
>>     }
>>
>> +    object_property_iter_init(&iter, obj);
>> +
>> +    while ((idregprop = object_property_iter_next(&iter))) {
>> +        QObject *value;
>> +
>> +        if (!g_str_has_prefix(idregprop->name, "SYSREG_")) {
>> +            continue;
>> +        }
>> +        value = object_property_get_qobject(obj, idregprop->name, &error_abort);
>> +        qdict_put_obj(qdict_out, idregprop->name, value);
>> +    }
>> +
>>     if (!qdict_size(qdict_out)) {
>>         qobject_unref(qdict_out);
>>     } else {
>> @@ -199,6 +295,11 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>>     object_unref(obj);
>>
>>     return expansion_info;
>> +bail_out:
> Leaks obj.
>> +    if (use_scratch_vcpu) {
>> +        kvm_arm_destroy_scratch_host_vcpu(fdarray);
> fdarray is actually never written to.
also fixed by passing the fdarray as arg of 

kvm_arm_create_init_scratch_vcpu()

Thanks!

Eric

>
> Warm Regards,
> Khushit
>> +    }
>> +    return NULL;
>> }
>>
>> static void arm_cpu_add_definition(gpointer data, gpointer user_data)
>> -- 
>> 2.53.0
>>


