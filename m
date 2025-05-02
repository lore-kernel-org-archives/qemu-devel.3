Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD22C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgik-0001vm-3Y; Thu, 01 May 2025 23:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgih-0001oH-TP; Thu, 01 May 2025 23:05:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgig-0000bD-5q; Thu, 01 May 2025 23:05:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so1546114b3a.1; 
 Thu, 01 May 2025 20:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155143; x=1746759943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UX5i98+VvwrNDRvu7y7o1k9t75ZW7RfEsAcL5qSuocY=;
 b=mNT57EkOWXPDGP54XBZTxOPRXeDqjsBa+vWbiyJTSriu25STx5zoNyBonDywMWqXzc
 gwrkejb3SjDyshcK4hhCvU/6KXEHXU1gQEpWP48afg8553YIfDWsI8Ps1QrL29Bv5/oQ
 BL73NkdIfvaVfdPqWnjD6Ewop9uunAx/Sj75mvhIfJLmND5GL8TvR/X+4P0kQjSrWeg1
 MgCqTm6lyEWH82R8xvKQBq1nN9xF+o8cEaseulRAkKiEY/kA8DqErKbnRfmrrur2GXgD
 XGHFfSqt+DBtufjmYY7ZYN3D+dL8pIKhii0gMlPagh89d0+O956vGBOY6pUdl1nQHfIm
 zD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155143; x=1746759943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UX5i98+VvwrNDRvu7y7o1k9t75ZW7RfEsAcL5qSuocY=;
 b=hsp8+XQmRqwL2f3SV5rtowGIKOmsHenVHSVDywN2UqswZV0BxHNW9ihzenvTLcEzmq
 D9RaDLZ77zNUNAUpTou9iDI3qMD0hpdUDE8Rfy/EGk0CObDmVyrDOcVrMLkQBvvgI/FZ
 X9SvEDVe6JihWDM4WA3Bb8QuJ1XMXTr8WPgNqoQHV26dChQrjv4kgpEisYDDkPiI0Imx
 53WAK1iBZUvMvL4YqRBBwMcIrJ7+4Dqd/2JQk92QHK5iCkFELecZlwcqDqsQ+/DjgKhF
 EsQst+YYBZWGunU8OfxXK+fcd5NReJ1bP0fl2SqObUM+uBjGGoy7LkHLb0J0UDqwTZZG
 Qotw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCg7ZMJauuuBVPDFvFoiIyzpqhaJQMpdUkLDI1NtUlfsyd62jTb2rdbG+znYT9i40IntqFPadFphk=@nongnu.org,
 AJvYcCWhYGE3lKhBGFqSO+vfZAnxhRqjhOYYPgVAaoIxEIYFH+AuVSDN5FeGDv9hHpXRW05T0FS8kfp1mPQq@nongnu.org
X-Gm-Message-State: AOJu0YzI2N9GkW2ZETYGyNQEPpgsvqP9zCZ6SjgyWhmCo5UF2MD5TtAe
 HybvxHitXFwm9MBP800LvVdLW9mAn5+aLfa1g7YuVhpT10L5PTDTf+KgLQ==
X-Gm-Gg: ASbGnct5RBrR410SYCJm2QLaDwCdXcnV28VwFaSg5pNW+whYY/kW874EuhiSU7yyfq6
 cz2P8IIBZsEC9WG3P8WoEaEnfPmZYC0XrS37N9DVlf5qapVma/u7DLtlFpREdO9lOTfjsxtrWOY
 virdQyUjDfE9YgKyLArBuH9yjlx758PMu74TpARpIZI1aWdE0n/c7Ae8Av17jlGgKQuajMeCspW
 M/sarle3SeWMRnk61L3xQ+0Lvhh2n79YxViGAvISD2I1SYVIfgUs4yOXOmsky0sRIUJLzCMM0Hj
 UPWwxpDDiN2zSjguR2Xvh7HXLcRnD+1DH0GtljochWKM
X-Google-Smtp-Source: AGHT+IEI4dIB9PGkoRRBV+6vmuOdcAQsDQK7tNPsNhb0+PGdy/WsOyIVLLXRbC88m212g/sNugohUw==
X-Received: by 2002:a05:6a00:6c93:b0:736:51ab:7aed with SMTP id
 d2e1a72fcca58-74058b0aab3mr1977937b3a.16.1746155143386; 
 Thu, 01 May 2025 20:05:43 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:43 -0700 (PDT)
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
Subject: [PATCH v5 08/11] tests/qtest/libquos/pci: Add migration fixup helper
 for pci devices
Date: Fri,  2 May 2025 13:04:42 +1000
Message-ID: <20250502030446.88310-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h | 1 +
 tests/qtest/ahci-test.c  | 1 +
 tests/qtest/libqos/pci.c | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index ef40a6917d3..19f1dd13501 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -120,6 +120,7 @@ void qpci_memwrite(QPCIDevice *bus, QPCIBar token, uint64_t off,
                    const void *buf, size_t len);
 QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr);
 void qpci_iounmap(QPCIDevice *dev, QPCIBar addr);
+void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from);
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr);
 
 void qpci_unplug_acpi_device_test(QTestState *qs, const char *id, uint8_t slot);
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 7d5f73ac40b..60eef9949db 100644
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
index 2bae119bfca..de95329e486 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -620,6 +620,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
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


