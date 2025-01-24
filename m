Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6184C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbIl5-00005u-J0; Fri, 24 Jan 2025 07:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbIl2-00005F-QQ
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:25:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tbIl0-0001Yz-VG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737721553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnxustz4Ozr1581LgCiIqLuONz0VD0Xhn2cHUTkQB6k=;
 b=fIBzmHzdD36n1yPvBeL8eEhP09sritw+L94rgAlYugM6QdGiDgzTtGPbgG09MyW4mQQwbY
 OIjpFMslz+BKHBX6R2TkBhhyxM0Pu/zOlnJtvqT02gUBbroSPcy8jitLccNI60QeEOJaQY
 YV5SznVNGP8VS5WpzyceIheblQeTy/I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-7sjZEgL-Ne-zyM3HyTxYew-1; Fri, 24 Jan 2025 07:25:50 -0500
X-MC-Unique: 7sjZEgL-Ne-zyM3HyTxYew-1
X-Mimecast-MFC-AGG-ID: 7sjZEgL-Ne-zyM3HyTxYew
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38a684a0971so1014908f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 04:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737721549; x=1738326349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vnxustz4Ozr1581LgCiIqLuONz0VD0Xhn2cHUTkQB6k=;
 b=HnF3D6rDys9uQ/eiZDc7y7zcGZRqIWzG/DsYeP0wUjh/r4/LXMSe2qu0e9J2uYP6Bs
 vn3H0jb9JN6voiFxAA+AZu3/YBegcDNG0u/FRcGinxymXXWq4CdkhFblg/cBpOUbvnr9
 747epSIb6EHhsUowEV+ebIq58WYYdq8XSX7wEw0/k0F9vmoEVMXXRaKI1Bea15L5MYse
 UtSXVUcKlS9QLgAUIYJCELjIzKkzmdAOK/x3XGKG777TX3chL+fvXKxomVQo1vzGboIw
 OIN9xLGb86kPdTWnF1eo+KvuRbip8isTzeRgxY7lDktjSWeT6NJ3U5lwJCNfAptlyvZ1
 WC4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpKN/mjiepy7wNf41nbIrcwaAvAdhngU4NOsmne+p8iysfUv9NIHGYKWQaBQbXPGZAfsdKlf4iCHIW@nongnu.org
X-Gm-Message-State: AOJu0YwHz64DZlhd9n4sWvhsUWE203SAcPzndWxzBTTpRK2+z1NOwBi7
 yGh6lYRaSHLuSMGTgmHAwdP09TZUd343dEVpNolA8iOAf4wiQXmC6+st5xpPp7Q85EQq68Rx+rV
 KyM1FIkyGrJduDBqUa6Ox+RCRSr4gNyuy2vQiNDk5zi/cw37/2s65
X-Gm-Gg: ASbGncvNMpAww9VMzo5U7QNwfRg0sRxge8SIX+X8RGD0uSpGgWp/jC6rn7ZPaYg4Do1
 cv6Ws6GZP9y94eMNC8KF2tMB4XLO2u9CgoiBJaWb/vj4kusr0zWSDb8besR3VraUuM6/RZ8aPHr
 d3t0z2HmG0L+jUWYjD8pXbkiB8CNYFmNe/hVdiYUg3FWp4Yj5DP0IhWx0o5J38gAbHJ6MVAYbia
 OIlHaeqjvV4l/WurHToiav3KIDYnadSMGgRBjYmVN/GadJADEhhfxjbwmgg7OsXx4FD8yIASRUw
 Gt8op5IgTlXsEFJjXX9iZapjuzd4grKCyR9MLStr6w==
X-Received: by 2002:a5d:59a8:0:b0:385:fa26:f0d8 with SMTP id
 ffacd0b85a97d-38bf5655a0amr26933470f8f.8.1737721548974; 
 Fri, 24 Jan 2025 04:25:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEleHjBU1+JpAle5FPfNcGEhVnYCT++PmivrmNNIqSuFMQtW8TMMrtNdpuy5xp0Gzpzpftjpg==
X-Received: by 2002:a5d:59a8:0:b0:385:fa26:f0d8 with SMTP id
 ffacd0b85a97d-38bf5655a0amr26933442f8f.8.1737721548584; 
 Fri, 24 Jan 2025 04:25:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1bb0d4sm2603769f8f.69.2025.01.24.04.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 04:25:47 -0800 (PST)
Date: Fri, 24 Jan 2025 13:25:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] acpi/ghes: Cleanup the code which gets ghes ged
 state
Message-ID: <20250124132546.4ff1d643@imammedo.users.ipa.redhat.com>
In-Reply-To: <200501cb372d5121c44128a79b8775e529dc46e6.1737560101.git.mchehab+huawei@kernel.org>
References: <cover.1737560101.git.mchehab+huawei@kernel.org>
 <200501cb372d5121c44128a79b8775e529dc46e6.1737560101.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 22 Jan 2025 16:46:24 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Move the check logic into a common function and simplify the
> code which checks if GHES is enabled and was properly setup.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes-stub.c    |  4 ++--
>  hw/acpi/ghes.c         | 33 +++++++++++----------------------
>  include/hw/acpi/ghes.h |  9 +++++----
>  target/arm/kvm.c       |  2 +-
>  4 files changed, 19 insertions(+), 29 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index 7cec1812dad9..fbabf955155a 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -16,7 +16,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
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
> index 961fc38ea8f5..5d29db3918dd 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -420,10 +420,6 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
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
> @@ -451,10 +447,6 @@ static void get_ghes_source_offsets(uint16_t source_id, uint64_t hest_addr,
>      uint64_t err_source_struct, error_block_addr;
>      uint32_t num_sources, i;
>  
> -    if (!hest_addr) {
> -        return;
> -    }
> -
>      cpu_physical_memory_read(hest_addr, &num_sources, sizeof(num_sources));
>      num_sources = le32_to_cpu(num_sources);
>  
> @@ -513,7 +505,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
> -    AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
>      if (len > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
> @@ -521,13 +512,10 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>          return;
>      }
>  
> -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> -                                                       NULL));
> -    if (!acpi_ged_state) {
> -        error_setg(errp, "Can't find ACPI_GED object");
> +    ags = acpi_ghes_get_state();

1)

> +    if (!ags) {
>          return;
>      }
> -    ags = &acpi_ged_state->ghes_state;
>  
>      if (!ags->hest_lookup) {
>          get_hw_error_offsets(le64_to_cpu(ags->hw_error_le),
> @@ -537,11 +525,6 @@ void ghes_record_cper_errors(const void *cper, size_t len,
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
> @@ -605,7 +588,7 @@ int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_address)
>      return 0;
>  }
>  
> -bool acpi_ghes_present(void)
> +AcpiGhesState *acpi_ghes_get_state(void)
>  {
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
> @@ -614,8 +597,14 @@ bool acpi_ghes_present(void)
>                                                         NULL));
>  
>      if (!acpi_ged_state) {
> -        return false;
> +        return NULL;
>      }
>      ags = &acpi_ged_state->ghes_state;
> -    return ags->present;

> +    if (!ags->present) {
> +        return NULL;
> +    }

redundant check,  check below vvvv should be sufficient

> +    if (!ags->hw_error_le && !ags->hest_addr_le) {
> +        return NULL;
> +    }
> +    return ags;
>  }
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 2e8405edfe27..64fe2b5bea65 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -91,10 +91,11 @@ void ghes_record_cper_errors(const void *cper, size_t len,
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
> + * a memory error. Returns false, otherwise.
>   */
> -bool acpi_ghes_present(void);
> +AcpiGhesState *acpi_ghes_get_state(void);
>  #endif
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index da30bdbb2349..0283089713b9 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2369,7 +2369,7 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>  
>      assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
>  
> -    if (acpi_ghes_present() && addr) {
> +    if (acpi_ghes_get_state() && addr) {

double lookup, 1sh here and then in [1],
suggest store state here and pass it as an argument to down the call chain
(i.e. to acpi_ghes_memory_errors() and below)

>          ram_addr = qemu_ram_addr_from_host(addr);
>          if (ram_addr != RAM_ADDR_INVALID &&
>              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {


