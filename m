Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE0BCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIN1n-0003oC-8M; Thu, 30 Apr 2026 04:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wIN1j-0003nk-VR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:45:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wIN1i-0007WC-B0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 04:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777538740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmhLi3rVzAKEznojPt1D9BfEZzGvH5ayZgKcUrs3jKo=;
 b=cFpc9PceNtD0hxuNo3LcP1RwlesGDDqHlNss6ajxlc9kVditZLj/IIy9ql8ZbK3xStSoBN
 xDz5d3phiToodYBDP9a6ufffT0D/N3FrV2MUWZBw9Rclbjml9FDK/M9yAPmEnIxIwxySRV
 pmM1ln88GCQMwm4oF66n06tdZylMPJI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-d_P73KNANkSfI0YLOHzGqQ-1; Thu, 30 Apr 2026 04:45:38 -0400
X-MC-Unique: d_P73KNANkSfI0YLOHzGqQ-1
X-Mimecast-MFC-AGG-ID: d_P73KNANkSfI0YLOHzGqQ_1777538737
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8eb04352972so117805685a.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 01:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777538737; x=1778143537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmhLi3rVzAKEznojPt1D9BfEZzGvH5ayZgKcUrs3jKo=;
 b=aeLdrrDAE0gMV7f0tlMbWTdfnTpdPA4rKGvUrhLUOZHtKN3ONNOM2MZ3rxtqlk/QAg
 Akx9KW+wTOfKsfBiAlNzrF6Q2sy8z1GahDnm27IGHLoU3TmnH6mw8jpIocFzd7SzGSnJ
 Gr8F5p0tpQqXMmqSi47wvgQMOupDSTBiiqq+OpyLbEHo6a/AUHMaMAroJIh8MfPL/ftb
 YBo/10rT0sbfkgmS6RhvrLsmywPqTirA8jiTuZyN7IKLtnZeyypffkRl+4BImxylQAfv
 W6dfVR5BjFstfdiV26S7cDLnAeKJiVDW/rqP8f+ZR7F8MerWr33II7W4UnLT+Jc5E4SW
 /KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777538737; x=1778143537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cmhLi3rVzAKEznojPt1D9BfEZzGvH5ayZgKcUrs3jKo=;
 b=EZ0q4Jm9EdyeVITATHMwaA9Xt6VEZRI8LdXnGPEBX4e2uIy5x/ZnHnTT9sw/vRRe3h
 sQaT9rHhMumS+tJ0o78lYJ/Aj2sWHCKyTiBn9p+Do9bYIvktLyVF1imR1enpxs5FX1fR
 HuchMeWAnrZUD5++Nnnd6HeQjRUPpEU65AvKHNFXKS7hN6P/Hm9DJgiLt4I1uShpJAI9
 qx2nwfiq83VrAN07QcFAUdtVfb8ymyBiiB4HEjF2opYfOS4V3a84y2FgPtAx06DzgIHk
 WhTCxp8D9nC3Hv2lJMV2R5/7S30OEsoLC1f/P+JXgYpTyg33/YIvqkyqIfy/LoZWJPct
 xsJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xZw8b8O+YTO2g3V+qT1HAHIvrDtJ4tc3dPLHK7+Mxlt/cNgiPK+FyXj0eceD4yzw6grHrymLSWlOs@nongnu.org
X-Gm-Message-State: AOJu0YwHBH/qeRhQHi5u7jOfx2CFXN2oqpoqghGX5jfDK9dRDhL67ZiJ
 QTP/3yqQ3DaFndrosSR1UzT4/uwDoafRsANDSQZ/rlQ0aOEMRYZ3/OyAdLtoiw304GgN6xKb9zT
 C1+qrYoJhsXt4IrFDYWXL5MDHuLedK6kK5TzuqCu0Ape4mWfiYZvqwtOA
X-Gm-Gg: AeBDietJCNONOjo2cI5hb8GqynCm2vz3TZZBrBC1aAApRYfM/fDu/01idYGkfqXGjxR
 yAt6fBv4TZslaAoN9IAfAE/pPhL7aZRCD4JmjYm2uwLOGnJVJSmJFRj8iwH+J5JJCulhtuA+7kk
 2ffp8kbHNCI7Z2uH8mWcGsxxlfT/0GVYRU5men7ypogDZQRXYzlWoWpyUmHHWAm1S6kj08ypW2G
 KGH7VJerLiK/xr/BivQdJCEENuhN8VbJCzXO3aT3tJCY/I1JinnZ6TVflDrrKP3/S6eHdg5sA7i
 yc21pLwzbSiC09q1bWjRnv4++YTB1RGf7tno8CogpVElBT/m7cB/BFR/ehXNjkeN+kQkIC1zYed
 ivHQjcggZUsYUJeRU
X-Received: by 2002:a05:620a:4804:b0:8f4:3bb0:ca7 with SMTP id
 af79cd13be357-8fa88942d82mr307558285a.37.1777538737220; 
 Thu, 30 Apr 2026 01:45:37 -0700 (PDT)
X-Received: by 2002:a05:620a:4804:b0:8f4:3bb0:ca7 with SMTP id
 af79cd13be357-8fa88942d82mr307555485a.37.1777538736651; 
 Thu, 30 Apr 2026 01:45:36 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f93fc68102sm372044485a.34.2026.04.30.01.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:45:36 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:45:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 3/4] hw/char/serial-isa.c: declare IRQ as shared in
 ACPI IRQ descriptor
Message-ID: <20260430104534.0fa36276@imammedo>
In-Reply-To: <20260311162605.2976339-4-mark.caveayland@nutanix.com>
References: <20260311162605.2976339-1-mark.caveayland@nutanix.com>
 <20260311162605.2976339-4-mark.caveayland@nutanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 11 Mar 2026 16:24:28 +0000
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> From Windows 8.1 onwards ISA serial IRQs cannot be shared when ACPI Revision
> 5.0 is used in the FACP table. The reason for this is that if a 2-byte IRQ
> Descriptor is used then the interrupt is considered to be high true, edge
> sensitive, non-shareable. Since legacy serial ports COM1/3 and COM2/4 share
> an IRQ then if more than 2 serial ports are added, Windows indicates a
> conflict in Device Manager and these combinations cannot be used together.
> 
> Change the 2-byte IRQ Descriptor in the _CRS resource to a 3-byte IRQ
> Descriptor indicating that the ISA serial IRQ is low true, edge sensitive and
> shareable. This enables all 4 legacy serial ports to be used in Windows without
> conflict.
> 
> Note that it was agreed during the list discussion that this change does not
> require a compatibility property since it is not part of the default machine
> configuration and was already broken.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/char/serial-isa.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
> index a4be0492c5..686336f34f 100644
> --- a/hw/char/serial-isa.c
> +++ b/hw/char/serial-isa.c
> @@ -92,7 +92,8 @@ static void serial_isa_build_aml(AcpiDevAmlIf *adev, Aml *scope)
>  
>      crs = aml_resource_template();
>      aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x00, 0x08));
> -    aml_append(crs, aml_irq_no_flags(isa->isairq));
> +    aml_append(crs, aml_irq(isa->isairq, AML_EDGE, AML_ACTIVE_LOW,
> +                            AML_SHARED));

this combination looks wrong,

ACPI 5.0, 6.4.2.1 IRQ Descriptor
Note: This descriptor is meant for describing interrupts that are connected to PIC-compatible
interrupt controllers, which can only be programmed for Active-High-Edge-Triggered or Active-
Low-Level-Triggered interrupts. Any other combination is invalid. The Extended Interrupt
Descriptor can be used to describe other combinations.
>  
>      dev = aml_device("COM%d", isa->index + 1);
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));


