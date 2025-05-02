Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE33C3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgie-0001mm-DT; Thu, 01 May 2025 23:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgib-0001k3-OM; Thu, 01 May 2025 23:05:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgia-0000YX-37; Thu, 01 May 2025 23:05:41 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so1742424b3a.0; 
 Thu, 01 May 2025 20:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155137; x=1746759937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0EYcxOiAxlxt2yBBr4MMGs4l99XO3V8QvNESSUaMc8=;
 b=flbaFetbI+PttL8Z2tCtjWhxHlYYTvem7DKQsmlVAxKtZi0Q3maYczznH7bFPmBWa6
 hJxF1TuDJ1QeovMUOoSGjH+SMR6DLTuWjArtYA5oRsR8qjZOBKXYmy5lImMt5kIFfglv
 U0deCLnhF2lj7NR7RTXkrXAFCcKt6UBOcQxl2RD1jPTH61D1m0EMjDJiCREFNLx8E6aj
 aRSMgIPXJoyvMfGfnBOtqPlBz/+abTZAdQxk3Glc8Lm5GHDzZ5k1iHSoBPuH0ws6y1Fj
 q+Dy8B4Aw3nWLDvZmguEWEC/BJ0fnNbYYqd/DxKDK1ItpGg4VLiDNQ853l23Ka41ZaiA
 Z1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155137; x=1746759937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0EYcxOiAxlxt2yBBr4MMGs4l99XO3V8QvNESSUaMc8=;
 b=Y/u9V7P/ZC06g/Mop2tiTpESFh7KVKK5UCGjTpPP+d3HP5fUSA8uJSM0bwxk14+weN
 YyWaQdZkew7j0AlL6efiGg5ozxZIfJFciX0fFYgRsVv1L144Z/ESHEEpy/H3p5K5v/ig
 f2LV10wuN2hV4imfajjUalPICn8RPCIcTy9CIoir6cB2HAuCnwWJBfSE43hiR2gT+a5o
 Z8bZnNSvRsiXXxdNobawdMt90rt9nDPEY8ig41pBkaf8wB41VZP8KO7/ozn6OPR0Bl2k
 7SB8bRwmKbzornIDvMZgbBsAJIyIeRNZD6LgCUu65VEaOW+CD6bWVm41Ry5HrbHg2xuW
 FRNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOPZJmA7M8KLjp8ZQR2d3V5QlEvIDRn0+ZNSU6x6cuzE4iYAPKNxcYERyyOc7IKwiAX3B8q1j8Ti/g@nongnu.org,
 AJvYcCUk5NDUuD1khiqGy8se4A/oKm1Dsf1ihRRSFvyZeAqH3NXCvrHA4zKX3QdB6f1HQnMe2+N4xv1DRR4=@nongnu.org
X-Gm-Message-State: AOJu0YxxHYlJojk9V83fEGwgvqda3iX8R+2NN4D6WXGNN6QEdwfd/DMq
 xkdFswlvjSh/5MBhKBYZRAoSm+2GuJRz7jXqhLDG3xOehZkTDlNZN6+IeA==
X-Gm-Gg: ASbGncuZhwktzdAH7/Ndx0dO9tWnx0U2yKneFK8qZ+y2Opj4M03Y72eH7EL2NE4hZME
 KB7UtZ/iFW7zPDduUDvkBrrWjmPNGq9hi+LMkOkOtpcb+9IYhWQHsUstn0cLrYHV7twgP+IyuU9
 RpNhZ/NPNP5aKHw6xJ/3sYSrDabxGajfKvA3X6oLZ1eSonZOqi3VpsYXS8xnSyGLSa8KzmZ+025
 76dUTt/4iJj3KXiXWCNne3AJBYwOY8/kh01EqdfwHEcPWxGKOx1BfiVV7hMir+VZOh6JNy7L7nQ
 KDcLiJzO09nU3JE0r/CL+4r9OUividN5mYIsxVDAvi+S1gNHQ484WDY=
X-Google-Smtp-Source: AGHT+IHVpQXZJ247v9KO26Hg2LMy+FuiscfkqBSjUemfvcCWZ9vQ5XVeE+7z6th8q2Yq/5OlypiEUw==
X-Received: by 2002:a05:6a00:4403:b0:736:4ebd:e5a with SMTP id
 d2e1a72fcca58-74058b55e2bmr2085762b3a.20.1746155137285; 
 Thu, 01 May 2025 20:05:37 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:36 -0700 (PDT)
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
Subject: [PATCH v5 07/11] tests/qtest/libquos/virtio: unmap pci bar when
 disabling device
Date: Fri,  2 May 2025 13:04:41 +1000
Message-ID: <20250502030446.88310-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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
index ea8114e2438..d6333a4d576 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -278,13 +278,22 @@ static const QVirtioPCIMSIXOps qvirtio_pci_msix_ops_legacy = {
 
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


