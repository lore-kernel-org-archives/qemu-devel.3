Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61C2CA1015
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 13:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu9vA-0007nP-O5; Thu, 04 Sep 2025 09:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu9ut-0007fQ-0Z
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 09:22:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uu9ug-0008G9-Ry
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 09:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756992117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMdKYp0ExpoIDDe8oKKjxqxbbI524M1hFB252dm8wdM=;
 b=I6LBPukE4vzGmMcUQkwXoWjpt79NN5iM8WETUnF0vIBK2TbcEeeMgpnHqoT4JQvZQkrrVR
 jDiolvp2oCfV8w8Fpxnjd8BRhyEP7VBujkiaC9TJ+DKz4OSSmdQINpIy8In0ruSKuv6LeW
 GF1a2EMMHcR/Ii3W6Nua6TzkxSJnky0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-_Ukp740tNiiqQ33CVSycEw-1; Thu, 04 Sep 2025 09:21:56 -0400
X-MC-Unique: _Ukp740tNiiqQ33CVSycEw-1
X-Mimecast-MFC-AGG-ID: _Ukp740tNiiqQ33CVSycEw_1756992114
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b9c1b74e1so6097195e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 06:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756992114; x=1757596914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMdKYp0ExpoIDDe8oKKjxqxbbI524M1hFB252dm8wdM=;
 b=JKk1TFWIqOcpkZkFiVeBMDmYlf5LDc4Y+OG0mb3zq5kA/1KAwQg+aBPKcBxun3FZS5
 DhDWlZaP6Hf+FMM4mkMXhwD7s876uwnI3TeMeGys+3gJ+uXNFli9oC/BfMslxPZ1wRrH
 Dk5uerSo5XHywc+WnBLavDF+65przVuxTfRAERjiKVLdEWh4BPxS4nqjLkqkVylaKN6R
 NEtwKT+tkvy7V+uhavaWr3UIFL+AYt526CYQJFnC4R1pwcbezaBnR4PndhlsXzvUTEV4
 OAvScwwXdt7A2AYxiGmdnccfUnsBKiOH9lGD/k2qy8I6KrFuYdD4Kr1oMT+9X6EWDOua
 8kNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKkHfgtvAl1hioIN4CF/6aTP3DLOAM5h8LeCgXL6OvAd712YyLAJbNqVDq72dxRaW3vasY9qJb9vIe@nongnu.org
X-Gm-Message-State: AOJu0YyfHBuVw1/QhOcL6y1OEwKqAdOSjkjpf/Lq/dHj/2l/Cj6Ekc7v
 qfRIefCOCY+3W8uilsrGv92Mojk1sECGiibFKT5plbqDmH5UO8n9gOlalAF0tjgwxqtrCVXPuL4
 vRhvt9dJeDsncU5jx+vxWHyZn8ofPOCT3YLxyeCQGKKLGHx0G6wzCbsPV
X-Gm-Gg: ASbGncsW3/W7sLTV1Fz7Pd/wrZcl5derk87a7GmMSQx+cE2sA2jokzeooNVglsHZN+9
 Csf8PW0+plMoAiWwTR1KGiXtHzOU2E56XUBOZRwlEBVSg2KDdiEQyAZUlYzX0J+GAPOwgVVWTGw
 5+IHO14n8DsDZs5V/sKK7RihWGlaRh4t9R80o5VpWBL66VWoBtWrtaqQ8F+w11y+s8rLKN2BRwl
 I+zshH144Cc7xeGubHZ4XNqcDEqKpGRHjZB6M9ZZVpj+kT9tFa2PvDDUCv4Ihi9cbx2lrjhgwVK
 SAu3qdtyqU3zJPjztKehi+Kncd+V7g==
X-Received: by 2002:a05:600c:1c87:b0:45b:8b34:3489 with SMTP id
 5b1f17b1804b1-45b9861e89dmr83030105e9.4.1756992114004; 
 Thu, 04 Sep 2025 06:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuhAv+FbXjffw79lvHbN6M0cmbV2EMSJf80grZGR0Q150yWyuNWvJ1vbyAI4CZ1nycPD4E/Q==
X-Received: by 2002:a05:600c:1c87:b0:45b:8b34:3489 with SMTP id
 5b1f17b1804b1-45b9861e89dmr83029705e9.4.1756992113522; 
 Thu, 04 Sep 2025 06:21:53 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab093sm304922735e9.22.2025.09.04.06.21.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 06:21:53 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:21:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Leonid Bloch <lb.workbox@gmail.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Eric
 Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Dmitry Fleytman
 <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/4] hw/acpi: Support extended GPE handling for
 additional ACPI devices
Message-ID: <20250904152150.4e7a1127@fedora>
In-Reply-To: <20250827220054.37268-2-lb.workbox@gmail.com>
References: <20250827220054.37268-1-lb.workbox@gmail.com>
 <20250827220054.37268-2-lb.workbox@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 28 Aug 2025 01:00:47 +0300
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

add after this line a per patch changelog,
describing  what has changed.

>  hw/acpi/core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
> index 58f8964e13..3240ec185e 100644
> --- a/hw/acpi/core.c
> +++ b/hw/acpi/core.c
> @@ -729,19 +729,32 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr)
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
> +
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
                    ^^^^^^^^^^^^^^^^^^^^
           vvvv 
> +        gpe_sci = gpe_sci || !!(regs->gpe.sts[i] & regs->gpe.en[i]);
            once we decided to generate sci there is no need to scan array further
            so drop 'gpe_sci ||' and break the loop in the condition above

> +    }
> +
>      sci_level = ((pm1a_sts &
>                    regs->pm1.evt.en & ACPI_BITMASK_PM1_COMMON_ENABLED) != 0) ||
> -                ((regs->gpe.sts[0] & regs->gpe.en[0]) != 0);
> +                gpe_sci;
>  
>      qemu_set_irq(irq, sci_level);
>  


