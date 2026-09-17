Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14AAC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GXQ-0000ig-4Z; Thu, 17 Sep 2026 14:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x7GXM-0000i2-2R
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:08:45 -0400
Received: from mail-ej2-x1d.google.com ([2a00:1450:4864:34::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x7GXJ-0006p5-25
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:08:43 -0400
Received: by mail-ej2-x1d.google.com with SMTP id
 a640c23a62f3a-c254fa4c24cso190266766b.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1789668519; x=1790273319;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hb908BYvRZcKGE37Gf3HIxZuqnWARz1HEk9wZBI1YAA=;
 b=coExzdo0XxthnkbwoTgzwmJxqwszicOrfnsDzCWo1fSEB7mt9ub4X+2pqaO5YlrjLL
 VYRFbjbqW8tNV77cvEsk+c0kVu5EVD22Q1JvGL/dP9JnQxKDUmev6/Rx20W9is7eX1/m
 Qj6LjfeOhOhzk7BauL3pEVnYD1qSi/CMSCPr9rgMS/Up+6dSIhSgQWGCZoK+WV0QCC0r
 peWuiZF7UD7g6gtWvnLRHwViADYEzDfIIr0t+F5b4eVC/BogDmSHLKI/3EMHO01a6PH3
 ihKP9FoGDGRkrXafW1K7B8c68PrZA0axoRfoXpwU8qD1EPzcaSn+dFwC7mwaupcoIPtG
 S/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789668519; x=1790273319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hb908BYvRZcKGE37Gf3HIxZuqnWARz1HEk9wZBI1YAA=;
 b=KndDah6obd2kBDQJ9rR1lkgSJpyp91hxr2YZMFiJmRgglHr3lO3XbfektKIuT9W8/o
 zkrIJLIrcbEEeQuWAj82IbMRBCVbeZCKq1VgQoFKZtSZmz7RfT9Pvs4ctHyzeZ/H6zub
 0cDT3Z+KPKFPxtbra9IJYqxMquUA+6IidoC1h+NXl/MCXG2jcMefF84J5/zpILBPDOle
 b2F1m2hC55/cKaO7vcs0rJhqtFIC/MYcyVLlhLOlKRWo0CsNDXj2dVR6t/AkRsCl3ZzG
 bMZWx0ttxqWSDnybaDOAxmK6BVe3GKjmE4lmhdXc8FshJbA1Q8HM/0A3+j06Hfaj7gDE
 yBeA==
X-Gm-Message-State: AFuF++kNH9anjauTZAD9toQWM3nf4BSaYWdtO+R7zVwJJ37p7+Oajg1D
 4anlKotsQRYZXO9a1sS5TOb2gLvrMAVo8DFQA9r6nJ8PKGh7gIdyaWNSyQsRZrckxAFW2kPBnnI
 AIjvz
X-Gm-Gg: AYBFou3GdsSKJxvvgpytBWOrx5Zy9x6FR/VAcRdzbm2TtW9tiJ17/xcHYRWhtp5vBYD
 Q0uT8+DWh5SmuE1BXM4lmCoS47feEgYYQ0coPbBFSxI9kBxqIghbBw3zg2XavBOx4T+/Joe1usG
 uZ/TkW1GMbXQtSAPweS4EZNKcQLf2eiR0bZ3JUpytCdxkgrYO31HRrafTtQkzGJIuDwOjjOeDKO
 wgrlVkGzq3NC2UK9rr2HOGO/JBf45ZzYKyFemWoesvsZz9ddONWXv+FadgEEzKPeDEUnELfIQUk
 vy7QHYeTjQfJ+5mggoT3vAcxg5lqJyb5i9jDZkriUOn3KAuiGdO5vVWHfDkvStWY/ruoTCmQ1t3
 rVUpD+3mRxgpXJ6wSJSRKw/pvy+X4wlFN0INYA3ZWu6+tJX4w1cIb7EC4UaUKQazUxjUh4itHzW
 g+cw/vqxDXsJ8c+oNnG6bLoJb22NomRbCafz5dSapU3OmH4W9UihooxrzqvjuS7y/h5B1kUhjPW
 Evj7jxABHjxqZbFUGowwRBsIPgwjdxgkdtbWW6H7Y2jfHIHFdtHoT7TUV54BU90kVXQDHsel5E=
X-Received: by 2002:a17:907:18c4:b0:c29:3c21:ee69 with SMTP id
 a640c23a62f3a-c29e52c8542mr536845066b.23.1789668519382; 
 Thu, 17 Sep 2026 11:08:39 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de5a5337sm334676466b.34.2026.09.17.11.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 11:08:39 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>,
	kraxel@redhat.com
Subject: [PATCH 2/2] pci: Add device ID for CnuasGPU AI/ML compute accelerator
Date: Thu, 17 Sep 2026 18:08:29 +0000
Message-ID: <20260917180831.3142920-3-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917180831.3142920-1-weqaar.janjua@packetfive.com>
References: <20260917180831.3142920-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:34::1d;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ej2-x1d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

PCI device ID under QEMU vendor ID 0x1b36, device ID 0x0016

Request is for the CnuasGPU non-virtio QEMU device model of the Cnuas project.

CnuasGPU (QEMU device name: cnuasgpu): an experimental AI/ML compute accelerator with a guest Linux driver and user-space runtime.

Datasheet: https://cnuas.io/cnuas/docs/datasheets/CnuasGPU_Datasheet/

The allocation is requested in preparation for public release and upstream submission.

Cnuas is an experimental rack-scale AI/HPC emulation platform for functional experimentation in academic and industrial research and development. Its architecture and device interfaces are described in the public arXiv preprint paper:

Cnuas: A Software-Defined AI/HPC Rack-scale Emulation Platform and Hyperscale Data Center Facility Twin
https://doi.org/10.48550/arXiv.2609.15889

Website: https://cnuas.io

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index ec65a0e9ab..9672f13184 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -102,6 +102,8 @@ PCI devices (other than virtio):
   PCI RISC-V IOMMU device
 1b36:0015
   CnuasNIC RDMA network adapter
+1b36:0016
+  CnuasGPU AI/ML compute accelerator
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 51b3f83514..ad74f5456e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -122,6 +122,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
 #define PCI_DEVICE_ID_REDHAT_CNUASNIC    0x0015
+#define PCI_DEVICE_ID_REDHAT_CNUASGPU    0x0016
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.43.0


