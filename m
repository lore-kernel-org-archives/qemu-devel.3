Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A25C282D1
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 17:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp9xz-0001XD-Jm; Mon, 03 Mar 2025 12:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9xw-0001Ws-LG
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:32 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tp9xu-0000FP-7s
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 12:52:32 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-22113560c57so90796815ad.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741024346; x=1741629146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QZCVkfMaXSFARuIy09spko2Jqzd2Dt5tJP9e/xb2Itc=;
 b=bD9EtZvePk8JUe3Q7usKP8c9fc1L6jJ3n/mpiiOvLntKSj1irE2H0nMiGnn/BAAb+/
 3bOrQDe46kDfQPk08KTH19DEqYz/gIQCSfy5FG1wCGBNDKHy6U5xvVecOGUu9C7RR6Ts
 pARC4NthugGs5TYQmrjq2PTSkTusab5YTSxcM+sRP+uhIEAU7Eqz0Z2PKo1+QY1F9PnM
 90xE+nMzszkafTTUhmiXDO+P+DxsmEYbFlAd7+X+6m8VZACgNNcbVctjfF9p8yBua4w6
 LP2aj/aYSS9YEny5fUmoIv89LPlpnSCpXNkqOQEX+RkMAaqyzpk4w4TM5pV0EM4DICK3
 +ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741024346; x=1741629146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QZCVkfMaXSFARuIy09spko2Jqzd2Dt5tJP9e/xb2Itc=;
 b=nIeSlZaZO3vNBugulq8V3uplbO/mNwYkNx0ipjtT+Sw9cZM47We+nWgUnQ2WzUS1jQ
 lhXItFwZ7/Eadi3USrm0s464f7dv+tTx8QN4OtvyWpF5J9sjma7DVUPgg5IFtBKdqEOb
 JEZw0ZPLeNYLywxoB7pSgyJXZBRsfFdQjuQjWY1L/ZnAf0k/Z6KxVegnjK3GxBfKF0+5
 sZvokBZ0fwlAwVRTE7lQRc7CswgHZEMWP7uYK/sFOzX9pp42tv6ifa8Uou2Fa1ZcvFXk
 0a/sjFdDWUs/J1Rct2XM4WNBCamyC/NPWcnqNwH59Tib53CYHdK4xl5VjEhYpkxDdifz
 J8Pg==
X-Gm-Message-State: AOJu0YxwPk+Nlzc9e7Odpyhd3VLZ4P4spgj1QkqJIovG2oJmkwdCMW6V
 XM9VmQdcAQNth7RP+mXc5464WLbaUnhIrf/eShpcencIgftpzQ4=
X-Gm-Gg: ASbGncv/ZZfqlYHtsT15QBn1Dtaid6BEfQPh5ENXUQ6gNPFfWQtDtWlvzF7ui8xMA7K
 ovLy66ppDNdhnAAXANSRo1+YxxZOz9EippuIAlZxjA8iBYNAtOGJa/BWld3MfRX3iX7Mnp65tDv
 sndwa54igQRS8fNqYF+O9xB/439nVks+sR6N/7YMp/Vq5qDiGuKvuIFL5NrJdTtF48fCZOusu+8
 eKUA5YwOW0o9uChfcEPDL9x9Mx8f1pbncHuWN7rqbeaZz10F4ieNa6rv7LGTdcpV/xE2sKC1SBw
 qwyZn+i3CiJo/e+R7OTZQ+gZO8m6jvVBfL/mvcEqcZhJhKb9DO8Bl+6BzQ==
X-Google-Smtp-Source: AGHT+IFNAvMuI/OCcyBMg5Xzee6nRNDWZTMTS323B3rKU36yl0JoPFFHsp6tBw7weFtXGWkG+ZtZjg==
X-Received: by 2002:a17:903:41d2:b0:21f:35fd:1b6c with SMTP id
 d9443c01a7336-223692596b4mr213439295ad.45.1741024346186; 
 Mon, 03 Mar 2025 09:52:26 -0800 (PST)
Received: from localhost.localdomain ([58.37.175.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2235052beaasm80625535ad.233.2025.03.03.09.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 09:52:25 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v2 0/9] vfio/igd: Decoupling quirks with legacy mode
Date: Tue,  4 Mar 2025 01:52:10 +0800
Message-ID: <20250303175220.74917-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
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
is provided for users to disable it.

Note that a major difference is that instead of simply continues, legacy
mode will now fail immediately on error, this may break functionality,
but the impact should be low as IGD passthrough is not working, and
there would be no display output if it fails halfway.

The first 2 patches of this patchset was taken from a previous one,
details can be found at:
https://lore.kernel.org/all/20250124191245.12464-1-tomitamoeko@gmail.com/

This patchest was mainly tested on Alder Lake UHD770, with Debian 12
(kernel 6.1), Windows 11 (driver 32.0.101.6458) and Intel GOP driver
17.0.1081.

Btw, documentation change would be added after everyone considers the
proposed change is okay.


Changelog:
v2:
* Keep legacy mode for compatbility
* Renamed from "vfio/igd: Remove legacy mode"
Link: https://lore.kernel.org/all/20250224182927.31519-1-tomitamoeko@gmail.com/


Tomita Moeko (9):
  vfio/igd: Remove GTT write quirk in IO BAR 4
  vfio/igd: Do not include GTT stolen size in etc/igd-bdsm-size
  vfio/igd: Consolidate OpRegion initialization into a single function
  vfio/igd: Move LPC bridge initialization to a separate function
  vfio/pci: Add placeholder for device-specific config space quirks
  vfio/igd: Refactor vfio_probe_igd_bar4_quirk into pci config quirk
  vfio/igd: Decouple common quirks from legacy mode
  vfio/igd: Handle x-igd-opregion option in config quirk
  vfio/igd: Introduce x-igd-lpc option for LPC bridge ID quirk

 hw/vfio/igd.c        | 503 +++++++++++++++++--------------------------
 hw/vfio/pci-quirks.c |  51 +----
 hw/vfio/pci.c        |  33 +--
 hw/vfio/pci.h        |  13 +-
 4 files changed, 214 insertions(+), 386 deletions(-)

-- 
2.47.2


