Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF2BC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 13:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8Cm-0005Fz-Aq; Wed, 29 Jan 2025 08:34:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8Cl-0005Fg-2D
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:34:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8Cj-0005yU-1L
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738157642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxJvLwmS7fyxaJl56jJBb8LhcmJcQI3meyr6E1SPMfw=;
 b=VanC1klkHBnjeQXvLCTiDQSiK7uk2fOzk8Sd9wEl+x28f7pgkKJAyYD4g6Q79Cxv/qvNdE
 bZqzt7HlJGy/DjamGEgDopNSQgnM69oDPU5Z7dH9j0+N/mlrPiJiNLfUo/kcBm3esKAY+k
 nT8NkYmx2OH4Lwd3s/SSbZc+EGPdExk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-83LDDlYENWK1zjc4b-mo4w-1; Wed, 29 Jan 2025 08:34:01 -0500
X-MC-Unique: 83LDDlYENWK1zjc4b-mo4w-1
X-Mimecast-MFC-AGG-ID: 83LDDlYENWK1zjc4b-mo4w
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43621907030so53509645e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 05:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738157640; x=1738762440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZxJvLwmS7fyxaJl56jJBb8LhcmJcQI3meyr6E1SPMfw=;
 b=rPM7A5/5jCzYjYyWT4eShfezu5DG8UgYxz8Uyp/2kUwefr0TuIXfxh4n+ETzWEVQxM
 qc4FdcT14oaTfJdF2JOZamYarowd3eVzpNBQ5vggcio6fyFl1M4fE7mK4yr8ZZM9RydT
 jrhBkNfYiQ70Ap0UmLNwaRNvA+f6ZjdPKMvZsjdlCiikqGD78ahb562N/LLP0aqGI82I
 LlsUKBUiC8wiPjMTZS4Vc/CT2/Iy0isX67QI4ycrVXRvzcjkMuRYmRqda0lhO1FGmRzt
 CN6tM2KVtBGKZ7CdShcpftlAWy9auWg+FeCLgDVs+kC8TMg+UeqcdeR6uaqV5OfYWXZ6
 f5vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp1UMq25KwQkcfjKFH0ifYVidtUmMPLUENmP/liXeFpH3CJFigJqFuuBPbR/di1VY3XHZ3WOJpikxF@nongnu.org
X-Gm-Message-State: AOJu0Yz0QcBaaRoYQXn1n1r0LgX4GZFqloUQl0461GmnEPgROPxCiRFA
 ucM3yCRpFYG8+hMswiXJWlLuDthJLrCHXo6Wm+4rih0kFmk491d9ZvxQWt4dUNU73bkZw1+39Y8
 b7WE/LMSNEWBgf9QZjU2SfnhU/7pEhQ0Y7sIorIsrHrMvRyBaZVyX
X-Gm-Gg: ASbGncvs+HyyTh4mI3aFcjUDeAYMqSfYYDWL+KQZLe33HsjbZYTPgryyshgCSUdufUi
 FDBgkyZQAHtpykLqxKtFGjFc3B9/mXNTCeP/GsGvKyLy4raZgNrNFGhzJ1WdSGMyVQr4TMHknta
 bE2wV/NIXfNlF/Nr/nfSWRG9pEuK0ujF2Fo22+weIJdgnpTuerwTZ9DtLoFj85VPPGiRVmJHGOd
 TV49qcuDq8OzJvfg/8D8vDQ9+OsT+qfRBryrT4eRlDjUSz/C8JBeOEzGidOC5yXmc4mFT8EQVQo
 xp+wIjTnZFKzyz4sE8aZa1/BVUlsw0vgWY4LQ06gTiJ7PexDfr65
X-Received: by 2002:a05:600c:444c:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-438dc3caef4mr31783895e9.16.1738157640334; 
 Wed, 29 Jan 2025 05:34:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKl9IrMk6oIqeOVtJHZl6r4w9O3o7EdoXO05xkZeTC6mPHJYrNXA44G7CjCW0vmavG+W1sZQ==
X-Received: by 2002:a05:600c:444c:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-438dc3caef4mr31783435e9.16.1738157639796; 
 Wed, 29 Jan 2025 05:33:59 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc11bc1sm24211015e9.3.2025.01.29.05.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 05:33:59 -0800 (PST)
Date: Wed, 29 Jan 2025 14:33:58 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250129143358.1dc9ddff@imammedo.users.ipa.redhat.com>
In-Reply-To: <a3579f6c2c24e764e544f83b6e1b2dbef730e3e3.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <a3579f6c2c24e764e544f83b6e1b2dbef730e3e3.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On Wed, 22 Jan 2025 16:46:19 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its content at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> 
> Change from v8:
> - hest_addr_lr is now pointing to the error source size and data.

that's confusing, variable name say it's HEST table address,
while in practice it's (that + offset).

I'd very much prefer it being table start and then you'd add
offset later on where it's going to be used.  

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c         | 17 ++++++++++++++++-
>  include/hw/acpi/ghes.h |  1 +
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 3f519ccab90d..34e3364d3fd8 100644
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
> @@ -261,7 +262,7 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>      }
>  
>      /*
> -     * tell firmware to write hardware_errors GPA into
> +     * Tell firmware to write hardware_errors GPA into

drop this hunk as it's not related to  the patch

>       * hardware_errors_addr fw_cfg, once the former has been initialized.
>       */
>      bios_linker_loader_write_pointer(linker, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, 0,
> @@ -355,6 +356,8 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  
>      acpi_table_begin(&table, table_data);
>  
> +    int hest_offset = table_data->len;
> +
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, num_sources, 4);
>      for (i = 0; i < num_sources; i++) {
> @@ -362,6 +365,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>      }
>  
>      acpi_table_end(linker, &table);
> +
> +    /*
> +     * tell firmware to write into GPA the address of HEST via fw_cfg,
> +     * once initialized.
> +     */
> +    bios_linker_loader_write_pointer(linker,
> +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                     sizeof(uint64_t),
> +                                     ACPI_BUILD_TABLE_FILE, hest_offset);
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -375,6 +387,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
> +    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +
>      ags->present = true;
>  }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 9f0120d0d596..237721fec0a2 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
>  };
>  
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;


