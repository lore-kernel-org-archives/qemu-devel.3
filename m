Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860B2C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgiZ-0001gV-7W; Thu, 01 May 2025 23:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgiW-0001dW-7e; Thu, 01 May 2025 23:05:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgiU-0000IQ-8B; Thu, 01 May 2025 23:05:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73bf5aa95e7so1548234b3a.1; 
 Thu, 01 May 2025 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155131; x=1746759931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85Zd/mblli+U4+pxVxRHC9U0CP9i94iwyTWbD8xhhJE=;
 b=S1VaRkMHoiTYcHaAMl7tq4kDBpo72N+2LGrBH8ALyq/7NbTOduUNdrsEwx/HIaktHs
 GpobCbaw9qkoEo4UYgV+idgowUKBwIOiPN9pcir0g714PefX54p7sKmO/sjBpW5kTNug
 +fLvAuk8CuEPFKxI/uoJnE6eGeU+E2LofpjBxVNEwcD9uwzU7FCYvbdK8iIR1JO2eQQ/
 zIE39gjkt4ms+jeV3Ss6Hz1BSbPYsEvVJLkSQv9CEEUa7BdJ3f26bLW592WhVGFnIyo7
 +pg873HMfEJzvSs2RoMHI/YeUD/eddDjeXjY7IaALRyypSmivonFDxaJ5kXByGHs6Hqh
 vGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155131; x=1746759931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85Zd/mblli+U4+pxVxRHC9U0CP9i94iwyTWbD8xhhJE=;
 b=DKsMke1WDiBq0RWrvDYNfbgtr6DEveBYPWYLQDC6NU0L0iUND/Wz1vpjtyJIms8frt
 Wm1fEQCgZ0Lg8vjPt0oSUdT6RDtMDkZkeWbfR7sobg1jMxUePnxJwUA78YMxRQOd0UGc
 R0bWXFsfNJxS1gteVMhDb6RYT3Gl2yyHvJRNiy0OGXiT9z9PD/yI+i+EubzN7tpXvigZ
 bOanWRoBuiViw2r8XLuDIuw6XHlCrgpk9kUQtTiwfuqcAnmDQQ+AylAgKUtCL0GMCrqY
 USqVk1mgUzTJeGNP3EoHsQGPPjVi2vNW9E9r+gl4dgcTjYEwqU/T4czH5J3NmjoIhxKt
 E8pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqbZRnseOtMoa5uxyVW3TLOAjTIyxLUs85gTCyS7eB158WzOEcOoh0iWUQU4rUamh1WMQrdCwVfV0=@nongnu.org,
 AJvYcCWxVkgE7RNzn5BXj1t03rEJNbFYjYaZzhB+T81NymL38lp1wEoKHdhR3erwXRNQ33EvV6/QmDmDzNvM@nongnu.org
X-Gm-Message-State: AOJu0Yx/Uza5E6/XiOj5WrAnqcNDmZokMwwC1Uvu2SbUEa/FoEmpCtpR
 Ky4NY+ODtrGe6mUZaVf8X6DYM/hRUxow0hIAuCEWYMVkQ7ioSAjk9+vh/w==
X-Gm-Gg: ASbGnctnwxKaVg5yITlJuusYQclITLdhcuH01qfoCv86Qao4NB7MAWwOCCLI7fmKMRR
 bem3+ttGVe5rXTMzB0dqafD0gNoNTr7JjHauST5BT5siA6tdcVQi0MhW9v2+da5GVB/WW0Y01ZB
 L+JP+gVQcFN6Dtdi3e1P77ZX+L0QqG9aQwIAe82/vVZ3adz3QriNtl7TGGy8x+yo6VFQm9M08o+
 3/J2WUAYlatQkVUxDeNkvNyJDlHounnZhDRfE+WxAR4vS+B0yoej3eGs9L0/nzu4onRFGO2fOPv
 TQiDtgAgJ/25zgGgPzzY9KY8dTUVcVta8MeRrOjrt88l
X-Google-Smtp-Source: AGHT+IFDPgoxxd6icukls0pekzD9vKVU1eoFBB/twmC5W4IupRQY0l8uU/edV+aA+u0tnxwLwHOu6g==
X-Received: by 2002:a05:6a00:2791:b0:736:b9f5:47c6 with SMTP id
 d2e1a72fcca58-74058b11d08mr1883470b3a.16.1746155131199; 
 Thu, 01 May 2025 20:05:31 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:30 -0700 (PDT)
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
Subject: [PATCH v5 06/11] tests/qtest/ahci: don't unmap pci bar if it wasn't
 mapped
Date: Fri,  2 May 2025 13:04:40 +1000
Message-ID: <20250502030446.88310-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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
Cc: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/ahci.h | 1 +
 tests/qtest/ahci-test.c   | 7 ++++++-
 tests/qtest/libqos/ahci.c | 9 +++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index f610bd32a5f..d639692aac4 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -342,6 +342,7 @@ typedef struct AHCIQState {
     uint32_t cap;
     uint32_t cap2;
     AHCIPortQState port[32];
+    bool pci_enabled;
     bool enabled;
 } AHCIQState;
 
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 36caa7b2999..7d5f73ac40b 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -85,6 +85,8 @@ static void verify_state(AHCIQState *ahci, uint64_t hba_old)
     uint64_t hba_base;
     AHCICommandHeader cmd;
 
+    g_assert_cmphex(ahci->hba_bar.addr, ==, hba_old);
+
     ahci_fingerprint = qpci_config_readl(ahci->dev, PCI_VENDOR_ID);
     g_assert_cmphex(ahci_fingerprint, ==, ahci->fingerprint);
 
@@ -198,7 +200,9 @@ static void ahci_shutdown(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;
 
-    ahci_pci_disable(ahci);
+    if (ahci->pci_enabled) {
+        ahci_pci_disable(ahci);
+    }
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
@@ -1421,6 +1425,7 @@ static void test_reset(void)
         ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
         stop_ahci_device(ahci);
         ahci_clean_mem(ahci);
+        start_ahci_device(ahci);
     }
 
     ahci_shutdown(ahci);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index bd1994a9208..cc4f5b7b534 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -215,17 +215,25 @@ void ahci_pci_disable(AHCIQState *ahci)
  */
 void start_ahci_device(AHCIQState *ahci)
 {
+    g_assert(!ahci->pci_enabled);
+
     /* Map AHCI's ABAR (BAR5) */
     ahci->hba_bar = qpci_iomap(ahci->dev, 5, &ahci->barsize);
 
     /* turns on pci.cmd.iose, pci.cmd.mse and pci.cmd.bme */
     qpci_device_enable(ahci->dev);
+
+    ahci->pci_enabled = true;
 }
 
 void stop_ahci_device(AHCIQState *ahci)
 {
+    g_assert(ahci->pci_enabled);
+
     /* Unmap AHCI's ABAR */
     qpci_iounmap(ahci->dev, ahci->hba_bar);
+
+    ahci->pci_enabled = false;
 }
 
 /**
@@ -249,6 +257,7 @@ void ahci_hba_enable(AHCIQState *ahci)
     uint8_t num_cmd_slots;
 
     g_assert(ahci != NULL);
+    g_assert(ahci->pci_enabled);
 
     /* Set GHC.AE to 1 */
     ahci_set(ahci, AHCI_GHC, AHCI_GHC_AE);
-- 
2.47.1


