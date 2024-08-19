Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439F5C52D6F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 14:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg32y-0003XM-Eu; Mon, 19 Aug 2024 10:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg32u-0003PW-U4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:07:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sg32s-0007aG-7W
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724076460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XaG8gnC9HkBkVZUgCu9DLDVNY0F8IxCdBiRj1sSxhj0=;
 b=g9t/RzUtyzWvsa67Sx02VaKYHpdQca/jW63/1cEumioIy5j96AM9fo9wfI9s33aAsfPTHr
 HuP/8kV5uTUbSoli3087jPuBQwQd2Z8eNo2qlScgWh3zIjDG90YURbI7hk5rKum3tIMK6V
 kyJnMgGdN//9cphjf8mnyj+XA4XToZM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-mRRx5PZRN1ynXVvtLfL7RA-1; Mon, 19 Aug 2024 10:07:38 -0400
X-MC-Unique: mRRx5PZRN1ynXVvtLfL7RA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42816aacabcso37167165e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 07:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724076455; x=1724681255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaG8gnC9HkBkVZUgCu9DLDVNY0F8IxCdBiRj1sSxhj0=;
 b=qhjTX2uY0JQuWeIcu8xsaZoCfMkABYxHd114fWgNcnwr6lyohrr1LMGuIU9IZRO07y
 1ckDVAEG3qqaIGhNr1YS4otuWgvqi4TcSOyIrrfskWKpi4VQ03kMYvGKhuStxByA8QoG
 PpFi4kC4Us3ycLTEukVzAjQ/RcX9jgAwFe1Ihoh17RozxubgpPtM/b5B++kGsA1L9nSH
 y9QwzWHeyDyhRLjqKIk4qEnWMC9k6BXs0qW6JVH2d0ujvKU9bYk0NuZIqyne3g/TvwP0
 hct+gGcO0lYZ2TpdRtlMkkahUxw7d0C+lh08Ccc54pOVhwIdesYcnSuCC7LypGkHLkEV
 WmSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsOrLg7i3ktiGYL9xm4WMHP5kxP7lAAgVo4SFDFbwqsNS/0F87K6MW37FN3iz9ya0bDUYin5A7lT47@nongnu.org
X-Gm-Message-State: AOJu0YxyKk/L2hgOiYCttorQhD/K3aHnlErmeVQZ8aoNg7Ivszc/tAS0
 qOMiqk07E4jNpW9RyvMnW15frZKenbJeqmL+h/GQIhHcI/inFaq3+wIYEUoBNNLCXF5SUZ/vKWV
 swyIC3xxh+J6T9I3ycDnDBWDizYtivlrShI+RrEwE6e6CVbMc8zdu
X-Received: by 2002:a05:600c:3c92:b0:428:14b6:ce32 with SMTP id
 5b1f17b1804b1-429ed794e9bmr83814535e9.9.1724076455466; 
 Mon, 19 Aug 2024 07:07:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfRKyefx3jM8peabry8rlLAWDzXV188Bk6OgXILyrHTgcw2C0oEyb8nbpJUVCVYivXUG6/SQ==
X-Received: by 2002:a05:600c:3c92:b0:428:14b6:ce32 with SMTP id
 5b1f17b1804b1-429ed794e9bmr83814305e9.9.1724076454913; 
 Mon, 19 Aug 2024 07:07:34 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded7d5a9sm164102525e9.43.2024.08.19.07.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 07:07:34 -0700 (PDT)
Date: Mon, 19 Aug 2024 16:07:33 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v8 13/13] acpi/ghes: check if the BIOS pointers for HEST
 are correct
Message-ID: <20240819160733.464ccebf@imammedo.users.ipa.redhat.com>
In-Reply-To: <52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
 <52e6058feba318d01f54da6dca427b40ea5c9435.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 16 Aug 2024 09:37:45 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The OS kernels navigate between HEST, error source struct
> and CPER by the usage of some pointers. Double-check if such
> pointers were properly initializing, ensuring that they match
> the right address for CPER.

as QEMU, we don't care about what guest wrote into those addresses
(aka it's not hw businesses), even if later qemu will trample
on wrong guest memory (it's guest responsibility to do init right).

However this patch introduces usage for hest_addr_le, that I was looking for.
See notes below.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index a822a5eafaa0..51e2e40e5a9c 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -85,6 +85,9 @@ enum AcpiHestSourceId {
>  #define HEST_GHES_V2_TABLE_SIZE  92
>  #define GHES_ACK_OFFSET          (64 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
>  
> +/* ACPI 6.2: 18.3.2.7: Generic Hardware Error Source */
> +#define GHES_ERR_ST_ADDR_OFFSET  (20 + GAS_ADDR_OFFSET + ACPI_HEST_HEADER_SIZE)
> +
>  /*
>   * Values for error_severity field
>   */
> @@ -425,7 +428,10 @@ NotifierList acpi_generic_error_notifiers =
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               enum AcpiGhesNotifyType notify, Error **errp)
>  {
> -    uint64_t cper_addr, read_ack_start_addr;
> +    uint64_t hest_read_ack_start_addr, read_ack_start_addr;
> +    uint64_t read_ack_start_addr_2, err_source_struct;
> +    uint64_t hest_err_block_addr, error_block_addr;
> +    uint64_t cper_addr, cper_addr_2;
>      enum AcpiHestSourceId source;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -450,6 +456,28 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      cper_addr += ACPI_HEST_SRC_ID_COUNT * sizeof(uint64_t);
>      cper_addr += source * ACPI_GHES_MAX_RAW_DATA_LENGTH;
>  
> +    err_source_struct = le64_to_cpu(ags->hest_addr_le) +
> +                        source * HEST_GHES_V2_TABLE_SIZE;

there is no guaranties that HEST table will contain only GHESv2 sources,
and once such is added this place becomes broken.

we need to iterate over HEST taking that into account
and find only ghesv2 structure with source id of interest.

This function (and acpi_ghes_record_errors() as well) taking source_id
as input should be able to lookup pointers from HEST in guest RAM,
very crude idea could look something like this:

typedef struct hest_source_type2len{
   uint16_t type
   int len
} hest_structure_type2len

hest_structure_type2len supported_hest_sources[] = {
    /* Table 18-344 Generic Hardware Error Source version 2 (GHESv2) Structure */
    {.type = 10, .len = 92},
}

uint64_t find_error_source(src_id) {
    uint32_t struct_offset = hest_header_size;
    uint16_t type, id
    do {
       addr = ags->hest_addr_le + struct_offset
 
       cpu_physical_memory_read(addr, &id)
       if (src_id == id)
         return addr

       cpu_physical_memory_read(addr, &type)
       struct_offset ++= get_len_from_supported_hest_sources(type)
    while(struct_offset < hest_len)
    assert if not found
}

unit64_t get_error_status_block_addr(src_id) {
   struct_addr = find_error_source(src_id) 
   hest_err_block_addr =   struct_addr + GHES_ERR_ST_ADDR_OFFSET
   // read intermediate pointer to status block addr pointer in hw table
   cpu_physical_memory_read(hest_err_block_addr, &error_block_addr)
   // read actual pointer to status block
   cpu_physical_memory_read(error_block_addr, &error_status_block_addr)
   return error_status_block_addr
}
 
ditto for read_ack modulo indirection that we have for error_status_block_addr

This way we can easily map source id to error status block
and find needed addresses using pointer info from guest RAM
without fragile pointer math and assumptions which might go wrong
when new error sources are added and regardless of the order they
are being added.

> +    /* Check if BIOS addr pointers were properly generated */
> +
> +    hest_err_block_addr = err_source_struct + GHES_ERR_ST_ADDR_OFFSET;
> +    hest_read_ack_start_addr = err_source_struct + GHES_ACK_OFFSET;
> +
> +    cpu_physical_memory_read(hest_err_block_addr, &error_block_addr,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(error_block_addr, &cper_addr_2,
> +                             sizeof(error_block_addr));
> +
> +    cpu_physical_memory_read(hest_read_ack_start_addr, &read_ack_start_addr_2,
> +			     sizeof(read_ack_start_addr_2));
> +
> +    assert(cper_addr == cper_addr_2);
> +    assert(read_ack_start_addr == read_ack_start_addr_2);
> +
> +    /* Update ACK offset to notify about a new error */
> +
>      cpu_physical_memory_read(read_ack_start_addr,
>                               &read_ack, sizeof(uint64_t));
>  


