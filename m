Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CEEC3600A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVcd-0007vD-TK; Tue, 17 Sep 2024 06:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqVca-0007Wk-GF
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:39:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqVcY-0008B9-Vr
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Y5o5UIqHFRVGRxSAbGQX8S6o3VCRAhbHIE+pm5uS8k=;
 b=bsxRnJ9eeHISVuemWwycjFEbsPRTUtHC+b7/Sy340pbBOywjoLDisdWiSrTAmrITQR0FtP
 EfppnpTQu2LAiADrtL7wN3vUqPMUk2nbgBu2UKkeCUzAj22XvAkLfbnUu3N3Dttd46Blcc
 fWH7mvHLFufGBDD/XqVjNs+FbiBFcZs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-sJwfh8dDMXqMHwplOXRL9g-1; Tue, 17 Sep 2024 06:39:45 -0400
X-MC-Unique: sJwfh8dDMXqMHwplOXRL9g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cbcf60722so40398535e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 03:39:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726569584; x=1727174384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Y5o5UIqHFRVGRxSAbGQX8S6o3VCRAhbHIE+pm5uS8k=;
 b=N/TjWVselcC5Cbto3guy2IXBB0kSejifAo+7B/+aXUCHWGD1T7ldKifsX0JNfkDBqt
 sA1jgkkGRZ/Au5swiMvC1TbGnIP0SJfKRRl58y+kYZqItJOgNU0nwUmui8x8typWhkPH
 b1rOjbVzLSfjPdm1ioG8nQeQB14z/s1hTNEURFpPTO5YTgvqNERrGxP3a9SE3lMulOXa
 kmlS+d3iKHYdN8iz7/0bZABqAJtMbCTrGHA0fmqcRjf0aNYT/so4wd+XoEAebBy4XK/C
 e7aRvzS8LQmh3XLm3gmZ1xFVWNUK3gSVrZAwMqsJapQjxyB3SLolNbvpIA14ZW11+4dP
 SaPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj25Ntpn78x0lwhf+ETo2FC4unElLOF3JWI4A4f3NgzjojVg1/JrwAQEUcX8tgHeBeFOo7TQwThtPo@nongnu.org
X-Gm-Message-State: AOJu0Yw58BDA9HjskpqFZOOFuJs6resjxslyDMG3EHRjwvRh1PojfsP+
 +aCpSYOZbYeIEMsvYKYBY1q/Gz1QKmDi6VRTG5J8Qk9hlLT+f6rmhHyhdP4iwoa92QJBbNh6fLH
 Cye0DIyAVtlKN7IB2xCXsG+0FW0EWZmJQpPbTHhxCdtIgNooVUZ1Q
X-Received: by 2002:a05:600c:1c28:b0:42c:b187:bdeb with SMTP id
 5b1f17b1804b1-42cdb590f1cmr141828975e9.29.1726569583884; 
 Tue, 17 Sep 2024 03:39:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiiC0f5y3CXMF+iRUi9MF5LHgk9+qATIIdCrE1mjySaFe9beeQ3bBi0uw0siuLz2327t/Zvw==
X-Received: by 2002:a05:600c:1c28:b0:42c:b187:bdeb with SMTP id
 5b1f17b1804b1-42cdb590f1cmr141828725e9.29.1726569583356; 
 Tue, 17 Sep 2024 03:39:43 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22b8b70sm98685535e9.9.2024.09.17.03.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 03:39:42 -0700 (PDT)
Date: Tue, 17 Sep 2024 12:39:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 06/21] acpi/ghes: Remove a duplicated out of bounds
 check
Message-ID: <20240917123941.2a5ba7b2@imammedo.users.ipa.redhat.com>
In-Reply-To: <25bdbb971c3f7ccbc0e1964605dfe954193b8fcb.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <25bdbb971c3f7ccbc0e1964605dfe954193b8fcb.1726293808.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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

On Sat, 14 Sep 2024 08:13:27 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> acpi_ghes_record_errors() has an assert() at the beginning
> to ensure that source_id will be lower than
> ACPI_GHES_ERROR_SOURCE_COUNT. Remove a duplicated check.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 939e89723a2f..36fe5f68782f 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -420,9 +420,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>          return -1;
>      }
>  
> -    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
> -        start_addr += source_id * sizeof(uint64_t);
> -    }
> +    start_addr += source_id * sizeof(uint64_t);
>  
>      cpu_physical_memory_read(start_addr, &error_block_addr,
>                                  sizeof(error_block_addr));


