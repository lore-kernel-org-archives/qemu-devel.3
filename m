Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD29C18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJ9J-0001pc-LU; Wed, 26 Feb 2025 10:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJ9G-0001nU-ET
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJ9B-00083w-Mp
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740582987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAMKaxbCuypd3vaZYRif/XLYSi0QvW8Uwy9pZuSSG5I=;
 b=JzGARadcb4ODMMtNoYYkpPqQH470eE01/59sJFnMxz/jI7S2YIrBf/B1GHcvCXa0Sluqx1
 ZgnLb5bx9wA0LnQPYqMoWIQatc6uatDAX4eWo3FB/vMtJveRUtI/NvUyFlmYN26AE2AtAG
 6xirunqFdCFnAwoUkrI3Z7k90D+JBAw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76--lXRrI49NTOkxkeDPxCpgg-1; Wed, 26 Feb 2025 10:16:24 -0500
X-MC-Unique: -lXRrI49NTOkxkeDPxCpgg-1
X-Mimecast-MFC-AGG-ID: -lXRrI49NTOkxkeDPxCpgg_1740582983
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-439a5c4dfb2so31677785e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:16:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740582983; x=1741187783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAMKaxbCuypd3vaZYRif/XLYSi0QvW8Uwy9pZuSSG5I=;
 b=NWhJtqOkNlLGoo8rYNWZW51sP7+faUhMAg0qO1ZdqX3ROCGTTe6alOfDJ8JkmmIlXt
 p7ok47IZJUbhTzMA8TN8qT8j4v+RFcf/aeDtwM0BPG5q/aB0+kuVxymaTyrO9yO88prz
 D8yvRvxJhdtdERnnhmsXgozWIJbIXxm4taP+/yCfn48uyAS6ksbsOCAovDeDv0hTCdwx
 m11QvugSpCdssT9eWwumJbsh+tnVNGw9tcEvweOci/s3zOE5HPUtsxpoy9AvMtDrD8NL
 9NWtyXyfAllIMoTs1TR0dI7I8RfRpDPYUCGZFLvYPHvW5KuV8slugaL+SIjF8bWzGtOB
 SWmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyDHkB7uXLyYOqZJ8qfCyNzJcfGmHxM0EnWPaIZ7ZIKPPXhZ6jI2TC1RS1bJ2RSH7cPjaZ+EJeQbMX@nongnu.org
X-Gm-Message-State: AOJu0YxJiAEGlC6ufTtQulMXhG1y0g8Z+VvR7gBoMjJddW8SlXVgkEBH
 25/VNAhXYu0hJunTHFgCb5V1x95qou1Eu/W8ZZ4AK1o7c4SOMqNuwbVxlJD6E3k7a+uxSXxnpee
 qfw1oDhByGwphIkELBIPFR0bFubocb9SUuvSvoPO2DDkdeqZaEO1g
X-Gm-Gg: ASbGncsgUrdKvjcS5blZr6D5DizuuJL7nShBA69s1VAAacZdxjlhE75CjBAagNWdonH
 PTSITiSaxDAqgYTC3nUlhqef+ynWflGfXj5ljWwrdt12igKsJbkLYVAUsQnbhz0tyHU69xc9Uik
 siej4VcC1Vyy0qU4PZ6EwuaNxRlr+sb5zImxFocRfdQMbZDwFB0obILYkI8XLTpfHG4pMRhH0Kd
 jM67P6WWxFNDt382khlIXckGhFEBOfwNKlLPOErRrQOBbJiyMa/hTedlv7gYYIWMD2584dwta9I
 fNAT7m3T1PSpU7g7myjZ1aemo2lALJGTjfZir8LPwvs4Ng4LPvVQJ4jBVgLYrnA=
X-Received: by 2002:a05:600c:3b13:b0:439:8b19:fa92 with SMTP id
 5b1f17b1804b1-43ab8fd1d5dmr31944425e9.3.1740582982931; 
 Wed, 26 Feb 2025 07:16:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlM6i8Ee/tLzlEeUpo6E2Z8sILDKY6kCfAi/XqI/dobpFiR2uV+QuL0e7RHhvki21w2RWp4g==
X-Received: by 2002:a05:600c:3b13:b0:439:8b19:fa92 with SMTP id
 5b1f17b1804b1-43ab8fd1d5dmr31943985e9.3.1740582982458; 
 Wed, 26 Feb 2025 07:16:22 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba549d6asm24515085e9.36.2025.02.26.07.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:16:21 -0800 (PST)
Date: Wed, 26 Feb 2025 16:16:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/14] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20250226161621.61d482fc@imammedo.users.ipa.redhat.com>
In-Reply-To: <0134424ddba15dea8daaf32b09e89f1bf7e81552.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <0134424ddba15dea8daaf32b09e89f1bf7e81552.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
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

On Fri, 21 Feb 2025 15:35:12 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the ack.
s/ack/read_ack/

> 
> It is preferable to calculate them from the HEST table.  This allows
> checking the source ID, the size of the table and the type of the
> HEST error block structures.
> 
> Yet, keep the old code, as this is needed for migration purposes

+ from older QEMU versions

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/ghes.c         | 100 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/ghes.h |   2 +-
>  2 files changed, 101 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index ba37be9e7022..7efea519f766 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -41,6 +41,12 @@
>  /* Address offset in Generic Address Structure(GAS) */
>  #define GAS_ADDR_OFFSET 4
>  
> +/*
> + * ACPI spec 1.0b
> + * 5.2.3 System Description Table Header
> + */
> +#define ACPI_DESC_HEADER_OFFSET     36
> +
>  /*
>   * The total size of Generic Error Data Entry
>   * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> @@ -61,6 +67,30 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * See the memory layout map at docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/*
> + * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_ENTRY_SIZE  92
> +
> +/*
> + * ACPI 6.1: 18.3.2.7: Generic Hardware Error Source
wrong chapter, read ack can't be in v1 GHES

> + * Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure
> + * Read Ack Register
> + */
> +#define GHES_READ_ACK_ADDR_OFF          64
> +
> +/*
> + * ACPI 6.1: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-341 Generic Hardware Error Source Structure
> + * Error Status Address
> + */
> +#define GHES_ERR_STATUS_ADDR_OFF  20
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -412,6 +442,73 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
> +static void get_ghes_source_offsets(uint16_t source_id,
> +                                    uint64_t hest_addr,
> +                                    uint64_t *cper_addr,
> +                                    uint64_t *read_ack_start_addr,
> +                                    Error **errp)
> +{
> +    uint64_t hest_err_block_addr, hest_read_ack_addr;
> +    uint64_t err_source_entry, error_block_addr;
> +    uint32_t num_sources, i;
> +
> +    hest_addr += ACPI_DESC_HEADER_OFFSET;
> +
> +    cpu_physical_memory_read(hest_addr, &num_sources,
> +                             sizeof(num_sources));
> +    num_sources = le32_to_cpu(num_sources);
> +
> +    err_source_entry = hest_addr + sizeof(num_sources);
> +
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
> +    for (i = 0; i < num_sources; i++) {
> +        uint64_t addr = err_source_entry;
> +        uint16_t type, src_id;
> +
> +        cpu_physical_memory_read(addr, &type, sizeof(type));
> +        type = le16_to_cpu(type);
> +
> +        /* For now, we only know the size of GHESv2 table */
> +        if (type != ACPI_GHES_SOURCE_GENERIC_ERROR_V2) {
> +            error_setg(errp, "HEST: type %d not supported.", type);
> +            return;
> +        }
> +
> +        /* Compare CPER source address at the GHESv2 structure */
                                  ^^^^^ typo?

> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> +        if (le16_to_cpu(src_id) == source_id) {
> +            break;
> +        }
> +
> +        err_source_entry += HEST_GHES_V2_ENTRY_SIZE;
> +    }
> +    if (i == num_sources) {
> +        error_setg(errp, "HEST: Source %d not found.", source_id);
> +        return;
> +    }
> +
> +    /* Navigate though table address pointers */
                   ^^^^^ typo
 
> +    hest_err_block_addr = err_source_entry + GHES_ERR_STATUS_ADDR_OFF +
> +                          GAS_ADDR_OFFSET;
> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +    error_block_addr = le64_to_cpu(error_block_addr);
> +
> +    cpu_physical_memory_read(error_block_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +    *cper_addr = le64_to_cpu(*cper_addr);
> +
> +    hest_read_ack_addr = err_source_entry + GHES_READ_ACK_ADDR_OFF +
> +                         GAS_ADDR_OFFSET;
> +    cpu_physical_memory_read(hest_read_ack_addr, read_ack_start_addr,
> +                             sizeof(*read_ack_start_addr));
> +    *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -437,6 +534,9 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
> +    } else {
> +        get_ghes_source_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> +                                &cper_addr, &read_ack_register_addr, errp);
>      }
>  
>      if (!cper_addr) {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 454e97b5341c..2f06e433ce04 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -80,7 +80,7 @@ enum {
>  typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
> -    bool use_hest_addr;         /* Currently, always false */
> +    bool use_hest_addr; /* True if HEST address is present */
>  } AcpiGhesState;
>  
>  void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,


