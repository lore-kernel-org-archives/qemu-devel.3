Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A385CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 13:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWFh-0004gz-64; Thu, 14 May 2026 09:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNWFf-0004gb-5l
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNWFd-0002Sn-6P
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778765839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SjcPbh8yr2oK5KjKzE/XH/0Yle3o8UNey6/It1VWbuQ=;
 b=L29zFvvD68d7Gy5dDD3wsaAq98YQlT5eYWBpmhY/D9r90b/RyQV2eDAd344qRI2UQslgQM
 HbhVQZYYPn4vs3McQL2Ts6hnCTj/VmpualC3LfXKdGkZ6WeKLUeTcE/sjsKdnu9KUKIlh9
 WzAGMhldL57aFoFCIbm+9lcYALhH/2Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-7QmxHrN4PI-KrFJv1w4rWg-1; Thu, 14 May 2026 09:37:17 -0400
X-MC-Unique: 7QmxHrN4PI-KrFJv1w4rWg-1
X-Mimecast-MFC-AGG-ID: 7QmxHrN4PI-KrFJv1w4rWg_1778765837
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d7730e9e3so5071510f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778765836; x=1779370636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjcPbh8yr2oK5KjKzE/XH/0Yle3o8UNey6/It1VWbuQ=;
 b=TNpjtPyIrxnaVHXEL+3W732PECHcaZxUOXH36P/KeqJTuynEuRpGd/yN1XNOK7BWKw
 Ad5vRwvtxiXr7iQc+aAAVEge9B0kw//e8FisYfhobSxoYlpIbZPUEi3K60lcvwvCKRKY
 V1a702+pqNP2dbQ86WmKKmHHZnwLLIn7CINjCD1NbwsWmzcIPa2ocYLhV0hk8ytl59V7
 Dh2RSoe4H3VeVj2+Vi2nILY5QmUYFBUQrkVlRh/bF05t3ne8HiagdMgeCtV1MwtACrXn
 +7q0Vrsnphs7y1rvdz4qlK1fGuczTyjthoixFGU8vti5H1n7nzgaKZn90XjDSP3DzHK8
 4Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778765836; x=1779370636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SjcPbh8yr2oK5KjKzE/XH/0Yle3o8UNey6/It1VWbuQ=;
 b=nnT6A8wcJFbOwMb5/7LVO/KCkBl0zN2mfaCUGjpb6tyj0Qljt7KcY3PLaiwpu0saJ6
 GFJNE9mef2ftXx01+Hw+nCdh09uwiZWI+Od2oJX8Im0fRe+7/WAY2AsEf8C/a9TUrfYd
 qYq+hCEAXacVu3IT+KRJENediZYhVqFc7BBQuzdHnL9lLTRBVYg29ljQIfUVYKDNNwZY
 SloiyY0kvuiAxFnIxkA/zbmBL3s7qOQKLvbo/iNOb6vIeihhIEgam1pYOP/bJltwwPiv
 ybcQ3NwfK9ggtcK1Nu2tbGGOeqStLEalrRPCXsnzIvxFnUuuL10pI2TaUPvV4uIkEjB8
 EiZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xDXI+SoGEIgkzTUo3Vj1Tt+OK3l2ep/hGL6smL0toxLumEVhQHnpl0EgbQ+uJtDu46STFM3qq5h4J@nongnu.org
X-Gm-Message-State: AOJu0YwlHi19JdZF+IS2lJeFUKLZHLMX19hLzIq2Si45Vn/8rd4f6EwS
 g/AOqYuVid1sC4b64IFu0XEQGVcCb47Nr9U63HJsv2M5ew99N5nqpBQB+p7UaawHWxv+hetj7s6
 2rfJRGJdgfxQyPfNSqojE7HaoTGeXHmBC4KP5zFVOJuVhRgdKq+mnfMFy
X-Gm-Gg: Acq92OGixoFSk5vm3WbTtBWQur812lx5ASpMfJQPUW9n9olDxYWhhpvUz4YweTa1Wvy
 o3KG5TUMhu8P/SJYYCHIvy0yNOdONKXkEpOR/eSEf8SNcMlueZkL4mddPK4Eg+ct457shRNi9O/
 rJiXGoRvnwe/riKxWwD6sZOz91LJTHqqqs2pAuzv5b9OMtBuz8mfZ6lXhGz2KOPSfpoV20zMmpY
 6rqVk7eznPfJDV0PbsR0CzcZSgFDeO9jDsijfKcHh+jBbeRLpcJHfPQziPaP5eekskQojHUDBOH
 THWnRoManKHxRCTP2Q7V97PLV6GRAA9KrClgmzNHxz1Nh9X8hHye8XLpH7xv+8V/qOXdK3OX3fh
 hUBEUjg==
X-Received: by 2002:a05:6000:22c7:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-45c58884933mr12059011f8f.19.1778765836624; 
 Thu, 14 May 2026 06:37:16 -0700 (PDT)
X-Received: by 2002:a05:6000:22c7:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-45c58884933mr12058947f8f.19.1778765836223; 
 Thu, 14 May 2026 06:37:16 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9adc2209sm6139706f8f.0.2026.05.14.06.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:37:15 -0700 (PDT)
Date: Thu, 14 May 2026 15:37:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/4] hw/char/serial-isa.c: declare IRQ as shared in
 ACPI IRQ descriptor
Message-ID: <20260514153714.1cd2721b@imammedo>
In-Reply-To: <20260508101901.930781-4-mark.caveayland@nutanix.com>
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
 <20260508101901.930781-4-mark.caveayland@nutanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri,  8 May 2026 11:17:42 +0100
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
> 3.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
> Descriptor is used then the interrupt is considered to be high true, edge
> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
> an IRQ then if more than 2 serial ports are added, Windows indicates a
> conflict in Device Manager and these combinations cannot be used together.
> 
> Change the 2-byte IRQ Descriptor in the _CRS resource to a 3-byte IRQ
> Descriptor indicating that the ISA serial IRQ is high true, edge sensitive and
> shareable. This enables all 4 legacy serial ports to be used in Windows without
> conflict.
> 
> Note that it was agreed during the list discussion that this change does not
> require a compatibility property since it is not part of the default machine
> configuration and was already broken.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/char/serial-isa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index a4be0492c5..59df726871 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -92,7 +92,8 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
>  
>      crs = aml_resource_template();
>      aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
> -    aml_append(crs, aml_irq_no_flags(isa->isairq));
> +    aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_HIGH,
> +                            AML_SHARED));
>  
>      dev = aml_device("COM%d", isa->index + 1);
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));


