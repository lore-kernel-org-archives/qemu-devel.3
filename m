Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4FAC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 13:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA7nm-0006SM-9c; Wed, 30 Apr 2025 09:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uA7nk-0006Qb-27
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 09:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uA7nh-00024T-Vq
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 09:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746020915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLVOo1RS7FiUiZjstQUcuIC9vXhBzHVmV4xEjiYp0vQ=;
 b=FAwWPK7ljQ1bMTT99ZTQIQ6WCOE14XMh/iaOCQJyDQxd1fudU5ByVcayxiQTcJ6+rJuk0T
 xgFYLywlvpC6v0BoiUSZsH0zxGn6LuL4A+8uWZxlvB9cQZq7XfB25/wpTG5fYi67TCCo7W
 WgC9fmI8OJok7yOD66aPcYhnkXdUXZM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-9t1_IlpnMES5Gy2AHNDGcA-1; Wed,
 30 Apr 2025 09:48:32 -0400
X-MC-Unique: 9t1_IlpnMES5Gy2AHNDGcA-1
X-Mimecast-MFC-AGG-ID: 9t1_IlpnMES5Gy2AHNDGcA_1746020910
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0574B1800446; Wed, 30 Apr 2025 13:48:29 +0000 (UTC)
Received: from localhost (unknown [10.67.24.156])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 100E919560A3; Wed, 30 Apr 2025 13:48:25 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Sebastian Ott <sebott@redhat.com>
Cc: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, shameerali.kolothum.thodi@huawei.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com, agraf@csgraf.de, shahuang@redhat.com,
 mark.rutland@arm.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 05/10] arm/cpu: accessors for writable id registers
In-Reply-To: <bebefcad-d9db-a2b7-ab69-8eed34b9e63d@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-6-cohuck@redhat.com>
 <bebefcad-d9db-a2b7-ab69-8eed34b9e63d@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 30 Apr 2025 15:48:19 +0200
Message-ID: <877c31rc9o.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Apr 29 2025, Sebastian Ott <sebott@redhat.com> wrote:

> On Mon, 14 Apr 2025, Cornelia Huck wrote:
>> Also add conversion between the different indices.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>> target/arm/cpu.h | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index bbee7ff2414a..775a8aebc5d3 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -876,6 +876,13 @@ typedef struct IdRegMap {
>>     uint64_t regs[NR_ID_REGS];
>> } IdRegMap;
>>
>> +#define ARM_FEATURE_ID_RANGE_IDX(op0, op1, crn, crm, op2)               \
>> +        ({                                                              \
>> +                __u64 __op1 = (op1) & 3;                                \
>> +                __op1 -= (__op1 == 3);                                  \
>> +                (__op1 << 6 | ((crm) & 7) << 3 | (op2));                \
>> +        })
>> +
>> /* REG is ID_XXX */
>> #define FIELD_DP64_IDREG(ISAR, REG, FIELD, VALUE)                       \
>>     ({                                                                  \
>> @@ -923,6 +930,17 @@ typedef struct IdRegMap {
>>         i_->idregs[REG ## _EL1_IDX];                                    \
>>     })
>>
>> +#define GET_IDREG_WRITABLE(MAP, REG)                                  \
>> +    ({                                                                \
>> +    const IdRegMap *m_ = (MAP);                                       \
>> +    int index = ARM_FEATURE_ID_RANGE_IDX((sysreg >> 14) & 0x0000c000, \
>> +                                         (sysreg >> 11) & 0x00003800, \
>> +                                         (sysreg >> 7) & 0x00000780,  \
>> +                                         (sysreg >> 3) & 0x00000078,  \
>> +                                         sysreg & 0x00000007);        \
>> +    m_->regs[index];                                                  \
>> +    })
>> +
>
> s/sysreg/REG/
>
> Also GET_IDREG_WRITABLE doesn't seem to be used in this series.

Hm, and it wouldn't have worked if we did use it... probably an artifact
left over from earlier refactorings, I think we can get rid of it.


