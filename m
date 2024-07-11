Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FFEC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtkE-0001Gj-TP; Thu, 11 Jul 2024 09:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRtk4-0000gk-5R
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:21:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sRtk2-0006j1-6F
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720704105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mN0sRZ3bdsO54hnVlLYkoH6g7lrAo+ChghkMqg7jdgg=;
 b=R6tNkvBrlKWRzioAYzN62ankJGoznZQQN6JciX2Dvq7GBDE3MzAMj0Bns5h/vtPn1zIjzO
 cv7MZqR818N0UgYj2h36edITbt1FqdH/BorwvtO0+4mfKxEp0Co37YZaP/KB8+ZIRiLv6M
 piaV2uizCGS+DDZIXtiKhJGm+zAdQ+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-ijAxXFzZPGSMXzERhPvdpA-1; Thu, 11 Jul 2024 09:21:43 -0400
X-MC-Unique: ijAxXFzZPGSMXzERhPvdpA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367991a0a64so431918f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720704102; x=1721308902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mN0sRZ3bdsO54hnVlLYkoH6g7lrAo+ChghkMqg7jdgg=;
 b=EuGQYChH4JzpjWUXg2lSRX2p8FxJNh+hxa7pQpoD3Dy+ooV+6KZxBjWYZqnwxdZCJt
 tGloL2HzFtLng9ahq3kAyBV/cJfvpNrQd0ALbs4mWbzbdAI6Hcbgu9drofZr/mFeaz0c
 gvll0UFQAa4vj0ldHOeb2ypbJjDY7EePkS+esoDO3Nvlt7A2gPsF/OWDzv/g06V1Kktz
 L/MtUy8fg2FvC+/Or+8SDp3hwiqzbadqRKqUGW2EWOfTlxIpz6TZdOV49Nq/6qehaNbg
 onQLM7vD5/LZe3kowZttg4gt1DpmaXoplyvVkOZWBQOVhBwLUMRmLDraR1Ut9ZtoT0xi
 2X1Q==
X-Gm-Message-State: AOJu0YwqaY7kJQojSuKUl/bSTlBAbNd+3YoAi+OtO1xLVCuvFfuJMXao
 U8dMapZLt6PPqAneQu5QkfAvSnLfiv6eMzKexZfYAPp/dKkyH8ANHdskx0CJtAvJcHGLx0fEEIj
 yEROZEr0I+b6d++AdLSOn0MVepPqMjZmoTlKBR2pwPoQbu+FPYIDc
X-Received: by 2002:a05:6000:c6:b0:367:963b:ab81 with SMTP id
 ffacd0b85a97d-367ceacaa90mr5688410f8f.46.1720704102661; 
 Thu, 11 Jul 2024 06:21:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM+q02fComieQSyE7QIb0XjvJJ4i3vmG8SrqxyvMG5hmF6IoBW7pWtouX48NWKFK/PIGPXBA==
X-Received: by 2002:a05:6000:c6:b0:367:963b:ab81 with SMTP id
 ffacd0b85a97d-367ceacaa90mr5688387f8f.46.1720704102274; 
 Thu, 11 Jul 2024 06:21:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde890bdsm7787326f8f.50.2024.07.11.06.21.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:21:41 -0700 (PDT)
Date: Thu, 11 Jul 2024 15:21:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v2 1/9] hw/riscv/virt-acpi-build.c: Add namespace
 devices for PLIC and APLIC
Message-ID: <20240711152141.741d5bc5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240708114741.3499585-2-sunilvl@ventanamicro.com>
References: <20240708114741.3499585-1-sunilvl@ventanamicro.com>
 <20240708114741.3499585-2-sunilvl@ventanamicro.com>
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

On Mon,  8 Jul 2024 17:17:33 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> PLIC and APLIC should be in namespace as well. So, add them using the
> defined HID.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/virt-acpi-build.c | 47 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 0925528160..87fe882af0 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -141,6 +141,52 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
>      }
>  }
>  
> +static void acpi_dsdt_add_plic_aplic(Aml *scope, RISCVVirtState *s)
> +{
> +    MachineState *ms = MACHINE(s);
> +    uint64_t plic_aplic_addr;
> +    uint32_t gsi_base;
> +    uint8_t  socket;
> +
> +    if (s->aia_type == VIRT_AIA_TYPE_NONE) {
> +        /* PLICs */
> +        for (socket = 0; socket < riscv_socket_count(ms); socket++) {

you have socket_count in caller already, pass it as argument and
drop  MachineState *ms = MACHINE(s) above.


> +            plic_aplic_addr = s->memmap[VIRT_PLIC].base +
> +                         s->memmap[VIRT_PLIC].size * socket;
> +            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            Aml *dev = aml_device("IC%.02X", socket);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0001")));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> +            aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
> +
> +            Aml *crs = aml_resource_template();
> +            aml_append(crs, aml_memory32_fixed(plic_aplic_addr,
> +                                               s->memmap[VIRT_PLIC].size,
> +                                               AML_READ_WRITE));
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(scope, dev);
> +        }
> +    } else {
> +        /* APLICs */
> +        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
> +            plic_aplic_addr = s->memmap[VIRT_APLIC_S].base +
> +                             s->memmap[VIRT_APLIC_S].size * socket;
> +            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            Aml *dev = aml_device("IC%.02X", socket);
> +            aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0002")));
> +            aml_append(dev, aml_name_decl("_UID", aml_int(socket)));
> +            aml_append(dev, aml_name_decl("_GSB", aml_int(gsi_base)));
> +
> +            Aml *crs = aml_resource_template();
> +            aml_append(crs, aml_memory32_fixed(plic_aplic_addr,
> +                                               s->memmap[VIRT_APLIC_S].size,
> +                                               AML_READ_WRITE));
> +            aml_append(dev, aml_name_decl("_CRS", crs));
> +            aml_append(scope, dev);
> +        }
> +    }
> +}
> +
>  static void
>  acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>                      uint32_t uart_irq)
> @@ -411,6 +457,7 @@ static void build_dsdt(GArray *table_data,
>  
>      socket_count = riscv_socket_count(ms);
>  
> +    acpi_dsdt_add_plic_aplic(scope, s);
Perhaps do the same for memmap/RISCVVirtState vvvv

>      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART0], UART0_IRQ);


>  
>      if (socket_count == 1) {


