Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F48C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6MkZ-0001KA-5g; Sun, 12 May 2024 23:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkQ-0001I2-Sh
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkP-0008LE-8m
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:10 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f44ed6e82fso3514559b3a.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572388; x=1716177188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZOIOSzWw7S5O/W1X23ZvIZbIDRDARXSDRkqo9S5Wbo=;
 b=PTmXv110XVCFuMCrvt+WHj6FyU7VxfMxcywX8zuOeEKYS2twcS2CV9EWuaoQnyoVz0
 0+ZlCGEV30AKCe7wYsL1C3rTUi6orBrpUmPqx3YCPZ3ioTEtZI3cuALVoEmesowsE+z7
 5aMAle+UL3Jxn7Q3nuRjNCaaAJo9qOA0Ul8SO9EDQibITpbLJk/3bWGtEMPmbaJ08KT/
 Jw5dy2lUrT1Qx0E6fsjG0CDOC0XahLKXLmJG/vuavN+FbCfwnRj42tg5iuBnYSIraBcK
 +jY1lIY8NbYWAAJgiA9O60h0h6ATSDiJJx4dnlyBxmfBC7ImlCB2Ewdo4sCsOhm/cQwl
 x+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572388; x=1716177188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZOIOSzWw7S5O/W1X23ZvIZbIDRDARXSDRkqo9S5Wbo=;
 b=jMRl9bymQokiWvP8nAzpG0vydYdzQcubF00Q86uayMx0yHOFKM4siqKopgoUJpXVQI
 A07gSFqfPs5LbvrHaOmbObOok1imAlgk+QXXwiI7LM6twBq5z88cS2NqWpfuX/+3YrAL
 ax2qzTRvt0yIG+1GP3rwD7Dn62HnAv+rSSu/l08dRz4GQOnbaCUV4GJxVSse8aKGoyyV
 nvirg3T1GZ1FzkGaGHGxcVLNkvQ799sehpdieIaKrXgD8m7lQ0QAOf/MQR+zocSYjqdO
 5Shpjk0QVd9IFdNkYlO7OrWdZh9QcexpF28EJBKD1VoIDszUEKL1kFQbbtlx4+eehOCO
 YP0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRLfhOfi1raWT1Q/YSom1ndmeRtCpesP4yP5VJMcB6opH1ecBVk7VTiXFs1h1RxWrzzg2sC7kGgxlqIopMtG46sHYpu08=
X-Gm-Message-State: AOJu0YzqIqXfIA19l0IypA5BikTj4IMC9uAbglMOEmYEvefEJSzGo3Lm
 yG+UlNIBDXDSQLSauHZsDLGKgajvAZJLeI3irC8J51txP4CsoUQluAAyF7p49BQ=
X-Google-Smtp-Source: AGHT+IHKh7ejZmhEpBtm9r81LU94Vz5oWQyXL5fAdo1sStNRDrExD+hZ6qZ6RQOsD0BH4hjVnmsuIQ==
X-Received: by 2002:a05:6a00:1409:b0:6e7:4abe:85a0 with SMTP id
 d2e1a72fcca58-6f4e02c65b0mr11802733b3a.14.1715572387696; 
 Sun, 12 May 2024 20:53:07 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:53:07 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 07/11] hw/nvme: add helper functions for converting
 reservation types
Date: Mon, 13 May 2024 11:52:26 +0800
Message-Id: <20240513035230.60162-8-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513035230.60162-1-luchangqi.123@bytedance.com>
References: <20240513035230.60162-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x434.google.com
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

This commit introduces two helper functions
that facilitate the conversion between the
reservation types used in the NVME protocol
and those used in the block layer.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 hw/nvme/nvme.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index bed8191bd5..6abe479410 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -474,6 +474,46 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     }
 }
 
+static inline NVMEResvType block_pr_type_to_nvme(BlockPrType type)
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
+static inline BlockPrType nvme_pr_type_to_block(NVMEResvType type)
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
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
     uint16_t    sqid;
-- 
2.20.1


