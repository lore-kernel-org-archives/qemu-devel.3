Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A440BC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq43-0007e3-Bq; Fri, 17 Jan 2025 12:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3f-0007TQ-Tn; Fri, 17 Jan 2025 12:23:00 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3e-00061n-Ee; Fri, 17 Jan 2025 12:22:59 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21644aca3a0so57567655ad.3; 
 Fri, 17 Jan 2025 09:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737134577; x=1737739377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G13bQK8MBtUoRPpnIFDO8Sgsudp2y54/cquE6DK8iMs=;
 b=dS/bpNDpDPE5z/WHH5MVvvxpzGbkccFnGecvXHk0H8vvYfR6N6aADKVvWBXa19zVId
 fJpma1Hn+VOdiTFjcM6q3uyZHZaDjihc+wd+PJouY4Z6cahdX3Y2Qet7Thw3MOrrKRl/
 CaiqofeYqlmqkXghmVqzlU/BSYDTqd58+kbDGwJYeLjamYE2Ihn7VZyKyVK4opnfKQZe
 x6ctcQ6hrQjuGFScn8ARRnOzWdLwvngy7xCf2fBFIqtfCiY7+YkGXhk7Mcu4ZH7Gv0d5
 EPjPYT1z+8LNLc4AYr3Thw9piPfoc6yghaIsTtL9RuoDUIHVjyHApCyhqWnoa210eZle
 J+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134577; x=1737739377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G13bQK8MBtUoRPpnIFDO8Sgsudp2y54/cquE6DK8iMs=;
 b=snx5veIuHcxKXcOq94EAorJN5T3xwAb4kEK7roTAyGo9jZ7fcHHHFOOkNxVehmUydV
 PeY61sV/kXGqJlOcC0j/EQdKTC3aM7gh+bby04GeYyEujBYgUbH6Q6s3V2e77fFB9Xmz
 I2Y9RFJAnv1mfhjj5QYXlsMhJgm+kai/t6VplSoVKWJSi6p4rydbQvZ45Cq6q8Pql4GM
 USMPCNpZBQLRmf/O3NlP67OKiqfhug6Ro390iQgyH2hEnk29xzh8DGQxyL4tWxRZq7mr
 Uu8MjvxJoNfz9GVZxAyru62My7gTg1xUrOQPgIYmwNZ74fKn/TCYjQZcMuyA/7iRM8//
 +9hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnluaONcQcBst3MqNdRZZbkMQf2z0Ta2ONJf0ytnvGAiOfnBNQy74/itxoD2dJ/PtSekhMKPfVm6a2@nongnu.org,
 AJvYcCX6nmq1qQFXPs3mFBEjmCPkbXIgoQp12Gt3I+LOGNyTP/LS62MnC3xWdGVfscYk+2s0bq3tWaia/+Mg/A==@nongnu.org
X-Gm-Message-State: AOJu0YwN0VD4kU8H8zsaCvix896kg+6juKIGy0BVQo8ilc4MHcReqnCU
 D9dIwWJ6fdTryuGHZs8hfn1uLP7HLAbevrLmAw4WN7s7GSIbD896
X-Gm-Gg: ASbGncsHRa8wI7BV97JQ5d1qrYYbRpIybCprbU5b/4l6Vuf86l973uW2z7WVeAQC5rQ
 EbfcUJL9WMS0452Sy7YQOiuKBggxDzbjRxoR6EO2q+BvtLNrzeMz/ZbhyE9B4YLtIciwIaxwQ5g
 /ec1PhyKyeG3rbzohj4QLrC37LTVk+2HGZFp5rKEkRrCnP2fotZGlgdo+LKy2tFDpQcvWNzZpju
 HgCBCK1vHBYdbZMgnNMR5PMadlxOEgB3gHEST0zCm7exx5BN2psHp24dGoULgHR6WWjBC0USTF9
 O1qPrS/oJDv8HR0=
X-Google-Smtp-Source: AGHT+IGqhYxRWQ7UPyszVEfBKnwbxGfHpuVJRP3bSNzwKy7WcFIzq+50tyPyw3fJb3i8pRITYzYGow==
X-Received: by 2002:a05:6a00:2d19:b0:725:ffe:4dae with SMTP id
 d2e1a72fcca58-72dafa44ce7mr5543345b3a.10.1737134576830; 
 Fri, 17 Jan 2025 09:22:56 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba511a4sm2235950b3a.140.2025.01.17.09.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:22:56 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 1/4] qtest/libqos/pci: Do not write to PBA memory
Date: Sat, 18 Jan 2025 03:22:40 +1000
Message-ID: <20250117172244.406206-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117172244.406206-1-npiggin@gmail.com>
References: <20250117172244.406206-1-npiggin@gmail.com>
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

The PCI Local Bus Specification says the result of writes to MSI-X
PBA memory is undefined. QEMU implements them as no-ops, so remove
the pointless write from qpci_msix_pending().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index b23d72346b6..a59197b9922 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -328,8 +328,6 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 
     g_assert(dev->msix_enabled);
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
-    qpci_io_writel(dev, dev->msix_pba_bar, dev->msix_pba_off + off,
-                   pba_entry & ~(1 << bit_n));
     return (pba_entry & (1 << bit_n)) != 0;
 }
 
-- 
2.45.2


