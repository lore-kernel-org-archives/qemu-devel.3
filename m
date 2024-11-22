Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4E3E69173
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 16:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEWOi-0004KB-5b; Fri, 22 Nov 2024 11:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEWOW-0004BX-Gr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 11:20:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEWOU-0003fZ-VN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 11:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732292430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeBsoywq5pgh/XUprwXSGU0TjSDIfHvJFYAFD/VkyJs=;
 b=JlT4n2a8GPa9XqjJT7M4rtXX74FzU0tuSrJbeTGdnjLf2atzsfyUr5rgwQixUAdsJbwTSF
 C2+PR9GAdVHJDRtfTeMpxa4VQnibhsuf7vrz5wfF4T5qXF1ndZUNuahPdk/WoQqS+b1zqA
 DGxeldP4ANGsFyq/f2bUavtGjh83mUw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-jaE3XKheM4Ku-IZXB2LeAw-1; Fri, 22 Nov 2024 11:20:27 -0500
X-MC-Unique: jaE3XKheM4Ku-IZXB2LeAw-1
X-Mimecast-MFC-AGG-ID: jaE3XKheM4Ku-IZXB2LeAw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315dd8fe7fso20074985e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 08:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732292426; x=1732897226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aeBsoywq5pgh/XUprwXSGU0TjSDIfHvJFYAFD/VkyJs=;
 b=jZNf9YgRuKpM7wt4iIGP7gqLH3DupAUUPI0J5cKkkmm+GW6a6RVO/5mKH9V5o0oR6v
 yhBs8vpWM/2ua3p0ykIMGjE5HAoeH/P+pfIt4eN4fC9IWOgYjZu9GSfyyBc/5cBXMsYn
 AsqfHrVxZebgt1DW2fX/p+kuc4BktZ3+P1XvAv6YVZcQWTsr+GakwLlELHxx06AWJHNe
 2b5Kty/w8dPasZXaseI0ti6Ptf+LSF7beDfQrcHLhR3lEM00b+M/swsJJsCcfWjULOTJ
 IOs5yM6X+wkykY0aoqsT/oGmlyKo67pQ+4eU0leLW3J1fJyhBoArH/Ov0JDcBSaQxzMO
 D4tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaxSk97696zBb/9aO9MbVMxRya2fxkFqqE016nPU1++Xlsy1Im7Pkgi0QSK4bAgpKbcIrcCgJvFf+m@nongnu.org
X-Gm-Message-State: AOJu0YyDNfRMLlIzp/osD1TQqyx5X/Q6gB7OBpWllAoI7paEwhobn4pO
 atJzaVknaRgZGD3BaQZoJ5/ujTigEmdEVd1QP7/UD68ps3hCTHAEJuSMPTAUP7eZ/X5ka36/JI3
 lH0L6oaPzedZcAlWCTOIQifc3di1/NcwxYKdslcBHYotwnrPUVASX
X-Gm-Gg: ASbGnctrrDV1NPSqoYZZNZ8sozih4wXj52+hnD+uN7ieBQXCYBodDUH6eVLM9C9H02u
 725ZGjrQQXEeWeYqJiMzHgWCIvARytzcTLG8YUCwYJj92Zi7VcDf9uwukeTLzX5yQXTfQ2fFRw3
 RoibwKGBef8aOt1SZ7MeLZ2DGD+l1Flxb6AgXhrc0/wfNM4Zk3mOq1JvozxYWawrwTAf5Co3rKP
 aE5UfGod5r+rIf7TAk1yPi9xnDZBMn7T0EtN73pP5M1EvWunZRGf4D5p3kkGcqx9Kv7d0KiwRPt
 o3H/5RxXNo2xzFzpynVdmQ==
X-Received: by 2002:a05:600c:4fcc:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-433ce410337mr29781475e9.1.1732292426642; 
 Fri, 22 Nov 2024 08:20:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfnCVCtSLDvYz49C8CbppJHHhiynRHuZUEWU9I8Ig8QVTpU3P25aNt428T9B2r9GX9wU/yTw==
X-Received: by 2002:a05:600c:4fcc:b0:42c:ba83:3f00 with SMTP id
 5b1f17b1804b1-433ce410337mr29781235e9.1.1732292426254; 
 Fri, 22 Nov 2024 08:20:26 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4643217sm95331535e9.44.2024.11.22.08.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 08:20:24 -0800 (PST)
Date: Fri, 22 Nov 2024 17:20:22 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 04/15] acpi/ghes: better handle source_id and
 notification
Message-ID: <20241122172022.64fddb52@imammedo.users.ipa.redhat.com>
In-Reply-To: <0ad66ed39b357d5fbf2e4a6d1fa47d310796cc1c.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <0ad66ed39b357d5fbf2e4a6d1fa47d310796cc1c.1732266152.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

On Fri, 22 Nov 2024 10:11:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> GHES has two fields that are stored on HEST error source
> blocks associated with notifications:
> 
> - notification type, which is a number defined at the ACPI spec
>   containing several arch-specific synchronous and assynchronous
>   types;
> - source id, which is a HW/FW defined number, used to distinguish
>   between different implemented sources.
> 
> There could be several sources with the same notification type,
> which is dependent of the way each architecture maps notifications.
> 
> Right now, build_ghes_v2() hardcodes a 1:1 mapping between such
> fields. Move it to two independent parameters, allowing the
> caller function to fill both.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> Chenges from v10:
> 
> - Some changes got moved to the previous patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4a6c45bcb4be..29cd7e4d8171 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -284,9 +284,13 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  }
>  
>  /* Build Generic Hardware Error Source version 2 (GHESv2) */
> -static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
> +static void build_ghes_v2(GArray *table_data,
> +                          BIOSLinker *linker,
> +                          enum AcpiGhesNotifyType notify,
> +                          uint16_t source_id)
>  {
>      uint64_t address_offset;
> +
>      /*
>       * Type:
>       * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> @@ -316,18 +320,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>          address_offset + GAS_ADDR_OFFSET, sizeof(uint64_t),
>          ACPI_GHES_ERRORS_FW_CFG_FILE, source_id * sizeof(uint64_t));
>  
> -    switch (source_id) {
> -    case ACPI_HEST_SRC_ID_SEA:
> -        /*
> -         * Notification Structure
> -         * Now only enable ARMv8 SEA notification type
> -         */
> -        build_ghes_hw_error_notification(table_data, ACPI_GHES_NOTIFY_SEA);
> -        break;
> -    default:
> -        error_report("Not support this error source");
> -        abort();
> -    }
> +    /* Notification Structure */
> +    build_ghes_hw_error_notification(table_data, notify);
>  
>      /* Error Status Block Length */
>      build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
> @@ -369,7 +363,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
> -    build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
> +    build_ghes_v2(table_data, linker,
> +                  ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
>  }


