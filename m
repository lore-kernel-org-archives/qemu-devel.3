Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61D2CF6D21
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 13:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svzHR-0003TB-D2; Wed, 02 Oct 2024 09:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzHP-0003Sv-Nh
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1svzHO-0007PH-2y
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 09:20:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727875232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t8G6I2i4FaDHY2EK/vvbx77DXkVZHXJ6ZumTYcL076I=;
 b=MvqZEpCPaoObqjZBJtIgipKfbplDm7op8fLan8QelM248QOuXNC4fyuUAuzVeDAI7+itxT
 cIZdW+T+9as9hqYTJhjL70XmAS+CKrNm263vPMWvsUQ9c3JwG5W2nqob07KkmPsuOZHvW/
 CYB6JCg/Z0KEmhl1p9KJxtJJ5eGOOQA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-8s7CgaXtM8WrvvSWfU1XAA-1; Wed, 02 Oct 2024 09:20:31 -0400
X-MC-Unique: 8s7CgaXtM8WrvvSWfU1XAA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42cb5f6708aso41388535e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 06:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727875230; x=1728480030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t8G6I2i4FaDHY2EK/vvbx77DXkVZHXJ6ZumTYcL076I=;
 b=fo7RY10S/RJS8Gt+zjKShuptZ577Ztu9rm2QDUzS1kiczEOyO4BPcF+XtS3o3xjnjb
 M/gUbDHoETI76NNVtrR5RxYHaX7Ml8UMOAj1etLUCHYCk+TmnfpP9w7l7gpDUhnyK5Mf
 X677b+UgnW95Iky+5nSnfoC6bAaCQpt71r8ZAbKHRQFEFkxR8bgtZEx6FyH+F+Ex0WHY
 q4hUGTVo4SgNNvySaoV/aT5hc+kYWuMzHbjPz8dbtaFHfqKxcId5qUxfJInX+yK1OGXP
 3/eAYxGV9K1B66sqVaryGIGxs7sniXhM6A35BB6j3GIlIY6s4vvNKs+Wj9LxPb+QrjKS
 Ws0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxBF3LX0E0H/RNWrWGiEm27PDIzK8Mh3PzkBkuwpB3bGLyhyvmVmt8UEzYCeXgrrtlA3jBpRuXxksb@nongnu.org
X-Gm-Message-State: AOJu0YzoP5kP6Hpr3jEUtBUGAx7evhwjmJHw138a7jWMGYergHdOiS9o
 qn5rR+O+GqfwkTSneQc9z0APEymyFTy+ZRUmpuDShGhbe/QTVdlTUbUkReD29Hn1bH05Vl8Xug/
 IvgKxC9ufKZzKjhrucb4wK/bGVWsur8o/4g2JBp+PM9IvXggM6r36
X-Received: by 2002:a05:600c:a4b:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-42f777c7ea4mr19128885e9.19.1727875230520; 
 Wed, 02 Oct 2024 06:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ+dzAihiBsY9l8Oiv6bvplCLVDGsi0Vh04FiMpWB5vmn9nn14wcdtaG5jGl8wWqU/T1F/KQ==
X-Received: by 2002:a05:600c:a4b:b0:426:6edf:6597 with SMTP id
 5b1f17b1804b1-42f777c7ea4mr19128635e9.19.1727875230121; 
 Wed, 02 Oct 2024 06:20:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79ead1absm18404085e9.17.2024.10.02.06.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 06:20:28 -0700 (PDT)
Date: Wed, 2 Oct 2024 15:20:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 10/15] acpi/ghes: move offset calculus to a separate
 function
Message-ID: <20241002152027.6b90e8cd@imammedo.users.ipa.redhat.com>
In-Reply-To: <84226f5976fd29e23ce47d3a5cd311821c8111f8.1727766088.git.mchehab+huawei@kernel.org>
References: <cover.1727766088.git.mchehab+huawei@kernel.org>
 <84226f5976fd29e23ce47d3a5cd311821c8111f8.1727766088.git.mchehab+huawei@kernel.org>
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

On Tue,  1 Oct 2024 09:03:47 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Currently, CPER address location is calculated as an offset of
> the hardware_errors table. It is also badly named, as the
> offset actually used is the address where the CPER data starts,
> and not the beginning of the error source.
> 
> Move the logic which calculates such offset to a separate
> function, in preparation for a patch that will be changing the
> logic to calculate it from the HEST table.
> 
> While here, properly name the variable which stores the cper
> address.

I'd move 14/15 into the beginning of the series,
so this patch would look a bit more sensible.

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/acpi/ghes.c | 50 +++++++++++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 628fa9b22f4b..900f1571bc97 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -378,11 +378,36 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      ags->present = true;
>  }
>  
> +static void get_ghes_offsets(uint64_t ghes_addr,
> +                             uint64_t *cper_addr,
> +                             uint64_t *read_ack_register_addr)
> +{
> +    if (!ghes_addr) {
> +        return;
> +    }
> +
> +    /*
> +     * non-HEST version supports only one source, so no need to change
> +     * the start offset based on the source ID. Also, we can't validate
> +     * the source ID, as it is stored inside the HEST table.
> +     */
> +
> +    cpu_physical_memory_read(ghes_addr, cper_addr,
> +                             sizeof(*cper_addr));
> +
> +    *cper_addr = le64_to_cpu(*cper_addr);
> +
> +    /*
> +     * As the current version supports only one source, the ack offset is
> +     * just sizeof(uint64_t).
> +     */
> +    *read_ack_register_addr = ghes_addr + sizeof(uint64_t);
> +}
> +
>  void ghes_record_cper_errors(const void *cper, size_t len,
>                               uint16_t source_id, Error **errp)
>  {
> -    uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> -    uint64_t start_addr;
> +    uint64_t cper_addr = 0, read_ack_register_addr = 0, read_ack_register;
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> @@ -396,27 +421,14 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>      g_assert(acpi_ged_state);
>      ags = &acpi_ged_state->ghes_state;
>  
> -    /*
> -     * Current version supports only one source, as assured during table build,
> -     * so no need to change the start offset based on the source ID.
> -     */
> -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> +    get_ghes_offsets(le64_to_cpu(ags->ghes_addr_le),
> +                     &cper_addr, &read_ack_register_addr);
>  
> -    cpu_physical_memory_read(start_addr, &error_block_addr,
> -                             sizeof(error_block_addr));
> -
> -    error_block_addr = le64_to_cpu(error_block_addr);
> -    if (!error_block_addr) {
> +    if (!cper_addr) {
>          error_setg(errp, "can not find Generic Error Status Block");
>          return;
>      }
>  
> -    /*
> -     * As the current version supports only one source, the ack offset is
> -     * just sizeof(uint64_t).
> -     */
> -    read_ack_register_addr = start_addr + sizeof(uint64_t);
> -
>      cpu_physical_memory_read(read_ack_register_addr,
>                               &read_ack_register, sizeof(read_ack_register));
>  
> @@ -437,7 +449,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
>          &read_ack_register, sizeof(uint64_t));
>  
>      /* Write the generic error data entry into guest memory */
> -    cpu_physical_memory_write(error_block_addr, cper, len);
> +    cpu_physical_memory_write(cper_addr, cper, len);
>  
>      return;
>  }


