Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B88CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfQ6-0004Mu-7c; Tue, 16 Jul 2024 06:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTfQ4-0004LI-Ma
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sTfQ3-0000JU-1o
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721125705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9dMyt5tLR62A+MRxjYYv0VkPrjjUrb3m20z3ATaoyZs=;
 b=eGM5DtvQIynGPXoGhEWcpS4HhTBQMqB3XznwXyENamqIwL1b8MRMKCGUlFDhEHdrwHdIQT
 R8Qvn8dmGguawe49kdZE8VlTdAPCsEpd6YxB8I7KB1ivzRPSNltY4+Y7evP1JTaICu9dX6
 Q//TWbjn1xmcsweDP/t2BOBlS4L0S9E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-LoJE7FZbO-CXkzEG1J1PXA-1; Tue, 16 Jul 2024 06:28:23 -0400
X-MC-Unique: LoJE7FZbO-CXkzEG1J1PXA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367990a5796so3290469f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 03:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721125702; x=1721730502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9dMyt5tLR62A+MRxjYYv0VkPrjjUrb3m20z3ATaoyZs=;
 b=N2k/eVFMA/BtKeO7CA+hZiTRvPvCT7sBYUDq4hGdSgqhr54grnXpn6YuNTr99KDg1N
 S4TxwdjWQU+TtfegA7eUYNbVWFiiT3KAh88aewC8NWKuokPavYidVmzo8cHLV+SUIpiU
 L1mHlHNIUGz+2d+cPqpio8dGFk1Zsly/inu/a7xuXQnJoZjqvVY9l8pQl/Tbh5vTK+WM
 BVimc8hyi/n/fKYpumHz8As3o1Znat+LdRvsQYuS16YMjBEoV4zyOGbdW0DjnHxiynhC
 xnOdG2uqAeLPDh1kKUfrj9evR/HX7PpWQt9OlDmldjtWO5xpL+N0WuY63DLAMJIp77il
 k8uQ==
X-Gm-Message-State: AOJu0YzZe37kzFWvbQMpFy1yoMJsVwCp5QrnqYs/7aNXpXWyrQG66bUt
 asZPq73zHVxeJp+hGpnxUqqdj5B1LWCowYt1twQjzPdpetcDr7ECSxgw/PyD/jQ3N9WGo3uLvm4
 d6uKYsz+eokRoTTWRLkjESVmClJeaqRbn9z/FkHN2hJZAU94npive
X-Received: by 2002:a5d:5f4d:0:b0:367:9088:fecc with SMTP id
 ffacd0b85a97d-36825f66d1cmr1190655f8f.7.1721125702673; 
 Tue, 16 Jul 2024 03:28:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjoYHzXVsHHoaQEjzjY1ErcKTwlmyc62XKKdwu2Mf+qlLjExjK2dmnpgcwe9CUvSxhqLrShg==
X-Received: by 2002:a5d:5f4d:0:b0:367:9088:fecc with SMTP id
 ffacd0b85a97d-36825f66d1cmr1190639f8f.7.1721125702321; 
 Tue, 16 Jul 2024 03:28:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbea9sm8702502f8f.82.2024.07.16.03.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 03:28:21 -0700 (PDT)
Date: Tue, 16 Jul 2024 12:28:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, "Michael S . Tsirkin" <mst@redhat.com>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v3 2/9] hw/riscv/virt-acpi-build.c: Update the HID of
 RISC-V UART
Message-ID: <20240716122821.2480bdc5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240715171129.1168896-3-sunilvl@ventanamicro.com>
References: <20240715171129.1168896-1-sunilvl@ventanamicro.com>
 <20240715171129.1168896-3-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
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

On Mon, 15 Jul 2024 22:41:22 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> The requirement ACPI_060 in the RISC-V BRS specification [1], requires
> NS16550 compatible UART to have the HID RSCV0003. So, update the HID for
> the UART.
> 
> [1] - https://github.com/riscv-non-isa/riscv-brs/commits/main/acpi.adoc
this should point to text like in previous patch and not to commit 

>       (commit: 7bfa87e86ad5658283731207dbfc8ab3744d3265)
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>

with above fixed:
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/riscv/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 5f5082a35b..36d6a3a412 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -170,7 +170,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>                      uint32_t uart_irq)
>  {
>      Aml *dev = aml_device("COM0");
> -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> +    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));
>      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>  
>      Aml *crs = aml_resource_template();


