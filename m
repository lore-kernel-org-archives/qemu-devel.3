Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86056C3ABD2
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUVk-0006YC-Jg; Tue, 17 Sep 2024 05:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqUVh-0006WH-KV
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqUVf-0005P8-Ro
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726565315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKky4UPm9uDnWvji516fng+iapLQ5mCU5oI7sv9KVko=;
 b=iAPdXc/b4lo+S2ScDZWwWSusxE+vtkQtMWwC1ET+OO26GZbCKOvShSjn3bJXgGf7Lct3UG
 LdgbDzkvmAjem8fu3L8u4oKunY4vV2C4FCJB/EAgvFhHzpH/iJjlo/NJg7DQGK2jF8Y/w3
 QGdGA5fRgrC+UFPeKiMKcPQysXZzm/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-odcKaTtHPu-u4GS5uy9PmQ-1; Tue, 17 Sep 2024 05:28:31 -0400
X-MC-Unique: odcKaTtHPu-u4GS5uy9PmQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb6f3c476so42112775e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 02:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726565310; x=1727170110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TKky4UPm9uDnWvji516fng+iapLQ5mCU5oI7sv9KVko=;
 b=RmTjpWeYtwSL9pOU3+8c1izjuwk3OTgfoQwea5yKZOOgG1fpldAYjU6IZmq37V8jut
 iGg8V/3k3DoJnb1n5zC1rqX3ikGiw5yy5wMUMaZo58cO+KZDatKvegR6qD2n+hRFLXTh
 tT+bWIWRPmhblt1QsuR9VUwSss0Ir6LlfSWqtR4HXkDdCB6g/OHOmTT+N5T+H5AUFRhp
 usiq36tpFZ8gbRiTIryC76uYecPbGVfTraxvwTW06HYuUfh67C56WMHqjiN1ETRXS5Fs
 CvqnoyK9Rl5iPDIS027PhpnjfjjVHqQQuKUvnAhK3T8ZxhpUt9RAMPdE0KSSM4qTDNyY
 EaOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqkwTfnCHe3uax8Wj142tfThtKxlzB9ZX53Nr+sZii2dcN1yWJ3dx04wvH8JULfCY1opQnrcJpTnT3@nongnu.org
X-Gm-Message-State: AOJu0YyccbxWJoAxfyRJj8ViXfgGmPuW43Tu2dGnklBIhQtvm6oqR8MH
 G3RwQe12spughRTP5FerR7OLex+O0+vijieP8Ot3/et7rtkGqgniVI96QaO/st7NtA3mLMDwQDS
 06CirbbMrVIFte2xxfM31IzMj3WFouU0vtLNja+oXc1i5/hssQOXb
X-Received: by 2002:a05:600c:4707:b0:428:10d7:a4b1 with SMTP id
 5b1f17b1804b1-42cdb56dfa6mr147009505e9.25.1726565310172; 
 Tue, 17 Sep 2024 02:28:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+fhU2hQzDjy/E/ZXG2LagaJrZJDNZUK+L06+Bq+ORmLe1kVeMDNQu2vADH2mK7JepZsg4uA==
X-Received: by 2002:a05:600c:4707:b0:428:10d7:a4b1 with SMTP id
 5b1f17b1804b1-42cdb56dfa6mr147009205e9.25.1726565309593; 
 Tue, 17 Sep 2024 02:28:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780025asm9061262f8f.72.2024.09.17.02.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 02:28:29 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:28:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 04/21] acpi/ghes: simplify acpi_ghes_record_errors()
 code
Message-ID: <20240917112828.514d9255@imammedo.users.ipa.redhat.com>
In-Reply-To: <40b209cf75717796c658b26d0ecd564f63dc8656.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <40b209cf75717796c658b26d0ecd564f63dc8656.1726293808.git.mchehab+huawei@kernel.org>
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

On Sat, 14 Sep 2024 08:13:25 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> if physical_address is not defined, just return with an error
> set.

no need to mention that, as it's what does now.

> 
> That reduces the ident of the function and prepares it for
> the next changes.
> 
> No functional changes.

this is enough to describe the change.

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c | 56 ++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 27 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 35f793401d06..17b7d9e10f3e 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -417,40 +417,42 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  
>      start_addr = le64_to_cpu(ags->ghes_addr_le);
>  
> -    if (physical_address) {
> +    if (!physical_address) {
> +        return -1;
> +    }
>  
> -        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
> -            start_addr += source_id * sizeof(uint64_t);
> -        }
> +    if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
> +        start_addr += source_id * sizeof(uint64_t);
> +    }
>  
> -        cpu_physical_memory_read(start_addr, &error_block_addr,
> -                                 sizeof(error_block_addr));
> +    cpu_physical_memory_read(start_addr, &error_block_addr,
> +                                sizeof(error_block_addr));
>  
> -        error_block_addr = le64_to_cpu(error_block_addr);
> +    error_block_addr = le64_to_cpu(error_block_addr);
>  
> -        read_ack_register_addr = start_addr +
> -            ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
> +    read_ack_register_addr = start_addr +
> +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
>  
> -        cpu_physical_memory_read(read_ack_register_addr,
> -                                 &read_ack_register, sizeof(read_ack_register));
> +    cpu_physical_memory_read(read_ack_register_addr,
> +                                &read_ack_register, sizeof(read_ack_register));
>  
> -        /* zero means OSPM does not acknowledge the error */
> -        if (!read_ack_register) {
> -            error_report("OSPM does not acknowledge previous error,"
> -                " so can not record CPER for current error anymore");
> -        } else if (error_block_addr) {
> -            read_ack_register = cpu_to_le64(0);
> -            /*
> -             * Clear the Read Ack Register, OSPM will write it to 1 when
> -             * it acknowledges this error.
> -             */
> -            cpu_physical_memory_write(read_ack_register_addr,
> -                &read_ack_register, sizeof(uint64_t));
> +    /* zero means OSPM does not acknowledge the error */
> +    if (!read_ack_register) {
> +        error_report("OSPM does not acknowledge previous error,"
> +            " so can not record CPER for current error anymore");
> +    } else if (error_block_addr) {
> +        read_ack_register = cpu_to_le64(0);
> +        /*
> +         * Clear the Read Ack Register, OSPM will write it to 1 when
> +         * it acknowledges this error.
> +         */
> +        cpu_physical_memory_write(read_ack_register_addr,
> +            &read_ack_register, sizeof(uint64_t));
>  
> -            ret = acpi_ghes_record_mem_error(error_block_addr,
> -                                             physical_address);
> -        } else
> -            error_report("can not find Generic Error Status Block");
> +        ret = acpi_ghes_record_mem_error(error_block_addr,
> +                                            physical_address);
> +    } else {
> +        error_report("can not find Generic Error Status Block");
>      }
>  
>      return ret;


