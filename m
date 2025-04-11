Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A98C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36D8-0003De-U8; Fri, 11 Apr 2025 00:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36D5-0003DB-Et; Fri, 11 Apr 2025 00:41:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36D3-0001ah-VA; Fri, 11 Apr 2025 00:41:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22403cbb47fso16550725ad.0; 
 Thu, 10 Apr 2025 21:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744346504; x=1744951304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=npWwzJvQM/483RZnV/1gsYUruF9uzp3Jiju7pOepVLE=;
 b=L/SePEEPNsJEwFTyq+zeH6z0pUaUmmDnOi+e5R+GP6QHM+BcV2hiqsYTNN1U9HDEK/
 2TFmU+f3Jbcbr2Cnz/pAl3i1vigNQB3Ec7cTachz1H4P5kxMgw6jQkFqNGO9mCp/5SwA
 7L6/nZVuexCIodfiTgZzv9ca5RQvJp/Au6CEcbaSeVJMkvsv2ksb/mHUK55pV4f+Vbmg
 sbricojPOoA7WitX1cWgXFfyXb+7ptdoCuEiITgHCqamB25KI3j309g/F03LOKzw1M4T
 PSOEkbpak6FbY2igkrJTwkOJaKFQxYre0BlX46Dkkra3iPLzIjCNfrxDb3b9UxpUnUcS
 f2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744346504; x=1744951304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npWwzJvQM/483RZnV/1gsYUruF9uzp3Jiju7pOepVLE=;
 b=IH4DpPIXokLRDcPRZtw1bUqtjoHgBYobI67C3ny4f70XNlzIxGhz15MQAerYKf1d+D
 bJXRb4vqkZ8iEkslXY2ztE+pLAYCa8k91HClr3QvWmOi+Vf0Yl3Z2jz9OnOdhS+pItMl
 PGmq7HnQBrNMF2ggq4SLNS8tAijkNTA/fAwczY5sLGLxUGoIZhS5XGTCD+CJAYC+ZXEw
 hIkrvFWgNIU9hdJt+tMGBPb++RCDREVmKuVgiSFDWX+FNwYWMR6QILStpXwqzIj11Ju7
 YkcVUAKKEpC87KAEtZHZqkukvMakdvwJ7w3j+97F1fPUkcX1AYjVHnytaQQk63Ckperm
 cvyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIN+tULdOcG+Me5DA6MAUTMNnqwjRJid8TpI3NWNkOR3j7ddhtQq2lzGrYUCtvl5LLj4KFuCu0jsiA@nongnu.org
X-Gm-Message-State: AOJu0YyDYbLq+VWeSUcQp8vjpFGdg1N5VIhdcSzKuL4VUT40VSNsYolY
 Uz8opDekifSap0IPd58EreWjyO+G2V5On2mZ2QLrkN960SFrvTf9a24JfQ==
X-Gm-Gg: ASbGncsiKLuUdE/NdhIVZvh2qKl2SJOCh0T9I1i7g6bmKp4JnsVxp7P5aOfwbDAOrgW
 yq+0/pNR4SiHkHvL1uHsrg7ehyYgE0MGZLlOcZ0uH3icnqER0zL3CXycPjOgnwltKaQxY3KB2JP
 gVDfFqTbf0TkHy86/gYcOz7Q7D5iuoP7Lmrf3YS96V1xAWhfsOqP05eEfKTtg97AYmzUOulUl2q
 TQUDR4my797qbEawQOkvTsrBzbmUZqBDISJ9QB/4NMhZht5YJd9ajS5WmnU/kil4AB+5i8JBEbg
 tvZK2yFGDtDqPJWDJiprIIjbBEj/wPQL6kAbik72I+Zo
X-Google-Smtp-Source: AGHT+IF584UzOZV0bcCk+SeJdeQms0zTSZ1QIuDLi1EJGiTB8qRjZRqHp2A1WvnJ9swlKW5QOkVPbg==
X-Received: by 2002:a17:903:22c4:b0:224:a74:28d2 with SMTP id
 d9443c01a7336-22bea4c6cbcmr19602515ad.26.1744346503775; 
 Thu, 10 Apr 2025 21:41:43 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971e4sm39672745ad.136.2025.04.10.21.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:41:43 -0700 (PDT)
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
Subject: [PATCH v4 1/7] tests/qtest/ahci: unmap pci bar before reusing device
Date: Fri, 11 Apr 2025 14:41:23 +1000
Message-ID: <20250411044130.201724-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411044130.201724-1-npiggin@gmail.com>
References: <20250411044130.201724-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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
index 88ac6c66ce3..7cae6b58e0c 100644
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


