Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5A1C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 13:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBsS-00048t-3Q; Wed, 14 May 2025 09:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uFBqu-0000sW-E2
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uFBqs-0000il-2Y
 for qemu-devel@nongnu.org; Wed, 14 May 2025 09:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747228126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjvPFTZxlUTCgxQgiB+/awojF3gbVDt0w+ZaWf8Kprk=;
 b=YUvRcQ7kK4Z3gd+ThwgjJWB1OI5k/9YC0zVYb8Vmhy2Tp0tmkH+BiKKeJ26KJ+8t5tY+/w
 MxAeiX5eUfXEKq2DvM+ONPpHY299jRh4oO6LR/dlzS1ON/b/exrj/VNZDxeis5y8fUy+Vj
 sV1asYmj8VZDsPFM8puZsXkYFM5DLpI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-nOdf0NAWO3iJs7FOzJVNKw-1; Wed, 14 May 2025 09:08:45 -0400
X-MC-Unique: nOdf0NAWO3iJs7FOzJVNKw-1
X-Mimecast-MFC-AGG-ID: nOdf0NAWO3iJs7FOzJVNKw_1747228124
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-acbbb00099eso620741066b.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 06:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747228124; x=1747832924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjvPFTZxlUTCgxQgiB+/awojF3gbVDt0w+ZaWf8Kprk=;
 b=eQrJ7P/YCvF2d+8sAm31GC0rnWD2f00Jj23s6CbBiT0WwgkUljFkz1YMXTyjKuD0Fd
 7u6yHz7VSj5d6MqFj08KkY/0+JnEwAM0KBZVY8AcuICnVPJScbSM6+ofCMHbtrPf4Paf
 rEZsrbYWKBO2MBxn9pwLKhVzpf/LAJNakojvauFevEnXI16A1JS6O7mVie9wVSENjJL0
 /3TnFBWsv2lN/0WrHg5dXaM2wpGbRELE8ehd5VuaIgYVTL6eSRLIVy5Vt1MQN8GD7pic
 X0nNipxyKZhl/p6Q/kfwnxhdhDwY9t+eo6715F08AKsV0HjrfGpOqy+VBIcVRySxFV8M
 XtcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBLOItp/m4dlCHhp56N3XDKZRut3rALLDQ7MzyrtoTD7q+5GNgSaK2+ZuinlDHtZKIp+XSQNgxGOQm@nongnu.org
X-Gm-Message-State: AOJu0YyyiURLalUo187FNq8RZCg97dXYJ/ny9ydp25+0fcu5gwHRR68A
 Xk5ToWM0p/uTGsqdXjTRg4G4t1X2/qCcbjNMu+o26gEc0JZmqk0ukW/PNI6lX82a31H+lYnLFZh
 DbYcsc2sC8eP1TbYlTGWkOF1eB2JzO3XIkdGo7bSgOb78/cdbgXPNOb9W5SRWGDtZjYJKKS3zlN
 w4NtpUbTGXuXCrHbfaX62wrct1Ofs=
X-Gm-Gg: ASbGncu3cnBgZOWwRpzKKW4FGKHNy1etGHXjdHAVbdjM7rpKXW3sHY6iCZxjp5JYDfv
 AR0eijB2risyKWMywWeu2xkS/Fp4IDYPULibV07aLrOyqBzAOenbEsjqiURX5cvVWyPt8sQ==
X-Received: by 2002:a17:907:7e8b:b0:ad2:5657:3161 with SMTP id
 a640c23a62f3a-ad4f74a836emr371089466b.59.1747228123870; 
 Wed, 14 May 2025 06:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsDNHGfAzkup7t7LmuEjs9mO0TvsN/0cCBnh8QYpnknCDfmai+awibI2DOsk+myFjrs4Vq+fITNPfIB8Zq12Q=
X-Received: by 2002:a17:907:7e8b:b0:ad2:5657:3161 with SMTP id
 a640c23a62f3a-ad4f74a836emr371086066b.59.1747228123483; Wed, 14 May 2025
 06:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-4-zhao1.liu@intel.com>
In-Reply-To: <20250514084957.2221975-4-zhao1.liu@intel.com>
From: Ani Sinha <anisinha@redhat.com>
Date: Wed, 14 May 2025 18:38:32 +0530
X-Gm-Features: AX0GCFvztF3hOmQVCp-L4OH09uBMSDdE9_k3iVSa8ZrM9g2Xy8s75S1BT2Nw-WE
Message-ID: <CAK3XEhPuL8YBdnTekTOBdE09ZegLgpBxHey9iDX61ewj98n1XQ@mail.gmail.com>
Subject: Re: [PATCH 3/9] hw/acpi/pci: Consolidate
 OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 14, 2025 at 1:59=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> The QOM types of AcpiGenericInitiator and AcpiGenericPort are declared
> by OBJECT_DECLARE_SIMPLE_TYPE, which means they don't need the class!
>
> Therefore, use OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES to implement
> the type, then there's no need for class definition.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  hw/acpi/pci.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index d511a8502954..acac6744525e 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -75,16 +75,12 @@ typedef struct AcpiGenericInitiator {
>      uint32_t node;
>  } AcpiGenericInitiator;
>
> -typedef struct AcpiGenericInitiatorClass {
> -    ObjectClass parent_class;
> -} AcpiGenericInitiatorClass;
> -
>  #define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
>
> -OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_in=
itiator,
> -                   ACPI_GENERIC_INITIATOR, OBJECT,
> -                   { TYPE_USER_CREATABLE },
> -                   { NULL })
> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_gen=
eric_initiator,
> +                                          ACPI_GENERIC_INITIATOR, OBJECT=
,
> +                                          { TYPE_USER_CREATABLE },
> +                                          { NULL })
>
>  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
>
> @@ -191,16 +187,12 @@ typedef struct AcpiGenericPort {
>      uint32_t node;
>  } AcpiGenericPort;
>
> -typedef struct AcpiGenericPortClass {
> -    ObjectClass parent_class;
> -} AcpiGenericPortClass;
> -
>  #define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
>
> -OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
> -                   ACPI_GENERIC_PORT, OBJECT,
> -                   { TYPE_USER_CREATABLE },
> -                   { NULL })
> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_=
port,
> +                                          ACPI_GENERIC_PORT, OBJECT,
> +                                          { TYPE_USER_CREATABLE },
> +                                          { NULL })
>
>  OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
>
> --
> 2.34.1
>


