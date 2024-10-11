Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBC8D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJFA-00049p-MV; Fri, 11 Oct 2024 13:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szJ7i-0004AI-7u
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:19 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szEW6-0004tP-QZ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:13:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20ca388d242so4213245ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728648789; x=1729253589; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CUQGygF7ax3lHkGrG99vLN6/xen2jiCuqCocfv+MI40=;
 b=AbKpzPuVzItF1V7ReqEWqH4fRKEx4wU98JJfaB4ZqFxH1xqBU91QqRflFH5gDNwE6a
 4sFCefnZfBsbewMIQfxDj/XXNbdy9oEg6vtrEYBTmsSOvutjC3Kfu0EcupNFdiRxnazR
 skcLsAQbdRykJcIgR5bw8WsjaI8wohz5JHe9VFZoP+7oHWhQu9BXfluQ2h2bObr4voBF
 EDPBfjfhe5/hJ1vK1uWvHBy1Cggi0iS/lRzVXnXS5u45uh7OpNZLc6xT3VHRWQu3+LcR
 CmqCgCAA30SE+OomLzz5+HG9ipK2TwumbRaQqH4KVrwyQATYBbcmrcmRbhsGXTpWbp/t
 SKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728648789; x=1729253589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CUQGygF7ax3lHkGrG99vLN6/xen2jiCuqCocfv+MI40=;
 b=ohefkHrdvA+RRusqfbsjKJj7gpxFWECVyxa/icsPZon4h5lkDcZz9wDywyNYUOdcgk
 U+fG5xvP/GqkPwY5BKvE6dcDq84P8y2xeuUYbDBaScaBOTHgsUNSyeURQ9V510zWtAas
 svHtG/NQJXJwT97BFrh2rSA1vhdoUuZoLFQqYfZAj5MLbDX0HbJ21FjLHLBvyS/caGJ8
 HRpl5nd40JzgoU1YHA9VJ1hv1VK0yIgQGnrW3FdUkjkbqYKSK73NcfjTYiXZZQ5K+AYs
 W0ZUarnKnUtxNNM+eMnlVVW/iNySlEQ9GszsCKa9RXDd+7Bd0dQmzOIOa1WabR8Wdnz5
 KxCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVybO1ehN+UYr/uhOtVpz6GSMl1OqXfKvMrGGPaJGCA6nBKsrz+/ydB13X954nIuwaN2TlVHx2he4Ig@nongnu.org
X-Gm-Message-State: AOJu0YwnFuZl9Amw3P7+vFB7e6OAQDk54emmfYze83IlVIM5RFGYE2rh
 RUArWHvX4YlXiEnS3ntoHZ9VzLNmfXRq8cGf2eyo+8fTINTxfjX+NNaiYhQxbW8=
X-Google-Smtp-Source: AGHT+IGtAbrKtQaXIau5W4nalaZrL9YM4AdjlLjIse3y6ZkmvZ45eKwslztWYIo/Oou/qBRNTXhoxw==
X-Received: by 2002:a17:902:cf04:b0:20b:ce88:1b9d with SMTP id
 d9443c01a7336-20ca16a0d51mr34316845ad.45.1728648789207; 
 Fri, 11 Oct 2024 05:13:09 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([139.177.225.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc13551sm22569305ad.88.2024.10.11.05.13.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Oct 2024 05:13:08 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v14 04/10] scsi/util: add helper functions for persistent
 reservation types conversion
Date: Fri, 11 Oct 2024 20:12:25 +0800
Message-Id: <20241011121231.18333-5-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241011121231.18333-1-luchangqi.123@bytedance.com>
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62d.google.com
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
persistent reservation types used in the SCSI
protocol and those used in the block layer.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/scsi/utils.h |  8 +++++
 scsi/utils.c         | 81 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index d5c8efa16e..89a0b082fb 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -1,6 +1,8 @@
 #ifndef SCSI_UTILS_H
 #define SCSI_UTILS_H
 
+#include "block/block-common.h"
+#include "scsi/constants.h"
 #ifdef CONFIG_LINUX
 #include <scsi/sg.h>
 #endif
@@ -135,6 +137,12 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf);
 uint32_t scsi_cdb_xfer(uint8_t *buf);
 int scsi_cdb_length(uint8_t *buf);
 
+BlockPrType scsi_pr_type_to_block(SCSIPrType type);
+SCSIPrType block_pr_type_to_scsi(BlockPrType type);
+
+uint8_t scsi_pr_cap_to_block(uint16_t scsi_pr_cap);
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap);
+
 /* Linux SG_IO interface.  */
 #ifdef CONFIG_LINUX
 #define SG_ERR_DRIVER_TIMEOUT  0x06
diff --git a/scsi/utils.c b/scsi/utils.c
index 357b036671..0dfdeb499d 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -658,3 +658,84 @@ int scsi_sense_from_host_status(uint8_t host_status,
     }
     return GOOD;
 }
+
+BlockPrType scsi_pr_type_to_block(SCSIPrType type)
+{
+    switch (type) {
+    case SCSI_PR_WRITE_EXCLUSIVE:
+        return BLK_PR_WRITE_EXCLUSIVE;
+    case SCSI_PR_EXCLUSIVE_ACCESS:
+        return BLK_PR_EXCLUSIVE_ACCESS;
+    case SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return BLK_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+SCSIPrType block_pr_type_to_scsi(BlockPrType type)
+{
+    switch (type) {
+    case BLK_PR_WRITE_EXCLUSIVE:
+        return SCSI_PR_WRITE_EXCLUSIVE;
+    case BLK_PR_EXCLUSIVE_ACCESS:
+        return SCSI_PR_EXCLUSIVE_ACCESS;
+    case BLK_PR_WRITE_EXCLUSIVE_REGS_ONLY:
+        return SCSI_PR_WRITE_EXCLUSIVE_REGS_ONLY;
+    case BLK_PR_EXCLUSIVE_ACCESS_REGS_ONLY:
+        return SCSI_PR_EXCLUSIVE_ACCESS_REGS_ONLY;
+    case BLK_PR_WRITE_EXCLUSIVE_ALL_REGS:
+        return SCSI_PR_WRITE_EXCLUSIVE_ALL_REGS;
+    case BLK_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+        return SCSI_PR_EXCLUSIVE_ACCESS_ALL_REGS;
+    }
+
+    return 0;
+}
+
+
+uint8_t scsi_pr_cap_to_block(uint16_t scsi_pr_cap)
+{
+    uint8_t res = 0;
+
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX) ?
+           BLK_PR_CAP_WR_EX : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC) ?
+           BLK_PR_CAP_EX_AC : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX_RO) ?
+           BLK_PR_CAP_WR_EX_RO : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC_RO) ?
+           BLK_PR_CAP_EX_AC_RO : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_WR_EX_AR) ?
+           BLK_PR_CAP_WR_EX_AR : 0;
+    res |= (scsi_pr_cap & SCSI_PR_CAP_EX_AC_AR) ?
+           BLK_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
+
+uint16_t block_pr_cap_to_scsi(uint8_t block_pr_cap)
+{
+    uint16_t res = 0;
+
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX) ?
+              SCSI_PR_CAP_WR_EX : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC) ?
+              SCSI_PR_CAP_EX_AC : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_RO) ?
+              SCSI_PR_CAP_WR_EX_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_RO) ?
+              SCSI_PR_CAP_EX_AC_RO : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_WR_EX_AR) ?
+              SCSI_PR_CAP_WR_EX_AR : 0;
+    res |= (block_pr_cap & BLK_PR_CAP_EX_AC_AR) ?
+              SCSI_PR_CAP_EX_AC_AR : 0;
+
+    return res;
+}
-- 
2.20.1


