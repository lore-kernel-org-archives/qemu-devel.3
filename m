Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64FEC531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 18:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo3d3-0003Gz-9P; Sun, 26 Jul 2026 14:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wo3cA-00035w-FX
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 14:30:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wo3c8-0006Sx-MQ
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 14:30:18 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-495502852d1so2334395e9.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785090614; x=1785695414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sUFLhYstuO/XlafElkPvKSdsFnu5LT4q66F/BUCXJcs=;
 b=dhw1l2KIsP69bgE09gnARt9Lg0Q/+N4rqlX4fqZ1rwSrJBP0j3opROhtcxWdlewWUT
 Q+nVlkhZF0oTcURh/Js4yQ7mtO1viaoEFsp6jvzzAYITsLUmOVzlxkH9nx7Jdb0hWvoJ
 uLKRXpB4jndLpdthyUf0cWx5a7yEHNZKGU2DwXwTxD6x9BpBjYUnPBtpr5Nc5sytqQNO
 jKl4uwNB7nVm/9GPoGoSB7BAUBb3BD7XledW93Sr9OPG3mzYGIvyVvtWkr4vDB6jwLts
 WsQ8bES9wNYl1AawaznvSKM8MFHcZXsko2VkeQLth/LgFJhKAM8MENzcEiAIn7aAS2me
 zqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785090614; x=1785695414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sUFLhYstuO/XlafElkPvKSdsFnu5LT4q66F/BUCXJcs=;
 b=ZLiOHafgL6wo7aKCK3YBm8Sl1HT288y7GBUVBMh66c5mQR7m+thyHOUbn2zXv/GsNx
 PKOGtnxvhIk69xZRQlzx8W1FHRQrsM0/wqHqvc23WIQD4VwgSe7exPHcR7Wt/hX+64XB
 iME4FjwrXShfPLgI/g8f696gynIrTxzcf7zgpzH92QcEI4XEwL0OTyECfkVOhvku6r6P
 xkNWLVvv5Ugjndr+1MztKzHBfbftAxorVt+higc8uLPJEhzTGMIWYM/wtnI4vozwFEfn
 xlyEtlD9jHfyuEKZafiXgIfB+OQhlHRGjddKcWZEqt44b8QkGP7WryltNtIvVZN6m1ev
 yD/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8Hvf3lxe3mj5nbt/e0VmxLIJtNoZ3pNRDEiHjIk5JMeRDFk1cwCFOEVvrnx1V38M8lGGnXT12Q0p6@nongnu.org
X-Gm-Message-State: AOJu0YzMUbz2zBDddrtaB1aThiB1WJpQYpkcvlnKDzhWjSvDy/TJquf6
 XH2VoJouA0zKJdTzgFPcqSQ0K0uuPCxwj2bc+9ff5za9PIYfIAEUg39S
X-Gm-Gg: AR+sD12C5MEmUi+dPYyBqCRo8hMtbQ1PCSt6RDaS/xDWlY2HV0+j+/T5tFmai/nByxr
 v6zXys4auFW/lr6apPSMgyvc/16vphEl7ZDBXnY8vcAOx8Z4uJZYoZuCi3nvAe0mdpDIebdTnyX
 uBcNA6MJfV5cEYvzR2iMRn+iB8uNcazMZeEhHVgkna3eS0qo6YG2jPQaa2QAp9umgLCUjt4TjHU
 u16w18TBEEFVNZo9k8l0jnBvHQW47YTu0689IXfn37Bvr3QsIiaKXBAaL2nNZIGD8dlKNeNTeDK
 wHVaf5FrqFopmH8VfpAUi54Jm3bCXpdKKoSTheAlfQooO8H28aGHxJJ0gUZitgvhQo3pTTJV1Ap
 jaBgB4hgMB3FWNy3RhJwAA/Xt5OLuHCkdyC3Lv7nedy2HxwtMd1XRRLAkMYNjzcWzkoDj+GqRV8
 IE
X-Received: by 2002:a05:600c:3b0e:b0:495:4044:11fc with SMTP id
 5b1f17b1804b1-496b5754493mr43875225e9.7.1785090614126; 
 Sun, 26 Jul 2026 11:30:14 -0700 (PDT)
Received: from AtiePC ([79.112.95.175]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb57cfsm43122504f8f.11.2026.07.26.11.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 11:30:13 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>,
 Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org (open list:nvme),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] hw/nvme: fix assertion failure on subregion removal when
 removing a nvme controller with a msix exclusive bar
Date: Sun, 26 Jul 2026 20:30:08 +0200
Message-ID: <20260726183008.160498-1-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When a controller is created with a MSI-X exclusive BAR, the bar0 memory region
is not used at all, and so, the iomem region is not added as a subregion of it.
However, when removing a NVMe controller, the iomem region is unconditionally
removed as a subregion of bar0, causing an assertion failure. Remove the iomem
memory region as a subregion of bar0 only if not using a MSI-X exclusive BAR.

QEMU options (requires a hotunplug-aware OS):

        -M q35 -device pcie-root-port,id=rp0 \
        -device nvme,serial=ctrl0,id=ctrl0,bus=rp0,msix-exclusive-bar=on

In the QEMU monitor, or by causing an ejection from the OS:

        device_del ctrl0

Message in stderr:

qemu-system-x86_64: ../system/memory.c:2617: memory_region_del_subregion: Assertion `subregion->container == mr' failed.

Fixes: fa905f65c554 ("hw/nvme: add machine compatibility parameter to enable msix exclusive bar")
Fixes: 9162f1012576 ("hw/nvme: fix msix_uninit with exclusive bar")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4090
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/nvme/ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e159889..142fbe033e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9710,10 +9710,9 @@ static void nvme_exit(PCIDevice *pci_dev)
         msix_uninit_exclusive_bar(pci_dev);
     } else {
         msix_uninit(pci_dev, &n->bar0, &n->bar0);
+        memory_region_del_subregion(&n->bar0, &n->iomem);
     }
 
-    memory_region_del_subregion(&n->bar0, &n->iomem);
-
     migrate_del_blocker(&n->migration_blocker);
 }
 
-- 
2.55.0


