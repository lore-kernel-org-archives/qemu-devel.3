Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF75C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36DL-0003PK-WA; Fri, 11 Apr 2025 00:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DJ-0003KC-Uv; Fri, 11 Apr 2025 00:42:01 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DI-0001eP-5P; Fri, 11 Apr 2025 00:42:01 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2279915e06eso16770205ad.1; 
 Thu, 10 Apr 2025 21:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744346518; x=1744951318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Rm33TSnC22jP6DTQXcfoa4b7xZArhvwABkl1UW9Q7U=;
 b=EnjrPqv701Fxhy8G32sSkANOXpJ9sm0DtRaVJEkrMr/o73JK3pkjiPuP2gRDMRWlNh
 ZnefD8QadFmwsJbhn0ZfMbyD3BpEhqBYVN9lmVQeW0IZc5Dzg/BnPmmTjKAwfR9cp346
 HSXG4oISblqT+hLOLv8QMgPNGC8fBbkQNOeAFghG6PU/0+yCxzQs/U1/b2lfe8LB0yRd
 BhJy4bL+lTl1+sySBTXHF+l+8SeTMZyl28zBZeuWH5xpF5B9+MxssUE/f2nhleCKMfXK
 v+UpDGhHort5Ia7e2poMOElMqwGxWynTrjVIz8hvDszUlI08lP8QWuKkSnLr7rW5LcDM
 tvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744346518; x=1744951318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Rm33TSnC22jP6DTQXcfoa4b7xZArhvwABkl1UW9Q7U=;
 b=ssMepefkY3hjZFOJHBAQ86l5BGEse983zRsGb8yPWVTBCYC2PxBE3LB5its/HKvWe9
 6mPSxsM3yi+UfwHNMqGYW+rem/B/g9lntcmFFn++9fqRRiaAub/3r2HKuksFrWqeMuwi
 1jyT3mygc8VuELEUtSFkykD7THv0HH/M4+/QyBKbmyVZm3bH/WIELCrGPDNMupht8Vls
 XayyW1I/NrN4ICCXJPD7MHvSJB/roayWmTqPvPTntKMhi8ganmzfQhY0e7gB+Y/R/dhv
 HY9qnPsL5scwywV7GkO+muLk5tcL0GEioUB7DG3veuAeVQo1vsNHeShojBG7cHmuv5ZW
 +88Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6WDb0+1prVq9JJRyCzzSnjHxOmPYLTymdGm6xDlJIlEfXzavRDBpWEVd3LSt+Hbx73U9jUDm6pu3d@nongnu.org
X-Gm-Message-State: AOJu0YwBjUZvfugJrk/c8TtHHbYOdm1coeZkscJVNYt9j4+TL7l/aUGT
 eCpJ603VJ1Sr5O/UNaxWL6UlAZryk63RakImbGq4DtPxpeTHdUau70Bhjg==
X-Gm-Gg: ASbGncszLRhop5zu1owEn5ayDne4VXMOjrQE1lfEQBgtfLqNex3Aigjgv9ikRsCsdbP
 VcMrd1xkxh7NHdpJ5+o8C4JO/kH4vjFXFrRG7wTph8qHhTibJhrCbenBzsEoZCSs1FyKRLR5NIT
 nL7ojsQvnETC/dPo3MuWOU6kqJiNckEnnOwoTjvzpdkQntrELXF+fSW/cLwT9ZKRSqo7cF13Ib0
 K0iYQFg8pwmHcsCpNESSOgzzzCY/k8fZU/t4kh0d2/svOH/3CbzpeIcQwLU6g76Ln/E9s3TO7eC
 WoBNqIt5DRSCc7UcFSvcI1yaDC8+dhSxUOuX7H1C+amf
X-Google-Smtp-Source: AGHT+IHdaSVvqODpivLgLLZowwJQUWVs5cNTCHezD3lkJIv78SBBnb8CAf63yepUCJzAWOHdqZnhzg==
X-Received: by 2002:a17:902:ef03:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-22bea4effefmr21097465ad.36.1744346518250; 
 Thu, 10 Apr 2025 21:41:58 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971e4sm39672745ad.136.2025.04.10.21.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:41:57 -0700 (PDT)
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
Subject: [PATCH v4 4/7] tests/qtest/libquos/pci: Add migration fixup helper
 for pci devices
Date: Fri, 11 Apr 2025 14:41:26 +1000
Message-ID: <20250411044130.201724-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411044130.201724-1-npiggin@gmail.com>
References: <20250411044130.201724-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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

Migration tests can create new QPCI devices for the destination
machine which may need to take on some state of the source machine
after destination is complete.

Add a migration fixup helper and call it from ahci migration tests.
This is currently a noop and will be used subsequently.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h | 1 +
 tests/qtest/ahci-test.c  | 1 +
 tests/qtest/libqos/pci.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 83896145235..fd195ac4e6f 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -122,6 +122,7 @@ void qpci_memwrite(QPCIDevice *bus, QPCIBar token, uint64_t off,
                    const void *buf, size_t len);
 QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
 
 void qpci_unplug_acpi_device_test(QTestState *qs, const char *id, uint8_t slot);
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 02c9d54f898..6fd6063b971 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -137,6 +137,7 @@ static void ahci_migrate(AHCIQState *from, AHCIQState *to, const char *uri)
     memcpy(to, from, sizeof(AHCIQState));
     to->parent = tmp;
     to->dev = dev;
+    qpci_migrate_fixup(to->dev, from->dev);
 
     tmp = from->parent;
     dev = from->dev;
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index a59197b9922..14581178c79 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -586,6 +586,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
     return bar;
 }
 
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
+{
+}
+
 void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
 {
     g_assert(addr);
-- 
2.47.1


