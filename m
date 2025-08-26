Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327D7CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 12:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqt5F-0002OY-8A; Tue, 26 Aug 2025 08:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqt57-0002Ns-1W
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uqt51-0003Or-0B
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 08:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756212429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2va58WNzwGcUhbBosBPCNBhe9snKFRLXpDLWuaj5F44=;
 b=FIS23Wk4lqIco8pg3TJXHKYkrfUGFN/expbs+/2Xv6Vh0Da90y4H9GfpIFbfZHAXELuT/e
 hKQE0BgWiS3zWkUFwFwuwLy2sFtwXQbZZBo3aHb4PhFQE2cZ3VMjGxSNz2MQG0ab0CxjE6
 Y9wlTdRSbQ2bmhWXaPoNoZhesRWudPM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510--aVMpSeuNSSUddmx2T6Hsw-1; Tue, 26 Aug 2025 08:47:08 -0400
X-MC-Unique: -aVMpSeuNSSUddmx2T6Hsw-1
X-Mimecast-MFC-AGG-ID: -aVMpSeuNSSUddmx2T6Hsw_1756212427
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a1b0cb0aaso42681965e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 05:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756212427; x=1756817227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2va58WNzwGcUhbBosBPCNBhe9snKFRLXpDLWuaj5F44=;
 b=mFW2hS5LQ2ZOOsi/1sPpbD4oGFiplyubnaIWhMvyLnczbga5Kpj6ZB+r4D8ZZ1vAec
 H2agARVwHYlEFsoz1j/W91uKcKMGoGddV2v0qXBnedGcus+Wosw4z8AI8pZn+1SWffoT
 +M2IOdlzKQHE0KRlHR+Tev2Z/BmGmxt8mGhoNtz940xzaP2JSKC/OL+lkjkcB1QjR+qU
 fXIK6Py1lrvhSStYrMmXU37Gjo/05i1JSomCBeFjDrrfzAXNh5f2SrEjcxhBoZonS04d
 REXlTgO+8LRfEvGYtea16hlJtIsJXmyx8/6HSJo+O7Z5+YTxu8lwFeMK0yJGyFRWHlm8
 9+6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMmxX31e/TRYccPPE2hiyms6aqjZMSvPS/v9bhm7iW1CIqS5MQrnu3xCsNtKrxEwPzFDgyxxV010mq@nongnu.org
X-Gm-Message-State: AOJu0YzpvDvIl3Umf7iHuuwOSOkAaYRouNTztMcFapoFnivxkvkL7NrF
 Ttk8hJkdapzy8rEo72pTCmoaXDzU7I8XhyPAquEjeoG81zo3VCAB5aeQA9iuqMLYfowswqavP5f
 K0bdzL6yPTCwmz4ztf/oazXku5iMBDKBI6m0jlm2FrSq3PONFIjhjusJT
X-Gm-Gg: ASbGnctkcd9vqnDyN7uoRS9dBOi7lZb29PQ5kcwl7jliCP70p+4DzTY5EmPsWXMPNOP
 E0d83oPTLXGUIepQpXuiH0xLHMuf+3hf7ThRFsQPZ2EwEMQXgpWRLj+kiXttdHZKbykRiApqSoZ
 FNijvdrcxfZKfc2JG/TkQDPLNQYWdz64jo+/QbJloxYsSJgdMJhoO6Fo7NnyTMVf2c60GTDtZGl
 NT58hS0TrRakS2lFp3Z9JiYl/cLAGnJlzqkF8xdhZjinlCOXThAbn3642+cUynAuXeXM4SD0Xb8
 2/6BGfvzF4LZMsRR9mFDWfEqBhnZ1g==
X-Received: by 2002:a05:600c:4715:b0:456:13d8:d141 with SMTP id
 5b1f17b1804b1-45b517d2700mr123075975e9.27.1756212426920; 
 Tue, 26 Aug 2025 05:47:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBpJD2/4GY4Zh8t1j3Pk+a0a9D9ONYlebj07538BmZk7zOFqDcN2KJQvmzKg8QqZ3/MbH6TQ==
X-Received: by 2002:a05:600c:4715:b0:456:13d8:d141 with SMTP id
 5b1f17b1804b1-45b517d2700mr123075745e9.27.1756212426490; 
 Tue, 26 Aug 2025 05:47:06 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c9c9324dc9sm7716311f8f.3.2025.08.26.05.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 05:47:05 -0700 (PDT)
Date: Tue, 26 Aug 2025 14:47:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Leonid Bloch <lb.workbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] hw/acpi: Increase the number of possible ACPI
 interrupts
Message-ID: <20250826144704.4c45cb5b@fedora>
In-Reply-To: <20250821174554.40607-2-lb.workbox@gmail.com>
References: <20250821174554.40607-1-lb.workbox@gmail.com>
 <20250821174554.40607-2-lb.workbox@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 21 Aug 2025 20:45:49 +0300
Leonid Bloch <lb.workbox@gmail.com> wrote:

> Increase the number of possible ACPI interrupts from 8, to the maximum
> available: 64 by default.

for piix4 we have 'GPE_LEN 4', which gives us 2 bitmaps (STS/EN) 16bit each.
For ICH9_PMIO_GPE0_LEN 16 => 8bytes/bitmap

so numbers above would vary on used machine type

also commit message should mention why this is needed.

> 
> Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
> ---
>  hw/acpi/core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 58f8964e13..447ff07878 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -729,19 +729,32 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
>  void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>                           AcpiEventStatusBits status)
>  {
> -    ar->gpe.sts[0] |= status;
> +    int i;
> +
> +    AcpiEventStatusBits st = status;
newline here and remove newline above

> +    for (i = 0; i < ar->gpe.len / 2; i++) {
> +        ar->gpe.sts[i] |= st;
> +        st >>= (sizeof(ar->gpe.sts[0]) * CHAR_BIT);
                perhaps use TYPE_WIDTH()

> +    }
>
>      acpi_update_sci(ar, irq);
>  }
>  
>  void acpi_update_sci(ACPIREGS *regs, qemu_irq irq)
>  {
>      int sci_level, pm1a_sts;
> +    uint64_t gpe_sci = 0;
> +    int i;
>  
>      pm1a_sts = acpi_pm1_evt_get_sts(regs);
>  
> +    for (i = 0; i < regs->gpe.len / 2; i++) {
> +        gpe_sci |= (regs->gpe.sts[i] & regs->gpe.en[i]);
           ^^^
           make it bool and then !!(regs->gpe.sts[i] & regs->gpe.en[i])

> +    }


or maybe instead of opencoding bitmaps, use bitmap API from bitops.h

>      sci_level = ((pm1a_sts &
>                    regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED) != 0) ||
> -                ((regs->gpe.sts[0] & regs->gpe.en[0]) != 0);
> +                (gpe_sci != 0);
>  
>      qemu_set_irq(irq, sci_level);
>  


