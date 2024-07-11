Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F37C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtno-00016C-OX; Thu, 11 Jul 2024 09:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRtnZ-0008QB-6q
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRtnT-0000WD-6H
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720704316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0mlNGZ4bfWgRjS9ILK0zXFJKte83IiOLCct3+UOnosw=;
 b=WhWGHz/WWbrHMjrLprSJFvup1y5KzJVaI1Fu0JH43bLUSYPbEohgr5MMypm+xbjCNChGG2
 QE4UfSdNgXoG7x88t5uN0exdPeQxupGu+5iqCj5iNcDB94blj709ZO2xck9l+d7wBCRwiq
 A5hlLWtdNnddy2gbX6VBWX2Jbqh0/G0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-nX5ivUExP0Su33vQq4jJYg-1; Thu, 11 Jul 2024 09:25:15 -0400
X-MC-Unique: nX5ivUExP0Su33vQq4jJYg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2eebc944683so9446391fa.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720704314; x=1721309114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0mlNGZ4bfWgRjS9ILK0zXFJKte83IiOLCct3+UOnosw=;
 b=qIzvQt1y1AiVb3l+mziKkBecVj+qVYtJ9Nc4YeslrQYqgLHfjWO+IE5U33PHG7/vsq
 Kw6bIu8AJA7xWPq8XwZ0KnRR9a74cFH+zEP1QP0aqc344jpIFA4sER4DdWiC74e93Mf2
 ZDVAhpIrQX8KbclLPUKlqPijUTIWRPcWo4QvouYSUBAPrPSPrFnXHaM75OoMMMKgZumr
 jmzEdZ8DcJTMnm/yD69qL/VGQyOPmOc8IrkqW6PIcKb0UYbPwqEcYq4/ezBELxvWtu0b
 l49pBv4PtrfNIod6FYmCNMSmw37OIOxyfhdbiE2kGnqfFbK4f/1Q+MKLr0u1atdyVqNu
 zF+Q==
X-Gm-Message-State: AOJu0YxwZbXpaXMcG8L+HJ94DH5g1SIo/3V3EbNe5XRJGHKuSb+Ymhed
 aFs81IvFdn4XA7ZyZRnHcUGsQvTfHWknSTitcDWggkOCMALyxPpZZHCy9nwA9Zfpcf7z5hlelYX
 JUktUJfoDVK8MXrF/7JE+p3Opt+t2eP2m0mXBh7M+6yN2C5qgDxkV
X-Received: by 2002:a2e:9b57:0:b0:2ec:4de9:7334 with SMTP id
 38308e7fff4ca-2eeb30b9a2amr61918921fa.11.1720704314000; 
 Thu, 11 Jul 2024 06:25:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPatDhweWWk+d5kmgLL3/xo18zlu3AZi+X6KGXf7YsIGKCaHgbh0s7I9hRKQfskauRLqmxzw==
X-Received: by 2002:a2e:9b57:0:b0:2ec:4de9:7334 with SMTP id
 38308e7fff4ca-2eeb30b9a2amr61918681fa.11.1720704313623; 
 Thu, 11 Jul 2024 06:25:13 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa07b9sm7721453f8f.74.2024.07.11.06.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:25:12 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:25:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 2/9] hw/riscv/virt-acpi-build.c: Update the HID of
 RISC-V UART
Message-ID: <20240711152512.5e2fac36@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240708114741.3499585-3-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240708114741.3499585-3-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon,  8 Jul 2024 17:17:34 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> The RISC-V BRS specification [1] requires NS16550 compatible UART to
> have the HID RSCV0003. So, update the HID for the UART.
> 
> [1] - https://github.com/riscv-non-isa/riscv-brs

it point's repo with a bunch of files,
please make it easier for reader to find
aka point to concrete document + title (for when link goes stale)
and chapter. (similar to what we do for when documenting ACPI code)

> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 87fe882af0..939f951e45 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -192,7 +192,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>                      uint32_t uart_irq)
>  {
>      Aml *dev = aml_device("COM0");
> -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> +    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
>      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>  
>      Aml *crs = aml_resource_template();


