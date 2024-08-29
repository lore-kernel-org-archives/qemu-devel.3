Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D9FC8300F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 08:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjakM-0007U9-W4; Thu, 29 Aug 2024 04:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjakL-0007Ef-A1
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:43:13 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sjakJ-0000E1-5d
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 04:43:12 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2d3d58d6e08so283423a91.3
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1724920988; x=1725525788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tjqh17JUE1WkBpchsBFPlHMHCUXRZeQxBDgeEciSrXM=;
 b=V3bm4ADZN1/lWCOwKrclD0dziod58BwZl9AiFXP8Z40bJ6tZoFg+ik1/fsKzTmiReF
 9ZZG8QMaZ0lUnTh68kybm5ldfSK7awn+SvskiZoX5mGwPo7faCoIB9SX8AVPEIva+Dwd
 IEUkXsoaImfoZStSSjIWlYHD5lsP7w3EZmbNw0W3cTpTqqCRnGMdIxoBu8K91pTSc/Jq
 fxM0j5Y55Qev0QZl3FDqCCZ7yVQKLX1eRLdwbsxXTy0Vade46tzE+lqnAfdCwEnYHMOI
 HbaxciN5KkR+TBfWvZVQZVz8ao4smRcGwHyirPDXeFMn8pS3/t0N/mjm+XYyvjzPNRKO
 xR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724920988; x=1725525788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tjqh17JUE1WkBpchsBFPlHMHCUXRZeQxBDgeEciSrXM=;
 b=K8cI22HLY7dUJuZzDcjyWhnDKHPB+FPXTxGWJL4OJiO45CgXiL5dS3bHrxXqajCLTL
 bVilVbWs268MUwGzj4A92KzpND89jkCjwUmIrpoL99zkoGXX+a+Bsyzeyun1C4j4W1iA
 r7FCL6tGWNiYvzxnRqFrQ+BDvOXD2xHC6zJUNE8apMmRd5ItIe+qBR9y+AHdTsda9dR2
 kcKnF7T980SLWxPFIwAgvkCDCUO6DiFJA9qGHI11x9c0bjV6qHh1xKFt1EZo7K/N+lyM
 LLOLtuNLVQxZt1qkBr6K4vrTvGhkPbYvgY4xUcBm6AxjE77qHeTDvmbe22wLDfkZxpQR
 ASKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBHYnU9jTyYKZ0PBwAogHcZcYtCy+imeiKHrFoh48fzX1uW1OmmKdCSESBEYTXSCPhcr2FpIBs/vgK@nongnu.org
X-Gm-Message-State: AOJu0YzjcTc0rAJKcbZgJuM1YsDlpyWe8DqhYHpOARhy5A4DPcDG6z+O
 1Cw/0ZwYjVUgzaphY6+1AZez7PxGyT8Cejwex1Uyzmadq4Rh2Z28O79XuZw1JUo=
X-Google-Smtp-Source: AGHT+IEUEumExd3Oy0k/BoTWco3k2o7bE0LEEWTSrZRLY2onu4AHW6bgy3ZngvEkX+KxWKMvyEvZQQ==
X-Received: by 2002:a17:90a:ff0d:b0:2c9:7aa6:e15d with SMTP id
 98e67ed59e1d1-2d8561c5948mr2066756a91.20.1724920987864; 
 Thu, 29 Aug 2024 01:43:07 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8446f3897sm3431856a91.49.2024.08.29.01.43.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 29 Aug 2024 01:43:07 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v10 07/10] hw/nvme: add helper functions for converting
 reservation types
Date: Thu, 29 Aug 2024 16:42:11 +0800
Message-Id: <20240829084214.50548-8-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240829084214.50548-1-luchangqi.123@bytedance.com>
References: <20240829084214.50548-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This commit introduces two helper functions
that facilitate the conversion between the
reservation types used in the NVME protocol
and those used in the block layer.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/nvme.h | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..6d0e456348 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -474,6 +474,90 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     }
 }
 
+static inline NvmeResvType block_pr_type_to_nvme(BlockPrType type)
+{
+    switch (type) {
+    case BLK_PR_WRITE_EXCLUSIVE:
+        return NVME_RESV_WRITE_EXCLUSIVE;
+    case BLK_PR_EXCLUSIVE_ACCESS:
+        return NVME_RESV_EXCLUSIVE_ACCESS;
+    case BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY;
+    case BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case BLK_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS;
+    case BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+static inline BlockPrType nvme_pr_type_to_block(NvmeResvType type)
+{
+    switch (type) {
+    case NVME_RESV_WRITE_EXCLUSIVE:
+        return BLK_PR_WRITE_EXCLUSIVE;
+    case NVME_RESV_EXCLUSIVE_ACCESS:
+        return BLK_PR_EXCLUSIVE_ACCESS;
+    case NVME_RESV_WRITE_EXCLUSIVE_REGS_ONLY:
+        return BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case NVME_RESV_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case NVME_RESV_WRITE_EXCLUSIVE_ALL_REGS:
+        return BLK_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case NVME_RESV_EXCLUSIVE_ACCESS_ALL_REGS:
+        return BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+static inline uint8_t nvme_pr_cap_to_block(uint16_t nvme_pr_cap)
+{
+    uint8_t res = 0;
+
+    res |= (nvme_pr_cap & NVME_PR_CAP_PTPL) ?
+           NVME_PR_CAP_PTPL : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_WR_EX) ?
+           BLK_PR_CAP_WR_EX : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_EX_AC) ?
+           BLK_PR_CAP_EX_AC : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_WR_EX_RO) ?
+           BLK_PR_CAP_WR_EX_RO : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_EX_AC_RO) ?
+           BLK_PR_CAP_EX_AC_RO : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_WR_EX_AR) ?
+           BLK_PR_CAP_WR_EX_AR : 0;
+    res |= (nvme_pr_cap & NVME_PR_CAP_EX_AC_AR) ?
+           BLK_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
+
+static inline uint8_t block_pr_cap_to_nvme(uint8_t block_pr_cap)
+{
+    uint16_t res = 0;
+
+    res |= (block_pr_cap & BLK_PR_CAP_PTPL) ?
+              NVME_PR_CAP_PTPL : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX) ?
+              NVME_PR_CAP_WR_EX : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC) ?
+              NVME_PR_CAP_EX_AC : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_RO) ?
+              NVME_PR_CAP_WR_EX_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_RO) ?
+              NVME_PR_CAP_EX_AC_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_AR) ?
+              NVME_PR_CAP_WR_EX_AR : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_AR) ?
+              NVME_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
+
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
     uint16_t    sqid;
-- 
2.20.1


