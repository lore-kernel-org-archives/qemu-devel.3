Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA58AC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 09:19:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiTqa-0004NT-UU; Sat, 11 Jul 2026 05:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wiTqY-0004Mz-KS
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wiTqV-0006OV-VF
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 05:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783761481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hqa3Fti5lDoVW8M1AaaqRu4tCVXidwxyx3HFQzJHhfU=;
 b=YxC0KwLY3K96rcGKBkwNEAr7B6MQPqIHSle8bW1QeJjPAEApHHhtJMkBI9d33MxL8znOuo
 /RLTRS6XDlTTYn/B7u4o3BvV3MCl2RAGwZFRAhSdibpwIQlWSHd6pQxnQqfzTFWaclurMR
 09CziVb7ns2yFl8+Q3LyjLqvkw8piJY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-XqVfm0APPU2Y37EPU2_soQ-1; Sat, 11 Jul 2026 05:17:59 -0400
X-MC-Unique: XqVfm0APPU2Y37EPU2_soQ-1
X-Mimecast-MFC-AGG-ID: XqVfm0APPU2Y37EPU2_soQ_1783761478
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-695bbac451bso2059279a12.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 02:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783761478; x=1784366278; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hqa3Fti5lDoVW8M1AaaqRu4tCVXidwxyx3HFQzJHhfU=;
 b=GrJawlTxofGfSGnao0gYhGAYyAJzbKK4/pXXXicmu46ucmbVKHUoN6h5uGnATNj4rK
 yAQHIkP1weV4p7WcRJ2HoGUfwrqmntHIW5uEGPahFJhF8QgUvE47ERYTXLc/iDejHBSe
 2rn3HR2p/ccPRjMrCaYt3vtwZ7jmfjXlFBnsOf8ZIkbqk0dOlZ3Hbm0mS2Cs0Rpym4wC
 /wHMpMW2N1v8hF6PEgbHYSDhdUpjnChfVW6dy2YUNSzkS+6zzteXy+dzzUj4oaCJ0L9E
 +3DDdonCeAQ8oW1ie+uF5KhCcBuTQ/h41BvakBR8Zm92eOQnO7ebKF4XUUliErw0XK31
 OGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783761478; x=1784366278;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hqa3Fti5lDoVW8M1AaaqRu4tCVXidwxyx3HFQzJHhfU=;
 b=adSX3wUM6J9bCkwqDrcQALZgffAHk4jhnDurXxMg2JO0EDPx8+FE15Xq4ggzFM9kxQ
 SzrBOL8P/NYtL0EostzFuGW+RO6WoC4zo/w4MTxgBt33HwsOxyZyP0JBC2EMD3ttqtUk
 q2ztN8/5Rhd+cZ969ESYwYBMLPeg5qAFARCB9aSzWzSiHxlYPQ8pOPY+n3PpSx1JShdm
 J5eHGGUz1+AhMbVnKHNGPKKpw4kXdbzEWagjwmAo6fFdjJTvfTjlgzi4XZMsnUxbDQIR
 Qgd6L74q8znUqRiiNSHEuCaSeEfILIKIE7Myc4xAPv3SOkNnh3ZMR4qgcGdqnqqYJh41
 16bQ==
X-Gm-Message-State: AOJu0YythLZqrGC7LQV/h/RZ5CYW1iI1ibDAs3OViCdYiHk75fulTONH
 SeBX83To+zcgelsqGyw+jFgEK8dT+1RYWr9KarRHaDRsbwlovdrY6kxnpF7pLuHftdWIcSO9PM5
 sKvGhukoP/iBR1EUPrxKF+C8wryPXMyb0qWAmizd0QqTsLehW9hsubL+I
X-Gm-Gg: AfdE7cmFcGnc02sX+qgpf9DUP/UuwL5JOciuKkK+jaHTsRO50/qCEe5FiSUqW9gjFNN
 X8AUlv7rbLIPDHN77ZDxHKMnVCK9r0lJFaCspTEoUvnWyEZuOJ5lUZw45FfavzdQohRlFlzL8+l
 9vRvHWEJOM55juiG6xRVmsOszdYMZEMIY10wViNnMUYYDJY5JvVEMxiV3LDYPryGljrvbCNAVMT
 donWBIoNtXOwuDE5WxXcaF9W0bBs1gyDRP7dr0kcuJ99QPbPsfDtev7dE95KOQseGCh8dwa8HoX
 isCLYdQDwYvl1MY5AQT2/y/LETFapMZwAXKA+qIz7see2dDfVe09aULcvdhLlwfYL935Z+gBAhM
 GYvfxR0g/c7w5mjrMifOZrNwIa7KZIEeNupncER8zxQ==
X-Received: by 2002:a05:6402:1e8c:b0:697:8d48:7fa7 with SMTP id
 4fb4d7f45d1cf-69c5f2302a5mr1208177a12.22.1783761478225; 
 Sat, 11 Jul 2026 02:17:58 -0700 (PDT)
X-Received: by 2002:a05:6402:1e8c:b0:697:8d48:7fa7 with SMTP id
 4fb4d7f45d1cf-69c5f2302a5mr1208171a12.22.1783761477718; 
 Sat, 11 Jul 2026 02:17:57 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19ce4a60sm11985302a12.8.2026.07.11.02.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 02:17:56 -0700 (PDT)
Date: Sat, 11 Jul 2026 05:17:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dmitry R <rdmitry0911@gmail.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH v1 0/1] Thunderbolt PCIe hotplug layer
Message-ID: <20260711051514-mutt-send-email-mst@kernel.org>
References: <20260710133440.2845828-1-rdmitry0911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710133440.2845828-1-rdmitry0911@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 10, 2026 at 04:34:37PM +0300, Dmitry R wrote:
> This RFC adds a Thunderbolt-flavoured PCIe hotplug layer for QEMU.
> 
> The main goal is hotplug and hot-unplug of real and virtual devices in
> guests where direct hotplug for those devices is not supported or not
> usable.  macOS is the main validation target for this path: the guest can
> observe endpoints through a guest-visible Thunderbolt layer even when direct
> PCIe hotplug for the same endpoint is not usable.


Very happy to see this.


> The series intentionally keeps regular QEMU PCI endpoint devices intact.
> Devices behind the new layer remain normal QEMU PCI devices; the
> Thunderbolt root port controls guest-visible link presence, publishes ACPI
> properties, and emits PCIe hotplug notifications.
> 
> The patch adds:
> 
> * thunderbolt-root-port, creating a thunderbolt-bus secondary bus.
> * thunderbolt-pcie-pci-bridge for tunnelled PCI endpoints.
> * thunderbolt-vga, a separate stdvga-compatible hotpluggable endpoint.
> * README/specs documentation with VGA, USB storage, and NVMe examples.
> * qtest coverage for the Thunderbolt VGA hotplug path.
> 
> The regular QEMU VGA device is not changed and remains non-hotpluggable.
> The Thunderbolt display path uses the separate thunderbolt-vga device type.
> 
> Runtime validation performed so far:
> 
> * macOS guest booted from QCOW2 overlays over immutable base disk images.
> * Thunderbolt VGA hotplug/removal while the standard boot VGA remains.
> * NVMe hotplug/removal with guest driver instance checks.
> * USB controller hotplug, USB storage mount/write/eject, controller removal,
>   replug, and data persistence verification.
> 
> Build/test validation:
> 
> * ninja -C build qemu-system-x86_64 tests/qtest/display-vga-test
> * meson test -C build qtest-x86_64/display-vga-test --print-errorlogs
> * scripts/checkpatch.pl --no-tree --no-signoff on the full diff:
>   0 errors, with expected warnings for MIT inheritance in thunderbolt-vga.c
>   and possible MAINTAINERS coverage.
> 
> Open questions:
> 
> * Whether this should be split into smaller review patches after the overall
>   Thunderbolt modelling direction is accepted.

I'd prefer a split up version, as it is, I'm not ever
sure which part of the  patch does modeling refer to.


> * Which MAINTAINERS entry should own the Thunderbolt PCIe layer.

Are you going to be available long term for review?
if yes you can add an entry with yourself as reviewer,
and it will inherit maintainer from pci-bridge

> * Whether the guest-visible properties are sufficient for non-macOS guests
>   that may also benefit from Thunderbolt-style tunnelling.
> 
> Dmitry R (1):
>   hw/pci-bridge: add Thunderbolt PCIe hotplug layer
> 
>  README.md                                   |  91 ++++
>  docs/specs/index.rst                        |   1 +
>  docs/specs/thunderbolt-pcie-hotplug.rst     |  99 ++++
>  hw/display/meson.build                      |   1 +
>  hw/display/thunderbolt-vga.c                | 275 ++++++++++
>  hw/pci-bridge/meson.build                   |   2 +
>  hw/pci-bridge/thunderbolt_pcie_pci_bridge.c | 156 ++++++
>  hw/pci-bridge/thunderbolt_root_port.c       | 565 ++++++++++++++++++++
>  tests/qtest/display-vga-test.c              |  68 +++
>  9 files changed, 1258 insertions(+)
>  create mode 100644 README.md
>  create mode 100644 docs/specs/thunderbolt-pcie-hotplug.rst
>  create mode 100644 hw/display/thunderbolt-vga.c
>  create mode 100644 hw/pci-bridge/thunderbolt_pcie_pci_bridge.c
>  create mode 100644 hw/pci-bridge/thunderbolt_root_port.c
> 
> -- 
> 2.47.3


