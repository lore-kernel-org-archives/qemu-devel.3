Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC7BC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgiC-0001KP-BI; Thu, 01 May 2025 23:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgi9-0001JZ-5C; Thu, 01 May 2025 23:05:13 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgi6-00087P-O9; Thu, 01 May 2025 23:05:12 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso1865709b3a.0; 
 Thu, 01 May 2025 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155107; x=1746759907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyvoNMD/MGbgPmwNNQJl9p2mFi5GZdgxMiyr2KvPotM=;
 b=LccGEQ5AtEs0o01GjYRnux3mSrQvKT2mIujeuY2Q9jzmmDrz/ci0yCASFJ5TI/cQVq
 VOo3mypej6MGkHlJbbRPANV7YxuggqZmMPUL05fR0ptIXAifa0ZIr7uP/OXFTA/EoK3w
 f/htluUBl994hfTi11qapl6JX/wpVmMrFSwc0W8Mhyo5M9yofXL7Nm6kXgfCmHoGyraH
 w+Pa70cXfvd2awZRIyktaWXVzktLQmUbFmzP4tqdHHuO+9SiIHvjkc6QzhOu53qG6jyX
 SwFr3MnSGIK1g3LaQWmTiuCmDKnO55NG+C77AMos5me8bGYsRBj/KoccJDkvMihK+ec1
 9Cpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155107; x=1746759907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyvoNMD/MGbgPmwNNQJl9p2mFi5GZdgxMiyr2KvPotM=;
 b=O+fCefC+jFRDNgT3I2trEo+Lk2XB9i7GSpfMLfCKfvF6Rb5FTB4GyG2yJTOuFTefCa
 QwPjxlu4tUIntBHXol0DY9tQ0YhqfaPDuLRRlnfGs5qoLISjd2fVqOxWycYdcf96DaUx
 qmFLtkdUtco4zl1Z84zS21TPQFFkvqbH9USoGIpkPECi6Wz2VHPwfWbRxoNjysCo58c1
 OoY7Ltwu6ehvljrVBk1LsJ7175h3NHBIprAzGfv4q85F6kInaK3RHd15jOk6BmlI/OrL
 wmfofj1kcjWPJIeuVKr3+c2mOlgakh6QJZACgogXPYfWoa3jAYRLDCtMxZdxhcPclCed
 MN1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU80G0EnbMHxGq2NiJyoIfqiGAMlvK3eahcDyXEJ9Fxs6LFdrwkeF++XJP59xUVgTikEPXNU3QS6i1s@nongnu.org,
 AJvYcCWayCxUH8wXJT35tLyE9WeTugeiW//NwHFJ7DRtGf6SKHfwZdFH49XUwxhEcQh9Ty23rDw9jE/qAHM=@nongnu.org
X-Gm-Message-State: AOJu0YzC2tFZl9LwWlI9lx3oaW25dVoIPJfgZvvaHqXVw3MG1vPM4qLS
 HlfuQiB30Z+gd6f9fXX7NcgEgPXrZjmMSN+PiMHGOG/oE+gkwFZHCQQ+OQ==
X-Gm-Gg: ASbGncteRRHFFNniKlNswRrxDAT4vDDgtFNdzl+qbjE8y2X8EPbJgeX33hbaAPLnCVD
 hd/gI9upC1CvCeMxv8dCR8ZZsvMHfcsY8jy4HXpdTisdX9cddJQ2mS7ZJGOwnbV4L06EX8Qo8Ii
 iB7qM8qeTWwaEjk7LMXOrZkgHRBtMBNvule7WcuJVkNaGSP35Ysko0C+wMd49N8052gSFpR3Oh9
 PuaZLUs5R67ORUvPag/mJrfQ7qfYS2PsO+UfRIHLBcb5GsafiZHrEcvIgp3132I/e+jpKwtUk4x
 FODCRvQIvN7pc6Bq/n8Kte6jVQjWywV5DTZbphTkir1X
X-Google-Smtp-Source: AGHT+IF5TYxfNmocc6bkCZOdo4qMI6qvavCE3WjJoDgXq/tAspIQhAXCTMzrzHcLSLpchQLCJbTMHQ==
X-Received: by 2002:a05:6a21:7702:b0:1f5:9431:46e7 with SMTP id
 adf61e73a8af0-20ce04e692bmr1754858637.42.1746155107511; 
 Thu, 01 May 2025 20:05:07 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 02/11] tests/qtest: Fix virtio msix message endianness
Date: Fri,  2 May 2025 13:04:36 +1000
Message-ID: <20250502030446.88310-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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


