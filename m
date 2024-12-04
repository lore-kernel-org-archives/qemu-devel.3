Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F09E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 16:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIsSN-0004sO-88; Wed, 04 Dec 2024 11:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIsSG-0004rT-7b
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:42:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIsSC-00058E-Na
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733330537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTboGuxBsv1/D7jYDtP1EAK+nV/89N3aSEIGaAgBjps=;
 b=Nxy0P8CKb2yRCaBrFeL6Q74ero02qti4zLxuN/o1V+VdWUCmmXdPb3kRUlnvESRVJyZNdZ
 DJjbQy91S0tGWNWeXTpIc6r9LaeYWqeYFJNQdvPXOvyzjL7oS2DgkrMPBAS3l8au8m86YD
 dLL7YaYx8KDUJebM48jOqBPJQcec5Xk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-oaGKx-DdPea5kVJTJmxZuw-1; Wed, 04 Dec 2024 11:42:15 -0500
X-MC-Unique: oaGKx-DdPea5kVJTJmxZuw-1
X-Mimecast-MFC-AGG-ID: oaGKx-DdPea5kVJTJmxZuw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4349f32c9a6so57458705e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 08:42:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733330534; x=1733935334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aTboGuxBsv1/D7jYDtP1EAK+nV/89N3aSEIGaAgBjps=;
 b=dex+Y2TdtB/uPP8qIIewmJC1pr+L5SBZ1Uj9HeomcRBBbT0oDlCHcJftIUWDhGtLjC
 Fti9QHnKc2dwjaZw5RULELJIfrGB5A534foayU3xILqLJnvrw+E79viLsUSA+hBW786h
 WWNF1TlTCTBA5eve43J1UVzfwGYQNLDmYtQ5XXoPef/hasg/GA6HrrmlTQpSL+rRy+AV
 X8XsytCEiKvGXyY0LaSU1eUDqq0JMJz5DftXec2YFbgnpqE/1Y44ewr+i5XYDm/iUTrg
 LGNyfwj9uWCHNW9yHCTCa6R6bNT65eCsA+SooN9rRhCezA84W5RigarRfuXVgc9PRTsd
 rKLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT7TBgVnq0ukhLgDcwsnymgi6wpxI/OPKuTbioy97kmhFx6qRLVXZPgNLZkYbv4HID4/iloGVW+M0c@nongnu.org
X-Gm-Message-State: AOJu0Yx4Bi7xZmQ7xupmZ3rly2n7Fpv/3uLUEcpjhtm6Hcvg/9dsRe9d
 1yOlPSLHnhUoCmnPzAm8z/dq/HrXEGQM6AH1BOrrfIo/sovA/OuhAV80qaiZ2N7gzlJaXCfxE8t
 leicwEXwKJr6JGk6uE/RSEITCszJmtXnjxdBY2yxFTQ1PZuakKdoH
X-Gm-Gg: ASbGncvfPixezkQAbIGpbxr1yBv/5xYRqDcEpcahrX6g9LBdCB79jYn8oVGhrZPt1g0
 koDka9QCEFv3Oua4E+uRYEiT/pJAU3Ama/5rbYjrwTi+Ruz1oanaoffWtOMfwtSzyAh7X1W9kwf
 TsdhJ5s+49f7RfecrExZv3JzGkVR64I6ESBb5i4L6SVh3RbBBBPAr1Ea2077KuqYwQ5Q7z490Wm
 Xfuj9ZDFDMr9YU1tWnnXRKcRm0OZ7wLS28UpkWENKB79xH47EL9kglwbY70RYU4KvH4Pj9IjwND
 HmDZnzN+GH3xO6EsjKB8sA==
X-Received: by 2002:a05:600c:3c9b:b0:434:a706:c0f0 with SMTP id
 5b1f17b1804b1-434d09b5fbdmr65866705e9.14.1733330534056; 
 Wed, 04 Dec 2024 08:42:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3vYYe0JYqWvdtnCbpcYPrqQ5wdtxOa58ZiyFbEhfHIUG+ni9gR0oBxI2tXG6+uCSAb9oHLw==
X-Received: by 2002:a05:600c:3c9b:b0:434:a706:c0f0 with SMTP id
 5b1f17b1804b1-434d09b5fbdmr65866395e9.14.1733330533682; 
 Wed, 04 Dec 2024 08:42:13 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52cbd5asm29512655e9.40.2024.12.04.08.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 08:42:13 -0800 (PST)
Date: Wed, 4 Dec 2024 17:42:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 14/16] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241204174212.4c6558aa@imammedo.users.ipa.redhat.com>
In-Reply-To: <5a2bda4722e2d45839a75f3a193f6b8f4841c773.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
 <5a2bda4722e2d45839a75f3a193f6b8f4841c773.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed,  4 Dec 2024 08:41:22 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Currently, CPER address location is calculated as an offset of
> the hardware_errors table. It is also badly named, as the
> offset actually used is the address where the CPER data starts,
> and not the beginning of the error source.
> 
> Move the logic which calculates such offset to a separate
> function, in preparation for a patch that will be changing the
> logic to calculate it from the HEST table.
> 
> While here, properly name the variable which stores the cper
> address.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 40 +++++++++++++++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 90d76b9c2d8c..a4453ee357bc 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -364,10 +364,37 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> +static void get_hw_error_offsets(uint64_t ghes_addr,
> +                                 uint64_t *cper_addr,
> +                                 uint64_t *read_ack_register_addr)
> +{
> +    if (!ghes_addr) {
> +        return;
> +    }
> +
> +    /*
> +     * non-HEST version supports only one source, so no need to change
> +     * the start offset based on the source ID. Also, we can't validate
> +     * the source ID, as it is stored inside the HEST table.
> +     */
> +
> +    cpu_physical_memory_read(ghes_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    *cper_addr = le64_to_cpu(*cper_addr);
> +
> +    /*
> +     * As the current version supports only one source, the ack offset is
> +     * just sizeof(uint64_t).
> +     */
> +    *read_ack_register_addr = ghes_addr +
> +			      ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> +    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
>      uint64_t start_addr;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -389,18 +416,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>  
>      start_addr += source_id * sizeof(uint64_t);
>  
> -    cpu_physical_memory_read(start_addr, &error_block_addr,
> -                             sizeof(error_block_addr));
> +    get_hw_error_offsets(start_addr, &cper_addr, &read_ack_register_addr);
>  
> -    error_block_addr = le64_to_cpu(error_block_addr);
> -    if (!error_block_addr) {
> +    if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");
>          return;
>      }
>  
> -    read_ack_register_addr = start_addr +
> -                             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> -
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
>  
> @@ -421,7 +443,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>          &read_ack_register, sizeof(uint64_t));
>  
>      /* Write the generic error data entry into guest memory */
> -    cpu_physical_memory_write(error_block_addr, cper, len);
> +    cpu_physical_memory_write(cper_addr, cper, len);
>  
>      return;
>  }


