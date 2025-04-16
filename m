Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC3C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 15:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u54FJ-0006mY-Pw; Wed, 16 Apr 2025 11:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54Et-0006cS-DS; Wed, 16 Apr 2025 10:59:48 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u54En-00036r-TH; Wed, 16 Apr 2025 10:59:46 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227c7e57da2so62897135ad.0; 
 Wed, 16 Apr 2025 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744815578; x=1745420378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyvoNMD/MGbgPmwNNQJl9p2mFi5GZdgxMiyr2KvPotM=;
 b=Ba5sh9tOpgF1aqEDcjI5bl9pugkKB5NoXCPoL7JU3yjVhdq16cnoSpSvjGpVRl2iHE
 xIBxeGIfbRaYaK9mkwsIXR+jzmVnKjW5CN8NH0Cce4kbezjjaC3mf6GLNP/9v4xKaHD5
 AGVadjzqTX6wpXkuUO6z/xWYsLPwXWIzSEQFBxi2cmFufc9B1EmKu5aKN2GcReOY6T0L
 JIS/2W/cEJqtFHiOJJQJysM9fLdHWI46TW8cm+K3gkdfbAUkxSe+4xY/Ty6fbSv1OoWm
 0LOaBlREQgxnVFG7Vjd5aXAs8ac2F/jHRQ3lewfB+pnbpAV5MRBvd1YBsbWer4eQldc+
 fSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744815578; x=1745420378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyvoNMD/MGbgPmwNNQJl9p2mFi5GZdgxMiyr2KvPotM=;
 b=P96QrDTHcqZYgYSmeXRu5HijIXgeca4MMD3NxG8Pqvovb/Bg0iEBFsOEIVGo3rcJbQ
 UR6XSglAyD2v1VzTl5jXQljrcmuz4yoBfkBYre6hlttQUZ1svYiT4RJ/76mnkaqtW8BZ
 pde9OKLbjFP3McoX0wF1qfKioymouZjkUHNy/ShicJrfF/ey8qW6usfkGcrSYMAq54+B
 A2amU0C70ur1Eh4W2rbfEoIK8dds3Q46piHwIHkT753yH3zGOCcIktrN4Sc6G2q36baf
 1JhbkcXsYcslatGkkuGhHZsUEJ/SQri7RARxOE0D3vj5PFFwDE7c8zN2zVvjFMIpV0Ad
 OzQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd9V2UlUH+KIN8cblQOx/RWXKdO18JZk5ruSn7mmcU998RFFB463B8i4uLXXCGxagqLPojT3KhBV/GAg==@nongnu.org,
 AJvYcCXt4I8YjNPctRc/vD9MRx9w9/8yQTzg+wiqIftP8GJb0edzhRUND51HP6YybyNZxnfzOwTLHJTag2fg@nongnu.org
X-Gm-Message-State: AOJu0Yw7M7337BxMtcfciLvobPD0YpGCEDOsJeqw+BAKjhE4fm23eO3Z
 VP9WK805fczmKQLzDaxHkUJH++t0793sj9z2JkeBWIrgyalVmi5HaEBQDA==
X-Gm-Gg: ASbGncs8JlCa1zgdCfm+fEKOYfoUH9V5KAWTNDl++epsFbrf+NxLQl7bZ++DmXvTTQ6
 vYRG2Iwn5hAO+HCuS2OvO8iNa9VR4Ct+FTWpAuNX6JlOOLbhvuafmS6DSiuMj71viHefjFfgc9f
 XSsM5/XwGE3NsiKdyoB4Rkven24WgMn7fBBAeG/TKpAmCEu7F4BY4+vB2j0yqFvAQqZzy87qd1s
 1ciwER6gFZLqttumF7rfcMt4LMwhcAhdwsQOItdCC6yXwA2BbjqWsEWv0uTkVuZ8vNml/oxR4/u
 SALi4gdxDkst9kleN8kz+F88NQftxEyI4yPvdQ9Auw==
X-Google-Smtp-Source: AGHT+IHyUsvFSEPPqJyGG0q7Ktigwy3M9LlmGN6QgT66bjF0HOOKhwvrvBYNeZAeB5cIlPq+LLQBdw==
X-Received: by 2002:a17:903:3c4f:b0:21f:45d:21fb with SMTP id
 d9443c01a7336-22c358c61a6mr33034405ad.3.1744815578317; 
 Wed, 16 Apr 2025 07:59:38 -0700 (PDT)
Received: from wheely.local0.net ([1.145.55.85])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e355sm10814506b3a.139.2025.04.16.07.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 07:59:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [PATCH 2/4] tests/qtest: Fix virtio msix message endianness
Date: Thu, 17 Apr 2025 00:59:16 +1000
Message-ID: <20250416145918.415674-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250416145918.415674-1-npiggin@gmail.com>
References: <20250416145918.415674-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

msix messages are written to memory in little-endian order, so they
should not be byteswapped depending on target endianness, but read
as le and converted to host endian by the qtest.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/virtio-pci-modern.c | 4 +++-
 tests/qtest/libqos/virtio-pci.c        | 6 ++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index f31b3be656d..5dae41e6d74 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "standard-headers/linux/pci_regs.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_config.h"
@@ -136,7 +137,8 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
         return qpci_msix_pending(dev->pdev, msix_entry);
     }
 
-    data = qtest_readl(dev->pdev->bus->qts, msix_addr);
+    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
+    data = le32_to_cpu(data);
     if (data == 0) {
         return false;
     }
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 102e45b5248..76ea1f45ba9 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -131,7 +131,8 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
+            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data, 4);
+            data = le32_to_cpu(data);
             if (data == 0) {
                 return false;
             }
@@ -156,7 +157,8 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
+            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr, &data, 4);
+            data = le32_to_cpu(data);
             if (data == 0) {
                 return false;
             }
-- 
2.47.1


