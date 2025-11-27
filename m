Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF76CFD2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOcQA-0005QP-Je; Thu, 27 Nov 2025 08:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vOcQ8-0005QC-C0
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vOcQ6-00004q-AE
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764251542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p1NZI6SfAX7uTI+IbgGu5WcB86gxrOroGxpoqMt+WCo=;
 b=bdn2fZ3gFh8kZtXTEwUCpgBY2X9xYNG1zVMsy/6A7OiFrg27H7d8Q1PYHl42UC4PwIwEdI
 /lmqFF1TRP9T6srezRm5glBl59kn+klnNezSv1zaoBNKqZqcw+JOzY3z3hD1SSRENaTi/O
 JMMij0O7vu0I5ioGrfnjCgHUxi3YNZs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-hTRtIFp6PGOggO2hBbPrhA-1; Thu, 27 Nov 2025 08:52:21 -0500
X-MC-Unique: hTRtIFp6PGOggO2hBbPrhA-1
X-Mimecast-MFC-AGG-ID: hTRtIFp6PGOggO2hBbPrhA_1764251540
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b739b3d8997so63383666b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764251540; x=1764856340; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p1NZI6SfAX7uTI+IbgGu5WcB86gxrOroGxpoqMt+WCo=;
 b=aERKm2bDnYNE35xR3TudeYLN6aipRwV3tn8w1cdynqCLZhfMs4lZJZswz+5j1UbNi3
 wVjErWNvaWQtESF6+27AVpd5+UPsK2DxCOZDSGUpcrXu7TYrosdWQfUDN/UCi+Vnkas3
 7/ocq1F3bQLC2wVdCnRlzCAd07g9FIsOY/4UqOC6n1ODUd0PnHjtS8Yx7MQyPJ0IZYWQ
 zsBV1a2exH22XcspW5udxlHqyLi7JtMnEz9Xn98yeyiPz5FPdhmN5mbyuTB1wIQAQkOJ
 yPhVkhGIm0IT+ICj/gQbflNyDAKzY2AZS6rFyieP0g4ULKLddBnX92Uq3DH9CTtu2GZ2
 Yc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764251540; x=1764856340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p1NZI6SfAX7uTI+IbgGu5WcB86gxrOroGxpoqMt+WCo=;
 b=WlxfFExDoHuErUGR9UyLGRO6nXl3dSQfc5wQkwZSIQtFwZDfq4fF75CKjeCzPaoSkv
 5W5QRj39IHJQG/HzErOURkSGOxhUB8REd+zg78bFKcVfdGk8gZ2H+KDcISUZCYSZLsqd
 ipt6zx568aUCZJEoOxOKBXWytGExG6EKlqZeTYAY3Axe7u8ef4jgRX+xOGi8lpo5zcii
 UXM1CLTymZsCORtwsaOa/LCIwumJdMiX8KKzIwoGQzd+VhgJOn7BYDkJjQWVJpR79KBP
 J1SRlcTUyL4abl8LUNY9jGPtFpIO+LjkDcZxh0h+g+t/RdR5ZeJm/OQ0kBQi6+MiWuRV
 fhMQ==
X-Gm-Message-State: AOJu0Yzs6hWef3vVELiv2Z+GnW7qEVr3zjfZYP6lC90A4bWM5uTJE3nl
 zZUhdIFBljspFOOwXaJFujch0THBev4bIjxFwZEunJLtSFL8VWVPCW4q+9fHcHUiwRayjm/rORx
 +Bvw2znOgCLapop+OQN8SLFcs6TL999fSBz++b4VdkANp321bH2pvISIF
X-Gm-Gg: ASbGncsEDLr02ATO/b/6AfCQD1tp0SNhJOebo8Sa94UO+IHnzL/Oge2jPWUHFb2+8EZ
 EkEmzIDf5R5Nrgvxn8KW7Qmq4+yPkmHu2WEvY2mvUz1D0VcvWXbxkkONADe15jmSzunbPIZ/aTv
 jjOS76PMXt9VhHmA4KUuqVYAcfQcE+QvbOlo4mhk+YcnG+E4hHA0Kcd0Z9p6SKz/x5iRWJq1E9V
 TAHr1Ic8Fg+tMTeO1rdKgjGfmKIx13dOIhi+GBY8SKKWGidmWev+IsSlkgqD7LJsnPx1am1UYcy
 JcrVYeBdxuP7dcRKGTbWJPjiUnI0AYNalfFhAN6p1Tsw7we8fjzkHjdNAJW8pT38AKpunsCPuAg
 =
X-Received: by 2002:a17:907:6e8b:b0:b76:26bc:f95f with SMTP id
 a640c23a62f3a-b76c50c2061mr1134537866b.0.1764251540105; 
 Thu, 27 Nov 2025 05:52:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7StyLXP9pw718sD926ML0fmY84l7ccIMKtDXRIiQDYL7v8frjD9mMXYEbXV36uv98muXhqg==
X-Received: by 2002:a17:907:6e8b:b0:b76:26bc:f95f with SMTP id
 a640c23a62f3a-b76c50c2061mr1134533566b.0.1764251539557; 
 Thu, 27 Nov 2025 05:52:19 -0800 (PST)
Received: from redhat.com ([31.187.78.210]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5a4b762sm168013966b.67.2025.11.27.05.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:52:18 -0800 (PST)
Date: Thu, 27 Nov 2025 08:52:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: AlanoSong@163.com
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, anisinha@redhat.com
Subject: Re: [PATCH] hw/acpi: Add aml_gpio_io() wrapper for GPIO IO Connection
Message-ID: <20251127083441-mutt-send-email-mst@kernel.org>
References: <20251127123602.24478-1-AlanoSong@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127123602.24478-1-AlanoSong@163.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 27, 2025 at 08:36:02PM +0800, AlanoSong@163.com wrote:
> According to ACPI 5.0 section 19.5.54, I add aml_gpio_io()
> wrapper for GPIO IO Connection purpose.
> 
> Signed-off-by: Alano Song <AlanoSong@163.com>
> ---
>  hw/acpi/aml-build.c         | 19 +++++++++++++++++++
>  include/hw/acpi/aml-build.h | 17 +++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 2d5826a8f1..b4dd0bc665 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -962,6 +962,25 @@ Aml *aml_gpio_int(AmlConsumerAndProducer con_and_pro,
>                                 vendor_data_len);
>  }
>  
> +/*
> + * ACPI 5.0: 19.5.54
> + * GpioIo(GPIO Connection IO Resource Descriptor Macro)
> + */
> +Aml *aml_gpio_io(AmlConsumerAndProducer con_and_pro,
> +                 AmlIoRestriction io_restriction, AmlShared shared,
> +                 AmlPinConfig pin_config, uint16_t debounce_timeout,
> +                 const uint32_t pin_list[], uint32_t pin_count,
> +                 const char *resource_source_name,
> +                 const uint8_t *vendor_data, uint16_t vendor_data_len)
> +{
> +    uint8_t flags = io_restriction | shared << 3;
> +
> +    return aml_gpio_connection(AML_IO_CONNECTION, con_and_pro, flags,
> +                               pin_config, 0, debounce_timeout, pin_list,
> +                               pin_count, resource_source_name, vendor_data,
> +                               vendor_data_len);
> +}
> +
>  /*
>   * ACPI 1.0b: 6.4.3.4 32-Bit Fixed Location Memory Range Descriptor
>   * (Type 1, Large Item Name 0x6)
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index f38e129719..f5c0c5886b 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -167,6 +167,17 @@ typedef enum {
>      AML_ACTIVE_LOW = 1,
>  } AmlActiveHighAndLow;
>  
> +/*
> + * ACPI 5.0: Table 5-133 Predefined ACPI Names

what does that have to do with anything?

> + * _IOR field definition
> + */
> +typedef enum {
> +    AML_IO_RESTRICTION_NONE = 0,
> +    AML_IO_RESTRICTION_INPUT_ONLY = 1,
> +    AML_IO_RESTRICTION_OUTPUT_ONLY = 2,
> +    AML_IO_RESTRICTION_NONE_AND_PRESERVE = 3,

these numbers are not from that table.

> +} AmlIoRestriction;
> +

the actual table is here:

Table 6-189 GPIO Connection Descriptor Definition



and there are no names there to not match this enum.

So a better way to do it is different. Pass in u8,
and at the calling site, you add text matching spec verbatim:
	0x1 /* This pin or pins can only be used for Input, and the pin configuration must be preserved while not in use.  */

only use an enum if same value used multiple times.
in that cases, add this comment at the enum values.

but it is important to use spec text verbatim so people can
easily find the relevant spec part.



>  /*
>   * ACPI 5.0: Table 6-187 Extended Interrupt Descriptor Definition
>   * _SHR field definition
> @@ -331,6 +342,12 @@ Aml *aml_gpio_int(AmlConsumerAndProducer con_and_pro,
>                    const uint32_t pin_list[], uint32_t pin_count,
>                    const char *resource_source_name,
>                    const uint8_t *vendor_data, uint16_t vendor_data_len);
> +Aml *aml_gpio_io(AmlConsumerAndProducer con_and_pro,
> +                 AmlIoRestriction io_restriction, AmlShared shared,
> +                 AmlPinConfig pin_config, uint16_t debounce_timeout,
> +                 const uint32_t pin_list[], uint32_t pin_count,
> +                 const char *resource_source_name,
> +                 const uint8_t *vendor_data, uint16_t vendor_data_len);
>  Aml *aml_memory32_fixed(uint32_t addr, uint32_t size,
>                          AmlReadAndWrite read_and_write);
>  Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,


fyi I am not merging unused code. pls make this patch a part
of a patchset using this.

> -- 
> 2.43.0


