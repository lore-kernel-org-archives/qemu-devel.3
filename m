Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA61C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqGE-0000jf-Ly; Tue, 13 May 2025 10:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uEqGB-0000iq-Ed
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uEqG9-0003OA-AP
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747145127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uk82EjzJtnyar56E26L6uDoZS2+bPln9a7V28aPdNsM=;
 b=BlX7XblMcrSm0WXJavtHND4pfziY9/56Jv8GCbfBohbtLfsh6wkwS0bKkjMQa+mO0draG3
 FC7PvLRuM7xg0WSdk8DbfsZS4gRxqLFa/shBvDK2Ff03JHcPVe5hLiljv1AQwpxEosUreM
 3n/+I/qeOJ4X8PFwdyho6QQgTqBNTJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-l9mYAlONNdeqolyRROXIag-1; Tue,
 13 May 2025 10:05:24 -0400
X-MC-Unique: l9mYAlONNdeqolyRROXIag-1
X-Mimecast-MFC-AGG-ID: l9mYAlONNdeqolyRROXIag_1747145122
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDD37195DE5B; Tue, 13 May 2025 14:05:20 +0000 (UTC)
Received: from localhost (dhcp-192-216.str.redhat.com [10.33.192.216])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8CEE19373EB; Tue, 13 May 2025 14:05:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 01/10] arm/cpu: Add infra to handle generated ID
 register definitions
In-Reply-To: <6c06a198-1608-4919-8b6e-68e3c28c2526@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-2-cohuck@redhat.com>
 <6c06a198-1608-4919-8b6e-68e3c28c2526@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 13 May 2025 16:05:16 +0200
Message-ID: <87bjrwppwj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> The known ID regs are described in a new initialization function
>> dubbed initialize_cpu_sysreg_properties(). That code will be
>> automatically generated from linux arch/arm64/tools/sysreg. For the
>> time being let's just describe a single id reg, CTR_EL0. In this
>> description we only care about non RES/RAZ fields, ie. named fields.
>>
>> The registers are populated in an array indexed by ARMIDRegisterIdx
>> and their fields are added in a sorted list.
>>
>> [CH: adapted to reworked register storage]
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  target/arm/cpu-custom.h            | 60 ++++++++++++++++++++++++++++++
>>  target/arm/cpu-sysreg-properties.c | 41 ++++++++++++++++++++
>>  target/arm/cpu64.c                 |  2 +
>>  target/arm/meson.build             |  1 +
>>  4 files changed, 104 insertions(+)
>>  create mode 100644 target/arm/cpu-custom.h
> do we still want reference to the "custom" terminology, following
> initial comments?

Hm, maybe 'cpu-idregs.h'?

>>  create mode 100644 target/arm/cpu-sysreg-properties.c
>>
>> diff --git a/target/arm/cpu-custom.h b/target/arm/cpu-custom.h
>> new file mode 100644
>> index 000000000000..615347376e56
>> --- /dev/null
>> +++ b/target/arm/cpu-custom.h
>> @@ -0,0 +1,60 @@
>> +/*
>> + * handle ID registers and their fields
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +#ifndef ARM_CPU_CUSTOM_H
>> +#define ARM_CPU_CUSTOM_H
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "cpu.h"
>> +#include "cpu-sysregs.h"
>> +
>> +typedef struct ARM64SysRegField {
>> +    const char *name; /* name of the field, for instance CTR_EL0_IDC */
>> +    int index;
> worth to add a comment saying this is the ARMIDRegisterIdx of the parent
> sysreg.

ok

>> +    int lower;
>> +    int upper;
>> +} ARM64SysRegField;
>> +
>> +typedef struct ARM64SysReg {
>> +    const char *name;   /* name of the sysreg, for instance CTR_EL0 */
>> +    ARMSysRegs sysreg;
>> +    int index;
> now that we have different kinds of indexing, may be worth adding a
> comment to explain which one is being used.
> I guess here it is ARMIDRegisterIdx. So you could even change the data type.

Yeah, comments are good, I'll add some.

>> +    GList *fields; /* list of named fields, excluding RES* */
>> +} ARM64SysReg;
>> +
>> +void initialize_cpu_sysreg_properties(void);
>> +
>> +/*
>> + * List of exposed ID regs (automatically populated from linux
>> + * arch/arm64/tools/sysreg)
>> + */
>> +extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
>> +
>> +/* Allocate a new field and insert it at the head of the @reg list */
>> +static inline GList *arm64_sysreg_add_field(ARM64SysReg *reg, const char *name,
>> +                                     uint8_t min, uint8_t max) {
>> +
>> +     ARM64SysRegField *field = g_new0(ARM64SysRegField, 1);
>> +
>> +     field->name = name;
>> +     field->lower = min;
>> +     field->upper = max;
>> +     field->index = reg->index;
>> +
>> +     reg->fields = g_list_append(reg->fields, field);
>> +     return reg->fields;
>> +}
>> +
>> +static inline ARM64SysReg *arm64_sysreg_get(ARMIDRegisterIdx index)
>> +{
>> +        ARM64SysReg *reg = &arm64_id_regs[index];
>> +
>> +        reg->index = index;
>> +        reg->sysreg = id_register_sysreg[index];
>> +        return reg;
>> +}
>> +
>> +#endif
>> diff --git a/target/arm/cpu-sysreg-properties.c b/target/arm/cpu-sysreg-properties.c
>> new file mode 100644
>> index 000000000000..8b7ef5badfb9
>> --- /dev/null
>> +++ b/target/arm/cpu-sysreg-properties.c
>> @@ -0,0 +1,41 @@
>> +/*
>> + * QEMU ARM CPU SYSREG PROPERTIES
>> + * to be generated from linux sysreg
>> + *
>> + * Copyright (c) Red Hat, Inc. 2024
> maybe increment the year now ;-)

Wait, it is 2025 already? :)


