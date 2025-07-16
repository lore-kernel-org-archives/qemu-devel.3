Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C397C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 16:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc55m-0006pL-CV; Wed, 16 Jul 2025 12:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uc55Q-0006aU-PE
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uc55M-0007DU-0b
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 12:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752683662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Lt8aj1FxR9CggnAUblYrgctpsKO75BIGUfC4DVW2fjc=;
 b=bMrc76zrf9XobgI+2UJ9VzRdRM46lisPdNfoYEcyLE5yYeTnwPVVEH5Wbuq2jXiZeQbD1r
 ULDuRbVI2woYhj2Ful+Zu06jjHcVRWa7/qTviSeZfALcdRHPpapqt/1fGQDH7BdCtao5S3
 MVi7pAX6EQmj3fTjX38RKnBzKW6uDLI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-QPlFBNg5MMWIPrJZaTTnRw-1; Wed, 16 Jul 2025 12:34:19 -0400
X-MC-Unique: QPlFBNg5MMWIPrJZaTTnRw-1
X-Mimecast-MFC-AGG-ID: QPlFBNg5MMWIPrJZaTTnRw_1752683658
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so269425e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 09:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752683658; x=1753288458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lt8aj1FxR9CggnAUblYrgctpsKO75BIGUfC4DVW2fjc=;
 b=n64X9pgIpPzO/9+LR0FA33JhdSVb2yIC7tln7R4zRPLAHcfE5aJDSyk7VmJqzMpRAF
 CHPBYWH+O3NRleZz24Atahsyv7/SCHM69wwjNOdJsxgOzl2FPPB1rqUY19pEqkwDMhUr
 09wND3vfre0918/Sxfb5CqQ5VzWTl31ZP1R8etSNU1FET4Mf1cwvgW/DtUJf1YKhYE30
 6X5dXmypv/8J7DR5zpsUkJVjdVwa2CqeQgivf3k0b5jymm9yXd1QD0GVKUPh9HI+pyKN
 wajyCn/KY7m7aCYcxjGomFkg5nHE84s3M60dNxLUq/TVdomBUrrbKFg0Ay81exEoBZg5
 k77w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwYt3ENYoUv633W0RfEnfd+YBOZTVhupt4KL8WYVOlgIaQkQQwiiU3GaVOo/WrfQSDom+3zQwi/a22@nongnu.org
X-Gm-Message-State: AOJu0YxZaLwekRyCzv2oVDbnPGUZ3VKgOcxGtc0SpzNSYeeuYC4Hr9ip
 K8Zy3fVmisbClSub8oNa0MxxJtSpxMa+UfXAVytVV4tSLVb7nfdw7ribh7ghXYBX/g5ajhJ24r0
 uDVZ4hFxMAAM8zCa0KWHbV3R6wN8zscE+b2dAf2doN8T+6f/IsquEmzaI
X-Gm-Gg: ASbGncuk2L9oPurTe2P9YH4b+q85K4vq4Z75LugfTsgXfcjDVJaGGx/39rGkFCXBQ9F
 jt492eVzbeKabDPMJ9nz4yFdC1e0re8egCQggF7UOaTZLVkz3JZ0LJMFl7t902wstArkAXJ5gPJ
 wpFXPZB4zfxy8qdafJL3eMTTQRFtqg2re8yDfYrv0HAgat19xdC1t1/Ie5J6VyGJVerlbUYSaDC
 t5XbjSyeMm4o8Z9gVQDtCPD3eCxzyE8rGRS2FThzbJGn3cVXUpVIoHXrBNlPPlpm0Tp0Z0ohRsR
 tQfgw156MR19Dc/NLvSK1CaTxIoAlo6W
X-Received: by 2002:a05:600c:1c81:b0:456:161c:3d6f with SMTP id
 5b1f17b1804b1-4562dfe78dfmr39852375e9.11.1752683658134; 
 Wed, 16 Jul 2025 09:34:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV6ARNWrC22WSly1BT7ol8d2Xlb+fz8Fhi7OSr2CfruKNlfa8xXro/g5y8RAdDjwrCM28Bzg==
X-Received: by 2002:a05:600c:1c81:b0:456:161c:3d6f with SMTP id
 5b1f17b1804b1-4562dfe78dfmr39852125e9.11.1752683657700; 
 Wed, 16 Jul 2025 09:34:17 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd180fsm18165517f8f.2.2025.07.16.09.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 09:34:17 -0700 (PDT)
Date: Wed, 16 Jul 2025 12:34:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>,
 Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH 2/3] hw/riscv/virt-acpi-build.c: Update FADT and MADT
 versions
Message-ID: <20250716123314-mutt-send-email-mst@kernel.org>
References: <20250716144140.3954431-1-sunilvl@ventanamicro.com>
 <20250716144140.3954431-3-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716144140.3954431-3-sunilvl@ventanamicro.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 08:11:39PM +0530, Sunil V L wrote:
> RISC-V support is added only in ACPI 6.6. According to the ACPI 6.6
> specification, the minor version of the Fixed ACPI Description Table
> (FADT) should be 6, and the Multiple APIC Description Table (MADT)
> should use revision 7. So, update the RISC-V FADT and MADT to reflect
> correct versions.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  hw/riscv/virt-acpi-build.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index ee1416d264..d7e57cbb1f 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -429,7 +429,7 @@ static void build_fadt_rev6(GArray *table_data,
>  {
>      AcpiFadtData fadt = {
>          .rev = 6,
> -        .minor_ver = 5,
> +        .minor_ver = 6,
>          .flags = 1 << ACPI_FADT_F_HW_REDUCED_ACPI,
>          .xdsdt_tbl_offset = &dsdt_tbl_offset,
>      };
> @@ -537,7 +537,7 @@ static void build_madt(GArray *table_data,
>  
>      hart_index_bits = imsic_num_bits(imsic_max_hart_per_socket);
>  
> -    AcpiTable table = { .sig = "APIC", .rev = 6, .oem_id = s->oem_id,
> +    AcpiTable table = { .sig = "APIC", .rev = 7, .oem_id = s->oem_id,
>                          .oem_table_id = s->oem_table_id };

Add comments citing the spec version and chapter.


>      acpi_table_begin(&table, table_data);
> -- 
> 2.43.0


