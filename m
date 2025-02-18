Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB46C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQ7t-00065h-KY; Tue, 18 Feb 2025 11:07:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkQ7p-000652-Fh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tkQ7m-0006Pr-0l
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739894824;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3g9jows/4/+ShPFJxsYWAQAkLb0y/5Wvk4/3mwEv5w=;
 b=LWGpSukJ/IDiMnGJ7BReCwl+2dxGFgXcPkS3GmTnPmfxeeRa7SLxXXzIaRb7k3FAuzYK0k
 Ta+RjWStse+7gMff1Z9sFd57ffGagbebuetTj93SdN9DBg9416jrLN/lD7xVCYc2uqKrUI
 hoKClYfBdMWr3MM/+xZrUEXPOG9gSIQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-V0_5MLOvNnG9hqp9BCFH6A-1; Tue, 18 Feb 2025 11:07:03 -0500
X-MC-Unique: V0_5MLOvNnG9hqp9BCFH6A-1
X-Mimecast-MFC-AGG-ID: V0_5MLOvNnG9hqp9BCFH6A_1739894822
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4393e8738b3so47511615e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739894822; x=1740499622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s3g9jows/4/+ShPFJxsYWAQAkLb0y/5Wvk4/3mwEv5w=;
 b=nR48JST2qQtBzJBl8e8m6mOuiFtNzNoVo1qVewNkUDM3EIQVEw6VPFP0gEAhVrHKHd
 +aM8q0uwWdd784QPlrJQsowuwhT0TAu6/ZGeyk+WHjIA2KFvnyi5bUeWqMYuUbpO2T64
 g+RbfowwBN+fQeKdFzJAkP7GBX3a7XiENI4Kif8DHb9pOtUbGTH7rlhVO97Z3YkdAeWQ
 Ht4xWbsy7SFCC/6A10FbrDJimSWz466YTBAYO6gbYlsGow2eJnNb6F1voVOjA8dIgNSx
 84UsdfdEDuC5B/db37UDTzzGNfmXs/O87UxiM0mKz1yhp05+xS3nAbVb8ZzyYlEalo4i
 pCnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5SOady25ojuTKaWNA2cUL/MbbjJZl9v+XtfuFdY8+uFWcLmmZQrf8AleFSlBIjVY7D10aelWKgQ8p@nongnu.org
X-Gm-Message-State: AOJu0YyDJCaMJ6GlVgDa+qVVKuw57d8cGMxIRhjHhuDki8rsybbwxCRw
 lPxzPF2QkrexKvJRmP0BQwRgE2JG0bnrV7F/AhZmjIgXiRkBH8XDPI8z/bHfrOTQOb9Z/JbJUhA
 tZLHOxYlCNo8+lxpkBgpT81hKe/pnif781Kc5j+6BuOBTvjlDqmaZ
X-Gm-Gg: ASbGnctwD+6No26a76gQJaN9T0RfZa77vcL8T8ZnkvzF9FZkgIYG+oYeY22oKEcOKsH
 vk7px4K2xRxE2nEj9Hyd86GlOMlfMaIwNImWj9EoLINMEtXXIa5EvZugNXXeX5ozsm7oYsoj6wL
 1EUvuq0Jonv7UUkKGUwXFCazm1Q1hOoFYeKkU5v5aq/hwxPd6efW/O77lF/Fd7jS+T4JH6S2lud
 sRknkwHn5k/0Vx2HGJGAz7h2e7jehkxhh6kYCuaL7NNtbY9C1d2Kh5v2Ka9+OdUZrG8y+gPpx41
 saVh1JV6pGkFlWnxr7jSlQ/WlYz7wp9PQblrjIAUGOJzbsk4kKiY
X-Received: by 2002:a05:600c:4e8c:b0:439:33dd:48ea with SMTP id
 5b1f17b1804b1-43999d72091mr2202805e9.2.1739894822018; 
 Tue, 18 Feb 2025 08:07:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsMyDHKAgJhzDk32tn0Woebs43BToX7M4ssqeiTBNIv2bgE7wYwZvGEHmCB35LNPrWcIT0yg==
X-Received: by 2002:a05:600c:4e8c:b0:439:33dd:48ea with SMTP id
 5b1f17b1804b1-43999d72091mr2202075e9.2.1739894821469; 
 Tue, 18 Feb 2025 08:07:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398872fa85sm53409035e9.28.2025.02.18.08.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 08:07:00 -0800 (PST)
Message-ID: <05a1c41e-3436-4117-a22f-61b4e1e2de20@redhat.com>
Date: Tue, 18 Feb 2025 17:06:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] arm/cpu: Add infra to handle generated ID register
 definitions
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250207110248.1580465-1-cohuck@redhat.com>
 <20250207110248.1580465-14-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250207110248.1580465-14-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,


On 2/7/25 12:02 PM, Cornelia Huck wrote:
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

I don't think we need all the infra related to properties in this
prerequisite series. I would postpone it until the main CPU model series.

You can just keep scripts/gen-cpu-sysregs-header.awk to generate the
sysreg definitions
>
> [CH: adapted to reworked register storage]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  target/arm/cpu-custom.h            | 55 ++++++++++++++++++++++++++++++
>  target/arm/cpu-sysreg-properties.c | 41 ++++++++++++++++++++++
>  target/arm/cpu64.c                 |  2 ++
>  target/arm/meson.build             |  1 +
>  4 files changed, 99 insertions(+)
>  create mode 100644 target/arm/cpu-custom.h
>  create mode 100644 target/arm/cpu-sysreg-properties.c
>
> diff --git a/target/arm/cpu-custom.h b/target/arm/cpu-custom.h
by the custom we may get rid of the 'custom' terminology
> new file mode 100644
> index 000000000000..17533765dacd
> --- /dev/null
> +++ b/target/arm/cpu-custom.h
> @@ -0,0 +1,55 @@
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
> +    int lower;
> +    int upper;
> +} ARM64SysRegField;
> +
> +typedef struct ARM64SysReg {
> +    const char *name;   /* name of the sysreg, for instance CTR_EL0 */
> +    ARMSysRegs sysreg;
> +    int index;
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
> index beba1733c99f..8371aabce5f4 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -35,6 +35,7 @@
>  #include "internals.h"
>  #include "cpu-features.h"
>  #include "cpregs.h"
> +#include "cpu-custom.h"
>  
>  void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>  {
> @@ -894,6 +895,7 @@ static void aarch64_cpu_register_types(void)
>  {
>      size_t i;
>  
> +    initialize_cpu_sysreg_properties();
>      type_register_static(&aarch64_cpu_type_info);
>  
>      for (i = 0; i < ARRAY_SIZE(aarch64_cpus); ++i) {
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 2e10464dbb6b..9c7a04ee1b26 100644
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
Thanks

Eric


