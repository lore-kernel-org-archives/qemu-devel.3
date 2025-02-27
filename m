Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEEFC021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 13:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tndrz-0006U6-9G; Thu, 27 Feb 2025 08:24:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndrv-0006OM-1j
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:24:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tndrs-0001Rt-Ba
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 08:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740662638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+/sVet04sI8XRzD0vhsj+5eFIvMMczIeqA1fuUR4Rw=;
 b=Sz0Z1wHswwyrH1aJRPAICWnDaL9+Rme8Vg6iqO4HvDccn3EIL0Ytc6JN2dQcdN/Fi0IZz1
 xyMYcHNb/+7DVa18FQz5EMae731NNQyUIA3MSI8PYivfcC0NHcKaJPahcVoyvNiy6nj8jB
 Xuau5bPqARCBAvNBGwzWHUrKHphNn/Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-hhLYsZX8PKq1D_tqZ2M4Ow-1; Thu, 27 Feb 2025 08:23:57 -0500
X-MC-Unique: hhLYsZX8PKq1D_tqZ2M4Ow-1
X-Mimecast-MFC-AGG-ID: hhLYsZX8PKq1D_tqZ2M4Ow_1740662636
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f4cce15c8so387215f8f.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 05:23:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740662636; x=1741267436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+/sVet04sI8XRzD0vhsj+5eFIvMMczIeqA1fuUR4Rw=;
 b=i6fMe3FKSbTjZrjtA1VIdc8u5RXYEzmtnBTgZNEvfhV+YiLU3QVf1xatTld1iEVB3R
 nydM/Vi6bobRLRKAAdCPmjRuL8HuXqPMwcjXg+yOf2nVODv8SxQr2Hz0fxkFt8SM2D3y
 iJPn7U7R1M6U98dykJDgLlMag+R4HKNHlRrMvTEZ2FpWPHONIr36js9txrMSKqd+lPvz
 BQI8JUL1oYpiiFQKj0tZH0F2G2QpgUhhLr2qv/WY8L2Ns04ut4+OomGWC4iWE141PvTu
 OBzcVpDoFiD6E9vBsfCpFix7nN+4TgELgiejwybexuw412uQxuhPg4xZHW2w5boyK3io
 XX1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMI9ICQdTn9lBREa4BkeZX+HTlyOiHGcb9o9pg1ffG76v8zHqWnBRrJ41MEgfDmwNptHNZhICUk/nf@nongnu.org
X-Gm-Message-State: AOJu0Yw3PwWSvzqZMtPmXPGFEC/IM4BGs4zBSQI/Rs79nXH6TVyYCqfN
 DHUK5GTuxVWewC0E2d7+M4uDwMm84Qdrju3dsJ3grjCW+pZM+c9HFQtB6R8jbK/zpGLW9G1WS+Q
 DmZXxypKWWEtSN62Dn5ashBGp+E4cVTS50FMRQ+SgtS0IwlLdSlVG
X-Gm-Gg: ASbGncv97OmO2qpht8diDKTW9cYVdUYcFQmg2bZLk1tRaQkSySw2cc0J2LChHVA6QtO
 LmEAVsnPdEcnEqoBtUyJb3b7h3YEQ0r0Rc/Fj2ouWYRjMzQBAVQpU+tLoShclwa3NawJd9KDGdx
 PoLW6k1pTqocW+i+umKD3gipHGKQaclzHzvCWnLNGdg3F+aUv1exaZ6yL+zCIYzKTFUeFQ0Y8m+
 EDnFDaoPIoKlcvH4NQBhNqa8aBwWO2xbcdhAp32N0RrL7ddGqx0A+OlRMOu9szLS7gEXW26pah3
 FOacKSAKf37i/3nWn7iEaszIzN893aYy24kcqkweJ6ITbZVXhv2DQYUVbyqDCjE=
X-Received: by 2002:a05:6000:2b01:b0:390:e9e2:828e with SMTP id
 ffacd0b85a97d-390e9e28568mr585725f8f.32.1740662636387; 
 Thu, 27 Feb 2025 05:23:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQXzOKzEDenCsFiQtIEa/8g0gcGHJegK46j5f/hefRmdAuM29CTrqDy3E7ROmmChOu9kCEsg==
X-Received: by 2002:a05:6000:2b01:b0:390:e9e2:828e with SMTP id
 ffacd0b85a97d-390e9e28568mr585702f8f.32.1740662635947; 
 Thu, 27 Feb 2025 05:23:55 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7b6asm2108584f8f.51.2025.02.27.05.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 05:23:55 -0800 (PST)
Date: Thu, 27 Feb 2025 14:23:54 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/21] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250227142354.711204b1@imammedo.users.ipa.redhat.com>
In-Reply-To: <ce0db0a85f31a58c44e25198f0ef3614c717cb07.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
 <ce0db0a85f31a58c44e25198f0ef3614c717cb07.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 27 Feb 2025 12:03:36 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its the start of the table at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c         | 20 +++++++++++++++++++-
>  include/hw/acpi/ghes.h |  7 ++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 9243b5ad4acb..8ec423726b3f 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -30,6 +30,7 @@
>  
>  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
>  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -341,6 +342,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    uint32_t hest_offset;
> +
> +    hest_offset = table_data->len;
>  
>      build_ghes_error_table(ags, hardware_errors, linker);
>  
> @@ -352,6 +356,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                    ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
> +
> +    if (ags->use_hest_addr) {
> +        /*
> +         * Tell firmware to write into GPA the address of HEST via fw_cfg,
> +         * once initialized.
> +         */
> +        bios_linker_loader_write_pointer(linker,
> +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                         sizeof(uint64_t),
> +                                         ACPI_BUILD_TABLE_FILE, hest_offset);
> +    }
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -361,7 +376,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    if (!ags->use_hest_addr) {
> +    if (ags->use_hest_addr) {
> +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    } else {
>          /* Create a read-write fw_cfg file for Address */
>          fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>              NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 5000891f163f..38abe6e3db52 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -70,9 +70,14 @@ enum {
>   * When use_hest_addr is false, the GPA of the etc/hardware_errors firmware
>   * is stored at hw_error_le. This is the default on QEMU 9.x.
>   *
> - * An GPA value equal to zero means that GHES is not present.
> + * When use_hest_addr is true, the stored offset is placed at hest_addr_le,
                                             ^^^^^ it's not offset, it's GPA
please get rid of offset language in this comment.
        
> + * meaning an offset from the HEST table address from etc/acpi/tables firmware.
> + * This is the default for QEMU 10.x and above.
> + *
> + * Whe both GPA values are equal to zero means that GHES is not present.
>   */
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool use_hest_addr;         /* Currently, always false */
>  } AcpiGhesState;


