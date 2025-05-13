Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C75C3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 13:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEq4B-0001qe-C1; Tue, 13 May 2025 09:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEq49-0001pu-8F
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEq47-0001q0-0v
 for qemu-devel@nongnu.org; Tue, 13 May 2025 09:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747144381;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qd5j9HGmDqx5UKJ8JxQsW9/d5OfJ5IPgcMenkg8z06g=;
 b=WLTwsq6ZyZ6p4LViHAr+WxevCptooNgBhoGou14BHDguEH1SBF9TgsAMI667oyznpZTb/+
 whYogqnIZ+3V4RgI6MHWsJyv71y+h17wSQqHsvZTjjL09ddOqocNhSEYaF5UxxKDtFbnkV
 ozpCbNdXZyjCL9JgYN5CdvWy2jTxXng=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-hlirZAKZMcOALUxKvI_hEg-1; Tue, 13 May 2025 09:53:00 -0400
X-MC-Unique: hlirZAKZMcOALUxKvI_hEg-1
X-Mimecast-MFC-AGG-ID: hlirZAKZMcOALUxKvI_hEg_1747144379
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b9bbfa5dso1976911f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 06:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747144379; x=1747749179;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qd5j9HGmDqx5UKJ8JxQsW9/d5OfJ5IPgcMenkg8z06g=;
 b=iWkd77nmkGSb02aKBK0UFnCcoRBVaJgzUhj0aBmajU+jKDlshhXuZKPdeqvAoHnKQM
 Gaj6QtE12bFlVWTL/ntR5eYyVHp6USVFu8HPbUHVh7FiqmXhOrRaj0jY50jet6ddXRxR
 D8cYrGtvMz6bOAWf647teYaL+VOGmgqnkcbbMJi5kfDJBTbZmERbHQKWk5mhXJ9gUAgi
 OeyiN8Ta+E0Ln5hacfHtMzP6ncjKaf6nv8z+/0pEr+K5HtlvJh86RTQBTbFexddNn4Cl
 cVrIvA47WLB4hC7z2f1E8tyb3jkOaSmerFIbX1QowG/bODKZrgu6TRs61nVw46ys9JAS
 dqBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVsisMk9icAXaUJV8Gv8cqiPSnx1w7X7VUddR2OzWcqqadVuVLhLQ7uNCby2qbSsf6L+DWiqqPGkBA@nongnu.org
X-Gm-Message-State: AOJu0Yxn6kHQrpTF601U2NT8f47Kj8bQ4zgybTHs4BRWzJOkWWQN4tnC
 cMRDIkDZ4/+39ZGx93sgvg3JGApI5F3dtK99uPFJaKx3NuXz/AYYi7myhQZ2LbmDBtA04K+a2tW
 qYJFiPch0M0NSk+VEu1J7URCMjYi/+ZqSBIpURMnie6qIWAn7Uod5
X-Gm-Gg: ASbGncuCbImlGDddy7Fj9PgKYv/fua5hXRepGCGsNrDAmQ74Msg6JmUZUe85jlyEaTw
 chOiJXVCtz312Ix5bXz2TLt8PysUxO09urkWoqy+AxKk0ZTbchkX4tz0DqyJWOpw0b828+r4ygM
 St/k9sPKMtzfcDWjdi5aI2OQZLky5YXD1Fkkg2lLVhzK1BEKJ2JTEUvjQfVFsvyaa2nmThpVEbT
 pVH4eVxGbuzIGskK2HA1/zb9I8axFJQRZ/1VKBSEX/cLY7nkQTeZBSenjrIau4RSIF8uAy5zFEm
 l/T6dh8zdlGO3UDGWydYXPYVxiibMQOov1ySkhldPUsKRX8LtdglVl4aJqA=
X-Received: by 2002:a5d:584c:0:b0:3a0:a8b1:cf17 with SMTP id
 ffacd0b85a97d-3a1f643711emr13945591f8f.15.1747144378738; 
 Tue, 13 May 2025 06:52:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM5FdATd8pnIJT4WuzmTHicRYMn8uCdk8+cKg2mhf50laTdgXXTyYFJcNb5j0s2R6fWv37Yg==
X-Received: by 2002:a5d:584c:0:b0:3a0:a8b1:cf17 with SMTP id
 ffacd0b85a97d-3a1f643711emr13945557f8f.15.1747144378233; 
 Tue, 13 May 2025 06:52:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddd5esm16148585f8f.6.2025.05.13.06.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 06:52:57 -0700 (PDT)
Message-ID: <6c06a198-1608-4919-8b6e-68e3c28c2526@redhat.com>
Date: Tue, 13 May 2025 15:52:56 +0200
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250414163849.321857-2-cohuck@redhat.com>
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 4/14/25 6:38 PM, Cornelia Huck wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> The known ID regs are described in a new initialization function
> dubbed initialize_cpu_sysreg_properties(). That code will be
> automatically generated from linux arch/arm64/tools/sysreg. For the
> time being let's just describe a single id reg, CTR_EL0. In this
> description we only care about non RES/RAZ fields, ie. named fields.
>
> The registers are populated in an array indexed by ARMIDRegisterIdx
> and their fields are added in a sorted list.
>
> [CH: adapted to reworked register storage]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu-custom.h            | 60 ++++++++++++++++++++++++++++++
>  target/arm/cpu-sysreg-properties.c | 41 ++++++++++++++++++++
>  target/arm/cpu64.c                 |  2 +
>  target/arm/meson.build             |  1 +
>  4 files changed, 104 insertions(+)
>  create mode 100644 target/arm/cpu-custom.h
do we still want reference to the "custom" terminology, following
initial comments?
>  create mode 100644 target/arm/cpu-sysreg-properties.c
>
> diff --git a/target/arm/cpu-custom.h b/target/arm/cpu-custom.h
> new file mode 100644
> index 000000000000..615347376e56
> --- /dev/null
> +++ b/target/arm/cpu-custom.h
> @@ -0,0 +1,60 @@
> +/*
> + * handle ID registers and their fields
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef ARM_CPU_CUSTOM_H
> +#define ARM_CPU_CUSTOM_H
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "cpu.h"
> +#include "cpu-sysregs.h"
> +
> +typedef struct ARM64SysRegField {
> +    const char *name; /* name of the field, for instance CTR_EL0_IDC */
> +    int index;
worth to add a comment saying this is the ARMIDRegisterIdx of the parent
sysreg.
> +    int lower;
> +    int upper;
> +} ARM64SysRegField;
> +
> +typedef struct ARM64SysReg {
> +    const char *name;   /* name of the sysreg, for instance CTR_EL0 */
> +    ARMSysRegs sysreg;
> +    int index;
now that we have different kinds of indexing, may be worth adding a
comment to explain which one is being used.
I guess here it is ARMIDRegisterIdx. So you could even change the data type.
> +    GList *fields; /* list of named fields, excluding RES* */
> +} ARM64SysReg;
> +
> +void initialize_cpu_sysreg_properties(void);
> +
> +/*
> + * List of exposed ID regs (automatically populated from linux
> + * arch/arm64/tools/sysreg)
> + */
> +extern ARM64SysReg arm64_id_regs[NUM_ID_IDX];
> +
> +/* Allocate a new field and insert it at the head of the @reg list */
> +static inline GList *arm64_sysreg_add_field(ARM64SysReg *reg, const char *name,
> +                                     uint8_t min, uint8_t max) {
> +
> +     ARM64SysRegField *field = g_new0(ARM64SysRegField, 1);
> +
> +     field->name = name;
> +     field->lower = min;
> +     field->upper = max;
> +     field->index = reg->index;
> +
> +     reg->fields = g_list_append(reg->fields, field);
> +     return reg->fields;
> +}
> +
> +static inline ARM64SysReg *arm64_sysreg_get(ARMIDRegisterIdx index)
> +{
> +        ARM64SysReg *reg = &arm64_id_regs[index];
> +
> +        reg->index = index;
> +        reg->sysreg = id_register_sysreg[index];
> +        return reg;
> +}
> +
> +#endif
> diff --git a/target/arm/cpu-sysreg-properties.c b/target/arm/cpu-sysreg-properties.c
> new file mode 100644
> index 000000000000..8b7ef5badfb9
> --- /dev/null
> +++ b/target/arm/cpu-sysreg-properties.c
> @@ -0,0 +1,41 @@
> +/*
> + * QEMU ARM CPU SYSREG PROPERTIES
> + * to be generated from linux sysreg
> + *
> + * Copyright (c) Red Hat, Inc. 2024
maybe increment the year now ;-)
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see
> + * <http://www.gnu.org/licenses/gpl-2.0.html>
> + */
> +
> +#include "cpu-custom.h"
> +
> +ARM64SysReg arm64_id_regs[NUM_ID_IDX];
> +
> +void initialize_cpu_sysreg_properties(void)
> +{
> +    memset(arm64_id_regs, 0, sizeof(ARM64SysReg) * NUM_ID_IDX);
> +    /* CTR_EL0 */
> +    ARM64SysReg *CTR_EL0 = arm64_sysreg_get(CTR_EL0_IDX);
> +    CTR_EL0->name = "CTR_EL0";
> +    arm64_sysreg_add_field(CTR_EL0, "TminLine", 32, 37);
> +    arm64_sysreg_add_field(CTR_EL0, "DIC", 29, 29);
> +    arm64_sysreg_add_field(CTR_EL0, "IDC", 28, 28);
> +    arm64_sysreg_add_field(CTR_EL0, "CWG", 24, 27);
> +    arm64_sysreg_add_field(CTR_EL0, "ERG", 20, 23);
> +    arm64_sysreg_add_field(CTR_EL0, "DminLine", 16, 19);
> +    arm64_sysreg_add_field(CTR_EL0, "L1Ip", 14, 15);
> +    arm64_sysreg_add_field(CTR_EL0, "IminLine", 0, 3);
> +}
> +
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 9769401a8585..839442745ea4 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -35,6 +35,7 @@
>  #include "internals.h"
>  #include "cpu-features.h"
>  #include "cpregs.h"
> +#include "cpu-custom.h"
>  
>  /* convert between <register>_IDX and SYS_<register> */
>  #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \
> @@ -891,6 +892,7 @@ static void aarch64_cpu_register_types(void)
>  {
>      size_t i;
>  
> +    initialize_cpu_sysreg_properties();
>      type_register_static(&aarch64_cpu_type_info);
>  
>      for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 3065081d241d..1c97c1ef7580 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -14,6 +14,7 @@ arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>  arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
>    'cpu64.c',
>    'gdbstub64.c',
> +  'cpu-sysreg-properties.c',
>  ))
>  
>  arm_system_ss = ss.source_set()


