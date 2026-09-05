Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D3FC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 12:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2pLy-0004Ml-S2; Sat, 05 Sep 2026 08:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x2pLx-0004Le-6x
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 08:18:37 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x2pLv-0001A2-Gv
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 08:18:36 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482e1b55da9so208753f8f.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788610714; x=1789215514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+IUpNcB02wW+cFoYTYG7CNyjL1aH81MjtkfSh/Ay9Rc=;
 b=PLoRi6rZaVjxvEuzHaO0Ah+FhqyIYL4RmsZqL/6BftHhCdTMPkaT+emag+OnEMPpVo
 KUCnUptZYh5ZmGc/rcId0snKx3FEn5NqB6xjCPTZC8HHtk57oLwEj29IaSuF57JB43c5
 ttMreSggSg3TFcNmZbmXk/aykUoNMC2HSR+TtdtqJCvIZoeSRFIL7/H31Pxo2yJeoQgH
 cJwLTn66XL6CapzZMhTrqJLGYEee3Y/3flK2i4bqSZdtiXkyjh95ktYAEmu2RG+Y6gq7
 5Pti6W14/xz3zfYM4vIe1sjb3ToqU5aedKcv76X1YMduNtqwwsiyzHLdIYIq1Ye6Uzjv
 68fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788610714; x=1789215514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+IUpNcB02wW+cFoYTYG7CNyjL1aH81MjtkfSh/Ay9Rc=;
 b=KJ7E9N1hP6FT8yLOH8W15l0wWoDBCxWZd/6FSqWjL0YL2AA+wM8yscBDlXE0UW0Ubr
 gTUAiFb7jQrPVcZ0JQbF7mZktxnjceifc6IToV0b7kpohFeklUsYKghEQ7hV8uH50vJL
 0QOQMvpQo0p4Hm1LVFW8GGQ/oHGJWzzSm9fkjDhVQYl5ASOMekE/NX3gERRYLaLbg61L
 PJzVclh5+PQ7uT0+FPCjApA6LsgGwlb9ugAgMK2V/NkQWDnP3uc3j3Pv0WMYVhEYBqhw
 jP4Z/XF0epYhf0jchGr8d0so27nIExscO7ibPY7KQJYyfColPOEZvgn5pmzFR12GvW6U
 6pbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzmnUizeBuLY8YnICqyuX/8VAVuGBAgH/FiBLQXV52lLhjpumCpnhmVOXsZEKlY0/SN5i21balnDq3d@nongnu.org
X-Gm-Message-State: AFuF++ldQc4vQEKr6hGeoJJxEKB5uIPZhJEQSN5+jZKYYAXwAuyGcNIj
 hml8BI94tdAmN5Zp3Udikme4xDzibvwX4CcQelBAAbnZurKJcn2nma6R
X-Gm-Gg: AYBFou3CRkUHHAgreCgF2uaumwS2+Wm52c2CSZY8cHC1uHqyLb9udy6ptEb5ieE9bz2
 o+Y5/EYpyOnn0YsYaR6TR6lsuZfyf64hW3rKQRqrvEDYZbHP4BCJtp130oa18hpWDDzPqkwgYUV
 Vf3cd6A3uVmanvxjomiZ8kAUj83IEYeAjg4bxCNMJRxj1i8otuPRoa1D/+1APQMwVnFUAzNQjCK
 P367c4BERnn+3nNv4ntNwl0Dbr0eJ9QVDo3vgf8VKWrmqskpf2l3wgAMl7Rm9KLYOIFM3IXRv9S
 lePEbJzkuF4C0KehqxN8DQKVeswWq8cUBCZuZjrXy6BR9Ijyy/bDwz17wgp6lCAKfTpCafyZcpB
 yFwPi2xU2ycPBglJ28OA1sD/K5um9pUoItl8TYD/E1IPpDVh070F7SRhCoB5mYlDMMrnabO1lyh
 FR6vNxlTdF9f3JQoP6g2Avqw006sughy8Uup8a7WSxrJs8BQYXUMF7MuJx7A==
X-Received: by 2002:a05:600c:a305:b0:49c:ff81:e062 with SMTP id
 5b1f17b1804b1-49cff81e076mr53512705e9.2.1788610713850; 
 Sat, 05 Sep 2026 05:18:33 -0700 (PDT)
Received: from AtiePC ([79.116.0.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm234546625e9.4.2026.09.05.05.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 05:18:33 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org (open list:nvme),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 1/2] hw/nvme: fix assertion failure on sr-iov capable nvme
 controller removal
Date: Sat,  5 Sep 2026 14:18:11 +0200
Message-ID: <20260905121812.47816-2-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905121812.47816-1-danielpaziyski@gmail.com>
References: <20260905121812.47816-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In a nvme subsystem, the ctrls array maps controller IDs to nvme controllers.
The value of the array elements can either be NULL (no controller present for
this ID), SUBSYS_SLOT_RSVD, or any other value, representing a pointer to the
nvme controller structure.

The SUBSYS_SLOT_RSVD value is special: when a nvme controller physical function
is being created and is reserving the controller IDs for its virtual functions,
it indicates that the slot is soon going to be filled by its corresponding
virtual function when it is realized, and on virtual function removal, it means
that its controller has been removed.

When the physical function is being removed, it goes through its list of
secondary controllers (virtual functions), ensures that their slots have the
SUBSYS_SLOT_RSVD values, and then frees up the controller IDs by setting the
NULL value. This traversal occurs before the virtual functions are destroyed,
causing an assertion failure because the slots contain as values the pointers to
the secondary controllers.

Destroy the virtual functions (and therefore, the secondary controllers) after
they are offlined in the nvme_ctrl_reset call of the physical function, but
before releasing the controller IDs of the secondary controllers in
nvme_subsys_unregister_ctrl.

QEMU command line (boot with a hotunplug-aware OS, such as Linux):

    qemu-system-x86_64 -M q35 -device pcie-root-port,id=rp -monitor stdio \
    -device nvme-subsys,id=subsys0 \
    -device nvme,subsys=subsys0,serial=ctrl0,sriov_max_vfs=1,\
sriov_vq_flexible=2,sriov_vi_flexible=1,max_ioqpairs=4,msix_qsize=2,bus=rp,id=ctrl0

In the QEMU monitor:

    device_del ctrl0

Message in stderr:

qemu-system-x86_64: ../hw/nvme/subsys.c:49: nvme_subsys_unreserve_cntlids: Assertion `subsys->ctrls[cntlid] == SUBSYS_SLOT_RSVD' failed.

Cc: qemu-stable@nongnu.org
Fixes: 44c2c09488db ("hw/nvme: Add support for SR-IOV")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/nvme/ctrl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4893cf7e74..3040cb1760 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9702,6 +9702,10 @@ static void nvme_exit(PCIDevice *pci_dev)
         }
     }
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
+        pcie_sriov_pf_exit(pci_dev);
+    }
+
     nvme_subsys_unregister_ctrl(n->subsys, n);
 
     g_free(n->cq);
@@ -9726,10 +9730,6 @@ static void nvme_exit(PCIDevice *pci_dev)
         host_memory_backend_set_mapped(n->pmr.dev, false);
     }
 
-    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
-        pcie_sriov_pf_exit(pci_dev);
-    }
-
     if (n->params.msix_exclusive_bar && !pci_is_vf(pci_dev)) {
         msix_uninit_exclusive_bar(pci_dev);
     } else {
-- 
2.55.0


