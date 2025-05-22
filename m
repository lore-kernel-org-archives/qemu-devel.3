Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F260C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 10:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI2oX-0004Zx-1t; Thu, 22 May 2025 06:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uI2oV-0004ZK-47; Thu, 22 May 2025 06:06:11 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uI2oS-0002a6-06; Thu, 22 May 2025 06:06:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so5612428b3a.0; 
 Thu, 22 May 2025 03:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747908363; x=1748513163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u+jAhJvSiiXBD9mect6svubQFP5HWgruvnvTSTNgeB0=;
 b=INSuXnKqHMBRtszEQ2SdD9RSgXHs/3sOYUyk+OjmCEaiM1Le/e5BA6Qtvzh6a6LQhL
 1ovbwOTAaknESrVV3+i8sJ7MlO/D9JUiCvzVcgH9BFt3wPVyRuGd+5pn0Av7pZpeyG97
 6/fA81DhCm/wW6agbqLXoLfgFy/m0KfxphnljG7oVkk5XQM9nCy2ct6xw7wSqL84ZBWg
 DMChWZU6b3yVEKSKuKSL1z/D3KaKfXaQzvkQfT7NsehaE2TzwFQxDk5SOJRooA5Yg5aK
 dG4XhxFCrKVCWdIZ+X9iJNnigKvDcsLgBTrYSHiJSQBYdeuRr9gORPPx8veTZgO5LfJ5
 kp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747908363; x=1748513163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+jAhJvSiiXBD9mect6svubQFP5HWgruvnvTSTNgeB0=;
 b=E9vqVXAfqSyJ19cHjYoucbE/mlFHueqZpIecBeS4U4njEWin92Ul5axn96jTmRT1ap
 q/+rklMNGwyuBHEpBMWLi18Bv68defFALBY4CWqBRe9vPg6E7P5tlvuHVXnislNn3kk9
 YItk3RXzXzD8wgOAqzulmVTYCQitohyAWaYMpKJ9uos0n45t/csVtjXGMYZykYqZNlbT
 hKMR2q1f6uomRKbARQDC2yU2b7oc2j+r12nL7ngIjUa/2yt5CB0lJ+m98GUamNsmBE9E
 4Oa0dv1EXH6zXEKKnzBmHx14TryYtIefE8Wt3MCpr+s4gQeHcfg9rGBmVHnJYSJiE4aD
 TEfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXghtLtqMa7KIaTeWD5pw6xc50eYn1tx/oEtOkMoT8sW1HBKo8TUvZkUBVLjCh/D9nGe+Mj1sn8T4QXWQ==@nongnu.org
X-Gm-Message-State: AOJu0YwUqi/v+Cqod5Ml0LT3YoR6fB8DFfDd9bzI9Dn7yp72UFhKjlYS
 P6qQCV3622nhLl+q4RHXkmBsvr6NqFj+TGnNSrZp3ByGVqHllE05LFI9FP0fvxkZ
X-Gm-Gg: ASbGncuL0s2GvXn4rcDlcd07SKgMIjnmqskQvoAdpKFjl9zF6DDlCM/bVO1HUS1ypf4
 3xvoqIWyNyZEdC2rkXn1bia0dK9qhYWJBq8vNCD8Axp3WcOO6/GBGaP799+KAudnpCGoESsweEF
 2fY0IxBjhahhjAX7y/u/Zi2GYx15InPzbFsnb82Zdq0zb23d/laNjBMTIBsdY9ZF8+RJjk1b+H5
 JDTVY4gidVEK1hddyGmkY39lTx7+9bgpgLimUSh9EV/xQcFGBLDcRgiYhrvh96LoMgbbZuVgpsI
 DjYUtqRC6OtPa6mpgEAz+lreZfPRCDT4Xtk0lHx84QLIGTRqBs/D2DP9xfdIxLG2uvDvuR0E9Ir
 XLDUzfMz5fMBrXCczaRcp20J4cTi80FCJ9JDospgrAnc2SnTvvG9Am3E=
X-Google-Smtp-Source: AGHT+IE5yEPG3n+GNfWCq/dc7VfDzuRiu3clctMfZ82JiQKfNcHO1HqOPuRrK3h7yKMdkBX27ChBEA==
X-Received: by 2002:a05:6a00:9094:b0:736:53f2:87bc with SMTP id
 d2e1a72fcca58-742acce4f17mr30814997b3a.13.1747908363260; 
 Thu, 22 May 2025 03:06:03 -0700 (PDT)
Received: from localhost.localdomain (172-234-80-15.ip.linodeusercontent.com.
 [172.234.80.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a95b2b19sm10909267b3a.0.2025.05.22.03.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 03:06:02 -0700 (PDT)
From: oenhan@gmail.com
X-Google-Original-From: hanht2@chinatelecom.cn
To: mst@redhat.com, sgarzare@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pasic@linux.ibm.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com, leiyang@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huaitong Han <hanht2@chinatelecom.cn>,
 Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>,
 Jidong Xia <xiajd@chinatelecom.cn>
Subject: [PATCH V3] vhost: Don't set vring call if guest notifier is unused
Date: Thu, 22 May 2025 18:05:48 +0800
Message-ID: <20250522100548.212740-1-hanht2@chinatelecom.cn>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=oenhan@gmail.com; helo=mail-pf1-x42e.google.com
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

From: Huaitong Han <hanht2@chinatelecom.cn>

The vring call fd is set even when the guest does not use MSI-X (e.g., in the
case of virtio PMD), leading to unnecessary CPU overhead for processing
interrupts.

The commit 96a3d98d2c("vhost: don't set vring call if no vector") optimized the
case where MSI-X is enabled but the queue vector is unset. However, there's an
additional case where the guest uses INTx and the INTx_DISABLED bit in the PCI
config is set, meaning that no interrupt notifier will actually be used.

In such cases, the vring call fd should also be cleared to avoid redundant
interrupt handling.

Fixes: 96a3d98d2c("vhost: don't set vring call if no vector")

Reported-by: Zhiyuan Yuan <yuanzhiyuan@chinatelecom.cn>
Signed-off-by: Jidong Xia <xiajd@chinatelecom.cn>
Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
---
V3:
- Don't change query_guest_notifiers semantics, just fix the issue

V2:
- Retain the name `query_guest_notifiers`
- All qtest/unit test cases pass
- Fix V1 patch style problems

 hw/pci/pci.c           | 2 +-
 hw/virtio/virtio-pci.c | 7 ++++++-
 include/hw/pci/pci.h   | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index f5ab510697..82f82e726b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1725,7 +1725,7 @@ static void pci_update_mappings(PCIDevice *d)
     pci_update_vga(d);
 }
 
-static inline int pci_irq_disabled(PCIDevice *d)
+int pci_irq_disabled(PCIDevice *d)
 {
     return pci_get_word(d->config + PCI_COMMAND) & PCI_COMMAND_INTX_DISABLE;
 }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 9b48aa8c3e..7e309d1d49 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1215,7 +1215,12 @@ static int virtio_pci_set_guest_notifier(DeviceState *d, int n, bool assign,
 static bool virtio_pci_query_guest_notifiers(DeviceState *d)
 {
     VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
-    return msix_enabled(&proxy->pci_dev);
+
+    if (msix_enabled(&proxy->pci_dev)) {
+        return true;
+    } else {
+        return pci_irq_disabled(&proxy->pci_dev);
+    }
 }
 
 static int virtio_pci_set_guest_notifiers(DeviceState *d, int nvqs, bool assign)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c2fe6caa2c..8c24bd97db 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -668,6 +668,7 @@ void lsi53c8xx_handle_legacy_cmdline(DeviceState *lsi_dev);
 
 qemu_irq pci_allocate_irq(PCIDevice *pci_dev);
 void pci_set_irq(PCIDevice *pci_dev, int level);
+int pci_irq_disabled(PCIDevice *d);
 
 static inline void pci_irq_assert(PCIDevice *pci_dev)
 {
-- 
2.43.5


