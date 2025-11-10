Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80241CD13D2
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vITGm-000688-GN; Mon, 10 Nov 2025 09:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vITGj-0005zb-Kx
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:53:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vITGd-0000Pp-Px
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 09:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762786394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mfVMdJfyaaPsUPMviEliedK60j/rWdz+0nevChecdnc=;
 b=QVv7EfIw94fq98uKrLmaFaotu5iG5dolZETSs7iD7GODsT0kcpx3Pv6Am+yU07ZtdnCAXV
 COmIojml5IPSKOdUL0SYX8wY6uR52NdXyrb54f+d4AkKZrRZz9ILxmCBApkvkzEjYE+XZW
 d7xHadFXDzfaaNAmJ4s0BO//04beawI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-m243Eg4jN9mXPiPjezQnuA-1; Mon, 10 Nov 2025 09:53:10 -0500
X-MC-Unique: m243Eg4jN9mXPiPjezQnuA-1
X-Mimecast-MFC-AGG-ID: m243Eg4jN9mXPiPjezQnuA_1762786389
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-429cce847c4so1305480f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 06:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762786389; x=1763391189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfVMdJfyaaPsUPMviEliedK60j/rWdz+0nevChecdnc=;
 b=FP384B54+A80IBJ75AfJU0p7N2Jc4GIauhwisCkWpBBGIY66N2bV4+czdrtc4YB0L4
 b0Y+bmYkfO/OxvKiJzwicyF7ntaAOFEmRvd4DTUhpRdQmfuFgQQQ8ybYVOmIWD2AUnTD
 t09H8vg9awqZFsRm8nrT9Q8P875Sxe9L8QRE701W7YtKGMbwm57ips0RnrwV6IPBtnG7
 GBG9BAaUS4i+3AmL2Me9hzzrRpucSC4zCrrsm99Z9YBAzAeBVfXBmzkIWfiE1Aqv6XB7
 F6natgfA/EUl2B4Q3BjtSAF4QfltfauO9NZze+uiuB75vgMOK/mgphJrZX7cP/x9jaTL
 PoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762786389; x=1763391189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mfVMdJfyaaPsUPMviEliedK60j/rWdz+0nevChecdnc=;
 b=otQ9UC6Kjov8kBNEMYfeyn919PskQonTg0WXhrIT3cQB1XfP6n7Q7TFHXAGBi64Xjq
 7CImWstsd4+z1v/EyE0GC8wNfyhbVUUZ9v17vVx/QJ42wRXXlDeZC/44n/wn8G0HmbXQ
 F7DZBX8bQaGPr6ezXBG6lqDy1TWV/gdv6swEKLRTcZp76/iiwIMh2KiDF2p5ZdKLgA2M
 yeZ7IjwTd1KqAu9zRKSdB+X5NiRcea0xJxhK2Rdq2KduRBr+pel863ikdEJwSucZ/8vy
 3LTIg88xCxxQihdkB/astIqoGK1jm5KtR/sPZatftBtpo/ygpwZChAxAQkJs5OFVczw6
 nrpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXEhq8yVKuF8dXIz/PebhOHvE5FhLZFsxWaPgGWduDbJca1/C4mM1yvoyYVn6QBnvCzbXPlkdLbcgL@nongnu.org
X-Gm-Message-State: AOJu0Ywg1DzLWIj15qeJWvFmtetoWed0caSbLKJzCz7LU0JkV4Nl8Z54
 jnJwCapfjIb8ALBhRb+AxjJxlIsV1bhas+WMK3DO5bquahqYwyZ0VPEVFJwVmnwu85s/mvLxLO8
 V/FpWp9HZQN7jKJS/6nkXODsMZ9dKLMMg/QdemN/IoMFI9e2AjL/AdjgI
X-Gm-Gg: ASbGncs3GQOKpGko8WsqfXYXeI7/ZlVJA6Z4XsXg4XkVAeyRblChKFaWVhRxZlWGZLw
 QtJ43YFIN1x0gYjfqc4a3PTzGA2/5hOW+cMmj/Z5Skrc7EAe1cCTxFRvpmEq5MJxAz56ZBRlbjW
 iAmDPCepo4kJuvjw8xneLk/UvfjYWbl1VgFeN/hjwqX4hxwY4g6gQS7HFIagnbYPWKOVPXTIogl
 MB75FuV5Ln3aOGOPG8n9nFtcvciYux4RZoha4QdiJ5/ubi8/Hpz8M6DMUXKIpqYesqSGExDsaDs
 aF+ejKM4uOIyGsXNO6+M1iNsNn3stWAZclPE11sFcmR9xF0K0itrRQqhrrTq9ukOMQ==
X-Received: by 2002:a05:6000:22c5:b0:42b:3806:2bb4 with SMTP id
 ffacd0b85a97d-42b38062ee3mr4659077f8f.27.1762786389447; 
 Mon, 10 Nov 2025 06:53:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6IUThXKt0KKjHqEVdE+mYwAOPIdOCgZ1CY1+kF0yMKjCk3InWytT1vqqnXexM0MQpe3Ftyg==
X-Received: by 2002:a05:6000:22c5:b0:42b:3806:2bb4 with SMTP id
 ffacd0b85a97d-42b38062ee3mr4659041f8f.27.1762786388960; 
 Mon, 10 Nov 2025 06:53:08 -0800 (PST)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42ac67920fcsm22466090f8f.39.2025.11.10.06.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 06:53:08 -0800 (PST)
Date: Mon, 10 Nov 2025 15:53:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v3 6/8] acpi/ghes: Use error_abort in
 acpi_ghes_memory_errors()
Message-ID: <20251110155307.372dafb0@fedora>
In-Reply-To: <20251105114453.2164073-7-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
 <20251105114453.2164073-7-gshan@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed,  5 Nov 2025 21:44:51 +1000
Gavin Shan <gshan@redhat.com> wrote:

> Use error_abort in acpi_ghes_memory_errors() so that the caller needn't
> explicitly call abort() on errors. With this change, its return value
> isn't needed any more.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes-stub.c    |  6 +++---
>  hw/acpi/ghes.c         | 15 ++++-----------
>  include/hw/acpi/ghes.h |  5 +++--
>  target/arm/kvm.c       | 10 +++-------
>  4 files changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 4faf573aeb..4ef914ffc5 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,10 +11,10 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t *addresses, uint32_t num_of_addresses)
> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                             uint64_t *addresses, uint32_t num_of_addresses,
> +                             Error **errp)
>  {
> -    return -1;
>  }
>  
>  AcpiGhesState *acpi_ghes_get_state(void)
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 055e5d719a..aa469c03f2 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -543,8 +543,9 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      notifier_list_notify(&acpi_generic_error_notifiers, &source_id);
>  }
>  
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t *addresses, uint32_t num_of_addresses)
> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                             uint64_t *addresses, uint32_t num_of_addresses,
> +                             Error **errp)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> @@ -555,7 +556,6 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>       * Table 17-13 Generic Error Data Entry
>       */
>      QemuUUID fru_id = {};
> -    Error *errp = NULL;
>      int data_length;
>      GArray *block;
>      uint32_t block_status, i;
> @@ -592,16 +592,9 @@ int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
>      }
>  
>      /* Report the error */
> -    ghes_record_cper_errors(ags, block->data, block->len, source_id, &errp);
> +    ghes_record_cper_errors(ags, block->data, block->len, source_id, errp);
>  
>      g_array_free(block, true);
> -
> -    if (errp) {
> -        error_report_err(errp);
> -        return -1;
> -    }
> -
> -    return 0;
>  }
>  
>  AcpiGhesState *acpi_ghes_get_state(void)
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index f73908985d..35c7bbbb01 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -98,8 +98,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> -                            uint64_t *addresses, uint32_t num_of_addresses);
> +void acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> +                             uint64_t *addresses, uint32_t num_of_addresses,
> +                             Error **errp);
>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
>  
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 459ca4a9b0..a889315606 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2458,13 +2458,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>              addresses[0] = paddr;
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> -                                             addresses, 1)) {
> -                    kvm_inject_arm_sea(c);
> -                } else {
> -                    error_report("failed to record the error");
> -                    abort();
> -                }
> +                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
> +                                        addresses, 1, &error_abort);
> +                kvm_inject_arm_sea(c);
>              }
>              return;
>          }


