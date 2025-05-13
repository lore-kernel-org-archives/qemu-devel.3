Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF58C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErIi-0001Zd-FB; Tue, 13 May 2025 11:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uErIf-0001Ys-5J
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:12:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uErIc-0004KW-Ud
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747149125;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/KQTBCUFT6lIczxYv9kya2WRKORWdtfT/IOQQeFA4I=;
 b=Q1X25Qs14OpVXU57vKlfTn11CEX3jsKh7vgV8rQ6WQzpVGGxcm7azcjReG/prCOrs5yXio
 15qfNspBjtohGbCDA3cylfxaRS0ma9Y9tLhkkL6xWKqC2PyZaRpkpPXjg61v80sNtBbCtU
 E8UeZ+YsLagYWStj28mE2No+la5sqYI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-z6I6AuYoOwe9LG6-YfqnCA-1; Tue, 13 May 2025 11:12:04 -0400
X-MC-Unique: z6I6AuYoOwe9LG6-YfqnCA-1
X-Mimecast-MFC-AGG-ID: z6I6AuYoOwe9LG6-YfqnCA_1747149123
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-442ccf0eb4eso42564535e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 08:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747149123; x=1747753923;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/KQTBCUFT6lIczxYv9kya2WRKORWdtfT/IOQQeFA4I=;
 b=UKxAm7a8qwhhbakMGr2+Y+vGn+UKVcxR4y3l0Jn87T//ZyS5RIcC0UoOmlUOcemP7t
 c+wNWpl/PznDCwZNiKNxXVyj8y1bOh7g7pLNvgUnuX9SPIAVJiN9+AnwhOYC/YykE81S
 OxI259HPd6M1ov15+JW3sCqffYXwbRuoXKTtfSjFFX9YTv1fzxvls/mJso/QxNPGXATz
 QHOwEIYwI3+ZpUe64OqmXu8jC/Fi3h4b/geQCGWVKf5MrMuKITfuyUsBKc3AHwM0YBlX
 npGqlp8LyMzpvDx186EFw6vFkC4T947taf8BFu/qPgb5gTCu93VthPt/1TAO7b7yr9qG
 O4HA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm8mLwP4l7iuhdu5QndiEROLQfsxbiJZGuHYzF/TGbcPNd4bjCcq1IKsR1uS2jeY6a5bXVDP24BiOA@nongnu.org
X-Gm-Message-State: AOJu0YwLloWU/yy7JQdJuGCW4vnFnyE3kIqNlSujGLcJkBS4bq62pCLq
 pAojM8X/rDGEodEIzp2j0MNSaRalQvY5p2ZCgP86BmRILpDKOJq77yzd1OsEENrCsHFL3vWph2I
 xtOHSi6iYeF1JOANVxtJUtsGE2ch6rbnLEQ3g4U68dO9pkDXJw8/u
X-Gm-Gg: ASbGncv5NnneL+EUQ0z7Cn439F3Njvx9oVbpp2ZIJSDb3Pxs/XlSYVHxIhgJ1wJzKj3
 wkw9KBxkVW8BxmbsMY/t2w0XtbUPAAZU5L8MtvnHMxNjwpOCbKpgbuxtk/JeqgKa5Z2/s6Z6PXj
 zL66LFC/e/f2qYgEPmKVa8TrFeAeL1uITkRXSwR1bhp1pGnDzFh1GB8rmrcf8yDAXNLbrvD4Jgb
 J8QMTYLUO7holcpKINvGOHQfCe8Nw7KshA57WORlw2yydxQ+bcCyktPOGoJoqde3b/+oKrFRkvf
 xaOFHJM54elMH7UzKOlBRx0NkZPz9fkFlqgRBzOsHo7kRROofCfM/bBBA/M=
X-Received: by 2002:a05:600c:4454:b0:440:6a5f:c308 with SMTP id
 5b1f17b1804b1-442d6d44bd0mr180390925e9.13.1747149122890; 
 Tue, 13 May 2025 08:12:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEWMXqYkLvMeaU7iQvq+Zw2kcbCGYoc0n05zU9v6tGqcMeMfS9BUjhUzvzh7oe31939OLWUQ==
X-Received: by 2002:a05:600c:4454:b0:440:6a5f:c308 with SMTP id
 5b1f17b1804b1-442d6d44bd0mr180390485e9.13.1747149122480; 
 Tue, 13 May 2025 08:12:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4c76dsm16745142f8f.92.2025.05.13.08.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 08:12:01 -0700 (PDT)
Message-ID: <3ad1d053-8a11-4a28-9a94-778389addfeb@redhat.com>
Date: Tue, 13 May 2025 17:12:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] arm/cpu: Add infra to handle generated ID
 register definitions
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-2-cohuck@redhat.com>
 <6c06a198-1608-4919-8b6e-68e3c28c2526@redhat.com> <87bjrwppwj.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87bjrwppwj.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/13/25 4:05 PM, Cornelia Huck wrote:
> On Tue, May 13 2025, Eric Auger <eric.auger@redhat.com> wrote:
>
>> Hi Connie,
>>
>> On 4/14/25 6:38 PM, Cornelia Huck wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> The known ID regs are described in a new initialization function
>>> dubbed initialize_cpu_sysreg_properties(). That code will be
>>> automatically generated from linux arch/arm64/tools/sysreg. For the
>>> time being let's just describe a single id reg, CTR_EL0. In this
>>> description we only care about non RES/RAZ fields, ie. named fields.
>>>
>>> The registers are populated in an array indexed by ARMIDRegisterIdx
>>> and their fields are added in a sorted list.
>>>
>>> [CH: adapted to reworked register storage]
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>> ---
>>>  target/arm/cpu-custom.h            | 60 ++++++++++++++++++++++++++++++
>>>  target/arm/cpu-sysreg-properties.c | 41 ++++++++++++++++++++
>>>  target/arm/cpu64.c                 |  2 +
>>>  target/arm/meson.build             |  1 +
>>>  4 files changed, 104 insertions(+)
>>>  create mode 100644 target/arm/cpu-custom.h
>> do we still want reference to the "custom" terminology, following
>> initial comments?
> Hm, maybe 'cpu-idregs.h'?
OK for me

Eric
>
>>>  create mode 100644 target/arm/cpu-sysreg-properties.c
>>>
>>> diff --git a/target/arm/cpu-custom.h b/target/arm/cpu-custom.h
>>> new file mode 100644
>>> index 000000000000..615347376e56
>>> --- /dev/null
>>> +++ b/target/arm/cpu-custom.h
>>> @@ -0,0 +1,60 @@
>>> +/*
>>> + * handle ID registers and their fields
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +#ifndef ARM_CPU_CUSTOM_H
>>> +#define ARM_CPU_CUSTOM_H
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/error-report.h"
>>> +#include "cpu.h"
>>> +#include "cpu-sysregs.h"
>>> +
>>> +typedef struct ARM64SysRegField {
>>> +    const char *name; /* name of the field, for instance CTR_EL0_IDC */
>>> +    int index;
>> worth to add a comment saying this is the ARMIDRegisterIdx of the parent
>> sysreg.
> ok
>
>>> +    int lower;
>>> +    int upper;
>>> +} ARM64SysRegField;
>>> +
>>> +typedef struct ARM64SysReg {
>>> +    const char *name;   /* name of the sysreg, for instance CTR_EL0 */
>>> +    ARMSysRegs sysreg;
>>> +    int index;
>> now that we have different kinds of indexing, may be worth adding a
>> comment to explain which one is being used.
>> I guess here it is ARMIDRegisterIdx. So you could even change the data type.
> Yeah, comments are good, I'll add some.
>
>>> +    GList *fields; /* list of named fields, excluding RES* */
>>> +} ARM64SysReg;
>>> +
>>> +void initialize_cpu_sysreg_properties(void);
>>> +
>>> +/*
>>> + * List of exposed ID regs (automatically populated from linux
>>> + * arch/arm64/tools/sysreg)
>>> + */
>>> +extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
>>> +
>>> +/* Allocate a new field and insert it at the head of the @reg list */
>>> +static inline GList *arm64_sysreg_add_field(ARM64SysReg *reg, const char *name,
>>> +                                     uint8_t min, uint8_t max) {
>>> +
>>> +     ARM64SysRegField *field = g_new0(ARM64SysRegField, 1);
>>> +
>>> +     field->name = name;
>>> +     field->lower = min;
>>> +     field->upper = max;
>>> +     field->index = reg->index;
>>> +
>>> +     reg->fields = g_list_append(reg->fields, field);
>>> +     return reg->fields;
>>> +}
>>> +
>>> +static inline ARM64SysReg *arm64_sysreg_get(ARMIDRegisterIdx index)
>>> +{
>>> +        ARM64SysReg *reg = &arm64_id_regs[index];
>>> +
>>> +        reg->index = index;
>>> +        reg->sysreg = id_register_sysreg[index];
>>> +        return reg;
>>> +}
>>> +
>>> +#endif
>>> diff --git a/target/arm/cpu-sysreg-properties.c b/target/arm/cpu-sysreg-properties.c
>>> new file mode 100644
>>> index 000000000000..8b7ef5badfb9
>>> --- /dev/null
>>> +++ b/target/arm/cpu-sysreg-properties.c
>>> @@ -0,0 +1,41 @@
>>> +/*
>>> + * QEMU ARM CPU SYSREG PROPERTIES
>>> + * to be generated from linux sysreg
>>> + *
>>> + * Copyright (c) Red Hat, Inc. 2024
>> maybe increment the year now ;-)
> Wait, it is 2025 already? :)
>


