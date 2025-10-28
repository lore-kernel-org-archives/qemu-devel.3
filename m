Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CEACCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 11:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDhTf-00086v-5v; Tue, 28 Oct 2025 07:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vDhT5-00083Z-Vj
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vDhSy-0007aB-FA
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 07:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761649332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nxmOHwHxmZMLpzf1uqdrSlEJ/+f2PvodAb00eauIdqA=;
 b=RGXEg6S7QdFyMg65kUcnVzV189bMUBncERwFiF4ki6jWVoSbCMi/zznfxEBg+jjUXlINwW
 ISDkWN8OaKi3w1wVwPJ5Sz+XoNIxfLL7vFUV60N/WKyYi4ssg3Q0MGsvGJkolj0dvdIBmJ
 M1j8kP/YB3rfHlAK8m0WSI4kY3fgV6s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-qC4hoW51OQqpdwoHk9plhg-1; Tue, 28 Oct 2025 07:00:57 -0400
X-MC-Unique: qC4hoW51OQqpdwoHk9plhg-1
X-Mimecast-MFC-AGG-ID: qC4hoW51OQqpdwoHk9plhg_1761649256
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475dd9906e1so16766935e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 04:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761649255; x=1762254055;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nxmOHwHxmZMLpzf1uqdrSlEJ/+f2PvodAb00eauIdqA=;
 b=E/lfJyG1wdn6Gm4EvuwSeVL8obezXsM4hYKGG+a0xiTBJlrEu68ZwUq+4B+iunZuCY
 ZVJjiOECE0AZ1FN1tx0DeorCxPEpAgYWY/6mFUojnoUy/qr3idX6ivmi5JJFV3VxQpuC
 MAIDZwiCgzuM82hr5vBcz5o1qpSJXX5E1ozgK+ywmWlBxkp5uDgRUNubxvle5qHp4F/y
 HSduJhFgEvUHe2I/pMnZobxZBAqolgs1hmjAXHkKS3Q+wsVmMxXuyuUtEf5ZlIhy/jwd
 5ue3tbGs3isPHGv2TRCN+FJnRKG6M4q/ihXWfmpatPNsPPBCd8fdECsPA8YVty3lqKaU
 WnGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrpIylFfsK2iJ36YnMbzogwAkRWnX6GG+ugLbS+v0bUhP5zHyWnLzDfnKzSUm4PG2a3IfyZo4LDl5h@nongnu.org
X-Gm-Message-State: AOJu0YwWBnWR/Lye3vhCpHJSA1fKpMNC+jp7BlQBwJofYWDSBdLCNIzH
 O8p73pOFJDA1ZUNi9Fz68V1YM8DnYs7y7ZAjzhxbQ1/xECPZaWB8889J48ufK+O7jJtdcXVZgtS
 Cw1Nih2jxlysR1YbocJG6gRyBosJLqgkPn5tFztoagxd86a7R0qvMmPjX
X-Gm-Gg: ASbGncuuMMM66OALE1f9LZlFDySYfqgbdXUb3AmfbIMVCGvG5f78WiYhKkykflypRhK
 NoNk9XFCE4iypqDv0PAGyK2fLTJE1rhLuFDSxsXg5WdRq24cnMm2wkWZKJBFij+vYzNSDcTQ7i2
 F/uOM8h3t5dIylwxtGYNC5wS7pvlE9aQGEDr4y+j64KUseH2r0R1yV/fFgDKke3sjn5B//eRRRe
 tAVYUeYzq3jfdhY3ujAK8vWjlcS06zpMfHtp1YD5hmX8o2iWSdLo/Hg8IXTIU6RECGI++dCA0kG
 XwfcCB5FpL16JbgYVSi7OQ6i5IRSTLnlMoBFdp68rF/9rXDwclix4fQCMRV2WvCcS9VmgwWM6N4
 yQgq0ngOaABjHoBqsG9H+BAPHxnZoXmTP3ezfx/tZ1T6h6E+l
X-Received: by 2002:a05:600c:3493:b0:46f:b42e:edce with SMTP id
 5b1f17b1804b1-47717e67cd3mr23266995e9.39.1761649255552; 
 Tue, 28 Oct 2025 04:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFVAEQZBrj6XxR1esAB3vvNknSrAGxc5wuX0loLWB2sKQiYoi+ajmuIkxNcYXcTJ8iSZx7ug==
X-Received: by 2002:a05:600c:3493:b0:46f:b42e:edce with SMTP id
 5b1f17b1804b1-47717e67cd3mr23266575e9.39.1761649255026; 
 Tue, 28 Oct 2025 04:00:55 -0700 (PDT)
Received: from rh (p200300f6af131a0027bd20bfc18c447d.dip0.t-ipconnect.de.
 [2003:f6:af13:1a00:27bd:20bf:c18c:447d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd48942dsm192647185e9.4.2025.10.28.04.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 04:00:54 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:00:53 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH 2/2] target/arm/kvm: add kvm-psci-version vcpu property
In-Reply-To: <CAFEAcA-urFX=V7kuRA3cRik7PifFQER5eoXC_CZ2jKg7OZz9iA@mail.gmail.com>
Message-ID: <ba03c952-e567-eb2b-f4c8-b1818ee127d6@redhat.com>
References: <20250911144923.24259-1-sebott@redhat.com>
 <20250911144923.24259-3-sebott@redhat.com>
 <CAFEAcA-urFX=V7kuRA3cRik7PifFQER5eoXC_CZ2jKg7OZz9iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 27 Oct 2025, Peter Maydell wrote:
> On Thu, 11 Sept 2025 at 15:49, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> Provide a kvm specific vcpu property to override the default
>> (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
>> by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>  docs/system/arm/cpu-features.rst |  5 +++
>>  target/arm/cpu.h                 |  6 +++
>>  target/arm/kvm.c                 | 70 +++++++++++++++++++++++++++++++-
>>  3 files changed, 80 insertions(+), 1 deletion(-)
>>
>> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
>> index 37d5dfd15b..1d32ce0fee 100644
>> --- a/docs/system/arm/cpu-features.rst
>> +++ b/docs/system/arm/cpu-features.rst
>> @@ -204,6 +204,11 @@ the list of KVM VCPU features and their descriptions.
>>    the guest scheduler behavior and/or be exposed to the guest
>>    userspace.
>>
>> +``kvm-psci-version``
>> +  Override the default (as of kernel v6.13 that would be PSCI v1.3)
>> +  PSCI version emulated by the kernel. Current valid values are:
>> +  0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>> +
>>  TCG VCPU Features
>>  =================
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index c15d79a106..44292aab32 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -974,6 +974,12 @@ struct ArchCPU {
>>       */
>>      uint32_t psci_version;
>>
>> +    /*
>> +     * Intermediate value used during property parsing.
>> +     * Once finalized, the value should be read from psci_version.
>> +     */
>> +    uint32_t prop_psci_version;
>> +
>>      /* Current power state, access guarded by BQL */
>>      ARMPSCIState power_state;
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 6672344855..bc6073f395 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -483,6 +483,59 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
>>      ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>>  }
>>
>> +static char *kvm_get_psci_version(Object *obj, Error **errp)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +    const char *val;
>> +
>> +    switch (cpu->prop_psci_version) {
>> +    case QEMU_PSCI_VERSION_0_1:
>> +        val = "0.1";
>> +        break;
>> +    case QEMU_PSCI_VERSION_0_2:
>> +        val = "0.2";
>> +        break;
>> +    case QEMU_PSCI_VERSION_1_0:
>> +        val = "1.0";
>> +        break;
>> +    case QEMU_PSCI_VERSION_1_1:
>> +        val = "1.1";
>> +        break;
>> +    case QEMU_PSCI_VERSION_1_2:
>> +        val = "1.2";
>> +        break;
>> +    case QEMU_PSCI_VERSION_1_3:
>> +        val = "1.3";
>> +        break;
>> +    default:
>> +        val = "0.2";
>> +        break;
>> +    }
>> +    return g_strdup(val);
>> +}
>> +
>> +static void kvm_set_psci_version(Object *obj, const char *value, Error **errp)
>> +{
>> +    ARMCPU *cpu = ARM_CPU(obj);
>> +
>> +    if (!strcmp(value, "0.1")) {
>> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_0_1;
>> +    } else if (!strcmp(value, "0.2")) {
>> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_0_2;
>> +    } else if (!strcmp(value, "1.0")) {
>> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_0;
>> +    } else if (!strcmp(value, "1.1")) {
>> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_1;
>> +    } else if (!strcmp(value, "1.2")) {
>> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_2;
>> +    } else if (!strcmp(value, "1.3")) {
>> +        cpu->prop_psci_version = QEMU_PSCI_VERSION_1_3;
>
> We already have six values here and it's not implausible
> we might end up with more in future; maybe we should make the
> mapping between string and constant data-driven rather
> than having code written out longhand in the get and set
> functions?

Yes, sure. I'll send out a V2.

Thanks!
Sebastian


