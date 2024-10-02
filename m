Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E022FCF6D28
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 14:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw0I7-00052I-HD; Wed, 02 Oct 2024 10:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sw0I1-00051r-R0
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sw0I0-0007DX-5n
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 10:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727879114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7yYLFWSqoKhXSseNrFGZ+H7UKls7TXd7XUU0eMiJ64U=;
 b=iR2b7CRk3bWAXvWLxf9bULOqOW7ntkckUWDIXT8Al5JKeq8z419+R1xAjaGFmTLsUtgDsd
 fyfsCJ/H+p2VOr6u73Hp5jfHaiRquVcHaXQ+meaF/3FhgwSKHoK7+QBRSfcmc8CbuhwBnZ
 kEpMTeVWa+9hsjdLe9jALM+JMb9/fBs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-tb7LT-r_MRagraUiTvQLfg-1; Wed, 02 Oct 2024 10:25:13 -0400
X-MC-Unique: tb7LT-r_MRagraUiTvQLfg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42f310f0ed2so67222905e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 07:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727879112; x=1728483912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yYLFWSqoKhXSseNrFGZ+H7UKls7TXd7XUU0eMiJ64U=;
 b=keG+u6Psa1s0vBK6vb6kQEqPKLcDMdT/yapJ7WyyZWiaAzYTOKdWWHShXkjwDAOBW9
 Icr0X10v9schGxw5pevU+jZgNLjhS1Wp//9y6Q8/Hvast2kv1GrjnMeBx56nRwR8yej2
 ajvYGSkOHDJA04nW1NACcp/fAPtixUYU9B7W2OWiUZCv8+73fitBsHh6V4zJL7IZF7+v
 anJT7ZcAhoHnl3bnTDGEBo+j4r3UWWeNRGHBsv9O4Ib/W/l31qQzXteadi1mqAW0kvt4
 54ow2DHRNNxJdRVg6bUiSJR+51llQZNzMKPowOasK4+P7idnhpxAYz9FJCUr4lh9St2B
 eRtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfdi/kbENOIXwjXQpfqnEcybyoMMHQXIml1d/XplY6T4u5hvgWjwudjc6au5rlPGkZc1dM8PZKJqZR@nongnu.org
X-Gm-Message-State: AOJu0YygiAMtWXQ7UOjy9V7zjvwHAm/9n5goGTrECqT1jI6A8yyUF5yG
 WTvN5UiVoDbe8BmNeVHRQACVkZN5uhCv3TK1qCg9JNYjKZ6RZw95fescF/9KWMfmqa5c+lBgHZ6
 sJmheddZP8z6E7g0yXkrTseYeCYiG69OnLER42u8ZVOT+g4i/zJUB
X-Received: by 2002:adf:e712:0:b0:37c:d1c6:7e45 with SMTP id
 ffacd0b85a97d-37cfba0a614mr2591332f8f.40.1727879112094; 
 Wed, 02 Oct 2024 07:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvsBZu6kUdqGD6UWXQeMJQdhI82ZeuVK+z+lgmZ2rR4jdzCitMuuMV5JcjWjKCcTMKcXxDcg==
X-Received: by 2002:adf:e712:0:b0:37c:d1c6:7e45 with SMTP id
 ffacd0b85a97d-37cfba0a614mr2591309f8f.40.1727879111650; 
 Wed, 02 Oct 2024 07:25:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d2aasm14147627f8f.4.2024.10.02.07.25.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 07:25:11 -0700 (PDT)
Date: Wed, 2 Oct 2024 16:25:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 2/5] acpi/ghes: Use HEST table offsets when
 preparing GHES records
Message-ID: <20241002162510.6cb7aef6@imammedo.users.ipa.redhat.com>
In-Reply-To: <9eacb24e5e13b2028be90d19e936868a921f8e34.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
 <9eacb24e5e13b2028be90d19e936868a921f8e34.1727782588.git.mchehab+huawei@kernel.org>
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

On Tue,  1 Oct 2024 13:42:47 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are two pointers that are needed during error injection:
> 
> 1. The start address of the CPER block to be stored;
> 2. The address of the ack, which needs a reset before next error.
> 
> Calculate them preferrable from the HEST table, as this allows
> checking the source ID, the size of the table and the type of
> HEST error block structures.
> 
> Yet, keep the old code, as this is needed for migration purposes.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 93 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 83 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 2c2cf444edeb..313a6e453af6 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -61,6 +61,23 @@
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> +/*
> + * Offsets with regards to the start of the HEST table stored at
> + * ags->hest_addr_le, according with the memory layout map at
> + * docs/specs/acpi_hest_ghes.rst.
> + */
> +
> +/* ACPI 6.2: 18.3.2.8 Generic Hardware Error Source version 2
> + * Table 18-382 Generic Hardware Error Source version 2 (GHESv2) Structure
> + */
> +#define HEST_GHES_V2_TABLE_SIZE  92
> +#define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET)
> +
> +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source
> + * Table 18-380: 'Error Status Address' field
> + */
> +#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET)
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -218,14 +235,6 @@ static void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker,
>  {
>      int i, error_status_block_offset;
>  
> -    /*
> -     * TODO: Current version supports only one source.
> -     * A further patch will drop this check, after adding a proper migration
> -     * code, as, for the code to work, we need to store a bios pointer to the
> -     * HEST table.
> -     */
> -    assert(num_sources == 1);
> -
>      /* Build error_block_address */
>      for (i = 0; i < num_sources; i++) {
>          build_append_int_noprefix(hardware_errors, 0, sizeof(uint64_t));
> @@ -425,6 +434,65 @@ static void get_ghes_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
>  }
>  
> +static void get_hest_offsets(uint16_t source_id, uint64_t hest_addr,
> +                             uint64_t *cper_addr,
> +                             uint64_t *read_ack_start_addr,
> +                              Error **errp)

cper/read_ack are GHES specific only, aren't they?

perhaps s/get_hest_offsets/get_ghes_source_offsets/


> +{
> +    uint64_t hest_err_block_addr, hest_read_ack_start_addr;
> +    uint64_t err_source_struct, error_block_addr;
> +    uint32_t num_sources, i;
> +
> +    if (!hest_addr) {
> +        return;
> +    }
> +
> +    cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
> +
> +    err_source_struct = hest_addr + sizeof(num_sources);
> +
> +    /*
> +     * Currently, HEST Error source navigates only for GHESv2 tables
> +     */
> +
> +    for (i = 0; i < num_sources; i++) {

missing le2cpu(num_sources)

> +        uint64_t addr = err_source_struct;
> +        uint16_t type, src_id;
> +
> +        cpu_physical_memory_read(addr, &type, sizeof(type));

ditto for anything larger than 1 byte that you read from guest memory
(all over the patch)

> +
> +        /* For now, we only know the size of GHESv2 table */
> +        assert(type == ACPI_GHES_SOURCE_GENERIC_ERROR_V2);

Imagine in qemu-9.3 we add non GHES error source, and then try to migrate
such guest to qemu-9.2. It will explode here.
Of-cause we can add some compat property to ged or machine type to
make sure that code works old way in qemu-9.3 for virt-9.2
at expense of keeping 9.2 code in 9.3. Which adds to maintenance burden
and fragile, also it's a matter of time before we screw it up and release
non-migratable/broken QEMU.

So I'd like to avoid piling up compat code/knobs on to of each other
and do it in a way where this src id lookup could gracefully skip
not implemented yet error sources.
This way we won't need any compat knobs to deal with in the future. 

> +
> +        /* It is GHES. Compare CPER source address */
> +        addr += sizeof(type);
> +        cpu_physical_memory_read(addr, &src_id, sizeof(src_id));
> +
> +        if (src_id == source_id) {
> +            break;
> +        }
> +
> +        err_source_struct += HEST_GHES_V2_TABLE_SIZE;
> +    }
> +    if (i == num_sources) {
> +        error_setg(errp, "HEST: Source %d not found.", source_id);
> +        return;
> +    }
> +
> +    /* Navigate though table address pointers */
> +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> +    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;

s/hest_read_ack_start_addr/hest_read_ack_addr/

> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(error_block_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    cpu_physical_memory_read(hest_read_ack_start_addr, read_ack_start_addr,
> +                             sizeof(*read_ack_start_addr));
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -445,8 +513,13 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
> -                     &cper_addr, &read_ack_register_addr);
> +    if (!ags->hest_addr_le) {
> +        get_ghes_offsets(le64_to_cpu(ags->hw_error_le),

should it be named get_hw_error_offsets

> +                         &cper_addr, &read_ack_register_addr);
> +    } else {
> +        get_hest_offsets(source_id, le64_to_cpu(ags->hest_addr_le),
> +                         &cper_addr, &read_ack_register_addr, errp);
> +    }
>  
>      if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");


