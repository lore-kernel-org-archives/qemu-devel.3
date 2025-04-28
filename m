Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B48C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9R4d-0002Mb-T7; Mon, 28 Apr 2025 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R3q-0001vV-1B
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u9R3l-0008Ma-8W
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:10:23 -0400
Received: by mail-pl1-x642.google.com with SMTP id
 d9443c01a7336-227d6b530d8so54013955ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745856618; x=1746461418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eVeMu9aXn88CJLsmZUlPh0sgcymHqGzuWJ5s084Uj3s=;
 b=OLI07gM7kxIBszXd1/6HJYebuAPJ/lI2vLqYNmgbPm/15H7TRehxyUa3FJLRoosjl3
 jx3REpWHeX5eqt5R8iz2uYQI9tMA6Rf6vSmMPKhGBc6VkAHzFnM+JXi4uUFVkG9rvANw
 H65JPCLgEIszqprDRhH9WfbJ+aa8qxSCG6TiMzpUB5uxNwMHRn43RvX2jDhJL5TR3BJn
 O2ENZjIIG9Rl2PhClhlnITnZqe74UTHpqS8r567yRYZiY9r/yezi3kMAyA8vKqfmZ9nT
 ke/qHq1DDVFHDBODm/s6/BCJ54A5AvcdHuE1Y2lpWc/NagBHiC2BX8Xj7ym50rBQej/C
 JBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745856618; x=1746461418;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eVeMu9aXn88CJLsmZUlPh0sgcymHqGzuWJ5s084Uj3s=;
 b=PebKO/EMA6zLYjrdkr+/jDeYVVuRLvd780Kz67gwu46BCGEuDIoRptc7mylQ8/3Eyb
 TqFcAVou5aTiGLhMRMaJx9vkq1iT8wdjA21+dOnx6XfUQVd/uOKI2ranSJfSZ2h9aYiK
 HQiKuvHIlEuxawwSeglhklHKfGkvrUXOe9JqKkqdwP+9NuwaZ1Vzt05FZCHCGTl/GGEY
 vEV/XrsSV0y01FzeiuE1MYHXm1q2RvvGiXhGAucrhWss76CdqMdAUKAiwb9uTL+QDqoz
 YWandokV77TrEIWJ1aHIScS22AG5+xtWBupv04W69y230HHWMgmS+Rt6PUNfUi0HI8Qq
 zAUw==
X-Gm-Message-State: AOJu0Yx+d/dMZmPa3tG0Nb4bWumDMO20FI8GCwMKNGvkO9m/EQdBm0Az
 LizCeawnII5vh6EI6iwY4bPPT6hTUTxIr8wo4PLo5n6XS5Vh4qznkmnzlfMjvg==
X-Gm-Gg: ASbGncuS1N9XiqXj15Sr/TyFQ56gAwD0wSX+Z+KpPZ9oo42pnsKzjYCKpuBQLf4kl6F
 oDuwEZgrGFQrCKwm3gTsGrMaYRPuWkw+008sIZQksTVrnTXZVsrKkTkyxvfImW8r7Tp+rF7bsfC
 F74cks0qWZLjHeRK3bdx9fsJLRPEWTSyvU51vg71wH4UztNzgnv4BMVSLepibOsGMN25hho3TNH
 Ti4FEkP/CP00uwBkSaSSkB/7X/4/UkL3tvjC6TENu6htJwRStZP8+DH8riwivG2ezAe7gxRZXQL
 fzcvNrUO/Mti0WIRm9Rxoq/Aopqm36xA4vVWmwwW7HBEsL1NoMy62IulZcrJ7iU3BAE=
X-Google-Smtp-Source: AGHT+IEu/orxQULhjBuxoRCqNRXLn/ywW70O6T8Wqb29ZhsZjKG5UnFLNau+0ik9naVg2vitSFZ0pw==
X-Received: by 2002:a17:902:ce8b:b0:223:501c:7576 with SMTP id
 d9443c01a7336-22dbf5ef67dmr197927005ad.12.1745856618248; 
 Mon, 28 Apr 2025 09:10:18 -0700 (PDT)
Received: from localhost.localdomain ([139.227.182.191])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5221677sm84357515ad.248.2025.04.28.09.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 09:10:17 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH 0/9] vfio/igd: Detect IGD by OpRegion and enable OpRegion
 automatically
Date: Tue, 29 Apr 2025 00:09:55 +0800
Message-ID: <20250428161004.35613-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x642.google.com
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

As proposed in a previous discussion [1], detect IGD devices based on
whether it has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION exposed by kernel
and enables OpRegion access by default. This enables out-of-the-box
display output support for IGD passthrough without having to manually
set x-igd-opregion=on, which probably saves effort for libvirt users.

This patchset also limits legacy mode to Gen6-9 devices, as Intel no
longer provides CSM support and VBIOS on newer IGD, and Seabios does not
support setting up the 64 bit BDSM register on Gen 11+ devices. Exposing
VGA ranges to guests by default on platforms without VGA mode support is
undesirable.

Additionally, as we enables OpRegion on IGD devices by default, and
Intel removes the BDSM register from Meteor Lake [2]. There seems to be
no extra register quirks rather than OpRegion required on newer devices.
To support them (and probably future devices), the generation limit is
removed, with BDSM quirk only applied to known Gen 6-12 devices. 

Note: I have not been able to test this on Meteor Lake or newer
platforms due to lack of hardware.


[1] https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com
[2] https://edc.intel.com/content/www/us/en/design/publications/14th-generation-core-processors-cfg-and-mem-registers/d2-f0-processor-graphics-registers/

Changelog:
v2:
* Removed "Allow hotplugging with OpRegion enabled", hotplugging is
  always forbidden.
* Test device is not hotplugged and get opregion in a single function.
* Update documentation along with code changes.
* Minor code style fixes.
Link: https://lore.kernel.org/qemu-devel/20250421163112.21316-1-tomitamoeko@gmail.coms

Tomita Moeko (9):
  vfio/igd: Restrict legacy mode to Gen6-9 devices
  vfio/igd: Always emulate ASLS (OpRegion) register
  vfio/igd: Detect IGD device by OpRegion
  vfio/igd: Check vendor and device ID on GVT-g mdev
  vfio/igd: Check OpRegion support on GVT-g mdev
  vfio/igd: Enable OpRegion by default
  vfio/igd: Allow overriding GMS with 0xf0 to 0xfe on Gen9+
  vfio/igd: Only emulate GGC register when x-igd-gms is set
  vfio/igd: Remove generation limitation for IGD passthrough

 docs/igd-assign.txt |  11 ++-
 hw/vfio/igd.c       | 218 ++++++++++++++++++++++++++------------------
 hw/vfio/pci.c       |   2 +-
 3 files changed, 137 insertions(+), 94 deletions(-)

-- 
2.47.2


