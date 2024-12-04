Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F8E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 16:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIsQU-0003t4-VY; Wed, 04 Dec 2024 11:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIsQT-0003sr-H9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tIsQS-0003cr-4l
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 11:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733330431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEeC3RYjo0ryc9cx1hBsYweGmp9PRkMA7aFXlYOXkWM=;
 b=g/4ei6LAxOxDNQ0NmaczWCKIGLJMBnse8aUvPi2L6oRkGPPE9EnUohVaIs+k0dRpeLTuvg
 UO3xAqZ92VfPbLf2tutBdIL6rFtBS+1dn79BGg2+I8PatnxB3/O2rAnnUcA0G32kSuNLAn
 GXsSJso1X1J6xbfUqAw36xxL0X1Q7Fk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-mfwYroNsPcWFPKvk5U4Qeg-1; Wed, 04 Dec 2024 11:40:28 -0500
X-MC-Unique: mfwYroNsPcWFPKvk5U4Qeg-1
X-Mimecast-MFC-AGG-ID: mfwYroNsPcWFPKvk5U4Qeg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4349e08ae91so32985e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 08:40:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733330427; x=1733935227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEeC3RYjo0ryc9cx1hBsYweGmp9PRkMA7aFXlYOXkWM=;
 b=boni7+sRfnVR2Ic065BSRApiJI+GhV++GpRU68EVbVZ8vYAOTrrO1FRpGtfqwTmcih
 Hg0IEgd5DPUZnE9+2vEq538k1gm8AQPnG01oQfbw9fG8ksAI4HWS8QlA7c7nbh/0a6ct
 9nM1g6Nby99qibZM7/TFLDnwolKVltEJc34jiM4jARBZZV3lFYZm32Ed2CWUfLlw13jv
 mvUdT6Q6x15rbSEdbBNj52HrmyiSLVmPh1dNn53NzkbBRPh0eOgNmuqtO3WINlrrglqU
 PQVxE0TAWS7KWF/DaPxp/oVDDL+YUCOUQfveA7QmNhzEjHn4HYIpTAJNTqXNaBPStnoY
 VkSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh1S/sUvslqmipSnE9ZZydsH5dl2j/eCJ/FBW4dLZmBgog0bf44kKkweNsNhOoMLQZ08K8Ekky6jvi@nongnu.org
X-Gm-Message-State: AOJu0YxorfF/v9rqYQgEnwT8Qtuc9yBIkkgHGRHew4NDiXUjpfZFmbHr
 pGcpWKu/eZ67IyGDjqCHHu4HXmyQrw+BpuDZ7bIp8OXOKClQrIJhxoCmmaXtIM2gJdunNCG5e+0
 /g9+mcH8eQC9adCUiWMh0Y/z+KLaEcGYHFHx8jmBlvjsMPLsI6WtP
X-Gm-Gg: ASbGncvMjDdKJ5dW1b8yN6BR6UP2+8uwqElO5+rZre0qwAjAWXBCPjl+tCyk0JdtSRx
 8vZDPNohIs6H0zskZayCNTOyhWLQbabxM9MbWdjQuJo5OxAC2kg9q8SraS7V1A5WmPccDiA9EA2
 YWR6zz8zeoWiB9m2JBGfifzYFIcp/K9UiwGEePoQ69r3Ex4dP778o6oeWDrV5FW4Mt/VgPubW9C
 yXQhXFDYiS/9seuCFZQ/qhYX9FIlpHRYEf/Wttt3EBbU4aBdq3uIM2aq7U8GU3zYQ/CR+UtFeTW
 gk6vc+/dotLnA9LfXsi3bw==
X-Received: by 2002:a05:600c:35cf:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-434d0a07e76mr56634695e9.20.1733330426903; 
 Wed, 04 Dec 2024 08:40:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlmQvivINODRz0LjSbG3GHEmn9Krx7Hqgr3pzwsWlsNg+E/WUPCGldC0NDYZMcYKm+/x0RRg==
X-Received: by 2002:a05:600c:35cf:b0:431:52b7:a499 with SMTP id
 5b1f17b1804b1-434d0a07e76mr56634495e9.20.1733330426521; 
 Wed, 04 Dec 2024 08:40:26 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52cbd42sm29861995e9.38.2024.12.04.08.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 08:40:26 -0800 (PST)
Date: Wed, 4 Dec 2024 17:40:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 10/16] acpi/ghes: better name GHES memory error function
Message-ID: <20241204174025.52e3756a@imammedo.users.ipa.redhat.com>
In-Reply-To: <1f16080ef9848dacb207ffdbb2716b1c928d8fad.1733297707.git.mchehab+huawei@kernel.org>
References: <cover.1733297707.git.mchehab+huawei@kernel.org>
 <1f16080ef9848dacb207ffdbb2716b1c928d8fad.1733297707.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Wed,  4 Dec 2024 08:41:18 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The current function used to generate GHES data is specific for
> memory errors. Give a better name for it, as we now have a generic
> function as well.
> 
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

not that it matters but for FYI
Sign off of author goes 1st and then after it other tags
that were added later

> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 4 ++--
>  target/arm/kvm.c       | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 2b64cbd2819a..7cec1812dad9 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4b5332f8c667..414a4a1ee00e 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -415,7 +415,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      return;
>  }
>  
> -int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      /* Memory Error Section Type */
>      const uint8_t guid[] =
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 8859346af51a..21666a4bcc8b 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -74,15 +74,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> +int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_addr);
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);
> -int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
>   *
>   * Returns: true if the system has an ACPI GHES table and it is
> - * safe to call acpi_ghes_record_errors() to record a memory error.
> + * safe to call acpi_ghes_memory_errors() to record a memory error.
>   */
>  bool acpi_ghes_present(void);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 7b6812c0de2e..b4260467f8b9 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2387,7 +2387,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>               */
>              if (code == BUS_MCEERR_AR) {
>                  kvm_cpu_synchronize_state(c);
> -                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
> +                if (!acpi_ghes_memory_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
>                      kvm_inject_arm_sea(c);
>                  } else {
>                      error_report("failed to record the error");


