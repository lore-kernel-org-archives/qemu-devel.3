Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4B8C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 18:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqFXh-00033e-SS; Thu, 06 Mar 2025 13:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXU-00032h-2F
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:44 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tqFXS-0008WM-2h
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 13:01:43 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-223fb0f619dso20397205ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741284098; x=1741888898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GdJfYXrcqWD3zMkJvz+5nykVW2SM0vZ2bQZguTS5vXM=;
 b=e9KRQO7MrRD6APFW4OWJ16NZoYiFSMWVj/ys2oI3SDbqN19aiACWk7O7ZZJYgNMrBY
 AOStIop8MTNKdC9Jglk0WhOGSG7qWrPT0O/1Z2A0Jb9e4AaxEwTU0v6ZnJhZoPqbOrO1
 gDmBbaO1LTJ1SG8yFD0Gzg8PCC8XDNusGiQ5t/1LeK8K3cSgCfVR6xhN1cyhHvPUNuoH
 FllsdqMDyOma9LkKyu02wTKdtNpvGhH3Ywy6XfNFeXkfDvSIEAundVB9O8PaD5Luib+E
 NyUJaT0XCDIcuSttDIHS8l8ikdN0FvUNU3ncJ8bAYvLXyaSbTShpIRH91qMOeg097MvK
 v84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741284098; x=1741888898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GdJfYXrcqWD3zMkJvz+5nykVW2SM0vZ2bQZguTS5vXM=;
 b=RY9OBPXtQOJkw/f2zEdOk8GAx8x97Ig2gPABwHgARVCuosSaigSEwGsXuoWyKX21k4
 gDMQTXgxT4Z0zv8rOMtVr0c+pQbHbun9NzG5N1/6Z9til0+Am3ICacgCp0uaMyg+UBQ4
 74WMifJe9bWS2DqCzc3D/DURv3SVESpBlQ3OggGsOWOqw7P5AOW72WrN4vtFqU91QV5q
 9R4eLU5CqBwPYPsMlctAlzvNq2lnalWGax25KtKdT0CLKpV0tXq+7hm3uNw/faOXQKwo
 KqHoBclW31nnq5KMhqrQ5jE5d6rnkwT2fSPtXZPMFhrQ9jwjyEyiFwhiAqqdyRSm/m1L
 h26g==
X-Gm-Message-State: AOJu0Yy8ZNePuIAtMpUWxtgbu9MaGwF+ywY7iMbg7s2aGtEy1IVhIv6p
 u2srM+OYAwqS5ml7mhiN93vXWPV4cynQ+ly0RsPns6Hptr5CR2LwNdZQCUKNCw==
X-Gm-Gg: ASbGnctOmmQqLk13pRTVE6JGlBjd3Zi8/97YLNjR/8YlqRRTBqXRilLQtpME/x+uvfO
 eDoqkeMJEvRxdZGSi27bf5/+qaRxzbN6d4kMqz0tgXNCuyspqBbVKkNpMLmIu5Nmc3auJLrrXzJ
 nlsBp93jLvt3kKnS1aCHF/BLIZIlLq8MfYnnKTgFXv9K2hKi1CGdjCaikdr8XENdWpiPeZWzntA
 fYLmlMyBE/RJ2HSXbX5VPhs++pp63a31Db2mA31D/U1BHxievf+qPLTGgu7KXux9HMk2/9M9U5a
 /M0losIdidNYVPzD0PmvcxbCwD5Ez+BI2aLLOeXoSPc2ydxllo+rUWhmng==
X-Google-Smtp-Source: AGHT+IHMT5IBxVOWiMgPmNAcfmnyYrFbvjQ19Z0TcYm62OO67Catwhpcbjs+EmAMlt5fY5LPgWLTvA==
X-Received: by 2002:a05:6a21:398:b0:1f3:36f7:c0d2 with SMTP id
 adf61e73a8af0-1f544c93c57mr622069637.41.1741284098216; 
 Thu, 06 Mar 2025 10:01:38 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af28126db9bsm1338498a12.58.2025.03.06.10.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 10:01:37 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v3 00/10] vfio/igd: Decoupling quirks with legacy mode
Date: Fri,  7 Mar 2025 02:01:20 +0800
Message-ID: <20250306180131.32970-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patchset intends to decouple existing quirks from legacy mode.
Currently all quirks depends on legacy mode (except x-igd-opregion),
which includes following conditions:
* Machine type is i440fx
* IGD device is at guest BDF 00:02.0
* VBIOS in ROM BAR or file
* VGA IO/MMIO ranges are claimed by IGD
* OpRegion
* Same LPC bridge and Host bridge VID/DID/SVID/SSID as host

If one of the condition is not met, the quirks will not be applied.
However, for recent generations, espcially Gen 11+ devices that removed
VBIOS support, not all the conditions are required. For example, on EFI-
based systems, VBIOS ROM is unnecessary, and VGA ranges are not used.

To have better support on newer UEFI-based VMs, this patchset makes the
quirks independent of legacy mode. The BDSM and GGC register quirks are
applied to all supported IGD devices, new x-igd-lpc option for the LPC
bridge / Host bridge ID quirk is introduced for possible Q35 support.
It also prepares for supporting IGD passthrough when it is not primary
display later (kernel change will be merged in 6.15).

To maintain backward compatbility with exising configuration, legacy
mode will automatically be enabled when:
* Machine type is i440fx
* IGD device is at guest BDF 00:02.0
If the legacy mode behavior is unwanted, option x-igd-legacy-mode=off
is provided for users to disable it. Setting x-igd-legacy-mode=on checks
if the condition above are met, and set up all the required quirks.

The default value is x-igd-legacy-mode=auto. When the above conditions
are all met, it acts as before and continues on any error. Otherwise it
is equivalent to x-igd-legacy-mode=off.

When x-igd-legacy-mode is set to on or off, QEMU will fail immediately
on error.

The first 2 patches of this patchset was taken from a previous one,
details can be found at:
https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/

This patchest was mainly tested on Alder Lake UHD770, with Debian 12
(kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
17.0.1081.

Due to I caught COVID these days, I am unable to deliver the proposed
documentation update before QEMU 10.0 soft-freeze next week. Please help
decide whether to make this patch series in 10.0 or next release.

Changelog:
v3:
* Use OnOffAuto for x-igd-legacy-mode option, default is auto, to keep
  current behavior.
* Added a new patch to solve the possible KVMGT/GVT-g fail.
Link: https://lore.kernel.org/all/20250303175220.74917-1-tomitamoeko@gmail.com/

v2:
* Keep legacy mode for compatbility
* Renamed from "vfio/igd: Remove legacy mode"
Link: https://lore.kernel.org/all/20250224182927.31519-1-tomitamoeko@gmail.com/

Tomita Moeko (10):
  vfio/igd: Remove GTT write quirk in IO BAR 4
  vfio/igd: Do not include GTT stolen size in etc/igd-bdsm-size
  vfio/igd: Consolidate OpRegion initialization into a single function
  vfio/igd: Move LPC bridge initialization to a separate function
  vfio/pci: Add placeholder for device-specific config space quirks
  vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci config quirk
  vfio/igd: Decouple common quirks from legacy mode
  vfio/igd: Handle x-igd-opregion option in config quirk
  vfio/igd: Introduce x-igd-lpc option for LPC bridge ID quirk
  vfio/igd: Fix broken KVMGT OpRegion support

 hw/vfio/igd.c        | 529 +++++++++++++++++++------------------------
 hw/vfio/pci-quirks.c |  51 +----
 hw/vfio/pci.c        |  33 +--
 hw/vfio/pci.h        |  11 +-
 4 files changed, 248 insertions(+), 376 deletions(-)

-- 
2.47.2


