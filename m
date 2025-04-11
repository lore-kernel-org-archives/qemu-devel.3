Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834F8C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36DG-0003GJ-Sc; Fri, 11 Apr 2025 00:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DF-0003FX-3T; Fri, 11 Apr 2025 00:41:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DD-0001db-FX; Fri, 11 Apr 2025 00:41:56 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso16032885ad.1; 
 Thu, 10 Apr 2025 21:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744346513; x=1744951313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/o7YYwGycbMB48G0KCdsMRvKzBvHTyod2rEkRdfLkf8=;
 b=DQB+r/rWKOcdIDHkzTO4igRwdhmty9EyiWv3tCuW657gRaXLCiFum85rXphTzllYHd
 SME3In3e9IYX/uoOuScmuG1kzslSLoOYcDE+BtKEQ3pJCXd4t3Ndvfmv4i72lg5/QuA2
 OGOHFcWqPlq4hNtE7lx25odpUQDE3QgSxszIFobHtkoRIcZsID994EC5tAgZLWeKB5kQ
 iVji7y7gm2g59ZsvmsaDsUH6Watuv/77lkK6sneSS3jgbxGOn/FKnnOOVFqv8HWLB4w+
 eYcYsALDe7JGGDteM60+xDXJMiZoxRgKnFfSbF/QDsEcldKNdHYVimzJL2U1IVDt8ako
 uWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744346513; x=1744951313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/o7YYwGycbMB48G0KCdsMRvKzBvHTyod2rEkRdfLkf8=;
 b=V3w4P9MZ2+uUH4MEiKlej8NsRG+OUVBQlr+yfg85NVbdszA71fFbMOHHc4mJhwsH6Z
 SwG4krHDVaGiGYDsFY+v7ENmABsfrk7WPdei4GbX1hpiMWWI96Oc+AjsvYeB9m3QLxmZ
 oPPsUNyGGr2zYFfOH9G63ei7AnJLPX9E7+FV2UGyrsp4The4ER71s/u4skmDi9L1NKOE
 j28q4scx5eSQsephgTj+8iDadzSkSrpewuJV8Qv0dJMAmNetBE7KgyPS81NY9CZujeAb
 UHgYKUJ0PgL0n05gKZdLMtQE13dEOCU1i9cWQT+YDr1gfFEZ2GyExiSFN3G89JQhcDHc
 +RYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsi/hNAUHHIamX3CatvbcJpEjld9GiEPERKf0gtv5pUFHYs/HBF0hDgkixHtNscKsyKLtifhsE1xQ4@nongnu.org
X-Gm-Message-State: AOJu0YzEkq65X7vNzP/byBPRh/RD9i3JQZM7ym7/i9jNOyFH/TDmPpMb
 hA07cGGWfD/oyCUZKzSSAbqRbHK647xOk7uPuf1Ggbo7kADvo+LF7hDILA==
X-Gm-Gg: ASbGncs7fLMAMGNw9E+fBve87r8fyyT/COUy/lQWOBsS+lT9p1ePhfP/bnKaeZrhJTF
 ncVp4RMPuR2OHSDFQh2cVsptc0uq26lNX2M3BCWuZCpgxPFT7SMYO9dGLNoZNkLJ7DqNsnaO7iC
 vLH5rvobhbNjq2bABJFPKlpfa1UVSmRU+IB5lHzKCUXaQTPyCu/4pbmL/TLu1B0Aq4cYAIMRrAA
 l86LWkb1+Ukjz28zAFYdCk0SSzYzn+gBkB3VZACdAlHixB2LCD4yi196+i2W4VqoZgyDXeSFCUV
 YBXTAyuWo3/J08srisJU2lo5iT99JI1f4IvZDiSHErp6
X-Google-Smtp-Source: AGHT+IHYXRuD6gS2i4nIEW4pB5fxlGMlDpC30/K47GG6gftAxLtfSwWNG2fMF7M7Wq2DhJCz/vQw8A==
X-Received: by 2002:a17:902:d4cb:b0:21f:1348:10e6 with SMTP id
 d9443c01a7336-22bea05db99mr19802225ad.13.1744346513353; 
 Thu, 10 Apr 2025 21:41:53 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971e4sm39672745ad.136.2025.04.10.21.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:41:52 -0700 (PDT)
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
Subject: [PATCH v4 3/7] tests/qtest/libquos/virtio: unmap pci bar when
 disabling device
Date: Fri, 11 Apr 2025 14:41:25 +1000
Message-ID: <20250411044130.201724-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411044130.201724-1-npiggin@gmail.com>
References: <20250411044130.201724-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

Unmap the virtio-pci bar in qvirtio_pci_disable_device() to keep
iomap/iounmap balanced.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/virtio-pci.h |  1 +
 tests/qtest/libqos/virtio-pci.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-pci.h b/tests/qtest/libqos/virtio-pci.h
index f5115cacba2..efdf904b254 100644
--- a/tests/qtest/libqos/virtio-pci.h
+++ b/tests/qtest/libqos/virtio-pci.h
@@ -26,6 +26,7 @@ typedef struct QVirtioPCIDevice {
     uint64_t config_msix_addr;
     uint32_t config_msix_data;
 
+    bool enabled;
     int bar_idx;
 
     /* VIRTIO 1.0 */
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 002bf8b8c2d..cb52a7c3f2e 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -300,13 +300,22 @@ static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_legacy = {
 
 void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
 {
+    g_assert(!d->enabled);
+    d->enabled = true;
     qpci_device_enable(d->pdev);
     d->bar = qpci_iomap(d->pdev, d->bar_idx, NULL);
 }
 
 void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 {
-    qpci_iounmap(d->pdev, d->bar);
+    /*
+     * Test for "enabled" device state because some paths can call
+     * qvirtio_pci_disable_device() on devices that have not been enabled.
+     */
+    if (d->enabled) {
+        qpci_iounmap(d->pdev, d->bar);
+        d->enabled = false;
+    }
 }
 
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
-- 
2.47.1


