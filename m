Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28E63C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc31-0003K9-Iy; Fri, 07 Mar 2025 13:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc2y-0003J5-R8
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:03:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc2v-0000h2-QX
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:03:44 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bc638686eso21300275e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370620; x=1741975420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/oAHM+o1HyAZE1R9TLHu1sG81uMnmeMuAy/uRUVPY4=;
 b=E+5XOr0lm9i9Hx7gZEmmnrCtlUYoReJ8gtz1qG0oqMY1OKGkpq8i2QosiBjY90SjSf
 2BO6l1yNc3TNf5GUPbzyUaQpH3maURFH16bpWtMBvfIX+BxqTBVdVlBcN1Rl7X9iQX61
 DTz+HMNiK12N/GF20+EfO82krEcA47OvhksjwcKVCiOMh2u6ARokd/eMMOVZoGhefziK
 NIQoYIzmzz2kVFApTISGmHPwSoiNI1m5WQlaWJk5Qn9dfpN1RXEdtHYSVx3xjxgo21sc
 P9OzT7EUScQNnDLe9YZ1FqkNdOLCfsttztCt8T9e+7ICmvMdjcv9IjYGS/iZuf2cXgD2
 BSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370620; x=1741975420;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q/oAHM+o1HyAZE1R9TLHu1sG81uMnmeMuAy/uRUVPY4=;
 b=SQY0UoprO9ReAdKvCCmeLcUK6m9kX8Q2N+5U4mDUwGWyKuG7yyFisH/I1fUm37Dv2j
 cW8TqtiRNKupKipyM9YzIgw3pk354xJIghMipn6qcy70sHM0z2rIaUmFouTdtOUQQqz+
 SNlBYqCOvOsggCe2xYcxq1JiRTAgiNegiWYVYISN1pyAmDA6YODy54TfjDWkLESWtKTK
 7Bg/oAkq5NC0QUSXzUfjN5fepy175JT3iWlP8mQ7Yb+sVFi8TT9obTkdSJmaegbhaKFW
 L/Zz4apTAQEL7FW7LXBTgogFBmew1EWxLAQXppBUCTdiz6TGIrv7XmrRrKA6fIZETaPv
 oIfw==
X-Gm-Message-State: AOJu0Yz8gvNjLXD6Z9QoYxepK6H87PLCj7RVgpMAezHgJJvKSu1dr6yu
 ehKRAIa9yTodD/4erqjL2S/EjQ8mNm2BZAikSOguCQfn6+266Z+zILdo5wmRWVDNbxybz4VJy1W
 qSxs=
X-Gm-Gg: ASbGncsgjI6Y/lnQNWbioiTE5k7MlFlmr3E4Jx6fOU6vaGIwGX0KqbdKKhq8+7oeOoV
 JgWyWj6jPMWsoVcrf/23oPrz58EXGdm6cnutDHx+ANJXgPeSNKsZ7bn6TZcMArfnNPH6q70mDYF
 uiehlgk7w+9a6ssBNT9/zofBD2+f6KTBmEjwIHxcULMJ0taCPmuydGahvVTiYdIwyxKj+Y4bx3h
 V7kO8XCRQBpd42sMVnQ569nu/VIiyqHv3mY3CgNIHsLrvifa8KB/6gu+Y9Nx7drMitqfKMBEasD
 NPUGTbSpk+65FPMagWtBkVTtnGkTftYJ84LkzQZ8DZVdJIuBt80n0XTk2iyvcbyjTM7FNdPWqiE
 SvZLBbBRZigaJcouz9yM=
X-Google-Smtp-Source: AGHT+IGJCt1VGdsMr+uydjBiH7JPgewvP9Ih/z/ZXT/fA/i9Aw0RMbjmlNL8hvAx3QH87mYJ2fMqvw==
X-Received: by 2002:a05:6000:1f84:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-3913af060e0mr441014f8f.15.1741370619758; 
 Fri, 07 Mar 2025 10:03:39 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0195bfsm6006751f8f.48.2025.03.07.10.03.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:03:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 00/14] hw/vfio: Build various objects once
Date: Fri,  7 Mar 2025 19:03:23 +0100
Message-ID: <20250307180337.14811-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Philippe Mathieu-Daudé (14):
  hw/vfio/common: Include missing 'system/tcg.h' header
  hw/vfio/spapr: Do not include <linux/kvm.h>
  hw/vfio: Compile some common objects once
  hw/vfio: Compile more objects once
  hw/vfio: Compile iommufd.c once
  system: Declare qemu_[min/max]rampagesize() in 'system/hostmem.h'
  hw/vfio: Compile display.c once
  system/kvm: Expose kvm_irqchip_[add,remove]_change_notifier()
  hw/vfio/pci: Convert CONFIG_KVM check to runtime one
  system/iommufd: Introduce iommufd_builtin() helper
  hw/vfio/pci: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
  hw/vfio/ap: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
  hw/vfio/ccw: Check CONFIG_IOMMUFD at runtime using iommufd_builtin()
  hw/vfio/platform: Check CONFIG_IOMMUFD at runtime using
    iommufd_builtin

 docs/devel/vfio-iommufd.rst  |  2 +-
 include/exec/ram_addr.h      |  3 --
 include/system/hostmem.h     |  3 ++
 include/system/iommufd.h     |  8 +++++
 include/system/kvm.h         |  8 ++---
 target/s390x/kvm/kvm_s390x.h |  2 +-
 accel/stubs/kvm-stub.c       | 12 ++++++++
 hw/ppc/spapr_caps.c          |  1 +
 hw/s390x/s390-virtio-ccw.c   |  1 +
 hw/vfio/ap.c                 | 27 ++++++++---------
 hw/vfio/ccw.c                | 27 ++++++++---------
 hw/vfio/common.c             |  1 +
 hw/vfio/iommufd.c            |  1 -
 hw/vfio/migration.c          |  1 -
 hw/vfio/pci.c                | 57 +++++++++++++++++-------------------
 hw/vfio/platform.c           | 25 ++++++++--------
 hw/vfio/spapr.c              |  4 +--
 hw/vfio/meson.build          | 33 ++++++++++++---------
 18 files changed, 117 insertions(+), 99 deletions(-)

-- 
2.47.1


