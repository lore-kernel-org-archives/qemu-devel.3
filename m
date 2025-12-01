Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4731D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 10:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ0uB-0007YW-2o; Mon, 01 Dec 2025 05:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0tK-0006yN-1d
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 05:12:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vQ0tI-00041M-9V
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 05:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764583938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NSWjB5xJ+0R/gzP3NMr7iboo6um3B37gHfH7EWh0fok=;
 b=d0s6UZjpxOqDTGOTJ0gbDwZAE7McIQqxxp07a+5I/dQnarHUqpgSL/f/yxee2D/EWkgB66
 fBOCR4gBFeB57Ak+2SVKy1SLoKpwu4sfzbqkhlIC+POHMZU7JpV3AC6HpGWNYb3Nml5bw9
 UYwERtBWsX2YNhct2EYTvQ1kvjyvpUI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-BXZ24qR6P2el8jPTF6PLfA-1; Mon, 01 Dec 2025 05:12:17 -0500
X-MC-Unique: BXZ24qR6P2el8jPTF6PLfA-1
X-Mimecast-MFC-AGG-ID: BXZ24qR6P2el8jPTF6PLfA_1764583936
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2ad2a58cso1806784f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 02:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764583936; x=1765188736; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSWjB5xJ+0R/gzP3NMr7iboo6um3B37gHfH7EWh0fok=;
 b=oImDpdLZlGDCi488qQEN7c0/UDOpN7kWPOGPzczqfOhj7YnkuuGDB6kT0a0xK3xy/O
 NftCWcjv01uVn2Yol1MF+govWMcgDOWjZs8QiAOez4Mx/6unAAOunrKPBF/2ZpJ68NWT
 8tZ3lZUoiWW3d/mjYzbSmzex6SSZ59mXh8xhpBR63KKag9RCnx3BiNp+nLz8el5pKyVr
 CfYZro5EQQgfMlqehyd+bumr+a2uLmnaiZZ4l9muiQZfc8BZCpvizAJK0y78OjPb31Ei
 Op0Wy3blP1w4sMn+FN6BQHEpaRUKZwI4PEuTUBAvwMt1HhRvx4UoVusDAaCUPUKOabP2
 cauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764583936; x=1765188736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NSWjB5xJ+0R/gzP3NMr7iboo6um3B37gHfH7EWh0fok=;
 b=pmNPn59dXI1q/eb5psv2qiyo8sJzMFv/Qqn51ADxnDOnyufVlH8IoK4sPcgXFAhr+X
 Pc2Ci5BcMPUNy9vNMk/2uNvwDsi2mUn2Zaqegr6AR3lKCZ+AuY1Gr/kYpry1+ROfrVNz
 1r99qI6SmaEwL7VA6Nu2PJNm+a+ok1c/RxJvW+sqsck4ufsXrPQxbkTHUfr1+E43HnbO
 NNgE9gHwYL24XzBxNT0GxwWDAnt2ZWcpBhyruet/5y+45BR7RkCQgVrYjAViKZgVzSb4
 pmCzcN7WKsTLsaOY7aCR0dYnoKRMMenf6DobFX1XDgJ0uTLSAyP9+06EKCAEPv5b+kaP
 bqtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO2iY9OtZ2Y9/dbqxgowA2bo+jk5d1Z/uqnsuWFLjjiopOn4b4fxoNknvAOViudCR6ZMdTuPHW3nNP@nongnu.org
X-Gm-Message-State: AOJu0YzYzXTCpW33xucgHo1uw0NPiW/Pp7zLLyht+JYnj2CjVsHF+47d
 SvzOk8k/3Sv0mlpgRgzugCnR6sEacCVk+7hRaE4nxj6iLfPBrl7c7Lqq4z/L314rb6tR4AXVOzH
 Cu83tqDvxrbFP51ZQ5pJiY5Lp8mt45lZI3OmDlLCAKUWSyVh5xNQohccc
X-Gm-Gg: ASbGncv5ydWOBRqksnkEhanyYUQGdP6xksnxov7lMdu0TCIkZqCOMrRYzr20Vxl2gRZ
 dE24Cj1tP29Lt/556wtC1+WyTj6HwMxETB18yTlDbY5lWEMTBJ+n1C+azBYtK0GD6Qn0odUWi+n
 sFIN0Qvt/MYIxXMc5t4jQdF1RZ7xAh59KS0f0ntbvFPAiMvdDIBhCLZkBM9oOHM4Z9U2qLESWeT
 CRfeB0MfBhrkRUVBxwIKdKK1ScJnedGBIxDfe4Z4lqHrbBv4IEm7621aLO6HVyvMa0aSLXiSMDQ
 BIlZOZFZlPk6ltisgfER5TgzJ6Wauz6iUQ7sRrd958CWEjKSks0zyCiPd46AqhGO8eKWGQ==
X-Received: by 2002:a5d:5d85:0:b0:42b:3b55:8928 with SMTP id
 ffacd0b85a97d-42cc1accd19mr40223178f8f.20.1764583936283; 
 Mon, 01 Dec 2025 02:12:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjAs5/j9Nvi9MOfPHTwzHLNogR0Tnk0U4GQl6b3MkL4A3JGNeza2p5zT2QceWhtq6Ou9oFWw==
X-Received: by 2002:a5d:5d85:0:b0:42b:3b55:8928 with SMTP id
 ffacd0b85a97d-42cc1accd19mr40223132f8f.20.1764583935812; 
 Mon, 01 Dec 2025 02:12:15 -0800 (PST)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5c3022sm25823448f8f.4.2025.12.01.02.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 02:12:15 -0800 (PST)
Date: Mon, 1 Dec 2025 11:12:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, mchehab+huawei@kernel.org,
 jonathan.cameron@huawei.com, armbru@redhat.com, mst@redhat.com,
 anisinha@redhat.com, gengdongjiu1@gmail.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 5/5] acpi/ghes: Use error_fatal in
 acpi_ghes_memory_errors()
Message-ID: <20251201111214.1e432e82@imammedo>
In-Reply-To: <20251127004435.2098335-6-gshan@redhat.com>
References: <20251127004435.2098335-1-gshan@redhat.com>
 <20251127004435.2098335-6-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Nov 2025 10:44:35 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Use error_fatal in acpi_ghes_memory_errors() so that the caller needn't
> explicitly call exit(). The return value of acpi_ghes_memory_errors()
> and ghes_record_cper_errors() is changed to 'bool' indicating an error
> has been raised, to be compatible with what's documented in error.h.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes-stub.c    |  4 ++--
>  hw/acpi/ghes.c         | 26 ++++++++++----------------
>  include/hw/acpi/ghes.h |  6 +++---
>  target/arm/kvm.c       |  9 +++------
>  4 files changed, 18 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index b54f1b093c..5f9313cce9 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,8 +11,8 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t physical_address)
> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                             uint64_t physical_address, Error **errp)
>  {
>      g_assert_not_reached();
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index c35883dfa9..3033e93d65 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -515,14 +515,14 @@ static bool get_ghes_source_offsets(uint16_t source_id,
>  NotifierList acpi_generic_error_notifiers =
>      NOTIFIER_LIST_INITIALIZER(acpi_generic_error_notifiers);
>  
> -void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
> +bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
>  
>      if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
>          error_setg(errp, "GHES CPER record is too big: %zd", len);
> -        return;
> +        return false;
>      }
>  
>      if (!ags->use_hest_addr) {
> @@ -531,7 +531,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      } else if (!get_ghes_source_offsets(source_id,
>                      le64_to_cpu(ags->hest_addr_le),
>                      &cper_addr, &read_ack_register_addr, errp)) {
> -            return;
> +            return false;
>      }
>  
>      cpu_physical_memory_read(read_ack_register_addr,
> @@ -542,7 +542,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>          error_setg(errp,
>                     "OSPM does not acknowledge previous error,"
>                     " so can not record CPER for current error anymore");
> -        return;
> +        return false;
>      }
>  
>      read_ack_register = cpu_to_le64(0);
> @@ -557,16 +557,17 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      cpu_physical_memory_write(cper_addr, cper, len);
>  
>      notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
> +
> +    return true;
>  }
>  
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t physical_address)
> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                             uint64_t physical_address, Error **errp)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
>            UUID_LE(0xA5BC1114, 0x6F64, 0x4EDE, 0xB8, 0x63, 0x3E, 0x83, \
>                    0xED, 0x7C, 0x83, 0xB1);
> -    Error *errp = NULL;
>      int data_length;
>      g_autoptr(GArray) block = g_array_new(false, true /* clear */, 1);
>  
> @@ -583,15 +584,8 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>      /* Build the memory section CPER for above new generic error data entry */
>      acpi_ghes_build_append_mem_cper(block, physical_address);
>  
> -    /* Report the error */
> -    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
> -
> -    if (errp) {
> -        error_report_err(errp);
> -        return -1;
> -    }
> -
> -    return 0;
> +    return ghes_record_cper_errors(ags, block->data, block->len,
> +                                   source_id, errp);
>  }
>  
>  AcpiGhesState *acpi_ghes_get_state(void)
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index df2ecbf6e4..5b29aae4dd 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -98,9 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t error_physical_addr);
> -void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
> +bool acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                            uint64_t error_physical_addr, Error **errp);
> +bool ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
>  
>  /**
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index acda0b3fb4..76aa09810f 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2456,12 +2456,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> -                                             paddr)) {
> -                    kvm_inject_arm_sea(c);
> -                } else {
> -                    exit(1);
> -                }
> +                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> +                                        paddr, &error_fatal);
> +                kvm_inject_arm_sea(c);
>              }
>              return;
>          }


