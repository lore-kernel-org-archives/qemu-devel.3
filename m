Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A51C369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:21:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bXE-0001Q3-84; Tue, 15 Apr 2025 04:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u4bWN-0007jg-1z; Tue, 15 Apr 2025 04:19:55 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u4bWL-0002hZ-2y; Tue, 15 Apr 2025 04:19:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22423adf751so47819705ad.2; 
 Tue, 15 Apr 2025 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744705190; x=1745309990; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0JJKI5JSSPG9HV9ebWkOQYWwmgSY1J55Hh8hs1+6Djw=;
 b=Pivd/6xcMZiAiMPI1kfK+5tMFoToOi702WrXKT1T15ELwxUYJtCWOwTwefs3YU1d1J
 Jd0vsRgRCotfPQy0pSc8vMalQyITkrQrtP/uS35U1lKS4SdOCvdSI5Zq0LGYJe7UqCCH
 5avh2hwOXWAKpmmzFQP9j79/g2+UjxGlVyG9djEEfQYTW5Uj0WXglPQKDkmMzKObsgrJ
 Cok/72hsIlPTC7oXHq0Dc/h2BSfLC/j8D+UJI8UG384yzhRDl/wPyy2fXwfbxCYy16PM
 Lu7zIPpNFGuOegAolADY5MFOcuUTZmp0I40tE0ORHheFSZpIFPrTMv/h7n9GIjdT8zuZ
 OnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744705190; x=1745309990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0JJKI5JSSPG9HV9ebWkOQYWwmgSY1J55Hh8hs1+6Djw=;
 b=h4wV3Id9FWM40g5yX2s9pN/6FHUrpbfZwofag9SwTSzQVN08eYd2hQsgrqZpR7tpIp
 iiAltf/HQg4oVWxilpqMphO/3lPGuDfMNo3hUxYrQ88Mk4d2tFjNr6Na7aON7CIaBr6p
 yGRSbTegulvaYetTEqAvBtNdm74OCL2iO/OJkQU+u/OSgUGFgRKm7OjZxf9kaG08VpK8
 4vqQX8jgvQWF7npAD0kmaPe9BgCNUgbYSECwiqX+ahkU3mehc9DGC5apH08cCgSh5gxR
 omtdXT4ArJbI2AU2a9Mzn2aIyiyvRpMEP36IRkNBv+2cO+dkJmUYWeWPKyQXHix1fVfh
 LrIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKzIHyrM9N+19puovurwzeQfvuNbBcnnoHbO+n6Er0cGltHdIYw/2fArhm2G1neNreidywSxH0RlBL@nongnu.org,
 AJvYcCW6ecJim3GYLYmuLxu0yVRzzBWGSCA5pwqdLkDG8uuskOBnCchm05OY3W3jrr57h+EF1zq0rkchW8xNCg==@nongnu.org
X-Gm-Message-State: AOJu0Ywbkwnc3w+qyUxCG03ukVib1K4Kakg1+NeDPJa9Mv6gi381vMLi
 gv6WGu6U9Jic2hRqTbxmbkPMiusdw/pludmw6iRN0/o/9nmX4jM7IxqrgQ==
X-Gm-Gg: ASbGnct+uibOJPMBjq2z8ANoum/mkk89eOj8+MxruaHyW7lE9bVkGzkAP/lcyPP4shS
 aoM8oQYqLGW9agC9P4i2AqBXsz37LVhvFXprZ2WuQjnZ18rWuCumh9iVzkl9dn6y5GorxdcF4JD
 WCk8FXTcI+ono5aRMTaY4RfFG8/lkjZxp4rHhAvEZU/PNgrDFz3YBxexdZy5kwwr+PfER5qst7r
 0J1QnKamC+vdqoVPvdEmUOf3D7BrXukiLGbiPvlPd2EWwDvlg+YIZY9+1BBBFeUB6EZUX9Icl02
 bBOratLeQiDtCL0HIY9H0kxekKpRinVF6yxz+GLXnjxLqmwwEedAFHpJZGo3rdN1UpRlQhSmZRI
 PZzHVhALiquCum+MP/tRgNZUetAAW64AfJ44lcBwP7GGmjULTWv8=
X-Google-Smtp-Source: AGHT+IEQ+D4qE9ZfSFqFzBDcSa/5wZD0VEovtzCIV58kFU1SVyGk3s/w8ZrxVv1hrYiXB3w86uSgFQ==
X-Received: by 2002:a17:90b:2dd2:b0:2fe:afa7:eaf8 with SMTP id
 98e67ed59e1d1-30823670affmr23192680a91.13.1744705190472; 
 Tue, 15 Apr 2025 01:19:50 -0700 (PDT)
Received: from wheely.local0.net
 (ppp118-208-164-196.cbr-trn-nor-bras39.tpg.internode.on.net.
 [118.208.164.196]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df08f63bsm12543098a91.24.2025.04.15.01.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:19:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [RFC PATCH 1/2] tests/qtest: Fix virtio msix message endianness
Date: Tue, 15 Apr 2025 18:19:13 +1000
Message-ID: <20250415081914.378236-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250415081914.378236-1-npiggin@gmail.com>
References: <20250415081914.378236-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/virtio-pci-modern.c | 9 +++++++--
 tests/qtest/libqos/virtio-pci.c        | 7 +++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 4e67fcbd5d3..67aa2af0bd7 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "standard-headers/linux/pci_regs.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_config.h"
@@ -136,12 +137,16 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
         return qpci_msix_pending(dev->pdev, msix_entry);
     }
 
-    data = qtest_readl(dev->pdev->bus->qts, msix_addr);
+    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, 4);
+    data = le32_to_cpu(data);
     if (data == msix_data) {
         qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
         return true;
-    } else {
+    } else if (data == 0) {
         return false;
+    } else {
+        /* Must only be either 0 (no interrupt) or the msix data. */
+        g_assert_not_reached();
     }
 }
 
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 002bf8b8c2d..6b421a4d859 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -131,12 +131,15 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
+            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr, &data, 4);
+            data = le32_to_cpu(data);
             if (data == vqpci->msix_data) {
                 qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
                 return true;
-            } else {
+            } else if (data == 0) {
                 return false;
+            } else {
+                g_assert_not_reached();
             }
         }
     } else {
-- 
2.47.1


