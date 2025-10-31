Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FB4CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEp0s-0000Nn-34; Fri, 31 Oct 2025 09:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEp0i-0000Nb-IN
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEp0c-0003lb-5S
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 09:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761916647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4nZN04g0fpHzGnnakyzUEsMbyKPI2T16hrZiR3jQVA=;
 b=fVjoLRd3nZ3N1ZSCoiveh2l04VFqRJjGwduFSAVXshLukFK7cRISCDSkWbAHLpfyLbCr12
 Fdi5M541agksiTmUCit2z81R0r9tcs7GubsHEC38RQkDN0AaK0ZIWKfM+OlAKAVlWJcI2U
 n3n4ykGkf/yDSzc2bkHBKOoMtqOdudM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-l7Hi7Ry7Nr6pHxyNs_pOTg-1; Fri, 31 Oct 2025 09:17:25 -0400
X-MC-Unique: l7Hi7Ry7Nr6pHxyNs_pOTg-1
X-Mimecast-MFC-AGG-ID: l7Hi7Ry7Nr6pHxyNs_pOTg_1761916645
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-476b8c02445so19592375e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 06:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761916644; x=1762521444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k4nZN04g0fpHzGnnakyzUEsMbyKPI2T16hrZiR3jQVA=;
 b=bMkwCdNfL93YBH5G5x1C+VApkdsENpEMhckHCcQRJULncQKkl3EE+Ih1sPy0Rw8u4y
 kYP6WpsZ1fzjOWKUzR6eYbbf81wrvHv0l09qgshGPTagwRFqowI5QQjrt3vAMlB5dxBi
 Qrv81UJL+BKKYImcRyKJc4aaQHsWk4q5DBdyxfwAOpscM2gOupE0kaLdTDsAy2FfxHku
 9d1UMbJJLEcnnjvWyQBwm4OmRek4ncwQj0F3obRtoXzXiy317RKaInHVL2Ld2YRfI/2T
 SChYcHV+8KNxbKrx8kcYSSDwDEj5ozwR8R4hfKuk9Vh2wTbOkN1k5lxGtkVklkZqzM20
 UBSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyd5Gpe7wiJBiOJ4p2Xq+b8Wjy8Vb2zqNdoLFa0wwnwZeekv3pA6eYKj/jOFoy43RLrzhlastGeisE@nongnu.org
X-Gm-Message-State: AOJu0YyQIXnGsW5gDm2pojTOT0XWvsbwN4G/o2UNn1ilUQBnzBrdDxIp
 Yci1tO4j3pL7fSSwjf3yChRRITM/UDRMF9s3zIOtZWhd2s1B15WYAGoLztdT8GzUp2XgirrUT5E
 t9pSLQe/ccMw7/H05/lBUU0TuoaxGvRDLSTEMe/ONSaHp7woeL55nOpLX
X-Gm-Gg: ASbGncsS96/yb5JPO1xOYwtyE6MYkt1VFJk/wU+aWDc3ASXhj1oZqE2lGVIokq4YIBL
 WH0qjhzZvOt8KMoXtGPJ0n/PgXzf7qbbR3cPB3L45ivyZathiI2a7OPcbUQQ5J7YE7MeSHEVt7R
 1r0KY07YHdIgCC2e2RZxVPK+4wsoaXI7f52aAQtZUAOnDh2pqIjZSQw4JpQxAuP7H6DpvEIYmsQ
 3CTQK5+ORpar5b/U4GrbZp4Jn2r8wLV0qF2lk80zfdVkF3E4omtW3sSRlfEmQPSceCgBINUpKQW
 ecEBEhOS30nBLD6DGpsLDd+RjODCdc5wYBi+HDVByA4NKCyzxrl5DF5iF5sVHtty0w==
X-Received: by 2002:a05:600c:828f:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-477308a7b5emr40871085e9.34.1761916644493; 
 Fri, 31 Oct 2025 06:17:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsY3ncpfw8eiQh4KIaiJCPOMuF2F81dtFS+n1DSrptFNRtWHjcGxfDnmVPK0rRJeGLJsxTQQ==
X-Received: by 2002:a05:600c:828f:b0:46e:3d41:6001 with SMTP id
 5b1f17b1804b1-477308a7b5emr40870635e9.34.1761916644052; 
 Fri, 31 Oct 2025 06:17:24 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772ff83182sm21996875e9.4.2025.10.31.06.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:17:23 -0700 (PDT)
Date: Fri, 31 Oct 2025 14:17:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, mchehab+huawei@kernel.org,
 Jonathan.Cameron@huawei.com, shan.gavin@gmail.com
Subject: Re: [PATCH RESEND v2 1/3] acpi/ghes: Extend
 acpi_ghes_memory_errors() to support multiple CPERs
Message-ID: <20251031141721.4d336189@fedora>
In-Reply-To: <20251007060810.258536-2-gshan@redhat.com>
References: <20251007060810.258536-1-gshan@redhat.com>
 <20251007060810.258536-2-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  7 Oct 2025 16:08:08 +1000
Gavin Shan <gshan@redhat.com> wrote:

> In the situation where host and guest has 64KB and 4KB page sizes, one
> error on the host's page affects 16 guest's pages. we need to send 16
> consective errors in this specific case.
> 
> Extend acpi_ghes_memory_errors() to support multiple CPERs after the
> hunk of code to generate the GHES error status is pulled out from
> ghes_gen_err_data_uncorrectable_recoverable().
> 
> No functional changes intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  hw/acpi/ghes-stub.c    |  2 +-
>  hw/acpi/ghes.c         | 27 ++++++++++++++-------------
>  include/hw/acpi/ghes.h |  2 +-
>  target/arm/kvm.c       |  7 ++++++-
>  4 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 40f660c246..c1f8c9bec9 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -12,7 +12,7 @@
>  #include "hw/acpi/ghes.h"
>  
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t physical_address)
> +                            GArray *addresses)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 06555905ce..045b77715f 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -214,18 +214,13 @@ static void acpi_ghes_build_append_mem_cper(GArray *table,
>  
>  static void
>  ghes_gen_err_data_uncorrectable_recoverable(GArray *block,
> -                                            const uint8_t *section_type,
> -                                            int data_length)
> +                                            const uint8_t *section_type)
>  {
>      /* invalid fru id: ACPI 4.0: 17.3.2.6.1 Generic Error Data,
>       * Table 17-13 Generic Error Data Entry
>       */
>      QemuUUID fru_id = {};
>  
> -    /* Build the new generic error status block header */
> -    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE,
> -        0, 0, data_length, ACPI_CPER_SEV_RECOVERABLE);
> -
>      /* Build this new generic error data entry header */
>      acpi_ghes_generic_error_data(block, section_type,
>          ACPI_CPER_SEV_RECOVERABLE, 0, 0,
> @@ -557,19 +552,20 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>  }
>  
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t physical_address)
> +                            GArray *addresses)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
>            UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
>                    0xED, 0x7C, 0x83, 0xB1);
>      Error *errp = NULL;
> -    int data_length;
> +    int data_length, i;
>      GArray *block;
>  
>      block = g_array_new(false, true /* clear */, 1);
>  
> -    data_length = ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH;
> +    data_length = addresses->len *
> +                  (ACPI_GHES_DATA_LENGTH + ACPI_GHES_MEM_CPER_LENGTH);
>      /*
>       * It should not run out of the preallocated memory if adding a new generic
>       * error data entry
> @@ -577,10 +573,15 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>      assert((data_length + ACPI_GHES_GESB_SIZE) <=
>              ACPI_GHES_MAX_RAW_DATA_LENGTH);
>  
> -    ghes_gen_err_data_uncorrectable_recoverable(block, guid, data_length);
> -
> -    /* Build the memory section CPER for above new generic error data entry */
> -    acpi_ghes_build_append_mem_cper(block, physical_address);
> +    /* Build the new generic error status block header */
> +    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE, 0, 0,
                                             ^^^^^
with following loop, it might be no enough. See ACPI6.5 Tables 18.11: Status field

Don't we need to set multiple_foo bit(s) and also fix 'Error Data Entry Count' bits?


> +                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
> +    for (i = 0; i < addresses->len; i++) {
> +        ghes_gen_err_data_uncorrectable_recoverable(block, guid);
> +        /* Memory section CPER on top of the generic error data entry */
> +        acpi_ghes_build_append_mem_cper(block,
> +                                        g_array_index(addresses, uint64_t, i));
> +    }

>  
>      /* Report the error */
>      ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index df2ecbf6e4..a8cbc520d5 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -99,7 +99,7 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t error_physical_addr);
> +                            GArray *addresses);
>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4f769d69b3..9a47ac9e3a 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2434,6 +2434,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>      ram_addr_t ram_addr;
>      hwaddr paddr;
>      AcpiGhesState *ags;
> +    GArray *addresses;
>  
>      assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>  
> @@ -2442,6 +2443,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>          ram_addr = qemu_ram_addr_from_host(addr);
>          if (ram_addr != RAM_ADDR_INVALID &&
>              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
> +            addresses = g_array_new(false, false, sizeof(paddr));
>              kvm_hwpoison_page_add(ram_addr);
>              /*
>               * If this is a BUS_MCEERR_AR, we know we have been called
> @@ -2454,16 +2456,19 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               * later from the main thread, so doing the injection of
>               * the error would be more complicated.
>               */
> +            g_array_append_vals(addresses, &paddr, 1);
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
>                  if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> -                                             paddr)) {
> +                                             addresses)) {
>                      kvm_inject_arm_sea(c);
>                  } else {
>                      error_report("failed to record the error");
>                      abort();
>                  }
>              }
> +
> +            g_array_free(addresses, true);
>              return;
>          }
>          if (code == BUS_MCEERR_AO) {


