Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2724DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v413j-0002M4-2Q; Wed, 01 Oct 2025 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413T-0002A9-Ic
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4133-00013A-Vq
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:55:54 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso541625e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341323; x=1759946123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aokqeion6vg/XBK7zMSfidbyVnYpQrHhaMRTyeMkDMQ=;
 b=RNEduLsYjzLUx/Y10XCLc1EwzBG48Jmeyjhul+2AF/uT71lYgVOOcQmcmR2NQqHOrl
 mXd2K6phLC8HPkgPovFdDKz7AxtLQp8EfuO+JbM+kyNBNbcjiT+5nxSa8W5aqK2kITn4
 VJ0uWl3wF2P3fu54LRFXKZG2BZQ2MjR2lWGNnGjb31lS+8iQrS42N9YLG/Uql6WZEA3S
 o2AZIrVrApeWkIz/Qc+i8sFC39pK8mrtAeUc7F0yv/cNO8FQKAaV9nSnvl6bpy9utD5m
 5ZsoJ3ddltmD564l3DFZPA3V8CGEqByTT1IjW9PKOL7BwYygPEFrBQ0Cg5qCX/ToQwms
 sr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341323; x=1759946123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aokqeion6vg/XBK7zMSfidbyVnYpQrHhaMRTyeMkDMQ=;
 b=oiVpPuJ2SJIyR28BBiKIEmqx5HLhS77jzq4gG9jLRTZZ/6GxW4ADCrHfG1cnV4DENp
 XwuUlkONinwOvzrgCKPS2X8SB0dtvjSAi6htlclxNYblzm+b9cCJUH6ckmcP7ZC/LEjd
 e+d2f+94OlJ0zv+mVS6ShDbCqeCwcLFTXZOBdS/40vDQ84UntIHklbgozHKN3RJEhMaM
 L9LtDx20k+4dV/hfFhJ8hs+2kX4yVDMO+9BdbGQFLcKJhc40kG82QWCx84fMk9NNNFiz
 9MuehWyKRHCmbyOX4sGtytc4mLhzDrkWc7s7df1xKOCPn1QR1ttbOdlps1xexAFl4DaF
 qR/w==
X-Gm-Message-State: AOJu0YwSzRrRRMC2z+wclBhVoHZT82na9yFGP2XCSMhxYLf3NdXj9IUu
 dIv+Ig5IMhnHlXXHH6Mbna9+tk2vgkk7JkOmb63YuUu3wP9iNwdNBHqiHUQa0052UPstCWC9elR
 5ufX+lolAxw==
X-Gm-Gg: ASbGnctc+M+1Laz0nMiyKXRYbXN+H8w6Oy/cKRCIC7I3vrIpBwC8gq9r0Z5qdaJ1Rr4
 uHJIgAD4A7cAlreQIOfRc3Z5cT4yB7E504Aksywj8RQ/v8b6dMgQ1pWX40bXsE1Km13BMENxu3u
 Uff2B5tUm8/6CJDc0g2jacsOQsC9q1H9VLcYJXLyXsD1Ttd/CKLP6M6GEDoIabnl0USYuKgbdWp
 4kMRJxl+n5K70yduXVeGuwqZbc7i1mpTiKm2o+MXsL5wEsW5mX4mncddBceDdKgaNFt1qvAppjZ
 Vx4obli2/n9wJJznYOYgHuzESwXGHPLnGelX4hev/J174B8Amgdh+POgATmEgajGptI+o44rBgF
 m4ihFAnswqv8kA1/4gvmT9MoNKMXc//sn3AsgSeITAVPdYJP1Vmu5LRbfUuX0UukmkQd4dpx2Za
 dDjaZOxHTN5vShqejWwbeJYkfxxA==
X-Google-Smtp-Source: AGHT+IGTdM+ShrsSYsYPJCqJA4n0otn39Exzcd9EGo7lsVQICK9Ecvf0H7UF6pHszRiQWBgo2Y4+Cw==
X-Received: by 2002:a05:6000:240a:b0:3e7:6197:9947 with SMTP id
 ffacd0b85a97d-42557a15b6fmr3507602f8f.53.1759341323415; 
 Wed, 01 Oct 2025 10:55:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c49sm143400f8f.3.2025.10.01.10.55.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:55:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 06/18] hw: Remove unnecessary 'system/ram_addr.h' header
Date: Wed,  1 Oct 2025 19:54:35 +0200
Message-ID: <20251001175448.18933-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

None of these files require definition exposed by "system/ram_addr.h",
remove its inclusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ppc/spapr.c                    | 1 -
 hw/ppc/spapr_caps.c               | 1 -
 hw/ppc/spapr_pci.c                | 1 -
 hw/remote/memory.c                | 1 -
 hw/remote/proxy-memory-listener.c | 1 -
 hw/s390x/s390-virtio-ccw.c        | 1 -
 hw/vfio/spapr.c                   | 1 -
 hw/virtio/virtio-mem.c            | 1 -
 8 files changed, 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 82fb23beaa8..97ab6bebd25 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -77,7 +77,6 @@
 #include "hw/virtio/virtio-scsi.h"
 #include "hw/virtio/vhost-scsi-common.h"
 
-#include "system/ram_addr.h"
 #include "system/confidential-guest-support.h"
 #include "hw/usb.h"
 #include "qemu/config-file.h"
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index f2f5722d8ad..0f94c192fd4 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "system/hw_accel.h"
-#include "system/ram_addr.h"
 #include "target/ppc/cpu.h"
 #include "target/ppc/mmu-hash64.h"
 #include "cpu-models.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 1ac1185825e..f9095552e86 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -34,7 +34,6 @@
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
-#include "system/ram_addr.h"
 #include <libfdt.h>
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/hw/remote/memory.c b/hw/remote/memory.c
index 00193a552fa..8195aa5fb83 100644
--- a/hw/remote/memory.c
+++ b/hw/remote/memory.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 
 #include "hw/remote/memory.h"
-#include "system/ram_addr.h"
 #include "qapi/error.h"
 
 static void remote_sysmem_reset(void)
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index 30ac74961dd..e1a52d24f0b 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -12,7 +12,6 @@
 #include "qemu/range.h"
 #include "system/memory.h"
 #include "exec/cpu-common.h"
-#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/remote/mpqemu-link.h"
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d0c6e80cb05..ad2c48188a8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -13,7 +13,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "system/ram_addr.h"
 #include "system/confidential-guest-support.h"
 #include "hw/boards.h"
 #include "hw/s390x/sclp.h"
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 8d9d68da4ec..0f23681a3f9 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -17,7 +17,6 @@
 
 #include "hw/vfio/vfio-container-legacy.h"
 #include "hw/hw.h"
-#include "system/ram_addr.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 1de2d3de521..15ba6799f22 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -25,7 +25,6 @@
 #include "hw/virtio/virtio-mem.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "system/ram_addr.h"
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-- 
2.51.0


