Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406FECF6D21
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzIW-00046a-TD; Wed, 02 Oct 2024 09:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzIO-00044j-Is
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:21:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzIM-0007SZ-JB
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727875291;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fi2yz8P5s1N+bIPUltlWoEdasaEDLb+ur9FDivcVwJc=;
 b=MEk9P8aUVYrEmC3ch5cSe62BDIFP2Z5AuqREpTpN2t6PjQs4tGOYmlYVtCNtW6uJh3ASnZ
 nnA866P4fgVKB48tG4jSit7Tg+tU1sSHhQJ5m6DJ8NNYh394K1E/LcJrCqcGWs9BNqDN/7
 PoackqheFQtV8ksVxxgRUeBLDXgIWXI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-4F81eUgNMn6RcfwWKeIDPg-1; Wed, 02 Oct 2024 09:21:29 -0400
X-MC-Unique: 4F81eUgNMn6RcfwWKeIDPg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42ac185e26cso52460425e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727875288; x=1728480088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fi2yz8P5s1N+bIPUltlWoEdasaEDLb+ur9FDivcVwJc=;
 b=kMYbHvbjmqRZn1tr23kyg81nnhemQOmr86Y8Pv0efZ3f0jPfej1gNCMZmnrBh1JUPv
 J8fU0r1xZQP8NdLHMCTkO54b2/NOoq7mPI0jquEZKjyPC5ACJ9K84B/oCRZ+ByD/eEzT
 kPc4yKD0JsdPsm2A6UZY6tfGbFBdiGtYoIiofY+hf6guXUI/9VM/IlZHbjr689Kd5ui3
 27osrhxGM+nldemRrHrMyWjuz+MWM/+iZ9hLgtyHP2dj5eEbPHiI5LbIF11NuOD9K688
 2c2dd8tPgeAqa4xpQxlzwZdnDUAa1zO8PS0quShWp9y06xVbGUwoJhY881l5XljEzPgN
 kR6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsb+9n2dutVAP/qa9tZ1vnyI+Tqy5uXIDB5DuA9wVh+8HZ/xbkbbXLVCylLxXwOpS3QWXU+XE5AE65@nongnu.org
X-Gm-Message-State: AOJu0YxPxM1MjlPT8Tc87IDRq9d5ibpJf249ao+KiaZrOpXP+axQQBy1
 40XzRT2JzX5EwBuHtOvd57lXOKPMxxc670K30dmR8COUm4h7uHN73tdC2C+UV4ywqgY0zM6QASk
 wwbos2XFE7jPGC51QxjYT2b4zkSuQi6nzFGnutzYUurC3jKYoVKv9
X-Received: by 2002:a05:600c:3b11:b0:42f:5209:f82 with SMTP id
 5b1f17b1804b1-42f778fca07mr24075715e9.29.1727875287922; 
 Wed, 02 Oct 2024 06:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa0CuSkIxupuJBALLTiHnpFUd8KhvmGmKNzGDZWA5YCsoW6MqplAwf5hNS0uMtbh92chZYoA==
X-Received: by 2002:a05:600c:3b11:b0:42f:5209:f82 with SMTP id
 5b1f17b1804b1-42f778fca07mr24075465e9.29.1727875287486; 
 Wed, 02 Oct 2024 06:21:27 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79db2b97sm18643505e9.6.2024.10.02.06.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 06:21:26 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:21:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 05/15] acpi/ghes: Fix acpi_ghes_record_errors() argument
Message-ID: <20241002152126.08438809@imammedo.users.ipa.redhat.com>
In-Reply-To: <7c2862061ef4b358154414127f6cfd231310660e.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
 <7c2862061ef4b358154414127f6cfd231310660e.1727766088.git.mchehab+huawei@kernel.org>
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

On Tue,  1 Oct 2024 09:03:42 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Align the header file with the actual implementation of
> this function, as the first argument is source ID and not
> notification type.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> Changes from v8:
> - Non-rename/cleanup changes merged altogether;
> - source ID is now more generic, defined per guest target.
>   That should make easier to add support for 86.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/hw/acpi/ghes.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 20016c226d1f..50e3a25ea384 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -73,7 +73,7 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>                       const char *oem_id, const char *oem_table_id);
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
> -int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
> +int acpi_ghes_record_errors(uint8_t source_id, uint64_t error_physical_addr);
>  
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present


