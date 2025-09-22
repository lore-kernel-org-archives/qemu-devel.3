Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464B5CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0mc8-0006kS-4r; Mon, 22 Sep 2025 15:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0mc3-0006jb-LI
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 15:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0mbu-0007lf-AF
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 15:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758570841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0Yqg8gEbvJo/CoFFTxRv8DSp1CKYcYqQm7EktP6gkM=;
 b=VBrwV7hxuiOUGB+N3uqXTmfT3V/Gs7EU/mSDbRMmIFRRjl6H3ceJT2qbUVQyeCTEeJ4X7B
 Po6B83ZtG8FxURssa4bXs+0YbVvUYaQQGf1iRuutNChiKHl/CD7QfSl+TYntAEqIGSXm0U
 R5NL6GSW83MnCb46vSS5t5HirU41k80=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-H0a9cbYfOaKHTAst-E-YqA-1; Mon, 22 Sep 2025 15:54:00 -0400
X-MC-Unique: H0a9cbYfOaKHTAst-E-YqA-1
X-Mimecast-MFC-AGG-ID: H0a9cbYfOaKHTAst-E-YqA_1758570839
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f3787688b0so1394464f8f.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 12:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758570839; x=1759175639;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q0Yqg8gEbvJo/CoFFTxRv8DSp1CKYcYqQm7EktP6gkM=;
 b=e/oovKNt4kIAh+MYmeGq/32jC1bIjrw9HR1pB/1bWVPQCUoudpwEoLB7eA1zRvAPMF
 FFL1f1ozAub0InBdtEtOONaumlR4606vJu5MSeqDBDSJpXu23isRfpP6Vu0ZPGmS8Ymh
 1lyc+csxj98BQbKL8U7qMKNG0L3+WT9iEhd6Nd6qSkg+fTZwhRsNCnwpPm2n4D9m+08P
 aHdlIoHM04FXKqv8CxoiRsgzaMqDoCpG6L7lxxh16MGv2NCklw5snQt2W1qvEBfiw/Nc
 ejmpJaN3MFUN+mjwPhqyyxT+b4QvcIkEp4pxpDYF3fEg3XOWzFJkEPQopfZRlU5FvgGO
 4SLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUASKBddoG2nt84IZmnfEvPFbU0Y9ZBg5KsHeL+2Tb9MLxDJb6UPeCFw0a6U5aVXbc3Vb1jbIW/ok9a@nongnu.org
X-Gm-Message-State: AOJu0YyNJCrEjuIVxjZq3Q8CjJqKF5VCCL4TWseZexHPn2IGAtmpPXtH
 /gTpH+Bt1UiKzGvcmK9qQ1y4NateD+v21A2vCkHBPq2Ya5AqlCHPQS6awGUJ7PqKKrz3/n+XdQi
 JtzvSroJDF7mBUYGunO4Jfu/yXZeRnn8CP+8mzWFGQ+SuBWrcgJGLL51A
X-Gm-Gg: ASbGnctzui1r2QlZ6KSBypGzIyjMPryx6MzLCVuD4+0FngAGui5VZB+hWv+zVkuXHKy
 +J5VrGOHyd0LTIbfkMyzyD7T1hssNE8w/dw/3wzKecOtDO6kktg/lt6KXm8kagioYz8DA40X05D
 VW/XYZCJQAI5gyZPjQ7plUZ410rCdbmsyNPetDjZkCqZGzDUZ71XAXBSQP3VH1jSBYj+1bpP7bS
 hp/UrsNp7ivdIne0guG7io8od5mqG9iRfsswYlxz+sMRJ/EZh18UtkFoOsuP9JApUkNmPioSOik
 n3zuvuPV4zTbmNueNdE8QgkeBnG/oemhqAw=
X-Received: by 2002:a05:6000:144f:b0:3dc:ca9d:e3d7 with SMTP id
 ffacd0b85a97d-3ee7c92548amr10579649f8f.8.1758570838860; 
 Mon, 22 Sep 2025 12:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp8THkRNhPscjEqQIO4If5x2KjyP8dZD4dQVet5lrqUeRiHNoBL7mMlbSonlrCt+D9jHyOLw==
X-Received: by 2002:a05:6000:144f:b0:3dc:ca9d:e3d7 with SMTP id
 ffacd0b85a97d-3ee7c92548amr10579640f8f.8.1758570838450; 
 Mon, 22 Sep 2025 12:53:58 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-467fc818e00sm177847365e9.0.2025.09.22.12.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 12:53:57 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:53:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>
Subject: Re: [PATCH v11 07/17] acpi/ghes: add a notifier to notify when error
 data is ready
Message-ID: <20250922155111-mutt-send-email-mst@kernel.org>
References: <cover.1757084668.git.mchehab+huawei@kernel.org>
 <ef3f17b5ca97c6e2774bba346f830cce6e0c3dc1.1757084668.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3f17b5ca97c6e2774bba346f830cce6e0c3dc1.1757084668.git.mchehab+huawei@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Sep 05, 2025 at 05:09:14PM +0200, Mauro Carvalho Chehab wrote:
> Some error injection notify methods are async, like GPIO
> notify. Add a notifier to be used when the error record is
> ready to be sent to the guest OS.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c         | 5 ++++-
>  include/hw/acpi/ghes.h | 3 +++
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index f49d0d628fc4..0135ac844bcf 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -510,6 +510,9 @@ static void get_ghes_source_offsets(uint16_t source_id,
>      *read_ack_start_addr = le64_to_cpu(*read_ack_start_addr);
>  }
>  
> +NotifierList acpi_generic_error_notifiers =
> +    NOTIFIER_LIST_INITIALIZER(error_device_notifiers);
> +

I don't get where is "error_device_notifiers" defined.

I think it is not, and it works because the parameter is unused right now.

But it still should be:


NotifierList acpi_generic_error_notifiers =
    NOTIFIER_LIST_INITIALIZER(acpi_generic_error_notifiers);

Same as all other initializers.



>  void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> @@ -550,7 +553,7 @@ void ghes_record_cper_errors(AcpiGhesState *ags, const void *cper, size_t len,
>      /* Write the generic error data entry into guest memory */
>      cpu_physical_memory_write(cper_addr, cper, len);
>  
> -    return;
> +    notifier_list_notify(&acpi_generic_error_notifiers, NULL);
>  }
>  
>  int acpi_ghes_memory_errors(AcpiGhesState *ags, uint16_t source_id,
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 8c4b08433760..390943e46d99 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -24,6 +24,9 @@
>  
>  #include "hw/acpi/bios-linker-loader.h"
>  #include "qapi/error.h"
> +#include "qemu/notify.h"
> +
> +extern NotifierList acpi_generic_error_notifiers;
>  
>  /*
>   * Values for Hardware Error Notification Type field
> -- 
> 2.51.0


