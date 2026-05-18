Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87C0CD4F49
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzml-0002vm-Av; Mon, 18 May 2026 11:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wOzmf-0002rt-L3
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wOzmd-00070Q-6I
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779117689;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C1bFUpduXqNFXVInpMskz8flfKqQxqeF4wLqRJiwQpg=;
 b=fqwtV1rgtlQuhFIQhQy0abcy6mgBjjK1BiklkIV3ZlQ6OKiUH/zE5ymf80xsqn5rg7FMGk
 /tK22W8rZNOBzaG0lmSONnqZ9Gx5PIFTLPWm8mMMxEcWpcFTAvOfEVVpGCKQ4cJLvngPiA
 QmxuAJBY2SvWrxKII2UPZhY1nsA4AlY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-SFEIpcjTPDyacMZMKw4QuA-1; Mon, 18 May 2026 11:21:28 -0400
X-MC-Unique: SFEIpcjTPDyacMZMKw4QuA-1
X-Mimecast-MFC-AGG-ID: SFEIpcjTPDyacMZMKw4QuA_1779117687
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45e80183514so873799f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 08:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779117687; x=1779722487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1bFUpduXqNFXVInpMskz8flfKqQxqeF4wLqRJiwQpg=;
 b=SOL25p1yBf+wC2XgaG8DcB4shi3CMmjYVdkelD3rZqGyRN0lH/Y7Oe/BrkYO5Io65K
 CiR8sTPtL+O6XU7qU8Re60rUw1qtxr7cBN287lqVqB+ebSOMqqsB+thPkvjrbUn78i7M
 u3LNlZv+jXFwwH1EvlrW6L6f1Oivr697Zsl9ld5QUamNs8SlIZPzJbYebHGf2RyZiNo5
 4XI+6TbnzzqSFQC2GES/gmq0bjlcg6ifgzIsYLwbB7j8iwsz4VN5Rh3KEKCn7bAArkuj
 G+dKVFtQBVSnfaMW5NGx4PE+yiNQAFUxJU+Lp4ROhhZL3xhT69uj4oLWtUStCAFjC3Xq
 PtSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ81ksGW2SRPDRaF+hXW7hljoAFq83xKznA0IEQVyLL3x2/vPPRUS2wWy/CFpNXMomQN9da/Ca4m8MoF@nongnu.org
X-Gm-Message-State: AOJu0Yz2kYTQZWb4DBLYzlCegd4Yr4LytsWatQZ1zfsZ+AJUVUCuxz8a
 ulswXeXdBBwVGp9YpZJgodQ/liciSIbGGJaBwyeZJVyj2nasvsfyzx2r5wgadwXer6RYR4GLQq6
 yy4YbY/bcDo40hlKe1vJ4xbM90PhGV+3so3iInQV9qepH6dyZmR32Ky7b
X-Gm-Gg: Acq92OE8j4DUdXjsDBfYimBdoA89pagm7G2OKi4arek+zggzsM17hsThKvW2MXkJPg6
 otNRHfbjo1gxZlpfBrLRyvqJ2g9TcLbEdKVS4610wF+WIAKezn8/lolwmroAbO64kIc90LlDNgV
 ZUVaEmiwFdEfIyhUNSNVq2plcXwMjIUjN0oq92r1f/sDfLRp12YCQ7Aj8LEq+NuxynS7PDPj1ZV
 c8cWuWyEbv6ngChjJ/ORF7F4oWQUzCelJAOw3OIlcb/eN0RLRjwuJH2xGXWPvAns1YDuyCulTtW
 EmeVLOR028fL9Jr/KqxUvq+OP4fBn+PSFMJuXwnn89foe+aTSJFUzj8JEv0F8BqaunhTMbf1UP5
 H8cWoOxdpR0lMB1hKHQpRwMhbm35al7PbSlbmbh76GpTpvciuQ6ZWb2k5gFECFvsiUy33ElHu8I
 MPr5wx
X-Received: by 2002:a05:600c:6995:b0:489:1f97:6b1d with SMTP id
 5b1f17b1804b1-48fe6322219mr241868095e9.28.1779117687090; 
 Mon, 18 May 2026 08:21:27 -0700 (PDT)
X-Received: by 2002:a05:600c:6995:b0:489:1f97:6b1d with SMTP id
 5b1f17b1804b1-48fe6322219mr241867385e9.28.1779117686687; 
 Mon, 18 May 2026 08:21:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4862209sm262808055e9.0.2026.05.18.08.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 08:21:26 -0700 (PDT)
Message-ID: <1d8a86aa-d43e-4e4c-ae5c-7cb392d93471@redhat.com>
Date: Mon, 18 May 2026 17:21:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/17] arm/cpu: Expose writable ID reg field properties
 on the kvm host vcpu model
Content-Language: en-US
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260503073541.790215-1-eric.auger@redhat.com>
 <20260503073541.790215-16-eric.auger@redhat.com>
 <CH3PR12MB7548D4829306C3B8E9612FD9AB3C2@CH3PR12MB7548.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CH3PR12MB7548D4829306C3B8E9612FD9AB3C2@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 5/7/26 9:22 PM, Shameer Kolothum Thodi wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 03 May 2026 08:34
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> cohuck@redhat.com; sebott@redhat.com; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; philmd@linaro.org
>> Cc: maz@kernel.org; oliver.upton@linux.dev; pbonzini@redhat.com;
>> armbru@redhat.com; berrange@redhat.com; abologna@redhat.com;
>> jdenemar@redhat.com
>> Subject: [PATCH v4 15/17] arm/cpu: Expose writable ID reg field properties on
>> the kvm host vcpu model
>>
>> External email: Use caution opening links or attachments
>>
>>
>> If the host supports KVM_CAP_ARM_SUPPORTED_REG_MASK_RANGES and
>> KVM_ARM_GET_REG_WRITABLE_MASKS ioctl successfully retrieved the mask
>> of writable fields for all ID regs, expose uint64 SYSREG properties
>> for all the writable ID reg fields exposed by the host kernel which
>> can be matched in target/arm/cpu-sysreg-properties.c.
>>
>> Properties are named  SYSREG_<REG>_<FIELD> with REG and FIELD
>> being those used in linux arch/arm64/tools/sysreg or in the AARCHMRS
>> Registers.json.
>>
>> This is achieved by matching the writable fields retrieved from the
>> host kernel against the generated description of ID regs and their
>> fields in target/arm/cpu-sysreg-properties.c.
>>
>> An example of invocation is:
>> -cpu host,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
>> which sets DP field of ID_AA64ISAR0_EL1 to 0.
>>
>> [CH: add properties to the host model instead of introducing a new
>> "custom" model]
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu.c   | 12 ++++++++++++
>>  target/arm/cpu64.c | 23 ++++++++++++++++++++++-
>>  2 files changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 10feb639c4..10ce4eb0cb 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -1824,6 +1824,18 @@ static void arm_cpu_realizefn(DeviceState *dev,
>> Error **errp)
>>          return;
>>      }
>>
>> +    /*
>> +     * If we failed to retrieve the set of writable ID registers for the "host"
>> +     * CPU model, report it here. No error if the interface for discovering
>> +     * writable ID registers is not available.
>> +     * In case we did get the set of writable ID registers, set the features to
>> +     * the configured values here and perform some sanity checks.
>> +     */
>> +    if (cpu->writable_id_regs_status == WRITABLE_ID_REGS_FAILED) {
>> +        error_setg(errp, "Failed to discover writable id registers");
>> +        return;
>> +    }
>> +
>>      if (!cpu->gt_cntfrq_hz) {
>>          /*
>>           * 0 means "the board didn't set a value, use the default". (We also
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 1b3d3fb245..d66cb00a21 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -852,6 +852,8 @@ static void
>> kvm_arm_set_cpreg_mig_tolerances(ARMCPU *cpu)
>>  static void aarch64_host_initfn(Object *obj)
>>  {
>>      ARMCPU *cpu = ARM_CPU(obj);
>> +    bool expose_id_regs = true;
>> +    int ret;
> The above will be unused for non KVM builds.
removed
>
>>  #if defined(CONFIG_NITRO)
>>      if (nitro_enabled()) {
>> @@ -862,8 +864,27 @@ static void aarch64_host_initfn(Object *obj)
>>
>>  #if defined(CONFIG_KVM)
>>      kvm_arm_set_cpreg_mig_tolerances(cpu);
>> -    kvm_arm_set_cpu_features_from_host(cpu, false);
>> +
>> +    cpu->writable_map = g_malloc(sizeof(IdRegMap));
> Does kernel clear the buffer before setting writable mask?

yes it does:
        /* Wipe the whole thing first */
        if (clear_user(masks, KVM_ARM_FEATURE_ID_RANGE_SIZE *
sizeof(__u64)))
                return -EFAULT;

>
>> +    /* discover via KVM_ARM_GET_REG_WRITABLE_MASKS */
>> +    ret = kvm_arm_get_writable_id_regs(cpu, cpu->writable_map);
>> +    if (ret == -ENOSYS) {
>> +        /* legacy: continue without writable id regs */
>> +        expose_id_regs = false;
>> +    } else if (ret) {
>> +        /* function will have marked an error */
>> +        return;
>> +    }
> Should free and NULL writable_map for both error paths above.
sure

Eric
>
> Thanks,
> Shameer
>
>> +
>> +    kvm_arm_set_cpu_features_from_host(cpu, expose_id_regs);
>>      aarch64_add_sve_properties(obj);
>> +
>> +    if (expose_id_regs) {
>> +        /* generate SYSREG properties according to writable masks */
>> +        kvm_arm_expose_idreg_properties(cpu, arm64_id_regs);
>> +    }
>> +
>>  #elif defined(CONFIG_HVF)
>>      hvf_arm_set_cpu_features_from_host(cpu);
>>  #elif defined(CONFIG_WHPX)
>> --
>> 2.53.0


