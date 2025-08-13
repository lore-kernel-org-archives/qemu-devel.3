Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03586C87FCF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 10:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um8JB-0002BZ-VZ; Wed, 13 Aug 2025 06:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1um8J8-0002AX-Oc
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1um8J4-0004A2-7z
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 06:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755079320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8CNuR+QnjfIx82z9oQ6zipAfF/tBTWho/+2yiPk7vk=;
 b=HzOw0eX8sHtyM/V5t2Y8ooXxKMA0LKdiJGblGJHncQTlgj/mC9YFuW9kmTIqDI1sLBjS/6
 BgzrwgA2j4ehXq1WCeXuIeuy43OX/vmxp+Bv3i+chLeOPLirrG1gVBs3XHAhnfY6U5TGWj
 e9vciN22tRuiGuCmvj6PYx1tRf41FtU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-vI8OGwcWMIOKixQC35z4PA-1; Wed,
 13 Aug 2025 06:01:59 -0400
X-MC-Unique: vI8OGwcWMIOKixQC35z4PA-1
X-Mimecast-MFC-AGG-ID: vI8OGwcWMIOKixQC35z4PA_1755079318
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4155195608E; Wed, 13 Aug 2025 10:01:57 +0000 (UTC)
Received: from localhost (dhcp-192-236.str.redhat.com [10.33.192.236])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23B20180047F; Wed, 13 Aug 2025 10:01:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC] arm/kvm: report registers we failed to set
In-Reply-To: <88812eea-08e3-48f5-b2f8-75ab0fff573b@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20250721161932.548668-1-cohuck@redhat.com>
 <88812eea-08e3-48f5-b2f8-75ab0fff573b@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Wed, 13 Aug 2025 12:01:54 +0200
Message-ID: <875xerfskt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 12 2025, Eric Auger <eric.auger@redhat.com> wrote:

> Hi Connie,
>
> On 7/21/25 6:19 PM, Cornelia Huck wrote:
>> If we fail migration because of a mismatch of some registers between
>> source and destination, the error message is not very informative:
>>
>> qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
>> qemu-system-aarch64: Failed to put registers after init: Invalid argument
>>
>> At least try to give the user a hint which registers had a problem,
>> even if they cannot really do anything about it right now.
>>
>> Sample output:
>>
>> Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)
>>
>> We could be even more helpful once we support writable ID registers,
>> at which point the user might actually be able to configure something
>> that is migratable.
>>
>> Suggested-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>
>> Notes:
>> - This currently prints the list of failing registers for every call to
>>   write_list_to_kvmstate(), in particular for every cpu -- we might want
>>   to reduce that.
>> - If the macros aren't too ugly (or we manage to improve them), there
>>   might be other places where they could be useful.
>>
>> ---
>>  target/arm/kvm.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 667234485547..ac6502e0c78f 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -900,6 +900,24 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
>>      return ok;
>>  }
>>  
>> +/* pretty-print a KVM register */
>> +#define CP_REG_ARM64_SYSREG_OP(_reg, _op)                       \
>> +    ((uint8_t)((_reg & CP_REG_ARM64_SYSREG_ ## _op ## _MASK) >> \
>> +               CP_REG_ARM64_SYSREG_ ## _op ## _SHIFT))
>> +
>> +#define PRI_CP_REG_ARM64_SYSREG(_reg)                    \
>> +    ({                                                   \
>> +        char _out[32];                                   \
>> +        snprintf(_out, sizeof(_out),                     \
>> +                 "op0:%d op1:%d crn:%d crm:%d op2:%d",   \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP0),      \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP1),      \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRN),      \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRM),      \
>> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP2));     \
>> +        _out;                                            \
>> +    })
>> +
> I am afraid this is too simplistic.
> Refering to linux/Documentation/virt/kvm/api.rst 4.68 KVM_SET_ONE_REG
> ARM registers section
> there are different groups of registers (upper 16b) and not all regs are
> further identified by op0-2, crn, crm.
> I think it would be valuable to output the group type and then the
> formatted lower 16b, depending on the group type.
>
> For instance 64b ARM FW pseudo reg is formatted as
> 0x6030 0000 0014 <regno:16>
>
> a diff on reg 0 results in
> qemu-system-aarch64: Could not set register op0:0 op1:0 crn:0 crm:0
> op2:0 to 10003 (is 10001)
> qemu-system-aarch64: error while loading state for instance 0x0 of
> device 'cpu'
> qemu-system-aarch64: Could not set register op0:0 op1:0 crn:0 crm:0
> op2:0 to 10003 (is 10001)
> qemu-system-aarch64: Failed to put registers after init: Invalid argument

You mean smth like

Could not set FW pseudo register <regno> to <val> (is <val>)
Could not set ID register <decoding> to <val> (is <val>)

?


