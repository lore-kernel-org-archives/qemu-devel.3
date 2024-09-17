Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F777C35FFD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 09:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqUQ4-0000Os-7f; Tue, 17 Sep 2024 05:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqUQ2-0000Hs-Kf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sqUQ0-0004hB-Pq
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 05:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726564964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gM6/s5JzlURtImk2OaK1piumzBONmsL9B4dUQRIQefk=;
 b=ARPFIflbk25XJsmYE/eg/nLDTEknavw1FworF+cnDbYvpnjBMhrXSfI9nbqdy5OHEnBU5D
 kiD3K7Qb9qIWM+xxJr4mJv2kE/XwAKtOScVeF7zxsmGF96zsXaVstXydBAgAwVDNJQnehJ
 hZp96+iPWv7BIDo52/W0aXZhEyi18ok=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-KIEV1d2QOa2Wu8lSTP4WeQ-1; Tue, 17 Sep 2024 05:22:42 -0400
X-MC-Unique: KIEV1d2QOa2Wu8lSTP4WeQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-378929f1a4eso2928843f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 02:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726564961; x=1727169761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gM6/s5JzlURtImk2OaK1piumzBONmsL9B4dUQRIQefk=;
 b=b74Ev+rUkUo1xgm8q8EpLjTst5ptdfu9WjZD9L/am85z8qV0sZNmbsMY7ozRk/8T53
 OuiQkIsdDtFXXmHNq6HrUWjYrHcJ6iRxmxxISZjIbeRdyT1XDZtwLVTL2ccAgP4UUqVA
 E17jI+p7jKxsaWeJQVuLj7LiyydzyVq60IVChlxhRxrKlsWVAoIQzBfOifKFpElxnWMh
 DBvka+wy6+D6DCM623xLtu2h0H1KS1M7xzTf4KrsQSv/OvydLBU3ag/YT5sFdhITnmsG
 VAzj2CPmrdslqMjHb2sRHQjphXCotGxkfe3gC5cqLxX4c9dzeL3GtIztYLk7M10++L/v
 9SAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoviTpkrTG+RREHNV70IinM3txKy/YDnqlr9M4BodJaR9j7/CV7L8vrgXVWoMOfW0Qb1dnzQBYrhXJ@nongnu.org
X-Gm-Message-State: AOJu0YxDPIY16QGQCt8c0qQ3zS0iLNc+s7W4ePwOlavj5CgmZpOPv1eD
 O2ZNyfMQQg7WExSrvJLnkC9dTyt6sn7jyUhQVgW/R5XGQfqy4LdOIdDiDAmc0Tpzn3acpr3BkeM
 39nRhjmJmFEkHiLVehCDtNqyWodth0gfDrJge3vjRsavU/SwCfL7z
X-Received: by 2002:adf:efc9:0:b0:371:8a91:9e72 with SMTP id
 ffacd0b85a97d-378c2d119f7mr12005826f8f.30.1726564961563; 
 Tue, 17 Sep 2024 02:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqYVYCTIMhAhk0CJfwZmZ3/b1qIb8YzfZSTf4gL82RAQ5AU+D2fLAvtIxrIBrsVjw24Z0VhA==
X-Received: by 2002:adf:efc9:0:b0:371:8a91:9e72 with SMTP id
 ffacd0b85a97d-378c2d119f7mr12005812f8f.30.1726564961052; 
 Tue, 17 Sep 2024 02:22:41 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73f62dasm8971910f8f.49.2024.09.17.02.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 02:22:40 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:22:39 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v10 03/21] acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
Message-ID: <20240917112239.503b2a0b@imammedo.users.ipa.redhat.com>
In-Reply-To: <eb07ac97c57f4fbab413eba8a47150037b5a7684.1726293808.git.mchehab+huawei@kernel.org>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <eb07ac97c57f4fbab413eba8a47150037b5a7684.1726293808.git.mchehab+huawei@kernel.org>
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

On Sat, 14 Sep 2024 08:13:24 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> This is just duplicating ACPI_GHES_ERROR_SOURCE_COUNT, which
> has a better name. So, drop the duplication.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 7 ++-----
>  include/hw/acpi/ghes.h | 3 ++-
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 529c14e3289f..35f793401d06 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -35,9 +35,6 @@
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
>  
> -/* Now only support ARMv8 SEA notification type error source */
> -#define ACPI_GHES_ERROR_SOURCE_COUNT        1
> -
>  /* Generic Hardware Error Source version 2 */
>  #define ACPI_GHES_SOURCE_GENERIC_ERROR_V2   10
>  
> @@ -411,7 +408,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>      AcpiGedState *acpi_ged_state;
>      AcpiGhesState *ags;
>  
> -    assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> +    assert(source_id < ACPI_GHES_ERROR_SOURCE_COUNT);
>  
>      acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
>                                                         NULL));
> @@ -422,7 +419,7 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
>  
>      if (physical_address) {
>  
> -        if (source_id < ACPI_HEST_SRC_ID_RESERVED) {
> +        if (source_id < ACPI_GHES_ERROR_SOURCE_COUNT) {
>              start_addr += source_id * sizeof(uint64_t);
>          }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 28b956acb19a..5421ffcbb7fa 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -59,7 +59,8 @@ enum AcpiGhesNotifyType {
>  enum {
>      ACPI_HEST_SRC_ID_SEA = 0,
>      /* future ids go here */
> -    ACPI_HEST_SRC_ID_RESERVED,
> +
> +    ACPI_GHES_ERROR_SOURCE_COUNT
>  };
>  
>  typedef struct AcpiGhesState {


