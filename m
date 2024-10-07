Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9C4CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 13:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxnLU-0005Ns-Tb; Mon, 07 Oct 2024 09:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxnLF-0005Gw-75
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sxnLB-0006rk-Qk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 09:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728305995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lH3FVvekpqnjNxrrKTGLoKx1238o4ywoFvMB1Gr16gc=;
 b=N3wthmfDEemHwVqieXS2ZyOE4UhgbqtwCOK04Yu4MYPrBeZW3NHvuCDySP7nUzbwIBEHTk
 bPOzuZvpN8hs9E8hxfISdFo0rOrCH7CSdNvtR/LOvvWczVmJ+o71bNTmfuAV+UU9vyPz1W
 QLjV1EV0c1l44rBm9vuPCWj1xK9p8MI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-dDipKSr2NGKuL2bNa182Zg-1; Mon, 07 Oct 2024 08:59:54 -0400
X-MC-Unique: dDipKSr2NGKuL2bNa182Zg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb0b0514bso39437865e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 05:59:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728305993; x=1728910793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lH3FVvekpqnjNxrrKTGLoKx1238o4ywoFvMB1Gr16gc=;
 b=CtTWcPDlfdaLG0tNKpV+XknEpyEl9kPDzwMZg8esybnWeOi6ONAYv9eD2ckGSpyUuc
 q+aoeJm9sauyOfCJ3J3i16dprA2Y8VWoVl3xWqWkcCLnGedX5cXGRmdUb5pdqfn2P50C
 A4rq4TMwG5WRG59OM5tG9GJvi1gCF+GY1FaujQZkQA6ErBdBTR3FKKqvSo8d2uQ01WiS
 QTvvseV6zYGfRP6B9V1qlh9QlU2wcv3RDN/0yiNEmgcst9OLUtKEZwxhcvLskL7/FFhh
 z0AzhN0HPjM4NS/8LxesSUvDeBkxdWqSl30wm0H4fl6X7gq7wEb5TmV/QWedO7mHG7pk
 prmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQBGzKy65z5xIRM4LqcRkW9Gd81MyZSKiiS8ZnKJlKU+llMM75Tu3eQUMU/LLryZPc+Lzm+g5ACpG5@nongnu.org
X-Gm-Message-State: AOJu0YySKWG7KF/4tvrnC2sZWRugoE9XivzHshPCaSzHdqO3bvAwJ6cg
 VSynPSwTjxLHba2Zo2KjfgV4IiCXn84AsTQq/9V0O+RnroWNMl7Ka4SxO8YGd15v1gI132J4djP
 gQkULKtKZZALfYPTUJE9NICM1a2/AFzSteIfYNnX+wmQlezpaj+Kq
X-Received: by 2002:a05:600c:511d:b0:42c:e0da:f13e with SMTP id
 5b1f17b1804b1-42f85ab7b98mr85273285e9.18.1728305993409; 
 Mon, 07 Oct 2024 05:59:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGilwu6OdlFZhAKn67PhVqmZc1ngN27l3glb2SsNuiyq69O3Q5PDtZ85rYkSyb93VVtOUUeNQ==
X-Received: by 2002:a05:600c:511d:b0:42c:e0da:f13e with SMTP id
 5b1f17b1804b1-42f85ab7b98mr85272535e9.18.1728305992193; 
 Mon, 07 Oct 2024 05:59:52 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f89e89b42sm73389795e9.13.2024.10.07.05.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 05:59:51 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:59:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: miguel.luis@oracle.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 dave@treblig.org, mst@redhat.com, anisinha@redhat.com,
 shannon.zhaosl@gmail.com, peter.maydell@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [RFC V2 PATCH 02/11] acpi: Implement control method sleep button
Message-ID: <20241007145950.0e53023c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240927183906.1248-3-annie.li@oracle.com>
References: <20240927183906.1248-1-annie.li@oracle.com>
 <20240927183906.1248-3-annie.li@oracle.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 27 Sep 2024 14:38:57 -0400
Annie Li <annie.li@oracle.com> wrote:

> The control method sleep button is added, as well as its GPE event
> handler.
> 
> Co-developed-by: Miguel Luis <miguel.luis@oracle.com>
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hw/acpi/control_method_device.c         | 54 +++++++++++++++++++++++++
>  hw/acpi/meson.build                     |  1 +
>  include/hw/acpi/control_method_device.h | 25 ++++++++++++
>  3 files changed, 80 insertions(+)
> 
> diff --git a/hw/acpi/control_method_device.c b/hw/acpi/control_method_device.c
> new file mode 100644
> index 0000000000..f52c190352
> --- /dev/null
> +++ b/hw/acpi/control_method_device.c
> @@ -0,0 +1,54 @@
> +/*
> + * Control method devices
> + *
> + * Copyright (c) 2023 Oracle and/or its affiliates.
> + *
> + *
> + * Authors:
> + *     Annie Li <annie.li@oracle.com>
> + *
> + *

> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.

replace it with SPDX-License-Identifier like it's done elsewhere

> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/acpi/control_method_device.h"
> +#include "hw/mem/nvdimm.h"
> +
> +void acpi_dsdt_add_sleep_button(Aml *scope)
> +{
> +    Aml *dev = aml_device("\\_SB."ACPI_SLEEP_BUTTON_DEVICE);

drop "\\_SB." here and below as well, 

> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0E")));
> +    Aml *pkg = aml_package(2);
> +    aml_append(pkg, aml_int(0x01));
> +    aml_append(pkg, aml_int(0x04));
> +    aml_append(dev, aml_name_decl("_PRW", pkg));
> +    aml_append(dev, aml_operation_region("\\Boo", AML_SYSTEM_IO,
use some sensible name for opreg

> +                                         aml_int(0x201), 0x1));
> +    Aml *field = aml_field("\\Boo", AML_BYTE_ACC, AML_NOLOCK,
> +                           AML_WRITE_AS_ZEROS);
> +    aml_append(field, aml_named_field("SBP", 1));
> +    aml_append(field, aml_named_field("SBW", 1));
> +    aml_append(dev, field);
> +    aml_append(scope, dev);
> +}

also above and below lacks any documentation,
add comments for relevant spec references, like we do with other ACPI
functions. Also perhaps, it's out of order, reviewer has not clue
where from above registers come and how it is supposed to work.

if you invented those registers, there should be a preceding doc patch
that documents them.

Suggest to reorder after patch that implements above registers in hw,
and also comment here where to look for them.

> +
> +void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope)
> +{
> +     Aml *method = aml_method("_L07", 0, AML_NOTSERIALIZED);
> +     Aml *condition = aml_if(aml_name("\\_SB.SLPB.SBP"));
> +     aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBP")));
> +     aml_append(condition,
> +                aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
> +                                    aml_int(0x80)));
> +     aml_append(method, condition);
> +     condition = aml_if(aml_name("\\_SB.SLPB.SBW"));
> +     aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBW")));
> +     aml_append(condition,
> +                aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
> +                                    aml_int(0x2)));
> +     aml_append(method, condition);
> +     aml_append(scope, method);
> +}
> diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
> index fa5c07db90..0b4f1b432d 100644
> --- a/hw/acpi/meson.build
> +++ b/hw/acpi/meson.build
> @@ -17,6 +17,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
> +acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('control_method_device.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_APEI', if_true: files('ghes.c'), if_false: files('ghes-stub.c'))
>  acpi_ss.add(when: 'CONFIG_ACPI_PIIX4', if_true: files('piix4.c'))
> diff --git a/include/hw/acpi/control_method_device.h b/include/hw/acpi/control_method_device.h
> new file mode 100644
> index 0000000000..87f8d6fd59
> --- /dev/null
> +++ b/include/hw/acpi/control_method_device.h
> @@ -0,0 +1,25 @@
> +/*
> + * Control method devices
> + *
> + * Copyright (c) 2023 Oracle and/or its affiliates.
> + *
> + *
> + * Authors:
> + *     Annie Li <annie.li@oracle.com>
> + *
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +
> +#ifndef HW_ACPI_CONTROL_METHOD_DEVICE_H
> +#define HW_ACPI_CONTROL_NETHOD_DEVICE_H
> +
> +#define ACPI_SLEEP_BUTTON_DEVICE "SLPB"
> +
> +void acpi_dsdt_add_sleep_button(Aml *scope);
> +void acpi_dsdt_add_sleep_gpe_event_handler(Aml *scope);
> +
> +#endif


