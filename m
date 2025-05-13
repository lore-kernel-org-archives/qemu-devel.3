Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4901DC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqqN-0006Ic-Vi; Tue, 13 May 2025 10:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uEqqK-0006IJ-T9
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uEqqJ-0000oL-45
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747147369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p6Pc/DoCV1c6L4UtfRaupclGbLmRZkZUjIct4ZRvSAg=;
 b=WS7q8yzUOErU/ktv/5H6y0TdsR/AeRxuZz/EKQfDEXxkEFWT4f4dgdGch8y4aFLOxTZCKx
 337G+6cie3keLbYH+W1JhEBeAVI9u7u7+xdOlM3pxrNxMwqyjYmFTo8MVqikFn1m1GoDqZ
 55w70PvQ6cxeGiSWz2Mqto07ctd+IZE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-qDPC7BQuNki1Jg3wfs3r-A-1; Tue,
 13 May 2025 10:42:45 -0400
X-MC-Unique: qDPC7BQuNki1Jg3wfs3r-A-1
X-Mimecast-MFC-AGG-ID: qDPC7BQuNki1Jg3wfs3r-A_1747147362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 085671800368; Tue, 13 May 2025 14:42:42 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D93A7180049D; Tue, 13 May 2025 14:42:40 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 04/10] kvm: kvm_get_writable_id_regs
In-Reply-To: <4f370fae-8234-48ca-97e2-3b7038092974@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-5-cohuck@redhat.com>
 <4f370fae-8234-48ca-97e2-3b7038092974@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 13 May 2025 16:42:38 +0200
Message-ID: <878qn0po69.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 13 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Hi Connie,
>
> On 4/14/25 6:38 PM, Cornelia Huck wrote:
>> Add an helper to retrieve the writable id reg bitmask. The
>> status of the query is stored in the CPU struct so that an
>> an error, if any, can be reported on vcpu realize().
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu.h     | 26 ++++++++++++++++++++++++++
>>  target/arm/kvm.c     | 32 ++++++++++++++++++++++++++++++++
>>  target/arm/kvm_arm.h |  7 +++++++
>>  3 files changed, 65 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index d27134f4a025..bbee7ff2414a 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -856,6 +856,26 @@ typedef struct {
>>      uint32_t map, init, supported;
>>  } ARMVQMap;
>>  
>> +typedef enum ARMIdRegsState {
>> +    WRITABLE_ID_REGS_UNKNOWN,
>> +    WRITABLE_ID_REGS_NOT_DISCOVERABLE,
>> +    WRITABLE_ID_REGS_FAILED,
>> +    WRITABLE_ID_REGS_AVAIL,
>> +} ARMIdRegsState;
>> +
>> +/*
>> + * The following structures are for the purpose of mapping the output of
>> + * KVM_ARM_GET_REG_WRITABLE_MASKS that also may cover id registers we do
>> + * not support in QEMU
>> + * ID registers in op0==3, op1=={0,1,3}, crn=0, crm=={0-7}, op2=={0-7},
>> + * as used by the KVM_ARM_GET_REG_WRITABLE_MASKS ioctl call.
>> + */
>> +#define NR_ID_REGS (3 * 8 * 8)
> We may rename this define to better associate to the KVM API. I tend to
> mix it with NUM_ID_IDX now ;-)
> maybe something like KVM_NR_EXPOSED_ID_REGS

The kernel calls it KVM_FEATURE_ID_RANGE_SIZE, but I'd like to avoid
adding 'KVM' in the name, as it is basically a range of registers and
nothing really KVM specific... maybe ID_REG_RANGE_SIZE?

>> +
>> +typedef struct IdRegMap {
>> +    uint64_t regs[NR_ID_REGS];
>> +} IdRegMap;
> I would add a comment saying this is the mask array, just to prevent the
> reading from thinking it is the actual reg content.

"More comments" seems to be a theme :) I'll go ahead and add them where
it makes sense.

>> +
>>  /* REG is ID_XXX */
>>  #define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
>>      ({                                                                  \
>> @@ -1044,6 +1064,12 @@ struct ArchCPU {
>>       */
>>      bool host_cpu_probe_failed;
>>  
>> +    /*
>> +     * state of writable id regs query used to report an error, if any,
>> +     * on KVM custom vcpu model realize
>> +     */
>> +    ARMIdRegsState writable_id_regs;
> maybe rename into writable_id_reg_status that would better reflect what
> it is.

Indeed.


