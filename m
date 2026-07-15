Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7BCC44501
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 19:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk578-0007Zn-Gz; Wed, 15 Jul 2026 15:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wk572-0007ZU-Ss
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 15:17:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wk56z-0003Ln-2K
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 15:17:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-493f60208a5so48947585e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784143058; x=1784747858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xoS/tY7IOVa+KDgM7q6XHwr7j+UHvR0r9yoBic4DaKQ=;
 b=g0NN3ZtoNc0glVDXmXjAmmzTUijQ30svfO59CQ99fY14ruDQfR6X3MsUwelblIA/P/
 uh2N8EuBgcDvh0/0ytKj/exFskq4W8LO/tGeiW0do14v6BPCp+mAML/b8sLW/f3vZits
 HvJO+JGQ74AvWNpQmcxYznA9iofyMSmIaTYLnepDDSiORNhIlzzbMKKkzdivNsTmolgL
 4KcAGRYdpolrhUaBYgk6LDMBAXGBxOw36/ZeE4SKtc4sJ3lYV0HLYQHHtcP1e0kg5OcS
 6mSqcHmTlRZYwEllez9wIKpSzo+BhERmsjsP7Gkgbw4M57B2SdKqP1D9S7JMnzC+0Vki
 JgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784143058; x=1784747858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xoS/tY7IOVa+KDgM7q6XHwr7j+UHvR0r9yoBic4DaKQ=;
 b=r+KaK/jMb0HuKkrG3OFMEoGiVuAKNyWrVb0+RbGa5EVD/YUvnrjIkLlXIYM1s/p5Ii
 ayTQJlZNzSzAr8MgPOAwYKKxa6WqZPWfuZ664f5swM4t3kKGob/EnncpFUxVj2k3UeNd
 NnZvvzlG7d1Po7Qokv/DwQY3fXTOb3XC5pM9/jUIH5CT+dVIB4ei4bvMD05PsNsxJzPN
 ygL3t3eWObkXGyiOP92BXxJiBK0mNH0YfM+epI8/HYBU4w+3ifxngzyXVd/l2u0Y0/a3
 GnDpTgX4/grHY6lvkpsDYZtffPrH/T695j7kiNG5BYo2e8fIT2brKN22GqXboOhow6fP
 71eA==
X-Gm-Message-State: AOJu0Yy+1G+TRwxKcoijCFxkMFOBUL3imhWZh5UGthftiRcOa+rP6Lzo
 2lGtC2/BqISVD7p16ZeYf+/2j37FzGZkRgigvpGNYifyn3fGEXrZnpjibEj1of7EWkN3+IS2rjt
 RbDQghoA=
X-Gm-Gg: AfdE7cn5S3CJsD/A/B+aO9o0IRluxAl71Q8VgwFHGl42w03zKNa53WuPMOovTD7+py3
 A0I3olQ10BBa+y9gTB7IW7+fEsMYYLD8bSLvTFNV/SOD89znM395Yy+Le46jSYPCU5gIgzz92Jh
 Lq0iFhyvPNdSO2cH4SgwRUm1HTBvCJ9YoTvaF1PclwqNSjJ4obs43+/n8hMopDVkoWJlzw9bC0a
 SCgASMnoAJ3+8ri0FTR9mTVqZdLrU348Z0ABlcNegiBfJxkHWYpem4POyP+PCqwTdNsVkQPfhPj
 9M8v55jmWcmjsAcNPD3nStjKQUXgwgGbxuXayFrxHBSiBH4uC0/MkgyGtfKo9VOs6bE/AIjPvSq
 MCqCCSLWcIhPsr/2//TXDHOikNu/gU+JVgERczVlcscNazJpy1xUtQ5YUqFsCYX9sTGeWTMUzeA
 pdGD2HhV+ZAg==
X-Received: by 2002:a05:600c:8483:b0:493:d078:796 with SMTP id
 5b1f17b1804b1-4953c16a713mr49208625e9.17.1784143057885; 
 Wed, 15 Jul 2026 12:17:37 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9de7:8ad8:9bc8:e973])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e51f47sm4195465e9.0.2026.07.15.12.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 12:17:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Alex Williamson <alex@shazbot.org>,
 "Cedric Le Goater" <clg@redhat.com>
Subject: [PATCH 1/1] vfio/pci: Reject invalid PCI interrupt pin values
Date: Wed, 15 Jul 2026 21:17:35 +0200
Message-ID: <20260715191735.2454719-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

If a passthrough device's config space is unreadable at realize
time (wedged link, surprise removal, powered-off GPU, etc.), the
read of PCI_INTERRUPT_PIN comes back as 0xff. That value is
non-zero, so it passes the "!pin" early-return check, and
vfio_intx_enable() turns it into an out-of-range intx.pin (254).
That value survives into pci_irq_deassert() -> pci_set_irq() ->
pci_irq_handler(), which asserts 0 <= irq_num < PCI_NUM_PINS and
aborts, killing the whole qemu-kvm process with SIGABRT instead
of just failing the device.

Reject pin values outside the legal PCI_INTERRUPT_PIN range so
this now surfaces as an ordinary device realize failure.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Alex Williamson <alex@shazbot.org>
CC: "Cedric Le Goater" <clg@redhat.com>
---
 hw/vfio/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c204706e63..612ee4a0db 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -812,6 +812,12 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
     PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret;
 
+    /* pin reads back as 0xff if the device is unresponsive */
+    if (pin > PCI_NUM_PINS) {
+        error_setg(errp, "Invalid PCI interrupt pin %d", pin);
+        return -EINVAL;
+    }
+
     vfio_disable_interrupts(vdev);
 
     vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->msix->entries);
-- 
2.53.0


