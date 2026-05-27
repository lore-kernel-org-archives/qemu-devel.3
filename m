Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23AFCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 15:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGXg-0006Ku-3l; Wed, 27 May 2026 11:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGXY-0006Io-H0
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGXW-00019n-Ql
 for qemu-devel@nongnu.org; Wed, 27 May 2026 11:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779897086;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNh1EiqEZh1MvxlmuCepdse4lX9bTcWUvyZGOXaCV84=;
 b=X9i0XAkwZyYV45nIeEW+JFc4wwJNw2iF+gh0dRryCydYtoduLmzsMm8JhIh+i6gouSvyKZ
 2YT5SE2Nkd2RDD15+tn46XvRDzaiiBvDmcc8F94PQV/ukVXDk5I/EM2hn+s7Ycjh/x3559
 4+aISotU4V26TbK/aoOov4/PW/KYL/I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-6owPNLoJMKeLSy2VEDeR_w-1; Wed, 27 May 2026 11:51:23 -0400
X-MC-Unique: 6owPNLoJMKeLSy2VEDeR_w-1
X-Mimecast-MFC-AGG-ID: 6owPNLoJMKeLSy2VEDeR_w_1779897082
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fd33b4921so77490565e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 08:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779897082; x=1780501882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNh1EiqEZh1MvxlmuCepdse4lX9bTcWUvyZGOXaCV84=;
 b=BKa7bfEphnBcd0J19GiBcyyBd/VHM26ubeBsGiVrFswM+5V3GCLSuZ75FpyYP5RRZG
 d2aCfJjHGtm88Oc8pTYIzahNXz/fyxTrUeC2JtR1tEBryAi6r2cpcjTu1DG0twNUlYls
 WG8iFqP8kKkY5xuTSff5gV935cw2KEyveq7jJ3KbT65cQXwfuHEUi+DWS0g/Wdtuxqg/
 xllpFlUKQ79XYBCUfAkDdMzwy3bklidJZYuz7fWxMkaHBzrhQ+ue3CgYdHKYTSldy2xP
 EH6n9eDPRBonPGfwzDt2NxBwcMOYtIofQSUrgzLu+9laHFnE7PDhDY9csZc0tof4pDjF
 lzQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ91rE11he6wVO6IvdORIGvzx2O0aiUxTrz5/sMpJiqK/zfLlnupKfjkY/kqihcL8oVCE15PZlO5FN4g@nongnu.org
X-Gm-Message-State: AOJu0YwNLtYgnpE6CWPmK9sBk9eNFav+Dp379tEYu9Fw7LuB5IcupoZ8
 gnIR98h/7OtXRc+7SnPj3hxezA5rYQ6GxPEluMpwk3RdV2rLx2qEdM89bYt4vON7rx94C21uPpT
 1z9r5ZW7wSvKVRBKBRhu5xZHaESQloMV7x5Ei7aL+gtKhOxfBAmdUQGNn
X-Gm-Gg: Acq92OGkHGucI2X+cKPadYR5WRqvyDP/k2os7miMOjngIaaJ8d5F45gRgRb9tlfUS2m
 38/TsU/A/nYRZ1RcHPMhwWZEmBJWcgxrZduPhElUdSRkJ2EbRrG6Ii9nhNQzN24BXjKCHSHceRx
 ztqKZMMGMNbZ/Pdm2wvJO6TZQjZ2xiXgg0nIlNfiuWmxrzQ8tE3Jk+duTKF1uPyKPvB6/mQkfmx
 d4VzVjMW9Z4eEfp74P52W1gPi0iChIAR95v3yxBZiRKDjJVDZKlWEVKWFpH5zTEjnLF5vNeaKcy
 JYbH55VAVlf7wio7Qxes0L5zRTDh0aHKh1XsujuF762dstiwQbM5OaXoa9tvnwOEXNRtYyPmTY+
 b2CCIIGpm9zjmSQiW6ZFxKLkwocwEGe5hURucX5U8oSzpYF6gcoGVl1JJjJxi47FK1LnIi5fH24
 riWDil
X-Received: by 2002:a05:600c:35c8:b0:490:45bb:8dd9 with SMTP id
 5b1f17b1804b1-49045bb8efdmr419559465e9.8.1779897081758; 
 Wed, 27 May 2026 08:51:21 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:490:45bb:8dd9 with SMTP id
 5b1f17b1804b1-49045bb8efdmr419558785e9.8.1779897081304; 
 Wed, 27 May 2026 08:51:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5a2a73sm6716947f8f.22.2026.05.27.08.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 08:51:20 -0700 (PDT)
Message-ID: <6c14a58a-60ab-419f-9395-ca3489f6cff8@redhat.com>
Date: Wed, 27 May 2026 17:51:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/18] target/arm/cpu: Expose writable ID reg field
 properties on the kvm host vcpu model
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-17-eric.auger@redhat.com>
 <30F66A6A-E26B-486C-81D1-8E1B2CCB558A@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <30F66A6A-E26B-486C-81D1-8E1B2CCB558A@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 5/27/26 5:16 PM, Khushit Shah wrote:
>
>> On 19 May 2026, at 6:57 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> If the host supports KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES and
>> KVM_ARM_GET_REG_WRITABLE_MASKS ioctl successfully retrieved the mask
>> of writable fields for all ID regs, expose uint64 SYSREG properties
>> for all the writable ID reg fields exposed by the host kernel which
>> can be matched in target/arm/cpu-idregs.h.inc.
>>
>> Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
>> being those used ARCHMRS Registers.json.
>>
>> When such properties are set, they override the default field value
>> retrieved from the host and reinjected into KVM. Then the actual value
>> being applied at KVM depends on the register, ie. it can be sanitized.
>> In case the field value is rejected by KVM, the vpcu init fails.
>>
>> Anyway there is a first attempt to write back this value into KVM.
>>
>> Then legacy CPU options (virtualization, secure, ...) can still
>> override the previous value. So low level IDREG field properties
>> apply before the legacy ones.
> No code to handle this right now right? Anyway I just think parse the
> props in order they are specified in command line. 
Actually I think it works that way already because we first override the
values with ID reg field prop values and then apply the legacy composite
props
>
> qmp cpu-model-expansion is a weird case, it defines an order in which
> props are processed.
Yeah that's effectively something that needs to be further tested

Thanks

Eric
>
>> An example of invocation is:
>> -cpu host,SYSREG_ID_AA64MMFR0_EL1_ECV=0x0
>> which sets ECV field of ID_AA64MMFR0_EL1 to 0 (enhanced counter
>> virtualization).
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>
>> ---
>> v4 -> v5:
>> - get rid of ret local variable, dynamically allocate and free writable_map
>>  here
>> ---
>> target/arm/cpu64.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index f2edbfc437..e0e1ff6cfb 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -37,6 +37,7 @@
>> #include "hw/core/qdev-properties.h"
>> #include "internals.h"
>> #include "cpu-features.h"
>> +#include "cpu-idregs.h"
>>
>> /* convert between <register>_IDX and SYS_<register> */
>> #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
>> @@ -851,7 +852,6 @@ static void kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
>> static void aarch64_host_initfn(Object *obj)
>> {
>>     ARMCPU *cpu = ARM_CPU(obj);
>> -    int ret;
>>
>> #if defined(CONFIG_NITRO)
>>     if (nitro_enabled()) {
>> @@ -865,13 +865,18 @@ static void aarch64_host_initfn(Object *obj)
>>
>>     cpu->writable_map = g_new(uint64_t, KVM_ARM_FEATURE_ID_RANGE_SIZE);
>>
>> -    ret = kvm_arm_get_writable_id_regs(cpu->writable_map);
>> -    if (ret) {
>> +    if (kvm_arm_get_writable_id_regs(cpu->writable_map)) {
>>         g_free(cpu->writable_map);
>>         cpu->writable_map = NULL;
>>     }
>>     kvm_arm_set_cpu_features_from_host(cpu);
>>     aarch64_add_sve_properties(obj);
>> +
>> +    if (cpu->writable_map) {
>> +        /* generate SYSREG properties according to writable masks */
>> +        kvm_arm_expose_idreg_properties(cpu, arm64_id_regs);
>> +    }
>> +
>> #elif defined(CONFIG_HVF)
>>     hvf_arm_set_cpu_features_from_host(cpu);
>> #elif defined(CONFIG_WHPX)
>> -- 
>> 2.53.0
>>
> Warm Regards,
> Khushit
>


