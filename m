Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FF8CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd0F-0004cd-3m; Fri, 21 Nov 2025 21:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vMcAO-0006o7-EO
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:11:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vMc8I-0004Fo-PS
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 20:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763773761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d12F7jWt6ovbskDnymQfRvlGRAivIvO12o7hGLf7U8M=;
 b=EIf4vnWOUtJ3L8WA716BPikmVT687iVAjQbkNr7l/WEZCZyTmkR/ArCYCT5CMxyqgSbeEp
 rBy/KGnt7UA0bhXpSa3LW5C7J5YC9o7gJ9cfZiKkhnReftUb+9MHEt0lv+bPBMYSSFp7j7
 x4MVRpOFHplrTxocMl/j3s6JRnHYPVs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-n7XJrKZZPCGeCsczxzWDiw-1; Fri,
 21 Nov 2025 09:47:29 -0500
X-MC-Unique: n7XJrKZZPCGeCsczxzWDiw-1
X-Mimecast-MFC-AGG-ID: n7XJrKZZPCGeCsczxzWDiw_1763736448
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 805F718002C4; Fri, 21 Nov 2025 14:47:27 +0000 (UTC)
Received: from localhost (unknown [10.67.32.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBD7830044DC; Fri, 21 Nov 2025 14:47:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-11.0] arm: add DCZID_EL0 to idregs array
In-Reply-To: <ef7a800a-99fe-472a-b3a2-c6eff15d65ff@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251119134414.2892640-1-cohuck@redhat.com>
 <ef7a800a-99fe-472a-b3a2-c6eff15d65ff@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 21 Nov 2025 15:47:20 +0100
Message-ID: <87y0nzphmv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Thu, Nov 20 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Hi Connie,
>
> On 11/19/25 2:44 PM, Cornelia Huck wrote:
>> This requires a bit of care, since we still have to handle the EL
>> specific part (DCZID_EL0.DZP). Callers can set/access dcz_blocksize
> what do you mean by EL specific part?

DZP is depending on the current EL (see DC ZVA; it might trap for
EL0/EL1.)

>
> you may simply say that at the moment only bs field is handled as part
> of cpu.dcz_blocklen
> so you replace all the users of that field by accessors to the
> isar.idreg[] storage

Hm, I'm not sure I understand this sentence -- what I wanted to say is
that we care about DCZID_EL0.BS and moving DCZID_EL0 to idregs is made
easier by a simple wrapper for that.

>> via a wrapper working on DCZID_EL.BS.
>>
>> KVM currently does not support DCZID_EL0 via ONE_REG, and actually
>> does not need to work with it, so provide a dummy value for now.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

(...)

>> @@ -1178,6 +1176,19 @@ struct ARMCPUClass {
>>      ResettablePhases parent_phases;
>>  };
>>  
>> +static inline uint8_t get_dcz_blocksize(ARMCPU *cpu)
> While at it I would replace dcz_blocksize by dczid_el0_bs to be more
> explicit

Can do; I wanted to make the diff more straightforward to use.

>> +{
>> +    return cpu->isar.idregs[DCZID_EL0_IDX] & 0xf;
> extract64?
>> +}
>> +
>> +static inline void set_dcz_blocksize(ARMCPU *cpu, uint8_t bs)
>> +{
>> +    uint64_t dczid = cpu->isar.idregs[DCZID_EL0_IDX];
>> +
>> +    /* keep dzp unchanged */
>> +    cpu->isar.idregs[DCZID_EL0_IDX] = (dczid & ~0xf) | bs;
> deposit64?

Can change.

>> +}
>> +
>>  /* Callback functions for the generic timer's timers. */
>>  void arm_gt_ptimer_cb(void *opaque);
>>  void arm_gt_vtimer_cb(void *opaque);

(...)

>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index 27ebc6f29b82..8dfeaff25350 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -3324,7 +3324,8 @@ static uint64_t aa64_dczid_read(CPUARMState *env, const ARMCPRegInfo *ri)
> the name of the function seems to indicate you read the whole DCZID but
> I see the DZP bit is tweaked below. Do you get why we can't return the
> raw id reg?

See above -- the value of DZP depends on the current EL (and some other
bits, which don't change.)

>>      if (aa64_zva_access(env, NULL, false) == CP_ACCESS_OK) {
>>          dzp_bit = 0;
>>      }
>> -    return cpu->dcz_blocksize | dzp_bit;
>> +
> nit spurious NL

ok

>> +    return cpu->isar.idregs[DCZID_EL0_IDX] | dzp_bit;
>>  }
>>  
>>  static CPAccessResult sp_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 0d57081e69fb..5d65f64addc6 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -2020,6 +2020,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>      }
>>      cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
>>  
>> +    /*
>> +     * We currently do not need this, except for tcg. Should KVM gain support
>> +     * for accessing DCZID_EL0 via ONE_REG, we'll overwrite this below. Just
>> +     * set a dummy value that corresponds to the minimum value for FEAT_MTE2.
>> +     */
>> +    set_dcz_blocksize(cpu, 2);
> it is not clear to me why we need that?

We currently don't use it for kvm, but I wanted to put something
non-bogus there. Alternatively, we could moan if we try to access the
reg under kvm.

>> +
>>      return kvm_arm_init_cpreg_list(cpu);
>>  }
>>  


