Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09A9CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 13:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWC1-0003F0-Sd; Thu, 14 May 2026 09:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNWC0-0003Es-Qf
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:33:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNWBy-00015C-IR
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778765613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWNhLNgr5RJQJK4/0Zw8kNEXpZ0oXxc7DJ6fqqj2Nbg=;
 b=erCyCPO6qD9/8jEy15APPFQd6gLyNGB75i1GW/D30gguazzkknzS0s+RTJMET8lHLuLyBX
 idFPy0+d2msj/5RbkRojREmi47upnuCsWYHeS9w8/n3TwYWFk+ICth721ZDVBo5EbLsGKb
 BEwcJntCnXVmdSfXwzTI7vw2IXjwThA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Lyc5oSv0OGyLa_qmAOiUjQ-1; Thu, 14 May 2026 09:33:28 -0400
X-MC-Unique: Lyc5oSv0OGyLa_qmAOiUjQ-1
X-Mimecast-MFC-AGG-ID: Lyc5oSv0OGyLa_qmAOiUjQ_1778765607
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45d95cba6f1so672913f8f.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778765607; x=1779370407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWNhLNgr5RJQJK4/0Zw8kNEXpZ0oXxc7DJ6fqqj2Nbg=;
 b=TtUkL/2SmSryRR+XB1V12wtH+cyQSJ36QaRDIhjvIozcHah0vJMuUslVyFDfy6HkpL
 kHco6Y57GI0GPyI0vVhE43JEea7PLVr7JfRqnyAQZCQEpDDfqIdrJ/LbItNOsmO2W0WE
 ZgLQwirH8ozkTsXabM+6RYhCg+c050g9fCSPbjHAihHuT5bEOKIotQ8BB70rohVwhk0x
 CyUIaQ9QXp9kEcYXQmn++jNBBVPkwRenO4kBn9SNACvU4U8TXlBKMWQw+BCbhoSwWPYX
 9gX3U9eBBUjf0Mt0dOBgw+x7QBUjHasQS19qHDfNsUbPU2i4Yo6LLMdE0/2Ql+Lp/jGK
 o7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778765607; x=1779370407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RWNhLNgr5RJQJK4/0Zw8kNEXpZ0oXxc7DJ6fqqj2Nbg=;
 b=GkufavrhCn8pvMjUtx3BZ9pgzW3WTsHs6W3S4KjDJRA2lNZjSNSjBTnvziJUixcWX5
 cDGbW+eMMtDvvO1At24/y6ii209ttgpFmVDSFAY5pnadmocxza9kodtBIjzL5Fg2cCqP
 jY0Z1Mc7gMW40lIYC/5WxCJg7oDGhStOTSIncZ64Rt58h1PvrhGICWssvM9RVXGMDJ/W
 D5ucdeut/nK3LEctcezI0ijKjgwDbhlkqNo6rZdrcMc5Zbc/ehHvz/gaGZmDmaLOL4qZ
 iN2IfYs6vIysPsg80D3dmGdwE76KzZN2pXZ+b2noKWap+WU+8FjH54UxCUf+4eoWvalH
 ja6w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ccEyYQ+xg5G7v9+af29Acv8zXVtHcjPaTtpCMSKFRQMF7p1DjaIwdZdD7dQzZ2l9LQnHbH398aMG4@nongnu.org
X-Gm-Message-State: AOJu0Yzej2lrnqO8GhjEyCeOtW2zPhYZs5ehDJv2YQuMEXibyqscDmt+
 TmWEwDYHbZcEPuZFQB+PXeQLlPXtbaZxyCkR0jcMp9E+MIxxBPkUSDTlY534QV/A4v0Af1t+mbX
 jBffoCK7JtI/CKRBe3M9cg5mnPJN508IxXf+wrmcQGx9ccNbQYlFStCYJ
X-Gm-Gg: Acq92OGkoEtsOV/p9/1ricxUt08I8bojI68nMtIL7tjwlFDllPY/8Qi8CuNnaqM0Dcq
 QVsbsuLPNH1y/aZLLHADWQ14XDCecdIinVsguPUbtBlPaUEYearA/U8bhrAETlHwCVhxhpHfGJP
 Ew47gKZYD2LN5s8V+Xa0x/Gc7XGiwB/zXCe/HGRV2KlZ+sVGTWX82t50WTzDn1qXlwbpEktgq3S
 4cw53bv/0vmDp6YCxMfHFHqODsXxjXypQ/t2ub/hG9SxK2RkpGbu0GydQJRrGFl4POPoNJNOCoI
 ltTvyunKYzkHN4K8l811mHSW0wFQU7cNT9STlNI/uUertZv9CW8y8GuelsRGKiulSA82lw15jOv
 SlO17DA==
X-Received: by 2002:a05:6000:2486:b0:439:c299:4d8f with SMTP id
 ffacd0b85a97d-45c57bf958emr12875588f8f.17.1778765607314; 
 Thu, 14 May 2026 06:33:27 -0700 (PDT)
X-Received: by 2002:a05:6000:2486:b0:439:c299:4d8f with SMTP id
 ffacd0b85a97d-45c57bf958emr12875547f8f.17.1778765606921; 
 Thu, 14 May 2026 06:33:26 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm6911343f8f.22.2026.05.14.06.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:33:26 -0700 (PDT)
Date: Thu, 14 May 2026 15:33:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/4] hw/acpi/aml-build.c: add aml_irq() representing
 the 3-byte IRQ descriptor
Message-ID: <20260514153324.7ff20b8e@imammedo>
In-Reply-To: <20260508101901.930781-2-mark.caveayland@nutanix.com>
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
 <20260508101901.930781-2-mark.caveayland@nutanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri,  8 May 2026 11:17:40 +0100
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> The existing aml_interrupt() uses the Extended Interrupt Descriptor to store
> the interrupt information, however newer Windows will only parse the
> standard IRQ Descriptor when enumerating ISA serial ports.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

with nit below fixed:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/acpi/aml-build.h |  2 ++
>  hw/acpi/aml-build-stub.c    |  6 ++++++
>  hw/acpi/aml-build.c         | 25 +++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index e70e0643b1..eaff025d26 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -343,6 +343,8 @@ Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint16_t max_base,
>  Aml *aml_operation_region(const char *name, AmlRegionSpace rs,
>                            Aml *offset, uint32_t len);
>  Aml *aml_irq_no_flags(uint8_t irq);
> +Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
> +             AmlActiveHighAndLow high_and_low, AmlShared shared);
>  Aml *aml_named_field(const char *name, unsigned length);
>  Aml *aml_reserved_field(unsigned length);
>  Aml *aml_local(int num);
> diff --git a/hw/acpi/aml-build-stub.c b/hw/acpi/aml-build-stub.c
> index 89a8fec4af..3180c7c962 100644
> --- a/hw/acpi/aml-build-stub.c
> +++ b/hw/acpi/aml-build-stub.c
> @@ -67,6 +67,12 @@ Aml *aml_irq_no_flags(uint8_t irq)
>      return NULL;
>  }
>  
> +Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
> +             AmlActiveHighAndLow high_and_low, AmlShared shared)
> +{
> +    return NULL;
> +}
> +
>  Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,
>                     AmlLevelAndEdge level_and_edge,
>                     AmlActiveHighAndLow high_and_low, AmlShared shared,
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 7edc8aed42..3aaf96c2a7 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1061,6 +1061,31 @@ Aml *aml_irq_no_flags(uint8_t irq)
>      return var;
>  }
>  
> +/*
> + * ACPI 1.0b: 6.4.2.1.1 ASL Macro for IRQ Descriptor
> + *
> + * More verbose description at:
> + * ACPI 5.0: 19.5.63 IRQ (Interrupt Resource Descriptor Macro)
> + *           6.4.2.1 IRQ Descriptor
> + */
> +Aml *aml_irq(uint8_t irq, AmlLevelAndEdge level_and_edge,
> +             AmlActiveHighAndLow high_and_low, AmlShared shared)
> +{
> +    uint16_t irq_mask;
> +    Aml *var = aml_alloc();
> +    uint8_t irq_flags = level_and_edge | (high_and_low << 3) |
> +                        (shared << 4);

I'd add here an assert for invalid level_and_edge/high_and_low

> +
> +    assert(irq < 16);
> +    build_append_byte(var->buf, 0x23); /* IRQ descriptor 3 byte form */
> +
> +    irq_mask = 1U << irq;
> +    build_append_byte(var->buf, irq_mask & 0xFF); /* IRQ mask bits[7:0] */
> +    build_append_byte(var->buf, irq_mask >> 8); /* IRQ mask bits[15:8] */
> +    build_append_byte(var->buf, irq_flags); /* IRQ flags */
> +    return var;
> +}
> +
>  /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
>  Aml *aml_lnot(Aml *arg)
>  {


