Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57F1E6916D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 15:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEVnI-00049M-B3; Fri, 22 Nov 2024 10:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEVnB-00047Q-07
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 10:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tEVn9-0003g1-1b
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 10:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732290113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+yaHaIkSyy8GR8NSGw9v4GihzAiPvpRQjvYO902Fu4=;
 b=BnAVdp7G0m0+R+w/RxHrRWKRV15DV0eMNa7pdSupIkD8jP1+FaTp9g1W0frPcNZxy+iQ/m
 81FXukQaV3GIQ1TcRvkn6QVIqI3osexgxQeFKEGjo+WUEsmPjTfOT2t34bb4JoMTobITsw
 Flj3hQ7w6VDWwAlRW/KY3cOGy0/Emec=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-RBT33PWpOBq6EUz1Jdwb_g-1; Fri, 22 Nov 2024 10:41:51 -0500
X-MC-Unique: RBT33PWpOBq6EUz1Jdwb_g-1
X-Mimecast-MFC-AGG-ID: RBT33PWpOBq6EUz1Jdwb_g
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3822ec50b64so1179444f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 07:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732290111; x=1732894911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+yaHaIkSyy8GR8NSGw9v4GihzAiPvpRQjvYO902Fu4=;
 b=phgCYGd+pY2ZXOviqA5u5PO+olEv9rai76kJFitnXhTBuJAGNH8Dk8+WPQF4ggLJcM
 f7MVgmEXFloSJSQVRdOY3Ny+JtOQGaUKrXjkTKueQ9GM4EBjRQuZSGjBtnKYfcci2t8s
 NuuFAjgjRqK5iuEY1dy/m+kFwjGlM5LFd/ZjBGmHfwWVmKV8tqTmt3LzSGuA06G6BaFl
 Q3QbSrbSHulrAK06C63tDFXbXXDIuEE1nEFuulhEheR3uWnFEka02gyIneHub39fhnwR
 wLXTcflWfWzXeJoxQ566zXEUze4G32ZVS9BZP6LA17O3cSaH6ut1SqqSizwOfuCIFJLW
 C1fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNjilZx48E/epeZPRIKbcCd8Jm6e+/Ii8yXlVzZNji57z4eHZcZVrt/ZREECyfddkbFHgKXa0PBGoA@nongnu.org
X-Gm-Message-State: AOJu0YyQA2u1vQz6NghCTcWiu/LEku8GMAW5/v/dgsaXB0w7MnUalFJ1
 LBzpx1r9QklU3JUR2uR4kfnUusD7pZraTqBCZM+x0JCPfpZqzcL1ScakZ6lhgR5bfyZH4xjfRsh
 zLWpfyPBFWoQ9lubdfssQk/MNMxoXQIOJuAXo8KdWX9xQIxqJ6LBU
X-Gm-Gg: ASbGncsowt09MG+uGgob+VMPe8W663HE/8b0tdXQ+YdQQStdSCzOgnAzg+cXgQHnNkZ
 4/ZAokJlVX/bLAnhCKtqTQx1EQekjgghgt6mRNqN7LZ92JnjRLgb4n7/+p/aqtBy71jdGSHm7+q
 Y/X7zIvvNUKEzTMYcMKZJTPokR5wolPuSl4zvOhZRBi/DF/kdPQX2FcQcWxuwB618Wb008Sb8Ji
 WVPf9HB7uyyzGmVCKKZ/vy/MW9H1smNctHpcqfkAK8I0j6LNARmZ37uNN2jj3t6kz3GLRZZ7cff
 9M7SDpat+E757RTsRA/vyw==
X-Received: by 2002:a05:6000:1446:b0:382:512b:baff with SMTP id
 ffacd0b85a97d-38260bfaedamr3291400f8f.59.1732290110703; 
 Fri, 22 Nov 2024 07:41:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZIAv9MqkDQh4Mlw1DlID8h5lyTKTFj7KDo0Gz8w4AVp3Lc4Otp3hDXSOF+GaOumjzW9S5LA==
X-Received: by 2002:a05:6000:1446:b0:382:512b:baff with SMTP id
 ffacd0b85a97d-38260bfaedamr3291367f8f.59.1732290110322; 
 Fri, 22 Nov 2024 07:41:50 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm2680201f8f.109.2024.11.22.07.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 07:41:49 -0800 (PST)
Date: Fri, 22 Nov 2024 16:41:48 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 07/15] acpi/ghes: Change the type for source_id
Message-ID: <20241122164148.60dc5290@imammedo.users.ipa.redhat.com>
In-Reply-To: <84475e30b69680d93697ec666214482e36cd8844.1732266152.git.mchehab+huawei@kernel.org>
References: <cover.1732266152.git.mchehab+huawei@kernel.org>
 <84475e30b69680d93697ec666214482e36cd8844.1732266152.git.mchehab+huawei@kernel.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Fri, 22 Nov 2024 10:11:24 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> As described at: ACPI 6.5 spec at:
> 	18.3.2. ACPI Error Source
> 
> In particular at GHES/GHESv2 table:
> 	Table 18.10 Generic Hardware Error Source Structure
> 
> HEST source ID is actually a 16-bit value.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index c315de1802d6..2b64cbd2819a 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 5f67322bf0f2..edc74c38bf8a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -383,7 +383,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
>  {
>      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
>      uint64_t start_addr;
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 50e3a25ea384..9295e46be25e 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(uint16_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present


