Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D042DCD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNY8-0005kk-5l; Mon, 11 May 2026 06:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wMNXn-0005ei-9v
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wMNXg-0000Zw-Kp
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778494035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3xARPOZBMa4JMWXAh+1mMa/W2rdZ/pp3M23ZoELmx1M=;
 b=TixvmAgljSRKuh1NerCvFuGo8ihjR3TzEaNh1SdPsoOKN61566EbKieqR3P1dqHlfB5/CT
 SHzd5AOMNRo9HEbN0zGN7KbngrZBR7zq0bZ9tJ4fko121qvXwBoukiupXVJOJmQ7E8nbGv
 mIM8C6vRp/OhYjVZtz3VJYMemqRtVyc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-xhQpSJRcNuuMytUgBzl51g-1; Mon, 11 May 2026 02:59:27 -0400
X-MC-Unique: xhQpSJRcNuuMytUgBzl51g-1
X-Mimecast-MFC-AGG-ID: xhQpSJRcNuuMytUgBzl51g_1778482767
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8bc5ab12bb5so91728376d6.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 23:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778482767; cv=none;
 d=google.com; s=arc-20240605;
 b=UhpZbpj5OcivUysPqD1OPi8YrjOKCwMa4McMiWAp6zJOkJ95fMLA8jUMqGJlo7mBCQ
 nWS7TD2xqRPe2rCE8Ywsg1CF1uohIsufMcOrFwpwhkVHmBU6WlA5bgPkBeJZsSZGsKmy
 nfsfVvn876sjqQ4cH7DpAu64HjBDMovcQjIO4yAINedMGgMfvmXfl3QVfKFANhUHR6Kg
 ElWd3Y7Jvvtp4vZwYUk0YU3whs3EqbkWh+w4xFQxJXLSpFs16CjGU8QycHb1MMvNpMtQ
 cU6O+DYKOHRERE2cVJN3+Twt0Um5kq6Vjxd9PsQtFCm/eB89Fn1KnknHg2FlHWcqVjCY
 Iw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3xARPOZBMa4JMWXAh+1mMa/W2rdZ/pp3M23ZoELmx1M=;
 fh=G3k45vOq6tGQ1it1xT4L5EuRIfjrG+ZzI0PlARbvKLY=;
 b=fvvHNZFV3g2tHsQxIGqiKJGVaJafrp7ctS+duAHZ4xjgGzvRE5qiF6iD2ajXlLNzft
 nGXttpjDsIlHM4q8SfV5k2Soi3t5J80n0hRobemrLGHL2+3T6GyN+3OVKT8a/ILCkvQm
 jJVtrfoptvSWxG+F2s+h2xn2/kCTrrrBiMTR/QiW1ZcvA6NmLuRkbyh6oyWtRwjOfD5B
 lj0IZjViMQErtFhZPBOfVrF6tCDmnokW9uwbRNpWQ4BsWFtw89dEDOtMxCWxT2QwmHZ2
 qmFYBj3xh1Yv4LR7zzp7eFGl7QWGJmcOyrWHtSf1LIIfcjoQXNGk/bHNBN5OqdNL4vKg
 MImg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778482767; x=1779087567; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xARPOZBMa4JMWXAh+1mMa/W2rdZ/pp3M23ZoELmx1M=;
 b=tFDxzd45ZCTsaO+QKclusxkMk6kAIN0Mq1ExlVGGdcgMFmZm2VYTPdA5oqsUNVa2pZ
 DUZMMdkCIQTkRv2bKNMoVSJFz+g8i3+NT9OpE3QeURAi/s+G20FEQUsQGHXFxwrVhht6
 J+pxYbDonqfHemwEl1NYvDSMAMkhOz8vatYacJm3QvL/Aeu29a12S21kXcEsQ2oA2dEK
 9AExCsZ0jGO+ct8JonRuyBrfyxrOQtc9sNgv4756Pn06HoT7zTzINiWliKbQviD14UwU
 8XhHlnQpfqF5Qn+t1svjG7L7ml1o40kwEYCZBEUArr64k0laUPN7lSv4KFcLQUEtZgh5
 eNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778482767; x=1779087567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3xARPOZBMa4JMWXAh+1mMa/W2rdZ/pp3M23ZoELmx1M=;
 b=JplxQAHhkBBDs9jra1Nw7v/jTuf1ufTivd8lHoNkmCUdSd955EFhJha+7zvuv11WK5
 l4NGHVSXTSzhPGpt9mLB//L+wmq3eSodlnjM5ZBRlLbCmnWqOMYVgGCZagzWs03oJqZc
 Kbtt5FAMe8pu6or7tOh2CmIBzcf+ONSgs86cXYhMXCU6g0TFMuWqnAXCHwUyL37nBGsY
 dxuoAwIgEMCoKy36lzrwFwX75AQ1yCyglNDUMjwoYRCe6qFerzMp2BhMWFn+bPixh+6e
 XJCQM/Fo3z0ehN+ifCvKkDxDcTfRmwCmteT9kz+OQ9TjPka6/UpRPciuDDxI55EQp5M+
 JhVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/z+nRf6fYI/gimUeehPWgFe5FSVOZQnp8vFGDexBu3EBw7krJfWuBp+cfdq+zCS4nC5u1t57C45RIj@nongnu.org
X-Gm-Message-State: AOJu0YyHFxZ6wN3Queiztw8yaueSyArRTlvSKheXeszWhMZ0DLcAxgRj
 v814hPBX+js5w44pbTPtuZxmie1JbpjWYKAG7eBNOS9rgd85C6YBpqe4oj/Jt8NZq/MiIOspJFF
 VKTeBnuXU1y4KG0mEPbsEkP1/3+d/xsGMjDxFYweYlXnCu+nXcUQC3QcxwkY9VhHpcGQIBdDN/L
 0ZpB/P5vSQpo5KKRm6u9WD+urH99wHhCo=
X-Gm-Gg: Acq92OH4eyeJtomfxGRlfUdIMRR5Wnx98/WRPbAKqj4rJOeCVig/wkw5cYTqNKKa0RD
 ZVLLhCpOIFJLuUAKXHPTQmepWHkxo+ARsj9QDLeLfOo+4sD5nRSVeeBoYFmD36LAKPxKSu2o0mz
 96QmYYZwjwHbDFkqcXgr7k4C26RmDh7iAgp0qUurxtnhg3Vn0G4BP/6R66mf4uRM78BPx7tGb82
 8nl8GKnMs+6jdcs1RhnoLhTY7uS+4WjHDwBafNgZfdKSUIQtw==
X-Received: by 2002:a05:6214:46a0:b0:8ac:b5e0:bf92 with SMTP id
 6a1803df08f44-8bc422a61f2mr342201256d6.9.1778482766997; 
 Sun, 10 May 2026 23:59:26 -0700 (PDT)
X-Received: by 2002:a05:6214:46a0:b0:8ac:b5e0:bf92 with SMTP id
 6a1803df08f44-8bc422a61f2mr342201106d6.9.1778482766572; Sun, 10 May 2026
 23:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
 <20260508101901.930781-2-mark.caveayland@nutanix.com>
In-Reply-To: <20260508101901.930781-2-mark.caveayland@nutanix.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 11 May 2026 12:29:15 +0530
X-Gm-Features: AVHnY4J6lHgyoujUeG-4H-mo11SSZx6DvkRFQ9SO6LMOYWjBEz_jN3DuGsDGDlI
Message-ID: <CAK3XEhNHQSkorBUgVrYYzmc8mfxV+cMFrC0+j-pbhcJxG0zCrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] hw/acpi/aml-build.c: add aml_irq() representing
 the 3-byte IRQ descriptor
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

On Fri, May 8, 2026 at 3:49=E2=80=AFPM Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> The existing aml_interrupt() uses the Extended Interrupt Descriptor to st=
ore
> the interrupt information, however newer Windows will only parse the
> standard IRQ Descriptor when enumerating ISA serial ports.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

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
> @@ -343,6 +343,8 @@ Aml *aml_io(AmlIODecode dec, uint16_t min_base, uint1=
6_t max_base,
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
> +    Aml *var =3D aml_alloc();
> +    uint8_t irq_flags =3D level_and_edge | (high_and_low << 3) |
> +                        (shared << 4);
> +
> +    assert(irq < 16);
> +    build_append_byte(var->buf, 0x23); /* IRQ descriptor 3 byte form */
> +
> +    irq_mask =3D 1U << irq;
> +    build_append_byte(var->buf, irq_mask & 0xFF); /* IRQ mask bits[7:0] =
*/
> +    build_append_byte(var->buf, irq_mask >> 8); /* IRQ mask bits[15:8] *=
/
> +    build_append_byte(var->buf, irq_flags); /* IRQ flags */
> +    return var;
> +}
> +
>  /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
>  Aml *aml_lnot(Aml *arg)
>  {
> --
> 2.43.0
>


