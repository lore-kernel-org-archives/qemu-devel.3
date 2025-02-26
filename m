Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F08EC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJJf-0005sQ-MX; Wed, 26 Feb 2025 10:27:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJJe-0005oz-8B
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:27:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnJJb-0001AZ-LH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740583633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=opCox9KVcehhy1NQGp4HS1lXiyGpPcoip0UbMOR0ICE=;
 b=aE5hCH2wWLoRLNLq1e385g8taw2gN2p0380RiVbSENYbfRmF6W8LNKtatPYjVGrbxhqkgU
 AY/pICM2rHaKTidzIbh1edt1230KnAA1lYzGYosL6WKueffm6P/2OedJ0GFMR1X/oZG2jW
 TqdLf7dZgYP/Fh63eGlxTb8518+pikU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-1_T610wQO8WtdmbPXC_IsQ-1; Wed, 26 Feb 2025 10:27:08 -0500
X-MC-Unique: 1_T610wQO8WtdmbPXC_IsQ-1
X-Mimecast-MFC-AGG-ID: 1_T610wQO8WtdmbPXC_IsQ_1740583627
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f32ac838cso5247118f8f.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740583627; x=1741188427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=opCox9KVcehhy1NQGp4HS1lXiyGpPcoip0UbMOR0ICE=;
 b=GyfIOFQeFB/z3FuS7MTF7Pvw52FTyxOPUTSa4j5D6cTCX7gwq1nyQdAOOYUHgUmWIZ
 T9FnqLUEfNAyPkxaXFGO2B9LTgo8a6uqqsNe1fVLK1Dr2Kr+/dK+I0ejllopx30b3VnS
 I2BxMGdsygb4GEONoeZRvy+Zd4v0ZXW83tbUp5prYuHsJI4wp+Pc7EeFRjr8AkkFDSpB
 K33tRF0xMd8aHV1PKcTxmThiMalPnNGWVzr7U/IoNoHKZ6RLQLLPFBb+5h/j0wWpZO4j
 G1N8JH1PSlKQ5WRIIxfMqS00IVKbv09wvp+/nnxZ/Mk9DE4e/XNqkC0XHUYMAmjqEJZL
 N8LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjycAO+2eXWkFSWXphWLwQ34hxrCav4XRoTGgnHECYbky0r02Cu//32Cqgxr5ftyjrlmKDtHRkKYVj@nongnu.org
X-Gm-Message-State: AOJu0YyFOKuLLDUBVJzxksvTe/JKbNltDuflyXG3eREwbF97U+GYaXLw
 PfIKw1PDjsq2ROi/FhtshO47zhDGbcN8i/RP50LAopyrNjd7vnI2PJ2K6SxCmZm9tixN4Ow7KDF
 SMp/lRa+Yl8XRaCDWtFDJ/Jlw8Me3qR8HbaJSw2vYHok0haL1CzMS
X-Gm-Gg: ASbGncvvKgiiTURv7PddRdiW9b+UyPEiYPZc85LDmesjXBirrQRIEz1qK5RjNrxYbte
 YyiansJL2h2cJm7JMfPZ6uUYWZCIGfXa8ewTRscEIi32LzueCyapvkkRjH3MbjTB75QLNtgauMM
 RYYLetcn9MoFZWdznNSPDcdQBMUejtgM2r5P/73DEChTjlgzEFKVXfcPF2Aq1uqMKoGVBR7TtqB
 CxXxpLPtN+EoXPRRFRpMunnCeAOSONXXxEqFjGCVSYiejRZCUxTdvSkX0Rgl+56xhYpL3kw/wCQ
 oCO3/dggcQ4MT6J+WG3llWs5bzBcR60tJ3IfuQuJKzeJJsxHJfzyLw1cckz8sx8=
X-Received: by 2002:a5d:5887:0:b0:38f:355b:141e with SMTP id
 ffacd0b85a97d-390d4f378ebmr3452624f8f.3.1740583626909; 
 Wed, 26 Feb 2025 07:27:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1DwZYHHCSs8+Mdqpg+KX0YNs2WqUN7TodnTaxIGwwctMTc50nKGidchiWQV2RbC4q0fkVAw==
X-Received: by 2002:a5d:5887:0:b0:38f:355b:141e with SMTP id
 ffacd0b85a97d-390d4f378ebmr3452587f8f.3.1740583626458; 
 Wed, 26 Feb 2025 07:27:06 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd882a64sm5769008f8f.46.2025.02.26.07.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:27:05 -0800 (PST)
Date: Wed, 26 Feb 2025 16:27:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/14] acpi/ghes: create an ancillary
 acpi_ghes_get_state() function
Message-ID: <20250226162705.67875661@imammedo.users.ipa.redhat.com>
In-Reply-To: <2288cfe02f8cfec4b35759fd748366c885018b59.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <2288cfe02f8cfec4b35759fd748366c885018b59.1740148260.git.mchehab+huawei@kernel.org>
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

On Fri, 21 Feb 2025 15:35:15 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Instead of having a function to check if ACPI is enabled
> (acpi_ghes_present), change its logic to be more generic,
> returing a pointed to AcpiGhesState.
> 
> Such change allows cleanup the ghes GED state code, avoiding
> to read it multiple times, and simplifying the code.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by:  Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes-stub.c    |  7 ++++---
>  hw/acpi/ghes.c         | 38 ++++++++++----------------------------
>  include/hw/acpi/ghes.h | 14 ++++++++------
>  target/arm/kvm.c       |  7 +++++--
>  4 files changed, 27 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 7cec1812dad9..40f660c246fe 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,12 +11,13 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t physical_address)
>  {
>      return -1;
>  }
>  
> -bool acpi_ghes_present(void)
> +AcpiGhesState *acpi_ghes_get_state(void)
>  {
> -    return false;
> +    return NULL;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index f2d1cc7369f4..401789259f60 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -425,10 +425,6 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>                                   uint64_t *cper_addr,
>                                   uint64_t *read_ack_register_addr)
>  {
> -    if (!ghes_addr) {
> -        return;
> -    }
> -
>      /*
>       * non-HEST version supports only one source, so no need to change
>       * the start offset based on the source ID. Also, we can't validate
> @@ -517,27 +513,16 @@ static void get_ghes_source_offsets(uint16_t source_id,
>  NotifierList acpi_generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
>  
> -void ghes_record_cper_errors(const void *cper, size_t len,
> +void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
> -    AcpiGedState *acpi_ged_state;
> -    AcpiGhesState *ags;
>  
>      if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
>          error_setg(errp, "GHES CPER record is too big: %zd", len);
>          return;
>      }
>  
> -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> -                                                       NULL));
> -    if (!acpi_ged_state) {
> -        error_setg(errp, "Can't find ACPI_GED object");
> -        return;
> -    }
> -    ags = &acpi_ged_state->ghes_state;
> -
> -
>      if (!ags->use_hest_addr) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
>                               &cper_addr, &read_ack_register_addr);
> @@ -546,11 +531,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>                                  &cper_addr, &read_ack_register_addr, errp);
>      }
>  
> -    if (!cper_addr) {
> -        error_setg(errp, "can not find Generic Error Status Block");
> -        return;
> -    }
> -
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
>  
> @@ -576,7 +556,8 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      notifier_list_notify(&acpi_generic_error_notifiers, NULL);
>  }
>  
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t physical_address)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> @@ -602,7 +583,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>      acpi_ghes_build_append_mem_cper(block, physical_address);
>  
>      /* Report the error */
> -    ghes_record_cper_errors(block->data, block->len, source_id, &errp);
> +    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
>  
>      g_array_free(block, true);
>  
> @@ -614,7 +595,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>      return 0;
>  }
>  
> -bool acpi_ghes_present(void)
> +AcpiGhesState *acpi_ghes_get_state(void)
>  {
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -623,11 +604,12 @@ bool acpi_ghes_present(void)
>                                                         NULL));
>  
>      if (!acpi_ged_state) {
> -        return false;
> +        return NULL;
>      }
>      ags = &acpi_ged_state->ghes_state;
> -    if (!ags->hw_error_le && !ags->hest_addr_le)
> -        return false;
>  
> -    return true;
> +    if (!ags->hw_error_le && !ags->hest_addr_le) {
> +        return NULL;
> +    }
> +    return ags;
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 219aa7ab4fe0..276f9dc076d9 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -99,15 +99,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
> -void ghes_record_cper_errors(const void *cper, size_t len,
> +int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t error_physical_addr);
> +void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
>  
>  /**
> - * acpi_ghes_present: Report whether ACPI GHES table is present
> + * acpi_ghes_get_state: Get a pointer for ACPI ghes state
>   *
> - * Returns: true if the system has an ACPI GHES table and it is
> - * safe to call acpi_ghes_memory_errors() to record a memory error.
> + * Returns: a pointer to ghes state if the system has an ACPI GHES table,
> + * it is enabled and it is safe to call acpi_ghes_memory_errors() to record
      ^^^^^^^^^^^^^ can't link 'it' with anything, I'd drop this

> + * a memory error. Returns false, otherwise.
                              ^^^ NULL ??

>   */
> -bool acpi_ghes_present(void);
> +AcpiGhesState *acpi_ghes_get_state(void);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb2349..80ca7779797b 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2366,10 +2366,12 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  {
>      ram_addr_t ram_addr;
>      hwaddr paddr;
> +    AcpiGhesState *ags;
>  
>      assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>  
> -    if (acpi_ghes_present() && addr) {
> +    ags = acpi_ghes_get_state();
> +    if (ags && addr) {
>          ram_addr = qemu_ram_addr_from_host(addr);
>          if (ram_addr != RAM_ADDR_INVALID &&
>              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> @@ -2387,7 +2389,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
> +                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SEA,
> +                                             paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {
>                      error_report("failed to record the error");


