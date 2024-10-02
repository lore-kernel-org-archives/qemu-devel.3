Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5067CF6D25
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzQj-00064O-1l; Wed, 02 Oct 2024 09:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzQd-00062o-Ja
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:30:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzQb-0008N8-VS
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727875805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVaj7/BQi23v89JkJG2qnGOSUZwrNzEyBz6Xmffq5Xs=;
 b=OUaPz1uRfQeE/q10sczlErXfQ16rRj4WU3t+xGOCnMtoVXxpBFGSQNWfi85NVtGxv0n2tG
 AhddzYV3pKGN/rQqfgJxvZhZEMtDN99f1BjsVULJaYIyEaXmeK0teSf+zTElh0Wf4AqqOE
 Z1OmCJEqBqy2911kPZB06OCNcC3tgyY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-jz-KTR1qOQmYlf6xi-u9vA-1; Wed, 02 Oct 2024 09:30:04 -0400
X-MC-Unique: jz-KTR1qOQmYlf6xi-u9vA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42e77b5d3dcso44014445e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727875803; x=1728480603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVaj7/BQi23v89JkJG2qnGOSUZwrNzEyBz6Xmffq5Xs=;
 b=WLbI2bafT3dRagK+3NRbBf6HS54Bpi+YDMdnH4vzZ+GFBcjWHm68p5z/Sb3qJKd5YU
 yLcViMJxGax2tq1MrRT69HsITo5TSQ+kQi+BWNkCitwEAffIXMcGKpwicTAl75hSPpyw
 GQVvGcobJl0iYxdyAvGolPAPux1RRGu6pTpSsfGqkfYjCl+xyvO0jD+Xrpgfe2M7YA74
 CWY2mEy8J5g5u6QOPrenGKTBL2pKWd1B/SDYtErzF+POBcSvP8V1h3qH/CFsXR9Dn2ga
 w/44quSX4lWiFFm0r63ZCDoIu3NQ2iICnOOorpVobVxcAEkJ+piC76OudIcNWgpcosPL
 y+hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQdBHqJKHUUv/p2xXh+Ak5AsvhoOnmYXGdRNWoRJLmMsYE52g7prN948RKjdl8sGB/qe9CbE7cKKUd@nongnu.org
X-Gm-Message-State: AOJu0YyjiZ8qrAnbVqFZQlPtJTBsE+INPYt6bmpKfYMSb5OPJVN5H9Wj
 /nRJYsz7elR5/aljLgfrIOR3yIAxPx9gXjDSPm26G7v5H3Le3/rUc4LVojOYLE00K5yEqQ4Xixz
 HZObhPnOCd7v6ecMFsnp2L2gKugWwJhbApveTNj3ucPY1arUox085
X-Received: by 2002:a05:600c:3507:b0:42c:b63e:fe8f with SMTP id
 5b1f17b1804b1-42f777bf969mr20412245e9.13.1727875802934; 
 Wed, 02 Oct 2024 06:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7qHvz/rSdIDBwP4B+E2wVG8l63Y1Nawa+BWx5diV1g7GxH260FdI/ZjjdSjFXVctxqrqVtg==
X-Received: by 2002:a05:600c:3507:b0:42c:b63e:fe8f with SMTP id
 5b1f17b1804b1-42f777bf969mr20412055e9.13.1727875802489; 
 Wed, 02 Oct 2024 06:30:02 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a01f4fasm18587105e9.38.2024.10.02.06.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 06:30:01 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:30:01 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 03/15] acpi/ghes: simplify the per-arch caller to
 build HEST table
Message-ID: <20241002153001.22324ae1@imammedo.users.ipa.redhat.com>
In-Reply-To: <a106318a134a2aa9d75aa07f906bad959cb0600a.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
 <a106318a134a2aa9d75aa07f906bad959cb0600a.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue,  1 Oct 2024 09:03:40 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The GHES driver requires not only a HEST table, but also a
> separate firmware file to store Error Structure records.
> It can't do one without the other.
> 
> Simplify the caller logic for it to require one function.

> This prepares for further changes where the HEST table
> generation will become more generic.

I'd drop this

> No functional changes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> Changes from v10:
> - Removed the logic which associates notification and source
>   ID. This will be placed on a separate patch.
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c           | 7 +++++--
>  hw/arm/virt-acpi-build.c | 5 ++---
>  include/hw/acpi/ghes.h   | 4 ++--
>  3 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e66f3be1502b..4a6c45bcb4be 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -233,7 +233,7 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
>   * Initialize "etc/hardware_errors" and "etc/hardware_errors_addr" fw_cfg blobs.
>   * See docs/specs/acpi_hest_ghes.rst for blobs format.
>   */
> -void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
> +static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>  {
>      int i, error_status_block_offset;
>  
> @@ -356,12 +356,15 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>  }
>  
>  /* Build Hardware Error Source Table */
> -void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
> +void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +                     BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id)
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
> +    build_ghes_error_table(hardware_errors, linker);
> +
>      acpi_table_begin(&table, table_data);
>  
>      /* Error Source Count */
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117adff..bafd9a56c217 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -943,10 +943,9 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>      build_dbg2(tables_blob, tables->linker, vms);
>  
>      if (vms->ras) {
> -        build_ghes_error_table(tables->hardware_errors, tables->linker);
>          acpi_add_table(table_offsets, tables_blob);
> -        acpi_build_hest(tables_blob, tables->linker, vms->oem_id,
> -                        vms->oem_table_id);
> +        acpi_build_hest(tables_blob, tables->hardware_errors, tables->linker,
> +                        vms->oem_id, vms->oem_table_id);
>      }
>  
>      if (ms->numa_state->num_nodes > 0) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 59e3b8fb24b9..20016c226d1f 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -68,8 +68,8 @@ typedef struct AcpiGhesState {
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;
>  
> -void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
> -void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
> +void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
> +                     BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);


