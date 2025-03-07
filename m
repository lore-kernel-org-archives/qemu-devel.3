Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AECC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZjL-0003Hh-9n; Fri, 07 Mar 2025 10:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tqZjG-0003GL-DB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:35:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1tqZjE-00089r-5M
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741361711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jKCJK20iZ4Lxz+i3LBfF099FLHJSqlugl9nmS3hCHSo=;
 b=MHjB6C1iLmrmq/Ut2Sgx8k7f9O0WZyzZVsHCCWSGUc6dC5GadJ3wFNLYdhzQrTGCDfJm7v
 sZkVodc/KRFmYzTmt6xUswQyEErrjzfIkMlf2ej5YWb6w7PvKfmpqAf41MRVM0S5dYOtr1
 pww/zSwDJTxIb/jcICS61boytTHTCh0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-vgXDMstqMd2fAuRrDfya3g-1; Fri,
 07 Mar 2025 10:35:09 -0500
X-MC-Unique: vgXDMstqMd2fAuRrDfya3g-1
X-Mimecast-MFC-AGG-ID: vgXDMstqMd2fAuRrDfya3g_1741361708
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9453D1800A38; Fri,  7 Mar 2025 15:35:07 +0000 (UTC)
Received: from localhost (unknown [10.44.33.78])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DAC591800373; Fri,  7 Mar 2025 15:35:05 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: Re: [PATCH v2 02/14] arm/kvm: add accessors for storing host
 features into idregs
In-Reply-To: <8f4b598e-d09d-4d2e-afcc-317a6997ad02@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250305163819.2477553-1-cohuck@redhat.com>
 <20250305163819.2477553-3-cohuck@redhat.com>
 <8f4b598e-d09d-4d2e-afcc-317a6997ad02@linaro.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 07 Mar 2025 16:35:02 +0100
Message-ID: <87plisvopl.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 05 2025, Richard Henderson <richard.henderson@linaro.org> wrote:

> On 3/5/25 08:38, Cornelia Huck wrote:
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   target/arm/cpu-sysregs.h |  3 +++
>>   target/arm/cpu64.c       | 25 +++++++++++++++++++++++++
>>   target/arm/kvm.c         | 12 ++++++++++++
>>   3 files changed, 40 insertions(+)
>> 
>> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
>> index de09ebae91a5..54a4fadbf0c1 100644
>> --- a/target/arm/cpu-sysregs.h
>> +++ b/target/arm/cpu-sysregs.h
>> @@ -128,4 +128,7 @@ static const uint32_t id_register_sysreg[NUM_ID_IDX] = {
>>       [CTR_EL0_IDX] = SYS_CTR_EL0,
>>   };
>>   
>> +int get_sysreg_idx(ARMSysRegs sysreg);
>> +uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg);
>> +
>>   #endif /* ARM_CPU_SYSREGS_H */
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 8188ede5cc8a..9ae78253cb34 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -736,6 +736,31 @@ static void aarch64_a53_initfn(Object *obj)
>>       define_cortex_a72_a57_a53_cp_reginfo(cpu);
>>   }
>>   
>> +#ifdef CONFIG_KVM
>> +
>> +int get_sysreg_idx(ARMSysRegs sysreg)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < NUM_ID_IDX; i++) {
>> +        if (id_register_sysreg[i] == sysreg) {
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
>
> Why are these here, with an ifdef, instead of in kvm.c?
>
> Rather than a loop over an array, you could do
>
> #define DEF(NAME, OP0, OP1, CRN, CRM, OP2) \
>      case SYS_##NAME: return NAME##_IDX;
>
> int get_sysreg_idx(ARMSysRegs sysreg)
> {
>      switch (sysreg) {
> #include "cpu-sysregs.h.inc"
>      }
>      g_assert_not_reached();
> }
>
> #undef DEF

Ok, now I see where you're going with the DEF(...) magic.

>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index da30bdbb2349..2381c87e4ba1 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -246,6 +246,18 @@ static bool kvm_arm_pauth_supported(void)
>>               kvm_check_extension(kvm_state, KVM_CAP_ARM_PTRAUTH_GENERIC));
>>   }
>>   
>> +/* read a sysreg value and store it in the idregs */
>> +static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx index)
>> +{
>> +    uint64_t *reg;
>> +    int ret;
>> +
>> +    reg = &ahcf->isar.idregs[index];
>> +    ret = read_sys_reg64(fd, reg,
>> +                         idregs_sysreg_to_kvm_reg(id_register_sysreg[index]));
>> +    return ret;
>> +}
>
> Surely this patch doesn't compile by itself,
> because this will Werror for the unused function.

Hm, I'm pretty positive that I did intermediate compiles while sorting
the patches here... let me see if I can improve this.


