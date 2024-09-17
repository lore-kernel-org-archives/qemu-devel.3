Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D15EC35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUbj-0007BP-UF; Tue, 17 Sep 2024 05:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqUbh-00078a-4q
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqUbf-00061U-N7
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726565686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jjkuNBDLMIAJ/uQm+mpkOUbFOPVD1Lvn3qtluJr/L6k=;
 b=dYuDXHnhkMiDKRP69HfvNrdzBGrUKxuy5uF1ij3mtDkqQ5k6ZUryFg2O/RKATbQVTMv8rE
 Q+naKeowyiippYw8fmI0KmwzIrpxcBN/2t17sbihTV6Exy6VRRdponnMNg7UGgWqLp9QSr
 FN+h50JSlce+osUAN37xjSJllh3O5WE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-tbieDZGUOmewL0weLzW3Eg-1; Tue, 17 Sep 2024 05:34:44 -0400
X-MC-Unique: tbieDZGUOmewL0weLzW3Eg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5367cae7614so1133603e87.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 02:34:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726565683; x=1727170483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jjkuNBDLMIAJ/uQm+mpkOUbFOPVD1Lvn3qtluJr/L6k=;
 b=BYCyuPjZfyo5YkBQy8bswAR+680ALTeHgi4hBAZSXSG+Tin71AhpJ+Gbs1nP4oswrE
 H3mJ7/p6+5bI3cdsyxeh+fC2NqEiamqumdPDDoEbXU29JmuIXR6qpaGuKm8Vx/uj52Qn
 BRK54l7gXJ+q2OGUrQOm/L+daCJ5/PMWSLzjtbfHNMX/gl7gnH8caW2nyzxv0msl6LJH
 0//pKvpNdoVK/0RuWKLcujNXBcQdcXJTpf8e5n17sJNdAWyikmDrOSqyOajqSgss/8ZM
 oY2lJ8Efg0liMTmC+VYcm1VMQ/1RBwIrZvyzeC4hC94ss1Qf0d7O/Dx2ZRU/k1i275Au
 ml0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyj+rsuh2ywFMwjbrG2baYF4g9z7mGvS2fKDZXmJupwtWSA/0vJbMChKOTGIeWNffSmLxnKthXxquD@nongnu.org
X-Gm-Message-State: AOJu0Yz+4GJ88W8A/EFHo/JkCS611CdhG2umGE9MnV1XSlKUrKMzFNJj
 LOmBHJtdOla7/xm8ax7pu5oJmI5uqE1794ROd8mlG7Pwqt0BY6JSBxJjwmsFo+veqZxpMyXOOvy
 gvoSaXNgMvLMlnVoyP4cAVfSdhxFcc4Tuyel2VTkJEvcp2h/mihUf
X-Received: by 2002:a05:6512:ea4:b0:52e:f907:1023 with SMTP id
 2adb3069b0e04-53678ff5e06mr9932920e87.49.1726565682973; 
 Tue, 17 Sep 2024 02:34:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx9LegrKHp/daHt+ABb2qNfSu0ZiXmGlSGM+DWvjW//RcWpKn1wgglAmL+62PIHMLYMDeVvQ==
X-Received: by 2002:a05:6512:ea4:b0:52e:f907:1023 with SMTP id
 2adb3069b0e04-53678ff5e06mr9932887e87.49.1726565682325; 
 Tue, 17 Sep 2024 02:34:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22d85f2sm96908345e9.17.2024.09.17.02.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 02:34:41 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:34:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 01/21] acpi/ghes: add a firmware file with HEST address
Message-ID: <20240917113441.430d0bd9@imammedo.users.ipa.redhat.com>
In-Reply-To: <a1dacc20d1a2e6fc0031f957863750bd6132f423.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <a1dacc20d1a2e6fc0031f957863750bd6132f423.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, 14 Sep 2024 08:13:22 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its content at
> hest_addr_le variable.

say here why (just short description and pointing to the next patch
that would do that)

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

PS:
I'd move this patch to later in the series,
right before the patch where you are going to use hest_addr_le

> 
> ---
> 
> Change from v8:
> - hest_addr_lr is now pointing to the error source size and data.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
stray Signed-off-by

> ---
>  hw/acpi/ghes.c         | 15 +++++++++++++++
>  include/hw/acpi/ghes.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e9511d9b8f71..529c14e3289f 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -30,6 +30,7 @@
>  
>  #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
>  #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -367,11 +368,22 @@ void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>  
>      acpi_table_begin(&table, table_data);
>  
> +    int hest_offset = table_data->len;
> +
>      /* Error Source Count */
>      build_append_int_noprefix(table_data, ACPI_GHES_ERROR_SOURCE_COUNT, 4);
>      build_ghes_v2(table_data, ACPI_HEST_SRC_ID_SEA, linker);
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
> @@ -385,6 +397,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);
>  
> +    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +
>      ags->present = true;
>  }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 674f6958e905..28b956acb19a 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -63,6 +63,7 @@ enum {
>  };
>  
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t ghes_addr_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;


