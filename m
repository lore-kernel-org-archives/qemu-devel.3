Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3C2CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvx7-0008VL-GC; Tue, 09 Jun 2026 08:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWvx6-0008VD-PI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wWvx4-0000kY-V4
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781009585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMMwEgErShRBIb55CFP/isB4KLkQHr5YpWFsXpTjQ8Y=;
 b=LeEDTP6yGncdUCen/esTgrdY+LHRPYbmxTEnaWwP77r7fjUPA4j+zOm43SVGiIEAcD1TNa
 l/vzXgviDApJosyB/1PC3lWqbtQ44B0uMPBuOCuDttTyHtqBq5X/6ErQITYWt+1AhWsgFB
 QLoP2AdvE+I/KbSEqbiWLRmnsEOz4K0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-hAEAD6tbOl27Awn43_PWDw-1; Tue, 09 Jun 2026 08:53:03 -0400
X-MC-Unique: hAEAD6tbOl27Awn43_PWDw-1
X-Mimecast-MFC-AGG-ID: hAEAD6tbOl27Awn43_PWDw_1781009582
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so29468795e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781009582; x=1781614382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMMwEgErShRBIb55CFP/isB4KLkQHr5YpWFsXpTjQ8Y=;
 b=sNRyMQGDlSqnM2hJGYcv+o4QI/1roLI6UBIMXwa6DgtY+Ml18UbJXWmf1+Ltj7RgE6
 lXu8ELElOLHS7nyOLggnaj5QZtd6xsfWAlyhgJz/hCJ3khzBbauHQ3LoZnerWGQCAwKY
 PiTwobp53Ev0XTJMNpQwajdKJLyu9OEq5vchzxR0V/8/YsdmtRO4meNwX4VbZ769gjBL
 +UBCH39tonGPu+hvYGMJhyhiz2qbXVa6QbHLLwNJ1btaQ7OzInd8mQWUtfIjC5W9ls/Y
 9FbE0ov+miKwJq7gzNW9qEKm8PJty+df0YhVZDX7UCtD/Nyn+5feWF4ajXVznhsccB1j
 Cc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009582; x=1781614382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kMMwEgErShRBIb55CFP/isB4KLkQHr5YpWFsXpTjQ8Y=;
 b=hxsh9bTJKh//vmBy18aIUqqdGXuZqo7A4upi5sGAT8cdxrxIdSDCHKqrFctjHphpIh
 dHwPAMkebYKbe1Lz6IgUjf6ZMbW+kzSzPH0Gc4TywayuhAyj3gyF0GtacsAc3tGclCgQ
 YbcF0VPE8B9FbB2DundzrC82DHYnr2gGvEO+8eN5Dre4qP9FOXH7fsEnjFz33k+fAfkY
 XVHsCOSyh8/iG7SVHb3pEiYU+lUPPguhr6iEC77LRL/a12Wj5KytfO3/gCl9MLo3q63K
 AaFpY3s8fNv3O9A/q4z0d2hQ1U2KIi6XG511Ra8ony7aY5pfalNDocT8K+B0TJM2AJzo
 /P5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/akWxawfAqP/odjgcFbeTxoBv/CrG/djKuUGlH1OqRZTagaAip0NW00F2nOx2gDilqEuyPjbq5CqYW@nongnu.org
X-Gm-Message-State: AOJu0YzMAw/Xzpy0raDhs1kWYgu0NjQZkWOn7fl0xyXeya0slYURHHRN
 MuOFtDHkX9VMtDazCOS/5qnrzhRsav4Lh7dC8I5/OtdAB3RiUGhw7wy6wHr3iLFrtP2gWRrRtcL
 1+iHDeAEt5SzSpRNfdJFZNQVefjqKss6dM1krPu1ay6HB05OE6o739w/8
X-Gm-Gg: Acq92OGv2odRvwnHR4MYjkB9wvY/CY+DRO1GX4+w1aTZTl3uv/btgkqqFdCQlmHpEcy
 PVtcss3W9pXIuM7V0/jer/eZJ00DJxaJt6BQyykfOES/QkFC2FNQ7yYEbYUokSlvhsrEPIoQNG+
 kV1KC202HMM9sEtq/rxI1h0UekzOeUxDrUbgy7sSU8lxIRp0e5A+PLuXO/8jlU5xbLecqLvu4im
 JkKSuB6VQSmOqAXgnAPuE3cGcCOBWKFF4u5nkg9wk5fcCkPOmvRV/6aLlUHfqgMYM7A++28f3Gn
 hDupQp3KmGOaQkxpYYN1qGFxnmmMYKrOePXOYw+6zJfHV4M1wGB5S2ZRyChit0xa3B6RBUdLSkC
 1xhcr0gUkzl5NY5x8
X-Received: by 2002:a05:600c:4689:b0:490:bbc1:c9be with SMTP id
 5b1f17b1804b1-490c2c63f53mr250216215e9.0.1781009582361; 
 Tue, 09 Jun 2026 05:53:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4689:b0:490:bbc1:c9be with SMTP id
 5b1f17b1804b1-490c2c63f53mr250216095e9.0.1781009582018; 
 Tue, 09 Jun 2026 05:53:02 -0700 (PDT)
Received: from imammedo ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35eae5sm62640530f8f.33.2026.06.09.05.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:53:01 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:52:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Leonid Bloch <lb.workbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/8] hw/acpi: Support extended GPE handling for
 additional ACPI devices
Message-ID: <20260609145259.680fae5a@imammedo>
In-Reply-To: <20260526042928.9203-2-lb.workbox@gmail.com>
References: <20260526042928.9203-1-lb.workbox@gmail.com>
 <20260526042928.9203-2-lb.workbox@gmail.com>
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

On Tue, 26 May 2026 07:29:20 +0300
Leonid Bloch <lb.workbox@gmail.com> wrote:

> This patch extends the GPE (General Purpose Event) handling to support
> the maximum number of interrupts available based on the machine's GPE
> register length, rather than being limited to the first 8 bits.
> 
> This change is needed to support additional ACPI devices that will be
> introduced in subsequent patches (Battery, AC adapter, and button devices).
> These new devices require GPE event bits beyond the first 8, which were
> previously not being properly handled by the event sending and SCI
> (System Control Interrupt) update mechanisms.
> 
> The actual number of available GPE interrupts varies by machine type:
> - PIIX4: GPE_LEN = 4 (32 bits total across status and enable registers)
> - ICH9: ICH9_PMIO_GPE0_LEN = 16 (128 bits total)
> 
> The patch modifies:
> - acpi_send_gpe_event(): Now properly propagates status bits across all
>   available GPE registers based on the machine's gpe.len value
> - acpi_update_sci(): Checks all GPE registers for pending interrupts,
>   not just the first byte
> 
> Note: A future enhancement could refactor the GPE handling to use the
> bitmap API from bitops.h instead of the current manual bit manipulation,
> which would provide a cleaner interface for these operations.
> 
> Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
> ---
>  hw/acpi/core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index a6a62a742d..ad7abe568d 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -733,19 +733,32 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
>  void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>                           AcpiEventStatusBits status)
>  {
> -    ar->gpe.sts[0] |= status;
> +    int i;
> +    AcpiEventStatusBits st = status;
> +
> +    for (i = 0; i < ar->gpe.len / 2; i++) {
> +        ar->gpe.sts[i] |= st;
> +        st >>= TYPE_WIDTH(ar->gpe.sts[0]);
> +    }

Function is ever called with only one bit set at a time.
I'd suggest to add assert to guard for multiple bits and
use existing bitops instead of open-codding the loop.

>      acpi_update_sci(ar, irq);
>  }
>  
>  void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
>  {
>      int sci_level, pm1a_sts;
> +    bool gpe_sci = false;
> +    int i;
>  
>      pm1a_sts = acpi_pm1_evt_get_sts(regs);
>  
> +    for (i = 0; i < regs->gpe.len / 2; i++) {
> +        gpe_sci = gpe_sci || !!(regs->gpe.sts[i] & regs->gpe.en[i]);
> +    }
> +
>      sci_level = ((pm1a_sts &
>                    regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED) != 0) ||
> -                ((regs->gpe.sts[0] & regs->gpe.en[0]) != 0);
> +                gpe_sci;
>  
>      qemu_set_irq(irq, sci_level);
>  


