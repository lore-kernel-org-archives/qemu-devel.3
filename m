Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBDBECE584
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 11:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sncgU-000318-2M; Mon, 09 Sep 2024 07:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncgP-0002r6-2R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:49 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncgK-00016q-NA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:47 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc47abc040so36344005ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725881743; x=1726486543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpXCvHD2Qslc03OqNFilh7DiBfbBLmsoxBWva+ViCzE=;
 b=VF0/IqaUDemtooYWUYP/hjmgI1bJ78jsmOVUuVbzPHxTvQldMbvP/Cb86oVYM7HC1f
 LlcLaVHDRJVf7TEK+uQ7cJEzcfvRj7zOlpMmpyftXs4J77NtfBZMOTqaWz6qhxMtsR3m
 7w8EaUnn2iSghPZeh2hKJNGLvN3/8bJZMyvMJbhBfkHedgnIeEN+B1znt1Zn1hCw7n6c
 ToD12Zym4ihKw/qWw0UsACTisBARpHvy7MEwF2GfW1qqIWVx0p+aV7TTiX7OKF5EdT8j
 bomZV9vxHfpLWIRD7kz7/lYou9Ld7DMyBN0sjfQlfUwJ0FHuig8JcFf9AZMiV2oTJbkT
 w9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725881743; x=1726486543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpXCvHD2Qslc03OqNFilh7DiBfbBLmsoxBWva+ViCzE=;
 b=m7wMIPplxRsnlkW/Etf8FA/Fz/DYhElXfMBvgnWvyarfFjKnsku9zTodj1Fbj1+13+
 H4yk0Vs0j1IQIE1O/CXULP4sPOYGYIYo64aDg5SJW6aln9fYpGixwKuDz5hOigfbG/WF
 OaK22I5Y82pLtXaEEpFJUM1Gr963A5q3B5zanCHxPoiux6R5bEHBpL6nfSl+u3I4hBC7
 WE0UIlQfbv6yW4X+ZVoR3z42xGI62hVEtE63mMmx+00rZsTmXFvtmRjR1BpUDsxIJxbD
 +LQlgurc1/BmAQVGbGM5Ac+MT8sLVeLi4pLER/4iWzmnZaGVz3l9JNP5umYMSDafSEfX
 Dp4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5o4l73K+/Dx0cLs9S4yMwRtJQymMc+3UHHs1AqwE7oYeSnodgJO82ylMq6l9WhQjwzSnFVXULlXZg@nongnu.org
X-Gm-Message-State: AOJu0Yymn/THDgajBaM7pG6WyZpxdSK8L9HFUhg0tuXksTaFIqXbRkjx
 8+zo/+TdOqYZv6dwNWx9l5V22GexbCvUy5GbcEpuPID6GR9oQwetfxKdTnARuG0=
X-Google-Smtp-Source: AGHT+IFsDCJJHK01GE/1dMRpO9kWa1a6uXU6mLFrXIuL7Qa63eUFTYqP2RCqTYpQJv/1L8KuWRrBKA==
X-Received: by 2002:a17:902:e5d0:b0:205:5bc9:37fb with SMTP id
 d9443c01a7336-2070c200f88mr101006355ad.61.1725881742965; 
 Mon, 09 Sep 2024 04:35:42 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e328aasm32378605ad.91.2024.09.09.04.35.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 04:35:42 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v11 08/10] hw/nvme: enable ONCS and rescap function
Date: Mon,  9 Sep 2024 19:34:51 +0800
Message-Id: <20240909113453.64527-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240909113453.64527-1-luchangqi.123@bytedance.com>
References: <20240909113453.64527-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x630.google.com
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


