Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630A2C35FFF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 12:04:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqWwQ-0000E3-PA; Tue, 17 Sep 2024 08:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqWwI-0008Qo-0x
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:04:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqWwD-0004uU-B8
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 08:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726574648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3mPRoAn/jcSQbMphwkl3dfQdA1X6c4zq+Qf8pQUnQ4=;
 b=hOtnZhO9xzTw1uMbLpr3QGMV3SdF+cTjlDyRDP0yCJFs+v9ij9+trlsjrtkFiY5QEJB0e7
 giOlBC2FtmFnIjFjPNdW6JvPl5JvuHUUiXUfmrrzg6ePyOS+CykNe1+C3e+h3RuNL+wMtU
 t0+9HiK+YqNREZans7XU6WcZwICX7XU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-zChdxit1MJiBvAA5Mcy_eQ-1; Tue, 17 Sep 2024 08:04:07 -0400
X-MC-Unique: zChdxit1MJiBvAA5Mcy_eQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-374c434b952so1479718f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 05:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726574646; x=1727179446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3mPRoAn/jcSQbMphwkl3dfQdA1X6c4zq+Qf8pQUnQ4=;
 b=kG+qCx4kCPF9mPVgxEfv4K0SMFE7TJaAe0TeDDf5iQ5zcGmSn969ouKGXVz4bXg7bM
 41VrbhoiJpyYXztyx3MxA2MeUe4qgCvNRKv5mFYxtgnpjiG3UIF/DDwroAg4+Uw9WhCP
 XTEUj+owPDHMH8dB6GLZGb/N2crXQ2SIDIRTmsX1/rm5fSg80xwwiovzMm48tWRQ7UBA
 Fw+iT5V//2NuIadDE5qdRMQwdCjeYeniZwRAVplRG56HgPi7vWQ2SN3WT98IX6OqKN64
 sY352aOjsnQTTAyNvF0S27GnGs5shOZ21JyOQRBS9teVeIujpeR8pfpQaj7NvjirVLWE
 U34g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1n0kAJnx5xC9OCANtUaJ7ug0MnbnNCBjtKMmGbM4Kkmi9IzmOlt4ms1m0C3gzjtoT6KuwRcGh1HDK@nongnu.org
X-Gm-Message-State: AOJu0YzICo5SkUY8Tivy6P1ujK8jLKDR35rtvRH1v8z6dFEb1ilewzuj
 sdKWB2fbHELH8Gan7I9ustjMX2tJ5aoDhkuRp5QjqAfn/nscyp15Z/2phoDaY/AomBXgPXKwZSl
 Q9giQZsFF5YQaSmeL8U6vFQbmxVNodbzEgANVyu/BK4BKGrQ9I/6H
X-Received: by 2002:a05:6000:1faf:b0:367:991d:8b76 with SMTP id
 ffacd0b85a97d-378d61e28b7mr10430323f8f.15.1726574646021; 
 Tue, 17 Sep 2024 05:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQjzt44DVLX1iIp0pGOcq8zBmTwnTihJV9Tfiak19XPUOl6reWHzGMTPFZdrHRqw2ufjXv2Q==
X-Received: by 2002:a05:6000:1faf:b0:367:991d:8b76 with SMTP id
 ffacd0b85a97d-378d61e28b7mr10430292f8f.15.1726574645510; 
 Tue, 17 Sep 2024 05:04:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22d7e2esm100741425e9.13.2024.09.17.05.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:04:04 -0700 (PDT)
Date: Tue, 17 Sep 2024 14:04:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 08/21] acpi/ghes: Change the type for source_id
Message-ID: <20240917140404.306fb514@imammedo.users.ipa.redhat.com>
In-Reply-To: <64de87ae9e03e9be6cb98dc75e2eb02503354904.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <64de87ae9e03e9be6cb98dc75e2eb02503354904.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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

On Sat, 14 Sep 2024 08:13:29 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> HEST source ID is actually a 16-bit value. Yet, make it a little
> bit more generic using just an integer type.

wouldn't uint16_t be better to use, to explicitly show expectations?


> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes-stub.c    | 2 +-
>  hw/acpi/ghes.c         | 2 +-
>  include/hw/acpi/ghes.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
> index c315de1802d6..58a04e935142 100644
> --- a/hw/acpi/ghes-stub.c
> +++ b/hw/acpi/ghes-stub.c
> @@ -11,7 +11,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/acpi/ghes.h"
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
>  {
>      return -1;
>  }
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 6e5f0e8cf0c9..4e34b16a6ca9 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -416,7 +416,7 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> -int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> +int acpi_ghes_record_errors(int source_id, uint64_t physical_address)
>  {
>      uint64_t hest_read_ack_start_addr, read_ack_start_addr;
>      uint64_t hest_addr, cper_addr, err_source_struct;
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 7485f54c28f2..6471934d7775 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -75,7 +75,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t source_id,
> +int acpi_ghes_record_errors(int source_id,
>                              uint64_t error_physical_addr);
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp);


