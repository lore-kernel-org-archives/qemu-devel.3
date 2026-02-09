Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C9FE81BDC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTkn-0000Ru-BB; Mon, 09 Feb 2026 11:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpTki-0000R9-40
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpTkf-0006DS-If
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770653080;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GVH3rPbA4rJFSC+QYvCvZV5hBIq40IFFJc//1ksNAOU=;
 b=Enpo6kSxEPKzp7z5Ev3V6hf1AfqLbsfhgy5evnpjcCwydUvGSj/wpahi+Xuxd7a460or2b
 CB/FiwuYsVTNPvo7WBzefL0CXV39urWuF1hkkhqWZLKmAyYgJ7E+yNh3Acme00Vm8axjV3
 FmEDm+1Fr+iRR8mNYqAukB+14oWZxFs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-3aOlEuJwO8uXBW_vjsWfBA-1; Mon, 09 Feb 2026 11:04:39 -0500
X-MC-Unique: 3aOlEuJwO8uXBW_vjsWfBA-1
X-Mimecast-MFC-AGG-ID: 3aOlEuJwO8uXBW_vjsWfBA_1770653078
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4801bceb317so63129705e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770653078; x=1771257878;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVH3rPbA4rJFSC+QYvCvZV5hBIq40IFFJc//1ksNAOU=;
 b=apCbY/l/BRffitk3tF2nN38jIugf//c4GdzRuKauC6/TaY3ebs7A4kezu3snlmMXCD
 QUfjbNp1KNfYQyDEYciGmgR5B6116jnySytKRstiyIMGlhh8p/rARr80utke/4SBeeDv
 V7SmLgiG/aHxfN/90Ym2O7nSPdcpTbJvZX8PtFSf+XCHW6dgCSiGWE20kMJecKcaxXI7
 xyJa2ADN/tawGBMNznP+UrQx0BymiGAZg3Z3po1Rg9RogR9A9OmjWIMGpnW8XCOaMPa+
 lrI5lgnbDAP7BLEy5D2SuUi9H0i5dBaBbOyjpQHptzIsuK0Njh/M1W8aIEJ/VBk4pJ5+
 tMNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIt7XTxwoiEgjaBaDnwCoLSavomauA7a5W3RO2sfO0L6aMZkDD8Mf5yqoLayKfXMEYGBoPclPLgh7T@nongnu.org
X-Gm-Message-State: AOJu0Yzop4fSVrJBEsX+4tD9r33ROQSokIZQi475LR+DThwfKDkFfOup
 h+KH7HWuFIwBh5F2TR+S2QLEygkqOuUio8qf3de1cBR/TfM4V0Aw3ai5wnsyIkmlenFihgHOIwh
 Bmy0Y4lWjMZi06NCAzMhyhYEYy1rI/IshWKNlX9hXjFnyNpN+7blgX2G2
X-Gm-Gg: AZuq6aKQ676boYFqPRfexBG6oJYhdyreY4zJHjTX3OKPvHuv28fVbvp1E8AHpa/sp5y
 4vlyu9oSKn0kWyI1ipYELDxWoknACN2R583bFKkKs0afdphv6FZQCdGr5FQ/Nv4fVA1jW9KhRNa
 YOYgbKaAT6rkci83ozecBQUDDzALlOuq5GmJaGXm4Cd4yktkEf4VTmlPXDV8grUU3zTkRQBx/X4
 JOK52WUoGGnqsnWF5hSGCmvqmqUzQhkb1j2o3EnC4jQ6ygmeBo/bxxdrfSabpck5b4pnBMQVHJ3
 pQOk0p4vaDcx5SpKNuGvRRuiwEYJhoadZb5bSQBi6AL0XTccBMkl4Eki7G/sp2h3KIWEDe53quK
 xjJcOPnTTMNFiP7IMuVdGijZUfiV2iTvgbzEwQjXGRujnUy/K30G8ZOHoxQBGeR3ECoiTYw==
X-Received: by 2002:a05:600c:6289:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-483203393b7mr184571275e9.33.1770653077485; 
 Mon, 09 Feb 2026 08:04:37 -0800 (PST)
X-Received: by 2002:a05:600c:6289:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-483203393b7mr184570675e9.33.1770653076890; 
 Mon, 09 Feb 2026 08:04:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320638ff7sm260791625e9.0.2026.02.09.08.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 08:04:36 -0800 (PST)
Message-ID: <2c8a333d-f4eb-442d-ab2f-5545ad915f6d@redhat.com>
Date: Mon, 9 Feb 2026 17:04:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] target/arm/machine: Improve traces on register
 mismatch during migration
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-3-eric.auger@redhat.com>
 <87bjhyymx6.fsf@draig.linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87bjhyymx6.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Alex,

On 2/9/26 4:08 PM, Alex Bennée wrote:
> Eric Auger <eric.auger@redhat.com> writes:
>
>> Currently when the number of KVM registers exposed by the source is
>> larger than the one exposed on the destination, the migration fails
>> with: "failed to load cpu:cpreg_vmstate_array_len"
>>
>> This gives no information about which registers are causing the trouble.
>>
>> This patch reworks the target/arm/machine code so that it becomes
>> able to handle an input stream with a larger set of registers than
>> the destination and print useful information about which registers
>> are causing the trouble. The migration outcome is unchanged:
>> - unexpected registers still will fail the migration
>> - missing ones are printed but will not fail the migration, as done today.
>>
>> The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
>> registers compared to what exists on the target.
>>
>> If there are more registers we will still hit the previous
>> "load cpu:cpreg_vmstate_array_len" error.
>>
>> At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
>> and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are printed.
>>
>> Example:
>>
>> qemu-system-aarch64: kvm_arm_cpu_post_load Missing register in input stream: 0 0x6030000000160003 fw feat reg 3
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 0 0x603000000013c103 op0:3 op1:0 crn:2 crm:0 op2:3
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 1 0x603000000013c512 op0:3 op1:0 crn:10 crm:2 op2:2
>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 2 0x603000000013c513 op0:3 op1:0 crn:10 crm:2 op2:3
>> qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
>> qemu-system-aarch64: load of migration failed: Operation not permitted
>>
>> With TCG there is no user friendly formatting of the faulting
>> register indexes as with KVM. However the 2 added trace points
>> help to identify the culprit indexes.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>>
>> v2 -> v3:
>> - some extra typos (Connie)
>> - collected Connie's R-b
>>
>> v1 -> v2:
>> - fixed some type in the commit msg
>> ---
>>  target/arm/cpu.h        |  6 +++++
>>  target/arm/kvm.c        | 23 ++++++++++++++++
>>  target/arm/machine.c    | 58 ++++++++++++++++++++++++++++++++++++-----
>>  target/arm/trace-events |  7 +++++
>>  4 files changed, 88 insertions(+), 6 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 1eaf5a3fddf..e900ef7937b 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -939,6 +939,12 @@ struct ArchCPU {
>>      uint64_t *cpreg_vmstate_values;
>>      int32_t cpreg_vmstate_array_len;
>>  
>> +    #define MAX_CPREG_VMSTATE_ANOMALIES 10
>> +    uint64_t cpreg_vmstate_missing_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
>> +    int32_t cpreg_vmstate_missing_indexes_array_len;
>> +    uint64_t cpreg_vmstate_unexpected_indexes[MAX_CPREG_VMSTATE_ANOMALIES];
>> +    int32_t cpreg_vmstate_unexpected_indexes_array_len;
>> +
> This seems a bit old school when we have GArray.

thanks for jumping in. Agreed. if we manage to have a generic TCG/KVM 

print_register_name() I hope those can even be removed.

Thanks!

Eric

>
>>      DynamicGDBFeatureInfo dyn_sysreg_feature;
>>      DynamicGDBFeatureInfo dyn_svereg_feature;
>>      DynamicGDBFeatureInfo dyn_smereg_feature;
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 48f853fff80..c6f0d0fc4e1 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -1024,6 +1024,29 @@ void kvm_arm_cpu_pre_save(ARMCPU *cpu)
>>  
>>  bool kvm_arm_cpu_post_load(ARMCPU *cpu)
>>  {
>> +    int i;
>> +
>> +    for (i = 0; i < cpu->cpreg_vmstate_missing_indexes_array_len; i++) {
>> +        gchar *name;
>> +
>> +        name = kvm_print_register_name(cpu->cpreg_vmstate_missing_indexes[i]);
>> +        trace_kvm_arm_cpu_post_load_missing_reg(name);
>> +        g_free(name);
>> +    }
>> +
>> +    for (i = 0; i < cpu->cpreg_vmstate_unexpected_indexes_array_len; i++) {
>> +        gchar *name;
>> +
>> +        name = kvm_print_register_name(cpu->cpreg_vmstate_unexpected_indexes[i]);
>> +        error_report("%s Unexpected register in input stream: %i 0x%"PRIx64" %s",
>> +                     __func__, i, cpu->cpreg_vmstate_unexpected_indexes[i], name);
>> +        g_free(name);
>> +    }
>> +    /* Fail the migration if we detect unexpected registers */
>> +    if (cpu->cpreg_vmstate_unexpected_indexes_array_len) {
>> +        return false;
>> +    }
>> +
>>      if (!write_list_to_kvmstate(cpu, KVM_PUT_FULL_STATE)) {
>>          return false;
>>      }
>> diff --git a/target/arm/machine.c b/target/arm/machine.c
>> index 0befdb0b28a..f06a920aba1 100644
>> --- a/target/arm/machine.c
>> +++ b/target/arm/machine.c
>> @@ -10,6 +10,7 @@
>>  #include "migration/vmstate.h"
>>  #include "target/arm/gtimer.h"
>>  #include "hw/arm/machines-qom.h"
>> +#include "trace.h"
>>  
>>  static bool vfp_needed(void *opaque)
>>  {
>> @@ -990,7 +991,13 @@ static int cpu_pre_load(void *opaque)
>>  {
>>      ARMCPU *cpu = opaque;
>>      CPUARMState *env = &cpu->env;
>> +    int arraylen = cpu->cpreg_vmstate_array_len + MAX_CPREG_VMSTATE_ANOMALIES;
>>  
>> +    cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
>> +                                         arraylen);
>> +    cpu->cpreg_vmstate_values = g_renew(uint64_t, cpu->cpreg_vmstate_values,
>> +                                        arraylen);
>> +    cpu->cpreg_vmstate_array_len = arraylen;
> I wonder if these would be candidates for fixing up as well.
>
>>      /*
>>       * In an inbound migration where on the source FPSCR/FPSR/FPCR are 0,
>>       * there will be no fpcr_fpsr subsection so we won't call vfp_set_fpcr()
>> @@ -1023,7 +1030,7 @@ static int cpu_post_load(void *opaque, int version_id)
>>  {
>>      ARMCPU *cpu = opaque;
>>      CPUARMState *env = &cpu->env;
>> -    int i, v;
>> +    int i = 0, j = 0, k = 0, v = 0;
>>  
>>      /*
>>       * Handle migration compatibility from old QEMU which didn't
>> @@ -1051,27 +1058,66 @@ static int cpu_post_load(void *opaque, int version_id)
>>       * entries with the right slots in our own values array.
>>       */
>>  
>> -    for (i = 0, v = 0; i < cpu->cpreg_array_len
>> -             && v < cpu->cpreg_vmstate_array_len; i++) {
>> +    trace_cpu_post_load_len(cpu->cpreg_array_len, cpu->cpreg_vmstate_array_len);
>> +    for (; i < cpu->cpreg_array_len && v < cpu->cpreg_vmstate_array_len;) {
>> +        trace_cpu_post_load(i, v , cpu->cpreg_indexes[i]);
>>          if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
>>              /* register in our list but not incoming : skip it */
>> +            trace_cpu_post_load_missing(i, cpu->cpreg_indexes[i], v);
>> +            if (j < MAX_CPREG_VMSTATE_ANOMALIES) {
>> +                cpu->cpreg_vmstate_missing_indexes[j++] = cpu->cpreg_indexes[i];
>> +            }
>> +            i++;
>>              continue;
>>          }
>>          if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
>> -            /* register in their list but not ours: fail migration */
>> -            return -1;
>> +            /* register in their list but not ours: those will fail migration */
>> +            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
>> +            if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
>> +                cpu->cpreg_vmstate_unexpected_indexes[k++] =
>> +                    cpu->cpreg_vmstate_indexes[v];
>> +            }
>> +            v++;
>> +            continue;
>>          }
>>          /* matching register, copy the value over */
>>          cpu->cpreg_values[i] = cpu->cpreg_vmstate_values[v];
>>          v++;
>> +        i++;
>>      }
>> +    /*
>> +     * if we have reached the end of the incoming array but there are
>> +     * still regs in cpreg, continue parsing the regs which are missing
>> +     * in the input stream
>> +     */
>> +    for ( ; i < cpu->cpreg_array_len; i++) {
>> +        if (j < MAX_CPREG_VMSTATE_ANOMALIES) {
>> +            trace_cpu_post_load_missing(i, cpu->cpreg_indexes[i], v);
>> +            cpu->cpreg_vmstate_missing_indexes[j++] = cpu->cpreg_indexes[i];
>> +        }
>> +    }
>> +    /*
>> +     * if we have reached the end of the cpreg array but there are
>> +     * still regs in the input stream, continue parsing the vmstate array
>> +     */
>> +    for ( ; v < cpu->cpreg_vmstate_array_len; v++) {
>> +        if (k < MAX_CPREG_VMSTATE_ANOMALIES) {
>> +            trace_cpu_post_load_unexpected(v, cpu->cpreg_vmstate_indexes[v], i);
>> +            cpu->cpreg_vmstate_unexpected_indexes[k++] =
>> +                cpu->cpreg_vmstate_indexes[v];
>> +        }
>> +    }
>> +
>> +    cpu->cpreg_vmstate_missing_indexes_array_len = j;
>> +    cpu->cpreg_vmstate_unexpected_indexes_array_len = k;
>>  
>>      if (kvm_enabled()) {
>>          if (!kvm_arm_cpu_post_load(cpu)) {
>>              return -1;
>>          }
>>      } else {
>> -        if (!write_list_to_cpustate(cpu)) {
>> +        if (cpu->cpreg_vmstate_unexpected_indexes_array_len ||
>> +            !write_list_to_cpustate(cpu)) {
>>              return -1;
>>          }
>>      }
>> diff --git a/target/arm/trace-events b/target/arm/trace-events
>> index 676d29fe516..0a5ed3e69d5 100644
>> --- a/target/arm/trace-events
>> +++ b/target/arm/trace-events
>> @@ -13,6 +13,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
>>  
>>  # kvm.c
>>  kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
>> +kvm_arm_cpu_post_load_missing_reg(char *name) "Missing register in input stream: %s"
>>  
>>  # cpu.c
>>  arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
>> @@ -26,3 +27,9 @@ arm_powerctl_reset_cpu(uint64_t mp_aff) "cpu %" PRIu64
>>  
>>  # tcg/psci.c and hvf/hvf.c
>>  arm_psci_call(uint64_t x0, uint64_t x1, uint64_t x2, uint64_t x3, uint32_t cpuid) "PSCI Call x0=0x%016"PRIx64" x1=0x%016"PRIx64" x2=0x%016"PRIx64" x3=0x%016"PRIx64" cpuid=0x%x"
>> +
>> +# machine.c
>> +cpu_post_load_len(int cpreg_array_len, int cpreg_vmstate_array_len) "cpreg_array_len=%d cpreg_vmstate_array_len=%d"
>> +cpu_post_load(int i, int v, uint64_t regidx) "i=%d v=%d regidx=0x%"PRIx64
>> +cpu_post_load_missing(int i, uint64_t regidx, int v) "missing register in input stream: i=%d index=0x%"PRIx64" (v=%d)"
>> +cpu_post_load_unexpected(int v, uint64_t regidx, int i) "unexpected register in input stream: v=%d index=0x%"PRIx64" (i=%d)"


