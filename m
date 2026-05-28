Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BA4CD5BD1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSWxx-0002mK-9e; Thu, 28 May 2026 05:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wSWxt-0002k6-2m
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wSWxl-0004RX-ER
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779960215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=1vA6MBKntWhNaACiyqSXQMoBAMp+4vKgu8m3XqpJ7s4=;
 b=EUJzxPQrlrnUG68Jl5+okx6EVhDh7kzyO4OLndH8mMe2IVPHSu9p7K2AN1b0ajV9QAQJDA
 26Vx/KBtyH/OfhWWrozCMPeOvPr5udi1+Xoz+9jtEllCzU2Rwea0wpKobcA7F7Bt19O4G6
 1hyl0F/UwgbwNLEapCBKpL8IFWgZfso=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-xN29DgWhMJK9DJWxptgcgw-1; Thu, 28 May 2026 05:23:33 -0400
X-MC-Unique: xN29DgWhMJK9DJWxptgcgw-1
X-Mimecast-MFC-AGG-ID: xN29DgWhMJK9DJWxptgcgw_1779960213
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ed830a0eeso1846639f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779960212; x=1780565012; darn=nongnu.org;
 h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1vA6MBKntWhNaACiyqSXQMoBAMp+4vKgu8m3XqpJ7s4=;
 b=Kzix/vW1SoteYKW7C25QlZ3XGvu/vF7dKIYXiQ58pDrjiaP1QyfIcMp92/Ienpd5a2
 9QXYeKmo/H0axHc2lEFlLYFCrJYkXI6/lRWB8neWuD6EKt0v1nQcp26V54R7FsGU3o3o
 RPwtToo9uaMK9lEVNHQNeEA7rMdwmKbBekmq9fm7WFpDXLH8janSAhCB3MZ8hMJBRzUi
 /9Z2Ao15bNt1Qqn0ZRHnBgBeTCDhvaPLydNAg8/Sncz2EW9WJIJ7njqA4sT5PRYt1HSF
 gsOVnKSH9jGzGS5do2ka+asg2c9ybnfOBvJm10ut0tIIcaz6O2xjH0TAui4Hwwi7QxlL
 i+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779960212; x=1780565012;
 h=mime-version:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1vA6MBKntWhNaACiyqSXQMoBAMp+4vKgu8m3XqpJ7s4=;
 b=bIHBXkBDaOOUCyJhpE5J+dOUPxiXAaXEZocvIgvDBCqRfARaCfe6/kEywKkLVmGeFs
 hJlObwWLI1A/XuPD1Gm2Rt8OEnjgJpREQHto0ba4UDiIJQluC8koeVotZX/V1F4FtHGp
 gzRBE9swFYMkb0uGI+xN8/nff5cwF7fzcuxTaZ/GUTnM8e8NlpxprbKvpNo31SFEYPUq
 smIMDVOmdbQ6rojQHSrW6vxthKi9SRqZNjIQQg4blbIdvgoz1QWiEfu6mVSx6mU/HH/q
 C145Of/xyCeLk5OnE+sucVp8k6gzpKrwf7dYwDJ6mHci4ZsLuypU3H0Njq9vjG6Xw8PY
 vxTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kuUsh0mWjRGToSSBX+h+apRE20Woxuz0/8eD+yj2b4kvTl1syEozZIZn/L61dNeB11Utcqdne6/tl@nongnu.org
X-Gm-Message-State: AOJu0Yz7gWKFf0aTQMvXAO1pRSDqqQUjCTVfWT6yb1stICh0jerQgtRr
 AdsRmYFIcNZjL/wHTk2KCIoWmd6yH1URtT6eS9vZ2IN0DxBM1ir+U9Q7QT9VmPryTFAMdCbfL9f
 eOujaW5jMR9ZqfkPdpjJ3ZOEF2RwOAh1sJ2xebicgLXgeAOEfVvUsIXbK
X-Gm-Gg: Acq92OGLg5XtIsUT7H9AGuf86iGeSuWczVfICeWPUKe3ell1Adco+B9apdLpVW/jAym
 wOmi3z4uKjtrO48FqTS4ElccaoCCel3aG/7Skf2/nxPt3KgbdSv5DRIFCphWyu9QPIlBAIS+/2/
 i61HlnQjdbB7Qz5km8QWtcnn5cfTSJXrqFiLi2HNlPh/mGCBVIoU+urDuUZ78lPgYDkUEV7l+7i
 oFEFycfgHJcMCNc/3GQC5ZCKp7h27bDcxs3D3SPZj6mQx+VbLOjcXqPxrlHBZaBT6DOGklosztQ
 VaoU/pI2FTJy94+YLOeXeLrVPCrj+iDUZMuf94pSL7/CSeN2b9bYoRriuXOKcjrh5QNhXluOzXX
 GAb0BxtWhWAt6lfwIsDtvyAR873BWMOb5R9daYo28wpF6tmNd3b/hcnYpFLDv6mmje1EZCb9BsP
 bUWjZYEg==
X-Received: by 2002:a05:600c:6207:b0:490:538a:9c0b with SMTP id
 5b1f17b1804b1-4907dae371fmr130553665e9.2.1779960212668; 
 Thu, 28 May 2026 02:23:32 -0700 (PDT)
X-Received: by 2002:a05:600c:6207:b0:490:538a:9c0b with SMTP id
 5b1f17b1804b1-4907dae371fmr130553485e9.2.1779960212297; 
 Thu, 28 May 2026 02:23:32 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908f0afc77sm11447935e9.33.2026.05.28.02.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 02:23:31 -0700 (PDT)
Date: Thu, 28 May 2026 11:23:30 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: peter.maydell@linaro.org, mst@redhat.com, Eric Auger <eauger@redhat.com>
cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug
Message-ID: <0de640a2-8807-69cf-4429-672263e3e759@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
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

ACPI PCI hotplug of a PCI device using a bar > 2M fails on ARM
with a resource allocation failure in the guest kernel (Linux):

qemu-system-aarch64 [..] -device pcie-root-port,id=rp1,bus=pcie.0 \
 		    -global acpi-ged.acpi-pci-hotplug-with-bridge-support=on \
 		    -pflash /usr/share/edk2/aarch64/QEMU_EFI-silent-pflash.qcow2

(qemu) device_add pci-testdev,bus=rp1,membar=4M

[   55.106283] pci 0000:01:00.0: [1b36:0005] type 00 class 0x00ff00 conventional PCI endpoint
[   55.107627] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00000fff]
[   55.107864] pci 0000:01:00.0: BAR 1 [io  0x0000-0x00ff]
[   55.108015] pci 0000:01:00.0: BAR 2 [mem 0x00000000-0x003fffff 64bit pref]
[   55.118609] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
[   55.118653] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
[   55.118671] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned
[   55.122828] pci 0000:01:00.0: BAR 1 [io  0x1000-0x10ff]: assigned
[   55.127090] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: releasing
[   55.127098] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: can't assign; no space
[   55.127102] pci 0000:01:00.0: BAR 2 [mem size 0x00400000 64bit pref]: failed to assign
[   55.127106] pci 0000:01:00.0: BAR 0 [mem 0x10000000-0x10000fff]: assigned

This behavior is exactly the same on x86 - except the busses are created
with a default window size of 256M there. If the PCI devices being
hotplugged use a bar > 256M you get the same failure like on ARM.

The workaround on x86 is to specify "pref64-reserve=" for the PCIe
root-port. On ARM this is currently ignored.

The following patch changes ACPI DSM #5 to return 0 (only when
ACPI HP is used) which basically tells the guest kernel to keep
all PCI resource allocations.

------->8
From 92cd64b8398f13e51b67ff8baf62f15cac300c94 Mon Sep 17 00:00:00 2001
From: Sebastian Ott <sebott@redhat.com>
Date: Wed, 20 May 2026 10:39:26 -0400
Subject: [PATCH] hw/arm/virt: preserve config for ACPI PCI hotplug

Change ACPI DSM #5 to return 0 when ACPI PCI hotplug is used
to tell the guest kernel to keep all PCI resource allocations.

This allows to use the pref64-reserve= option for pcie-root-ports
and thus enables hotplug of PCI devices with a barsize > 2M.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
  hw/arm/virt.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b090233893..293a0c2163 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1094,6 +1094,7 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
          pcihp_region_index = sysbus_mmio_map_name(sbdev, ACPI_PCIHP_REGION_NAME,
                                                    vms->memmap[VIRT_ACPI_PCIHP].base);
          assert(pcihp_region_index >= 0);
+        vms->pci_preserve_config = true;
      }

      sysbus_connect_irq(sbdev, 0, qdev_get_gpio_in(vms->gic, irq));
-- 
2.53.0


