Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8522AC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN639-0001OW-O6; Thu, 05 Jun 2025 04:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uN637-0001OA-HH; Thu, 05 Jun 2025 04:34:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <oenhan@gmail.com>)
 id 1uN635-0006cO-Tp; Thu, 05 Jun 2025 04:34:09 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-73972a54919so681865b3a.3; 
 Thu, 05 Jun 2025 01:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749112445; x=1749717245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eStL4HphkzAKYOy6BeV4qdJYcZ2vzM8701fTzYc6Q4I=;
 b=BtGN7SqjaEvIjy0uFBatVcMU1q8Y8t+BA7px4M21k+nKr2ULaN+2ij1nBFkqy1YOZt
 nSlByjLsV7Tby8puaLoe7AIJ/mYZyQ70YghbNd+zfm5e8bPnQbrixSmLzmaxBXPbqGI9
 T7DCPpjPYmUMugN4q5y8n5X8/LpnguQfCfHRfIVS40lzEUaZT/aLu4QXWyaAcYe5ni5f
 0f43WHsGZPUw4RydJDXTUnytsQmfJIYkmaRHbGkNT/XR1XifUVQAFV6aRKzO1cCuRVho
 5NPmZOR9snf5CLAcksNt8iY76eCeInVC+6MK+0hCwGAj0N1X97irNohXJzrGpSvLZ0IC
 xqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749112445; x=1749717245;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eStL4HphkzAKYOy6BeV4qdJYcZ2vzM8701fTzYc6Q4I=;
 b=XYRCjUhnvpaw5ERh5hW50Yvw3lJLq/6ePmRVXcxdH+4ZIDutjNPF4OmV01OQzmhp11
 n4SLbcYsnzyQQWf/eLECJbNnhciQpb/KeBimPu17t/sRuqC5zzo+gES7aUvLoykNCVZf
 ypXx3jkROk/Ipq4BX3sDSjBjVVdflK+oaFBk9/xmFgY6DqKmZRmRqWuPugeUtc2tmP+t
 EtTrGVCQtTPFKiOB0Xew7o09gu72mkh70ewpir+W/MMjOOmNLr6uvkNyFBQrnOR2d51N
 mX8aWn75quAiCXGjl34b7I4dqr77cBEgV/HxK/qwiIhPay8HDa1P4rCi22WW2ppJ4RJh
 e8qQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpQAT8aRbG+D63/yw7JNzIgF9IV6eFBwhx4LroUSvL+RubzUUoCeoyO9z1iPBk8o3vmI8bb3vqlYxxdQ==@nongnu.org
X-Gm-Message-State: AOJu0Yyh/w/1m1f0VR4dtxoHU5YrMaGJVeRiezY47yWXchWd4RD87X7X
 Bm12ovIWcneldUqVsj/f8tlpzhjCribLg6ubosKaL6FmdvmhkGEobV4+
X-Gm-Gg: ASbGnctKq+X8UBHZGJTzbbel1e83m/kB5Uer1BBJq+AhfcH6Kz5+YjtAscZTO1JjYhV
 W8gxC613D2me/QLhgikRMyh7egh5ebMCJAvDtlLL26eXbIzND8v/4+2d7FIdq8K6UDroyJVxKVR
 jhTL4HRR1NzSzK8Oa/AFO9gByXkD1yMiQjomFouMCFLNqnoJ98uoZWjm6vZSg9iZd6sHIfx4iKe
 E9uWcshbkLjEYb871vNc27tc31yyWFRVn2eYyOZY0kc8sGKlHHBjGJ7mhlgGGE3tHLbLJWl/Fha
 9Hgq2w301SwGO5abU8ocPLzOW1m8qsqSxCfOoolTgVoguSiKKVetsY4o4rgKwVea4qZHNRIbCfd
 4SfG7P4GSXzct6je77eBD+pTHrjJNrNWCGRI=
X-Google-Smtp-Source: AGHT+IEkoXeV5o7x/5pmow9f3X4ZVXCVii4DZIF1fVUGJdP9ZJ2g1dkJMg7Boa3srl6KD8jZddamow==
X-Received: by 2002:a05:6a00:b81:b0:739:50c0:b3fe with SMTP id
 d2e1a72fcca58-7480b23acb1mr9361471b3a.8.1749112444852; 
 Thu, 05 Jun 2025 01:34:04 -0700 (PDT)
Received: from localhost.localdomain (172-234-80-15.ip.linodeusercontent.com.
 [172.234.80.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afda8b71sm12326628b3a.0.2025.06.05.01.34.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 01:34:04 -0700 (PDT)
From: oenhan@gmail.com
X-Google-Original-From: chenhgs@chinatelecom.cn
To: mst@redhat.com,
	clg@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Huguanshen Chen <chenhgs@chinatelecom.cn>,
 Heng Zhang <zhangh121@chinatelecom.cn>,
 Huaitong Han <hanht2@chinatelecom.cn>
Subject: [PATCH] vfio, migration: save device parent pci config
Date: Thu,  5 Jun 2025 16:33:38 +0800
Message-ID: <20250605083338.1845911-1-chenhgs@chinatelecom.cn>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=oenhan@gmail.com; helo=mail-pf1-x432.google.com
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

From: Huguanshen Chen <chenhgs@chinatelecom.cn>

On arm64 virtualization platform, vfio-user devices lose their interrupts after
migration to the destination. This issue occurs because qemu fails to deliver
the msi device id to the vGIC. The error device id is calculated based on the
device's parent bus, so it is essential to save the parent pci config to
prevent this issue.

Backtrace:
QEMU:
 #0 qdev_get_parent_bus
 #1 pci_dev_bus_num
 #2 pci_req_id_cache_extract
 #3 pci_requester_id
 #4 kvm_irqchip_update_msi_route delivers 0(error id) to vGIC

KVM:
 #0 find_its_device returns error
 #1 find_ite
 #2 vgic_its_resolve_lpi
 #3 vgic_its_trigger_msi
 #4 vgic_its_inject_msi
 #5 kvm_set_msi
 #6 kvm_send_userspace_msi

Reported-by: Heng Zhang <zhangh121@chinatelecom.cn>
Signed-off-by: Huguanshen Chen <chenhgs@chinatelecom.cn>
Signed-off-by: Huaitong Han <hanht2@chinatelecom.cn>
---
 hw/vfio/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1bfdfe375..442113d0b7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2654,6 +2654,11 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
+    PCIDevice *pdev = &vdev->pdev;
+    BusState *qbus = qdev_get_parent_bus(DEVICE(pdev));
+
+    pci_device_save(PCI_DEVICE(qbus->parent), f);
+
     return vmstate_save_state_with_err(f, &vmstate_vfio_pci_config, vdev, NULL,
                                        errp);
 }
@@ -2662,6 +2667,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
     PCIDevice *pdev = &vdev->pdev;
+    BusState *qbus = qdev_get_parent_bus(DEVICE(pdev));
     pcibus_t old_addr[PCI_NUM_REGIONS - 1];
     int bar, ret;
 
@@ -2669,6 +2675,11 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
         old_addr[bar] = pdev->io_regions[bar].addr;
     }
 
+    ret = pci_device_load(PCI_DEVICE(qbus->parent), f);
+    if (ret) {
+        return ret;
+    }
+
     ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
     if (ret) {
         return ret;
-- 
2.43.5


