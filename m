Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F83FA3754
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6OO-0002YV-89; Fri, 13 Sep 2024 09:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp6OL-0002VE-He
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sp6OJ-0004oZ-Le
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726234265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvGBItUkDfqFh1oLJWbFeeOAiWJ5xgJuYz7EKc9ObyY=;
 b=c77EADZ16iy9tEDp7jsojuqjw5vbKIpnHs/uQ+XZfujSLPBj14mnOR8LdJynJmhgf7kcfH
 bKNtw1TfndhSYQq3rM2eOXN6Sp5cgSHzANi7sGVGuVVTj4QnEoOVUbIxqYo5hXrZdKbLmb
 WYtFX5R0XuDfct6rtQ2p8i4zp7o+Vhk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-uGyhbYbSPOCYiCOFlL-Aww-1; Fri, 13 Sep 2024 09:31:03 -0400
X-MC-Unique: uGyhbYbSPOCYiCOFlL-Aww-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-374c54e188dso1691134f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 06:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726234262; x=1726839062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GvGBItUkDfqFh1oLJWbFeeOAiWJ5xgJuYz7EKc9ObyY=;
 b=H4ahmxCTNxDlm3btcUDxip1gvmpG5TjHSGECOcErh0ncggDZO+yKXM24KUZaqpIDbq
 vHtlfQCCr56osDobeMk4EqS3liFrpXD04/dFLXYlPbfvlHZ8w+nGQqQL9vPelVeWIjD8
 4eT6lsuLb4JL2GLcBOKFziMdeMC7ZPsKh4ZavbdCHKn9ZuLH6eMO+yX8ZIZN825XclA9
 IdZKXKeNs2YPGPxw3le3UsVoxP+Z1TVaFdBgZzkz3upSzKWkOw8n0oqyfxPpI0IE8Yql
 P6OOqB9oqeq6RG3IkkhPMmDpbd/X6zVxfXTigDNFMcs+Tn/13pMvaJ1rTELcvoCciN58
 iUPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtOoUGPsWaqlPoDBLo+Yy8RUnUQW8j87GQlWtXsZlEP/HBCSaEqyJ4ZGalO4ZYoiPcDWnimmEdSgcz@nongnu.org
X-Gm-Message-State: AOJu0Yw0XkCo/Ps1o9RINKTOXJVBXco+yjcCVWhLPY/1eR3sTBFYH/kY
 oxT7BAuCh73ZTYenw2uSZtFS70CO9XTnBSx56bRvtqJfPnPQwEr6kFUqSKD+dRJ/AATrdwemYTI
 qMyAzuNU7bpsfN0ByzXVado3Ff2q+xSq7qVEyheT8+jzJ/3mqBpWI
X-Received: by 2002:adf:b342:0:b0:374:c79d:5f7e with SMTP id
 ffacd0b85a97d-378a8a9c10fmr8178226f8f.26.1726234262208; 
 Fri, 13 Sep 2024 06:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERXa2lMjmAwq4vQT2K5EePIHr0LVLSu9sZkY1lZNKoaVRfj2Z4+KZyop89HsTwxVpI7RpYpA==
X-Received: by 2002:adf:b342:0:b0:374:c79d:5f7e with SMTP id
 ffacd0b85a97d-378a8a9c10fmr8178193f8f.26.1726234261379; 
 Fri, 13 Sep 2024 06:31:01 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05c984sm26274465e9.11.2024.09.13.06.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 06:31:00 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:31:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 04/12] acpi/ghes: better name GHES memory error function
Message-ID: <20240913153100.275ce41c@imammedo.users.ipa.redhat.com>
In-Reply-To: <ceb8b8f3537cf9f125fbdc86659bae25fdb34e3b.1724556967.git.mchehab+huawei@kernel.org>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <ceb8b8f3537cf9f125fbdc86659bae25fdb34e3b.1724556967.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, 25 Aug 2024 05:45:59 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current function used to generate GHES data is specific for
> memory errors. Give a better name for it, as we now have a generic
> function as well.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 4 ++--
>  target/arm/kvm.c       | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index c315de1802d6..dd41b3fd91df 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(uint8_t source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 3190eb954de4..10ed9c0614ff 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -494,7 +494,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      cpu_physical_memory_write(cper_addr, cper, len);
>  }
>  
> -int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(int source_id, uint64_t physical_address)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 4b5af86ec077..be53b7c53c91 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -70,7 +70,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(int source_id,
> +int acpi_ghes_memory_errors(int source_id,
>                              uint64_t error_physical_addr);
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
> @@ -79,7 +79,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *
>   * Returns: true if the system has an ACPI GHES table and it is
> - * safe to call acpi_ghes_record_errors() to record a memory error.
> + * safe to call acpi_ghes_memory_errors() to record a memory error.
>   */
>  bool acpi_ghes_present(void);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 8c4c8263b85a..8e63e9a59a5e 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2373,7 +2373,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_record_errors(ARM_ACPI_HEST_SRC_ID_SEA,
> +                if (!acpi_ghes_memory_errors(ARM_ACPI_HEST_SRC_ID_SEA,
>                                               paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {


