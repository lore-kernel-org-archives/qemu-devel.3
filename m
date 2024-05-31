Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE965C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 03:36:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCt3z-0007fr-UU; Thu, 30 May 2024 23:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt3y-0007eu-Nl
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:36:18 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sCt3w-0003gp-2s
 for qemu-devel@nongnu.org; Thu, 30 May 2024 23:36:17 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2c1afe1751cso934261a91.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 20:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1717126575; x=1717731375; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiOn0d9Pa8+qXsbBr3wAGk2xL3bXuiI7sz/i/2tw7Go=;
 b=PxSIzvYAckl/YCLUCLCeovANxKjvdN7PUdJhaWP56/k5JW+LkGBCpscfnq0MkuSsZ2
 xNBsYE5/xSrCakKjbmPOSEB761mHl4LUx46yVo7ihlg2swZypn0RB2oJF+3ZsepLIdKw
 dgFMCDJP8hfsLcFQLj9osYeM9FjPkesMHbM3N4xZRe8aT91IG6QM4/I5G8ELYclCfun8
 rUj2M91BbuTjCufp+eMFtVUS5X1u3oIB3gaJBMC3zpC3Gv4/X1lumQgFHfdzOKa+pXvM
 5VPqRrkjZb2ibeLD6FM+Y06YltzU59kcOqnK4m6AmGXOO6His81fmUG97kixyXDFVxtA
 axMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717126575; x=1717731375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiOn0d9Pa8+qXsbBr3wAGk2xL3bXuiI7sz/i/2tw7Go=;
 b=EbWpseq5/7xzL75j2SLmjwHAMgZL1qsHDqP/KKUPyrO45OCJDB7ZQ/TUng6zwtqPsl
 hyStf/61TYczn7MFBVYm3m95iHUt1RJmjBkZKLGzhlrme+InyFUBE01LLE1qoJavn+Wg
 M48v89z8FT2n9oMbgiWZyChVDSrxff4tKS6am0VANEwDqcGAgdesQAnNuc9HJR8YbybA
 RmZF2kDVhRgiRBygL9mx9chpuvfBe/XO0fNmhuIk3roxaN8PyxMJd+Z2oviEnMFS46VA
 HTaQ2r5Rqxf4dPcyNb0CZM8r58HfM08tDgpSQIA5KGA13FzNdlQMexPT3ruj8ApE+ZHE
 vmSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxqUQ9+wtNcF9knaEgJQxWyfoVEP0TXQHV7DsWVHQ1iSa5oSYX7Sz0vC11zdCDPR7ldFQkOxd3SMqZRbkGii6H9ubO30Y=
X-Gm-Message-State: AOJu0YyZiaxz0y80iSaq+HWBHqtUpWy1+N+MIYFqV/CJzAAAjNVqwcOV
 IJim2h9RD0/LPfuWbwkPqxwucg+jQXWM9mpJQhDtMZwDpKRHsfgJdsythl3wmgA=
X-Google-Smtp-Source: AGHT+IGrasCvSWWnjq1jCK0oAfHWHFCsE6yKYMKqP7OYhV+a9QFjUnhyvqXJMy1QOYQumCRXiju8JQ==
X-Received: by 2002:a17:90b:144:b0:2bd:efa5:5686 with SMTP id
 98e67ed59e1d1-2c1dc57eb3bmr633788a91.14.1717126574612; 
 Thu, 30 May 2024 20:36:14 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.142])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a777e989sm2457629a91.29.2024.05.30.20.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 20:36:14 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v4 08/10] hw/nvme: enable ONCS and rescap function
Date: Fri, 31 May 2024 11:34:53 +0800
Message-Id: <20240531033455.3774806-9-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
References: <20240531033455.3774806-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/ctrl.c | 3 ++-
 hw/nvme/ns.c   | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 127c3d2383..182307a48b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8248,7 +8248,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->nn = cpu_to_le32(NVME_MAX_NAMESPACES);
     id->oncs = cpu_to_le16(NVME_ONCS_WRITE_ZEROES | NVME_ONCS_TIMESTAMP |
                            NVME_ONCS_FEATURES | NVME_ONCS_DSM |
-                           NVME_ONCS_COMPARE | NVME_ONCS_COPY);
+                           NVME_ONCS_COMPARE | NVME_ONCS_COPY |
+                           NVME_ONCS_RESRVATIONS);
 
     /*
      * NOTE: If this device ever supports a command set that does NOT use 0x0
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index ea8db175db..320c9bf658 100644
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
+    blk_pr_cap = blk_bs(ns->blkconf.blk)->file->bs->bl.pr_cap;
+    id_ns->rescap = block_pr_cap_to_nvme(blk_pr_cap);
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
-- 
2.20.1


