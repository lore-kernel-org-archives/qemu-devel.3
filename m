Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F0BC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkfH-00088O-R9; Sat, 25 Jan 2025 13:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfG-00087h-78
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:13:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkfE-0004BI-I7
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:13:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso20959035e9.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737828826; x=1738433626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=moGB9VY6BYgn3pI64/Eq1yuXgBP6nQhiwk+gTGBd7L0=;
 b=rllLpTaPG2wOZZeTUZWpI6Mc3lTpgHM0IwgqBbn902DneqaVTOZFJ/cE23KwO+u6xT
 bjBkhmQo3DI44KWnLzsUbsvV5COfiZT+BmmjGqmQtfV896xNHxGT8vQERxgJGc9AVS7l
 AOdSA5je8dXKnp9hkpG1eK3DPQ3XOs36vNKCYmY+7SwtEQIO47+GGTRMUNV3Gz3VPi1S
 05WsOJgXmMQ0AM9hptsLkqtIHqeCR++GhFdYGVxRJZzdsLaFaMs/kOj5vW+6cFz8Rm3o
 EZ6sI9viKAhd/HjmfINE8ZRlTYFL344k5UKPspEIDxz9LtCvpFvN60bWoohuUTBiMMMv
 8ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737828826; x=1738433626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=moGB9VY6BYgn3pI64/Eq1yuXgBP6nQhiwk+gTGBd7L0=;
 b=fLdpKcpHvn7/p+x0CCCw/vNcvj4rzvSqI63iUjTgWFcbPFSoQZijJVsAuRZvh4sCiB
 He2/C+1viR/D/pEh1DBQlmMwXptb7kt3pSsG+KUnfx0XY3TRy/dXwwgHKEc/KXd6HxPf
 4iBWV7v2271QTVo3M/8BmC/8j4ZBoup7Il88kZIoQmdBsJeFF2Utr+o5BoIUPYOWMT91
 0AFwfFKMvfOC2JkQ8lj/W50Ovmje/nmOK64ki/pThq97IO5p+Ux0+Mnw3fpsl8wYJwqM
 XVmxntZBi+k5IemnV2A1LLUSXypcX61X2LyUk6F146hEfeZD0NitX/Au+R5AFe16CCoc
 e/QQ==
X-Gm-Message-State: AOJu0YziPfLpxTq161UORy4xoCqo0RbnfG1R5sditJapWRbgmeXNmKhP
 AfpDYk5LC2itsGOH72qDGwbrVeaqPfttW/ONGLAd1xHRdT4rCBFtzkZF77dQL+33HGc7lulQwdT
 rLeA=
X-Gm-Gg: ASbGncsSF1DRed8WWvYDBrBf6ZitlOjBwinZ+iUa6Y3rytYOeM+Wxb+UhJlus0zSoFR
 PHrlCT2QiF26pB2XKtFYo07WO1UGzS40ZfeNuD3Vhw0LDsvKs8siKNW9fCcZbnHN0Z7BlUFLmHA
 nXwr5N9QtPoqZuPl/E9AsHa38TNfl7e1TlwQC7pfYD9zFWoGXJdTdb6fN/hGQPxJWkMz68oJ9It
 Oxj4VujVn+HKmW7XXUwnhXfcNGWcEYPzFULIolNRPcm6/VHOsmh57qFHEktRGNnuWJy4AvAicvH
 jxwXjwaCwJ0QT4paO8/AhX5RwgWSjQLGMVF2G0vNyIjtsVcGqyOGXDksZoYW
X-Google-Smtp-Source: AGHT+IFFcuv4NbqWEewutKdT/4sas20HtAvh9/vbvnAdvh7QUUP5Q6Afr6fZs6XUltdZIWZYDYhKXA==
X-Received: by 2002:a05:600c:1d07:b0:436:488f:50a with SMTP id
 5b1f17b1804b1-438913ef4b7mr333870305e9.17.1737828825695; 
 Sat, 25 Jan 2025 10:13:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48b000sm70555435e9.20.2025.01.25.10.13.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 25 Jan 2025 10:13:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/9] hw/sysbus/platform-bus: Introduce
 TYPE_DYNAMIC_SYS_BUS_DEVICE
Date: Sat, 25 Jan 2025 19:13:34 +0100
Message-ID: <20250125181343.59151-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Some SysBus devices can optionally be dynamically plugged onto
the sysbus-platform-bus (then virtual guests are aware of
mmio mapping and IRQs via device tree / ACPI rules).

This series makes these devices explicit by having them implement
the DYNAMIC_SYS_BUS_DEVICE class, which only sets 'user_creatable'
flag to %true but makes the codebase a bit clearer (IMHO, at least
now we can grep for DYNAMIC_SYS_BUS_DEVICE).

Philippe Mathieu-Daudé (9):
  hw/sysbus: Use sizeof(BusState) in main_system_bus_create()
  hw/sysbus: Declare QOM types using DEFINE_TYPES() macro
  hw/sysbus: Introduce TYPE_DYNAMIC_SYS_BUS_DEVICE
  hw/vfio: Have VFIO_PLATFORM devices inherit from
    DYNAMIC_SYS_BUS_DEVICE
  hw/display: Have RAMFB device inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/i386: Have X86_IOMMU devices inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/net: Have eTSEC device inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/tpm: Have TPM TIS sysbus device inherit from DYNAMIC_SYS_BUS_DEVICE
  hw/xen: Have legacy Xen backend inherit from DYNAMIC_SYS_BUS_DEVICE

 include/hw/sysbus.h           |  2 ++
 include/hw/xen/xen_pvdev.h    |  3 +-
 hw/core/sysbus.c              | 53 ++++++++++++++++++++---------------
 hw/display/ramfb-standalone.c |  3 +-
 hw/i386/amd_iommu.c           |  2 --
 hw/i386/intel_iommu.c         |  2 --
 hw/i386/x86-iommu.c           |  2 +-
 hw/net/fsl_etsec/etsec.c      |  4 +--
 hw/tpm/tpm_tis_sysbus.c       |  3 +-
 hw/vfio/amd-xgbe.c            |  2 --
 hw/vfio/calxeda-xgmac.c       |  2 --
 hw/vfio/platform.c            |  4 +--
 hw/xen/xen-legacy-backend.c   |  7 ++---
 13 files changed, 42 insertions(+), 47 deletions(-)

-- 
2.47.1


