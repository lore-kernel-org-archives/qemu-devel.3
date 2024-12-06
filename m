Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E9AE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 12:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJXRC-0005vZ-7U; Fri, 06 Dec 2024 07:28:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXRA-0005uq-Ck
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:00 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tJXR8-00040h-8B
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 07:28:00 -0500
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-7252fba4de1so2251379b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 04:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733488076; x=1734092876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lTFS2SIdVrxjZ5HaZ1a3I+0a0U88QXInWRPExcsBu8Y=;
 b=RGkxGLcu5yMX5BOhZRg0QHfQpIY00FsfV/8+nQIpYdpTBus921dAVpyS11AYGbq8i9
 ifpwl6DDPTbw5553uYl8yonTcuuncSrg/y0LnLa0am/Ao3T5kAQKfsFZvXPzYU/41ba1
 afyTkc2o9hWysv641+qGFQ6C2wxmVZS3yZVFh2sACXZxT3vGAouUxV4nWf/+s98Yx72H
 Bx00PyLGlax3XB4UPacl3fNC+UGUnCp99qsYVKmzsGftmysj61SgfDxf10gdTF9AP9+E
 7fsZruUbUQStG9GVDq4/74XOCJKGSe/zluqr6QwSu89ibbQQPAdDgVhfmrTJhyrItJ3A
 +M7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733488076; x=1734092876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lTFS2SIdVrxjZ5HaZ1a3I+0a0U88QXInWRPExcsBu8Y=;
 b=eQwHhBVgugjE8pfzV40iVAh9yerymV1dFI6m4xY/gos+tb5YowfCeUt6fN5rHnY2QL
 hIPqD12iip3CRfqvsXATgVMqES2MXJvFa9hSex81rPE/Nn2DCmwgPx0UunWuUyxn0R3O
 AHKvJhR1Jak0HaHHaRWkmgK8huRXqhTjFt2exz8zyCLcFrFXeeELULCKjnQU7v9Oy+aZ
 ETKr/ef8Ltsw/j835dP5V3bY08UT0+eSAIiMaqKuYBTd5iR0QdAGP4DSyNfAJ7sEwqjJ
 ONBMqdUN3L8dRLhR4XdfLqFangJjq8sfmpcCVn87nZxJM6GRfQ68hpidC5KJq/gXPM/y
 Goiw==
X-Gm-Message-State: AOJu0Yz/VtZA494RWZ7vJsQNF8pgdfjPVOSNNVhX5d8/2YLEVllSBTDb
 cPKdG7p5nuTqqaSz/+Wc8Zudh8zY7PAUmw5vVfibN3UWiSTy3l8FmhKeaBPYIw==
X-Gm-Gg: ASbGncsOoLE4QcYNXhnZF+qQWYQ0R/1wnvYeitoE+OG1e//rshjrvRPVcNZBVok5fp4
 jTZfVVl+Ozv4yflnWjFV26u1voYbMt0wlDYsqBhWtaKoltS38iKG+aqLkc1fr0WVBTtraqpUrhR
 vFhPqX5FkA1sOHGo9bXaFq1wNBAgZIwpEbcgOVAAOq7/oqYicIw/uvJEaeS3iYvvvyqtfkDCASZ
 bOi8GrR8wEWTOyPWKqEraJqigey5zwDc4FgmAhq1f1W6OvnfSKgZgvw+w==
X-Google-Smtp-Source: AGHT+IHF7l+OveGOcp63p09vmP4Kpx63J7mB+smKS1kOb1d/vyPEJW2D74xHn/DcODfC/g1fn3uFPQ==
X-Received: by 2002:a05:6a00:1916:b0:725:a2d6:7f0e with SMTP id
 d2e1a72fcca58-725b811f556mr4426296b3a.1.1733488076037; 
 Fri, 06 Dec 2024 04:27:56 -0800 (PST)
Received: from kotori-desktop.lan ([58.38.120.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15710123sm2579866a12.49.2024.12.06.04.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 04:27:55 -0800 (PST)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Subject: [PATCH v4 00/10] vfio/igd: Enable legacy mode on more devices
Date: Fri,  6 Dec 2024 20:27:38 +0800
Message-ID: <20241206122749.9893-1-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pf1-x443.google.com
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

This patchset extends the support of legacy mode igd passthrough to
all Intel Gen 11 and 12 devices (including Ice Lake, Jasper Lake,
Rocket Lake, Alder Lake and Raptor Lake), and emulates GGC register
in MMIO BAR0 for better compatibiltiy (It is tested Windows and GOP
driver will read this MMIO register).

It also replaces magic numbers with macros to improve readability,
and aligns behavior (BDSM registor mirroring and GGMS calculation for
gen7) with i915 driver to avoid possible issues.

The x-igd-gms option removed in 971ca22f041b ("vfio/igd: don't set
stolen memory size to zero") is also added back so that data stolen
memory size can be specified for guest. It is tested that GMS may
related to framebuffer size, a small GMS value may cause display issues
like blackscreen. It can be changed by DVMT Pre-allocated option in
host BIOS, but not all BIOS comes with this option. Having it in QEMU
helps resolves such issues.

This patchset was verified on Intel i9-12900K CPU(UHD 770, 8086:4680)
with custom OVMF firmware [1] and IntelGopDriver extracted from host
bios. IGD device works well in both Windows and Linux guests, and
scored 726 in 3DMark Time Spy Graphics on Windows guest.

[1] https://github.com/tomitamoeko/edk2/commits/igd-pt-adl/

Btw, IO BAR4 seems never be used by guest, and it the IO BAR itself
is not working on Gen11+ devices in my experiments. There is no hints
about that in old commit message and mailing list. It would be greatly
appreciated if someone shares the background.

Changelog:
v4:
* Move "vfio/igd: fix GTT stolen memory size calculation for gen 8+" to
  the first.
Link: https://lore.kernel.org/qemu-devel/20241205105535.30498-1-tomitamoeko@gmail.com/

v3:
* Added new patch to fix GTT stolen memory size calculation for gen 8+
  devicess.
* Fixed quirk index in "vfio/igd: add macro for declaring mirrored
  registers"
* Fixed condition in "vfio/igd: add x-igd-gms option back to set DSM
  region size for guest"
* Updated comments and commit message.
Link: https://lore.kernel.org/qemu-devel/20241203133548.38252-1-tomitamoeko@gmail.com/

v2:
* Droped "vfio/igd: fix GTT stolen memory size calculation for gen 7".
* Fixed conditions when calculating GGMS size.
* Added Gemini Lake and Comet Lake device ids.
* Splited mirroring register declaration macro into a new patch.
* Minor fixes.
Link: https://lore.kernel.org/qemu-devel/20241201160938.44355-1-tomitamoeko@gmail.com/

Tomita Moeko (10):
  vfio/igd: fix GTT stolen memory size calculation for gen 8+
  vfio/igd: remove unsupported device ids
  vfio/igd: align generation with i915 kernel driver
  vfio/igd: canonicalize memory size calculations
  vfio/igd: add Gemini Lake and Comet Lake device ids
  vfio/igd: add Alder/Raptor/Rocket/Ice/Jasper Lake device ids
  vfio/igd: add macro for declaring mirrored registers
  vfio/igd: emulate GGC register in mmio bar0
  vfio/igd: emulate BDSM in mmio bar0 for gen 6-10 devices
  vfio/igd: add x-igd-gms option back to set DSM region size for guest

 hw/vfio/igd.c | 262 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 165 insertions(+), 97 deletions(-)

-- 
2.45.2


