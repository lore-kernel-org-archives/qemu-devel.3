Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E5FD35159
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7qli-0004q0-Uu; Wed, 01 Apr 2026 04:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w7qlh-0004nV-Kh
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:17:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1w7qlf-0005hZ-JQ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 04:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775031457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xY1SAH+4ld7BiDul+PVUUiw7HR4WUZ3t4f9KwJkRAVY=;
 b=QzFzlMQ4VJGqfFz6yudFszqwBSVtgaoN0JAlLcs66fQ77n6qoeZFmKowhL8X4KpYkUIm1a
 snzcqTyHI1I/8KF2zCPuh6sYivKsi/pYI5EHIPT9im1rdg3ry2/LBZqnU7Vt+WtUDCyYN7
 n/LSyzHYOgl2gW+OiphoPJbJsnet+AY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-OuAuK_4ZN5mC52-VYuFMhQ-1; Wed,
 01 Apr 2026 04:17:36 -0400
X-MC-Unique: OuAuK_4ZN5mC52-VYuFMhQ-1
X-Mimecast-MFC-AGG-ID: OuAuK_4ZN5mC52-VYuFMhQ_1775031455
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72DFA1800344; Wed,  1 Apr 2026 08:17:35 +0000 (UTC)
Received: from localhost (dhcp-192-210.str.redhat.com [10.33.192.210])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEB4F19560AB; Wed,  1 Apr 2026 08:17:34 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/3] arm: handle demuxed ID registers
In-Reply-To: <8ecca07b-7ff0-4a46-8de3-6a3f21173a00@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260204133229.297061-1-cohuck@redhat.com>
 <20260204133229.297061-2-cohuck@redhat.com>
 <8ecca07b-7ff0-4a46-8de3-6a3f21173a00@linaro.org>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 01 Apr 2026 10:17:32 +0200
Message-ID: <87bjg3drhf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Feb 05 2026, Richard Henderson <richard.henderson@linaro.org> wrote:

> On 2/4/26 23:32, Cornelia Huck wrote:
>> For some registers, we do not have a single ID register, but actually
>> an array of values (e.g. CCSIDR_EL1, where the actual value is
>> determined by whatever CSSELR_EL1 points to.) If we want to avoid
>> using a different way to handle registers like that for every
>> instance, we should provide some kind of infrastructure. Therefore,
>> add accessors {GET,SET}_IDREG_DEMUX that are similar to the accessors
>> we already use for regular ID registers.
>> 
>> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
>> Reviewed-by: Sebastian Ott <sebott@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>   target/arm/cpu-sysregs.h | 13 +++++++++++++
>>   target/arm/cpu.h         | 20 ++++++++++++++++++++
>>   2 files changed, 33 insertions(+)
>> 
>> diff --git a/target/arm/cpu-sysregs.h b/target/arm/cpu-sysregs.h
>> index 7877a3b06a8e..911f54bc8a4f 100644
>> --- a/target/arm/cpu-sysregs.h
>> +++ b/target/arm/cpu-sysregs.h
>> @@ -35,6 +35,19 @@ typedef enum ARMSysRegs {
>>   
>>   #undef DEF
>>   
>> +/* ID registers that vary based upon another register */
>> +typedef enum ARMIDRegisterDemuxIdx {
>> +    NUM_ID_DEMUX_IDX,
>> +} ARMIDRegisterDemuxIdx;
>> +
>> +/*
>> + * Number of register variants per demuxed register, trying to accommodate
>> + * possible use cases.
>> + * CCSIDR_EL1 currently needs 7*2, could be 7 more with FEAT_MTE2, in which
>> + * case we would need to bump this number.
>> + */
>> +#define ID_DEMUX_ARRAYLEN 16
>> +
>>   extern const uint32_t id_register_sysreg[NUM_ID_IDX];
>>   
>>   int get_sysreg_idx(ARMSysRegs sysreg);
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index 21fee5e840b7..f9d51c0fc187 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -906,6 +906,25 @@ typedef struct {
>>           i_->idregs[REG ## _EL1_IDX];                                    \
>>       })
>>   
>> +#define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
>> +    ({                                                                  \
>> +        ARMISARegisters *i_ = (ISAR);                                   \
>> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX] = VALUE;         \
>> +    })
>> +
>> +#define GET_IDREG_DEMUX(ISAR, REG, INDEX)                               \
>> +    ({                                                                  \
>> +        ARMISARegisters *i_ = (ISAR);                                   \
>> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][INDEX];                 \
>> +    })
>> +
>> +#define COPY_IDREG_DEMUX(ISAR, REG, FROM_INDEX, TO_INDEX)               \
>> +    ({                                                                  \
>> +        ARMISARegisters *i_ = (ISAR);                                   \
>> +        i_->idregs_demux[REG ## _EL1_DEMUX_IDX][TO_INDEX] =             \
>> +            i_->idregs_demux[REG ## _EL1_DEMUX_IDX][FROM_INDEX];        \
>> +    })
>> +
>>   /**
>>    * ARMCPU:
>>    * @env: #CPUARMState
>> @@ -1084,6 +1103,7 @@ struct ArchCPU {
>>           uint32_t dbgdevid1;
>>           uint64_t reset_pmcr_el0;
>>           uint64_t idregs[NUM_ID_IDX];
>> +        uint64_t idregs_demux[NUM_ID_DEMUX_IDX][ID_DEMUX_ARRAYLEN];

[Oops, totally overlooked this email! Sorry about that.]

>
> I'm not keen on this.  Surely we don't expect all multiplexed ID registers to have the 
> same number of sub-registers?  A rectangular matrix isn't a great representation.  Also, 
> you're wasting a hole in idregs[] with CSSIDR_EL1_IDX.
>
> Why not just have the N sub-registers occupy N entries within the regular idregs[]? 
> Something like
>
> #define DEF_MUX(NAME, OP0, OP1, CRN, CRM, OP2, NUM) \
>      NAME##_DEMUX_IDX,                               \
>      NAME##_DEMUX_LAST = NAME##_DEMUX_IDX + NUM - 1,
>
> #define SET_IDREG_DEMUX(ISAR, REG, INDEX, VALUE)                        \
>      ({                                                                  \
>          ARMISARegisters *i_ = (ISAR);                                   \
>          i_->idregs_demux[REG ## _EL1_DEMUX_IDX + INDEX] = VALUE;        \
>      })
>
> etc.

Yeah, I was not overly excited about my solution, either. I'll go and
play with this, thanks.


