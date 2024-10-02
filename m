Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7743DCF31B7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svySe-0007kP-EC; Wed, 02 Oct 2024 08:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svySZ-0007k2-Ll
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:28:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svySW-0008JL-O2
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 08:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727872078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zy/ZYXezD/7SwVnrR76iPCG2vx+uv4epmVmeCMiNdC0=;
 b=EvjrdBnSh7x6Wzc/RP6jE8rJ7Fe+SUnQL9tXzd9T7uAH8E22sCvO0QlvTlv0uGCVxUot7l
 Xu0FbDiYRW+mWbgj0z/ERP3AHyTGFp3yhgXp+bHhB9/JnCEtmrUjz7lBugcp0eaFd+2GxG
 BQZfbsz0i31kmwObN69NdGcXvTLSzJE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Xqt0OEx8NOWl4wCZoJ4EwA-1; Wed, 02 Oct 2024 08:27:57 -0400
X-MC-Unique: Xqt0OEx8NOWl4wCZoJ4EwA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cd08d3678so363567f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 05:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727872076; x=1728476876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zy/ZYXezD/7SwVnrR76iPCG2vx+uv4epmVmeCMiNdC0=;
 b=BfoixEI0w5iKIORBUQLLlF9KzU+CZb7BCXW1fmTUi/geO0DPOt2in5Yj0HZHdUGo4g
 ex6ZZilfgtkwWnV4j6qj4gbx/5uNf3C55PwXnlizpk0CcsVgZFbeNjZDXoYjHFSymfqG
 +0l8fteaskq+NFycxhztdpGQrmNrRC0qhdrxVAJQb35PVbsBJ0Hi8v2y5RfJLM/inhnv
 +0Ii/zxDESvbJMeEJ1HQzpO/ZbMhlYilUa8jzEUbqZdV2OAzh+Lr7BetuvTql04m4DlU
 vuKlKwIB9eV+IltYZ/CRK/pQUNy3S0VA0Nq9GyhoRdlV0Ig8TgdJbAPqRaj1NxKgUHJj
 HNcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUssU0TC6K9fP6sm081rmtvyspRPC4mY1UszoECgk68CAvb7ViSZba85HOX4lLB5UCLRJDtSd6z/K09@nongnu.org
X-Gm-Message-State: AOJu0YybMPNbgLpGoseGxRGKsp/DNABfwUaoXPmvSUOI+ugD82CcFM0q
 TbP2viTATwbYoSW41gaBGkFR6C5V7N/zYE0IBeHjgrpHdNGqlJXI2QW76hDnHEtEvgu74rR4H+Z
 qC9RcQgFGYhlDKMonkImKkQ1JRACfHv/RLuQ+ev7tiTY0VnyG1/Pc
X-Received: by 2002:a5d:6049:0:b0:374:cd3c:db6d with SMTP id
 ffacd0b85a97d-37cf289c5damr4197397f8f.6.1727872076197; 
 Wed, 02 Oct 2024 05:27:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFTM7gXF/Sks/nw+9yQa8k1GxSL0J2xOO4baZqrcOegpPf0mXvZ4khqwx1fsxeobYetsQxOQ==
X-Received: by 2002:a5d:6049:0:b0:374:cd3c:db6d with SMTP id
 ffacd0b85a97d-37cf289c5damr4197374f8f.6.1727872075824; 
 Wed, 02 Oct 2024 05:27:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a02ef4bsm17283085e9.47.2024.10.02.05.27.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 05:27:55 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:27:54 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 07/15] acpi/ghes: Change the type for source_id
Message-ID: <20241002142754.086a2cd8@imammedo.users.ipa.redhat.com>
In-Reply-To: <4149830f15bcad19f6e32981754d437493f3aeba.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
 <4149830f15bcad19f6e32981754d437493f3aeba.1727766088.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue,  1 Oct 2024 09:03:44 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> HEST source ID is actually a 16-bit value

add here spec/ver/chapter/table reference as a confirmation
of above statement.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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



