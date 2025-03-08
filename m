Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3DDC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Ii-0004Ox-Rm; Sat, 08 Mar 2025 18:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3IM-0004Ic-QQ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:28 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3IJ-00016G-4L
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:26 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so26011365e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475361; x=1742080161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ObCXdxBV5FFXTAkBikkLyhnu4rSBn8wDnLJnCi+DE38=;
 b=peEK3T4sYX3LFt9nPD0vVriEH2NCvY+X+chcEU0qEe6Dv2xpyHq/5sXcUe4Ns64lD4
 RIoHkT1lJx4UfS0U5Y2xCksvxMJ2EzpY+9Uu4G0cH5cmHEM3TgQCxANEHg85igSAYzCY
 op5lpmV244pUayiO6NYPLfWbaW2lZRXmEQW2G3CW2C2oupGAiWp/gCHGAHoVJm1P30Pe
 z9rFTG5TUDnfkhV++uE9yBbMdsRc6OdoTnwOogYpW093y4z32Qd9vixSgxLwlujYmP+A
 RTN+vsYnRv5ceHAeaC51JDZEF2SB54U1X5Fnxw0FJGPo9JQfcrD41fbd3AtTQXfSAh8M
 sgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475361; x=1742080161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ObCXdxBV5FFXTAkBikkLyhnu4rSBn8wDnLJnCi+DE38=;
 b=CMrvhWMNzm5BN/EuKF0TBGJgYWqetQ83pUjaYR9z+ezLTFcDNexAIEZnoIDxCGYM2r
 le8KZp0KWo66dj7dYtfW7c7zjgsY3vR9DuHODqQrXTkgNruQmHl/6JJLCHtbWfGy+xQZ
 8azT4OPN0l3w5C5II8XXo89aFYbbFRxfLHDOHYk2ECfnFXzVN6nuAHxJ8XLLc5suC3K5
 1V4DY/beUaBKyNXRbRrJJsDgDCAi9Pm/P/MXfOwX223EzKxbvL4Si4iRpde+PWXM/8CV
 X5FTXbqCuKMubeflsSx25libmoNxP30afo/E/Wmv3dcpf+pFiApmi3aaB0lc16hJOTst
 VhTg==
X-Gm-Message-State: AOJu0YxMCpYgVE+a/NnzVw1/mqybSYaWOe7jZfcPsFm1dzF/CXQm/92k
 X01WZ/Gf0J50XpjJLez6at81AWEwxYNryFwXToiGZKNzC/IfON61qI54nCv40mbp53AMmyhQvJa
 znVs=
X-Gm-Gg: ASbGncvROMDI9K7SnqYOHyHcw/gT0RIefyroA/KE2qffDeFwX/69wmtkDLHQAPx4wic
 X5BefvXXoohUXv33rqfT/86zAv8FkVFqe1gvvzKmCYtNyZ6jUi8sl3kW0O3KGD/K4xV/ypNV00R
 3A0I/hPSTx0M5ybYy019ucntui2zZKGMQCmo0yS7fx0Lth1+5d5SaO/kEdGd6xgmKTMGlPAmniL
 yNlUqm72bNCoXdYNjwgRH54MCCumb+BMnUQVcD2FROt4FIgUdXy4l/AZH8F5AOIRRXsiOcUWBNp
 zF7FQTug3Lw+NPdCSYKDhQKqs55ZxzNpXe+64+EgJSMhvdsvXTtog+kXQEJrntvzTYGamt2eFVr
 0p807F45F4NNgmOgmj8g=
X-Google-Smtp-Source: AGHT+IF98pReGBpdgLDkhd0lnLr9OBzKY1FVvFofkKlVXFbwmBnEwNlkFJzcxYQ3ZA/xQH45IkWqYg==
X-Received: by 2002:a05:6000:2107:b0:390:f6aa:4e6f with SMTP id
 ffacd0b85a97d-39132d306aamr4468226f8f.10.1741475360860; 
 Sat, 08 Mar 2025 15:09:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd435c88esm125768485e9.36.2025.03.08.15.09.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:09:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/21] hw/vfio: Build various objects once
Date: Sun,  9 Mar 2025 00:08:56 +0100
Message-ID: <20250308230917.18907-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

By doing the following changes:
- Clean some headers up
- Replace compile-time CONFIG_KVM check by kvm_enabled()
- Replace compile-time CONFIG_IOMMUFD check by iommufd_builtin()
we can build less vfio objects.

Since v1:
- Added R-b tags
- Introduce type_is_registered()
- Split builtin check VS meson changes (rth)
- Consider IGD

Philippe Mathieu-Daudé (21):
  hw/vfio/common: Include missing 'system/tcg.h' header
  hw/vfio/spapr: Do not include <linux/kvm.h>
  hw/vfio: Compile some common objects once
  hw/vfio: Compile more objects once
  hw/vfio: Compile iommufd.c once
  system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
  hw/vfio: Compile display.c once
  system/kvm: Expose kvm_irqchip_[add,remove]_change_notifier()
  hw/vfio/pci: Convert CONFIG_KVM check to runtime one
  qom: Introduce type_is_registered()
  hw/vfio/igd: Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE
  hw/vfio/igd: Check CONFIG_VFIO_IGD at runtime using vfio_igd_builtin()
  hw/vfio/igd: Compile once
  system/iommufd: Introduce iommufd_builtin() helper
  hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
  hw/vfio/pci: Compile once
  hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
  hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
  hw/vfio/s390x: Compile AP and CCW once
  hw/vfio/platform: Check CONFIG_IOMMUFD at runtime using
    iommufd_builtin
  hw/vfio/platform: Compile once

 docs/devel/vfio-iommufd.rst  |  2 +-
 hw/vfio/pci-quirks.h         |  8 +++++
 include/exec/ram_addr.h      |  3 --
 include/qom/object.h         |  8 +++++
 include/system/hostmem.h     |  3 ++
 include/system/iommufd.h     |  6 ++++
 include/system/kvm.h         |  8 ++---
 target/s390x/kvm/kvm_s390x.h |  2 +-
 hw/ppc/spapr_caps.c          |  1 +
 hw/s390x/s390-virtio-ccw.c   |  1 +
 hw/vfio/ap.c                 | 27 ++++++++---------
 hw/vfio/ccw.c                | 27 ++++++++---------
 hw/vfio/common.c             |  1 +
 hw/vfio/igd-stubs.c          | 20 +++++++++++++
 hw/vfio/igd.c                |  4 +--
 hw/vfio/iommufd.c            |  1 -
 hw/vfio/migration.c          |  1 -
 hw/vfio/pci-quirks.c         |  9 +++---
 hw/vfio/pci.c                | 57 +++++++++++++++++-------------------
 hw/vfio/platform.c           | 25 ++++++++--------
 hw/vfio/spapr.c              |  4 +--
 qom/object.c                 |  5 ++++
 hw/vfio/meson.build          | 35 +++++++++++++---------
 23 files changed, 152 insertions(+), 106 deletions(-)
 create mode 100644 hw/vfio/igd-stubs.c

-- 
2.47.1


