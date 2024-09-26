Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B94FCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 07:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stjDA-0004d8-JF; Thu, 26 Sep 2024 03:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCy-0003ox-Gw
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:49 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCw-0006LE-MG
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:40 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-718da0821cbso561630b3a.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 00:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1727336797; x=1727941597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpXCvHD2Qslc03OqNFilh7DiBfbBLmsoxBWva+ViCzE=;
 b=SqBmOnN33zxIxq+Oy9bRTo+3mcYA3dJt4+F2r96NYLnULtDMALfJ1vZm9zK13KvXNR
 Rc5CyhKq6r9mOS7jju96sS54LCvz6XhQ2Ire1Uvu6b5A+kzBhAZylN36uUR7gbdJdKkN
 /AOqKw1p/y8hStiuWbpXwqnFZi2zx6/ZBwgZfqdw4brn6IJW/+cXpFKlJiCwn1rKDq1+
 7U8L1VcL5Tn4zychtfuETArdaseJYRXV0+pOfpEMugM9aryLvEaREuJjZCf74gFs5Rrm
 NLRkuFS0H1xPncR9tCTJlp8aqEKRjQR48Zt14NkqkRKppS9Y99w4XMS2On7mQWz1oQWW
 GJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727336797; x=1727941597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpXCvHD2Qslc03OqNFilh7DiBfbBLmsoxBWva+ViCzE=;
 b=r3cmnF2mAo1mLqw5JJg3O+kLYZuIVZJ3+muUY3cVLjorlYjIV/fxMZm+Wdn0kfpVZP
 pK9yz4PsPD/McsxsCuTFuYrsn6P/6OuAELlR7z/tA2Ze3dkfcM1UurvaY5eSJbO2pDa4
 /jijewZecn1xAQ8b6Z9dkNRct0CdBdyXe91leWAwVzQghXBnTpQr0Dkgi7+KPr6FpPyb
 /qP86R+g5yiPeU8U80k/pdNSXMCziAGqeXiRoS4TFAP4VkQIAvn2oJ/jqRE6Rw2Dr/Zy
 AxQnfkXMjxVhRdwjJPk+v5rL107WXx8bZQiCQPctcAtqCHrCsPo9qVdLjrocqOKNHBVg
 Ys5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjaWyeziNvbWGiPUpKUzv+H2xoh5kXvi8I7CHOD0rJssr9tTJJpzMFu9s4Y+P4So7XNFxqo2EcsWrs@nongnu.org
X-Gm-Message-State: AOJu0YxV6JPf6NQW1mwRTdSxy/auyL5a5MSp7ZvLwZZOoIzWvHwLLHV7
 NjmDh+644w8Hdp7raWfrWMle45D+IVUJ1xg17ABOZt/OEcvHtsJl4DwwcK+lG/c=
X-Google-Smtp-Source: AGHT+IFDePEoGGbAKbN8ry1Q+n9UxlH/2Ctiw1SWapCz+bNejyWYiqshKrvk70UKOp1wbnhasNeIMw==
X-Received: by 2002:a05:6a00:190a:b0:718:da06:a4bf with SMTP id
 d2e1a72fcca58-71b0aa95113mr7015938b3a.2.1727336797327; 
 Thu, 26 Sep 2024 00:46:37 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6b7c31bb5sm3683357a12.16.2024.09.26.00.46.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Sep 2024 00:46:36 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v13 08/10] hw/nvme: enable ONCS and rescap function
Date: Thu, 26 Sep 2024 15:45:44 +0800
Message-Id: <20240926074546.24507-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240926074546.24507-1-luchangqi.123@bytedance.com>
References: <20240926074546.24507-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This commit enables ONCS to support the reservation
function at the controller level. Also enables rescap
function in the namespace by detecting the supported reservation
function in the backend driver.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/nvme/ctrl.c       | 3 ++-
 hw/nvme/ns.c         | 5 +++++
 include/block/nvme.h | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..ad212de723 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_RESERVATIONS);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..a5c903d727 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -20,6 +20,7 @@
 #include "qemu/bitops.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/block-backend.h"
+#include "block/block_int.h"
 
 #include "nvme.h"
 #include "trace.h"
@@ -33,6 +34,7 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     BlockDriverInfo bdi;
     int npdg, ret;
     int64_t nlbas;
+    uint8_t blk_pr_cap;
 
     ns->lbaf = id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(id_ns->flbas)];
     ns->lbasz = 1 << ns->lbaf.ds;
@@ -55,6 +57,9 @@ void nvme_ns_init_format(NvmeNamespace *ns)
     }
 
     id_ns->npda = id_ns->npdg = npdg - 1;
+
+    blk_pr_cap = blk_bs(ns->blkconf.blk)->bl.pr_cap;
+    id_ns->rescap = block_pr_cap_to_nvme(blk_pr_cap);
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 8b125f7769..9b9eaeb3a7 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1251,7 +1251,7 @@ enum NvmeIdCtrlOncs {
     NVME_ONCS_DSM           = 1 << 2,
     NVME_ONCS_WRITE_ZEROES  = 1 << 3,
     NVME_ONCS_FEATURES      = 1 << 4,
-    NVME_ONCS_RESRVATIONS   = 1 << 5,
+    NVME_ONCS_RESERVATIONS  = 1 << 5,
     NVME_ONCS_TIMESTAMP     = 1 << 6,
     NVME_ONCS_VERIFY        = 1 << 7,
     NVME_ONCS_COPY          = 1 << 8,
-- 
2.20.1


