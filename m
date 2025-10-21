Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B098ACCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8hP-0007gH-Em; Tue, 21 Oct 2025 05:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vB8hN-0007fs-EQ
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vB8hK-0007xi-Am
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761039028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9J4hocexgTPW7k2fCcVuz/92uDyCHbzKYwrgLeaVbl0=;
 b=X3lVlwVNsrA4/q6ZrrUguN6zfFEOlwgdY2xGauTWRDAt4UBwtYP7xGAIA3yywRPiroD3Pi
 eONOqEICApZlUh6A/UmEFgsLC0rrx0Pm0+TuEKloQL+xSJL8WdLa4IpX82oXpaFzg6apog
 FK6/StAZZwGdJt+f12G2DbvoniwWlvc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-Ij-Bq22ENTmzuBVNAP2JmA-1; Tue, 21 Oct 2025 05:30:27 -0400
X-MC-Unique: Ij-Bq22ENTmzuBVNAP2JmA-1
X-Mimecast-MFC-AGG-ID: Ij-Bq22ENTmzuBVNAP2JmA_1761039026
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47111dc7bdbso44062865e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761039026; x=1761643826;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9J4hocexgTPW7k2fCcVuz/92uDyCHbzKYwrgLeaVbl0=;
 b=alKdcs4+mhTbx0qs6zkimWQ2tWPDedN+E82LsAwAgRFGHBX3WU9GlcnDpU5X1jgTw+
 iH8pky839qbYHv/mH3EpnflWKfgudVpFaFgtQrMLd9O7f0T6/eWJusvjoyXO966BRwaK
 OdAMRDsrzFjX+ytc3tem5OL9Q6sq1gqft5hu4AGf4mw/g3swdtRiIT74xVHzDInlolid
 kLzA57Kwcj4SPvGuEQRGUsXHkkwLIqxgceaOGc2ypcI6f9DqQP+tP5PNXWN5VbvJx+Ck
 2O0gYwTR0oS5VbCTHaq2U0/JX91LzXyiQlatfOL2lY5lT1nhL9mcfvMGmcXs/zkil6fQ
 OgKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuy31i0OOr6oE7Jh7vyAcJmrwZjgPHpNXj3UUSus19hKLqITVRdlW5mbehD2cZQ6CoMqiyYD4iFlcw@nongnu.org
X-Gm-Message-State: AOJu0Ywla61fJR3+Ppjqucdo3TPSBlmnwzLe7GZPTsPsKxzt1pYI0wU2
 hlCcROiByfOpeNgMDXuViL5mY35RlHW1SKNnm55kPTzSlc6gM5SEODkGPHfVsOVzYVOTTKrVjOj
 BJ6QqsGfmcqufEcPkcNvTSm6jx/tCE1taCAE/OgrI+Z/XNkf4tcBrShcp
X-Gm-Gg: ASbGncuSIgI8xX8lK+PjpZWT+bGOBVXLH0YMbF/O4DIc2sYAagyRYDxWnJo+45N/9fB
 KIssuapZw5JzPGe5O7i0wKu3dOdyqu9n07bz3C9SwSE8mT1cPe3gIg29rwSN6FW6A8Gtf2v999L
 uIqhEXNl5sd07ogixs3SzRgU3uIj5C0wRn0YPQTd4JPClsWPXHQQYJl8GK0d52E+6voa23fUbi1
 DztWnSc1Li+d51efCFQfRfqg9nCBYt7zso6BBED8fS6/tzAlhNtGMTuA8/GzX3VHqXfEVBAXaYx
 2xGctgwkhPNRo0YPqWrl+7zmcQYboYopzZy23SoMrbaeNN9XfQgfwM6FTrt8cbmksnd9W455MTj
 O2J6odj6D/el2s+1mCODK1PWo
X-Received: by 2002:a05:600c:4448:b0:46e:711c:efeb with SMTP id
 5b1f17b1804b1-471179117camr121310355e9.25.1761039026208; 
 Tue, 21 Oct 2025 02:30:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9FMxWRw+lhETbem3AgEjvw6HcOgE5YkiPCOyWJDX+D21BKYBJwRz1+JoA6qgArd4NiP3seg==
X-Received: by 2002:a05:600c:4448:b0:46e:711c:efeb with SMTP id
 5b1f17b1804b1-471179117camr121310145e9.25.1761039025758; 
 Tue, 21 Oct 2025 02:30:25 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4711c487dfesm266448535e9.17.2025.10.21.02.30.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:30:25 -0700 (PDT)
Message-ID: <7340496c-c7fa-4598-a57d-1818eb826a40@redhat.com>
Date: Tue, 21 Oct 2025 11:30:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] pc-bios/s390-ccw: Introduce CLP Architecture
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 mjrosato@linux.ibm.com, zycai@linux.ibm.com
References: <20251020162023.3649165-1-jrossi@linux.ibm.com>
 <20251020162023.3649165-4-jrossi@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251020162023.3649165-4-jrossi@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/10/2025 18.20, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
> 
> Call Logical Processor (CLP) Architecture is used for managing PCI functions on
> s390x. Define and include the structures and routines needed to interact with
> PCI devices during IPL.
> 
> Headers in ~/qemu/include/hw are not normally visible and must be included
> using a relative path.  Due to this, the QEMU_PACKED macro must also be defined
> here.
> 
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>   pc-bios/s390-ccw/clp.h    |  24 +++++++++
>   pc-bios/s390-ccw/clp.c    | 106 ++++++++++++++++++++++++++++++++++++++
>   pc-bios/s390-ccw/Makefile |   2 +-
>   3 files changed, 131 insertions(+), 1 deletion(-)
>   create mode 100644 pc-bios/s390-ccw/clp.h
>   create mode 100644 pc-bios/s390-ccw/clp.c
> 
> diff --git a/pc-bios/s390-ccw/clp.h b/pc-bios/s390-ccw/clp.h
> new file mode 100644
> index 0000000000..cb130e5e90
> --- /dev/null
> +++ b/pc-bios/s390-ccw/clp.h
> @@ -0,0 +1,24 @@
> +/*
> + * Call Logical Processor (CLP) architecture definitions
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Jared Rossi <jrossi@linux.ibm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef CLP_H
> +#define CLP_H
> +
> +#ifndef QEMU_PACKED
> +#define QEMU_PACKED __attribute__((packed))
> +#endif
> +
> +#include <stdint.h>
> +#include "../../include/hw/s390x/s390-pci-clp.h"
> +
> +int clp_pci(void *data);
> +int enable_pci_function(uint32_t *fhandle);
> +int enumerate_pci_functions(void);
I just noticed that you later remove this unused prototype for 
enumerate_pci_functions() in a later patch again. Please remove it from this 
patch here in the next respin instead.

  Thanks,
   Thomas


