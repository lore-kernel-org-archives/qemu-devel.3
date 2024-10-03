Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1E6CF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMnr-0004aJ-Mc; Thu, 03 Oct 2024 10:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1swMno-0004a0-5b
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1swMnm-0001PX-5r
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727965653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3pJZobA60sAFaK3pApVWkQmuKWb0cjI4YlaaOYgdqzI=;
 b=TYUl0MKyA6hix3Q7qj1JcYlBb23m53/h1K2FD3PhuKxyCiEwCawSW5CFFZSthYqLZuGe0a
 XTh5C2tP33xyq2zUFt4eHxP4TY0LTpb2mh/GJtItX9gppf9QtXbzO3DO6+o80/pTrJwikW
 uJGBD2ASfXLzBWNBuFUnhMFf0JwBJJg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-Nkm9f01mOvGSkihPyaahTA-1; Thu, 03 Oct 2024 10:27:31 -0400
X-MC-Unique: Nkm9f01mOvGSkihPyaahTA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb89fbb8bso5537615e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727965651; x=1728570451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3pJZobA60sAFaK3pApVWkQmuKWb0cjI4YlaaOYgdqzI=;
 b=hdqxVgOV8HrTr0g1Ka3AeQCzNEp4UDazyptZbR2USs3FFScMLjfTgXh5rD0kOADog3
 KpT+g2yJkKVIwcn+cdw0e+A4BoHPHzW26fdaQrfmANM8z+huut/GbNgsxD3IIaPsLzec
 Zpk8PB6TdI0ZFNocATZnfI/FQvbq1cM9H4v5qwzD5NlXa1k+e4hHUldquZcDuyKPM1KO
 QheCAixEUzWd8PmvP1tzqox78uRaJM2SWQLGc7rcSeICGZiR8iAQbICKl9mvDcy2DgKr
 l4JnJMBREs8QZAze7CohNAGNK32+2W1ioeSvoLbEpCJCz+qGYgoE7HzV/5zX5A62fOuj
 enmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/9Ycndxb/qW4bgF5hWRVxxNEtb0RuwRGNX9koQ0qtp1UVjCtuBff5AabplKY1TTI6Cihxx/syd0AE@nongnu.org
X-Gm-Message-State: AOJu0YyWnv+SAUYfi9YUK7Tqn3Fkf1cjfM6pEEMTcx4yJ8ivbSLicBpy
 JuGTkWqLAAK0odMoKffK7c/lJTW3ciptmdHA1bAfsYErHQYQKGHaSUgjrMO1oQwBwOT0kyrumeU
 R7AiNFkG/LX2aTinrgmZJ13JZJJhCg9+J8obUYd1VrY4hNCIr/Nuw
X-Received: by 2002:a05:600c:1c04:b0:426:6158:962d with SMTP id
 5b1f17b1804b1-42f778f17b5mr41060395e9.23.1727965650644; 
 Thu, 03 Oct 2024 07:27:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnde61JPLgejKdLJPeGP1RyJk7X3RYeBhIql5q+2I1+Eaui6EGqEsyK+CzUCX61mnghmU7Jw==
X-Received: by 2002:a05:600c:1c04:b0:426:6158:962d with SMTP id
 5b1f17b1804b1-42f778f17b5mr41060175e9.23.1727965650166; 
 Thu, 03 Oct 2024 07:27:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f802b2805sm16826775e9.44.2024.10.03.07.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:27:29 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:27:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 4/5] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20241003162728.1de6fc62@imammedo.users.ipa.redhat.com>
In-Reply-To: <176693e011a411db92be9e912bfc4a9da0e664b7.1727782588.git.mchehab+huawei@kernel.org>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
 <176693e011a411db92be9e912bfc4a9da0e664b7.1727782588.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue,  1 Oct 2024 13:42:49 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 9.2 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/generic_event_device.c | 1 +
>  hw/acpi/ghes.c                 | 2 +-
>  hw/core/machine.c              | 4 +++-
>  include/hw/acpi/ghes.h         | 1 +
>  4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 49ca1fb8e84a..c4677c9ae6b4 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -318,6 +318,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState, ghes_state.hest_lookup, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 313a6e453af6..86bad865168c 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -513,7 +513,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      }
>      ags = &acpi_ged_state->ghes_state;
>  
> -    if (!ags->hest_addr_le) {
> +    if (!ags->hest_lookup) {
>          get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
>                           &cper_addr, &read_ack_register_addr);

just fencing off lookup is not enough,
to be compatible with qemu-9.1 (virt-9.1) we also should not publish hest_addr fwcfg.

Also have assert (to be removed later) to make sure that we put only
1 (existing) error source in HEST.
When you switch to multiple sources, this will become a condition
to switch HEST generation between 9.1 and 9.2+ variants.


>      } else {
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index adaba17ebac1..b58afe48aa71 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,7 +34,9 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "audio/audio.h"
>  
> -GlobalProperty hw_compat_9_1[] = {};
> +GlobalProperty hw_compat_9_1[] = {
> +    {"x-has-hest-addr", "false"},
> +};
>  const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>  
>  GlobalProperty hw_compat_9_0[] = {
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index a07c30ef13b7..040d6ee366b2 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -61,6 +61,7 @@ typedef struct AcpiGhesState {
>      uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
> +    bool hest_lookup; /* True if HEST address is present */
>  } AcpiGhesState;
>  
>  /*


