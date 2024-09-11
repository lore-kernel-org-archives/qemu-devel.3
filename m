Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3BFEE49B7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 14:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOMN-00034O-PF; Wed, 11 Sep 2024 10:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1soOMK-0002oe-61
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1soOMH-0003z6-TN
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726065012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+GQVE2uuyEK3/RgorpZcN0UGcAeWWEStHDF6T/3/l8s=;
 b=G4CNCC4q2ffLLYECcysVS4CI5eWypdfkD/phl2Awh+twiiW3+Ju018DZ+OuTFJuFSxeRea
 fSnivsBdC6fAo56YAjvFvSQ76KAfRwsXDw/78qquFBMc6/V5P9fvE2qu9alnDbJz1o17lA
 mqw6RuSI3LBHwClZ/jWMhReJRPjKuZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-eVy45LhCOG6qXN2rTYTLjQ-1; Wed, 11 Sep 2024 09:51:11 -0400
X-MC-Unique: eVy45LhCOG6qXN2rTYTLjQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cbfc2aac6so13398725e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062670; x=1726667470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GQVE2uuyEK3/RgorpZcN0UGcAeWWEStHDF6T/3/l8s=;
 b=igkaFeXtwi3mAofua769wdk0/q9fArMSHpXFgau6htvL952O+2cc38qf10jHBwTCZ9
 EVeJFXUnfk1LWxnxPzolYWMvc3oA8LeX5W8F0/+g19G5a+SfR6drWpX6JvIVICYVHV4s
 HIVzMZZsu5temxrAZR72p3Sw//UCXJuZsii64O+mMQK2s1Hwq5edFvhPHJBqBYBn1iKK
 NcT93wNcK8/hejsKctAl/RULXNBYI1W/rA9oN/8vB+3aG22JWMuKPxsnlHUxC9onZ3Zq
 PmBWrrdbIodlY2hG0KkSbORD8j0ZFdcVPJPZ0toG9rNFSGi6fVx/j/BeL9+Xu/iwAyWS
 8p/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIN8rDF0+EFP/PQT5XqUjYZd/n4jS0mJZS7ChRrg0COBqznGahNkTkZzWfLqubQcLIpq78+4K5SW3g@nongnu.org
X-Gm-Message-State: AOJu0YyOcYSX3tvU2pvsNu9IikmztukIWjz0+3OAIu/MF6FH1wSvdKwO
 nDpUmdBw1sEN1iUUgPDBGq10MfJ59vWL/Gnjr9i+8NxVmIcrqTURxPp0qQF9elKLztoHfLMEgn2
 IMRvxvSvLruCshEUCvt2OqYSyLpt0Oc8T/Db4yPLjhdjsTqUnMRVq
X-Received: by 2002:a05:600c:3b9a:b0:42c:af06:718 with SMTP id
 5b1f17b1804b1-42caf060aa3mr100376785e9.28.1726062670561; 
 Wed, 11 Sep 2024 06:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO3J09RP97kvF5YQ4SiyKLFil9vmlggk+kexCDdJuut3M2X4IPjV14jpq8cTqkCN/51S4QQQ==
X-Received: by 2002:a05:600c:3b9a:b0:42c:af06:718 with SMTP id
 5b1f17b1804b1-42caf060aa3mr100376375e9.28.1726062669558; 
 Wed, 11 Sep 2024 06:51:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb21a5csm143859255e9.6.2024.09.11.06.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:08 -0700 (PDT)
Date: Wed, 11 Sep 2024 15:51:08 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST address
Message-ID: <20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
In-Reply-To: <34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
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

On Sun, 25 Aug 2024 05:45:56 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its content at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This looks good to me.

in addition to this, it needs a patch on top to make sure
that we migrate hest_addr_le.
See a08a64627b6b 'ACPI: Record the Generic Error Status Block address'
and fixes on top of that for an example.

> ---
> 
> Change from v8:
> - hest_addr_lr is now pointing to the error source size and data.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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


