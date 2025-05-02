Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F58C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgiR-0001Ps-1u; Thu, 01 May 2025 23:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgiP-0001OO-Ao; Thu, 01 May 2025 23:05:29 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgiN-00005E-Jo; Thu, 01 May 2025 23:05:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7376e311086so2381569b3a.3; 
 Thu, 01 May 2025 20:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155125; x=1746759925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUOflv3alOGiol4S47wnqGVZoQeo26ssH01OhsbUcno=;
 b=K/0JObhJUXGRz+3D7oMdSdwpZ1eHtrscyLuHL3dazYlJkg2nw/m04xOVFyhWvv/vDu
 VAbdsua7kDXxtBjfBeUB30eFa++cZJr/Co3b2zlW1TKsVGDboxfQvy7m2HlPKyO2xSsS
 J4vXT2sPCkPnh/VAs736kbSaC4fIvJfFinWIW3YVNAiPwjjuNoz1xm+tGK7S2kESDrPF
 8KSPNoBF5+1w08+YFz7b49GLp6WsDGt3wFVlL9VC/q/c5t/oJv5kUOM/BePKNhYjg+fo
 EBM+wEnsU83cabruPyuT8emdq3UpYFDB0cx10FWSlQ2Ebp3EoCgAgQ+HBlmIDiERBMOL
 IPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155125; x=1746759925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUOflv3alOGiol4S47wnqGVZoQeo26ssH01OhsbUcno=;
 b=s+oxEpqtj7CvyF1EEwrli0GiO2VHHQ6iCTtBeRdF6BWteiboF5+2QjAcQUQcSsiTNd
 QM8aGJ+/RX1xBCq5dQ/oCiEq0lc+OHRbwKSc2eSsNiQE0ISWN9lBH4uBK2ChgTLxk5lC
 X9iDRVMDr/SbMKE6zunVa3vbfZlVUaCWZfWEdxx5gfTx5GIz6UN4pY5dNcd+AUgQwpkg
 pOl6e4/UwrpGb0/5460crfVdL7oIdDh5js0FB0xpmM8RJG91TiLYHe7wvQ/mPVdiuquB
 9EKjVFMWErUMve41Uh8KEfTEx6tuPhM+KIE37c2ul3Ff9wBu0GMhz5XM7wmeYFfV2s9b
 eJYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTAKeBYoSt5JaumS7y66j03ABqj69u7/JAKWTYiLcIH+t1XW5SQXz+xUfchAL8HX2HIc05FuQnuX84@nongnu.org,
 AJvYcCUZ4ibpN7sd2cquLKd7p8LdpRno3uGcYJ3odyOhOSAdKnSlf+B6OP2+d7mpO6DvOp+iDS9lxhPgO68=@nongnu.org
X-Gm-Message-State: AOJu0YxV5yPHec4kM0fwdnqohxo05Po87Cr6kC5j6JMNW/nsoDWwE8mx
 jfuwZeYw+9pZ4WgkPcpTh+hZvBGyMvAF5mH4XGVMunNNK79zSQY4KnKdVg==
X-Gm-Gg: ASbGncsbJD277f7hkWUWS3j7sXeh8adLeQ/kaqiuXvY1fMMn5/OILOkpsGQSmmCIapd
 unoI4Xqd0q97bcdipeHONSSMmZUk3tDvDJLUOM/zlmFlJYENg1CAoIsfyMQKnRrnm7Xbm0XjnVH
 EYf1ontlBJJPlsUR8mX0ECLANgsl8lKi+uf6ecokMFuM63StnoZIrOdaBSvmcyVP37UlEqI2QgC
 vTA3TVG/wzElue170NDB6yZY9hfc8v+4h+Fk5OnGOK6rvMOBHKtnAxsWPn3ANPqzqGKPikSUReT
 tEkDwT2mkerQ7YluuZiJ4NcJGC2aGcgG3aw/X5/1BD5o
X-Google-Smtp-Source: AGHT+IFzLp4UxAOXhR1w+7bk9AjQ9dY6f69C/9n9/xsAtdWM8nEWuYAej2Uv1ZNStxs+JuH4bdxqcw==
X-Received: by 2002:a05:6a00:340c:b0:736:a8db:93b4 with SMTP id
 d2e1a72fcca58-7405890a9f3mr1874428b3a.2.1746155125203; 
 Thu, 01 May 2025 20:05:25 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:24 -0700 (PDT)
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
Subject: [PATCH v5 05/11] tests/qtest/ahci: unmap pci bar before reusing device
Date: Fri,  2 May 2025 13:04:39 +1000
Message-ID: <20250502030446.88310-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

ahci-test double-maps the hba bar in the pending_callback test.
Unmap it first, to keep iomaps balanced.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/ahci.h |  2 ++
 tests/qtest/ahci-test.c   |  4 ++++
 tests/qtest/libqos/ahci.c | 11 +++++++++++
 3 files changed, 17 insertions(+)

diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index a0487a1557d..f610bd32a5f 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -574,7 +574,9 @@ void ahci_clean_mem(AHCIQState *ahci);
 QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
 void free_ahci_device(QPCIDevice *dev);
 void ahci_pci_enable(AHCIQState *ahci);
+void ahci_pci_disable(AHCIQState *ahci);
 void start_ahci_device(AHCIQState *ahci);
+void stop_ahci_device(AHCIQState *ahci);
 void ahci_hba_enable(AHCIQState *ahci);
 
 /* Port Management */
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index e8aabfc13f5..36caa7b2999 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -198,6 +198,7 @@ static void ahci_shutdown(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;
 
+    ahci_pci_disable(ahci);
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
@@ -1418,6 +1419,7 @@ static void test_reset(void)
                                CMD_READ_DMA_EXT,
                                CMD_WRITE_DMA_EXT);
         ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
+        stop_ahci_device(ahci);
         ahci_clean_mem(ahci);
     }
 
@@ -1484,6 +1486,7 @@ static void test_reset_pending_callback(void)
     sleep(1);
 
     /* Start again. */
+    stop_ahci_device(ahci);
     ahci_clean_mem(ahci);
     ahci_pci_enable(ahci);
     ahci_hba_enable(ahci);
@@ -1502,6 +1505,7 @@ static void test_reset_pending_callback(void)
     ahci_free(ahci, ptr1);
     ahci_free(ahci, ptr2);
 
+    stop_ahci_device(ahci);
     ahci_clean_mem(ahci);
 
     ahci_shutdown(ahci);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 34a75b7f43b..bd1994a9208 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -205,6 +205,11 @@ void ahci_pci_enable(AHCIQState *ahci)
 
 }
 
+void ahci_pci_disable(AHCIQState *ahci)
+{
+    stop_ahci_device(ahci);
+}
+
 /**
  * Map BAR5/ABAR, and engage the PCI device.
  */
@@ -217,6 +222,12 @@ void start_ahci_device(AHCIQState *ahci)
     qpci_device_enable(ahci->dev);
 }
 
+void stop_ahci_device(AHCIQState *ahci)
+{
+    /* Unmap AHCI's ABAR */
+    qpci_iounmap(ahci->dev, ahci->hba_bar);
+}
+
 /**
  * Test and initialize the AHCI's HBA memory areas.
  * Initialize and start any ports with devices attached.
-- 
2.47.1


