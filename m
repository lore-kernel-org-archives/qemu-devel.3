Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126DEC02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbIzI-0007HH-Ky; Fri, 24 Jan 2025 07:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbIz0-0007GC-W8
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:40:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbIyv-00044z-C4
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737722413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmgO+HvEIBTtyzELL4enJIOu2DHA7czaRvoBt+3oV6Y=;
 b=XBSe8vKvKx45IXMz7Op+v+ZZNAHHQ0ORxQ731Bie5n8Kk4oLgsiSup1RVm+xVMkXR9dL+x
 j4ttC1XC+yfFqGtEDScy3393waEb/zELGdVEum6KOVAPDKDMpQuWjg+PAnjzXUulv7Yvlg
 BCwETC62gQv5lPBuEAmyzzNfNyzRNC0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-1JQJZtyqOyeESq8GugBXJw-1; Fri, 24 Jan 2025 07:40:10 -0500
X-MC-Unique: 1JQJZtyqOyeESq8GugBXJw-1
X-Mimecast-MFC-AGG-ID: 1JQJZtyqOyeESq8GugBXJw
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4361ac8b25fso11381555e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737722409; x=1738327209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmgO+HvEIBTtyzELL4enJIOu2DHA7czaRvoBt+3oV6Y=;
 b=TP1c6AuU4uFSwKgeJqYpACCGFQFf3lz5yzYWG1zTAqi31F1RhZKkYRaXxFZdWDdP2k
 7SFS3adEdKemtG76wwFVdlzVf8bNNFNUYy+PzaLXy6Br4zSs0m86QPnSjysg+vUAALJR
 1/WiFEhfBMrKp1wNcEyBCC03R/EIoFyH0pf3uUvne1gQfo9cgwAyAVNSKAmjPzWZAE6k
 vSK6YnyduAbCUyEqJ0cXJ7IFyZLGjLR8Ixjb26UhG97ElicpOqH563/RH0+0sMiRKyjQ
 FQQrMp4f2rRlEqVDm0a8dpEOS5pRI0tzxSkK/NwyYcOv01L3Z7EMP1B4PpRY3Mt4tYkG
 +xcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtA5UbYV9g+6hr60Z3W/E0fP343qlHS2APthAJsItivd9jtKGclPysGCwjOisvWxQ1Gups5Yr6n/Z2@nongnu.org
X-Gm-Message-State: AOJu0Ywo2JbYTsPgtRjJcotEerh3+5BbRKtsyIcTb9dCWB4ybIRfvaiv
 mVczk6tNz3n0Nl6OK30N0PaAxIG0gu6T2cLPA6UpvqiCmXf2VAJnZSZC10PZh92fSg5hIh+UGLI
 Zl5zo/6vq5KtKLHQvkIgccbKpwp3O4IT4+gVj3BIVR8UpvNm3HlRu
X-Gm-Gg: ASbGncuVzTf8EQd3iW3Z7msW07quW+XGim3U3U+ZifH/6ddm0u08yi3tEiGfxpOwScL
 0wRnzkFhqMSH6clxKEJqaB/KcRNuHBA+2Df+vxzu3lNL4cYncWO90bmvY8CyMVB/X02Erk8HyM8
 lXPcRfMjv6d8XTfP49F44sgxSUJxTAjCLnzHfaETm+NY66RumgKffG5vxn7d4cUWlpRuB0ynBI7
 ktBz+eHy5v1oiwxldZJi00/tiTaW7wfTHO6G/syKB7lhb1F4akZm+q3g7E0XGdbZmpKgwwZhuTU
 eqV4EQMknLnkK9S2KKnWtY5DeTqrkJkBY7lSb/Q76A==
X-Received: by 2002:a05:600c:4e09:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-438913e99b0mr309664975e9.14.1737722409032; 
 Fri, 24 Jan 2025 04:40:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgXay2Ta+ZfnB/m+BroIeM5oLSBPhMMDGwJdKDqGUHGtymH8bLgQb+A7Sl84dklQUDSuzA3g==
X-Received: by 2002:a05:600c:4e09:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-438913e99b0mr309664595e9.14.1737722408588; 
 Fri, 24 Jan 2025 04:40:08 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4b9984sm25226475e9.28.2025.01.24.04.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 04:40:08 -0800 (PST)
Date: Fri, 24 Jan 2025 13:40:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Shannon Zhao" <shannon.zhaosl@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/11] qapi/acpi-hest: add an interface to do generic
 CPER error injection
Message-ID: <20250124134007.18b508bc@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250123110032.000052d4@huawei.com>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <769b68a3192cc921fec4c0e5e925552920fdbe71.1737560101.git.mchehab+huawei@kernel.org>
 <20250123110032.000052d4@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 23 Jan 2025 11:00:32 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 22 Jan 2025 16:46:27 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Creates a QMP command to be used for generic ACPI APEI hardware error
> > injection (HEST) via GHESv2, and add support for it for ARM guests.
> > 
> > Error injection uses ACPI_HEST_SRC_ID_QMP source ID to be platform
> > independent. This is mapped at arch virt bindings, depending on the
> > types supported by QEMU and by the BIOS. So, on ARM, this is supported
> > via ACPI_GHES_NOTIFY_GPIO notification type.
> > 
> > This patch is co-authored:
> >     - original ghes logic to inject a simple ARM record by Shiju Jose;
> >     - generic logic to handle block addresses by Jonathan Cameron;
> >     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> > 
> > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > 
> > ---
> > 
> > Changes since v9:
> > - ARM source IDs renamed to reflect SYNC/ASYNC;
> > - command name changed to better reflect what it does;
> > - some improvements at JSON documentation;
> > - add a check for QMP source at the notification logic.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Another bonus.
> 
> Few trivial formatting comments, otherwise looks fine to me.
> 
> Jonathan
> 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index 5d29db3918dd..cf83c959b5ef 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -547,7 +547,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> >      /* Write the generic error data entry into guest memory */
> >      cpu_physical_memory_write(cper_addr, cper, len);
> >  
> > -    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
> > +    notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
> >  }
> >  
> >  int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> > diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
> > new file mode 100644
> > index 000000000000..02c47b41b990
> > --- /dev/null
> > +++ b/hw/acpi/ghes_cper.c
> > @@ -0,0 +1,32 @@
> > +/*
> > + * CPER payload parser for error injection
> > + *
> > + * Copyright(C) 2024 Huawei LTD.

2025

> > + *
> > + * This code is licensed under the GPL version 2 or later. See the
> > + * COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "qemu/base64.h"
> > +#include "qemu/error-report.h"
> > +#include "qemu/uuid.h"
> > +#include "qapi/qapi-commands-acpi-hest.h"
> > +#include "hw/acpi/ghes.h"
> > +
> > +void qmp_inject_ghes_error(const char *qmp_cper, Error **errp)
> > +{
> > +  
> Odd blank line that can go.
> 
> > +    uint8_t *cper;
> > +    size_t  len;
> > +
> > +    cper = qbase64_decode(qmp_cper, -1, &len, errp);
> > +    if (!cper) {
> > +        error_setg(errp, "missing GHES CPER payload");
> > +        return;
> > +    }
> > +
> > +    ghes_record_cper_errors(cper, len, ACPI_HEST_SRC_ID_QMP, errp);
> > +}
> > diff --git a/hw/acpi/ghes_cper_stub.c b/hw/acpi/ghes_cper_stub.c
> > new file mode 100644
> > index 000000000000..8782e2c02fa8
> > --- /dev/null
> > +++ b/hw/acpi/ghes_cper_stub.c
> > @@ -0,0 +1,19 @@
> > +/*
> > + * Stub interface for CPER payload parser for error injection
> > + *
> > + * Copyright(C) 2024 Huawei LTD.

2025

> > + *
> > + * This code is licensed under the GPL version 2 or later. See the
> > + * COPYING file in the top-level directory.
> > + *  
> Trivial but I'd drop these trailing blank lines as they don't add
> anything other than making people scroll further.
> 
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qapi-commands-acpi-hest.h"
> > +#include "hw/acpi/ghes.h"  
> 
> Trivial but doe we need ghes.h?
> 
> > +
> > +void qmp_inject_ghes_error(const char *cper, Error **errp)
> > +{
> > +    error_setg(errp, "GHES QMP error inject is not compiled in");
> > +}  
> 


