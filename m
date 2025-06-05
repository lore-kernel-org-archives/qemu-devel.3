Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F12C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 15:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNCJE-0007ID-MD; Thu, 05 Jun 2025 11:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNCJ3-0007Ad-9z
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 11:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uNCJ1-00072g-8C
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 11:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749136498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jCidGWgWn2ryADMpNaK1bwwhGJAeaoXLr8AYUb05Ou0=;
 b=Wp+dVIgAxLWhB778h/xpsGZ24EsqKXY873VBMN3/8ACQ/sCJphJqiSt5NKYEjoaxG8vt0g
 bJBBpAv44W3lZ8RLqReaXrG7aNkHe+YVEyzXYT1KcqDcohE1FsceoA1B4D5SGVSay1DOHH
 M3m6MO+V5BS/f/yNUAvJIg7i+2YiSeA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-MTO0cZrAOV-F9f8Hkcnc8g-1; Thu, 05 Jun 2025 11:14:56 -0400
X-MC-Unique: MTO0cZrAOV-F9f8Hkcnc8g-1
X-Mimecast-MFC-AGG-ID: MTO0cZrAOV-F9f8Hkcnc8g_1749136496
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39ee4b91d1cso1129970f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 08:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749136495; x=1749741295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jCidGWgWn2ryADMpNaK1bwwhGJAeaoXLr8AYUb05Ou0=;
 b=sU95N5wW0xuVxQarQD8BFaO3yuPu6Uy8A3I4iiWpGmBY833Hl+jgUiccGil8iywlcE
 uaYSU1t0HiriWalrLPQFvJBZxE3hzRZLheLEMOpN6JTvYP60f1dVdT338fZ+cvAvJ7r7
 F/aiot3KRZOLyasGJkFvW4+dyXjfiL0wJ5bFawuO9c+mpySkwR449WbhTLSyFQ010tbS
 XmSukkiLH69d4slvH5gJ+YGneT6qtfMxOM0Uk4FRNxslA3lcTzY7hS4UeClayTtDVH1y
 W/W8wWC2kGaHMakgVcR7oNMByBD8YIU0xDf8s+iWDFmz6FQiiNReY7peEPITLVs86OvC
 +BWA==
X-Gm-Message-State: AOJu0YyZ9wlUujw0YdKwsigXZVE0NW4pJpMH+t6a2uF8jLoWN6xKY6/j
 gXdzQtFOWsOEmtCYFMcFXIO3t9xgWcGUudAz6nSszG6b+YrWbRBXEOIxX/3UsiZrjN1PSjspDQC
 AyuV2UsL2z5UDvUxmgYLB3+/LHoEECJFVqupj0PWw30UAQvdeP7Y1hE85
X-Gm-Gg: ASbGncujIMgjlrtC3XWNpdq87OaSQlUxyX8MvlAue+9yrF+Us1BKi+/ZfQ1dPtt34D/
 l9nwJKQZcSqXUqdTafoM0PCFIs3YtYZNxqMWTjidzOXeRvMx2OPWRRZWOgbY0BsIaLXyCbIounw
 KN4SOiSsQAR4Nv560JTUkeDCLo9vrCQZGpRCU3Ec/YVeNF3KtMNdNMpXmxm3Pu+eEMG2yk7wL/P
 qIZkvDq+MGPDIKzlQE0BGeCyLpwuekEMUa+sC+1gW1hFMZd4UGN4PZAVDjPtyjwlURp6B0pn4Mf
 EyJBaQ+ZRxcV0G4/naFgYjtQ7ZKYp2IM
X-Received: by 2002:a05:6000:288c:b0:3a1:f724:eb15 with SMTP id
 ffacd0b85a97d-3a526dd9b8emr3541197f8f.2.1749136495120; 
 Thu, 05 Jun 2025 08:14:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOt2l+v+ODRv/9H3x8lVMQwIBsINZoU63Mhwm5xd+L0ByfnQUy/Jtq8G62V8VdO50+X4ukdA==
X-Received: by 2002:a05:6000:288c:b0:3a1:f724:eb15 with SMTP id
 ffacd0b85a97d-3a526dd9b8emr3541146f8f.2.1749136494620; 
 Thu, 05 Jun 2025 08:14:54 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe73eadsm24423953f8f.41.2025.06.05.08.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 08:14:54 -0700 (PDT)
Date: Thu, 5 Jun 2025 17:14:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q2zDqW1lbnQ=?= Mathieu--Drif
 <clement.mathieu--drif@eviden.com>, Zhao Liu <zhao1.liu@intel.com>, Hanna
 Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 07/18] hw/pci/pcie: Remove QEMU_PCIE_EXTCAP_INIT definition
Message-ID: <20250605171452.6ca919f3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250501210456.89071-8-philmd@linaro.org>
References: <20250501210456.89071-1-philmd@linaro.org>
 <20250501210456.89071-8-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu,  1 May 2025 23:04:45 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> QEMU_PCIE_EXTCAP_INIT was only used by the hw_compat_2_8[]
> array, via the 'x-pcie-extcap-init=3Doff' property. We removed
> all machines using that array, lets remove all the code around
> QEMU_PCIE_EXTCAP_INIT.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/pci/pci.h | 2 --
>  hw/pci/pci.c         | 2 --
>  hw/pci/pcie.c        | 5 -----
>  3 files changed, 9 deletions(-)
>=20
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index c2fe6caa2c6..6c72a61c4b6 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -210,8 +210,6 @@ enum {
>      /* Link active status in endpoint capability is always set */
>  #define QEMU_PCIE_LNKSTA_DLLLA_BITNR 8
>      QEMU_PCIE_LNKSTA_DLLLA =3D (1 << QEMU_PCIE_LNKSTA_DLLLA_BITNR),
> -#define QEMU_PCIE_EXTCAP_INIT_BITNR 9
> -    QEMU_PCIE_EXTCAP_INIT =3D (1 << QEMU_PCIE_EXTCAP_INIT_BITNR),
>  #define QEMU_PCIE_CXL_BITNR 10
>      QEMU_PCIE_CAP_CXL =3D (1 << QEMU_PCIE_CXL_BITNR),
>  #define QEMU_PCIE_ERR_UNC_MASK_BITNR 11
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index fe38c4c0287..36206c77b7c 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -90,8 +90,6 @@ static const Property pci_props[] =3D {
>                      QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
>      DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
>                      QEMU_PCIE_LNKSTA_DLLLA_BITNR, true),
> -    DEFINE_PROP_BIT("x-pcie-extcap-init", PCIDevice, cap_present,
> -                    QEMU_PCIE_EXTCAP_INIT_BITNR, true),
>      DEFINE_PROP_STRING("failover_pair_id", PCIDevice,
>                         failover_pair_id),
>      DEFINE_PROP_UINT32("acpi-index",  PCIDevice, acpi_index, 0),
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 1b12db6fa29..a3969423bd3 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -245,11 +245,6 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset,
> =20
>      pci_set_word(dev->wmask + pos + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_EET=
LPPB);
> =20
> -    if (dev->cap_present & QEMU_PCIE_EXTCAP_INIT) {

so this one is true by default, and with knob removed
anything inside block should be called unconditionally (i.e. not like diff =
below),
aren't it?

> -        /* read-only to behave like a 'NULL' Extended Capability Header =
*/
> -        pci_set_long(dev->wmask + PCI_CONFIG_SPACE_SIZE, 0);
> -    }
> -
>      return pos;
>  }
> =20


