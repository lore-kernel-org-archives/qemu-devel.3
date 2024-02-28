Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E61FC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfICs-0001bU-5o; Wed, 28 Feb 2024 06:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICp-0001ZM-1r
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:35 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rfICn-0007J9-H6
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:34:34 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc13fb0133so40056635ad.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709120072; x=1709724872;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qNr8IpM/BgnyhwNeoHVIpQAv1RPcCThHB7TyMR3DGSw=;
 b=A3kZ2QibxYblQXm9M0N4hJrEpJ+5o2iXvz8GymQnAHtCjNH8AGhdB6h1/vQEpFiAM8
 5s4Gw02mSXaEmhrXGG52Qn8otKFL21JraUwrf89Ua0V6QtLrBYCJxCO95EFqFfIdR9Jl
 DHvMJepYpH0PttEGW1J9fAl0mkYOi7WGhmp3xjqkaVSlUESx00HSLTVeO4D2INkbvPHQ
 Ds0f74AOnXI0bUj1WtusoXayPvSzqUA74riZkcV5TXr2hLsT7pAEHpWVJxQAtsPXuWSq
 Y9zUurnWD8sa+weitYVY9xnWqZ5P4qfAUE2WfmRvFK09jtvuht3kLKLX/mKCw+OpuzP2
 mNGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120072; x=1709724872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNr8IpM/BgnyhwNeoHVIpQAv1RPcCThHB7TyMR3DGSw=;
 b=iMH9+mSX9Js65PGVUTcBqzsnf90BIGK4DnkcKEg3wvKDh3s0JEDBD/HHzjlSLxiNDS
 p0nqRNIXmFXspz90PevjJi3dSDW3jGcH8/SP6mn2Wa15Zn1rHDvpu+GA814G4J+i0byj
 +JwZLuHHQZjOo/cN9g4gEgLHdG8VM9zQjigiZn0ZVVHu3qHQ7ijMsEc/TsMwXCJ2BeI1
 RkYbNnwr7Lkx+4tFMuJ0dtaxCe5O49PmIHclNEu2JB3Z2TmgXT8mSVmBXv088VLuy2k6
 z70sRQ4nT4gc5rUdgsSSbRugZJiscJ0F9fcaYMri/Pj3dFFPL7RJ/gkeIZly983vzWuv
 O1NA==
X-Gm-Message-State: AOJu0YyBHcgLjUnRbZYhuHldUK0Re5IymlYRVXSlspxXPse235UnAlMp
 UC5wbzUCUgHikJChozl1S0PGpLAilh7RcSIbxB4SCoc6LedUFNmafuwosIiy6Fs=
X-Google-Smtp-Source: AGHT+IHaAr/9NqHn6dDudsu1a1zHBCsel/s503fgNIlr42wrMSR+AMGskRjwZnf8+gSw3AryNnytOA==
X-Received: by 2002:a17:902:700a:b0:1db:cfa0:4045 with SMTP id
 y10-20020a170902700a00b001dbcfa04045mr11172426plk.60.1709120072031; 
 Wed, 28 Feb 2024 03:34:32 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 kb16-20020a170903339000b001d94e6a7685sm3118049plb.234.2024.02.28.03.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:34:31 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 28 Feb 2024 20:33:24 +0900
Subject: [PATCH v8 13/15] hw/pci: Use UINT32_MAX as a default value for rombar
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-reuse-v8-13-282660281e60@daynix.com>
References: <20240228-reuse-v8-0-282660281e60@daynix.com>
In-Reply-To: <20240228-reuse-v8-0-282660281e60@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently there is no way to distinguish the case that rombar is
explicitly specified as 1 and the case that rombar is not specified.

Set rombar UINT32_MAX by default to distinguish these cases just as it
is done for addr and romsize. It was confirmed that changing the default
value to UINT32_MAX will not change the behavior by looking at
occurences of rom_bar.

$ git grep -w rom_bar
hw/display/qxl.c:328:    QXLRom *rom = memory_region_get_ram_ptr(&d->rom_bar);
hw/display/qxl.c:431:    qxl_set_dirty(&qxl->rom_bar, 0, qxl->rom_size);
hw/display/qxl.c:1048:    QXLRom *rom = memory_region_get_ram_ptr(&qxl->rom_bar);
hw/display/qxl.c:2131:    memory_region_init_rom(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
hw/display/qxl.c:2154: PCI_BASE_ADDRESS_SPACE_MEMORY, &qxl->rom_bar);
hw/display/qxl.h:101:    MemoryRegion       rom_bar;
hw/pci/pci.c:74:    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
hw/pci/pci.c:2329:    if (!pdev->rom_bar) {
hw/vfio/pci.c:1019:    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
hw/xen/xen_pt_load_rom.c:29:    if (dev->romfile || !dev->rom_bar) {
include/hw/pci/pci_device.h:150:    uint32_t rom_bar;

rom_bar refers to a different variable in qxl. It is only tested if
the value is 0 or not in the other places.

If a user explicitly set UINT32_MAX, we still cannot distinguish that
from the implicit default. However, it is unlikely to be a problem as
nobody would type literal UINT32_MAX (0xffffffff or 4294967295) by
chance.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 84df07a2789b..cb5ac46e9f27 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, UINT32_MAX),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,

-- 
2.43.2


