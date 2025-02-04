Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BA8C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJh0-0002X3-QA; Tue, 04 Feb 2025 09:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfJgu-0002T3-9z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfJgs-00038l-IF
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738678452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uoQihLFxJouBYznNHgtnZ2Dd0/sg9BDXkNdAOpjYLhs=;
 b=BxUK5mxqgqduV36sbtuTIS9TDU4+iHaO4tFm5gzF8gp7kGaTq3xpHuDBzko0N/qF1MkIuL
 Ix5wrIoLSmHy/dv4/YJnBpL4PFM5USG1uNRd1hYXAbS1/QQlPG08YrVMokQkS1y2SgSUKU
 Qv9fxuF5HkfxnD90UVbT1SaCD+ttoXo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-JMne0fzrO2K95W6rH3b9tQ-1; Tue, 04 Feb 2025 09:14:10 -0500
X-MC-Unique: JMne0fzrO2K95W6rH3b9tQ-1
X-Mimecast-MFC-AGG-ID: JMne0fzrO2K95W6rH3b9tQ
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8f6903d2eso100518026d6.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738678450; x=1739283250;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoQihLFxJouBYznNHgtnZ2Dd0/sg9BDXkNdAOpjYLhs=;
 b=e8b6/GyQJyXXgpw5Ol2EsKU7MzNiojUnU+5tukgbPcieXwTKaXjMpfV0qnPFV12S3Y
 dkteY2I76jUA6CooMns+I4TzLfUPYOYyJvd6vs7hJNOVNkhap7e4vakSJ2e7Ntq8cIPa
 DlzAPQueEPAQJvrapfVJoEbJoYmcSP/1jWl+wKUPGSKA2ChewHvhRQaeL58vNGYckiw/
 pPWH5YQ4OFezGCWTt4G9pxtkPFrj850g1jq3vfzBTDjZq8fyFGyyjZ0+/Lb1ZdPaRPJk
 fMo7Qr+1Gk50UA4Xkh6PlwmRGepazOxUNe7OYjqB5n+XVchS4PO8oW8hfkpDFjc1K2WE
 KjLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWch3Cnnk81V3hLwtJL5+nQ7+FnhQc9AEDGzFMvpfid3ABx+Cbtx1ROKkc9AyyA4zql2Xo9zpclWcJr@nongnu.org
X-Gm-Message-State: AOJu0YzWqkRqIJfeUoZI9TQnnwN2rfzOiziD1lEaRjlI2g/gKy2ZvHTy
 zPtMRX0FtlC9b4tI8ifQ660+oG1tGm9e5sY1unwY/TRiakvK3vEjRKuvNusqn5tRyJOnri4lwl2
 xw5VLRsXryo35QkEpyjU7fht+A+/KOjOWnqP+MnRWaGZSkZQAVWLT
X-Gm-Gg: ASbGncvCTrlg71b7cW6iJXiAZMLH8Md+VC89Hxj7hJqO0RyAFPLJFilZa6htRHw+Fua
 ixZNgLwnBZUbXpG3jXhZI5XmF5vL5h63812t85HGpNGK9Yg5Po5Bt9nVbIGLyEOvYLV/nZMzZRq
 UmUz+YvWeA4/CMUQ95ruqYW2qTMreRMyiuE2L6bF+Ohs2WC8wRtNc8HAoXaMAS7+5OWBaaWtf1v
 UHW2h9EeUj7DcRwoLqgvQVbOsWRsARgfQHIFrt3zIns4PkGOk2DiwYSh/xlBypU3vL1SZONdwbl
 2QPcBh/G9t5+9MK+/T2U4R5wSUIcZ8uKhIBZQgqGx9k=
X-Received: by 2002:a05:6214:27e4:b0:6e1:69fa:f023 with SMTP id
 6a1803df08f44-6e243c7e338mr379415366d6.39.1738678449877; 
 Tue, 04 Feb 2025 06:14:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhA77+wDM8KsmKKiGue9KQYrTT3YwtVETZcqKMowfKO4CUNGLMXjisbHS3LbWJQT8o8ksbRw==
X-Received: by 2002:a05:6214:27e4:b0:6e1:69fa:f023 with SMTP id
 6a1803df08f44-6e243c7e338mr379414946d6.39.1738678449561; 
 Tue, 04 Feb 2025 06:14:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2548141b5sm62058406d6.39.2025.02.04.06.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 06:14:09 -0800 (PST)
Message-ID: <8d675900-2a3f-43f9-8e54-331934c7aa02@redhat.com>
Date: Tue, 4 Feb 2025 15:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 08/26] pci: skip reset during cpr
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-9-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-9-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> Do not reset a vfio-pci device during CPR.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/pci/pci.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 2afa423..16b4f71 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -32,6 +32,7 @@
>   #include "hw/pci/pci_host.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
> +#include "migration/misc.h"
>   #include "migration/qemu-file-types.h"
>   #include "migration/vmstate.h"
>   #include "net/net.h"
> @@ -459,6 +460,18 @@ static void pci_reset_regions(PCIDevice *dev)
>   
>   static void pci_do_device_reset(PCIDevice *dev)
>   {
> +    /*
> +     * A PCI device that is resuming for cpr is already configured, so do
> +     * not reset it here when we are called from qemu_system_reset prior to
> +     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
> +     * safe to skip this reset for all PCI devices, because cpr load will set
> +     * all fields that would have been set here.
> +     */
> +    MigMode mode = migrate_mode();
> +    if (mode == MIG_MODE_CPR_TRANSFER) {
> +        return;
> +    }

Please use cpr_needed_for_reuse(). Or an appropriate helper.

I would the test under pci_device_reset() and avoid calling
pci_do_device_reset().

Thanks,

C.


>       pci_device_deassert_intx(dev);
>       assert(dev->irq_state == 0);
>   


