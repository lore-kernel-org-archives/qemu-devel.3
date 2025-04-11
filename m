Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BA0C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36DB-0003Ep-KL; Fri, 11 Apr 2025 00:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DA-0003EO-DO; Fri, 11 Apr 2025 00:41:52 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36D8-0001c1-Kr; Fri, 11 Apr 2025 00:41:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224341bbc1dso14994355ad.3; 
 Thu, 10 Apr 2025 21:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744346508; x=1744951308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lYQSLH9OUcacfFWWtc6NBDhhW0SrOAqjv9niMxwZuU=;
 b=cAXoeze4C5TBqiXG+X9SXBseHPjSU9ZEd05d5dj4+A6P3WegCmJPVEpfC8q7GMEDxW
 AHCUM0ByK06iKuYRWW6zuo0M4aY5WaIPgi3UEhNRdj5L9h61Z9Kqn9twTxHcnqoxaE9Z
 XXKagrCy7ICu/uV/gHsIsyaOduk32iBSCu3gt/0IxOMsWGyopFIyazUdVNSpfa6oK0BA
 kKtQ8HRKmFPEKznHLAYn/RvFdj5J96JVNIaHTsQbSgjeVHRw7g38K/XeiWZJIgOdYcom
 gEaaG4Zh9fXc7pVHpel9HG1onmG/pU7DfGf0VxjGADnzAPW2Z2bZgv6K9Ok8Z6Wl149/
 y9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744346508; x=1744951308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lYQSLH9OUcacfFWWtc6NBDhhW0SrOAqjv9niMxwZuU=;
 b=LgaymSZpmbLHJialy7cr+Wz5CbojOfyazVqpPacaVJ+KjVHXMAUIcADqQEMGZRAoAA
 TZZ/EHw1QeNEhhDaM8TxE3wIbTCB+iaJ+HIi+E5VEnnemnR2f5Qc3fyAcxBcECv6AUp1
 Bz+l4wW/ZYLDFC7ptrLEnrEZdw+kz78n2Ik0RIK1YFxoNtfUx+RN4CdIxAXyT/f3FRJl
 mbGJgECz0a8v3OYNz/KXpBwaG3g9NPWjLyxHhK9AuczwQAVDOc7egkYyV77FTcI9GSju
 /z7GOxEiLA5ebkmUaOZwSjE2trXTwVQtxJLTljbetvmUGeSB6FHAx/lppSWLm4EHXNxU
 mz5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQI9Pn5bIX5ayFItU55U5N5ADJU6ALGvHs73jjQD2PheAvH8Jgb9TF/Axj2PqxxLX2ueau06EdTQ6c@nongnu.org
X-Gm-Message-State: AOJu0Yxp1hxnVsoWbF/1QtEairv4D6fOZvY8oBf3x5Jflcq0kPc8purA
 JWKplxAl2web5sGi8aOOzBIe30ttfy9qytx1iUaGBl4lUL6TqfBk31xr6g==
X-Gm-Gg: ASbGncsyY6FPkHKhzRft/CnjDSmvBPEQqzgR51FSc9frgxmkmNBN2BjGuetyWrI0vZ9
 BuoIKOUjtZmS+5IlXiky6wx/KDucaIIFjrjHdg1iPG1Gzjzlza7rWt64GhctAv4meTeuKcx38zs
 xdcdoyz7sJaohBCojCRnU/F10pyjbVFnMkPognwy1yG5WhBPKghIS+UBWY3JXXsd36xARweDlV8
 CtO8aY4JXW93pl67Us+oprk0C9o1M+H5gEQMOz47D3hZTl4heob078dUmV5m9T/4d6xo04+cw6W
 5+7r98X5uyDN7SHPByFK6CaYRisX/zIUA+k1YV3lx85R
X-Google-Smtp-Source: AGHT+IFst1buBogpUZRva6fTa9aq7I3/mso8A+T7Vpigl3nZioJ+nx/encnx+PQrQW3IRWOCi2BHSA==
X-Received: by 2002:a17:903:1c5:b0:223:5ada:88ff with SMTP id
 d9443c01a7336-22bea4bcf30mr23126625ad.24.1744346508543; 
 Thu, 10 Apr 2025 21:41:48 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971e4sm39672745ad.136.2025.04.10.21.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:41:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v4 2/7] tests/qtest/ahci: don't unmap pci bar if it wasn't
 mapped
Date: Fri, 11 Apr 2025 14:41:24 +1000
Message-ID: <20250411044130.201724-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411044130.201724-1-npiggin@gmail.com>
References: <20250411044130.201724-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

ahci-test has a bunch of tests where the pci bar was not mapped. Avoid
unmapping it in these cases, to keep iomaps balanced.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/ahci-test.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 7cae6b58e0c..02c9d54f898 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -85,6 +85,8 @@ static void verify_state(AHCIQState *ahci, uint64_t hba_old)
     uint64_t hba_base;
     AHCICommandHeader cmd;
 
+    g_assert_cmphex(ahci->hba_bar.addr, ==, hba_old);
+
     ahci_fingerprint = qpci_config_readl(ahci->dev, PCI_VENDOR_ID);
     g_assert_cmphex(ahci_fingerprint, ==, ahci->fingerprint);
 
@@ -193,18 +195,28 @@ static AHCIQState *ahci_boot(const char *cli, ...)
 
 /**
  * Clean up the PCI device, then terminate the QEMU instance.
+ * Should be called if ahci_pci_enable (or ahci_boot_and_enable)
+ * was not used, or device/pci was disabled later.
  */
-static void ahci_shutdown(AHCIQState *ahci)
+static void ahci_shutdown_pci_disabled(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;
 
-    ahci_pci_disable(ahci);
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
     qtest_shutdown(qs);
 }
 
+/**
+ * Clean up the PCI device, then terminate the QEMU instance.
+ */
+static void ahci_shutdown(AHCIQState *ahci)
+{
+    ahci_pci_disable(ahci);
+    ahci_shutdown_pci_disabled(ahci);
+}
+
 /**
  * Boot and fully enable the HBA device.
  * @see ahci_boot, ahci_pci_enable and ahci_hba_enable.
@@ -945,7 +957,7 @@ static void test_sanity(void)
 {
     AHCIQState *ahci;
     ahci = ahci_boot(NULL);
-    ahci_shutdown(ahci);
+    ahci_shutdown_pci_disabled(ahci);
 }
 
 /**
@@ -957,7 +969,7 @@ static void test_pci_spec(void)
     AHCIQState *ahci;
     ahci = ahci_boot(NULL);
     ahci_test_pci_spec(ahci);
-    ahci_shutdown(ahci);
+    ahci_shutdown_pci_disabled(ahci);
 }
 
 /**
@@ -1143,8 +1155,8 @@ static void test_migrate_sanity(void)
 
     ahci_migrate(src, dst, uri);
 
-    ahci_shutdown(src);
-    ahci_shutdown(dst);
+    ahci_shutdown_pci_disabled(src);
+    ahci_shutdown_pci_disabled(dst);
     g_free(uri);
 }
 
@@ -1182,7 +1194,7 @@ static void ahci_migrate_simple(uint8_t cmd_read, uint8_t cmd_write)
     /* Verify pattern */
     g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);
 
-    ahci_shutdown(src);
+    ahci_shutdown_pci_disabled(src);
     ahci_shutdown(dst);
     g_free(rx);
     g_free(tx);
@@ -1324,7 +1336,7 @@ static void ahci_migrate_halted_io(uint8_t cmd_read, uint8_t cmd_write)
     g_assert_cmphex(memcmp(tx, rx, bufsize), ==, 0);
 
     /* Cleanup and go home. */
-    ahci_shutdown(src);
+    ahci_shutdown_pci_disabled(src);
     ahci_shutdown(dst);
     g_free(rx);
     g_free(tx);
@@ -1388,8 +1400,8 @@ static void test_flush_migrate(void)
     ahci_command_verify(dst, cmd);
 
     ahci_command_free(cmd);
-    ahci_shutdown(src);
-    ahci_shutdown(dst);
+    ahci_shutdown_pci_disabled(src);
+    ahci_shutdown_pci_disabled(dst);
     g_free(uri);
 }
 
@@ -1421,6 +1433,7 @@ static void test_reset(void)
         ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
         stop_ahci_device(ahci);
         ahci_clean_mem(ahci);
+        start_ahci_device(ahci);
     }
 
     ahci_shutdown(ahci);
@@ -1508,7 +1521,7 @@ static void test_reset_pending_callback(void)
     stop_ahci_device(ahci);
     ahci_clean_mem(ahci);
 
-    ahci_shutdown(ahci);
+    ahci_shutdown_pci_disabled(ahci);
 }
 
 static void test_ncq_simple(void)
-- 
2.47.1


