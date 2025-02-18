Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5FBC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 15:55:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkPwU-0003ek-HC; Tue, 18 Feb 2025 10:55:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tkPwT-0003eS-0C
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:55:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tkPwR-0004e8-88
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 10:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739894114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j90RWZALR1P7KicoAf1AmydoBRa+BXoXUs125IAi9hQ=;
 b=awfH8RwCtk7XKNsIWUqD76HI277GhPbam3TxX2ny2ZMKTn9x7HYREhcs//I77B65KVagqX
 jweBUxI5S10+TkTLg+FCZxQ9SszjzaesXJhqG92c89NCDFYXPmrm8q5qGXec3DU/atn5ju
 lKuMzBlGwB3IJ+ueLOI/gIOADlHofIQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-pIBM1XteNju7bqO1WirvZQ-1; Tue,
 18 Feb 2025 10:55:09 -0500
X-MC-Unique: pIBM1XteNju7bqO1WirvZQ-1
X-Mimecast-MFC-AGG-ID: pIBM1XteNju7bqO1WirvZQ_1739894108
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 632AD180087A; Tue, 18 Feb 2025 15:55:07 +0000 (UTC)
Received: from localhost (unknown [10.67.24.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0263E1800874; Tue, 18 Feb 2025 15:55:04 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH 02/15] arm/kvm: add accessors for storing host features
 into idregs
In-Reply-To: <b1a2e796-b2f5-4acc-9d6d-e85d99d67a0d@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-3-cohuck@redhat.com>
 <b1a2e796-b2f5-4acc-9d6d-e85d99d67a0d@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 18 Feb 2025 16:54:58 +0100
Message-ID: <874j0r459p.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 18 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Hi Connie
>
> On 2/7/25 12:02 PM, Cornelia Huck wrote:
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu-sysregs.h |  3 +++
>>  target/arm/cpu64.c       | 25 +++++++++++++++++++++++++
>>  target/arm/kvm.c         | 30 ++++++++++++++++++++++++++++++
>>  3 files changed, 58 insertions(+)
>>
>> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
>> index de09ebae91a5..54a4fadbf0c1 100644
>> --- a/target/arm/cpu-sysregs.h
>> +++ b/target/arm/cpu-sysregs.h
>> @@ -128,4 +128,7 @@ static const uint32_t id_register_sysreg[NUM_ID_IDX] = {
>>      [CTR_EL0_IDX] = SYS_CTR_EL0,
>>  };
>>  
>> +int get_sysreg_idx(ARMSysRegs sysreg);
>> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
>> +
>>  #endif /* ARM_CPU_SYSREGS_H */
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 8188ede5cc8a..9ae78253cb34 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -736,6 +736,31 @@ static void aarch64_a53_initfn(Object *obj)
>>      define_cortex_a72_a57_a53_cp_reginfo(cpu);
>>  }
>>  
>> +#ifdef CONFIG_KVM
>> +
>> +int get_sysreg_idx(ARMSysRegs sysreg)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < NUM_ID_IDX; i++) {
>> +        if (id_register_sysreg[i] == sysreg) {
> I agree with Richard that if we could get rid of this linear search it
> would be nicer.

FWIW, I have a local branch which reworks the lookup and the macros that
is currently in the "it compiles" stage. Hopefully progressing to the
"it works" stage (provided I'm not preempted by other things again.)

>> +            return i;
>> +        }
>> +    }
>> +    return -1;
>> +}
>> +
>> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
>> +{
>> +    return ARM64_SYS_REG((sysreg & CP_REG_ARM64_SYSREG_OP0_MASK) >> CP_REG_ARM64_SYSREG_OP0_SHIFT,
>> +                         (sysreg & CP_REG_ARM64_SYSREG_OP1_MASK) >> CP_REG_ARM64_SYSREG_OP1_SHIFT,
>> +                         (sysreg & CP_REG_ARM64_SYSREG_CRN_MASK) >> CP_REG_ARM64_SYSREG_CRN_SHIFT,
>> +                         (sysreg & CP_REG_ARM64_SYSREG_CRM_MASK) >> CP_REG_ARM64_SYSREG_CRM_SHIFT,
>> +                         (sysreg & CP_REG_ARM64_SYSREG_OP2_MASK) >> CP_REG_ARM64_SYSREG_OP2_SHIFT);
>> +}
>> +
>> +#endif
>> +
>>  static void aarch64_host_initfn(Object *obj)
>>  {
>>  #if defined(CONFIG_KVM)
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index da30bdbb2349..3b8bb5661f2b 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -246,6 +246,36 @@ static bool kvm_arm_pauth_supported(void)
>>              kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
>>  }
>>  
>> +/* read a 32b sysreg value and store it in the idregs */
>> +static int get_host_cpu_reg32(int fd, ARMHostCPUFeatures *ahcf, ARMSysRegs sysreg)
> those are defined as static but there is no user so this will break
> compilation locally

Hm, didn't see that, but noticed a few other places that are b0rken. I
think I need to fiddle with my config to broaden compilation coverage.


